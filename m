Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3778547044
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350682AbiFJXf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349341AbiFJXfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:35:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB7028B5E8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30c2f3431b4so5610937b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VtFj7Vd8iwc9aJC7agWcINnamQLCLqRTsZqQ1uLXLKE=;
        b=jYgx5aDbAXUdckbjfxHM6VjMlcQuhrZKNTnRn5oFv7YtvkjdDrt08K3br1BBkOgL8v
         hfIm0f+dL7y34o6vl5M2Jp1QVRrM8quCpZJWTyScrlMqWapTMjzKYbkaRBiz7wxw47Uj
         kAOSPLVojhIRsvNffTalKGOoBh/GAP1xDBC8GzzTTlMd20vGAKd0wVTBrFoVnFVuQXZi
         abMqGSOEp1V5iFY0BMyr2jmzrQO4DyQN+R5p0gG7uuuhhjBxyoSCQgcWZkbk3n6b1gZE
         nSb/cMuXEELRlddvzIye3yNQrpLfr0IkI7tbEiKtCTwllqpUHAQwhXI8Qmr/gE5KUcs3
         BFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VtFj7Vd8iwc9aJC7agWcINnamQLCLqRTsZqQ1uLXLKE=;
        b=CjnzJy+bgPJADReH0gcRe34xbvgzDqOOO+aQgSyU1SE2mCiuLgP7MWDyTuEu59SgtQ
         J7wmBcy5JyfAIHHGdCQYZtuvxsScAFHHFpgApoDiMOjrtX/TBd0RZYp476viTfZ3ryiO
         jgoo6TUV9DWCUwBcIUz6nisDSY74lmY4ZlgcvAw7fRP1Z61l8Ju0oNqnttEkpGexuwy7
         oI4F/ogBdNWuh8xmTJQ3tTvUanTNLQFJaNK1PgaO9cUE1EEAgIGZugb5e4xsvrinnk4w
         mg8FHAHUsTCVNWcYkfcWa9RET+12ofGMcqbMahw+Qtebbpz7AWJejtv3JazNNoAMUxl2
         le4Q==
X-Gm-Message-State: AOAM5338tYpEqjiWJoebq9T7ZYrap2s5HiM4E0gPOXLIJ1NSPvB5GwDo
        jiGbXQINOPmF5mG0Fj+ulC2B/rKhkZlg8005JB2T5v8JLXZZu1tj+4ePDQJ4aei7NQRfNzO00na
        UlT5aKLCgnvYWS85zwzFmnLCm0bUC07S7ABY6ZCP2TrKcOsv50R6QwXMCYMD2+igm1MK+gLogAK
        6Phz+BGI668Q==
X-Google-Smtp-Source: ABdhPJxPJe/R9hy4gXctM+ZmC5RqiftonDv7jq985Ji7NGmV6YePfVEI2vK+OgM/En62caw8kWQTe3zLaVkzaIsywZ4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a25:a286:0:b0:664:862a:f693 with SMTP
 id c6-20020a25a286000000b00664862af693mr271374ybi.389.1654904129740; Fri, 10
 Jun 2022 16:35:29 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:34:59 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3855; h=from:subject;
 bh=vJjTKDDovIqbimAL5v+Qu72XUGMoBkbINCB1joYMPKU=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UtLp/lk9levVOrHA5IEoT7UV9n0C0LMo0gZcI3
 HWSej++JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLQAKCRBMtfaEi7xW7olJC/
 4n+gkrmT90LKCtkM3/knA9+abm9t9xP3/1RUuxJvS9V60qXooFQTKSlMGg37XsKAmX1RRl4xQ4t6L7
 +Gf/rrhzvSxxa3zaQ/VeRelaVcaclvu6sAe+ye6jMb5MsOvcfGoEBsERiMDz4l2wPcJg2Ku6cVplDG
 r/CJTX82Jq62hFxoqZEBa77YE68NpCdInUGaZrNAZeiTX8fTqOMHfvVNa7WFSzujZkU2clKPoT7HDs
 wFlBg8gIg53vBFUUfUsTYKkOg/sV74bzgiJSHKgURb9CvFc+RNvshiuVnpkbScU2sK/Jk9yibau77o
 B6f0gD5lbJNCgBT9f1NV6xd4/XEaCfBT2sYRe5KHccSMOhzTeccUmvDxjQAHpIhQRrJuiQ5tZuDoXr
 7b/UJsODWukDlXOS8gUEcl/PIaSZXbwk4XABYtgMgy5+98B4le7Vzs83C4j3FcyWb9GbJbxmSWRpPg
 KeWddzgJvIAIRm3RIJdXttUz9haWOi0ujsH+TkDI/OcHQ=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 06/20] cfi: Add type helper macros
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
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

