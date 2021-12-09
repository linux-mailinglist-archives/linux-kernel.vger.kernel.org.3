Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9046B46F71B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhLIXA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLIXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:00:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17EAC061746;
        Thu,  9 Dec 2021 14:57:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so24275585edc.6;
        Thu, 09 Dec 2021 14:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XLhdkvwvC3V5jewWflNe7vPBmREYXroCL+F/fJ4fs/A=;
        b=IC/lIlTn0mFxl1UtsVHoI7DLrv4vj6GQcO0eHn8D5bdIejoBp5FZAqeZrPoo1aQWiT
         8l3kAsX5hTcowQf3hmHbmXfWq5S/NMfuH6TQreMdMA9dG2biFNGOCnNYHnpfXU9wNC+t
         eI2iqVR62mFbpomQOjgU+T48kWyr/AxgC5vAivhDvpvth2cH3InCHyG1epV9Aek4e8uk
         ymAWpm1IDQQJFis05DFCqcHhu/A/LVAFoGOaHrBoCRzT5G4nHrGUINod6Mg0s9rDdcem
         j3MYp+mm0NLbsa1DtVx3pv9uIJ8ofRmzgZ0lPjLmnz5WQjCKjkNuNldG35yc7qvKErwb
         KShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XLhdkvwvC3V5jewWflNe7vPBmREYXroCL+F/fJ4fs/A=;
        b=Nv/KtAB10Qu9G2WzHhwb9orH35ux36EU9ikYY21isowyHBfdi3+X110TBd0XXpFl3F
         O+036XBYIbcOlyj+RMiLwij5gcr7R4c7QWUCCOIGjWar6SdIFQM++cJJuj0q78dLUxOy
         D8xtdQqLRI2O/sh81n5OnAArQnXE/pFkIeLxCpeaQ85jbyFMEBfype4WW5SNTrtBLz2z
         6PScNqdUGggUfbaXioUhRKWRtdcn8qPdYFm/ST25ZlnLsDqSxh8SB/AlKukOoy1xo1jC
         mB5k9ADMSPtr/+p3HpHO7laCltHPJBdshQZSb1ARkmbZuEGdEe+Dj8t7hMDsO45wW8PW
         bMTw==
X-Gm-Message-State: AOAM532F4cMPELpg8ZQI+j+NrCHwzS3pdwq7RYm+MXqH0owD5naezX4+
        VZAOnTq4A8d4OZY3S2IAHXM=
X-Google-Smtp-Source: ABdhPJzKJtgwkE8V2vIe9BJUF2UPVorb8K2/TPGgVRPTlO/rMP3Vb6+jtdveQkUUULpeGPbi4FZKIA==
X-Received: by 2002:a17:907:94c2:: with SMTP id dn2mr19215035ejc.325.1639090641783;
        Thu, 09 Dec 2021 14:57:21 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id a68sm492527edf.41.2021.12.09.14.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 14:57:21 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: transform documentation into POD
Date:   Thu,  9 Dec 2021 23:55:48 +0100
Message-Id: <20211209225549.69010-1-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only change in the script execution flow is the replacement
of the 'usage' function with the native core Perl 'pod2usage'.

This entails:
- an overall documentation restructuring
- addition of a synopsis

Otherwise my intervention is minimal:
- a few tiny language, formatting and spacing corrections
- a few missing bits added in the command syntax description
- adding subsections in the "FORMAT OF COMMENTS" section
- alphabetical sorting within OPTIONS subections

Finally, the TODO stub evolves into a section:
- perldoc request removed
- undocumented options added

Run `kernel-doc -h` to see the full doc.

The TODO suggestion is ancient, thus I can't address its author with
a "Suggested-by" tag.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 613 ++++++++++++++++++++++++++++++---------------
 1 file changed, 413 insertions(+), 200 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 3106b7536b89..00c0c7f5ff58 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -4,46 +4,33 @@
 use warnings;
 use strict;
 
-## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
-## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
-## Copyright (C) 2001  Simon Huggins                             ##
-## Copyright (C) 2005-2012  Randy Dunlap                         ##
-## Copyright (C) 2012  Dan Luedtke                               ##
-## 								 ##
-## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
-## Copyright (c) 2000 MontaVista Software, Inc.			 ##
-## 								 ##
-## This software falls under the GNU General Public License.     ##
-## Please read the COPYING file for more information             ##
-
-# 18/01/2001 - 	Cleanups
-# 		Functions prototyped as foo(void) same as foo()
-# 		Stop eval'ing where we don't need to.
-# -- huggie@earth.li
-
-# 27/06/2001 -  Allowed whitespace after initial "/**" and
-#               allowed comments before function declarations.
-# -- Christian Kreibich <ck@whoop.org>
-
-# Still to do:
-# 	- add perldoc documentation
-# 	- Look more closely at some of the scarier bits :)
-
-# 26/05/2001 - 	Support for separate source and object trees.
-#		Return error code.
-# 		Keith Owens <kaos@ocs.com.au>
-
-# 23/09/2001 - Added support for typedefs, structs, enums and unions
-#              Support for Context section; can be terminated using empty line
-#              Small fixes (like spaces vs. \s in regex)
-# -- Tim Jansen <tim@tjansen.de>
-
-# 25/07/2012 - Added support for HTML5
-# -- Dan Luedtke <mail@danrl.de>
-
-sub usage {
-    my $message = <<"EOF";
-Usage: $0 [OPTION ...] FILE ...
+use Pod::Usage qw/pod2usage/;
+
+=head1 NAME
+
+kernel-doc - Print formatted kernel documentation to stdout.
+
+=head1 SYNOPSIS
+
+ kernel-doc [-h] [-v] [-Werror]
+   [-man|-none|-rst]
+   [-sphinx-version VERSION]
+   [
+     -export |
+     [-function NAME] ... |
+     -internal |
+     [-nosymbol NAME] ...
+   ]
+   [-enable-lineno]
+   [-export-file FILE] ...
+   [-no-doc-sections]
+   FILE ...
+
+Run `kernel-doc -h` for details.
+
+=cut
+
+=head1 DESCRIPTION
 
 Read C language source or header FILEs, extract embedded documentation comments,
 and print formatted documentation to standard output.
@@ -51,163 +38,9 @@ and print formatted documentation to standard output.
 The documentation comments are identified by "/**" opening comment mark. See
 Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 
-Output format selection (mutually exclusive):
-  -man			Output troff manual page format. This is the default.
-  -rst			Output reStructuredText format.
-  -none			Do not output documentation, only warnings.
-
-Output format selection modifier (affects only ReST output):
-
-  -sphinx-version	Use the ReST C domain dialect compatible with an
-			specific Sphinx Version.
-			If not specified, kernel-doc will auto-detect using
-			the sphinx-build version found on PATH.
-
-Output selection (mutually exclusive):
-  -export		Only output documentation for symbols that have been
-			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
-                        in any input FILE or -export-file FILE.
-  -internal		Only output documentation for symbols that have NOT been
-			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
-                        in any input FILE or -export-file FILE.
-  -function NAME	Only output documentation for the given function(s)
-			or DOC: section title(s). All other functions and DOC:
-			sections are ignored. May be specified multiple times.
-  -nosymbol NAME	Exclude the specified symbols from the output
-		        documentation. May be specified multiple times.
-
-Output selection modifiers:
-  -no-doc-sections	Do not output DOC: sections.
-  -enable-lineno        Enable output of #define LINENO lines. Only works with
-                        reStructuredText format.
-  -export-file FILE     Specify an additional FILE in which to look for
-                        EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(). To be used with
-                        -export or -internal. May be specified multiple times.
-
-Other parameters:
-  -v			Verbose output, more warnings and other information.
-  -h			Print this help.
-  -Werror		Treat warnings as errors.
-
-EOF
-    print $message;
-    exit 1;
-}
+=cut
 
