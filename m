Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5C4C2F61
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiBXPUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiBXPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991F8160FE5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OlG3tUtrNpkbjURpfEKmheQ7nlqCyiaKmrdK+ymPIvg=; b=e2B6cdgm1hVGwidAS872CwqUFN
        BjMzBvLRzskvJuXAXlU+5G7d8TKtjPlbCGvr4xNAM0jDD8KbXmH/Ptg9judbdbtpbYihGY470SuE/
        xJ9hu3CsGj9CtzN7GTYogvyGrLu6vXWz6wNTNys4fEWYm8IAzNa57UqgXHst7dCs5S2wOCGodrHsv
        VvCq1oQwqCWWh6EtRg01btbiavdrza8pDjzpJqqRypoueISoaWL35snvOse3WBQZ7y6VNlzmn1c2o
        ZR2stZoTVp8F4izQwE1Ojk687FpD6qx4EEB6B++I7SxvG+4Qz3y2Q0l9Nyc9CDvIAK1UCn0Qli6/B
        meABnSmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-00CeLb-6N; Thu, 24 Feb 2022 15:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 263AD300C1E;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 38DD629E75E55; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.423131356@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 07/39] x86/entry: Sprinkle ENDBR dust
References: <20220224145138.952963315@infradead.org>
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

The rule is that any UNWIND_HINT_IRET_REGS at sym+0 should have an
ENDBR, see the later objtool ibt validation patch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S        |    6 ++++++
 arch/x86/entry/entry_64_compat.S |    3 +++
 arch/x86/include/asm/idtentry.h  |   20 +++++++++++---------
 arch/x86/include/asm/segment.h   |    2 +-
 arch/x86/kernel/head_64.S        |    5 ++++-
 arch/x86/kernel/idt.c            |    5 +++--
 6 files changed, 28 insertions(+), 13 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -86,6 +86,7 @@
 
 SYM_CODE_START(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
+	ENDBR
 
 	swapgs
 	/* tss.sp2 is scratch space. */
@@ -350,6 +351,7 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
+	ENDBR
 	ASM_CLAC
 
 	.if \has_error_code == 0
@@ -417,6 +419,7 @@ SYM_CODE_END(\asmsym)
 .macro idtentry_mce_db vector asmsym cfunc
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
+	ENDBR
 	ASM_CLAC
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -472,6 +475,7 @@ SYM_CODE_END(\asmsym)
 .macro idtentry_vc vector asmsym cfunc
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
+	ENDBR
 	ASM_CLAC
 
 	/*
@@ -533,6 +537,7 @@ SYM_CODE_END(\asmsym)
 .macro idtentry_df vector asmsym cfunc
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
+	ENDBR
 	ASM_CLAC
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
@@ -1063,6 +1068,7 @@ SYM_CODE_END(error_return)
  */
 SYM_CODE_START(asm_exc_nmi)
 	UNWIND_HINT_IRET_REGS
+	ENDBR
 
 	/*
 	 * We allow breakpoints in NMIs. If a breakpoint occurs, then
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -48,6 +48,7 @@
  */
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	/* Interrupts are off on entry. */
 	SWAPGS
 
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
@@ -5,6 +5,8 @@
 /* Interrupts/Exceptions */
 #include <asm/trapnr.h>
 
+#define IDT_ALIGN	(8 * (1 + HAS_KERNEL_IBT))
+
 #ifndef __ASSEMBLY__
 #include <linux/entry-common.h>
 #include <linux/hardirq.h>
@@ -480,7 +482,7 @@ __visible noinstr void func(struct pt_re
 
 /*
  * ASM code to emit the common vector entry stubs where each stub is
- * packed into 8 bytes.
+ * packed into IDT_ALIGN bytes.
  *
  * Note, that the 'pushq imm8' is emitted via '.byte 0x6a, vector' because
  * GCC treats the local vector variable as unsigned int and would expand
@@ -492,33 +494,33 @@ __visible noinstr void func(struct pt_re
  * point is to mask off the bits above bit 7 because the push is sign
  * extending.
  */
-	.align 8
+	.align IDT_ALIGN
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept NR_EXTERNAL_VECTORS
 	UNWIND_HINT_IRET_REGS
 0 :
+	ENDBR
 	.byte	0x6a, vector
 	jmp	asm_common_interrupt
-	nop
-	/* Ensure that the above is 8 bytes max */
-	. = 0b + 8
+	/* Ensure that the above is IDT_ALIGN bytes max */
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
 	UNWIND_HINT_IRET_REGS
 0 :
+	ENDBR
 	.byte	0x6a, vector
 	jmp	asm_spurious_interrupt
-	nop
-	/* Ensure that the above is 8 bytes max */
-	. = 0b + 8
+	/* Ensure that the above is IDT_ALIGN bytes max */
+	.fill 0b + IDT_ALIGN - ., 1, 0x90
 	vector = vector+1
     .endr
 SYM_CODE_END(spurious_entries_start)
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -275,7 +275,7 @@ static inline void vdso_read_cpunode(uns
  * vector has no error code (two bytes), a 'push $vector_number' (two
  * bytes), and a jump to the common entry code (up to five bytes).
  */
-#define EARLY_IDT_HANDLER_SIZE 9
+#define EARLY_IDT_HANDLER_SIZE (9 + 4*HAS_KERNEL_IBT)
 
 /*
  * xen_early_idt_handler_array is for Xen pv guests: for each entry in
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -372,9 +372,11 @@ SYM_CODE_START(early_idt_handler_array)
 	.rept NUM_EXCEPTION_VECTORS
 	.if ((EXCEPTION_ERRCODE_MASK >> i) & 1) == 0
 		UNWIND_HINT_IRET_REGS
+		ENDBR
 		pushq $0	# Dummy error code, to make stack frame uniform
 	.else
 		UNWIND_HINT_IRET_REGS offset=8
+		ENDBR
 	.endif
 	pushq $i		# 72(%rsp) Vector number
 	jmp early_idt_handler_common
@@ -382,10 +384,11 @@ SYM_CODE_START(early_idt_handler_array)
 	i = i + 1
 	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
-	UNWIND_HINT_IRET_REGS offset=16
 SYM_CODE_END(early_idt_handler_array)
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
+	UNWIND_HINT_IRET_REGS offset=16
+	ANNOTATE_NOENDBR
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
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


