Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1A49520F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376894AbiATQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376872AbiATQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:09:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF0BC06173F;
        Thu, 20 Jan 2022 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mtyDfDtmj2E1gCt4wdSrRmdg+40wSt1K3yZYfH1SU2k=; b=Pj+P38GZDROrZRh4B0ckXlZKk8
        VASbGsesh6YXU33HFWMsT5A40RVp6biot2Bdyx5TifYrBK3WCh2iQt9YTAzLln3ftFOYBVr+idBGa
        Cr8wLjuPfV3hdeKIRT0mAnk4u6XCClqIgYOjtCGzwVq4LpPZuIevEqBupgWfb2cpOendX35e8/FCT
        l4IquWwOmwO5ASWNC/YBoZPn9WaZtAC57Be5E8rzFzsaiNl+H+Qy+KrP6+u0lLvwwHO6BRXKoenhI
        4ClmQgmWCEXtm71S3yAMZ6JtrX1IZC5XQG+Zl7w0t5um9wZoI1YL7KitwSetgBIB9eLoZEZCQ0q20
        1dYGNPDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZza-00EQ4I-3h; Thu, 20 Jan 2022 16:08:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDC913005CA;
        Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9453C2028047C; Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Message-ID: <20220120160822.728589540@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Jan 2022 16:55:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: [RFC][PATCH v2 2/5] entry,x86: Create common IRQ operations for exceptions
References: <20220120155517.066795336@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of exceptions can re-enable IRQs and schedule (provided the
context taking the exception has IRQs enabled etc.). Currently this
isn't standardized and each architecture does it slightly different.

(Notably, ARM64 restores/inherits more than just the IRQ state,
suggesting at least some form of arch_ hook might be appropriate on
top of this).

Create a single set of functions for this and convert x86 to use
these. The purpose is to have a single (common) place to hook in order
to cover all the exceptions that can schedule().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c      |   48 ++++++++++++++++---------------------------
 arch/x86/mm/fault.c          |   28 ++++++++++++-------------
 include/linux/entry-common.h |   24 +++++++++++++++++++++
 3 files changed, 56 insertions(+), 44 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -73,18 +73,6 @@
 
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
 
-static inline void cond_local_irq_enable(struct pt_regs *regs)
-{
-	if (regs->flags & X86_EFLAGS_IF)
-		local_irq_enable();
-}
-
-static inline void cond_local_irq_disable(struct pt_regs *regs)
-{
-	if (regs->flags & X86_EFLAGS_IF)
-		local_irq_disable();
-}
-
 __always_inline int is_valid_bugaddr(unsigned long addr)
 {
 	if (addr < TASK_SIZE_MAX)
@@ -177,9 +165,9 @@ static void do_error_trap(struct pt_regs
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
-		cond_local_irq_enable(regs);
+		irqentry_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
-		cond_local_irq_disable(regs);
+		irqentry_irq_disable(regs);
 	}
 }
 
@@ -300,7 +288,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_
 	if (!user_mode(regs))
 		die("Split lock detected\n", regs, error_code);
 
-	local_irq_enable();
+	irqentry_irq_enable(regs);
 
 	if (handle_user_split_lock(regs, error_code))
 		goto out;
@@ -309,7 +297,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_
 		error_code, BUS_ADRALN, NULL);
 
 out:
-	local_irq_disable();
+	irqentry_irq_disable(regs);
 }
 
 #ifdef CONFIG_VMAP_STACK
@@ -473,14 +461,14 @@ DEFINE_IDTENTRY(exc_bounds)
 	if (notify_die(DIE_TRAP, "bounds", regs, 0,
 			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
 		return;
-	cond_local_irq_enable(regs);
+	irqentry_irq_enable(regs);
 
 	if (!user_mode(regs))
 		die("bounds", regs, 0);
 
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, 0, 0, NULL);
 
-	cond_local_irq_disable(regs);
+	irqentry_irq_disable(regs);
 }
 
 enum kernel_gp_hint {
@@ -567,7 +555,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
 	unsigned long gp_addr;
 	int ret;
 
-	cond_local_irq_enable(regs);
+	irqentry_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
 		if (user_mode(regs) && fixup_umip_exception(regs))
@@ -638,7 +626,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
 	die_addr(desc, regs, error_code, gp_addr);
 
 exit:
-	cond_local_irq_disable(regs);
+	irqentry_irq_disable(regs);
 }
 
 static bool do_int3(struct pt_regs *regs)
@@ -665,9 +653,9 @@ static void do_int3_user(struct pt_regs
 	if (do_int3(regs))
 		return;
 
-	cond_local_irq_enable(regs);
+	irqentry_irq_enable(regs);
 	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
-	cond_local_irq_disable(regs);
+	irqentry_irq_disable(regs);
 }
 
 DEFINE_IDTENTRY_RAW(exc_int3)
