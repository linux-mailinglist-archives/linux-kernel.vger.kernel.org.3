Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31594BBE33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiBRRP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiBRRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C1B4C78F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LJfmDd84bAS0znmqb9Xaoa86tUE1V3+wlPu4qWBmX7s=; b=FfO/WJ22TlJeef5AItL8UePWdx
        qJbq4GaNTawEw+vU7t9Y/3/oRyCU4DPARIkt3ISGwoeyiflgfyYVsaBgsz2fNeppLuR/C+0dLo2GP
        /EEnMOGSxPhVYauxrEDkcdMLQAEn0bO56mqTrI1qJuArtys7T7QbwuYeQmJaIAhQOiuzCZTSSzdpB
        W5FkjXT38+E7w6qKy0ns2YX5mpZnRXqC+sWn4zxUECqpA1rNUhB9qCcuqEk13bebwEwmplGviHzhP
        pr2rzBvzflR3dDpPX3hB5gWgDL7h9z58u4nZn1pnjWSsOBMaUxfOhmibgvfORuuATgdEB7cE6WO+m
        u6n+5izw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6q9-00AsBQ-O7; Fri, 18 Feb 2022 17:14:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7A99300950;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1CAB82057EC72; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171408.984834165@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 07/29] x86/entry: Sprinkle ENDBR dust
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel entry points should be having ENDBR on for IBT configs.

The SYSCALL entry points are found through taking their respective
address in order to program them in the MSRs, while the exception
entry points are found through UNWIND_HINT_IRET_REGS.

*Except* that latter hint is also used on exit code to denote when
we're down to an IRET frame. As such add an additional 'entry'
argument to the macro and have it default to '1' such that objtool
will assume it's an entry and WARN about it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S           |   35 +++++++++++++++++++++--------------
 arch/x86/entry/entry_64_compat.S    |    3 +++
 arch/x86/include/asm/idtentry.h     |   23 +++++++++++++++--------
 arch/x86/include/asm/segment.h      |    5 +++++
 arch/x86/include/asm/unwind_hints.h |   18 +++++++++++++-----
 arch/x86/kernel/head_64.S           |   14 +++++++++-----
 arch/x86/kernel/idt.c               |    5 +++--
 arch/x86/kernel/unwind_orc.c        |    3 ++-
 include/linux/objtool.h             |    5 +++--
 tools/include/linux/objtool.h       |    5 +++--
 tools/objtool/check.c               |    3 ++-
 tools/objtool/orc_dump.c            |    3 ++-
 12 files changed, 81 insertions(+), 41 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -39,6 +39,7 @@
 #include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
 #include <asm/fsgsbase.h>
