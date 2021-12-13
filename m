Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72A472878
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhLMKNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbhLMKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D438C025499;
        Mon, 13 Dec 2021 01:50:24 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9L5VqEL7ic1WolWBBUho5GpRnEyyZgML1w9uGrYYNo=;
        b=S9GOjh2NMGa85ScRToRHnt3+yKzvzZPRiooyXA1wdkEz4o8bXnOj91lh9riGTQajnSklnA
        AsyrOg5cbZ76bgyKa+iWvrAxfaq/nhMs8eMUTTCQG/p5UC/F1hALvpSjYjjA0K8a1Ixhdy
        hWhT/1lUEYVpermjDuDNOh2Xw2UOk76AgXAQsPkTksBo12j7X9ceaZKbOO/Vb7042mh+ry
        5oKgiGO+HfpZFmLtfNkPF8Pqf7rNTQk7ETSplfwEQ4oRm/MnmiWT6rDSYzEt/A5GQ/s2rN
        aHNc80hpLeWRBQpTnY229wBbkby6WJdVHKWgBRXTYn0WtLbOZ1Jp84EkT7ELZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9L5VqEL7ic1WolWBBUho5GpRnEyyZgML1w9uGrYYNo=;
        b=w55whqStmZxRyUqYd7X9KbOXaqDI79ofU4hACplVt9q8134fsx9PjsCZ+dwgjzITr0MP15
        ce226fU42DdnDtDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry_32: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.245184699@infradead.org>
References: <20211110101325.245184699@infradead.org>
MIME-Version: 1.0
Message-ID: <163938902125.23020.10122333629049332379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     aa93e2ad7464ffb90155a5ffdde963816f86d5dc
Gitweb:        https://git.kernel.org/tip/aa93e2ad7464ffb90155a5ffdde963816f86d5dc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:46 +01:00

x86/entry_32: Remove .fixup usage

Where possible, push the .fixup into code, at the tail of functions.

This is hard for macros since they're used in multiple functions,
therefore introduce a new extable handler to pop zeros.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.245184699@infradead.org
---
 arch/x86/entry/entry_32.S                  | 28 ++++++---------------
 arch/x86/include/asm/extable_fixup_types.h |  2 ++-
 arch/x86/mm/extable.c                      | 14 +++++++++++-
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 00413e3..e0a95d8 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -270,17 +270,9 @@
 3:	popl	%fs
 	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
 	IRET_FRAME
-.pushsection .fixup, "ax"
-4:	movl	$0, (%esp)
-	jmp	1b
-5:	movl	$0, (%esp)
-	jmp	2b
-6:	movl	$0, (%esp)
-	jmp	3b
-.popsection
-	_ASM_EXTABLE(1b, 4b)
-	_ASM_EXTABLE(2b, 5b)
-	_ASM_EXTABLE(3b, 6b)
+	_ASM_EXTABLE_TYPE(1b, 1b, EX_TYPE_POP_ZERO)
+	_ASM_EXTABLE_TYPE(2b, 2b, EX_TYPE_POP_ZERO)
+	_ASM_EXTABLE_TYPE(3b, 3b, EX_TYPE_POP_ZERO)
 .endm
 
 .macro RESTORE_ALL_NMI cr3_reg:req pop=0
@@ -925,10 +917,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	sti
 	sysexit
 
-.pushsection .fixup, "ax"
-2:	movl	$0, PT_FS(%esp)
-	jmp	1b
-.popsection
+2:	movl    $0, PT_FS(%esp)
+	jmp     1b
 	_ASM_EXTABLE(1b, 2b)
 
 .Lsysenter_fix_flags:
@@ -996,8 +986,7 @@ restore_all_switch_stack:
 	 */
 	iret
 
-.section .fixup, "ax"
-SYM_CODE_START(asm_iret_error)
+.Lasm_iret_error:
 	pushl	$0				# no error code
 	pushl	$iret_error
 
@@ -1014,9 +1003,8 @@ SYM_CODE_START(asm_iret_error)
 #endif
 
 	jmp	handle_exception
-SYM_CODE_END(asm_iret_error)
-.previous
-	_ASM_EXTABLE(.Lirq_return, asm_iret_error)
+
+	_ASM_EXTABLE(.Lirq_return, .Lasm_iret_error)
 SYM_FUNC_END(entry_INT80_32)
 
 .macro FIXUP_ESPFIX_STACK
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 409524d..4d709a2 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -19,4 +19,6 @@
 #define	EX_TYPE_DEFAULT_MCE_SAFE	12
 #define	EX_TYPE_FAULT_MCE_SAFE		13
 
+#define	EX_TYPE_POP_ZERO		14
+
 #endif
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 5cd2a88..fb0c475 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -99,6 +99,18 @@ static bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_pop_zero(const struct exception_table_entry *fixup,
+				struct pt_regs *regs)
+{
+	/*
+	 * Typically used for when "pop %seg" traps, in which case we'll clear
+	 * the stack slot and re-try the instruction, which will then succeed
+	 * to pop zero.
+	 */
+	*((unsigned long *)regs->sp) = 0;
+	return ex_handler_default(fixup, regs);
+}
+
 int ex_get_fixup_type(unsigned long ip)
 {
 	const struct exception_table_entry *e = search_exception_tables(ip);
@@ -156,6 +168,8 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 	case EX_TYPE_WRMSR_IN_MCE:
 		ex_handler_msr_mce(regs, true);
 		break;
+	case EX_TYPE_POP_ZERO:
+		return ex_handler_pop_zero(e, regs);
 	}
 	BUG();
 }
