Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2182528529
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiEPNRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243901AbiEPNRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:17:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253983A5FC
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m12so14412272plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNLH3g4oey3zSyxe+H2t8uP9EGdvCmwPMhX5Etl/GJY=;
        b=bgkcSbE/jBQG8HN5gGcom2Ik6rP6OVJC4RgHkF7II5JVJiPATV/HQmgqNfKHLF4Dkx
         QJn+cchJ205TcH/0sbKhn5diZ7r9Qbzw7JwurPgcIGj1Oc4sFdJmScHL9xvimbVscmyh
         VqEIg97hB9V0JlfNCyw7kfa5cSRFAM64yibQvhdFCaSEg/buIgf3mKqf/IEFoI64ygO6
         zW8YuN0/Rk/Kva310hsf0HOkYqfs8c2G1yIkAIuNqRal2AeCW9C11ZXNUpp5WplhlrB2
         LXzARbhUnbEpx8+euVtpVFAd8rp2Qz357/cvuBjkqGz3ZfQQcxh6h6CtjNhkxM8KEht5
         JEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNLH3g4oey3zSyxe+H2t8uP9EGdvCmwPMhX5Etl/GJY=;
        b=AbCefHk5BEwvfqpwG+VJD83JsVegNY5TClsv8B73bLm8L3/D+/cJFnHFvlms3VG422
         4heOK0A6QeFXVD3Eh/Fn+7gOamEioX0cno4A8pFRY2Es4MWOAz/A5OcAdR1osjLukF2T
         DoETIMibMXhUM1ySrDrPwvCvuj8zWMbLPaAneEQEpuBg0NpEGqB6iVE5LRJfc6Wtft+6
         KHz4jscZBkW25FBkYjm0biReTjwPuEiE8eKVj0egkthMjNTzshT5Uz5ni+8wLbozTEtp
         DDTg8DpHzbOC66Iknrnd+ussPMQGN/ldJZyeHHGLGho8J+wFZnAHM4bkAfy48Cjhdeom
         3I4w==
X-Gm-Message-State: AOAM533XD8IsUDcbRY4aOQ5iS8CIxaaVvkH7GolIbg3yaB3wgIFPFQ5v
        6aUJNBHcvTL09vyGdULjaudWU2U48GM=
X-Google-Smtp-Source: ABdhPJwd4yznxcfDwX53COSduv50H7QUd0+1h/DL78zPEmBWOIdRQ8vYCvjr7Z+rAZDtkvRpUHhkRg==
X-Received: by 2002:a17:903:2042:b0:161:53e9:c7b7 with SMTP id q2-20020a170903204200b0016153e9c7b7mr10510701pla.122.1652707050974;
        Mon, 16 May 2022 06:17:30 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090302d100b0015e8d4eb243sm7006029plk.141.2022.05.16.06.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 06:17:30 -0700 (PDT)
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
Subject: [PATCH V2 7/7] x86/entry: Implement the whole error_entry() as C code
Date:   Mon, 16 May 2022 21:17:38 +0800
Message-Id: <20220516131739.521817-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220516131739.521817-1-jiangshanlai@gmail.com>
References: <20220516131739.521817-1-jiangshanlai@gmail.com>
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
index 3a1e3f215617..b678189b029e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -343,7 +343,7 @@ SYM_CODE_END(push_and_clear_regs)
 	 * own pvops for IRET and load_gs_index().  And it doesn't need to
 	 * switch the CR3.  So it can skip invoking error_entry().
 	 */
-	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+	ALTERNATIVE "movq %rsp, %rdi; call error_entry; movq %rax, %rsp", \
 		"", X86_FEATURE_XENPV
 
 	ENCODE_FRAME_POINTER
@@ -778,7 +778,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
-.Lgs_change:
+SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR // error_entry
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
@@ -799,7 +799,7 @@ SYM_FUNC_START(asm_load_gs_index)
 	movl	%eax, %gs
 	jmp	2b
 
-	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
+	_ASM_EXTABLE(asm_load_gs_index_gs_change, .Lbad_gs)
 
 SYM_FUNC_END(asm_load_gs_index)
 EXPORT_SYMBOL(asm_load_gs_index)
@@ -1006,85 +1006,6 @@ SYM_CODE_START_LOCAL(paranoid_exit)
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
index 0f899c8d7a4e..95d6d3a53cd5 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -13,6 +13,7 @@ void syscall_init(void);
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
 void entry_SYSCALL_64_safe_stack(void);
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

