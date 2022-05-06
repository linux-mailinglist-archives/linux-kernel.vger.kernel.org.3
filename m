Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26C351DB9C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442721AbiEFPND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442691AbiEFPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:12:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C306A6D186;
        Fri,  6 May 2022 08:09:04 -0700 (PDT)
Date:   Fri, 06 May 2022 15:09:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651849743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHHTLxZ0y3dDL8rZhZ0/4b2CMBU/c9ZY1ilj9VRJaos=;
        b=LoeSJ032In6KMScpHQq6yZRpwF5AP+JvaJ2XMCadWu30u331Fj5TXDlNFF1XMfruzCOnO/
        3R0M1k9I1HYRQycigmK8rPHxeTLnVPlZdJfRn7dE7ctrQO5qzEtSng0Z5SfrQoHeOuPUYE
        0AzLOo0V7rnFw1n3XQ15TFVbhTZiD8pHterB7VHUhhx/g2706CtcVCG5ONrxGJLUCPv9wU
        KqoY+mlB0K/GiYyyuE8Up9HaYRHe7AGvvzjeCj8VkaLZCpP8sWvwqpvWkjo/DNbs4U7phP
        90ad6DnQPXyoIQYU5QNXO0BkS1sbljkkzjSyyvlC40iN1xivW9M6qvwFXjR9Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651849743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHHTLxZ0y3dDL8rZhZ0/4b2CMBU/c9ZY1ilj9VRJaos=;
        b=SwSUFw6zCztrGFPyGHAse8e/nYFTz9NVHTqeTbO2FO1yi2czSk9+n1rXbQXNs8xNXdu6u+
        ZJckcvHVauHA3/Cw==
From:   "tip-bot2 for Linus Torvalds" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Simplify entry_INT80_compat()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220506121631.221072885@infradead.org>
References: <20220506121631.221072885@infradead.org>
MIME-Version: 1.0
Message-ID: <165184974237.4207.13398999270463525244.tip-bot2@tip-bot2>
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

Commit-ID:     d205222eb6a8e5e70c21200beb81c6e19ec211d6
Gitweb:        https://git.kernel.org/tip/d205222eb6a8e5e70c21200beb81c6e19ec211d6
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Fri, 06 May 2022 14:14:33 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 May 2022 15:49:51 +02:00

x86/entry: Simplify entry_INT80_compat()

Instead of playing silly games with rdi, use rax for simpler and more
consistent code.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220506121631.221072885@infradead.org
---
 arch/x86/entry/entry_64_compat.S | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index c5aeb08..d743eaa 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -362,26 +362,25 @@ SYM_CODE_START(entry_INT80_compat)
 
 	/* switch to thread stack expects orig_ax and rdi to be pushed */
 	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
 
 	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
 	/* In the Xen PV case we already run on the thread stack. */
 	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
 
-	movq	%rsp, %rdi
+	movq	%rsp, %rax
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
-	pushq	6*8(%rdi)		/* regs->ss */
-	pushq	5*8(%rdi)		/* regs->rsp */
-	pushq	4*8(%rdi)		/* regs->eflags */
-	pushq	3*8(%rdi)		/* regs->cs */
-	pushq	2*8(%rdi)		/* regs->ip */
-	pushq	1*8(%rdi)		/* regs->orig_ax */
-	pushq	(%rdi)			/* pt_regs->di */
+	pushq	5*8(%rax)		/* regs->ss */
+	pushq	4*8(%rax)		/* regs->rsp */
+	pushq	3*8(%rax)		/* regs->eflags */
+	pushq	2*8(%rax)		/* regs->cs */
+	pushq	1*8(%rax)		/* regs->ip */
+	pushq	0*8(%rax)		/* regs->orig_ax */
 .Lint80_keep_stack:
 
+	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
 	xorl	%esi, %esi		/* nospec   si */
 	pushq	%rdx			/* pt_regs->dx */
