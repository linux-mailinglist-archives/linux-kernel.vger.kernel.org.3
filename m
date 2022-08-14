Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B856B591D45
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbiHNAZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiHNAZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:25:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CB3B1D5;
        Sat, 13 Aug 2022 17:25:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c28so1963667lfh.3;
        Sat, 13 Aug 2022 17:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=CzO+KXa/fToaqU4lKH2uZ183XsoZP7LC2vMWPpsOYnE=;
        b=ADZpL1vgzVcOSjBsNex0YIK9in0yTGj0y1DYVwI9dfAub4362ctHOIE7xQWdBBu/lX
         xF8PAoQf4Ap3xJmbVHd9WVB/hlkOKihISEeqbobLUh+Jd/X/X1dBQMjO0kOr6LU5k8Z3
         fthuilsCFb14LtOMcWm/hun2YC1lErLp+34AMsR3L7y0BVWiR0xNkl/OHzV7qedDU8nj
         ixJQTVgMTvrq5zB3YCIV2qPh+wLZeJTFAJd9X2Ku/z+SSqSD++GUY4yc8Xj43IclLLl2
         owHmC22GcSjpwMNStIBdNnaKgjw0vyKgfIDgjhpBvaXqxcWBVX8tKEdyJI9TfrHJYhnP
         LWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CzO+KXa/fToaqU4lKH2uZ183XsoZP7LC2vMWPpsOYnE=;
        b=onADD806qGAOkNkzam06+IpehKathO9KkyFT/YtGRi3TF/qx9f4pHHfbeAuGCinX8S
         9GkNkgG6Ni2dcZe/HNxAdr7WsfvTadg3ivg8uFsAdyukHNhCYKQ+H7GhP/fqcL3zMsuK
         XkFonY7MS0mfwMd2USHYqq2DHiKryMMjDOq3f9ROnljiVxV7DZkBFirDCjXVSb2NyKcs
         wqq48EBa/uyAEBHfx7/ArGIy4+/Gcv2VHYTsJejtkfHn3Vcz9ZWapllY4rVGf1DE+UNd
         RJMiDerQdsu1aI5mrBd1O4d4WoFcoBw71UGGFPNU8+7cbnvR4/3p3NWkE7jmJ2DYo2Rq
         hfJg==
X-Gm-Message-State: ACgBeo0VEk5XE72rVf2Y5fvHkS+SxDmXbZhegBKyW6/NzydnrVaSxvbR
        v1FPTQfF/lvKydBi5MuwcRU=
X-Google-Smtp-Source: AA6agR71WBaaLyqxIwPYq5N4Uji8e3DRi1//H4CXjCPgOjwJbhsfWYd8EdwxLCFv24CXdMlvcnLEdA==
X-Received: by 2002:a05:6512:36ca:b0:48b:2896:bb8c with SMTP id e10-20020a05651236ca00b0048b2896bb8cmr3669594lfs.638.1660436724736;
        Sat, 13 Aug 2022 17:25:24 -0700 (PDT)
Received: from localhost.localdomain (37-145-44-55.broadband.corbina.ru. [37.145.44.55])
        by smtp.gmail.com with ESMTPSA id a5-20020a2ebe85000000b0025e49aaae10sm882917ljr.12.2022.08.13.17.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 17:25:24 -0700 (PDT)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     masahiroy@kernel.org, akpm@linux-foundation.org
Cc:     michal.lkml@markovi.net, ndesaulniers@google.com,
        nathan@kernel.org, peterz@infradead.org, keescook@chromium.org,
        jpoimboe@kernel.org, dan.j.williams@intel.com,
        isabbasso@riseup.net, edumazet@google.com, vbabka@suse.cz,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Subject: [PATCH v2] kbuild: add configurable debug info level
Date:   Sun, 14 Aug 2022 03:20:21 +0300
Message-Id: <20220814002021.16990-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides a way to configure debug info level (-glevel).
Debug level 3 includes extra information such as macro definitions. With
level 3 enabled it's possible to expand macros right from the debugging
session in gdb simplifying debugging when complicated macros involved.
The default level is set to 2 to not change the default build behavior.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---

Changes in v2: https://lore.kernel.org/all/20220804223504.4739-1-dmitrii.bundin.a@gmail.com/
  - Replace hardcoded -g3 with a configurable debug info level

 lib/Kconfig.debug      | 11 +++++++++++
 scripts/Makefile.debug |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e24db4bff19..a17c12c20290 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -304,6 +304,17 @@ config DEBUG_INFO_REDUCED
 	  DEBUG_INFO build and compile times are reduced too.
 	  Only works with newer gcc versions.
 
+config DEBUG_INFO_LEVEL
+	int "Debug info level"
+	range 0 3
+	default "2"
+	help
+	  Sets the level of how much debug information to generate (-glevel).
+	  Level 1 produces minimal debug information without including information
+	  about local variables. Level 3 includes extra information like macro
+	  definitions. Setting up level 3 will require significantly more disk
+	  space and increase built time. Level 0 produces no debug information.
+
 config DEBUG_INFO_COMPRESSED
 	bool "Compressed debugging information"
 	depends on $(cc-option,-gz=zlib)
diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 9f39b0130551..28beffc42e71 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -3,7 +3,7 @@ DEBUG_CFLAGS	:=
 ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS	+= -gsplit-dwarf
 else
-DEBUG_CFLAGS	+= -g
+DEBUG_CFLAGS	+= -g$(CONFIG_DEBUG_INFO_LEVEL)
 endif
 
 ifndef CONFIG_AS_IS_LLVM
-- 
2.17.1

