Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610764726DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbhLMJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:55:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbhLMJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:23 -0500
Date:   Mon, 13 Dec 2021 09:50:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIb35uBEJJvRtwQH0CAVVe+HaNlJUiol7ZrJ1lzTg/I=;
        b=uOD0zvJHUTkLQQoJjYIzPCOBkTd5d3/lntLNjkG/IqqCd3GIpGEkwvM2YGEQjI0r+0aQyZ
        XkwYEiKIdUS7GDDzW62cZCJdnyj+VlWLS8bDV0srpNmI86IBSaQaGQbGJo/mGGVgVIcvrj
        GrOrNfQMi1s2fYzc8R4WyFyQyiXkkyVZpe0biUntSDdnWPHaJhh2dSCkCDzMWJzd+i62pN
        +TnnL+15/I7u+dgVYkThMPD8/NCslDKUyP10F3GwpGJp4BT/Ru0qlGetgRrzFmqkJcdEtr
        WhkKkGtsmVFrL5GkCyekxUz9zxUJthhEoVBmlR0xCug9+zz0Su5FsgRpx6/+Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIb35uBEJJvRtwQH0CAVVe+HaNlJUiol7ZrJ1lzTg/I=;
        b=lBkXfWg9+4RZk3wZoU09GFA81u6JGxz/Wd41DUm+4WlQMaGN7XrCpW9fK3T2JniSbSKNH+
        dKR8k2/9jnnRaHAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/msr: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.364084212@infradead.org>
References: <20211110101325.364084212@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901969.23020.9600490082175457113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d52a7344bdfa9c3442d3f86fb3501d9343726c76
Gitweb:        https://git.kernel.org/tip/d52a7344bdfa9c3442d3f86fb3501d9343726c76
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:47 +01:00

x86/msr: Remove .fixup usage

Rework the MSR accessors to remove .fixup usage. Add two new extable
types (to the 4 already existing msr ones) using the new register
infrastructure to record which register should get the error value.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.364084212@infradead.org
---
 arch/x86/include/asm/extable_fixup_types.h | 23 ++++-----
 arch/x86/include/asm/msr.h                 | 26 +++--------
 arch/x86/mm/extable.c                      | 51 +++++++++++----------
 3 files changed, 47 insertions(+), 53 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 944f832..9d597fe 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -32,17 +32,16 @@
 #define	EX_TYPE_COPY			 4
 #define	EX_TYPE_CLEAR_FS		 5
 #define	EX_TYPE_FPU_RESTORE		 6
-#define	EX_TYPE_WRMSR			 7
-#define	EX_TYPE_RDMSR			 8
-#define	EX_TYPE_BPF			 9
-
-#define	EX_TYPE_WRMSR_IN_MCE		10
-#define	EX_TYPE_RDMSR_IN_MCE		11
-
-#define	EX_TYPE_DEFAULT_MCE_SAFE	12
-#define	EX_TYPE_FAULT_MCE_SAFE		13
-
-#define	EX_TYPE_POP_ZERO		14
-#define	EX_TYPE_IMM_REG			15 /* reg := (long)imm */
+#define	EX_TYPE_BPF			 7
+#define	EX_TYPE_WRMSR			 8
+#define	EX_TYPE_RDMSR			 9
+#define	EX_TYPE_WRMSR_SAFE		10 /* reg := -EIO */
+#define	EX_TYPE_RDMSR_SAFE		11 /* reg := -EIO */
+#define	EX_TYPE_WRMSR_IN_MCE		12
+#define	EX_TYPE_RDMSR_IN_MCE		13
+#define	EX_TYPE_DEFAULT_MCE_SAFE	14
+#define	EX_TYPE_FAULT_MCE_SAFE		15
+#define	EX_TYPE_POP_ZERO		16
+#define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 
 #endif
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 6b52182..d42e6c6 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -137,17 +137,11 @@ static inline unsigned long long native_read_msr_safe(unsigned int msr,
 {
 	DECLARE_ARGS(val, low, high);
 
-	asm volatile("2: rdmsr ; xor %[err],%[err]\n"
-		     "1:\n\t"
-		     ".section .fixup,\"ax\"\n\t"
-		     "3: mov %[fault],%[err]\n\t"
-		     "xorl %%eax, %%eax\n\t"
-		     "xorl %%edx, %%edx\n\t"
-		     "jmp 1b\n\t"
-		     ".previous\n\t"
-		     _ASM_EXTABLE(2b, 3b)
+	asm volatile("1: rdmsr ; xor %[err],%[err]\n"
+		     "2:\n\t"
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_RDMSR_SAFE, %[err])
 		     : [err] "=r" (*err), EAX_EDX_RET(val, low, high)
-		     : "c" (msr), [fault] "i" (-EIO));
+		     : "c" (msr));
 	if (tracepoint_enabled(read_msr))
 		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), *err);
 	return EAX_EDX_VAL(val, low, high);
