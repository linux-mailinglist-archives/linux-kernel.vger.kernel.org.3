Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047B0497CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiAXKDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiAXKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:03:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B236C06173B;
        Mon, 24 Jan 2022 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H6LcKSehcG3T/G89t5l/X+r5xRWoUbyAIud7gmEk2Ns=; b=AI1SH0yWSYHRGtVDmwlkZmfGts
        HB+d4rBh7HItjzsOBEar6kBuVbDGa3spuoIvOz/we8xbedmKSrqC6eF+3peimc27upL4/kFX+6fJJ
        NCv+1F15l7r0fJPA/j9jd0fZymXwgC3KCYKBXd+HFxf2WriPXODLbwsA6v3d82q4Xx7FU8RBMoKuD
        EfsXNGyCTyx/O/uLjbr3ZF6PLl/5faGeeiPtU8n3Wz7EN8eboCmUTXGYcKQPUyuE2yRIcWEz4zKHR
        8zsMk1tiO2+hP/IOPUQbQ2IppkXJUo+qwEsUB21dE8y4cAcsGgNUajoJnPrQXZrI9q9J97RZnizpr
        WxaifpMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBwBn-000RjR-KF; Mon, 24 Jan 2022 10:03:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC413986245; Mon, 24 Jan 2022 11:03:06 +0100 (CET)
Date:   Mon, 24 Jan 2022 11:03:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <20220124100306.GO20638@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Yerl+ZrZ2qflIMyg@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yerl+ZrZ2qflIMyg@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 04:57:29PM +0000, Mark Rutland wrote:

> > @@ -221,8 +227,11 @@ static inline void local_irq_disable_exi
> >   */
> >  static inline void irqentry_irq_enable(struct pt_regs *regs)
> >  {
> > -	if (!regs_irqs_disabled(regs))
> > +	if (!regs_irqs_disabled(regs)) {
> >  		local_irq_enable();
> > +		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
> > +			umcg_sys_enter(regs, -1);
> > +	}
> >  }
> 
> Perhaps it would make sense to have separate umcg_sys_enter(regs) and
> umcg_sys_enter_syscall(regs, syscallno)? Even if the former is just a wrapper,
> to make the entry/exit bits clearly correspond for all the !syscall cases?

Can do I suppose.

> Also, is the syscall case meant to nest within this, or syscall entry paths not
> supposed to call irqentry_irq_enable() ?

No nesting, syscall_ vs irqentry_. And you can't have a syscall and an
exception both be from user at the same time :-)

> >  /**
> > @@ -232,8 +241,11 @@ static inline void irqentry_irq_enable(s
> >   */
> >  static inline void irqentry_irq_disable(struct pt_regs *regs)
> >  {
> > -	if (!regs_irqs_disabled(regs))
> > +	if (!regs_irqs_disabled(regs)) {
> > +		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
> > +			umcg_sys_exit(regs);
> >  		local_irq_disable();
> > +	}
> >  }
> 
> Do the umcg_sys_{enter,exit}() calls need to happen with IRQs unmasked?

Yes; both can end up blocking.

> * If not (and this nests): for arm64 these can live in our
>   enter_from_user_mode() and exit_to_user_mode() helpers.
> 
> * If so (or this doesn't nest): for arm64 we'd need to rework our
>   local_daif_{inherit,restore,mask}() calls to handle this, though I've been
>   meaning to do that anyway to handle pseudo-NMI better.
> 
> Either way, it looks like we'd need helpers along the lines of:
> 
> | static __always_inline void umcg_enter_from_user(struct pt_regs *regs)
> | {
> | 	if (current->flags & PF_UMCG_WORKER)
> | 		umcg_sys_enter(regs, -1);
> | }
> | 
> | static __always_inline void umcg_exit_to_user(struct pt_regs *regs)
> | {
> | 	if (current->flags & PF_UMCG_WORKER)
> | 		umcg_sys_exit(regs);
> | }

Would something like:

#ifndef arch_irqentry_irq_enter
static __always_inline bool arch_irqentry_irq_enter(struct pt_regs *regs)
{
	if (!regs_irqs_disabled(regs)) {
		local_irq_enable();
		return true;
	}
	return false;
}
#endif

static __always_inline void irqentry_irq_enter(struct pt_regs *regs)
{
	if (arch_irqentry_irq_inherit(regs)) {
		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
			umcg_sys_enter(regs, -1);
	}
}

Work? Then arm64 can do:

static __always_inline bool arch_irqentry_irq_enter(struct pt_regs *regs)
{
	local_daif_inherit();
	return interrupts_enabled(regs);
}

or somesuch...
