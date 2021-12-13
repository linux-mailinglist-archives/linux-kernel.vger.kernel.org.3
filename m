Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC69473561
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbhLMT5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhLMT5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:57:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA532C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xU19eSvqDFC859EYkgatoLNxcwch4h6nIr3i8PoRLa0=; b=GTNgdztEwo6ly4Czr2WVdhqY/8
        //BbnOGLbzOAhKenZgl0GKhhxMZ3yRfF34ZcqOC/bZT7/RoeNsrQ83PdsTOBrfYQaW43m54XBP2JC
        bFuo75aYwG0GGaPwGOkBasVFcZY9SjFjOnNOk1hxa6Q7qRH2meu7uoCDa+pCE/vfEd+ZKh5Y1mgIg
        9cw0z328wjYwkBdwP6jlrTC2yIUWD5jQJelseLlbRATzyYJ7AK1/0Ze01sahE3slDAZDoBM5kPI8S
        09B+qZnDduDUIHeKGVyx9LffkKWedXpUV7Tx6SfahGK32AA5h+AZduoH+xVsxCrSAqr4UvAZw8LJz
        joOuZ23Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwrS1-001Azv-GC; Mon, 13 Dec 2021 19:57:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2D16981767; Mon, 13 Dec 2021 20:57:32 +0100 (CET)
Date:   Mon, 13 Dec 2021 20:57:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] x86/hw_breakpoint: Add stack_canary to
 hw_breakpoints denylist
Message-ID: <20211213195732.GA16608@worktop.programming.kicks-ass.net>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213042215.3096-3-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:22:14PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> When stack-protector is enabled, entry functions may access
> to the stack_canary.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/kernel/hw_breakpoint.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index 668a4a6533d9..b2b64afdf9c0 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -315,6 +315,14 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
>  		if (within_area(addr, end, (unsigned long)&per_cpu(cpu_dr7, cpu),
>  				sizeof(cpu_dr7)))
>  			return true;
> +
> +		/*
> +		 * When stack-protector is enabled, entry functions may access
> +		 * to the stack_canary.
> +		 */
> +		if (within_area(addr, end, (unsigned long)&per_cpu(fixed_percpu_data, cpu),
> +				sizeof(struct fixed_percpu_data)))
> +			return true;

Isn't fixed_percpu_data x86_64 only?

>  	}
>  
>  	return false;