@@ -169,15 +163,11 @@ native_write_msr_safe(unsigned int msr, u32 low, u32 high)
 {
 	int err;
 
-	asm volatile("2: wrmsr ; xor %[err],%[err]\n"
-		     "1:\n\t"
-		     ".section .fixup,\"ax\"\n\t"
-		     "3:  mov %[fault],%[err] ; jmp 1b\n\t"
-		     ".previous\n\t"
-		     _ASM_EXTABLE(2b, 3b)
+	asm volatile("1: wrmsr ; xor %[err],%[err]\n"
+		     "2:\n\t"
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_WRMSR_SAFE, %[err])
 		     : [err] "=a" (err)
-		     : "c" (msr), "0" (low), "d" (high),
-		       [fault] "i" (-EIO)
+		     : "c" (msr), "0" (low), "d" (high)
 		     : "memory");
 	if (tracepoint_enabled(write_msr))
 		do_trace_write_msr(msr, ((u64)high << 32 | low), err);
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index cef8901..717cd35 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -83,28 +83,29 @@ static bool ex_handler_copy(const struct exception_table_entry *fixup,
 	return ex_handler_fault(fixup, regs, trapnr);
 }
 
-static bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs)
+static bool ex_handler_msr(const struct exception_table_entry *fixup,
+			   struct pt_regs *regs, bool wrmsr, bool safe, int reg)
 {
-	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
+	if (!safe && wrmsr &&
+	    pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, (unsigned int)regs->dx,
+			 (unsigned int)regs->ax,  regs->ip, (void *)regs->ip))
+		show_stack_regs(regs);
+
+	if (!safe && !wrmsr &&
+	    pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
 		show_stack_regs(regs);
 
-	/* Pretend that the read succeeded and returned 0. */
-	regs->ax = 0;
-	regs->dx = 0;
-	return ex_handler_default(fixup, regs);
-}
+	if (!wrmsr) {
+		/* Pretend that the read succeeded and returned 0. */
+		regs->ax = 0;
+		regs->dx = 0;
+	}
 
-static bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs)
-{
-	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
-			 (unsigned int)regs->cx, (unsigned int)regs->dx,
-			 (unsigned int)regs->ax,  regs->ip, (void *)regs->ip))
-		show_stack_regs(regs);
+	if (safe)
+		*pt_regs_nr(regs, reg) = -EIO;
 
-	/* Pretend that the write succeeded. */
 	return ex_handler_default(fixup, regs);
 }
 
@@ -186,18 +187,22 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		return ex_handler_clear_fs(e, regs);
 	case EX_TYPE_FPU_RESTORE:
 		return ex_handler_fprestore(e, regs);
-	case EX_TYPE_RDMSR:
-		return ex_handler_rdmsr_unsafe(e, regs);
-	case EX_TYPE_WRMSR:
-		return ex_handler_wrmsr_unsafe(e, regs);
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(e, regs);
-	case EX_TYPE_RDMSR_IN_MCE:
-		ex_handler_msr_mce(regs, false);
-		break;
+	case EX_TYPE_WRMSR:
+		return ex_handler_msr(e, regs, true, false, reg);
+	case EX_TYPE_RDMSR:
+		return ex_handler_msr(e, regs, false, false, reg);
+	case EX_TYPE_WRMSR_SAFE:
+		return ex_handler_msr(e, regs, true, true, reg);
+	case EX_TYPE_RDMSR_SAFE:
+		return ex_handler_msr(e, regs, false, true, reg);
 	case EX_TYPE_WRMSR_IN_MCE:
 		ex_handler_msr_mce(regs, true);
 		break;
+	case EX_TYPE_RDMSR_IN_MCE:
+		ex_handler_msr_mce(regs, false);
+		break;
 	case EX_TYPE_POP_ZERO:
 		return ex_handler_pop_zero(e, regs);
 	case EX_TYPE_IMM_REG:
