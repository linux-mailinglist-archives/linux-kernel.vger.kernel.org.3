Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66CE497D24
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiAXK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:27:45 -0500
Received: from foss.arm.com ([217.140.110.172]:56804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbiAXK1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:27:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 037446D;
        Mon, 24 Jan 2022 02:27:44 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.2.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEA203F73B;
        Mon, 24 Jan 2022 02:27:40 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:27:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <Ye5/FIlVcym/Fbjs@FVFF77S0Q05N>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Yerl+ZrZ2qflIMyg@FVFF77S0Q05N>
 <20220124100306.GO20638@worktop.programming.kicks-ass.net>
 <20220124100704.GC22849@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124100704.GC22849@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:07:04AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 24, 2022 at 11:03:06AM +0100, Peter Zijlstra wrote:
> 
> > > Either way, it looks like we'd need helpers along the lines of:
> > > 
> > > | static __always_inline void umcg_enter_from_user(struct pt_regs *regs)
> > > | {
> > > | 	if (current->flags & PF_UMCG_WORKER)
> > > | 		umcg_sys_enter(regs, -1);
> > > | }
> > > | 
> > > | static __always_inline void umcg_exit_to_user(struct pt_regs *regs)
> > > | {
> > > | 	if (current->flags & PF_UMCG_WORKER)
> > > | 		umcg_sys_exit(regs);
> > > | }
> > 
> > Would something like:
> > 
> > #ifndef arch_irqentry_irq_enter
> > static __always_inline bool arch_irqentry_irq_enter(struct pt_regs *regs)
> > {
> > 	if (!regs_irqs_disabled(regs)) {
> > 		local_irq_enable();
> > 		return true;
> > 	}
> > 	return false;
> > }
> > #endif
> > 
> > static __always_inline void irqentry_irq_enter(struct pt_regs *regs)
> > {
> > 	if (arch_irqentry_irq_inherit(regs)) {
> > 		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
> > 			umcg_sys_enter(regs, -1);
> > 	}
> > }
> > 
> > Work? Then arm64 can do:
> > 
> > static __always_inline bool arch_irqentry_irq_enter(struct pt_regs *regs)
> > {
> > 	local_daif_inherit();
> > 	return interrupts_enabled(regs);
> > }
> > 
> > or somesuch...
> 
> Ah,.. just read your other email, so your concern is about the
> user_mode() thing due to ARM64 taking a different exception path for
> from-user vs from-kernel ?

Yup; it's two-fold:

1) We have separate vectors for entry from-user and from-kernel, and I'd like
   to avoid the conditionality (e.g. the user_mode(regs) checks) where possible. 
   Having that unconditional and explicit in the from-user code avoids
   redundant work and is much easier to see that it's correct and balanced.

   We have separate irqentry_from_user() and irqentry_from_kernel() helpers
   today for this.

2) Due to the way we nest classes of exception, on the entry path we manipulate
   the flags differently depending on which specific exception we've taken. On
   the return path we always mask everything (necessary due to the way
   exception return works architecturally).

   Luckily exceptions from-user don't nest, so those cases are simpler than
   exceptions from-kernel.

> I don't mind too much if arm64 decides to open-code the umcg hooks, but
> please do it such that's hard to forget a spot.

I'll see what I can do. :)

Thanks,
Mark.
