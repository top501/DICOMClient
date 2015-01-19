@echo off

echo Run 64 bit version of java to accommodate large file sets.

echo java -version | cmd 2>&1 | find "1.6.0" >nul 2>nul
if %errorlevel% EQU 0 GOTO javaversionok
echo java -version | cmd 2>&1 | find "1.7.0" >nul 2>nul
if %errorlevel% EQU 0 GOTO javaversionok

:javaversionok

echo java -version | cmd 2>&1 | find "64-Bit" >nul 2>nul
if %errorlevel% EQU 0 GOTO javaok

echo You must have 64 bit java version 6 or 7 installed, shown as 1.6 or 1.7
echo to run this program.  The java.exe program must also be in a directory
echo referenced by your PATH environment variable.
echo.
echo To see your java version, enter the following command at the DOS prompt:
echo.
echo    java -version
echo.
GOTO javabad

:javaok

set dirname=%~dp0
echo Starting DICOM+

@rem Large Xmx values are only supported on 64 bit versions of java 
java -Xmx8192m -cp %dirname%@@with-dep-jar@@ -Djava.util.logging.config.file=%dirname%logging.propertiesWindows edu.umro.dicom.client.DicomClient %*

:javabad