Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5D53E7AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiFFOpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiFFOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:45:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F8227FF1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so12731886pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+0ZvBcKjmOSwrSdkGloKpQ9H3nxamEQCaD2KXxqLfY=;
        b=FvqOZnH0mRX3uHYAPbiYuJBlNkp/2eOON9LX0IK2ME2E+X+SEuBu6vIe140tN4r16V
         Gid/QTm+E1i9Z95akrYb3IeO4lo3JNbePJA0mewIlcqvIJQJxkB29tIEx4BLF0/vgQv7
         UseTdzeWgpXUJ2iQ7bnsx4bg6tOIC6j/1Ma1q24YANtTbDPeuvSKNTcAtd4yVJkD3qRf
         IcoSxerQGm35TP7X6isqpGkgNGTHt7Uf4dwrOtW/jgG3JUiVthrJQFLu2T9OOBhTN/iR
         wFwEj/+bkhX89kXAP/SDvSaIkxGOTuByy3Wlwx+vEbPbURaJ03br06r2zWVxX5jbhyPC
         zzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+0ZvBcKjmOSwrSdkGloKpQ9H3nxamEQCaD2KXxqLfY=;
        b=i5rKeWK7o5McKledMmTwvLatpcqJuRETUxEHnrZl0tQ5hLDPECbV67OBnEGastaacV
         qoBC05nZOKwjuVCegDDoU+rIFEeUOfxaKpYaa68DC3GYmj24kbbXHxJlZAqfAJ45kJ8y
         Y3FmY2/P3xWqo+9OW/Wte6iDhsxfkS/pvmZEHT140YZdF2b5uUYTYPFi/dnZSdovVQi5
         OFsJFynKrLBGp9SeYppGuTKKL/sDdFM25nmU6dt0crRd/fXyu9OHomvP347H0FQYYr6U
         WHUQFXmOs67vI4AncntILrcTeHUqSOepb8S8v0hbRjLkG7OEv8j30tiNV6pcU+yBT5vd
         jz7g==
X-Gm-Message-State: AOAM533hMfHxLCUWZyTdltJjv1LnQG4B/Iw54iiFYUZBiL+zUEwqw2kn
        aq7vVsTaUoLbTQIO0VqbCM2Anij8UaE=
X-Google-Smtp-Source: ABdhPJyBBuXBiPw9Hc0HUpfuJK9Ow56dHwfaER9Skz2FkBXnYXEyjaTX/rEzMZuSeOT+hSRSnuRS0Q==
X-Received: by 2002:a17:90b:3b86:b0:1e8:6b89:2bb2 with SMTP id pc6-20020a17090b3b8600b001e86b892bb2mr10368784pjb.15.1654526698723;
        Mon, 06 Jun 2022 07:44:58 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00163f8eb7eb3sm10945646pln.196.2022.06.06.07.44.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:58 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH V3 7/7] x86/entry: Implement the whole error_entry() as C code
Date:   Mon,  6 Jun 2022 22:45:09 +0800
Message-Id: <20220606144509.617611-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220606144509.617611-1-jiangshanlai@gmail.com>
References: <20220606144509.617611-1-jiangshanlai@gmail.com>
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

Implement error_entry() as C code in arch/x86/entry/entry64.c and
replace the ASM version of error_entry().

The code might be in the user CR3 and user GS base at the start of
the function so it calls __always_inline C function only until the GS
and CR3 is switched.

No functional change intended and comments are also copied.

The C version generally has better readability and easier to be
updated/improved.

Note:
To avoid using goto, the C code has two call sites of sync_regs().
It calls sync_regs() directly after fixup_bad_iret() returns while the
ASM code uses JMP instruction to jump to the start of the first call
site.

