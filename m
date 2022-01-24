Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47F497CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiAXKH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiAXKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:07:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B811C06173B;
        Mon, 24 Jan 2022 02:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rGu/cVWqjKbmzWm5z1cUS5DKdCStpKhIQFvlPXr3oH8=; b=CwKvv+au3sSLPXpQy/TCrZHQxU
        y7J6x6rF3K+Ea/cuj5iosEJNVPaaD/mPPNaCKdy/qC5EzvZromUcN2uO1yDJ+Dn0mm6/O0aydVD1D
        551ijFJi6+hIWWhXTayb+4OrSC4ht5ZjSWD5NreEEFg/2LuALzbFg2WCIPSMlBQidHcLDirOzMNv0
        c39rSxzScRcI8rEvzqrmX9BC4x9oaF9adr0bjyTSSVa6+71Ulcbpwf1H56PsRuNp+rHrkbXuALn+p
        noONmub4xKIE2/UcTrfJkMQXXMbT7uPYl6VJliu6Vm/YfrckXv+ZdvAHyxwvQ5VDJBRoMOFqoUUvE
        gDZkOYRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBwFd-0038Lz-2D; Mon, 24 Jan 2022 10:07:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2863986245; Mon, 24 Jan 2022 11:07:04 +0100 (CET)
Date:   Mon, 24 Jan 2022 11:07:04 +0100
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
Message-ID: <20220124100704.GC22849@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Yerl+ZrZ2qflIMyg@FVFF77S0Q05N>
 <20220124100306.GO20638@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124100306.GO20638@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:03:06AM +0100, Peter Zijlstra wrote:

> > Either way, it looks like we'd need helpers along the lines of:
> > 
> > | static __always_inline void umcg_enter_from_user(struct pt_regs *regs)
> > | {
> > | 	if (current->flags & PF_UMCG_WORKER)
> > | 		umcg_sys_enter(regs, -1);
> > | }
> > | 
> > | static __always_inline void umcg_exit_to_user(struct pt_regs *regs)
> > | {
> > | 	if (current->flags & PF_UMCG_WORKER)
> > | 		umcg_sys_exit(regs);
> > | }
> 
> Would something like:
> 
> #ifndef arch_irqentry_irq_enter
> static __always_inline bool arch_irqentry_irq_enter(struct pt_regs *regs)
> {
> 	if (!regs_irqs_disabled(regs)) {
> 		local_irq_enable();
> 		return true;
> 	}
> 	return false;
> }
> #endif
> 
> static __always_inline void irqentry_irq_enter(struct pt_regs *regs)
> {
> 	if (arch_irqentry_irq_inherit(regs)) {
> 		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
> 			umcg_sys_enter(regs, -1);
> 	}
> }
> 
> Work? Then arm64 can do:
> 
> static __always_inline bool arch_irqentry_irq_enter(struct pt_regs *regs)
> {
> 	local_daif_inherit();
> 	return interrupts_enabled(regs);
> }
> 
> or somesuch...

Ah,.. just read your other email, so your concern is about the
user_mode() thing due to ARM64 taking a different exception path for
from-user vs from-kernel ?

I don't mind too much if arm64 decides to open-code the umcg hooks, but
please do it such that's hard to forget a spot.