-#
-# format of comments.
-# In the following table, (...)? signifies optional structure.
-#                         (...)* signifies 0 or more structure elements
-# /**
-#  * function_name(:)? (- short description)?
-# (* @parameterx: (description of parameter x)?)*
-# (* a blank line)?
-#  * (Description:)? (Description of function)?
-#  * (section header: (section description)? )*
-#  (*)?*/
-#
-# So .. the trivial example would be:
-#
-# /**
-#  * my_function
-#  */
-#
-# If the Description: header tag is omitted, then there must be a blank line
-# after the last parameter specification.
-# e.g.
-# /**
-#  * my_function - does my stuff
-#  * @my_arg: its mine damnit
-#  *
-#  * Does my stuff explained.
-#  */
-#
-#  or, could also use:
-# /**
-#  * my_function - does my stuff
-#  * @my_arg: its mine damnit
-#  * Description: Does my stuff explained.
-#  */
-# etc.
-#
-# Besides functions you can also write documentation for structs, unions,
-# enums and typedefs. Instead of the function name you must write the name
-# of the declaration;  the struct/union/enum/typedef must always precede
-# the name. Nesting of declarations is not supported.
-# Use the argument mechanism to document members or constants.
-# e.g.
-# /**
-#  * struct my_struct - short description
-#  * @a: first member
-#  * @b: second member
-#  *
-#  * Longer description
-#  */
-# struct my_struct {
-#     int a;
-#     int b;
-# /* private: */
-#     int c;
-# };
-#
-# All descriptions can be multiline, except the short function description.
-#
-# For really longs structs, you can also describe arguments inside the
-# body of the struct.
-# eg.
-# /**
-#  * struct my_struct - short description
-#  * @a: first member
-#  * @b: second member
-#  *
-#  * Longer description
-#  */
-# struct my_struct {
-#     int a;
-#     int b;
-#     /**
-#      * @c: This is longer description of C
-#      *
-#      * You can use paragraphs to describe arguments
-#      * using this method.
-#      */
-#     int c;
-# };
-#
-# This should be use only for struct/enum members.
-#
-# You can also add additional sections. When documenting kernel functions you
-# should document the "Context:" of the function, e.g. whether the functions
-# can be called form interrupts. Unlike other sections you can end it with an
-# empty line.
-# A non-void function should have a "Return:" section describing the return
-# value(s).
-# Example-sections should contain the string EXAMPLE so that they are marked
-# appropriately in DocBook.
-#
-# Example:
-# /**
-#  * user_function - function that can only be called in user context
-#  * @a: some argument
-#  * Context: !in_interrupt()
-#  *
-#  * Some description
-#  * Example:
-#  *    user_function(22);
-#  */
-# ...
-#
-#
-# All descriptive text is further processed, scanning for the following special
-# patterns, which are highlighted appropriately.
-#
-# 'funcname()' - function
-# '$ENVVAR' - environmental variable
-# '&struct_name' - name of a structure (up to two words including 'struct')
-# '&struct_name.member' - name of a structure member
-# '@parameter' - name of a parameter
-# '%CONST' - name of a constant.
-# '``LITERAL``' - literal string without any spaces on it.
+# more perldoc at the end of the file
 
 ## init lots of data
 
@@ -273,7 +106,12 @@ my $blankline_rst = "\n";
 
 # read arguments
 if ($#ARGV == -1) {
-    usage();
+	pod2usage(
+		-message => "No arguments!\n",
+		-exitval => 1,
+		-verbose => 99,
+		-sections => 'SYNOPSIS'
+	);
 }
 
 my $kernelversion;
@@ -468,7 +306,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
     } elsif ($cmd eq "Werror") {
 	$Werror = 1;
     } elsif (($cmd eq "h") || ($cmd eq "help")) {
-	usage();
+			pod2usage(-exitval => 0, -verbose => 2);
     } elsif ($cmd eq 'no-doc-sections') {
 	    $no_doc_sections = 1;
     } elsif ($cmd eq 'enable-lineno') {
@@ -493,8 +331,13 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	    die "Sphinx version should either major.minor or major.minor.patch format\n";
 	}
     } else {
-	# Unknown argument
-        usage();
+			# Unknown argument
+			pod2usage(
+				-message => "Argument unknown!\n",
+				-exitval => 1,
+				-verbose => 99,
+				-sections => 'SYNOPSIS'
+			);
     }
 }
 