The complier uses tail-call-optimization for calling sync_regs().  It
uses "JMP sync_regs" while the ASM code uses "CALL+RET".

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry64.c     | 69 +++++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S    | 85 ++----------------------------------
 arch/x86/include/asm/proto.h |  1 +
 arch/x86/include/asm/traps.h |  1 +
 arch/x86/kernel/traps.c      |  2 -
 5 files changed, 74 insertions(+), 84 deletions(-)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index f7f23800cee4..bd047c329622 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -13,6 +13,8 @@
  */
 #include <asm/traps.h>
 
+extern unsigned char asm_load_gs_index_gs_change[];
+
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 static __always_inline void pti_switch_to_kernel_cr3(unsigned long user_cr3)
 {
@@ -66,3 +68,70 @@ static __always_inline void user_entry_swapgs_and_fence(void)
 	native_swapgs();
 	fence_swapgs_user_entry();
 }
+
+/*
+ * Put pt_regs onto the task stack and switch GS and CR3 if needed.
+ * The actual stack switch is done in entry_64.S.
+ *
+ * Be careful, it might be in the user CR3 and user GS base at the start
+ * of the function.
+ */
+asmlinkage __visible __entry_text
+struct pt_regs *error_entry(struct pt_regs *eregs)
+{
+	unsigned long iret_ip = (unsigned long)native_irq_return_iret;
+
+	if (user_mode(eregs)) {
+		/*
+		 * We entered from user mode.
+		 * Switch to kernel gsbase and CR3.
+		 */
+		user_entry_swapgs_and_fence();
+		switch_to_kernel_cr3();
+
+		/* Put pt_regs onto the task stack. */
+		return sync_regs(eregs);
+	}
+
+	/*
+	 * There are two places in the kernel that can potentially fault with
+	 * usergs. Handle them here.  B stepping K8s sometimes report a
+	 * truncated RIP for IRET exceptions returning to compat mode. Check
+	 * for these here too.
+	 */
+	if ((eregs->ip == iret_ip) || (eregs->ip == (unsigned int)iret_ip)) {
+		eregs->ip = iret_ip; /* Fix truncated RIP */
+
+		/*
+		 * We came from an IRET to user mode, so we have user
+		 * gsbase and CR3.  Switch to kernel gsbase and CR3:
+		 */
+		user_entry_swapgs_and_fence();
+		switch_to_kernel_cr3();
+
+		/*
+		 * Pretend that the exception came from user mode: set up
+		 * pt_regs as if we faulted immediately after IRET and then
+		 * put pt_regs onto the real task stack.
+		 */
+		return sync_regs(fixup_bad_iret(eregs));
+	}
+
+	/*
+	 * Hack: asm_load_gs_index_gs_change can fail with user gsbase.
+	 * If this happens, fix up gsbase and proceed.  We'll fix up the
+	 * exception and land in asm_load_gs_index_gs_change's error
+	 * handler with kernel gsbase.
+	 */
+	if (eregs->ip == (unsigned long)asm_load_gs_index_gs_change)
+		native_swapgs();
+
+	/*
+	 * Issue an LFENCE to prevent GS speculation, regardless of whether
+	 * it is a kernel or user gsbase.
+	 */
+	fence_swapgs_kernel_entry();
+
+	/* Enter from kernel, don't move pt_regs */
+	return eregs;
+}
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4300ba49b5ee..f8322398fe1c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -348,7 +348,7 @@ SYM_CODE_END(push_and_clear_regs)
 	 * own pvops for IRET and load_gs_index().  And it doesn't need to
 	 * switch the CR3.  So it can skip invoking error_entry().
 	 */
-	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+	ALTERNATIVE "movq %rsp, %rdi; call error_entry; movq %rax, %rsp", \
 		"", X86_FEATURE_XENPV
 
 	ENCODE_FRAME_POINTER
@@ -784,7 +784,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
-.Lgs_change:
+SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR // error_entry
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
@@ -805,7 +805,7 @@ SYM_FUNC_START(asm_load_gs_index)
 	movl	%eax, %gs
 	jmp	2b
 
