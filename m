Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB705A85FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiHaSof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiHaSo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:44:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0625F8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dc888dc62so210024627b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=jeIDU7bkvi8qrUeCQKjSgf4R1NQDEDk5WzvSWsZHRgY=;
        b=hx1WadVFGfM2WHW+QMiqbRpB+tGtox/ZvfK2iSj6s7TWGpw2+YfDNLd71aeLJikF5A
         ut7591nG+1XtZZnWDLGHqvw7JJwxJ0XUqThW+DOuVmXx5U3HEA3SXJbmTWIaXpZ2woGZ
         RTEaI3LgVK8uilz+J1vZWsPlPY0651QNaHnpsTlpgvFMVxMQjssruP9r+aB90KHTVpR/
         SrpgK6Xxyza7FDY2erOi2mdc5Qq7aDYAg+yKZnkJsavJ/Dfs+V/FjohIVlEbMIrrrnc8
         VTZr1169mV2GmgrWFZhOXY+DTyvlyMMDWkpUhba503fcTfGVw+anr6JRNo1wjKRsiWNd
         VysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jeIDU7bkvi8qrUeCQKjSgf4R1NQDEDk5WzvSWsZHRgY=;
        b=6gbSFYKVNUu7jzJFgDJh7G7kPgiy6mE+h5y7VHOeYOdMpWtByTc22T56X5krIrZsuv
         pK+e91JAYWPJx6l50+er+wQ9biXuAQBbgw1z7CyvAajvye7YLOjONOZ0sz3WTEvqwtju
         NU+e+9aFyApzqKTMDZml/T2r/PfPQ0MUWusVH397yOuZx2MjFS6sXghPINiH84omNJZY
         Cz49P/AfMAR2XRklAtu/O4iYfRMQi/bQVmdyZeVg+i0ZLmE8ikJ+F/DvMM4wSBqsaljD
         +1XyruXZSjr3igK/MFnIOUzEp6/2X1pVs76On5bCNAyzGz2a+462l1iUhA2yeuyE4e6J
         8D0w==
X-Gm-Message-State: ACgBeo1TeQNQN2PQysIOWRF8zvITAH6xPNB68bZRTsJiLZXB/v781HEt
        5BB/YvRTlVZHFhNUO+Ph0Cl5PHjgAvfjfYaSvBs=
X-Google-Smtp-Source: AA6agR7Ag1fKKG3WlrfE60Hng53gw5R2d8mq+Pf+nJEkCn34r/4b9t9bbknLWL4Dz5mBS6VyDJJaVwKf1/TD3gZm/D4=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:5f5d:95d5:9a3:d41])
 (user=ndesaulniers job=sendgmr) by 2002:a25:7608:0:b0:694:220b:8bf6 with SMTP
 id r8-20020a257608000000b00694220b8bf6mr16732077ybc.210.1661971460048; Wed,
 31 Aug 2022 11:44:20 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:44:06 -0700
In-Reply-To: <20220831184408.2778264-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220831184408.2778264-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661971448; l=6313;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=4nrhFDfzIr6P2uEi5X9UGCfe5n7Png+PEC4jrJ9T2hY=;
 b=Asevhm76deGOJCh2wzvhWYmHcNqfB9w30KRQRslJFMSwOMNo1qdlvq1fib/n0CQt0uFs4EHOV7W4
 zd9FYCZZAcwt9VhTRml2m/KTX3mSvtSLn8veXUGEL29ZkuqxycP8
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831184408.2778264-4-ndesaulniers@google.com>
Subject: [PATCH v2 3/5] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc-ifversion is GCC specific. Replace it with compiler specific
variants. Update the users of cc-ifversion to use these new macros.
Provide a helper for checking compiler versions for GCC and Clang
simultaneously, that will be used in a follow up patch.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Link: https://github.com/ClangBuiltLinux/linux/issues/350
Link: https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
Suggested-by: Bill Wendling <morbo@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* New patch.

 Documentation/kbuild/makefiles.rst          | 44 +++++++++++++++------
 Makefile                                    |  4 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 12 ++----
 scripts/Makefile.compiler                   | 15 +++++--
 4 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 11a296e52d68..e46f5b45c422 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -682,22 +682,42 @@ more details, with real examples.
 	In the above example, -Wno-unused-but-set-variable will be added to
 	KBUILD_CFLAGS only if gcc really accepts it.
 
