Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F434D2A14
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiCIH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiCIH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A62A165C39;
        Tue,  8 Mar 2022 23:55:09 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XfDJ96tvln21+zO0ZDyXvjz5fF0y3zAwBIV6Ckja42I=;
        b=VXWCV5H4zX2ZhP1XZVuPGPwQjCDHMRAD4mCmQB1OpoTgv5trs53MwkBWuXcXcw/X49ecV6
        1WEoW9IvWN0bmXsCx0ymybJ+ijaUqPn1AnVR3FJKYLNA97+irlmyfxenTD//GWKaVqkx6J
        t9lLhod6oWWp+AolNhmwkYswjf7x+dBcynelZxDJH9EGMjpXT/rKl7NxPHrr57m3Gu8z8r
        /ny5aefFDxNEYZLGJYEV6FapgnkECGM2k4id7CE5QYOCk90edjJEeNc7hCdsuRXKwmbCEe
        CByfudqYjl4iqDttQxFxDGwGEHjrz/8clP5w4P3ARrAnnRiP6RtAlIQU6k/OVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XfDJ96tvln21+zO0ZDyXvjz5fF0y3zAwBIV6Ckja42I=;
        b=8s2KQBA1XiNszURBtSuDlPX6XWsfzHHFvv6E8QCe2InZOOkd8W9969ytGvBme4c32se4HT
        6GftgBKfqBH+38BA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,entry: Sprinkle ENDBR dust
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.933157479@infradead.org>
References: <20220308154317.933157479@infradead.org>
MIME-Version: 1.0
Message-ID: <164681250671.16921.5520371664282492345.tip-bot2@tip-bot2>
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

Commit-ID:     32850ea3d35102af3aa2cfbcb71744e9f54de1f8
Gitweb:        https://git.kernel.org/tip/32850ea3d35102af3aa2cfbcb71744e9f54de1f8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:30 +01:00

x86/ibt,entry: Sprinkle ENDBR dust

Kernel entry points should be having ENDBR on for IBT configs.

The SYSCALL entry points are found through taking their respective
address in order to program them in the MSRs, while the exception
entry points are found through UNWIND_HINT_IRET_REGS.

The rule is that any UNWIND_HINT_IRET_REGS at sym+0 should have an
ENDBR, see the later objtool ibt validation patch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.933157479@infradead.org
---
 arch/x86/entry/entry_64.S        |  6 ++++++
 arch/x86/entry/entry_64_compat.S |  3 +++
 arch/x86/include/asm/idtentry.h  | 20 +++++++++++---------
 arch/x86/include/asm/segment.h   |  3 ++-
 arch/x86/kernel/head_64.S        |  4 +++-
 arch/x86/kernel/idt.c            |  5 +++--
 6 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3fd3828..b17ee0d 100644
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
@@ -1069,6 +1074,7 @@ SYM_CODE_END(error_return)
  */
 SYM_CODE_START(asm_exc_nmi)
 	UNWIND_HINT_IRET_REGS
+	ENDBR
 
 	/*
 	 * We allow breakpoints in NMIs. If a breakpoint occurs, then
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0051cf5..35a0e69 100644
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
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088..f84280a 100644
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
@@ -480,7 +482,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 
 /*
  * ASM code to emit the common vector entry stubs where each stub is
- * packed into 8 bytes.
+ * packed into IDT_ALIGN bytes.
  *
  * Note, that the 'pushq imm8' is emitted via '.byte 0x6a, vector' because
  * GCC treats the local vector variable as unsigned int and would expand
@@ -492,33 +494,33 @@ __visible noinstr void func(struct pt_regs *regs,			\
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
+	.fill 0b + IDT_ALIGN - ., 1, 0xcc
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
+	.fill 0b + IDT_ALIGN - ., 1, 0xcc
 	vector = vector+1
     .endr
 SYM_CODE_END(spurious_entries_start)
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 3a31d4e..656ed65 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -4,6 +4,7 @@
 
 #include <linux/const.h>
 #include <asm/alternative.h>
+#include <asm/ibt.h>
 
 /*
  * Constructor for a conventional segment GDT (or LDT) entry.
@@ -275,7 +276,7 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
  * vector has no error code (two bytes), a 'push $vector_number' (two
  * bytes), and a jump to the common entry code (up to five bytes).
  */
-#define EARLY_IDT_HANDLER_SIZE 9
+#define EARLY_IDT_HANDLER_SIZE (9 + ENDBR_INSN_SIZE)
 
 /*
  * xen_early_idt_handler_array is for Xen pv guests: for each entry in
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 990960a..9b6fa76 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -371,9 +371,11 @@ SYM_CODE_START(early_idt_handler_array)
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
@@ -381,11 +383,11 @@ SYM_CODE_START(early_idt_handler_array)
 	i = i + 1
 	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
-	UNWIND_HINT_IRET_REGS offset=16
 SYM_CODE_END(early_idt_handler_array)
 	ANNOTATE_NOENDBR // early_idt_handler_array[NUM_EXCEPTION_VECTORS]
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
+	UNWIND_HINT_IRET_REGS offset=16
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index df0fa69..7676e34 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -10,6 +10,7 @@
 #include <asm/proto.h>
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
+#include <asm/idtentry.h>
 
 #define DPL0		0x0
 #define DPL3		0x3
@@ -272,7 +273,7 @@ void __init idt_setup_apic_and_irq_gates(void)
 	idt_setup_from_table(idt_table, apic_idts, ARRAY_SIZE(apic_idts), true);
 
 	for_each_clear_bit_from(i, system_vectors, FIRST_SYSTEM_VECTOR) {
-		entry = irq_entries_start + 8 * (i - FIRST_EXTERNAL_VECTOR);
+		entry = irq_entries_start + IDT_ALIGN * (i - FIRST_EXTERNAL_VECTOR);
 		set_intr_gate(i, entry);
 	}
 
@@ -283,7 +284,7 @@ void __init idt_setup_apic_and_irq_gates(void)
 		 * system_vectors bitmap. Otherwise they show up in
 		 * /proc/interrupts.
 		 */
-		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
+		entry = spurious_entries_start + IDT_ALIGN * (i - FIRST_SYSTEM_VECTOR);
 		set_intr_gate(i, entry);
 	}
 #endif