-	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
+	_ASM_EXTABLE(asm_load_gs_index_gs_change, .Lbad_gs)
 
 SYM_FUNC_END(asm_load_gs_index)
 EXPORT_SYMBOL(asm_load_gs_index)
@@ -1012,85 +1012,6 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	jmp		restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
-/*
- * Switch GS and CR3 if needed.
- */
-SYM_CODE_START_LOCAL(error_entry)
-	UNWIND_HINT_FUNC
-	testb	$3, CS+8(%rsp)
-	jz	.Lerror_kernelspace
-
-	/*
-	 * We entered from user mode or we're pretending to have entered
-	 * from user mode due to an IRET fault.
-	 */
-	swapgs
-	FENCE_SWAPGS_USER_ENTRY
-	/* We have user CR3.  Change to kernel CR3. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-
-	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
-.Lerror_entry_from_usermode_after_swapgs:
-	/* Put us onto the real thread stack. */
-	call	sync_regs
-	RET
-
-	/*
-	 * There are two places in the kernel that can potentially fault with
-	 * usergs. Handle them here.  B stepping K8s sometimes report a
-	 * truncated RIP for IRET exceptions returning to compat mode. Check
-	 * for these here too.
-	 */
-.Lerror_kernelspace:
-	leaq	native_irq_return_iret(%rip), %rcx
-	cmpq	%rcx, RIP+8(%rsp)
-	je	.Lerror_bad_iret
-	movl	%ecx, %eax			/* zero extend */
-	cmpq	%rax, RIP+8(%rsp)
-	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
-	jne	.Lerror_entry_done_lfence
-
-	/*
-	 * hack: .Lgs_change can fail with user gsbase.  If this happens, fix up
-	 * gsbase and proceed.  We'll fix up the exception and land in
-	 * .Lgs_change's error handler with kernel gsbase.
-	 */
-	swapgs
-
-	/*
-	 * Issue an LFENCE to prevent GS speculation, regardless of whether it is a
-	 * kernel or user gsbase.
-	 */
-.Lerror_entry_done_lfence:
-	FENCE_SWAPGS_KERNEL_ENTRY
-	leaq	8(%rsp), %rax			/* return pt_regs pointer */
-	RET
-
-.Lbstep_iret:
-	/* Fix truncated RIP */
-	movq	%rcx, RIP+8(%rsp)
-	/* fall through */
-
-.Lerror_bad_iret:
-	/*
-	 * We came from an IRET to user mode, so we have user
-	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
-	 */
-	swapgs
-	FENCE_SWAPGS_USER_ENTRY
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-
-	/*
-	 * Pretend that the exception came from user mode: set up pt_regs
-	 * as if we faulted immediately after IRET.
-	 */
-	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
-	call	fixup_bad_iret
-	mov	%rax, %rdi
-	jmp	.Lerror_entry_from_usermode_after_swapgs
-SYM_CODE_END(error_entry)
-
 SYM_CODE_START_LOCAL(error_return)
 	UNWIND_HINT_REGS
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 12ef86b19910..199d27fbf903 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -15,6 +15,7 @@ void entry_SYSCALL_64(void);
 void entry_SYSCALL_64_safe_stack(void);
 void entry_SYSRETQ_unsafe_stack(void);
 void entry_SYSRETQ_end(void);
+extern unsigned char native_irq_return_iret[];
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 47ecfff2c83d..2d00100d3e03 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -14,6 +14,7 @@
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
+asmlinkage __visible notrace struct pt_regs *error_entry(struct pt_regs *eregs);
 void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d62b2cb85cea..f76a15f654c5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -436,8 +436,6 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 #endif
 
 #ifdef CONFIG_X86_ESPFIX64
-	extern unsigned char native_irq_return_iret[];
-
 	/*
 	 * If IRET takes a non-IST fault on the espfix64 stack, then we
 	 * end up promoting it to a doublefault.  In that case, take
-- 
2.19.1.6.gb485710b

