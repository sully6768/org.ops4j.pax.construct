@echo off
SETLOCAL
set _SCRIPTS_=%~dp0
call "%_SCRIPTS_%\pax-validate"

if ""=="%PAX_CONSTRUCT_VERSION%" set PAX_CONSTRUCT_VERSION=${project.version}
set PAX_PLUGIN=org.ops4j.pax.construct:maven-pax-plugin:%PAX_CONSTRUCT_VERSION%

set _BATFILE_=%0
set _GROUPID_=
set _ARTIFACTID_=
set _VERSION_=

goto getopts
:shift_2
shift
:shift_1
shift

:getopts
if "%1"=="-g" set _GROUPID_=%2
if "%1"=="-g" goto shift_2
if "%1"=="-a" set _ARTIFACTID_=%2
if "%1"=="-a" goto shift_2
if "%1"=="-v" set _VERSION_=%2
if "%1"=="-v" goto shift_2
if "%1"=="-h" goto help
if "%1"=="--" goto endopts
if "%1"=="" goto endopts

echo %_BATFILE_%: illegal option -- %1
:help
echo pax-import-bundle -g groupId -a artifactId -v version [-- mvnOpts ...]
goto done
:endopts

shift
shift

set _EXTRA_=%PAX_CONSTRUCT_OPTIONS% %0 %1 %2 %3 %4 %5 %6 %7 %8 %9

if ""=="%_GROUPID_%" set /p _GROUPID_="groupId (org.ops4j.example) ? "
if ""=="%_ARTIFACTID_%" set /p _ARTIFACTID_="artifactId (myBundle) ? "
if ""=="%_VERSION_%" set /p _VERSION_="version (0.1.0-SNAPSHOT) ? "

if ""=="%_GROUPID_%" set _GROUPID_=org.ops4j.example
if ""=="%_ARTIFACTID_%" set _ARTIFACTID_=myBundle
if ""=="%_VERSION_%" set _VERSION_=0.1.0-SNAPSHOT

@echo on
mvn %PAX_PLUGIN%:import-bundle -DgroupId=%_GROUPID_% -DartifactId=%_ARTIFACTID_% -Dversion=%_VERSION_% %_EXTRA_%
:done