+#include <asm/ibt.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -87,6 +88,7 @@
 SYM_CODE_START(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
 
+	ENDBR
 	swapgs
 	/* tss.sp2 is scratch space. */
 	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
@@ -349,7 +351,8 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
+	UNWIND_HINT_IRET_REGS offset=\has_error_code*8 entry=1
+	ENDBR
 	ASM_CLAC
 
 	.if \has_error_code == 0
@@ -366,7 +369,7 @@ SYM_CODE_START(\asmsym)
 		.rept	6
 		pushq	5*8(%rsp)
 		.endr
-		UNWIND_HINT_IRET_REGS offset=8
+		UNWIND_HINT_IRET_REGS offset=8 entry=0
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
@@ -416,7 +419,8 @@ SYM_CODE_END(\asmsym)
  */
 .macro idtentry_mce_db vector asmsym cfunc
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=1
+	ENDBR
 	ASM_CLAC
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -471,7 +475,8 @@ SYM_CODE_END(\asmsym)
  */
 .macro idtentry_vc vector asmsym cfunc
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=1
+	ENDBR
 	ASM_CLAC
 
 	/*
@@ -532,7 +537,8 @@ SYM_CODE_END(\asmsym)
  */
 .macro idtentry_df vector asmsym cfunc
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS offset=8
+	UNWIND_HINT_IRET_REGS offset=8 entry=1
+	ENDBR
 	ASM_CLAC
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
@@ -629,7 +635,7 @@ SYM_INNER_LABEL(restore_regs_and_return_
 	INTERRUPT_RETURN
 
 SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=0
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
 	 * 64-bit mode SS:RSP on the exception stack is always valid.
@@ -706,7 +712,7 @@ SYM_INNER_LABEL(native_irq_return_iret,
 	popq	%rdi				/* Restore user RDI */
 
 	movq	%rax, %rsp
-	UNWIND_HINT_IRET_REGS offset=8
+	UNWIND_HINT_IRET_REGS offset=8 entry=0
 
 	/*
 	 * At this point, we cannot write to the stack any more, but we can
@@ -821,13 +827,13 @@ SYM_CODE_START(xen_failsafe_callback)
 	movq	8(%rsp), %r11
 	addq	$0x30, %rsp
 	pushq	$0				/* RIP */
-	UNWIND_HINT_IRET_REGS offset=8
+	UNWIND_HINT_IRET_REGS offset=8 entry=0
 	jmp	asm_exc_general_protection
 1:	/* Segment mismatch => Category 1 (Bad segment). Retry the IRET. */
 	movq	(%rsp), %rcx
 	movq	8(%rsp), %r11
 	addq	$0x30, %rsp
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=0
 	pushq	$-1 /* orig_ax = -1 => not a system call */
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
@@ -1062,7 +1068,8 @@ SYM_CODE_END(error_return)
  *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
 SYM_CODE_START(asm_exc_nmi)
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=1
+	ENDBR
 
 	/*
 	 * We allow breakpoints in NMIs. If a breakpoint occurs, then
@@ -1127,13 +1134,13 @@ SYM_CODE_START(asm_exc_nmi)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-	UNWIND_HINT_IRET_REGS base=%rdx offset=8
+	UNWIND_HINT_IRET_REGS base=%rdx offset=8 entry=0
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
 	pushq	3*8(%rdx)	/* pt_regs->flags */
 	pushq	2*8(%rdx)	/* pt_regs->cs */
 	pushq	1*8(%rdx)	/* pt_regs->rip */
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=0
 	pushq   $-1		/* pt_regs->orig_ax */
 	PUSH_AND_CLEAR_REGS rdx=(%rdx)
 	ENCODE_FRAME_POINTER
@@ -1289,7 +1296,7 @@ SYM_CODE_START(asm_exc_nmi)
 	.rept 5
 	pushq	11*8(%rsp)
 	.endr
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=0
 
 	/* Everything up to here is safe from nested NMIs */
 
@@ -1305,7 +1312,7 @@ SYM_CODE_START(asm_exc_nmi)
 	pushq	$__KERNEL_CS	/* CS */
 	pushq	$1f		/* RIP */
 	iretq			/* continues at repeat_nmi below */
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=0
 1:
 #endif
 
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -49,6 +49,7 @@
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
+	ENDBR
 	SWAPGS
 
 	pushq	%rax
@@ -198,6 +199,7 @@ SYM_CODE_END(entry_SYSENTER_compat)
  */
 SYM_CODE_START(entry_SYSCALL_compat)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	/* Interrupts are off on entry. */
 	swapgs
 
@@ -340,6 +342,7 @@ SYM_CODE_END(entry_SYSCALL_compat)
  */
 SYM_CODE_START(entry_INT80_compat)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	/*
 	 * Interrupts are off on entry.
 	 */
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -5,6 +5,12 @@
 /* Interrupts/Exceptions */
 #include <asm/trapnr.h>
 
+#ifdef CONFIG_X86_IBT
+#define IDT_ALIGN	16
+#else
+#define IDT_ALIGN	8
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/entry-common.h>
 #include <linux/hardirq.h>
@@ -492,33 +498,34 @@ __visible noinstr void func(struct pt_re
  * point is to mask off the bits above bit 7 because the push is sign
  * extending.
  */
-	.align 8
+
+	.align IDT_ALIGN
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept NR_EXTERNAL_VECTORS
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=1
 0 :
+	ENDBR
 	.byte	0x6a, vector
 	jmp	asm_common_interrupt
-	nop
 	/* Ensure that the above is 8 bytes max */
-	. = 0b + 8
+	.fill 0b + IDT_ALIGN - ., 1, 0x90
 	vector = vector+1
     .endr
 SYM_CODE_END(irq_entries_start)
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	.align 8
+	.align IDT_ALIGN
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
     .rept NR_SYSTEM_VECTORS
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=1
 0 :
+	ENDBR
 	.byte	0x6a, vector
 	jmp	asm_spurious_interrupt
-	nop
 	/* Ensure that the above is 8 bytes max */
-	. = 0b + 8
+	.fill 0b + IDT_ALIGN - ., 1, 0x90
 	vector = vector+1
     .endr
 SYM_CODE_END(spurious_entries_start)
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -4,6 +4,7 @@
 
 #include <linux/const.h>
 #include <asm/alternative.h>
+#include <asm/ibt.h>
 
 /*
  * Constructor for a conventional segment GDT (or LDT) entry.
@@ -275,7 +276,11 @@ static inline void vdso_read_cpunode(uns
  * vector has no error code (two bytes), a 'push $vector_number' (two
  * bytes), and a jump to the common entry code (up to five bytes).
  */
+#ifdef CONFIG_X86_IBT
+#define EARLY_IDT_HANDLER_SIZE 13
+#else
 #define EARLY_IDT_HANDLER_SIZE 9
+#endif
 
 /*
  * xen_early_idt_handler_array is for Xen pv guests: for each entry in
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -11,7 +11,7 @@
 	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL end=1
 .endm
 
-.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0
+.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0 entry=1
 	.if \base == %rsp
 		.if \indirect
 			.set sp_reg, ORC_REG_SP_INDIRECT
@@ -33,9 +33,17 @@
 	.set sp_offset, \offset
 
 	.if \partial
-		.set type, UNWIND_HINT_TYPE_REGS_PARTIAL
+		.if \entry
+		.set type, UNWIND_HINT_TYPE_REGS_ENTRY
+		.else
+		.set type, UNWIND_HINT_TYPE_REGS_EXIT
+		.endif
 	.elseif \extra == 0
-		.set type, UNWIND_HINT_TYPE_REGS_PARTIAL
+		.if \entry
+		.set type, UNWIND_HINT_TYPE_REGS_ENTRY
+		.else
+		.set type, UNWIND_HINT_TYPE_REGS_EXIT
+		.endif
 		.set sp_offset, \offset + (16*8)
 	.else
 		.set type, UNWIND_HINT_TYPE_REGS
@@ -44,8 +52,8 @@
 	UNWIND_HINT sp_reg=sp_reg sp_offset=sp_offset type=type
 .endm
 
-.macro UNWIND_HINT_IRET_REGS base=%rsp offset=0
-	UNWIND_HINT_REGS base=\base offset=\offset partial=1
+.macro UNWIND_HINT_IRET_REGS base=%rsp offset=0 entry=1
+	UNWIND_HINT_REGS base=\base offset=\offset partial=1 entry=\entry
 .endm
 
 .macro UNWIND_HINT_FUNC
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -25,6 +25,7 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/fixmap.h>
+#include <asm/ibt.h>
 
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
@@ -327,7 +328,8 @@ SYM_CODE_END(start_cpu0)
  * when .init.text is freed.
  */
 SYM_CODE_START_NOALIGN(vc_boot_ghcb)
-	UNWIND_HINT_IRET_REGS offset=8
+	UNWIND_HINT_IRET_REGS offset=8 entry=1
+	ENDBR
 
 	/* Build pt_regs */
 	PUSH_AND_CLEAR_REGS
@@ -371,18 +373,20 @@ SYM_CODE_START(early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	.if ((EXCEPTION_ERRCODE_MASK >> i) & 1) == 0
-		UNWIND_HINT_IRET_REGS
+		UNWIND_HINT_IRET_REGS entry=1
+		ENDBR
 		pushq $0	# Dummy error code, to make stack frame uniform
 	.else
-		UNWIND_HINT_IRET_REGS offset=8
+		UNWIND_HINT_IRET_REGS offset=8 entry=1
+		ENDBR
 	.endif
 	pushq $i		# 72(%rsp) Vector number
 	jmp early_idt_handler_common
-	UNWIND_HINT_IRET_REGS
+	UNWIND_HINT_IRET_REGS entry=0
 	i = i + 1
 	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
-	UNWIND_HINT_IRET_REGS offset=16
+	UNWIND_HINT_IRET_REGS offset=16 entry=0
 SYM_CODE_END(early_idt_handler_array)
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -10,6 +10,7 @@
 #include <asm/proto.h>
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
+#include <asm/idtentry.h>
 
 #define DPL0		0x0
 #define DPL3		0x3
@@ -272,7 +273,7 @@ void __init idt_setup_apic_and_irq_gates
 	idt_setup_from_table(idt_table, apic_idts, ARRAY_SIZE(apic_idts), true);
 
 	for_each_clear_bit_from(i, system_vectors, FIRST_SYSTEM_VECTOR) {
-		entry = irq_entries_start + 8 * (i - FIRST_EXTERNAL_VECTOR);
+		entry = irq_entries_start + IDT_ALIGN * (i - FIRST_EXTERNAL_VECTOR);
 		set_intr_gate(i, entry);
 	}
 
@@ -283,7 +284,7 @@ void __init idt_setup_apic_and_irq_gates
 		 * system_vectors bitmap. Otherwise they show up in
 		 * /proc/interrupts.
 		 */
-		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
+		entry = spurious_entries_start + IDT_ALIGN * (i - FIRST_SYSTEM_VECTOR);
 		set_intr_gate(i, entry);
 	}
 #endif
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -566,7 +566,8 @@ bool unwind_next_frame(struct unwind_sta
 		state->signal = true;
 		break;
 
-	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+	case UNWIND_HINT_TYPE_REGS_ENTRY:
+	case UNWIND_HINT_TYPE_REGS_EXIT:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn_current("can't access iret registers at %pB\n",
 					 (void *)orig_ip);
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -35,8 +35,9 @@ struct unwind_hint {
  */
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
-#define UNWIND_HINT_TYPE_REGS_PARTIAL	2
-#define UNWIND_HINT_TYPE_FUNC		3
+#define UNWIND_HINT_TYPE_REGS_ENTRY	2
+#define UNWIND_HINT_TYPE_REGS_EXIT	3
+#define UNWIND_HINT_TYPE_FUNC		4
 
 #ifdef CONFIG_STACK_VALIDATION
 
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -35,8 +35,9 @@ struct unwind_hint {
  */
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
-#define UNWIND_HINT_TYPE_REGS_PARTIAL	2
-#define UNWIND_HINT_TYPE_FUNC		3
+#define UNWIND_HINT_TYPE_REGS_ENTRY	2
+#define UNWIND_HINT_TYPE_REGS_EXIT	3
+#define UNWIND_HINT_TYPE_FUNC		4
 
 #ifdef CONFIG_STACK_VALIDATION
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2312,7 +2312,8 @@ static int update_cfi_state(struct instr
 	}
 
 	if (cfi->type == UNWIND_HINT_TYPE_REGS ||
-	    cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL)
+	    cfi->type == UNWIND_HINT_TYPE_REGS_ENTRY ||
+	    cfi->type == UNWIND_HINT_TYPE_REGS_EXIT)
 		return update_cfi_state_regs(insn, cfi, op);
 
 	switch (op->dest.type) {
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -43,7 +43,8 @@ static const char *orc_type_name(unsigne
 		return "call";
 	case UNWIND_HINT_TYPE_REGS:
 		return "regs";
-	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+	case UNWIND_HINT_TYPE_REGS_ENTRY:
+	case UNWIND_HINT_TYPE_REGS_EXIT:
 		return "regs (partial)";
 	default:
 		return "?";