With CONFIG_CFI_CLANG, assembly functions called indirectly
from C code must be annotated with type identifiers to pass CFI
checking.  In order to make this easier, the compiler emits a
__kcfi_typeid_<function> symbol for each address-taken function
declaration in C, which contains the expected type identifier that
we can refer to in assembly code.

Add typed versions of SYM_FUNC_START and SYM_FUNC_START_ALIAS, which
emit the type identifier before the function. Architectures that
support KCFI can define their own __CFI_TYPE macro to override the
default preamble format.

As an example, for the x86_64 blowfish_dec_blk function, the
compiler emits the following type symbol:

$ readelf -sW vmlinux | grep __kcfi_typeid_blowfish_dec_blk
121794: ffffffffef478db5     0 NOTYPE  WEAK   DEFAULT   ABS
	__kcfi_typeid_blowfish_dec_blk

And SYM_FUNC_START will generate the following preamble based on
the __CFI_TYPE definition for the architecture:

$ objdump -dr arch/x86/crypto/blowfish-x86_64-asm_64.o
     ...
00000000000003f7 <__cfi_blowfish_dec_blk>:
     3f7:       cc                      int3
     3f8:       cc                      int3
     3f9:       8b 04 25 00 00 00 00    mov    0x0,%eax
                        3fc: R_X86_64_32S __kcfi_typeid_blowfish_dec_blk
     400:       cc                      int3
     401:       cc                      int3

0000000000000402 <blowfish_dec_blk>:
     ...

Note that the address of all assembly functions annotated with
SYM_FUNC_START* must be taken in C code that's linked into the
binary or the missing __kcfi_typeid_ symbol will result in a linker
error with CONFIG_CFI_CLANG. If the code that contains the indirect
call is not always compiled in, __ADDRESSABLE(functionname) can be
used to ensure that the __kcfi_typeid_ symbol is emitted.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/cfi_types.h | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 include/linux/cfi_types.h

diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
new file mode 100644
index 000000000000..dd16e755a197
--- /dev/null
+++ b/include/linux/cfi_types.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Clang Control Flow Integrity (CFI) type definitions.
+ */
+#ifndef _LINUX_CFI_TYPES_H
+#define _LINUX_CFI_TYPES_H
+
+#ifdef CONFIG_CFI_CLANG
+#include <linux/linkage.h>
+
+#ifdef __ASSEMBLY__
+/*
+ * Use the __kcfi_typeid_<function> type identifier symbol to
+ * annotate indirectly called assembly functions. The compiler emits
+ * these symbols for all address-taken function declarations in C
+ * code.
+ */
+#ifndef __CFI_TYPE
+#define __CFI_TYPE(name)				\
+	.4byte __kcfi_typeid_##name
+#endif
+
+#define SYM_TYPED_ENTRY(name, fname, linkage, align...)	\
+	linkage(name) ASM_NL				\
+	align ASM_NL					\
+	__CFI_TYPE(fname) ASM_NL			\
+	name:
+
+#define __SYM_TYPED_FUNC_START_ALIAS(name, fname) \
+	SYM_TYPED_ENTRY(name, fname, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#define __SYM_TYPED_FUNC_START(name, fname) \
+	SYM_TYPED_ENTRY(name, fname, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#endif /* __ASSEMBLY__ */
+
+#else /* CONFIG_CFI_CLANG */
+
+#ifdef __ASSEMBLY__
+#define __SYM_TYPED_FUNC_START_ALIAS(name, fname) \
+	SYM_FUNC_START_ALIAS(name)
+
+#define __SYM_TYPED_FUNC_START(name, fname) \
+	SYM_FUNC_START(name)
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_CFI_CLANG */
+
+#ifdef __ASSEMBLY__
+#define SYM_TYPED_FUNC_START_ALIAS(name) \
+	__SYM_TYPED_FUNC_START_ALIAS(name, name)
+
+#define SYM_TYPED_FUNC_START(name) \
+	__SYM_TYPED_FUNC_START(name, name)
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_CFI_TYPES_H */
-- 
2.36.1.476.g0c4daa206d-goog