@@ -2521,3 +2364,373 @@ if ($Werror && $warnings) {
 } else {
     exit($output_mode eq "none" ? 0 : $errors)
 }
+
+__END__
+
+=head1 OPTIONS
+
+=head2 Output format selection (mutually exclusive):
+
+=over 8
+
+=item -man
+
+Output troff manual page format. This is the default.
+
+=item -none
+
+Do not output documentation, only warnings.
+
+=item -rst
+
+Output reStructuredText format.
+
+=back
+
+=head2 Output format selection modifier (affects only ReST output):
+
+=over 8
+
+=item -sphinx-version VERSION
+
+Use the ReST C domain dialect compatible with a specific Sphinx Version.
+
+If not specified, kernel-doc will auto-detect using the sphinx-build version
+found on PATH.
+
+=back
+
+=head2 Output selection (mutually exclusive):
+
+=over 8
+
+=item -export
+
+Only output documentation for symbols that have been exported using
+EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+
+=item -function NAME
+
+Only output documentation for the given function(s) or DOC: section title(s).
+All other functions and DOC: sections are ignored.
+
+May be specified multiple times.
+
+=item -internal
+
+Only output documentation for symbols that have NOT been exported using
+EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+
+=item -nosymbol NAME
+
+Exclude the specified symbols from the output documentation.
+
+May be specified multiple times.
+
+=back
+
+=head2 Output selection modifiers:
+
+=over 8
+
+=item -enable-lineno
+
+Enable output of #define LINENO lines. Only works with reStructuredText format.
+
+=item -export-file FILE
+
+Specify an additional FILE in which to look for EXPORT_SYMBOL() and
+EXPORT_SYMBOL_GPL(). To be used with -export or -internal.
+
+May be specified multiple times.
+
+=item -no-doc-sections
+
+Do not output DOC: sections.
+
+=back
+
+=head2 Other parameters:
+
+=over 8
+
+=item -h, -help
+
+Print this help.
+
+=item -v
+
+Verbose output, more warnings and other information.
+
+=item -Werror
+
+Treat warnings as errors.
+
+=back
+
+=cut
+
+=head1 FORMAT OF COMMENTS
+
+=head2 Functions
+
+=over 8
+
+=item In the following table,
+
+=over 8
+
+=item (...)?
+
+signifies optional structure,
+
+=item	(...)*
+
+signifies 0 or more structure elements.
+
+=back
+
+=back
+
+ /**
+  * function_name(:)? (- short description)?
+ (* @parameterx: (description of parameter x)?)*
+ (* a blank line)?
+  * (Description:)? (Description of function)?
+  * (section header: (section description)? )*
+ (*)?*/
+
+So the trivial example would be:
+
+ /**
+  * my_function
+  */
+
+If the "Description:" header tag is omitted, then there must be a blank line
+after the last parameter specification.
+
+e.g.
+
+ /**
+  * my_function - does my stuff
+  * @my_arg: its mine damnit
+  *
+  * Does my stuff explained.
+  */
+
+or, could also use:
+
+ /**
+  * my_function - does my stuff
+  * @my_arg: its mine damnit
+  * Description: Does my stuff explained.
+  */
+
+etc.
+
+=head2 Structs, unions, enums and typedefs
+
+Besides functions you can also write documentation for structs, unions,
+enums and typedefs.
+
+Instead of the function name you must write the name of the declaration;
+the struct/union/enum/typedef must always precede the name.
+
+Nesting of declarations is not supported.
+
+Use the argument mechanism to document members or constants.
+
+e.g.
+
+ /**
+  * struct my_struct - short description
+  * @a: first member
+  * @b: second member
+  *
+  * Longer description
+  */
+ struct my_struct {
+     int a;
+     int b;
+ /* private: */
+     int c;
+ };
+
+All descriptions can be multiline, except the short function description.
+
+For really longs structs, you can also describe arguments inside the
+body of the struct.
+
+e.g.
+
+ /**
+  * struct my_struct - short description
+  * @a: first member
+  * @b: second member
+  *
+  * Longer description
+  */
+ struct my_struct {
+     int a;
+     int b;
+     /**
+      * @c: This is longer description of C
+      *
+      * You can use paragraphs to describe arguments
+      * using this method.
+      */
+     int c;
+ };
+
+This should be used only for struct/enum members.
+
+=head2 Additional sections
+
+You can also add additional sections.
+
+When documenting kernel functions, you should document the "Context:" of
+the function, e.g. whether the functions can be called from interrupts.
+Unlike other sections you can end it with an empty line.
+
+A non-void function should have a "Return:" section describing the return
+value(s).
+
+Example-sections should contain the string EXAMPLE, so that they are marked
+appropriately in DocBook.
+
+Example:
+
+ /**
+  * user_function - function that can only be called in user context
+  * @a: some argument
+  * Context: !in_interrupt()
+  *
+  * Some description
+  * Example:
+  *    user_function(22);
+  */
+ ...
+
+All descriptive text is further processed, scanning for the following special
+patterns, which are highlighted appropriately.
+
+=over 8
+
+=item 'funcname()'
+
+function
+
+=item '$ENVVAR'
+
+environmental variable
+
+=item '&struct_name'
+
+name of a structure (up to two words including 'struct')
+
+=item '&struct_name.member'
+
+name of a structure member
+
+=item '@parameter'
+
+name of a parameter
+
+=item '%CONST'
+
+name of a constant
+
+=item '``LITERAL``'
+
+literal string without any spaces on it
+
+=back
+
+=cut
+
+=head1 TODO
+
+=head2 General
+
+=over 2
+
+=item -
+
+Look more closely at some of the scarier bits :)
+
+=back
+
+=head2 Options
+
+=over 2
+
+=item -
+
+Document: -module NAME, -show-not-found
+
+=back
+
+=head1 LICENSE
+
+This software falls under the GNU General Public License.
+
+Please read the COPYING file for more information.
+
+=head1 COPYRIGHT
+
+=over 2
+
+=item *
+
+Copyright (C) 1998 Michael Zucchi, All Rights Reserved
+
+=item *
+
+Copyright (C) 2000, 1 Tim Waugh <twaugh@redhat.com>
+
+=item *
+
+Copyright (C) 2001 Simon Huggins
+
+=item *
+
+Copyright (C) 2005-2012 Randy Dunlap
+
+=item *
+
+Copyright (C) 2012 Dan Luedtke
+
+=item *
+
+Copyright (C) 2000 MontaVista Software, Inc.
+
+#define enhancements by Armin Kuster <akuster@mvista.com>
+
+=back
+
+=head1 SOME PRE-GIT CONTRIBUTIONS
+
+Original formatting preserved for its historical value.
+
+ # 18/01/2001 - 	Cleanups
+ # 		Functions prototyped as foo(void) same as foo()
+ # 		Stop eval'ing where we don't need to.
+ # -- huggie@earth.li
+
+ # 27/06/2001 -  Allowed whitespace after initial "/**" and
+ #               allowed comments before function declarations.
+ # -- Christian Kreibich <ck@whoop.org>
+
+ # 26/05/2001 - 	Support for separate source and object trees.
+ #		Return error code.
+ # 		Keith Owens <kaos@ocs.com.au>
+
+ # 23/09/2001 - Added support for typedefs, structs, enums and unions
+ #              Support for Context section; can be terminated using empty line
+ #              Small fixes (like spaces vs. \s in regex)
+ # -- Tim Jansen <tim@tjansen.de>
+
+ # 25/07/2012 - Added support for HTML5
+ # -- Dan Luedtke <mail@danrl.de>
+
+=cut
-- 
2.30.2

