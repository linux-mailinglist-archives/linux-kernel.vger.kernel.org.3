Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF424BCB1B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 00:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbiBSXJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 18:09:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242187AbiBSXJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 18:09:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0B53B7A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 15:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/tQAYD5kmh9/A1otJ3uja+9tCJr92P8ew/FKBbxP4r8=; b=Z82fdHxoh5pLfb9BnQR24fSkkm
        tTF4lZqLHGFKYt7DDPvmX4XInlxz7+ex2M5aw6jmYn6uw1SyjQ5LB+yGWmS/0QtR4GsFHd+NHuPhp
        tPfweGfcIK4cVXOad5k6F7926L3qJlkzHdjCWQMHEb8NWp2C6jvn1/KTEihKeQAVKCYP9wtcPFhT2
        b0082R5oeyvlB1jyYiMV+bZl/yp5z7g5CqKuxNKWXxMDudNnullJENdboMskhXd+sb4EJmWO1ycAT
        o3jCKehe+9clmL7Nmhz52gFlk7gNmAX6WF83ZXXa8EYDT+7qX7MzDM97gfW2/J1E04b6aJpSAwmfS
        avTYadFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLYqG-000PhO-0o; Sat, 19 Feb 2022 23:08:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4196330022D;
        Sun, 20 Feb 2022 00:08:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD536203DD1DA; Sun, 20 Feb 2022 00:08:37 +0100 (CET)
Date:   Sun, 20 Feb 2022 00:08:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 07/29] x86/entry: Sprinkle ENDBR dust
Message-ID: <YhF4da/oHQ4nDyPM@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.984834165@infradead.org>
 <20220219002338.khiqptqukabfdvy2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219002338.khiqptqukabfdvy2@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 04:23:38PM -0800, Josh Poimboeuf wrote:
> Another possibly better and less intrusive way of doing this would be
> for objtool to realize that any UNWIND_HINT_IRET_REGS at the beginning
> of a SYM_CODE_START (global non-function code symbol) needs ENDBR.

This; I likes that. I reverted this patch from the tree (very much
including the annotations), redid the objtool check and regenerated the
missing ENDBR given the objtool output.

I think the few missing ENDBRs in this are due to using x86_64-defconfig
instead of allmodconfig. I'll try on monday after spooling up a real
build machine :-)

---
 arch/x86/entry/entry_64.S           | 32 +++++++++++++++-----------------
 arch/x86/entry/entry_64_compat.S    |  3 +--
 arch/x86/include/asm/idtentry.h     | 19 +++++++------------
 arch/x86/include/asm/segment.h      |  7 +------
 arch/x86/include/asm/unwind_hints.h | 18 +++++-------------
 arch/x86/kernel/head_64.S           | 13 ++++++-------
 arch/x86/kernel/unwind_orc.c        |  3 +--
 include/linux/objtool.h             |  5 ++---
 tools/include/linux/objtool.h       |  5 ++---
 tools/objtool/check.c               | 13 ++++++++-----
 tools/objtool/orc_dump.c            |  3 +--
 11 files changed, 49 insertions(+), 72 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 77e222f2061e..d69239c638a2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -39,7 +39,6 @@
 #include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
 #include <asm/fsgsbase.h>
