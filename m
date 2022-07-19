Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9657A1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiGSOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiGSOhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A87B31
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B4A616D3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ACAC341C6;
        Tue, 19 Jul 2022 14:32:02 +0000 (UTC)
Date:   Tue, 19 Jul 2022 10:32:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v2] ftrace/x86: Remove jumps to ftrace_epilogue and simplify
 trampolines
Message-ID: <20220719103201.38cb994c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The jumps to ftrace_epilogue were done as a way to make sure all the
function tracing trampolines ended at the function graph trampoline, as
the ftrace_epilogue was the location that would handle that.

With the advent of function graph tracer now being just one of the
callbacks of the function tracer there is no more requirement that all
trampolines go to a single location.

Remove the jumps to the ftrace_epilogue and replace them with return
statements.

This also means that the return statements can now be part of the
trampoline that gets copied into the dynamically created trampolines. This
simplifies the code to do the copies as it no longer needs to add the
returns to those created trampolines.

Note, the ftrace_epilogue can probably be renamed to ftrace_stub and the
weak logic for that could probably be removed. But lets leave that as a
separate change.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20220718170123.4d4bae4a@gandalf.local.home/

  - Removed the added UNWIND_HINT and ENDBR mark up (Peter Zijlstra)

  - Move the RET into the part of the trampoline that gets copied.
    Change the logic of the creation of the dynamic trampolines
    (that copy this code) to not have to create the RET itself,
    as now the RET gets copied too.

 arch/x86/kernel/ftrace.c    | 18 ++++++------------
 arch/x86/kernel/ftrace_64.S | 15 +++------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 5b4efc927d80..7225ccca94b9 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -301,8 +301,6 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
-#define RET_SIZE		1 + IS_ENABLED(CONFIG_SLS)
-
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 {
@@ -319,7 +317,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	void *ip;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
-	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
 	union ftrace_op_code_union op_ptr;
 	int ret;
 
@@ -341,14 +338,14 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	/*
 	 * Allocate enough size to store the ftrace_caller code,
-	 * the iret , as well as the address of the ftrace_ops this
-	 * trampoline is used for.
+	 * as well as the address of the ftrace_ops this trampoline
+	 * is used for.
 	 */
-	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
+	trampoline = alloc_tramp(size + sizeof(void *));
 	if (!trampoline)
 		return 0;
 
-	*tramp_size = size + RET_SIZE + sizeof(void *);
+	*tramp_size = size + sizeof(void *);
 	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
@@ -356,9 +353,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	if (WARN_ON(ret < 0))
 		goto fail;
 
-	ip = trampoline + size;
-	memcpy(ip, retq, RET_SIZE);
-
 	/* No need to test direct calls on created trampolines */
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
 		/* NOP the jnz 1f; but make sure it's a 2 byte jnz */
@@ -378,7 +372,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 * the global function_trace_op variable.
 	 */
 
-	ptr = (unsigned long *)(trampoline + size + RET_SIZE);
+	ptr = (unsigned long *)(trampoline + size);
 	*ptr = (unsigned long)ops;
 
 	op_offset -= start_offset;
@@ -440,7 +434,7 @@ void set_ftrace_ops_ro(void)
 			end_offset = (unsigned long)ftrace_caller_end;
 		}
 		size = end_offset - start_offset;
-		size = size + RET_SIZE + sizeof(void *);
+		size = size + sizeof(void *);
 		npages = DIV_ROUND_UP(size, PAGE_SIZE);
 		set_memory_ro((unsigned long)ops->trampoline, npages);
 	} while_for_each_ftrace_op(ops);
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index dfeb227de561..6294c14c51c9 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -164,7 +164,7 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
 
 	restore_mcount_regs
-
+	RET
 	/*
 	 * The code up to this label is copied into trampolines so
 	 * think twice before adding any new code or changing the
@@ -172,8 +172,6 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	 */
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-
-	jmp ftrace_epilogue
 SYM_FUNC_END(ftrace_caller);
 STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
@@ -260,16 +258,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	restore_mcount_regs
 	/* Restore flags */
 	popfq
-
-	/*
-	 * As this jmp to ftrace_epilogue can be a short jump
-	 * it must not be copied into the trampoline.
-	 * The trampoline will add the code to jump
-	 * to the return.
-	 */
+	RET
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-	jmp ftrace_epilogue
 
 	/* Swap the flags with orig_rax */
 1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
@@ -280,7 +271,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	/* Restore flags */
 	popfq
 	UNWIND_HINT_FUNC
-	jmp	ftrace_epilogue
+	RET
 
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
-- 
2.35.1

