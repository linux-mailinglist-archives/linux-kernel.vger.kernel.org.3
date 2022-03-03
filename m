Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B014CB594
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiCCDze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCDzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:55:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB9A145626
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:54:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so6603540pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QM4uqobSxpcHZ2MwWSMdbi4rkeQlFurjLwJi8lu0KCY=;
        b=JYpMQDYmzqVeJbVhFmGS6lOnm97UZ7Qa+V8YhRgJi/JNJB6m/QF2UDX5oPsrYLMFeY
         lbg+bRCPOwWeUsRb/9d4OXavdYTBe6uzWSQ/gJge4Bto6Pwxt5P3erkRv11Sb4PsD0wG
         2UIw33m6EuUQcv4G0V4pBKFL5S5od8SuzWhj4leZ8EN3ySdZZrWeLTCJd4uQKl1qeoRX
         wcnhoMMsH5WqnKBD4f/IxrH0ZbbrsHDqlHC2Ch/g7vjaNvt8XwoKKKwN5vB3oRKCN1Zj
         P1m9nKILLOHxAiWeRLU4vBq+8CtEsjZvNMa2DNw8IK7fqjfBdVNyunLF4lw1uGBDMkh7
         Jk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QM4uqobSxpcHZ2MwWSMdbi4rkeQlFurjLwJi8lu0KCY=;
        b=QvzQYa3mnFxZQ1eDgl2d3R0BAXoGAnyLsN+H/I68JzIUhjYv18LzaL2reIVSgMbRlY
         wMlbTc7J0njzJCr91v3DLoGXpmJkt9kXeOnrTOeu06IDGt2cpVXQeTwyGgSxNg4H6qnh
         A8OWET8w2Jd7fAz1m8usjBvCxhlXVWUxEZ/kGvre+8xpAMNwqA79ggLT+gR2yOmNwNxo
         W1lnSQnzsCUG7T3nvKeObWYlcxy6VaCKWRY90IdWlgurN1bRe6IlxvwWzmMuXXwBmmtK
         eI68cJ/TZV6Y9W4hTyZAmJiJw3TqmJsqnISG+TgM+g+FmDI4KVl3xAK2GSPKKnhga/Ip
         wQdQ==
X-Gm-Message-State: AOAM530K1CtH+NQZncjmBx3edzZXkxt8hm25G9A+eXz+2w7QXKKb92b0
        6M8Yq5qUn+F/VoZM9hZZXp3Ee894asc=
X-Google-Smtp-Source: ABdhPJyDUtmejzGJtbp+1hm9qyCe2tA/8FObh1ude01fnCTZSkr/+f3brn4ijPSCcg+2uT7F2Qn1fQ==
X-Received: by 2002:a17:902:7298:b0:151:842b:a241 with SMTP id d24-20020a170902729800b00151842ba241mr11104204pll.115.1646279679194;
        Wed, 02 Mar 2022 19:54:39 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a0008ce00b004f66dcd4f1csm627897pfu.32.2022.03.02.19.54.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:54:38 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH V2 6/7] x86/entry: Use idtentry macro for entry_INT80_compat
Date:   Thu,  3 Mar 2022 11:54:33 +0800
Message-Id: <20220303035434.20471-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220303035434.20471-1-jiangshanlai@gmail.com>
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

entry_INT80_compat is identical to idtentry macro except a special
handling for %rax in the prolog.

Add the prolog to idtentry and use idtentry for entry_INT80_compat.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S        |  18 ++++++
 arch/x86/entry/entry_64_compat.S | 102 -------------------------------
 arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
 arch/x86/include/asm/proto.h     |   4 --
 4 files changed, 65 insertions(+), 106 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index adc9f7619d1b..88b61f310289 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -371,6 +371,24 @@ SYM_CODE_START(\asmsym)
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
 	.endif
 
