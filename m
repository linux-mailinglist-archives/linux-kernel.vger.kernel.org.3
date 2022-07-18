Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E81578C50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiGRVBc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jul 2022 17:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiGRVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0E32075
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C88DA61380
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E4DC341C0;
        Mon, 18 Jul 2022 21:01:25 +0000 (UTC)
Date:   Mon, 18 Jul 2022 17:01:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch 36/38] x86/ftrace: Make it call depth tracking aware
Message-ID: <20220718170123.4d4bae4a@gandalf.local.home>
In-Reply-To: <20220716230954.835254576@linutronix.de>
References: <20220716230344.239749011@linutronix.de>
        <20220716230954.835254576@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2022 01:18:08 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> @@ -280,7 +291,19 @@ SYM_INNER_LABEL(ftrace_regs_caller_end,
>  	/* Restore flags */
>  	popfq
>  	UNWIND_HINT_FUNC
> -	jmp	ftrace_epilogue
> +
> +	/*
> +	 * Since we're effectively emulating a tail-call with PUSH;RET
> +	 * make sure we don't unbalance the RSB and mess up accounting.
> +	 */
> +	ANNOTATE_INTRA_FUNCTION_CALL
> +	call	2f
> +	int3
> +2:
> +	add	$8, %rsp
> +	ALTERNATIVE __stringify(RET), \
> +		    __stringify(ANNOTATE_UNRET_SAFE; ret; int3), \
> +		    X86_FEATURE_CALL_DEPTH
>  
>  SYM_FUNC_END(ftrace_regs_caller)

Would this code be simpler if we nuked the ftrace_epilogue altogether?

After commit 0c0593b45c9b ("x86/ftrace: Make function graph use ftrace
directly"), the ftrace_epilogue is no longer needed. That was there to make
sure all the trampolines would call the function graph tracer. But now that
function graph tracing is just another ftrace caller, it's not needed
anymore.

Something like the below. It booted and passed the ftrace kselftests.

Feel free to include this in your series.

-- Steve

From 533f10bd48ffbc4ee5d2a07f0a7fe99aeb1c823a Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Mon, 18 Jul 2022 16:01:07 -0400
Subject: [PATCH] ftrace/x86: Remove jumps to ftrace_epilogue

The jumps to ftrace_epilogue were done as a way to make sure all the
function tracing trampolines ended at the function graph trampoline, as
the ftrace_epilogue was the location that it would handle that.

With the advent of function graph tracer now being just one of the
callbacks of the function tracer there is no more requirement that all
trampolines go to a single location.

Remove the jumps to the ftrace_epilogue and replace them with return
statements.

Note, the ftrace_epilogue can probably be renamed to ftrace_stub and the
weak logic for that could probably be removed. But lets leave that as a
separate change.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace_64.S | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index dfeb227de561..8f225fafa5fb 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -173,7 +173,9 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 
-	jmp ftrace_epilogue
+	UNWIND_HINT_FUNC
+	ENDBR
+	RET
 SYM_FUNC_END(ftrace_caller);
 STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
@@ -261,15 +263,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	/* Restore flags */
 	popfq
 
-	/*
-	 * As this jmp to ftrace_epilogue can be a short jump
-	 * it must not be copied into the trampoline.
-	 * The trampoline will add the code to jump
-	 * to the return.
-	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-	jmp ftrace_epilogue
+	jmp 2f
 
 	/* Swap the flags with orig_rax */
 1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
@@ -279,8 +275,10 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	restore_mcount_regs 8
 	/* Restore flags */
 	popfq
+2:
 	UNWIND_HINT_FUNC
-	jmp	ftrace_epilogue
+	ENDBR
+	RET
 
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
-- 
2.35.1

