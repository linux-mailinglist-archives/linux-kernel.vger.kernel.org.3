Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1481F4D9939
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347398AbiCOKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347278AbiCOKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6863344EF;
        Tue, 15 Mar 2022 03:43:56 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQTL4lw8prEg4ZsF/2IcY+D8LEtbABpQAQdVVCpEUCI=;
        b=POZBaVfg3Z4vJNzn11m8bHqZSUj2vHa2aejvkWHmxM4jcSRz5PA2pXN0fxlQKGZcJQIUcP
        ERAo1A47zlSFmd7Gl7WjP784DGNcBk5es5CIqU3xNEbvAXWL3nR9vat8kOIhC3PkENdjgN
        VCgS1GA+A3V7aWoazuhhHaNOIAl3zBY7AqOdKxtgtIqU59pW/Wy2IfXFJtcWe60LA+huZO
        IMDeUjHJ861TD8hD7J7IpkpNJgw1Ha53fBDrodUr9HIYfbtu4KT3skPzdNVeArorpZfQb4
        jTw3UL+yL6PdTTQUv45OIz/TEPRu6uGjDqZvgh+qqIx6WjTempJwORKYVb8GoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQTL4lw8prEg4ZsF/2IcY+D8LEtbABpQAQdVVCpEUCI=;
        b=UmXF52EdrMvfPSZtYqHf0SH5TaitpIYRqdYLTgtQaJDRQAH+/vRAF9gMyS4YVopUzQPRq/
        gOeK0KQ8LiUewrAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,ftrace: Annotate ftrace code patching
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.936599479@infradead.org>
References: <20220308154318.936599479@infradead.org>
MIME-Version: 1.0
Message-ID: <164734103435.16921.12087221192544447210.tip-bot2@tip-bot2>
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

Commit-ID:     3215de84c06d747bb748b98945add83e3ec8a6e2
Gitweb:        https://git.kernel.org/tip/3215de84c06d747bb748b98945add83e3ec8a6e2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:41 +01:00

x86/ibt,ftrace: Annotate ftrace code patching

These are code patching sites, not indirect targets.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.936599479@infradead.org
---
 arch/x86/kernel/ftrace_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index e32b5cd..4ec1360 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -145,6 +145,7 @@ SYM_FUNC_START(ftrace_caller)
 	movq %rcx, RSP(%rsp)
 
 SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -155,6 +156,7 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	movq $0, CS(%rsp)
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	call ftrace_stub
 
 	/* Handlers can change the RIP */
@@ -169,6 +171,7 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	 * layout here.
 	 */
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	jmp ftrace_epilogue
 SYM_FUNC_END(ftrace_caller);
@@ -192,6 +195,7 @@ SYM_FUNC_START(ftrace_regs_caller)
 	/* save_mcount_regs fills in first two parameters */
 
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -221,6 +225,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	leaq (%rsp), %rcx
 
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	call ftrace_stub
 
 	/* Copy flags back to SS, to restore them */
@@ -248,6 +253,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 */
 	testq	%rax, %rax
 SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	jnz	1f
 
 	restore_mcount_regs
@@ -261,6 +267,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	jmp ftrace_epilogue
 
 	/* Swap the flags with orig_rax */
