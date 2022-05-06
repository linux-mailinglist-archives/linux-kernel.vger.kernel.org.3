Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8145551DB99
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376457AbiEFPNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442690AbiEFPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:12:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEE6D185;
        Fri,  6 May 2022 08:09:04 -0700 (PDT)
Date:   Fri, 06 May 2022 15:09:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651849742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKXsXDu95z28dw95tOvztnzgQy6dl5fSriDr+a0MRD8=;
        b=kjshoTS6FJVi9V8qlvjBCu24Kq0q9JZzsGN6O7MTLu+7kODdaSDjSiyIqz8OhrRurDEowp
        H6a3ey/nvLFUYcbUCBN4BeDRfPASCgO6V1syFiKLIJzPSX8QAuZARpbINUv7ckR3UvSZS/
        YPHIa8JZbU/R52CU0pVFDsGvGQmQVDto7SP3kCiU5B8S9u28iSNOE6EslsVjuXGqPbD8bL
        3nGHdCHkDD8rXUqW6UHYDW7vlfjMRwgDEH+3GXKNdOz2GHLXQTudeOvotY3AokJlj5QLWR
        NRr6pt3yqzXgCdS750cFyNua75FyNtvG9z3TnwR5hSQJYU5FOGVPHWLjaZBcDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651849742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKXsXDu95z28dw95tOvztnzgQy6dl5fSriDr+a0MRD8=;
        b=l9BBLPLRIvqu2ZvGpi/3+IrIg8tBalVJogUn6AA0BoIkwWUEjHt93M0KZ7NknodCb5/Lqp
        k/c82IqV7LILF8Cg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220506121631.293889636@infradead.org>
References: <20220506121631.293889636@infradead.org>
MIME-Version: 1.0
Message-ID: <165184974147.4207.18233557988026860808.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     8c42819b61b8340cff0643e65b5ce6a4144ab155
Gitweb:        https://git.kernel.org/tip/8c42819b61b8340cff0643e65b5ce6a4144ab155
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 May 2022 14:14:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 May 2022 15:57:02 +02:00

x86/entry: Use PUSH_AND_CLEAR_REGS for compat

Since the upper regs don't exist for ia32 code, preserving them
doesn't hurt and it simplifies the code.

This doesn't add any attack surface that would not already be
available through INT80.

Notably:

 - 32bit SYSENTER: didn't clear si, dx, cx.

 - 32bit SYSCALL, INT80: *do* clear si since the C functions don't
   take a second argument.

 - 64bit: didn't clear si since the C functions take a second
   argument; except the error_entry path might have only one argument,
   so clearing si was missing here.

32b SYSENTER should be clearing all those 3 registers, nothing uses them
and selftests pass.

Unconditionally clear rsi since it simplifies code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220506121631.293889636@infradead.org
---
 arch/x86/entry/calling.h         |  1 +-
 arch/x86/entry/entry_64_compat.S | 87 +------------------------------
 2 files changed, 4 insertions(+), 84 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a4c061f..debbe94 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -99,6 +99,7 @@ For 32-bit we have the following conventions - kernel is built with
 	 * well before they could be put to use in a speculative execution
 	 * gadget.
 	 */
+	xorl	%esi,  %esi	/* nospec si  */
 	xorl	%edx,  %edx	/* nospec dx  */
 	xorl	%ecx,  %ecx	/* nospec cx  */
 	xorl	%r8d,  %r8d	/* nospec r8  */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index d743eaa..ed2be36 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -83,32 +83,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	movl	%eax, %eax
 
 	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
-	pushq	%rsi			/* pt_regs->si */
-	pushq	%rdx			/* pt_regs->dx */
-	pushq	%rcx			/* pt_regs->cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
-	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   $0			/* pt_regs->r9  = 0 */
-	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   $0			/* pt_regs->r10 = 0 */
-	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   $0			/* pt_regs->r11 = 0 */
-	xorl	%r11d, %r11d		/* nospec   r11 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	xorl	%ebx, %ebx		/* nospec   rbx */
-	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
-	xorl	%ebp, %ebp		/* nospec   rbp */
-	pushq   $0			/* pt_regs->r12 = 0 */
-	xorl	%r12d, %r12d		/* nospec   r12 */
-	pushq   $0			/* pt_regs->r13 = 0 */
-	xorl	%r13d, %r13d		/* nospec   r13 */
-	pushq   $0			/* pt_regs->r14 = 0 */
-	xorl	%r14d, %r14d		/* nospec   r14 */
-	pushq   $0			/* pt_regs->r15 = 0 */
-	xorl	%r15d, %r15d		/* nospec   r15 */
-
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 	UNWIND_HINT_REGS
 
 	cld
@@ -225,35 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	movl	%eax, %eax		/* discard orig_ax high bits */
 	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
-	pushq	%rsi			/* pt_regs->si */
-	xorl	%esi, %esi		/* nospec   si */
-	pushq	%rdx			/* pt_regs->dx */
-	xorl	%edx, %edx		/* nospec   dx */
-	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
-	xorl	%ecx, %ecx		/* nospec   cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
-	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   $0			/* pt_regs->r9  = 0 */
-	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   $0			/* pt_regs->r10 = 0 */
-	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   $0			/* pt_regs->r11 = 0 */
-	xorl	%r11d, %r11d		/* nospec   r11 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	xorl	%ebx, %ebx		/* nospec   rbx */
-	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
-	xorl	%ebp, %ebp		/* nospec   rbp */
-	pushq   $0			/* pt_regs->r12 = 0 */
-	xorl	%r12d, %r12d		/* nospec   r12 */
-	pushq   $0			/* pt_regs->r13 = 0 */
-	xorl	%r13d, %r13d		/* nospec   r13 */
-	pushq   $0			/* pt_regs->r14 = 0 */
-	xorl	%r14d, %r14d		/* nospec   r14 */
-	pushq   $0			/* pt_regs->r15 = 0 */
-	xorl	%r15d, %r15d		/* nospec   r15 */
-
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
@@ -380,35 +327,7 @@ SYM_CODE_START(entry_INT80_compat)
 	pushq	0*8(%rax)		/* regs->orig_ax */
 .Lint80_keep_stack:
 
-	pushq	%rdi			/* pt_regs->di */
-	pushq	%rsi			/* pt_regs->si */
-	xorl	%esi, %esi		/* nospec   si */
-	pushq	%rdx			/* pt_regs->dx */
-	xorl	%edx, %edx		/* nospec   dx */
-	pushq	%rcx			/* pt_regs->cx */
-	xorl	%ecx, %ecx		/* nospec   cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   %r8			/* pt_regs->r8 */
-	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   %r9			/* pt_regs->r9 */
-	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   %r10			/* pt_regs->r10*/
-	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   %r11			/* pt_regs->r11 */
-	xorl	%r11d, %r11d		/* nospec   r11 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	xorl	%ebx, %ebx		/* nospec   rbx */
-	pushq   %rbp                    /* pt_regs->rbp */
-	xorl	%ebp, %ebp		/* nospec   rbp */
-	pushq   %r12                    /* pt_regs->r12 */
-	xorl	%r12d, %r12d		/* nospec   r12 */
-	pushq   %r13                    /* pt_regs->r13 */
-	xorl	%r13d, %r13d		/* nospec   r13 */
-	pushq   %r14                    /* pt_regs->r14 */
-	xorl	%r14d, %r14d		/* nospec   r14 */
-	pushq   %r15                    /* pt_regs->r15 */
-	xorl	%r15d, %r15d		/* nospec   r15 */
-
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 	UNWIND_HINT_REGS
 
 	cld
