Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8F46E847
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhLIMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhLIMVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:21:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F7AC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1gBspGAtm+sBZ+zsGE94F0PCt47ThuxEvpk/nv+3uP0=; b=FLA8hIMklKoSwyozJLoo3D3ZB5
        RSdYl9Ohksnr86f0IT1EbTY61dHD3GBSA42yeieKjVbJCtMNIxWdIJZ+wAIfRe+3B0NtXh78qMBRl
        f/lt/LG/J+f8NQw6kE4M8TzQ7uPesCBFPIS7frBA1wQMPXBelCDxblrtSPuYXVZxsTNOMrXpl2Dqu
        VTvAYatFnNkFFcjZlcAE7VfphZNd6zaMk6LMufejDzrmvqTPuMt72X+G3IohFnjvC+SGxhnZfEUCO
        ksftlDk78pKPPtl4yVD3md16xOfq1ZP7ZKef0y94GBvqlSzeY2Af7sfajvZxaWLRp1TMHfoYlzK08
        hpQoJYhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvIMx-009KiF-NY; Thu, 09 Dec 2021 12:17:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2068F3002DB;
        Thu,  9 Dec 2021 13:17:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F0AB2BB99CAA; Thu,  9 Dec 2021 13:17:52 +0100 (CET)
Date:   Thu, 9 Dec 2021 13:17:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 05/12] x86/mce: Allow instrumentation during task work
 queueing
Message-ID: <YbHz8LGrtVAXTD08@hirez.programming.kicks-ass.net>
References: <20211208111343.8130-1-bp@alien8.de>
 <20211208111343.8130-6-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208111343.8130-6-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 12:13:36PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fixes
> 
>   vmlinux.o: warning: objtool: do_machine_check()+0xdb1: call to queue_task_work() leaves .noinstr.text section
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index f61f14faa532..d7fa444d6282 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1451,6 +1451,14 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  	if (worst != MCE_AR_SEVERITY && !kill_current_task)
>  		goto out;
>  
> +	/*
> +	 * Enable instrumentation around the external facilities like
> +	 * task_work_add() (via queue_task_work()), fixup_exception() etc.
> +	 * For now, that is. Fixing this properly would need a lot more involved
> +	 * reorganization.

The only reason we want to fix that is to limit the amount of code MCE
runs, or is there additional concerns, like perhaps getting #DB traps
from !noinstr code?

> +	 */
> +	instrumentation_begin();
> +
>  	/* Fault was in user mode and we need to take some action */
>  	if ((m.cs & 3) == 3) {
>  		/* If this triggers there is no way to recover. Die hard. */
> @@ -1479,6 +1487,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  		if (m.kflags & MCE_IN_KERNEL_COPYIN)
>  			queue_task_work(&m, msg, kill_me_never);
>  	}
> +
> +	instrumentation_end();
> +
>  out:
>  	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
>  }
> -- 
> 2.29.2
> 
