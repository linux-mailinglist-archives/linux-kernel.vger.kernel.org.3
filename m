Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E3E4D9963
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347553AbiCOKrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347299AbiCOKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A2F50B3E;
        Tue, 15 Mar 2022 03:44:10 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swCwTecdJGT/ErUWecWBJRxuFrh4IhAg4ne1JoRBZ1g=;
        b=0ruPAJ9sbeAidylDi9c0+bv02ILybBgOgGfoGf1fhHFYjrpFfvojkak25F2+mP9D8cDKXn
        QqpZw2vDz+Dv7VkuHVFJqnovx/eUS2govxWTvRsCcQw4KDicVcWRMYSQQXqv54ymIYgwR3
        70+A74d2YTcESh4v7M5BfNg5n2MU3rsrXP6v564FstMgSE4OZaAPUpqD5X/911pSs68E/y
        GWDzkREg+daabr1CvYaVsHm/91qpgF7pT6eWnteAviPtwH6j3l3DD93uaQfgzDUDXM0+jg
        +IU2bc0dH2VmOrkSeaGCmlvPMhGmLr1SFC9ebEh5/00P2cnhx3OAV5qFxEnmBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swCwTecdJGT/ErUWecWBJRxuFrh4IhAg4ne1JoRBZ1g=;
        b=QwMhDB+mjndoxNZ8YuFWvgFdU+Bk4rwwMInomqM1ER6bvJCQZ1ArY+ds2BKb14UVTwh9Ei
        awyjb1bwoZA8daCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,xen: Sprinkle the ENDBR
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.873919996@infradead.org>
References: <20220308154317.873919996@infradead.org>
MIME-Version: 1.0
Message-ID: <164734104815.16921.5125419048077994442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5b2fc51576eff811a614e33cbbd0c3cb05022892
Gitweb:        https://git.kernel.org/tip/5b2fc51576eff811a614e33cbbd0c3cb05022892
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:35 +01:00

x86/ibt,xen: Sprinkle the ENDBR

Even though Xen currently doesn't advertise IBT, prepare for when it
will eventually do so and sprinkle the ENDBR dust accordingly.

Even though most of the entry points are IRET like, the CPL0
Hypervisor can set WAIT-FOR-ENDBR and demand ENDBR at these sites.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.873919996@infradead.org
---
 arch/x86/entry/entry_64.S      |  1 +
 arch/x86/include/asm/segment.h |  2 +-
 arch/x86/kernel/head_64.S      |  1 +
 arch/x86/xen/enlighten_pv.c    |  3 +++
 arch/x86/xen/xen-asm.S         |  9 +++++++++
 arch/x86/xen/xen-head.S        |  9 +++++++--
 6 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f731393..3fd3828 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -809,6 +809,7 @@ SYM_CODE_END(exc_xen_hypervisor_callback)
  */
 SYM_CODE_START(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	movl	%ds, %ecx
 	cmpw	%cx, 0x10(%rsp)
 	jne	1f
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index b228c9d..3a31d4e 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -283,7 +283,7 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
  * pop %rcx; pop %r11; jmp early_idt_handler_array[i]; summing up to
  * max 8 bytes.
  */
-#define XEN_EARLY_IDT_HANDLER_SIZE 8
+#define XEN_EARLY_IDT_HANDLER_SIZE (8 + ENDBR_INSN_SIZE)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 023761c..990960a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -383,6 +383,7 @@ SYM_CODE_START(early_idt_handler_array)
 	.endr
 	UNWIND_HINT_IRET_REGS offset=16
 SYM_CODE_END(early_idt_handler_array)
+	ANNOTATE_NOENDBR // early_idt_handler_array[NUM_EXCEPTION_VECTORS]
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 3c7a55c..5038edb 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -624,6 +624,9 @@ static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	TRAP_ENTRY(exc_alignment_check,			false ),
 	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
+#ifdef CONFIG_X86_KERNEL_IBT
+	TRAP_ENTRY(exc_control_protection,		false ),
+#endif
 };
 
 static bool __ref get_trap_addr(void **addr, unsigned int ist)
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index ee17b94..caa9bc2 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -122,6 +122,7 @@ SYM_FUNC_END(xen_read_cr2_direct);
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	pop %rcx
 	pop %r11
 	jmp  \name
@@ -147,6 +148,9 @@ xen_pv_trap asm_exc_page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
+#ifdef CONFIG_X86_KERNEL_IBT
+xen_pv_trap asm_exc_control_protection
+#endif
 #ifdef CONFIG_X86_MCE
 xen_pv_trap asm_xenpv_exc_machine_check
 #endif /* CONFIG_X86_MCE */
@@ -162,6 +166,7 @@ SYM_CODE_START(xen_early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	UNWIND_HINT_EMPTY
+	ENDBR
 	pop %rcx
 	pop %r11
 	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
@@ -231,6 +236,7 @@ SYM_CODE_END(xenpv_restore_regs_and_return_to_usermode)
 /* Normal 64-bit system call target */
 SYM_CODE_START(xen_syscall_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	popq %rcx
 	popq %r11
 
@@ -250,6 +256,7 @@ SYM_CODE_END(xen_syscall_target)
 /* 32-bit compat syscall target */
 SYM_CODE_START(xen_syscall32_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	popq %rcx
 	popq %r11
 
@@ -267,6 +274,7 @@ SYM_CODE_END(xen_syscall32_target)
 /* 32-bit compat sysenter target */
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	/*
 	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
 	 * that we don't need to guard against single step exceptions here.
@@ -290,6 +298,7 @@ SYM_CODE_END(xen_sysenter_target)
 SYM_CODE_START(xen_syscall32_target)
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 11d2865..ac17196 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -25,8 +25,12 @@
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_FUNC
-		.skip 31, 0x90
-		RET
+		ANNOTATE_NOENDBR
+		ret
+		/*
+		 * Xen will write the hypercall page, and sort out ENDBR.
+		 */
+		.skip 31, 0xcc
 	.endr
 
 #define HYPERCALL(n) \
@@ -74,6 +78,7 @@ SYM_CODE_END(startup_xen)
 .pushsection .text
 SYM_CODE_START(asm_cpu_bringup_and_idle)
 	UNWIND_HINT_EMPTY
+	ENDBR
 
 	call cpu_bringup_and_idle
 SYM_CODE_END(asm_cpu_bringup_and_idle)
