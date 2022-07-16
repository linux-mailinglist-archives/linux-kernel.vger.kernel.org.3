Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1458576CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiGPJdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGPJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:33:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF4182;
        Sat, 16 Jul 2022 02:33:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so13722442pjn.0;
        Sat, 16 Jul 2022 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhq++96SwqP8iCLJj1mxjf4nsafc6aa4I9geuOUsTYc=;
        b=arQXmVNjfmYBDpNRP5PRNWJoI8kfTbc5ypG0ZQEZDHfwB8FX3FTfhpHVNwRCERCZdR
         kK7A7fU20oJR6WneJQb8VqwOa5cffhmvzxj+qfyb0+JLNVGJRZ0XsZmX1SKtv7L7V+n2
         vtdgpsw3g/PFkNb7W0d406eVRYjY2ouuxnzMsy6pI8+7vEU+56+jTMxoNr1FeNQqfpWP
         fKfyr35Oe78cXWxxXxXngBPY6eRotbwcLmElAhiA3mxvVgYX2d4bbPJw2JbYsUyQEYvJ
         s/iRQ7ilUZk1qwHgfsGrRrkcknx/yJrF7PLiiKA/57v1TeNeUOoM+bIrj2a8yJ/DovOW
         Sayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhq++96SwqP8iCLJj1mxjf4nsafc6aa4I9geuOUsTYc=;
        b=V36ucEBkKQcSuMJGAh+/OnnOBEEHjA5NSOVbxaoV5sWbMO8m+MWg4sxQZQraw5p6j/
         NwHjEsRRxrfw5Dcmt5tm81r2XHbdBSoGvE5gWi5GWzjuF5SSnJvUSOPkhS5EtoiPBZVv
         KMPRbcww8T2C6ufEEvoosXb42CgBSg3S9W3ahyVo/AVw9+BXDleYBVGfl7+X79yqrUXb
         zL8R5q2WTDpFr+8UXALvnmVw2ZcoPUMglMelWZE96P5VAC+T5VEixsSLmBj68P3ZCwtn
         4NzQ+/U4aatBvFKMOZkpJ+6AMrNXjjGDLbmnvrTa4/4PND9wKIoCsXGC9XJhyxocW8uh
         cYbg==
X-Gm-Message-State: AJIora/99K1BZl15jewVC/4U83aqdmeXFWSJmGgzUrFPwNKJOArWXCTr
        9vpvHCZamwJtq6hSS23HvJE=
X-Google-Smtp-Source: AGRyM1sCsMunfbPOuymvkXTYD/IzPE6crrGnwwbagMZeRKOYiRRbdJW7sSMgIpbhgwrbS+WipRyRqg==
X-Received: by 2002:a17:902:eec2:b0:16c:9837:cd4 with SMTP id h2-20020a170902eec200b0016c98370cd4mr15342704plb.132.1657964019824;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-23.three.co.id. [116.206.28.23])
        by smtp.gmail.com with ESMTPSA id 199-20020a6218d0000000b0052abc2438f1sm5352747pfy.55.2022.07.16.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 02:33:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 60BCD103840; Sat, 16 Jul 2022 16:33:33 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Liska <mliska@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kbuild@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/4] Documentation: lto: use bullet lists for external link references list
Date:   Sat, 16 Jul 2022 16:32:49 +0700
Message-Id: <20220716093249.19326-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220716093249.19326-1-bagasdotme@gmail.com>
References: <20220716093249.19326-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the FAQ, use bullet lists in References section since it
contains list of external reference links.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kbuild/lto-build.rst | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/kbuild/lto-build.rst b/Documentation/kbuild/lto-build.rst
index 9e3e14042dda4c..3fb17342e72fd6 100644
--- a/Documentation/kbuild/lto-build.rst
+++ b/Documentation/kbuild/lto-build.rst
@@ -56,17 +56,20 @@ FAQs:
 References:
 -----------
 
-Presentation on Kernel LTO
-(note, performance numbers/details totally outdated.)
-http://halobates.de/kernel-lto.pdf
+* Presentation on Kernel LTO
+  (note, performance numbers/details totally outdated.)
 
-Generic gcc LTO:
-http://www.ucw.cz/~hubicka/slides/labs2013.pdf
-http://www.hipeac.net/system/files/barcelona.pdf
+  http://halobates.de/kernel-lto.pdf
 
-Somewhat outdated too:
-http://gcc.gnu.org/projects/lto/lto.pdf
-http://gcc.gnu.org/projects/lto/whopr.pdf
+* Generic gcc LTO:
+
+  * http://www.ucw.cz/~hubicka/slides/labs2013.pdf
+  * http://www.hipeac.net/system/files/barcelona.pdf
+
+* Somewhat outdated too (from GCC site):
+
+  * http://gcc.gnu.org/projects/lto/lto.pdf
+  * http://gcc.gnu.org/projects/lto/whopr.pdf
 
 Happy Link-Time-Optimizing!
 
-- 
An old man doll... just what I always wanted! - Clara

