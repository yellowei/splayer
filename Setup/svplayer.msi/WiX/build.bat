del /F /S /Q bin


set revfile=".\SvPlayerver.wxi"


for /f "delims=+ " %%a in ('hg id -n ../../../') do @set revnum=%%a 

set revnum=%revnum:~0,-1%

echo ^<^?xml version="1.0" encoding="utf-8"^?^>  > %revfile%
echo ^<!-- generated by build system --^>   >> %revfile%
echo ^<Include^>   >> %revfile%
echo   ^<?define SvPlayerMajorMinor = "3.7" ?^>  >> %revfile%
echo   ^<?define SvPlayerBuildNum = "%revnum%" ?^>   >> %revfile%
echo   ^<?define SvPlayerVersion = "$(var.SvPlayerMajorMinor).$(var.SvPlayerBuildNum)" ?^> >> %revfile%
echo ^</Include^>   >> %revfile%
 


msbuild svplayer.wixproj /property:Configuration=Release /l:FileLogger,Microsoft.Build.Engine;logfile=svplayer.log;verbosity=detailed /t:Clean,Build 
msbuild svplayer.wixproj /property:Configuration=ReleaseCHT /l:FileLogger,Microsoft.Build.Engine;logfile=svplayer.cht.log;verbosity=detailed /t:Clean,Build 
msbuild svplayer.wixproj /property:Configuration=ReleaseCHS /l:FileLogger,Microsoft.Build.Engine;logfile=svplayer.ch.log;verbosity=detailed /t:Clean,Build 
msbuild svplayer.wixproj /property:Configuration=ReleaseRU /l:FileLogger,Microsoft.Build.Engine;logfile=svplayer.ru.log;verbosity=detailed /t:Clean,Build 
