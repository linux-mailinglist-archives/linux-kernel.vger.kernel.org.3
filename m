Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DC04D29F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiCIH5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiCIH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3464164D1A;
        Tue,  8 Mar 2022 23:55:03 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812502;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AhkZ6uQdHI1QK4NM5lUiDyQS4Yhy+pHWc0wT90NuQc=;
        b=b1TXnqVE5WvLQTwoSnchjtL+fcBjfmmPT9/qHUEbbeDFQNyAd7f90qT3yU33OdPHpAi4eo
        IwJL8r5ZlWy5ubqBVLr01HuzGJQD2xdcKWz7wRoojStwHdWITB+hTK9Da7TplF7RsO1Rpe
        ZyZFmlD6Wa0lIOujrpfkWDuL2ykUOXtpnWPrBtiVr7drgDhotLNoobcE7K487EJNvI4IEp
        Odefu47AqPOpQgcK6zgm9K9liVkARXbpUAmSm6iWZrb0lfYtsqHwTYHYMJap/2rITrN79U
        1OihMusvHMd2O345vfOWjVAU+d4dwXKDaupL0ZVvKOeuvqJr7jRtlE6lSwCpGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812502;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AhkZ6uQdHI1QK4NM5lUiDyQS4Yhy+pHWc0wT90NuQc=;
        b=SWo8a1Zg6lfmu20e245h6pIVMq+oxpIqmoOGVlDTS1Rku/lVx4j5EbIQNQDqGlaOEupy8e
        JHN4pA+IF7Th+eBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,ftrace: Make function-graph play nice
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.347296408@infradead.org>
References: <20220308154318.347296408@infradead.org>
MIME-Version: 1.0
Message-ID: <164681250119.16921.11147534801857543829.tip-bot2@tip-bot2>
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

Commit-ID:     069cfa7285137030111dc78a3fcec091371da514
Gitweb:        https://git.kernel.org/tip/069cfa7285137030111dc78a3fcec091371da514
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:32 +01:00

x86/ibt,ftrace: Make function-graph play nice

Return trampoline must not use indirect branch to return; while this
preserves the RSB, it is fundamentally incompatible with IBT. Instead
use a retpoline like ROP gadget that defeats IBT while not unbalancing
the RSB.

And since ftrace_stub is no longer a plain RET, don't use it to copy
from. Since RET is a trivial instruction, poke it directly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.347296408@infradead.org
---
 arch/x86/kernel/ftrace.c    |  9 ++-------
 arch/x86/kernel/ftrace_64.S | 21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7cc540e..1e31c7d 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -316,12 +316,12 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long offset;
 	unsigned long npages;
 	unsigned long size;
-	unsigned long retq;
 	unsigned long *ptr;
 	void *trampoline;
 	void *ip;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
+	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
 	union ftrace_op_code_union op_ptr;
 	int ret;
 
@@ -359,12 +359,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		goto fail;
 
 	ip = trampoline + size;
-
-	/* The trampoline ends with ret(q) */
-	retq = (unsigned long)ftrace_stub;
-	ret = copy_from_kernel_nofault(ip, (void *)retq, RET_SIZE);
-	if (WARN_ON(ret < 0))
-		goto fail;
+	memcpy(ip, retq, RET_SIZE);
 
 	/* No need to test direct calls on created trampolines */
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 11ac028..e32b5cd 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -176,10 +176,10 @@ SYM_FUNC_END(ftrace_caller);
 SYM_FUNC_START(ftrace_epilogue)
 /*
  * This is weak to keep gas from relaxing the jumps.
- * It is also used to copy the RET for trampolines.
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	UNWIND_HINT_FUNC
+	ENDBR
 	RET
 SYM_FUNC_END(ftrace_epilogue)
 
@@ -284,6 +284,7 @@ SYM_FUNC_START(__fentry__)
 	jnz trace
 
 SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
+	ENDBR
 	RET
 
 trace:
@@ -307,7 +308,7 @@ EXPORT_SYMBOL(__fentry__)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_FUNC_START(return_to_handler)
-	subq  $24, %rsp
+	subq  $16, %rsp
 
 	/* Save the return values */
 	movq %rax, (%rsp)
@@ -319,7 +320,19 @@ SYM_FUNC_START(return_to_handler)
 	movq %rax, %rdi
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
-	addq $24, %rsp
-	JMP_NOSPEC rdi
+
+	addq $16, %rsp
+	/*
+	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
+	 * since IBT would demand that contain ENDBR, which simply isn't so for
+	 * return addresses. Use a retpoline here to keep the RSB balanced.
+	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call .Ldo_rop
+	int3
+.Ldo_rop:
+	mov %rdi, (%rsp)
+	UNWIND_HINT_FUNC
+	RET
 SYM_FUNC_END(return_to_handler)
 #endif