@@ -1003,7 +991,7 @@ static __always_inline void exc_debug_us
 		goto out;
 
 	/* It's safe to allow irq's after DR6 has been saved */
-	local_irq_enable();
+	irqentry_irq_enable(regs);
 
 	if (v8086_mode(regs)) {
 		handle_vm86_trap((struct kernel_vm86_regs *)regs, 0, X86_TRAP_DB);
@@ -1020,7 +1008,7 @@ static __always_inline void exc_debug_us
 		send_sigtrap(regs, 0, get_si_code(dr6));
 
 out_irq:
-	local_irq_disable();
+	irqentry_irq_disable(regs);
 out:
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
@@ -1064,7 +1052,7 @@ static void math_error(struct pt_regs *r
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
 
-	cond_local_irq_enable(regs);
+	irqentry_irq_enable(regs);
 
 	if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr, 0, 0))
@@ -1099,7 +1087,7 @@ static void math_error(struct pt_regs *r
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs));
 exit:
-	cond_local_irq_disable(regs);
+	irqentry_irq_disable(regs);
 }
 
 DEFINE_IDTENTRY(exc_coprocessor_error)
@@ -1160,7 +1148,7 @@ static bool handle_xfd_event(struct pt_r
 	if (WARN_ON(!user_mode(regs)))
 		return false;
 
-	local_irq_enable();
+	irqentry_irq_enable(regs);
 
 	err = xfd_enable_feature(xfd_err);
 
@@ -1173,7 +1161,7 @@ static bool handle_xfd_event(struct pt_r
 		break;
 	}
 
-	local_irq_disable();
+	irqentry_irq_disable(regs);
 	return true;
 }
 
@@ -1188,12 +1176,12 @@ DEFINE_IDTENTRY(exc_device_not_available
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
 
-		cond_local_irq_enable(regs);
+		irqentry_irq_enable(regs);
 
 		info.regs = regs;
 		math_emulate(&info);
 
-		cond_local_irq_disable(regs);
+		irqentry_irq_disable(regs);
 		return;
 	}
 #endif
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1209,6 +1209,12 @@ do_kern_addr_fault(struct pt_regs *regs,
 NOKPROBE_SYMBOL(do_kern_addr_fault);
 
 /*
+ * EFLAGS[3] is unused and ABI defined to be 0, use it to store IRQ state,
+ * because do_user_addr_fault() is too convoluted to track things.
+ */
+#define X86_EFLAGS_MISC		(1UL << 3)
+
+/*
  * Handle faults in the user portion of the address space.  Nothing in here
  * should check X86_PF_USER without a specific justification: for almost
  * all purposes, we should treat a normal kernel access to user memory
@@ -1290,13 +1296,11 @@ void do_user_addr_fault(struct pt_regs *
 	 * User-mode registers count as a user access even for any
 	 * potential system fault or CPU buglet:
 	 */
-	if (user_mode(regs)) {
-		local_irq_enable();
+	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
-	} else {
-		if (regs->flags & X86_EFLAGS_IF)
-			local_irq_enable();
-	}
+
+	irqentry_irq_enable(regs);
+	regs->flags |= X86_EFLAGS_MISC;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
@@ -1483,14 +1487,10 @@ handle_page_fault(struct pt_regs *regs,
 		do_kern_addr_fault(regs, error_code, address);
 	} else {
 		do_user_addr_fault(regs, error_code, address);
-		/*
-		 * User address page fault handling might have reenabled
-		 * interrupts. Fixing up all potential exit points of
-		 * do_user_addr_fault() and its leaf functions is just not
-		 * doable w/o creating an unholy mess or turning the code
-		 * upside down.
-		 */
-		local_irq_disable();
+		if (regs->flags & X86_EFLAGS_MISC) {
+			regs->flags &= ~X86_EFLAGS_MISC;
+			irqentry_irq_disable(regs);
+		}
 	}
 }
 
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -7,6 +7,7 @@
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
+#include <asm/ptrace.h>
 
 #include <asm/entry-common.h>
 
@@ -213,6 +214,29 @@ static inline void local_irq_disable_exi
 #endif
 
 /**
+ * irqentry_irq_enable - Conditionally enable IRQs from exceptions
+ *
+ * Common code for exceptions to (re)enable IRQs, typically done to allow
+ * from-user exceptions to schedule (since they run on the task stack).
+ */
+static inline void irqentry_irq_enable(struct pt_regs *regs)
+{
+	if (!regs_irqs_disabled(regs))
+		local_irq_enable();
+}
+
+/**
+ * irqentry_irq_disable - Conditionally disable IRQs from exceptions
+ *
+ * Counterpart of irqentry_irq_enable().
+ */
+static inline void irqentry_irq_disable(struct pt_regs *regs)
+{
+	if (!regs_irqs_disabled(regs))
+		local_irq_disable();
+}
+
+/**
  * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
  *				 to user mode.
  * @regs:	Pointer to currents pt_regs


