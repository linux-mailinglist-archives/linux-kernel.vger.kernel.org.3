Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20B7522D53
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiEKH2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbiEKH2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:28:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E843D1D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:28:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q18so1036387pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHFue09oINs+4LzVLRKmbmRrup/wwfhBquOsUuiiMnU=;
        b=f/rDUu0tPk4KejNi66lkkTJPUcBlNH56UeIjuFAsi+OH+iZxeubS3jYeHroGNS8z6c
         PiQ6TeKU0Iu3of5PQA0GmQOVTofq+nnAaqwj6h/QFWNjhksSs2y80Q3pUS6PXLOTQN1j
         tvqOuxoy2vVuaWULcfYV62wuCkzmBkvDujN+3D20KuP/uZC7N1Mq0Naf71Br5mtfK1UW
         /IvG5TNsjiQu3meH8ceTeyzC7Ga4HS4bEyFtAzUrbFKpXLvtWqOv3er2SEyIsZhgE69J
         iE7TmBoRRn10S6eLScrOuGUpq6QrNuLZi3PCYwsFiJ0y6NBuVnoD5zySCfGWD2drkn3h
         sL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHFue09oINs+4LzVLRKmbmRrup/wwfhBquOsUuiiMnU=;
        b=QMa1k/s/fi5Mnb2CDFd7yq5vZ+eobgri2i0wZUOMmJwCctmAyL626Wi3TYS4tSPx7P
         P6EmrZIOkmao0G76+n08QfZCvCMIzNN3qrsICPaU9UIIl0DCTIIk5ZbunO62nI6ZfvbD
         gvFZIgW/POGqFaL7e2b0l7BISUxayf6gagRswK9lTefb/YkE0/xJ7C0EpejvDQe2VskF
         4QzUQYuFM6tkt2NK1GP4McuQKTrJeGs/grcQDkwMajajTSnicCluoQeSOaktEpO1QW01
         p+e7sS91Z1r1DoO5N8V3NbMpJidwT4/gepREorzuE4x4jmpaiRwkPPiEucw+jQxvCuTC
         8dxQ==
X-Gm-Message-State: AOAM533+tiaaawVeT4B2/A7l5G95RlER+TsjjlEzknZLYBDtD7d8F1LS
        dqkpU0zOwKSm0RRcfI+DEWHXADXzZPU=
X-Google-Smtp-Source: ABdhPJwuVwnK3M4Qo4WYSourzS04CVOJP9/isTTnVIlJWEfmLeABaS5kh7+J3rPc45Of3qnolpy63Q==
X-Received: by 2002:a17:903:1c6:b0:15e:c623:b543 with SMTP id e6-20020a17090301c600b0015ec623b543mr24372321plh.147.1652254088030;
        Wed, 11 May 2022 00:28:08 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id bb9-20020a170902bc8900b0015f2d549b46sm930309plb.237.2022.05.11.00.28.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 00:28:07 -0700 (PDT)
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
Subject: [PATCH 7/7] x86/entry: Implement the whole error_entry() as C code
Date:   Wed, 11 May 2022 15:27:47 +0800
Message-Id: <20220511072747.3960-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220511072747.3960-1-jiangshanlai@gmail.com>
References: <20220511072747.3960-1-jiangshanlai@gmail.com>
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

