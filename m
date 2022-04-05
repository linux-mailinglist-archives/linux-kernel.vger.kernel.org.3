Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3224F526F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382318AbiDFCtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585294AbiDEX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:59:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A6213508
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:16:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7eaa730d9so5192907b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NTGx3vO8sq1dXtBCR5+TJJ5C7vnKyf9ljgD3Rl3d4sc=;
        b=h8iz4EugNtzHw+TkxpZpBYCGCCOw0O9FMz2im/z0uUrLEs+1T52HjzmQ59g+6fbKtW
         DKg7PkBnEW/HsKPM93MnIaFOO4AJeFN+m4VQiDY9nglhzeWUyn99nm3Y+Tfj00E6o1LV
         clW7XpypS22Xo9AG8ovaE+We/efPkEUIcnfi3gTtLrw3lQfMfztiIjqMECCWvzHOrY5a
         mrkFMxmIFvKclS6MRmCe9hcPjAj1px/J8E40FJt/mK7p3ItlwQNHAdg7tKwEalQSnFhZ
         BCqc5MBXlrTwZkAHrKMfLBINPchgzD+FarD1hUAIYdqXoj3yR4SBE9MF9IJLHrUOiWek
         /2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NTGx3vO8sq1dXtBCR5+TJJ5C7vnKyf9ljgD3Rl3d4sc=;
        b=KkEP8cZic4vSeJOJGVLtIIxYEVxZm2fue/Y8tNcP9PRp+NXvPJUDrbEeSjWvnMphoA
         DJBLxM2Fp4uQ+GJh7tceitBoyqapOrBUW6N+IWs+Xb2+WUhHOG2aGEIven27MNmrwvoQ
         xI5gaotQKW2IhPaZi/Z+5DWQbiC6LxVq+FcBfUSBdqF0Tbbf19DvTC85MNVNwriw3ZK/
         +jTB72x8o61w9jMxPeBM96PX1ZCFjzztq51dWpBCjhSHFJ66ey0adPP8Bx1crVSZOrSw
         yzBPrK1+gTpp+JF1pv4Ux2l/QCXF3ZcT4LPqPi4zXqDKE0zQsZyLGfw4tn2900WK5sgz
         9RXw==
X-Gm-Message-State: AOAM533sWg4PpASTP8BYTg0pdpUzv90pe52kiowPFN5GzLt/1AXWBDhY
        59gmLKuISeAdwGwQepA9l3tngRWcebpwa+rbQrg=
X-Google-Smtp-Source: ABdhPJyBrG2/HD25BUflFAr/K23ubnstDkiGKDaIC/pKd8iPOdfQRe4MLYYSwsJVi03d+N4cc1D11pTqqJBArQ1QSb8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:1397:2ffa:35b2:9631])
 (user=samitolvanen job=sendgmr) by 2002:a5b:ed1:0:b0:634:15f0:9e87 with SMTP
 id a17-20020a5b0ed1000000b0063415f09e87mr4349556ybs.392.1649196980591; Tue,
 05 Apr 2022 15:16:20 -0700 (PDT)
Date:   Tue,  5 Apr 2022 15:16:18 -0700
Message-Id: <20220405221618.633743-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; h=from:subject;
 bh=/iQgT6IkB64+WL3JrTtJZgkW5s5WmdKdm+zLHBU/Yj8=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBiTL+vZsW7RO18a8xqCkt9rrmxEyA4NPySbVUngQFI
 GoRLlPeJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYky/rwAKCRBMtfaEi7xW7sxGC/
 9fJkMV8Rpp0ZqAPvqv/HJc8HUBS0A0GaV+mAW1Mc7A/GfLHYuxGAej4UZCoReOA/39x6QJvaKX14D2
 6EJpSZDjN7cCi5wI7Py/0keVybKhdtWT0wR/jSk/ghcj8JNx+j2HCzCJPr8McUGQRKSv4wFDd7Tsk0
 ZdP7Dh0reCxpBtYULYfuOxSepm1RVcsazYCtw+k1eMzCIIhswdU6blnr0WS9KS1a2yf/uNNx/O9ZUb
 MSgPXA8pLH8iZAI4kGZgpRtsGwKiglvWb7mxA4vEgUrL8A0rt8hmLGuWH+AaPVVnBqKymT6/Rz9tFF
 RDm/syXq8piAt3sbjdYRww/3twDWf/rt99fVORCBV16i73UCi4U6+LTgTGUjQwZ1sOmenzX7TFuNmi
 SZAY9dsGF809rREBiSpK7NF8Yefj2T+I8Oa9mEHDhUBMD3kM4xi8lEffuaRaFuZAQSY6Ndjsgof+y8
 PjuLLtAIB6ZoKCYxhWWWWARBW6r8eWL0dW48vsLMceES8=
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2] cfi: Use __builtin_function_start
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang 14 added support for the __builtin_function_start function,
which allows us to implement the function_nocfi macro without
architecture-specific inline assembly and in a way that also works
with static initializers.

Change CONFIG_CFI_CLANG to depend on Clang >=3D 14, define
function_nocfi using __builtin_function_start, and remove the arm64
inline assembly implementation.

Link: https://github.com/llvm/llvm-project/commit/ec2e26eaf63558934f5b73a6e=
530edc453cf9508
Link: https://github.com/ClangBuiltLinux/linux/issues/1353
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will@kernel.org> # arm64
---
v2:
- Changed CFI_CLANG to depend on Clang 14 instead of
  __builtin_function_start.
- Squashed all three patches into one.

---
 arch/Kconfig                      |  5 +----
 arch/arm64/include/asm/compiler.h | 16 ----------------
 include/linux/compiler-clang.h    | 10 ++++++++++
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 29b0167c088b..c1627bce4a3a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -723,10 +723,7 @@ config ARCH_SUPPORTS_CFI_CLANG
 config CFI_CLANG
 	bool "Use Clang's Control Flow Integrity (CFI)"
 	depends on LTO_CLANG && ARCH_SUPPORTS_CFI_CLANG
-	# Clang >=3D 12:
-	# - https://bugs.llvm.org/show_bug.cgi?id=3D46258
-	# - https://bugs.llvm.org/show_bug.cgi?id=3D47479
-	depends on CLANG_VERSION >=3D 120000
+	depends on CLANG_VERSION >=3D 140000
 	select KALLSYMS
 	help
 	  This option enables Clang=E2=80=99s forward-edge Control Flow Integrity
diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/com=
piler.h
index dc3ea4080e2e..6fb2e6bcc392 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -23,20 +23,4 @@
 #define __builtin_return_address(val)					\
 	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
=20
-#ifdef CONFIG_CFI_CLANG
-/*
- * With CONFIG_CFI_CLANG, the compiler replaces function address
- * references with the address of the function's CFI jump table
- * entry. The function_nocfi macro always returns the address of the
- * actual function instead.
- */
-#define function_nocfi(x) ({						\
-	void *addr;							\
-	asm("adrp %0, " __stringify(x) "\n\t"				\
-	    "add  %0, %0, :lo12:" __stringify(x)			\
-	    : "=3Dr" (addr));						\
-	addr;								\
-})
-#endif
-
 #endif /* __ASM_COMPILER_H */
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.=
h
index babb1347148c..c84fec767445 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -69,6 +69,16 @@
 #define __nocfi		__attribute__((__no_sanitize__("cfi")))
 #define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
=20
+#if defined(CONFIG_CFI_CLANG)
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x)	__builtin_function_start(x)
+#endif
+
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
--=20
2.35.1.1094.g7c7d902a7c-goog

