Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF64CB83A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiCCIBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiCCIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:01:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B92169395
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C10StLcKzqZa6Kx2wItteMeScaJFaTX+CwrTCd5Ik/M=; b=cqFuuxvtzRL4atysAcLU7hCndL
        +MfDyjrP0SW/HC+PWsOPmiwCRJ3QGXuu1ULw2ya4tnAKXBFfeUZB9UdBmAtHx4gy/ZLQN7wOnYtcd
        3WA05P+PPpb87remYjc6Fm/IRJ1bd/q7TvG7UevPxq8yDrFZHTJbpW25ZTZpD44uWer5VeW1c18D8
        ZfgcgpBTiQWcN1W3cmPKOtFFbg3Unx0VZq+lGN/OjWksyeXKG7ximcIXNBiImE6+NDGz/ttfU7GWD
        0u9pPxdtU02uTBYdDKc5FUcoGL5m+dFMRDHI5STrvhkW6M+y+0E30wTugq2yBARhjsNYSOnX3N9zU
        R5Y7auNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPgNm-00ErCE-K7; Thu, 03 Mar 2022 08:00:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3EBA30022D;
        Thu,  3 Mar 2022 09:00:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E87820285CE8; Thu,  3 Mar 2022 09:00:16 +0100 (CET)
Date:   Thu, 3 Mar 2022 09:00:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2 2/7] x86/entry: Switch the stack after error_entry()
 returns
Message-ID: <YiB1kC7rzwoIQiL4@hirez.programming.kicks-ass.net>
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
 <20220303035434.20471-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303035434.20471-3-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:54:29AM +0800, Lai Jiangshan wrote:
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
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/entry/entry_64.S | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 24846284eda5..a51cad2b7fff 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -323,6 +323,8 @@ SYM_CODE_END(ret_from_fork)
>  .macro idtentry_body cfunc has_error_code:req
>  
>  	call	error_entry
> +	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
> +	ENCODE_FRAME_POINTER
>  	UNWIND_HINT_REGS
>  
>  	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
> @@ -980,14 +982,10 @@ SYM_CODE_START_LOCAL(error_entry)
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
> @@ -1019,6 +1017,7 @@ SYM_CODE_START_LOCAL(error_entry)
>  	 */
>  .Lerror_entry_done_lfence:
>  	FENCE_SWAPGS_KERNEL_ENTRY
> +	leaq	8(%rsp), %rax			/* return pt_regs pointer */
>  	RET
>  
>  .Lbstep_iret:
> @@ -1039,12 +1038,9 @@ SYM_CODE_START_LOCAL(error_entry)
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

I can't seem to follow; perhaps I need more wake-up-juice?

Suppose we have .Lerror_bad_iret, then the code flow is something like:


	old						new

.Lerror_bad_iret
				SWAWPGS business

	popq	%r12					leaq	8(%rsp), %rsi
	movq	%rsp, %rdi
	call	fixup_bad_iret				call	fixup_bad_iret
	mov	%rax, %rsp				mov	%rax, %rdi
	ENCODE_FRAME_POINTER
	pushq	%r12

		jmp	.Lerror_entry_from_usermode_after_swapgs

.Lerror_entry_from_usermode_after_swapgs
	pop	%r12
	movq	%rsp, %rdi
	call	sync_regs				call	sync_regs
	mov	%rax, %rsp
	ENCODE_FRAME_POINTER
	push	%r12
	RET						RET


The thing that appears to me is that syn_regs is called one stack switch
short. This isn't mentioned in the Changelog nor in the comments. Why is
this OK?




