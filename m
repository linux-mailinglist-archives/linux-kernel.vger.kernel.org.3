Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A357957D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiGSIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiGSIrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:47:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95843C8D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RbC7r/8tl7S857TrfZUiVTy6Kp8fldCLgj8I0D47eic=; b=nw//0fW4KEcP6UVVmEKaLS/dyG
        zEp1Y9mm0KW0dAkPUb+PQWVgY4fw8K/thPcnyp4Ma/ljSOJ9x4I/us0JEa4y/tIg8a9Vpq4sGYNJH
        5slfzT5HuJtcf2FspyogvoU+PYh4tV9n0MMkQeGHeUaQD9NDGFrZYuUSwsrqZuKZQ4QCHKh5E1tDG
        k7i5bDxVA3BzClHkdcNLrj/FqA35gBsyeXKq4dGhbXp5bjmebOZjeLwYbABRomvl5Sz/sTpHkGCsU
        Va8ymSVhp6Y1OKdY3XvFiFqa9wz8I2/XhUiYR94maZZrDKE7cUEDI3g45AH5Azf9cHrIoYreEjLHZ
        vhR/zi0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDisT-00520J-39; Tue, 19 Jul 2022 08:46:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 574AB9802A7; Tue, 19 Jul 2022 10:46:48 +0200 (CEST)
Date:   Tue, 19 Jul 2022 10:46:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>
Subject: Re: [patch 36/38] x86/ftrace: Make it call depth tracking aware
Message-ID: <YtZveA3tTi902Dbv@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <20220716230954.835254576@linutronix.de>
 <20220718170123.4d4bae4a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718170123.4d4bae4a@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 05:01:23PM -0400, Steven Rostedt wrote:

> From 533f10bd48ffbc4ee5d2a07f0a7fe99aeb1c823a Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Date: Mon, 18 Jul 2022 16:01:07 -0400
> Subject: [PATCH] ftrace/x86: Remove jumps to ftrace_epilogue
> 
> The jumps to ftrace_epilogue were done as a way to make sure all the
> function tracing trampolines ended at the function graph trampoline, as
> the ftrace_epilogue was the location that it would handle that.
> 
> With the advent of function graph tracer now being just one of the
> callbacks of the function tracer there is no more requirement that all
> trampolines go to a single location.
> 
> Remove the jumps to the ftrace_epilogue and replace them with return
> statements.
> 
> Note, the ftrace_epilogue can probably be renamed to ftrace_stub and the
> weak logic for that could probably be removed. But lets leave that as a
> separate change.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/kernel/ftrace_64.S | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index dfeb227de561..8f225fafa5fb 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -173,7 +173,9 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>  SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
>  	ANNOTATE_NOENDBR
>  
> -	jmp ftrace_epilogue
> +	UNWIND_HINT_FUNC
> +	ENDBR

Only the RET should do I think; you definitely don't need an ENDBR here
nor do you need to override the unwind hint. Lemme try..

Yeah, the below is sufficient:

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index dfeb227de561..d6679b65b6f2 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -172,8 +172,7 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	 */
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-
-	jmp ftrace_epilogue
+	RET
 SYM_FUNC_END(ftrace_caller);
 STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
@@ -269,7 +268,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-	jmp ftrace_epilogue
+	RET
 
 	/* Swap the flags with orig_rax */
 1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
@@ -280,7 +279,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	/* Restore flags */
 	popfq
 	UNWIND_HINT_FUNC
-	jmp	ftrace_epilogue
+	RET
 
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
