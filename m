Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47A46FF60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbhLJLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:09:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbhLJLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:54 -0500
Date:   Fri, 10 Dec 2021 11:05:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639134318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pG3+zxCo4Qkcwa0+4mpIEzP53yvo16Swc945EsLiPE8=;
        b=u2ZpCdsYLrI/Ci85SD9wRoBQGH5baZ/6iJDhhPzGuznt2TduekZbihDFISvgTDhxS3/X5t
        d4QKHT4RGrLlU1GvB/s8q3DewmOvpZJUJjcvxgxaqPOQ9l5lGsEYYNYM76dfpaPvoxfIv0
        Y2Gr6CEbwk4+vzMgsuEYJasVXL9ZWZOi+0j+FYbqx+sX1yEr7P3+luKLspkG010JCj1MYn
        inOxkrtaAVyLD5SQQ1IGltLiP3F+eXbIQ5xPnhaKPAlMa0Np/iBIydfrdqVldcTJmgU+3S
        UNFOsjRvKcA6h2PQwwoheZWqfvfDQFZ4YOB5gCsX1obO2SOY8N6guwKu65jqSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639134318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pG3+zxCo4Qkcwa0+4mpIEzP53yvo16Swc945EsLiPE8=;
        b=3EusCzf9crxojtPl1yl5We/EVT0vMhtudIq2Ea38BMID2VpVGqVx7n38yZ3Y0stz+hE4jD
        AqwL40RVQvQn1lAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Prepare inline-asm for straight-line-speculation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211204134907.964635458@infradead.org>
References: <20211204134907.964635458@infradead.org>
MIME-Version: 1.0
Message-ID: <163913431729.23020.9386764835797426676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b17c2baa305cccbd16bafa289fd743cc2db77966
Gitweb:        https://git.kernel.org/tip/b17c2baa305cccbd16bafa289fd743cc2db77966
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Dec 2021 14:43:41 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 19:23:12 +01:00

x86: Prepare inline-asm for straight-line-speculation

Replace all ret/retq instructions with ASM_RET in preparation of
making it more than a single instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211204134907.964635458@infradead.org
---
 arch/x86/include/asm/linkage.h            | 4 ++++
 arch/x86/include/asm/paravirt.h           | 2 +-
 arch/x86/include/asm/qspinlock_paravirt.h | 4 ++--
 arch/x86/kernel/alternative.c             | 2 +-
 arch/x86/kernel/kprobes/core.c            | 2 +-
 arch/x86/kernel/paravirt.c                | 4 ++--
 arch/x86/kvm/emulate.c                    | 4 ++--
 arch/x86/lib/error-inject.c               | 3 ++-
 samples/ftrace/ftrace-direct-modify.c     | 4 ++--
 samples/ftrace/ftrace-direct-too.c        | 2 +-
 samples/ftrace/ftrace-direct.c            | 2 +-
 11 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 3651117..ebddec2 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -18,6 +18,10 @@
 #define __ALIGN_STR	__stringify(__ALIGN)
 #endif
 
+#else /* __ASSEMBLY__ */
+
+#define ASM_RET	"ret\n\t"
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_LINKAGE_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 21c4a69..ce1148c 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -671,7 +671,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	    "call " #func ";"						\
 	    PV_RESTORE_ALL_CALLER_REGS					\
 	    FRAME_END							\
-	    "ret;"							\
+	    ASM_RET							\
 	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
 
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 159622e..1474cf9 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -48,7 +48,7 @@ asm    (".pushsection .text;"
 	"jne   .slowpath;"
 	"pop   %rdx;"
 	FRAME_END
-	"ret;"
+	ASM_RET
 	".slowpath: "
 	"push   %rsi;"
 	"movzbl %al,%esi;"
@@ -56,7 +56,7 @@ asm    (".pushsection .text;"
 	"pop    %rsi;"
 	"pop    %rdx;"
 	FRAME_END
-	"ret;"
+	ASM_RET
 	".size " PV_UNLOCK ", .-" PV_UNLOCK ";"
 	".popsection");
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 23fb4d5..175cde6 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -714,7 +714,7 @@ asm (
 "	.type		int3_magic, @function\n"
 "int3_magic:\n"
 "	movl	$1, (%" _ASM_ARG1 ")\n"
-"	ret\n"
+	ASM_RET
 "	.size		int3_magic, .-int3_magic\n"
 "	.popsection\n"
 );
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index fce99e2..6290712 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1051,7 +1051,7 @@ asm(
 	"	addl $4, %esp\n"
 	"	popfl\n"
 #endif
-	"	ret\n"
+	ASM_RET
 	".size __kretprobe_trampoline, .-__kretprobe_trampoline\n"
 );
 NOKPROBE_SYMBOL(__kretprobe_trampoline);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7f7636a..4420499 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -41,7 +41,7 @@ extern void _paravirt_nop(void);
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global _paravirt_nop\n"
      "_paravirt_nop:\n\t"
-     "ret\n\t"
+     ASM_RET
      ".size _paravirt_nop, . - _paravirt_nop\n\t"
      ".type _paravirt_nop, @function\n\t"
      ".popsection");
@@ -51,7 +51,7 @@ asm (".pushsection .entry.text, \"ax\"\n"
      ".global paravirt_ret0\n"
      "paravirt_ret0:\n\t"
      "xor %" _ASM_AX ", %" _ASM_AX ";\n\t"
-     "ret\n\t"
+     ASM_RET
      ".size paravirt_ret0, . - paravirt_ret0\n\t"
      ".type paravirt_ret0, @function\n\t"
      ".popsection");
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 28b1a4e..b026350 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -315,7 +315,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	__FOP_FUNC(#name)
 
 #define __FOP_RET(name) \
-	"ret \n\t" \
+	ASM_RET \
 	".size " name ", .-" name "\n\t"
 
 #define FOP_RET(name) \
@@ -435,7 +435,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	__FOP_RET(#op)
 
 asm(".pushsection .fixup, \"ax\"\n"
-    "kvm_fastop_exception: xor %esi, %esi; ret\n"
+    "kvm_fastop_exception: xor %esi, %esi; " ASM_RET
     ".popsection");
 
 FOP_START(setcc)
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index be5b5fb..5208970 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/linkage.h>
 #include <linux/error-injection.h>
 #include <linux/kprobes.h>
 
@@ -10,7 +11,7 @@ asm(
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
 	"just_return_func:\n"
-	"	ret\n"
+		ASM_RET
 	".size just_return_func, .-just_return_func\n"
 );
 
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 690e4a9..bc8f0d6 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -31,7 +31,7 @@ asm (
 "	call my_direct_func1\n"
 "	leave\n"
 "	.size		my_tramp1, .-my_tramp1\n"
-"	ret\n"
+	ASM_RET
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
@@ -39,7 +39,7 @@ asm (
 "	movq %rsp, %rbp\n"
 "	call my_direct_func2\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
 );
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 6e0de72..d1bec1c 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -31,7 +31,7 @@ asm (
 "	popq %rsi\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index a30aa42..51312e0 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -25,7 +25,7 @@ asm (
 "	call my_direct_func\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
