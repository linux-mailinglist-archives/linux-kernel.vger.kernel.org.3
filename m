Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE14E80D4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 13:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiCZMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 08:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiCZMfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 08:35:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8722980D;
        Sat, 26 Mar 2022 05:34:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so5766604pjb.0;
        Sat, 26 Mar 2022 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JX2HoafCqLBV8D/Av/3GafxcwR1VS5PL4ltoAzY1ZZc=;
        b=iJn02XuuXfCvrx5ULmVc2BnaJyESRKS08GEH+8zYCu0L+EhSG1ylZzTofQubEpkitA
         0aoghiugn5Is8+Rm7P9Lc1DsY3fMjQq/Hr5LANX3LDxNVJm+GFgNn1+mb8t8pY0y+SfD
         k7tsQT4dGionx0RoAI9TfFY0M1GAKmsq52eR2M03QtgaUAOb/N9en+8tF2ENJrTwL7+i
         GU1nNfFWErNSkH3aO8dr1/+R5jcCgzqqpBEKKarqQphNAHFGePGJV1BRmp/Cmb2/29r6
         sXoHhlW3QGbgiqd1GCS6mEqDgLMhkMBNMfVWkfVC1u5CksW0bPemJFNa6WzSmFKNJ/mV
         WS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JX2HoafCqLBV8D/Av/3GafxcwR1VS5PL4ltoAzY1ZZc=;
        b=y6Fyoy0LYrkuWdCB3UNgxLc8FtTEfd81SbBSxZzCkW6hCqJTntqxXeSoohK60IvIYs
         9wqY5ESX9luKBQ1xLglsFPSLGG1gxvSi2/VxwoZxNxgsuOb3E6Gtx+6oidyR9khUQ6XE
         XMd8vimfkSB6KSgSFlSNjdL/7xd2BkSR6GaAe8rkY52Uj+OK5YDuD6c76y7GikKkdd5L
         36hV54yUGps57Jf7znozthY7SZmBXdmY4+CsdO2hvQi35gp/nItE0MP/3usW5BhMPI/d
         i5ZFG4QbjFyI7O3oSEnd9HGYThjKvODMJXgAhDctIREjvqPc6wjgqdivLbPTK436zcyt
         Yjyw==
X-Gm-Message-State: AOAM530DEeJVGN9dxw2wy7XI/oKQYqLiE45f2IFsaz3E7A673jJZRfHR
        DU4gd+I2ASabMxkIdk+QNx0lok1MYiR2mrJD
X-Google-Smtp-Source: ABdhPJyjxL0mrFQx/wQf4pb0MaUt0NIe+E6Wo5AwkrdFrv5MtAAWGcTxSkDdxoz3ms4cXi32n465wg==
X-Received: by 2002:a17:902:a616:b0:154:abdd:50bb with SMTP id u22-20020a170902a61600b00154abdd50bbmr16362764plq.33.1648298043313;
        Sat, 26 Mar 2022 05:34:03 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-2.three.co.id. [116.206.28.2])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b001c7ea7f487asm4872920pjh.39.2022.03.26.05.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 05:34:02 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Documentation: kernel-doc: Promote "Writing kernel-doc comments" to page title
Date:   Sat, 26 Mar 2022 19:33:37 +0700
Message-Id: <20220326123337.642536-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326123337.642536-1-bagasdotme@gmail.com>
References: <20220326123337.642536-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Promote the first heading from chapter heading to page title. While at
it, fix heading inconsistencies by promoting the appropriate headings.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 29 +++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 79aaa55d6bcf2b..ea41e05d0e8903 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -1,3 +1,4 @@
+===========================
 Writing kernel-doc comments
 ===========================
 
@@ -31,7 +32,7 @@ kernel source code layout. This is lower priority and at the discretion
 of the maintainer of that kernel source file.
 
 How to format kernel-doc comments
----------------------------------
+=================================
 
 The opening comment mark ``/**`` is used for kernel-doc comments. The
 ``kernel-doc`` tool will extract comments marked this way. The rest of
@@ -56,7 +57,7 @@ requested to perform extra gcc checks::
 	make W=n
 
 Function documentation
-----------------------
+======================
 
 The general format of a function and function-like macro kernel-doc comment is::
 
@@ -88,7 +89,7 @@ ends with an argument description, a blank comment line, or the end of the
 comment block.
 
 Function parameters
-~~~~~~~~~~~~~~~~~~~
+-------------------
 
 Each function argument should be described in order, immediately following
 the short function description.  Do not leave a blank line between the
@@ -116,7 +117,7 @@ be written in kernel-doc notation as::
       * @...: description
 
 Function context
-~~~~~~~~~~~~~~~~
+----------------
 
 The context in which a function can be called should be described in a
 section named ``Context``. This should include whether the function
@@ -134,7 +135,7 @@ Examples::
   * Context: Interrupt context.
 
 Return values
-~~~~~~~~~~~~~
+-------------
 
 The return value, if any, should be described in a dedicated section
 named ``Return``.
@@ -166,7 +167,7 @@ named ``Return``.
      effect.
 
 Structure, union, and enumeration documentation
------------------------------------------------
+===============================================
 
 The general format of a struct, union, and enum kernel-doc comment is::
 
@@ -189,7 +190,7 @@ lines, and ends with a member description, a blank comment line, or the
 end of the comment block.
 
 Members
-~~~~~~~
+-------
 
 Members of structs, unions and enums should be documented the same way
 as function parameters; they immediately succeed the short description
@@ -223,7 +224,7 @@ Example::
   };
 
 Nested structs/unions
-~~~~~~~~~~~~~~~~~~~~~
+---------------------
 
 It is possible to document nested structs and unions, like::
 
@@ -274,7 +275,7 @@ It is possible to document nested structs and unions, like::
       should be documented as ``@bar:``
 
 In-line member documentation comments
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+-------------------------------------
 
 The structure members may also be documented in-line within the definition.
 There are two styles, single-line comments where both the opening ``/**`` and
@@ -311,7 +312,7 @@ on a line of their own, like all other kernel-doc comments::
   };
 
 Typedef documentation
----------------------
+=====================
 
 The general format of a typedef kernel-doc comment is::
 
@@ -336,7 +337,7 @@ Typedefs with function prototypes can also be documented::
    typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
 
 Highlights and cross-references
--------------------------------
+===============================
 
 The following special patterns are recognized in the kernel-doc comment
 descriptive text and converted to proper reStructuredText markup and `Sphinx C
@@ -385,7 +386,7 @@ Domain`_ references.
   instead. This is mostly for legacy comments.
 
 Cross-referencing from reStructuredText
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+=======================================
 
 No additional syntax is needed to cross-reference the functions and types
 defined in the kernel-doc comments from reStructuredText documents.
@@ -408,7 +409,7 @@ through the following syntax::
 For further details, please refer to the `Sphinx C Domain`_ documentation.
 
 Overview documentation comments
--------------------------------
+===============================
 
 To facilitate having source code and comments close together, you can include
 kernel-doc documentation blocks that are free-form comments instead of being
@@ -524,7 +525,7 @@ source.
 .. _kernel_doc:
 
 How to use kernel-doc to generate man pages
--------------------------------------------
+===========================================
 
 If you just want to use kernel-doc to generate man pages you can do this
 from the kernel git tree::
-- 
An old man doll... just what I always wanted! - Clara

