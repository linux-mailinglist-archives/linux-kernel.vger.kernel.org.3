Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338074726D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhLMJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:55:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbhLMJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:15 -0500
Date:   Mon, 13 Dec 2021 09:50:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxE714dIACg+rzkya8aOisz7B5Ki8b5eu3vMAi2gpWY=;
        b=AplQaI0Y88xANHx8GbP1iykAZ2qLBuphYwzgACOgIpS5Npp3HQqDaV5abB8wiFUV5BM0oJ
        B2uoi4V+darJfN3wKaFqH2VCdxx1i8GUuaHxYTdNgtTUIesw1uJMDsCnJ10/YWCTlNT/6l
        42KO0j6nci0eqINk7q+Dz+xEcDEamcMyWP9ypygp4kwQQA2Pg8BUEv5tciggA8lTdVHHeG
        sazRfPubvAtcB2wrLuifZfQO9ODEvXCve0L9vN6MrSWQl2l/Csq7heOZl2tUY9L8z1Vzhv
        hZRJGgchDt9rvFRpzdpUfjGmvKtPOkS9tjw48wu3AR+XkqOT9MJmNAqyWuz7GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxE714dIACg+rzkya8aOisz7B5Ki8b5eu3vMAi2gpWY=;
        b=cX2cbzon1NlRigD/B0HkkOWfAhhmtOM9q0mSw2Of0IGvc9cS+UHp+sloQluJHyo5wAhd3v
        haxzOHD3uGAfY0Cg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/sgx: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.961246679@infradead.org>
References: <20211110101325.961246679@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901224.23020.15161128488578371433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5ce8e39f55521c762f0e6d1bba9597284b1f2e69
Gitweb:        https://git.kernel.org/tip/5ce8e39f55521c762f0e6d1bba9597284b1f2e69
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:49 +01:00

x86/sgx: Remove .fixup usage

Create EX_TYPE_FAULT_SGX which does as EX_TYPE_FAULT does, except adds
this extra bit that SGX really fancies having.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.961246679@infradead.org
---
 arch/x86/include/asm/extable_fixup_types.h |  2 +-
 arch/x86/include/asm/sgx.h                 | 18 +++++++++++-
 arch/x86/kernel/cpu/sgx/encls.h            | 36 ++-------------------
 arch/x86/mm/extable.c                      | 10 ++++++-
 4 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 31ad42f..8278ed2 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -48,4 +48,6 @@
 #define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(0))
 #define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_DATA_IMM(1))
 
+#define	EX_TYPE_FAULT_SGX		18
+
 #endif
diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 05f3e21..3f9334e 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -46,6 +46,24 @@ enum sgx_encls_function {
 };
 
 /**
+ * SGX_ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
+ *
+ * ENCLS has its own (positive value) error codes and also generates
+ * ENCLS specific #GP and #PF faults.  And the ENCLS values get munged
+ * with system error codes as everything percolates back up the stack.
+ * Unfortunately (for us), we need to precisely identify each unique
+ * error code, e.g. the action taken if EWB fails varies based on the
+ * type of fault and on the exact SGX error code, i.e. we can't simply
+ * convert all faults to -EFAULT.
+ *
+ * To make all three error types coexist, we set bit 30 to identify an
+ * ENCLS fault.  Bit 31 (technically bits N:31) is used to differentiate
+ * between positive (faults and SGX error codes) and negative (system
+ * error codes) values.
+ */
+#define SGX_ENCLS_FAULT_FLAG 0x40000000
+
+/**
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 9b20484..fa04a73 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -11,26 +11,8 @@
 #include <asm/traps.h>
 #include "sgx.h"
 
-/**
- * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
- *
- * ENCLS has its own (positive value) error codes and also generates
- * ENCLS specific #GP and #PF faults.  And the ENCLS values get munged
- * with system error codes as everything percolates back up the stack.
- * Unfortunately (for us), we need to precisely identify each unique
- * error code, e.g. the action taken if EWB fails varies based on the
- * type of fault and on the exact SGX error code, i.e. we can't simply
- * convert all faults to -EFAULT.
- *
- * To make all three error types coexist, we set bit 30 to identify an
- * ENCLS fault.  Bit 31 (technically bits N:31) is used to differentiate
- * between positive (faults and SGX error codes) and negative (system
- * error codes) values.
- */
-#define ENCLS_FAULT_FLAG 0x40000000
-
 /* Retrieve the encoded trapnr from the specified return code. */
-#define ENCLS_TRAPNR(r) ((r) & ~ENCLS_FAULT_FLAG)
+#define ENCLS_TRAPNR(r) ((r) & ~SGX_ENCLS_FAULT_FLAG)
 
 /* Issue a WARN() about an ENCLS function. */
 #define ENCLS_WARN(r, name) {						  \
@@ -50,7 +32,7 @@
  */
 static inline bool encls_faulted(int ret)
 {
-	return ret & ENCLS_FAULT_FLAG;
+	return ret & SGX_ENCLS_FAULT_FLAG;
 }
 
 /**
@@ -88,11 +70,7 @@ static inline bool encls_failed(int ret)
 	asm volatile(						\
 	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
 	"2:\n"							\
-	".section .fixup,\"ax\"\n"				\
-	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
-	"   jmp 2b\n"						\
-	".previous\n"						\
-	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_SGX)		\
 	: "=a"(ret)						\
 	: "a"(rax), inputs					\
 	: "memory", "cc");					\
@@ -127,7 +105,7 @@ static inline bool encls_failed(int ret)
  *
  * Return:
  *   0 on success,
- *   trapnr with ENCLS_FAULT_FLAG set on fault
+ *   trapnr with SGX_ENCLS_FAULT_FLAG set on fault
  */
 #define __encls_N(rax, rbx_out, inputs...)			\
 	({							\
@@ -136,11 +114,7 @@ static inline bool encls_failed(int ret)
 	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
 	"   xor %%eax,%%eax;\n"					\
 	"2:\n"							\
-	".section .fixup,\"ax\"\n"				\
-	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
-	"   jmp 2b\n"						\
-	".previous\n"						\
-	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_SGX)		\
 	: "=a"(ret), "=b"(rbx_out)				\
 	: "a"(rax), inputs					\
 	: "memory");						\
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 717cd35..c869f43 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -10,6 +10,7 @@
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 #include <asm/insn-eval.h>
+#include <asm/sgx.h>
 
 static inline unsigned long *pt_regs_nr(struct pt_regs *regs, int nr)
 {
@@ -47,6 +48,13 @@ static bool ex_handler_fault(const struct exception_table_entry *fixup,
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_sgx(const struct exception_table_entry *fixup,
+			   struct pt_regs *regs, int trapnr)
+{
+	regs->ax = trapnr | SGX_ENCLS_FAULT_FLAG;
+	return ex_handler_default(fixup, regs);
+}
+
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never get
  * here because the FPU state of a task using the FPU (task->thread.fpu.state)
@@ -207,6 +215,8 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		return ex_handler_pop_zero(e, regs);
 	case EX_TYPE_IMM_REG:
 		return ex_handler_imm_reg(e, regs, reg, imm);
+	case EX_TYPE_FAULT_SGX:
+		return ex_handler_sgx(e, regs, trapnr);
 	}
 	BUG();
 }
