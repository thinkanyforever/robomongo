macro(VersionConf prjName from_file to_file iconname)
SET(COMPANYNAME "\"${PROJECT_COMPANYNAME}\"")
SET(filecontent "
    SET(ICON_FILE ${ICON_FILE})
	SET(MAJOR_VER	${MAJOR} ) 	
	SET(MINOR_VER1	${MINOR})
	SET(MINOR_VER2	${PATCH})
	SET(PRODUCTNAME ${prjName})
	SET(COMPANYNAME ${COMPANYNAME})
	SET(PRODUCTDOMAIN ${PROJECT_DOMAIN})
    SET(SHORTPRODUCTNAME ${prjName})
    SET(ICONNAME ${iconname})
    SET(PRODUCTCOPYRIGHT ${PROJECT_COPYRIGHT})
	CONFIGURE_FILE(${from_file} ${to_file})   
    ")

FILE(WRITE "${CMAKE_CURRENT_BINARY_DIR}/versionConfFile.cmake" "${filecontent}")

ADD_CUSTOM_TARGET(VersionConf
    ALL
    DEPENDS ${to_file})

ADD_CUSTOM_COMMAND(
    OUTPUT ${to_file}
    COMMAND ${CMAKE_COMMAND} -DSOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -P ${CMAKE_CURRENT_BINARY_DIR}/versionConfFile.cmake)

SET_SOURCE_FILES_PROPERTIES(${to_file} PROPERTIES GENERATED TRUE 
    #HEADER_FILE_ONLY TRUE
    )
ADD_DEPENDENCIES(${prjName} VersionConf)
endmacro(VersionConf)

###
# Prints all CMake variables.
# Usefull only for debug needs.
#
macro(print_all_vars)
    get_cmake_property(NAMES VARIABLES)
    foreach (NAME ${NAMES})
        message(STATUS "${NAME}=${${NAME}}")
    endforeach()
endmacro()