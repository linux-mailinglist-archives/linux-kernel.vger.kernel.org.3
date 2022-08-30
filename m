Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E995A6EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiH3Uxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiH3Ux1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:53:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFC58670D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:53:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33daeaa6b8eso186758307b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=5v/uULD38sKMsG6PW3WCi/TldG3Gb7FVbu6pkSQhM+o=;
        b=SS9SACvDbzU1NVjQtI+3FiV/qXJ09D57Q7Esfs1fzYpQOLlB2j5MiVHnLWFXtuvZ6X
         93/Y7XkferOLW6SRzUeTtPRFBWVQ+MLa50xEonH/qbWeXV4bzLe+hikag9gSF2r9Gl1e
         Iv2p0V426xzCrX5/d1FjinL8SW3pZ/fQlOYl9p5/NxChz4cpSsbbcPHJIG6xlXQLdPWu
         3lqT1KsAnbiWld23oOo8L0r8LfQ6XSz0zxJXLX/MUu4Q9CslCLg85cA4MtiP0NoXB6+U
         Ql89HJJC5BVg2i7XB8dtWqhX5UU/u2D36CJZeDtvTnfZwQF1YBbQ4/i23h+ndVG0JUZA
         Q+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=5v/uULD38sKMsG6PW3WCi/TldG3Gb7FVbu6pkSQhM+o=;
        b=UkNYfCRTkELAha3psyTQcUtKAMJzL8nIB0pIFP7vr/LjpM9WFXOxrwijjLtns2dkVd
         +hMUf7akMdVuBeTFYsIFBhL9Y4vY2q+7v0ygCK7uI09dz/+ubWvPOBV10t0+TVT+sTdN
         CAVFz7BYVIZCw4uFVTMV3XerXGuBESDAnwW3TUkFxqNaZ9Sjd1MbgEElo5KTQaxA4eD+
         PZAEnE3k/I2ZCPCFuDARCBV3DVpGV35UhvoDfJJXM4TQU0AzZJ2d8Cw1D2apqNM8um8s
         FjtXTQmoFU+mxEaWMRpazSikVnQCgGEgNfyFaGHPT9Gs8/CDLoAyiDCmDgdWGL6Y0qsv
         7K7g==
X-Gm-Message-State: ACgBeo1Sq9+qR3fpBC9qYWq8gSLSVpnw+8QVJDEwi4An27nrdf1WpwXx
        /fBLTkcahX6VN3QxztL4R+unGG2nG1Mw8Rm+0aQ=
X-Google-Smtp-Source: AA6agR4oE95bBhsSdIdScCPuED5bUgOLluJDetPQDhXiC2CMIZ2RkmN7Trz5O3XFH2zyMohNmhBoin3YpKWt+WGCqxU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:422b:cadb:302a:7901])
 (user=ndesaulniers job=sendgmr) by 2002:a81:7784:0:b0:33d:ca62:45f5 with SMTP
 id s126-20020a817784000000b0033dca6245f5mr15393337ywc.180.1661892805082; Tue,
 30 Aug 2022 13:53:25 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:53:07 -0700
In-Reply-To: <20220830205309.312864-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220830205309.312864-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661892789; l=3598;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=FqEu/v2r7QzyhMZ+aKgXq/vN9XM6LoTxDIw9cP7G/EQ=;
 b=gjQOE8Flfs4jPPc0zq1aAHXUiYKr0bq9gXdpXuj1sxS/j6umW+wG0AxfG9aN1eUi5IiBKiNCzvOS
 AbdniodNBrjpabk0YC0HNqMXXwo1xbVr1piJvMVBUhy3+S42e8YU
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830205309.312864-2-ndesaulniers@google.com>
Subject: [PATCH 1/3] fortify: use __builtin_dynamic_object_size in __compiletime_strlen
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
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

With CONFIG_FORTIFY=y and CONFIG_UBSAN_LOCAL_BOUNDS=y enabled, we
observe a runtime panic while running Android's Compatibility Test
Suite's (CTS) android.hardware.input.cts.tests.  This is stemming from a
strlen() call in hidinput_allocate().

__compiletime_strlen is implemented in terms of __builtin_object_size(),
then does an array access to check for NUL-termination. A quirk of
__builtin_object_size() is that for strings whose values are runtime
dependent, __builtin_object_size(str, 1 or 0) returns the maximum size
of possible values when those sizes are determinable at compile time.
Example:

  static const char *v = "FOO BAR";
  static const char *y = "FOO BA";
  unsigned long x (int z) {
      // Returns 8, which is:
      // max(__builtin_object_size(v, 1), __builtin_object_size(y, 1))
      return __builtin_object_size(z ? v : y, 1);
  }

So when FORTIFY is enabled, the current implementation of
__compiletime_strlen will try to access beyond the end of y at runtime
using the size of v. Mixed with UBSAN_LOCAL_BOUNDS we get a fault.

hidinput_allocate() has a local C string whose value is control flow
dependent on a switch statement, so __builtin_object_size(str, 1)
evaluates to the maximum string length, making all other cases fault on
the last character check. hidinput_allocate() could be cleaned up to
avoid runtime calls to strlen() since the local variable can only have
literal values, so there's no benefit to trying to fortify the strlen
call site there.

Add a Kconfig check for __builtin_dynamic_object_size(), then use that
when available (gcc-12+, all supported versions of clang) which avoids
this surprising behavior.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/fortify-string.h | 8 +++++++-
 init/Kconfig                   | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 3b401fa0f374..c5adad596a3f 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -14,11 +14,17 @@ void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("
 void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
 void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("detected write beyond size of field (1st parameter); maybe use struct_group()?");
 
+#ifdef CONFIG_CC_HAS_BUILTIN_DYNAMIC_OBJECT_SIZE
+#define __object_size __builtin_dynamic_object_size
+#else
+#define __object_size __builtin_object_size
+#endif
+
 #define __compiletime_strlen(p)					\
 ({								\
 	unsigned char *__p = (unsigned char *)(p);		\
 	size_t __ret = (size_t)-1;				\
-	size_t __p_size = __builtin_object_size(p, 1);		\
+	size_t __p_size = __object_size(p, 1);			\
 	if (__p_size != (size_t)-1) {				\
 		size_t __p_len = __p_size - 1;			\
 		if (__builtin_constant_p(__p[__p_len]) &&	\
diff --git a/init/Kconfig b/init/Kconfig
index 532362fcfe31..87dd31aa54ad 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -876,6 +876,9 @@ config ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 config CC_HAS_INT128
 	def_bool !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0) && 64BIT
 
+config CC_HAS_BUILTIN_DYNAMIC_OBJECT_SIZE
+	def_bool !CC_IS_GCC || GCC_VERSION >= 120000
+
 config CC_IMPLICIT_FALLTHROUGH
 	string
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
-- 
2.37.2.672.g94769d06f0-goog

