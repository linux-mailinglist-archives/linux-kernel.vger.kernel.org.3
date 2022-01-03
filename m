Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D20482DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiACE4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiACE4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:56:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E82C061761;
        Sun,  2 Jan 2022 20:56:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso17779609wmk.1;
        Sun, 02 Jan 2022 20:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS/IXV/uUkA4HFkL+doYrFhDD7IUbckhrneEYozEEDs=;
        b=mYRXzV34sIRJDSmnf3EfJKVbiJ0W4RYKdh/GDB8oySHUZWbmk5VEtEZpZHy/nvku85
         aiAoQTgHfwnbKxE/dxN/SkDsAWaX4r7Iq4+dS+GdecpENJ5zbDXu2EatOkyFn7nY56YP
         uVUFnvb5inPPotjynx2ll3PNmgCzRLdSRLaRuJxOPJuJCA7LCu3xxhQprzxI8n1xdOpr
         BmY+HSobAIxKlUNz2LpfPxWIdT2nISQD7NFtGI6s/P8UA/MUSKA6RDiiE/uJMJQbYifg
         GbRnME5fzmPD4QzmxOpeP1CPRYt7W9kUepaTjbHhlA2Eceyi2FIXCjo6cW+ejQ0ECweH
         YxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS/IXV/uUkA4HFkL+doYrFhDD7IUbckhrneEYozEEDs=;
        b=x/Hi7/W8RDi3agOLJh3Xrj4qJ7+smPNM9I+lQolgzH56xTVCbCmiYV7pTElZrgrZ1E
         XBIo51bFtN/GzqqJYDXNIa/CrZdzbiPtechWiEfMtnwb9Yrn7clEaJPOKjE7JpN/Y6Eu
         FmWLSfFIp0N755cYZT2ZNliw/WMKIifPg8jEpj+w04f3baSyFLwmJsGnQaK6Do8tFAj3
         8OYxUkXO5RFeJ+TUlO0qpH2DH8/qxHn5mEHtP5b1vmPsyu7cZj5iRyK4cfJExrz3Ir/x
         yEzZ0bIZy7t2kNA+19QIIRBSNgegOUyCR7dw433la4tV0rWfY9OC/YhtWxYJZ+fHcYHN
         Cr3Q==
X-Gm-Message-State: AOAM532bqgO435JPJINBElzF+Am5UOg9IVtNX/3b0lg8tueQ1ga9zzrW
        IFtk/nD0CzWmAvjo4veq65M=
X-Google-Smtp-Source: ABdhPJzBg0F0WGxf18SlKb9FOnM+vYhuMUPfg6nLlLCD9t5WuvGKJumw0FVSUEAPd4weBeIXQd4h0Q==
X-Received: by 2002:a05:600c:384c:: with SMTP id s12mr38024443wmr.108.1641185758648;
        Sun, 02 Jan 2022 20:55:58 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id d5sm34189032wms.28.2022.01.02.20.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:55:58 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v2 11/15] scripts: kernel-doc: Transform documentation into POD (11/15)
Date:   Mon,  3 Jan 2022 05:55:43 +0100
Message-Id: <20220103045547.506783-1-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 11) Remove the "format of comments" comment block

As suggested by Jani Nikula in a reply to my first version of this
transformation, Documentation/doc-guide/kernel-doc.rst can serve as the
information hub for comment formatting. The section DESCRIPTION already
points there, so the original comment block can just be removed.

See step 1 for the series details.

= Meta note =

I guess, I should use the Suggested-by tag for credits.
Maintainers, please correct this if I'm doing this wrong.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 115 ---------------------------------------------
 1 file changed, 115 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index bf0c5bb7b026..8069d1d29841 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -79,121 +79,6 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 # 25/07/2012 - Added support for HTML5
 # -- Dan Luedtke <mail@danrl.de>
 
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
-
 ## init lots of data
 
 my $errors = 0;
-- 
2.30.2

