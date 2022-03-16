Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5994DB486
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357198AbiCPPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357210AbiCPPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:12:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB406B095
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qQRAN0Xs3YAUDhKSU3+6HRqdE/8JI++H7hjPd3Bn0b0=; b=GK7N5ubPpSETgVgfFaVT2BNjCz
        FZJlChfMvWHBRQJghNPw/nKDs2pOHwffSE4P+sFc8KAT7XXKtBk2X4IY5QdF0WBhuBIvgRs02bkhb
        dC91EBUzv/BctuMOqzNz7d1/1Zn9x1TG6SgzkWGbK+BzqbvrzDdUBuLbnOCofgUpXcM3rfdTIocnH
        nl0HuuVp9IcMyGi4lunmJ/tOLjN67VLisNmDxnUwYP3LWs1Ls33k+xqjxRIN9nOHWwaMmtwkwslEU
        J4Jjr47Ls3Nc0Yrm2okAYe2G23C8IuXM8GtVr9lFHr6dabyL8WjVxy0+jnEixMerMoEVn9/5DSRDw
        BmrV39SA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUVHF-0065Ds-Am; Wed, 16 Mar 2022 15:09:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB2F930021B;
        Wed, 16 Mar 2022 16:09:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2DF92C47F84E; Wed, 16 Mar 2022 16:09:28 +0100 (CET)
Date:   Wed, 16 Mar 2022 16:09:28 +0100
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
Subject: Re: [PATCH V3 6/7] x86/entry: Don't call error_entry for XENPV
Message-ID: <YjH9qCkeCXZ4XjLx@hirez.programming.kicks-ass.net>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
 <20220315073949.7541-7-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315073949.7541-7-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:39:48PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> When in XENPV, it is already in the task stack, and it can't fault
> for native_iret() nor native_load_gs_index() since XENPV uses its own
> pvops for iret and load_gs_index().  And it doesn't need to switch CR3.
> So there is no reason to call error_entry() in XENPV.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/entry/entry_64.S | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e4a07276fd1c..ec885c2107de 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -328,8 +328,17 @@ SYM_CODE_END(ret_from_fork)
>  	PUSH_AND_CLEAR_REGS
>  	ENCODE_FRAME_POINTER
>  
> -	call	error_entry
> -	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
> +	/*
> +	 * Call error_entry and switch stack settled by sync_regs().
> +	 *
> +	 * When in XENPV, it is already in the task stack, and it can't fault
> +	 * for native_iret() nor native_load_gs_index() since XENPV uses its
> +	 * own pvops for iret and load_gs_index().  And it doesn't need to
> +	 * switch CR3.  So it can skip invoking error_entry().
> +	 */
> +	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
> +		"", X86_FEATURE_XENPV
> +
>  	ENCODE_FRAME_POINTER
>  	UNWIND_HINT_REGS
>  

Oooh, here we go, this is the answer to my question for patch #1, a note
in the changelog might be nice. Something like:

"This looses a Xen PV optimization, which will be restored in a later
patch. The superfluous stack switch is just that."
