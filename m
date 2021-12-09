Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72146E83D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhLIMUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhLIMUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:20:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53DCC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jq3xq/nvjt8oiQvE+CsLb1XjZN9u+9za66Ekyj2kiFw=; b=JFwR2ar6LXupuYTiL18OZ57ftZ
        GYNwiFddouK7DRpOOORVqlBcrE/95mf5znZhYwVSF5J06jPSR5Vylc0XIgCAhtsYZKFUWQQfXTM8d
        teo1/Pzc2JYRP1dckaZzZJ2Ix8J+fsApqLfHv0VOiqHRM9cBpKZt49RRXzpuag+0HimlDJhE6V6RW
        GcWEovX4keIffubrguy0w/94+Jzzs0tQOhGacX22Ax/3N0dbEvKO1LRy7c1kTGI6QUmQ60mBTIoXB
        ZuWqZ6JK07jf27pUzdBuIuNFZ6dirYAo0E9H/6Hj1ApSxghD2L8OFl672gY7/90gAnmuDDrkx8HX1
        mSCBk3Rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvIM4-009Kfy-Ab; Thu, 09 Dec 2021 12:16:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44501300079;
        Thu,  9 Dec 2021 13:16:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D9C52BB99CBE; Thu,  9 Dec 2021 13:16:56 +0100 (CET)
Date:   Thu, 9 Dec 2021 13:16:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 04/12] x86/mce: Remove noinstr annotation from
 mce_setup()
Message-ID: <YbHzuJmDXJ/ryWR6@hirez.programming.kicks-ass.net>
References: <20211208111343.8130-1-bp@alien8.de>
 <20211208111343.8130-5-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208111343.8130-5-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 12:13:35PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Instead, sandwitch around the call which is done in noinstr context and
> mark the caller - mce_gather_info() - as noinstr.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 87a277fc80b4..f61f14faa532 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -127,7 +127,7 @@ static struct irq_work mce_irq_work;
>  BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
>  
>  /* Do initial initialization of a struct mce */
> -noinstr void mce_setup(struct mce *m)
> +void mce_setup(struct mce *m)
>  {
>  	memset(m, 0, sizeof(struct mce));
>  	m->cpu = m->extcpu = smp_processor_id();
> @@ -430,9 +430,15 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
>   * check into our "mce" struct so that we can use it later to assess
>   * the severity of the problem as we read per-bank specific details.
>   */
> -static inline void mce_gather_info(struct mce *m, struct pt_regs *regs)
> +static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
>  {
> +	/*
> +	 * Enable instrumentation around mce_setup() which calls external
> +	 * facilities.

Yeah, that's what it does; but *why* is that correct? I'm thinking we're
well past the exception entry code and are only using noinstr as a means
to limit the amount of code in the MCE handler?

> +	 */
> +	instrumentation_begin();
>  	mce_setup(m);
> +	instrumentation_end();
>  
>  	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
>  	if (regs) {
> -- 
> 2.29.2
> 