-    cc-ifversion
-	cc-ifversion tests the version of $(CC) and equals the fourth parameter
-	if version expression is true, or the fifth (if given) if the version
-	expression is false.
+    gcc-min-version
+	gcc-min-version tests if the value of $(CONFIG_GCC_VERSION) is greater than
+	or equal to the provided value and evaluates to y if so.
 
 	Example::
 
-		#fs/reiserfs/Makefile
-		ccflags-y := $(call cc-ifversion, -lt, 0402, -O1)
+		cflags-$(call gcc-min-version, 70100) := -foo
 
-	In this example, ccflags-y will be assigned the value -O1 if the
-	$(CC) version is less than 4.2.
-	cc-ifversion takes all the shell operators:
-	-eq, -ne, -lt, -le, -gt, and -ge
-	The third parameter may be a text as in this example, but it may also
-	be an expanded variable or a macro.
+	In this example, cflags-y will be assigned the value -foo if $(CC) is gcc and
+	$(CONFIG_GCC_VERSION) is >= 7.1.
+
+    clang-min-version
+	clang-min-version tests if the value of $(CONFIG_CLANG_VERSION) is greater
+	than or equal to the provided value and evaluates to y if so.
+
+	Example::
+
+		cflags-$(call clang-min-version, 110000) := -foo
+
+	In this example, cflags-y will be assigned the value -foo if $(CC) is clang
+	and $(CONFIG_CLANG_VERSION) is >= 11.0.0.
+
+    cc-min-version
+	cc-min-version tests if the value of $(CONFIG_GCC_VERSION) is greater
+	than or equal to the first value provided, or if the value of
+	$(CONFIG_CLANG_VERSION) is greater than or equal to the second value
+	provided, and evaluates
+	to y if so.
+
+	Example::
+
+		cflags-$(call cc-min-version, 70100, 110000) := -foo
+
+	In this example, cflags-y will be assigned the value -foo if $(CC) is gcc and
+	$(CONFIG_GCC_VERSION) is >= 7.1, or if $(CC) is clang and
+	$(CONFIG_CLANG_VERSION) is >= 11.0.0.
 
     cc-cross-prefix
 	cc-cross-prefix is used to check if there exists a $(CC) in path with
diff --git a/Makefile b/Makefile
index 952d354069a4..caa39ecb1136 100644
--- a/Makefile
+++ b/Makefile
@@ -972,7 +972,7 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += -Wno-maybe-uninitialized
 endif
 
-ifdef CONFIG_CC_IS_GCC
+ifeq ($(call gcc-min-version, 90100),y)
 # The allocators already balk at large sizes, so silence the compiler
 # warnings for bounds checks involving those possible values. While
 # -Wno-alloc-size-larger-than would normally be used here, earlier versions
@@ -984,7 +984,7 @@ ifdef CONFIG_CC_IS_GCC
 # ignored, continuing to default to PTRDIFF_MAX. So, left with no other
 # choice, we must perform a versioned check to disable this warning.
 # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
-KBUILD_CFLAGS += $(call cc-ifversion, -ge, 0901, -Wno-alloc-size-larger-than)
+KBUILD_CFLAGS += -Wno-alloc-size-larger-than
 endif
 
 # disable invalid "can't wrap" optimizations for signed / pointers
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 86a3b5bfd699..d8ee4743b2e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -33,20 +33,14 @@ ifdef CONFIG_PPC64
 dml_ccflags := -mhard-float -maltivec
 endif
 
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
 ifdef CONFIG_X86
-ifdef IS_OLD_GCC
+ifeq ($(call gcc-min-version, 70100),y)
+dml_ccflags += -msse2
+else
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 dml_ccflags += -mpreferred-stack-boundary=4
-else
-dml_ccflags += -msse2
 endif
 endif
 
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index d1739f0d3ce3..13dade724fa3 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -61,9 +61,18 @@ cc-option-yn = $(call try-run,\
 cc-disable-warning = $(call try-run,\
 	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
-# cc-ifversion
-# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
-cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || echo $(4))
+# gcc-min-version
+# Usage: cflags-$(call gcc-min-version, 70100) += -foo
+gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION) -ge $(1) ] && echo y)
+
+# clang-min-version
+# Usage: cflags-$(call clang-min-version, 110000) += -foo
+clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION) -ge $(1) ] && echo y)
+
+# cc-min-version
+# Usage: cflags-$(call cc-min-version, 701000, 110000)
+#                                      ^ GCC   ^ Clang
+cc-min-version = $(filter y, $(call gcc-min-version, $(1)), $(call clang-min-version, $(2)))
 
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
-- 
2.37.2.672.g94769d06f0-goog