-#include <asm/ibt.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -87,8 +86,8 @@
 
 SYM_CODE_START(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
-
 	ENDBR
+
 	swapgs
 	/* tss.sp2 is scratch space. */
 	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
@@ -353,7 +352,7 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS offset=\has_error_code*8 entry=1
+	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ENDBR
 	ASM_CLAC
 
@@ -371,7 +370,7 @@ SYM_CODE_START(\asmsym)
 		.rept	6
 		pushq	5*8(%rsp)
 		.endr
-		UNWIND_HINT_IRET_REGS offset=8 entry=0
+		UNWIND_HINT_IRET_REGS offset=8
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
@@ -421,7 +420,7 @@ SYM_CODE_END(\asmsym)
  */
 .macro idtentry_mce_db vector asmsym cfunc
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS entry=1
+	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
 
@@ -477,7 +476,7 @@ SYM_CODE_END(\asmsym)
  */
 .macro idtentry_vc vector asmsym cfunc
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS entry=1
+	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
 
@@ -539,7 +538,7 @@ SYM_CODE_END(\asmsym)
  */
 .macro idtentry_df vector asmsym cfunc
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS offset=8 entry=1
+	UNWIND_HINT_IRET_REGS offset=8
 	ENDBR
 	ASM_CLAC
 
@@ -641,8 +640,7 @@ SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 	INTERRUPT_RETURN
 
 SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
-	UNWIND_HINT_IRET_REGS entry=0
-	ENDBR // paravirt_iret
+	UNWIND_HINT_IRET_REGS
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
 	 * 64-bit mode SS:RSP on the exception stack is always valid.
@@ -720,7 +718,7 @@ SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
 	popq	%rdi				/* Restore user RDI */
 
 	movq	%rax, %rsp
-	UNWIND_HINT_IRET_REGS offset=8 entry=0
+	UNWIND_HINT_IRET_REGS offset=8
 
 	/*
 	 * At this point, we cannot write to the stack any more, but we can
@@ -837,13 +835,13 @@ SYM_CODE_START(xen_failsafe_callback)
 	movq	8(%rsp), %r11
 	addq	$0x30, %rsp
 	pushq	$0				/* RIP */
-	UNWIND_HINT_IRET_REGS offset=8 entry=0
+	UNWIND_HINT_IRET_REGS offset=8
 	jmp	asm_exc_general_protection
 1:	/* Segment mismatch => Category 1 (Bad segment). Retry the IRET. */
 	movq	(%rsp), %rcx
 	movq	8(%rsp), %r11
 	addq	$0x30, %rsp
-	UNWIND_HINT_IRET_REGS entry=0
+	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
@@ -1078,7 +1076,7 @@ SYM_CODE_END(error_return)
  *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
 SYM_CODE_START(asm_exc_nmi)
-	UNWIND_HINT_IRET_REGS entry=1
+	UNWIND_HINT_IRET_REGS
 	ENDBR
 
 	/*
@@ -1144,13 +1142,13 @@ SYM_CODE_START(asm_exc_nmi)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-	UNWIND_HINT_IRET_REGS base=%rdx offset=8 entry=0
+	UNWIND_HINT_IRET_REGS base=%rdx offset=8
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
 	pushq	3*8(%rdx)	/* pt_regs->flags */
 	pushq	2*8(%rdx)	/* pt_regs->cs */
 	pushq	1*8(%rdx)	/* pt_regs->rip */
-	UNWIND_HINT_IRET_REGS entry=0
+	UNWIND_HINT_IRET_REGS
 	pushq   $-1		/* pt_regs->orig_ax */
 	PUSH_AND_CLEAR_REGS rdx=(%rdx)
 	ENCODE_FRAME_POINTER
@@ -1306,7 +1304,7 @@ SYM_CODE_START(asm_exc_nmi)
 	.rept 5
 	pushq	11*8(%rsp)
 	.endr
-	UNWIND_HINT_IRET_REGS entry=0
+	UNWIND_HINT_IRET_REGS
 
 	/* Everything up to here is safe from nested NMIs */
 
@@ -1322,7 +1320,7 @@ SYM_CODE_START(asm_exc_nmi)
 	pushq	$__KERNEL_CS	/* CS */
 	pushq	$1f		/* RIP */
 	iretq			/* continues at repeat_nmi below */
-	UNWIND_HINT_IRET_REGS entry=0
+	UNWIND_HINT_IRET_REGS
 1:
 #endif
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 316e0fa119b4..86caf7872a25 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -48,8 +48,8 @@
  */
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
-	/* Interrupts are off on entry. */
 	ENDBR
+	/* Interrupts are off on entry. */
 	SWAPGS
 
 	pushq	%rax
@@ -344,7 +344,6 @@ SYM_CODE_END(entry_SYSCALL_compat)
  */
 SYM_CODE_START(entry_INT80_compat)
 	UNWIND_HINT_EMPTY
-	ENDBR
 	/*
 	 * Interrupts are off on entry.
 	 */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 9127e1e3c439..1157ee6f98d7 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -5,11 +5,7 @@
 /* Interrupts/Exceptions */
 #include <asm/trapnr.h>
 
-#ifdef CONFIG_X86_IBT
-#define IDT_ALIGN	16
-#else
-#define IDT_ALIGN	8
-#endif
+#define IDT_ALIGN	(8 * (1 + IS_ENABLED(CONFIG_X86_IBT)))
 
 #ifndef __ASSEMBLY__
 #include <linux/entry-common.h>
@@ -486,7 +482,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 
 /*
  * ASM code to emit the common vector entry stubs where each stub is
- * packed into 8 bytes.
+ * packed into IDT_ALIGN bytes.
  *
  * Note, that the 'pushq imm8' is emitted via '.byte 0x6a, vector' because
  * GCC treats the local vector variable as unsigned int and would expand
@@ -498,17 +494,16 @@ __visible noinstr void func(struct pt_regs *regs,			\
  * point is to mask off the bits above bit 7 because the push is sign
  * extending.
  */
-
 	.align IDT_ALIGN
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept NR_EXTERNAL_VECTORS
-	UNWIND_HINT_IRET_REGS entry=1
-0 :
+	UNWIND_HINT_IRET_REGS
 	ENDBR
+0 :
 	.byte	0x6a, vector
 	jmp	asm_common_interrupt
-	/* Ensure that the above is 8 bytes max */
+	/* Ensure that the above is IDT_ALIGN bytes max */
 	.fill 0b + IDT_ALIGN - ., 1, 0x90
 	vector = vector+1
     .endr
@@ -519,12 +514,12 @@ SYM_CODE_END(irq_entries_start)
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
     .rept NR_SYSTEM_VECTORS
-	UNWIND_HINT_IRET_REGS entry=1
+	UNWIND_HINT_IRET_REGS
 0 :
 	ENDBR
 	.byte	0x6a, vector
 	jmp	asm_spurious_interrupt
-	/* Ensure that the above is 8 bytes max */
+	/* Ensure that the above is IDT_ALIGN bytes max */
 	.fill 0b + IDT_ALIGN - ., 1, 0x90
 	vector = vector+1
     .endr
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 6a8a5bcbf14d..3a09647788bd 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -4,7 +4,6 @@
 
 #include <linux/const.h>
 #include <asm/alternative.h>
-#include <asm/ibt.h>
 
 /*
  * Constructor for a conventional segment GDT (or LDT) entry.
@@ -276,11 +275,7 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
  * vector has no error code (two bytes), a 'push $vector_number' (two
  * bytes), and a jump to the common entry code (up to five bytes).
  */
-#ifdef CONFIG_X86_IBT
-#define EARLY_IDT_HANDLER_SIZE 13
-#else
-#define EARLY_IDT_HANDLER_SIZE 9
-#endif
+#define EARLY_IDT_HANDLER_SIZE (9 + 4*IS_ENABLED(CONFIG_X86_IBT))
 
 /*
  * xen_early_idt_handler_array is for Xen pv guests: for each entry in
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index d5b401c2f9e9..8b33674288ea 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -11,7 +11,7 @@
 	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL end=1
 .endm
 
-.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0 entry=1
+.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0
 	.if \base == %rsp
 		.if \indirect
 			.set sp_reg, ORC_REG_SP_INDIRECT
@@ -33,17 +33,9 @@
 	.set sp_offset, \offset
 
 	.if \partial
-		.if \entry
-		.set type, UNWIND_HINT_TYPE_REGS_ENTRY
-		.else
-		.set type, UNWIND_HINT_TYPE_REGS_EXIT
-		.endif
+		.set type, UNWIND_HINT_TYPE_REGS_PARTIAL
 	.elseif \extra == 0
-		.if \entry
-		.set type, UNWIND_HINT_TYPE_REGS_ENTRY
-		.else
-		.set type, UNWIND_HINT_TYPE_REGS_EXIT
-		.endif
+		.set type, UNWIND_HINT_TYPE_REGS_PARTIAL
 		.set sp_offset, \offset + (16*8)
 	.else
 		.set type, UNWIND_HINT_TYPE_REGS
@@ -52,8 +44,8 @@
 	UNWIND_HINT sp_reg=sp_reg sp_offset=sp_offset type=type
 .endm
 
-.macro UNWIND_HINT_IRET_REGS base=%rsp offset=0 entry=1
-	UNWIND_HINT_REGS base=\base offset=\offset partial=1 entry=\entry
+.macro UNWIND_HINT_IRET_REGS base=%rsp offset=0
+	UNWIND_HINT_REGS base=\base offset=\offset partial=1
 .endm
 
 .macro UNWIND_HINT_FUNC
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 92e759ae9030..816bc70c9e71 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -25,7 +25,6 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/fixmap.h>
-#include <asm/ibt.h>
 
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
@@ -332,8 +331,7 @@ SYM_CODE_END(start_cpu0)
  * when .init.text is freed.
  */
 SYM_CODE_START_NOALIGN(vc_boot_ghcb)
-	UNWIND_HINT_IRET_REGS offset=8 entry=1
-	ENDBR
+	UNWIND_HINT_IRET_REGS offset=8
 
 	/* Build pt_regs */
 	PUSH_AND_CLEAR_REGS
@@ -377,24 +375,25 @@ SYM_CODE_START(early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	.if ((EXCEPTION_ERRCODE_MASK >> i) & 1) == 0
-		UNWIND_HINT_IRET_REGS entry=1
+		UNWIND_HINT_IRET_REGS
 		ENDBR
 		pushq $0	# Dummy error code, to make stack frame uniform
 	.else
-		UNWIND_HINT_IRET_REGS offset=8 entry=1
+		UNWIND_HINT_IRET_REGS offset=8
 		ENDBR
 	.endif
 	pushq $i		# 72(%rsp) Vector number
 	jmp early_idt_handler_common
-	UNWIND_HINT_IRET_REGS entry=0
+	UNWIND_HINT_IRET_REGS
 	i = i + 1
 	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
-	UNWIND_HINT_IRET_REGS offset=16 entry=0
 SYM_CODE_END(early_idt_handler_array)
 	ANNOTATE_NOENDBR // early_idt_handler_array[NUM_EXCEPTION_VECTORS]
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
+	UNWIND_HINT_IRET_REGS offset=16
+	ANNOTATE_NOENDBR
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index fbf112c5485c..2de3c8c5eba9 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -566,8 +566,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->signal = true;
 		break;
 
-	case UNWIND_HINT_TYPE_REGS_ENTRY:
-	case UNWIND_HINT_TYPE_REGS_EXIT:
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn_current("can't access iret registers at %pB\n",
 					 (void *)orig_ip);
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 5281e02c2326..fd9d90ec0e48 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -35,9 +35,8 @@ struct unwind_hint {
  */
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
-#define UNWIND_HINT_TYPE_REGS_ENTRY	2
-#define UNWIND_HINT_TYPE_REGS_EXIT	3
-#define UNWIND_HINT_TYPE_FUNC		4
+#define UNWIND_HINT_TYPE_REGS_PARTIAL	2
+#define UNWIND_HINT_TYPE_FUNC		3
 
 #ifdef CONFIG_STACK_VALIDATION
 
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index c48d45733071..aca52db2f3f3 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -35,9 +35,8 @@ struct unwind_hint {
  */
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
-#define UNWIND_HINT_TYPE_REGS_ENTRY	2
-#define UNWIND_HINT_TYPE_REGS_EXIT	3
-#define UNWIND_HINT_TYPE_FUNC		4
+#define UNWIND_HINT_TYPE_REGS_PARTIAL	2
+#define UNWIND_HINT_TYPE_FUNC		3
 
 #ifdef CONFIG_STACK_VALIDATION
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 414c8a1dd868..5db0f66ab8fe 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2488,8 +2488,7 @@ static int update_cfi_state(struct instruction *insn,
 	}
 
 	if (cfi->type == UNWIND_HINT_TYPE_REGS ||
-	    cfi->type == UNWIND_HINT_TYPE_REGS_ENTRY ||
-	    cfi->type == UNWIND_HINT_TYPE_REGS_EXIT)
+	    cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL)
 		return update_cfi_state_regs(insn, cfi, op);
 
 	switch (op->dest.type) {
@@ -3254,9 +3253,13 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (insn->hint) {
 			state.cfi = *insn->cfi;
 			if (ibt) {
-				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_ENTRY &&
-				    insn->type != INSN_ENDBR) {
-					WARN_FUNC("IRET_ENTRY hint without ENDBR", insn->sec, insn->offset);
+				struct symbol *sym;
+				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL &&
+				    (sym = find_symbol_by_offset(insn->sec, insn->offset)) &&
+				    insn->type != INSN_ENDBR && !insn->noendbr) {
+					WARN_FUNC("IRET_REGS hint without ENDBR: %s",
+						  insn->sec, insn->offset,
+						  sym->name);
 				}
 			}
 		} else {
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 145cef3535c2..f5a8508c42d6 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -43,8 +43,7 @@ static const char *orc_type_name(unsigned int type)
 		return "call";
 	case UNWIND_HINT_TYPE_REGS:
 		return "regs";
-	case UNWIND_HINT_TYPE_REGS_ENTRY:
-	case UNWIND_HINT_TYPE_REGS_EXIT:
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
 		return "regs (partial)";
 	default:
 		return "?";