+	.if \vector == IA32_SYSCALL_VECTOR
+		/*
+		 * User tracing code (ptrace or signal handlers) might assume
+		 * that the saved RAX contains a 32-bit number when we're
+		 * invoking a 32-bit syscall.  Just in case the high bits are
+		 * nonzero, zero-extend the syscall number.  (This could almost
+		 * certainly be deleted with no ill effects.)
+		 */
+		movl	%eax, %eax
+
+		/*
+		 * do_int80_syscall_32() expects regs->orig_ax to be user ax,
+		 * and regs->ax to be $-ENOSYS.
+		 */
+		movq	%rax, (%rsp)
+		movq	$-ENOSYS, %rax
+	.endif
+
 	.if \vector == X86_TRAP_BP
 		/*
 		 * If coming from kernel space, create a 6-word gap to allow the
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0051cf5c792d..a4fcea0cab14 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -311,105 +311,3 @@ sysret32_from_system_call:
 	swapgs
 	sysretl
 SYM_CODE_END(entry_SYSCALL_compat)
-
-/*
- * 32-bit legacy system call entry.
- *
- * 32-bit x86 Linux system calls traditionally used the INT $0x80
- * instruction.  INT $0x80 lands here.
- *
- * This entry point can be used by 32-bit and 64-bit programs to perform
- * 32-bit system calls.  Instances of INT $0x80 can be found inline in
- * various programs and libraries.  It is also used by the vDSO's
- * __kernel_vsyscall fallback for hardware that doesn't support a faster
- * entry method.  Restarted 32-bit system calls also fall back to INT
- * $0x80 regardless of what instruction was originally used to do the
- * system call.
- *
- * This is considered a slow path.  It is not used by most libc
- * implementations on modern hardware except during process startup.
- *
- * Arguments:
- * eax  system call number
- * ebx  arg1
- * ecx  arg2
- * edx  arg3
- * esi  arg4
- * edi  arg5
- * ebp  arg6
- */
-SYM_CODE_START(entry_INT80_compat)
-	UNWIND_HINT_EMPTY
-	/*
-	 * Interrupts are off on entry.
-	 */
-	ASM_CLAC			/* Do this early to minimize exposure */
-	SWAPGS
-
-	/*
-	 * User tracing code (ptrace or signal handlers) might assume that
-	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
-	 * syscall.  Just in case the high bits are nonzero, zero-extend
-	 * the syscall number.  (This could almost certainly be deleted
-	 * with no ill effects.)
-	 */
-	movl	%eax, %eax
-
-	/* switch to thread stack expects orig_ax and rdi to be pushed */
-	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
-
-	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-
-	/* In the Xen PV case we already run on the thread stack. */
-	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
-
-	movq	%rsp, %rdi
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	pushq	6*8(%rdi)		/* regs->ss */
-	pushq	5*8(%rdi)		/* regs->rsp */
-	pushq	4*8(%rdi)		/* regs->eflags */
-	pushq	3*8(%rdi)		/* regs->cs */
-	pushq	2*8(%rdi)		/* regs->ip */
-	pushq	1*8(%rdi)		/* regs->orig_ax */
-	pushq	(%rdi)			/* pt_regs->di */
-.Lint80_keep_stack:
-
-	pushq	%rsi			/* pt_regs->si */
-	xorl	%esi, %esi		/* nospec   si */
-	pushq	%rdx			/* pt_regs->dx */
-	xorl	%edx, %edx		/* nospec   dx */
-	pushq	%rcx			/* pt_regs->cx */
-	xorl	%ecx, %ecx		/* nospec   cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   %r8			/* pt_regs->r8 */
-	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   %r9			/* pt_regs->r9 */
-	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   %r10			/* pt_regs->r10*/
-	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   %r11			/* pt_regs->r11 */
-	xorl	%r11d, %r11d		/* nospec   r11 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	xorl	%ebx, %ebx		/* nospec   rbx */
-	pushq   %rbp                    /* pt_regs->rbp */
-	xorl	%ebp, %ebp		/* nospec   rbp */
-	pushq   %r12                    /* pt_regs->r12 */
-	xorl	%r12d, %r12d		/* nospec   r12 */
-	pushq   %r13                    /* pt_regs->r13 */
-	xorl	%r13d, %r13d		/* nospec   r13 */
-	pushq   %r14                    /* pt_regs->r14 */
-	xorl	%r14d, %r14d		/* nospec   r14 */
-	pushq   %r15                    /* pt_regs->r15 */
-	xorl	%r15d, %r15d		/* nospec   r15 */
-
-	UNWIND_HINT_REGS
-
-	cld
-
-	movq	%rsp, %rdi
-	call	do_int80_syscall_32
-	jmp	swapgs_restore_regs_and_return_to_usermode
-SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..38cb2e0dc2c7 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -204,6 +204,20 @@ __visible noinstr void func(struct pt_regs *regs,			\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
 
+/**
+ * DECLARE_IDTENTRY_IA32_EMULATION - Declare functions for int80
+ * @vector:	Vector number (ignored for C)
+ * @asm_func:	Function name of the entry point
+ * @cfunc:	The C handler called from the ASM entry point (ignored for C)
+ *
+ * Declares two functions:
+ * - The ASM entry point: asm_func
+ * - The XEN PV trap entry point: xen_##asm_func (maybe unused)
+ */
+#define DECLARE_IDTENTRY_IA32_EMULATION(vector, asm_func, cfunc)	\
+	asmlinkage void asm_func(void);					\
+	asmlinkage void xen_##asm_func(void)
+
 /**
  * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
  * @vector:	Vector number (ignored for C)
@@ -430,6 +444,35 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
 	idtentry vector asm_##func func has_error_code=1
 
+/*
+ * 32-bit legacy system call entry.
+ *
+ * 32-bit x86 Linux system calls traditionally used the INT $0x80
+ * instruction.  INT $0x80 lands here.
+ *
+ * This entry point can be used by 32-bit and 64-bit programs to perform
+ * 32-bit system calls.  Instances of INT $0x80 can be found inline in
+ * various programs and libraries.  It is also used by the vDSO's
+ * __kernel_vsyscall fallback for hardware that doesn't support a faster
+ * entry method.  Restarted 32-bit system calls also fall back to INT
+ * $0x80 regardless of what instruction was originally used to do the
+ * system call.
+ *
+ * This is considered a slow path.  It is not used by most libc
+ * implementations on modern hardware except during process startup.
+ *
+ * Arguments:
+ * eax  system call number
+ * ebx  arg1
+ * ecx  arg2
+ * edx  arg3
+ * esi  arg4
+ * edi  arg5
+ * ebp  arg6
+ */
+#define DECLARE_IDTENTRY_IA32_EMULATION(vector, asm_func, cfunc)	\
+	idtentry vector asm_func cfunc has_error_code=0
+
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
 
@@ -631,6 +674,10 @@ DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
 DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	spurious_interrupt);
 #endif
 
+#ifdef CONFIG_IA32_EMULATION
+DECLARE_IDTENTRY_IA32_EMULATION(IA32_SYSCALL_VECTOR,	entry_INT80_compat, do_int80_syscall_32);
+#endif
+
 /* System vector entry points */
 #ifdef CONFIG_X86_LOCAL_APIC
 DECLARE_IDTENTRY_SYSVEC(ERROR_APIC_VECTOR,		sysvec_error_interrupt);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index feed36d44d04..c4d331fe65ff 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -28,10 +28,6 @@ void entry_SYSENTER_compat(void);
 void __end_entry_SYSENTER_compat(void);
 void entry_SYSCALL_compat(void);
 void entry_SYSCALL_compat_safe_stack(void);
-void entry_INT80_compat(void);
-#ifdef CONFIG_XEN_PV
-void xen_entry_INT80_compat(void);
-#endif
 #endif
 
 void x86_configure_nx(void);
-- 
2.19.1.6.gb485710b

