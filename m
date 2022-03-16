Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79574DB3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350288AbiCPPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbiCPPHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:07:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798413F89
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b52YCWijBdgiWy8YQpKsFW1QFuz5Nt4kd+/HK/JJDiU=; b=AfZCLpaS5g1OYbincZmji6Ix6A
        KwU9XjqdqImYGx7u6Vdaze6I0xADHlQsuxlQV+Y7rnHZjNcA5MeQXsHEvAExKn9EHhORn0h3Z639T
        h1I1n6IMhoRMaJH+GiztLvvZdK2XYYt+V3NSut5qaAy1KPdH29MLXGfHAUY5yEbOLzUqxCd0aaVqs
        qerb2LS/EhJ93FE4t2jhkHudI8DsVrqP83NsBouyJPxEF+5v8Zgy4DYJUFIJshGTYUag02n7EbrDQ
        vmGMgJmo7gcfTQ9ZXL1bTkhX/fvXH+MgSSAAGI5NMqABmi3f6f+iuz4+b+VIEYl6X2Z65rMcwlhG8
        15dulC/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUVDY-0064u2-SB; Wed, 16 Mar 2022 15:05:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D44830021B;
        Wed, 16 Mar 2022 16:05:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47F442C47F84B; Wed, 16 Mar 2022 16:05:40 +0100 (CET)
Date:   Wed, 16 Mar 2022 16:05:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V3 3/7] x86/entry: Switch the stack after error_entry()
 returns
Message-ID: <YjH8xJ3MKosyUl7M@hirez.programming.kicks-ass.net>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
 <20220315073949.7541-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315073949.7541-4-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:39:45PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> error_entry() calls sync_regs() to settle/copy the pt_regs and switches
> the stack directly after sync_regs().  But error_entry() itself is also
> a function call, the switching has to handle the return address of it
> together, which causes the work complicated and tangly.
> 
> Switching to the stack after error_entry() makes the code simpler and
> intuitive.
> 
> The behavior/logic is unchanged:
>   1) (opt) feed fixup_bad_iret() with the pt_regs pushed by ASM code
>   2) (opt) fixup_bad_iret() moves the partial pt_regs up
>   3) feed sync_regs() with the pt_regs pushed by ASM code or returned
>      by fixup_bad_iret()
>   4) sync_regs() copies the whole pt_regs to kernel stack if needed
>   5) after error_entry() and switching %rsp, it is in kernel stack with
>      the pt_regs
> 
> Changes only in calling:
>   Old code switches to copied pt_regs immediately twice in
>   error_entry() while new code switches to the copied pt_regs only
>   once after error_entry() returns.
>   It is correct since sync_regs() doesn't need to be called close
>   to the pt_regs it handles.
> 
>   Old code stashes the return-address of error_entry() in a scratch
>   register and new code doesn't stash it.
>   It relies on the fact that fixup_bad_iret() and sync_regs() don't
>   corrupt the return-address of error_entry() on the stack.  But even
>   the old code also relies on the fact that fixup_bad_iret() and
>   sync_regs() don't corrupt the return-address of themselves.
>   They are the same reliances and are assured.
> 
> After this change, error_entry() will not do fancy things with the stack
> except when in the prolog which will be fixed in the next patch ("move
> PUSH_AND_CLEAR_REGS out of error_entry").  This patch and the next patch
> can't be swapped because the next patch relies on this patch's stopping
> fiddling with the return-address of error_entry(), otherwise the objtool
> would complain.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/entry/entry_64.S | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 37505331b7f1..7768cdd0c7ed 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -326,6 +326,8 @@ SYM_CODE_END(ret_from_fork)
>  .macro idtentry_body cfunc has_error_code:req
>  
>  	call	error_entry
> +	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
> +	ENCODE_FRAME_POINTER
>  	UNWIND_HINT_REGS
>  
>  	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
> @@ -1014,14 +1016,10 @@ SYM_CODE_START_LOCAL(error_entry)
>  	/* We have user CR3.  Change to kernel CR3. */
>  	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
>  
> +	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
>  .Lerror_entry_from_usermode_after_swapgs:
>  	/* Put us onto the real thread stack. */
> -	popq	%r12				/* save return addr in %12 */
> -	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
>  	call	sync_regs
> -	movq	%rax, %rsp			/* switch stack */
> -	ENCODE_FRAME_POINTER
> -	pushq	%r12
>  	RET
>  
>  	/*
> @@ -1053,6 +1051,7 @@ SYM_CODE_START_LOCAL(error_entry)
>  	 */
>  .Lerror_entry_done_lfence:
>  	FENCE_SWAPGS_KERNEL_ENTRY
> +	leaq	8(%rsp), %rax			/* return pt_regs pointer */
>  	RET
>  
>  .Lbstep_iret:
> @@ -1073,12 +1072,9 @@ SYM_CODE_START_LOCAL(error_entry)
>  	 * Pretend that the exception came from user mode: set up pt_regs
>  	 * as if we faulted immediately after IRET.
>  	 */
> -	popq	%r12				/* save return addr in %12 */
> -	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
> +	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
>  	call	fixup_bad_iret
> -	mov	%rax, %rsp
> -	ENCODE_FRAME_POINTER
> -	pushq	%r12
> +	mov	%rax, %rdi
>  	jmp	.Lerror_entry_from_usermode_after_swapgs
>  SYM_CODE_END(error_entry)

So the new Changelog doesn't seem to help me much. But looking at both
fixup_bad_iret() and sync_regs(), they both have:

  __this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1

as hard-coded destination. Now, fixup_bad_iret() sets up a complete
ptregs there and then returns a pointer to this stack.

sync_regs otoh, does a straight up pt_regs sized copy from arg0 to this
new stack.

Therefore it appears to me that doing sync_regs() after fixup_bad_iret()
is a complete NO-OP and only confuses things further.

Would not something like the below clarify things?

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1004,6 +1004,7 @@ SYM_CODE_START_LOCAL(error_entry)
 .Lerror_entry_from_usermode_after_swapgs:
 	/* Put us onto the real thread stack. */
 	call	sync_regs
+.Lerror_entry_from_usermode_after_sync_regs:
 	RET
 
 	/*
@@ -1058,8 +1059,12 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
-	mov	%rax, %rdi
-	jmp	.Lerror_entry_from_usermode_after_swapgs
+	/*
+	 * fixup_bad_iret() will have setup pt_regs on the thread stack, and
+	 * returns a pointer to that stack exactly like sync_regs() would've
+	 * done. As such, calling sync_regs again makes no sense.
+	 */
+	jmp	.Lerror_entry_from_usermode_after_sync_regs
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)
