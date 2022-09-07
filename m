Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87E5AFB7D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiIGE75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGE7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:59:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512985FC1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:59:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3454647ff7dso54113937b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=bcgi8Ou8th2qqJa7CD88vTQQmiUlNdn6G38aIXpHI6Y=;
        b=ntpiMlsUZbBzGuoDfGrsuzC9Fu9Dngcb4gIzs9vYGwNNGJsAHWhrinnINN7afNa+aa
         Ju69QRlfFJKW9Y10Cp/2v4E6l4L3HUCFUsswVqibz/opy/3jfd5IGljZ+yDbnBHTGone
         gLjkZkXmzODkCXP09P6it2IQmKO6vQiVkQCWObUeDZWSQQsyH2CrqhdhCEkLAIvxJ++3
         Cn1vaDzB3STqCw6p0UOO+5q+vBLH7eUoI8EnXYuDLIxqAjPA0pQIlsetbgBApQo/8knJ
         9xuXq0izZx+52Ei7v7eLE+alDASuxx+P4GL55l25kj1eL6HIUPJ9xOXLI0sbvJ+5PZko
         Niqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=bcgi8Ou8th2qqJa7CD88vTQQmiUlNdn6G38aIXpHI6Y=;
        b=wprMATEr9iX8hZxA1lRRtB+zIjZfkSupdy2ONVe9TSf+s2fjU/g27GwDxJ3E9p/EEm
         LIBgIe1nmYPbT8Y7fhnAJC5H6qXNylC5nWDEvCv6SEyRTpx4q5rPm7obFeFpIS5ZamMs
         WazepJUu8SeoBA8KevVqaTk/EstLBUOpc6cj9yBQIAcmH2RkD8i0jWe4TLoocQDOScw9
         G5bLOA/MqNYVUfqPKZLSwoX6xCu3wOv08SpBPtycTwuYqURNWDVoeEbSWXGzSgwvnSD7
         BRtRO1+hLY4qQME4ytom0t0FDtU4Z2+86QZNzhCVSCFNRLkaGTYHMPzCzbnAyqfWgHH/
         /1mA==
X-Gm-Message-State: ACgBeo2duZH664eqmCSUZcTOGsm5wsiQevkwHga9I6OTugkZKB7AM8LR
        9aAYUqt1kmvz5RpWy8Xv75WwRNbHLNPcaiETpTg=
X-Google-Smtp-Source: AA6agR51gs/uUHreq+msqsiaEhkiRFCgMis3Jrd7egz+g3Jty9ES9OQyft1PDZ/MLkfp6N0Nb4aIesch0EUTQLjAZFA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:9755:c523:9dcb:2228])
 (user=ndesaulniers job=sendgmr) by 2002:a25:2501:0:b0:6a9:2c63:41df with SMTP
 id l1-20020a252501000000b006a92c6341dfmr1513377ybl.570.1662526770665; Tue, 06
 Sep 2022 21:59:30 -0700 (PDT)
Date:   Tue,  6 Sep 2022 21:59:05 -0700
In-Reply-To: <20220907045907.484043-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220907045907.484043-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662526746; l=5523;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=vU2YBqs04SKJi0GQSDvA4poA04ESc702LTI4xVOdImw=;
 b=ACvgjV4W2Fn0d0OoSsDUnfzLwgzbvkoSX5pWoxmj3OhBeI7wqr6l/Ze+J8eLCVskjea6kj/Y/Vom
 ccwPJxl5DeIznlJUZRGwr4WOP/rnBszo5UuLLP878hh5x1U5qH57
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907045907.484043-4-ndesaulniers@google.com>
Subject: [PATCH v3 3/5] Makefile.compiler: replace cc-ifversion with
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
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc-ifversion is GCC specific. Replace it with compiler specific
variants. Update the users of cc-ifversion to use these new macros.

Link: https://github.com/ClangBuiltLinux/linux/issues/350
Link: https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
Suggested-by: Bill Wendling <morbo@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2 -> v3:
* Fix AMDGPU -msse flag, as per Nathan.
* Pick up Nathan's RB tag.
* Drop cc-min-version, as per Masahiro.

Changes v1 -> v2:
* New patch.

 Documentation/kbuild/makefiles.rst          | 29 ++++++++++++---------
 Makefile                                    |  6 ++---
 drivers/gpu/drm/amd/display/dc/dml/Makefile |  2 +-
 scripts/Makefile.compiler                   | 10 ++++---
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 11a296e52d68..ee7e3ea1fbe1 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -682,22 +682,27 @@ more details, with real examples.
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
 
     cc-cross-prefix
 	cc-cross-prefix is used to check if there exists a $(CC) in path with
diff --git a/Makefile b/Makefile
index a4f71076cacb..cd9919c66b96 100644
--- a/Makefile
+++ b/Makefile
@@ -790,7 +790,6 @@ KBUILD_CFLAGS += $(stackp-flags-y)
 
 KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
 KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
-KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
@@ -972,7 +971,6 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += -Wno-maybe-uninitialized
 endif
 
-ifdef CONFIG_CC_IS_GCC
 # The allocators already balk at large sizes, so silence the compiler
 # warnings for bounds checks involving those possible values. While
 # -Wno-alloc-size-larger-than would normally be used here, earlier versions
@@ -984,8 +982,8 @@ ifdef CONFIG_CC_IS_GCC
 # ignored, continuing to default to PTRDIFF_MAX. So, left with no other
 # choice, we must perform a versioned check to disable this warning.
 # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
-KBUILD_CFLAGS += $(call cc-ifversion, -ge, 0901, -Wno-alloc-size-larger-than)
-endif
+KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
+KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= -fno-strict-overflow
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 86a3b5bfd699..3c64ae0b212c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -34,7 +34,7 @@ dml_ccflags := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index a66638b5f4a5..4b998dadd79d 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -61,9 +61,13 @@ cc-option-yn = $(call try-run,\
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
 
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
-- 
2.37.2.789.g6183377224-goog

