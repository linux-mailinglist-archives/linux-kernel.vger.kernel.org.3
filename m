Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687E64634CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhK3Mx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:53:59 -0500
Received: from foss.arm.com ([217.140.110.172]:37236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhK3Mx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:53:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 781E41042;
        Tue, 30 Nov 2021 04:50:38 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA15C3F5A1;
        Tue, 30 Nov 2021 04:50:36 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:50:30 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>,
        paulmck@kernel.org
Subject: Re: Question WRT early IRQ/NMI entry code
Message-ID: <YaYeFu4hi3uVkhkN@FVFF77S0Q05N>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 12:28:41PM +0100, Nicolas Saenz Julienne wrote:
> Hi All,

Hi Nicolas,

> while going over the IRQ/NMI entry code I've found a small 'inconsistency':
> while in the IRQ entry path, we inform RCU of the context change *before*
> incrementing the preempt counter, the opposite happens for the NMI entry
> path. This applies to both arm64 and x86[1].

For arm64, the style was copied from the x86 code, and (AFAIK) I had no
particular reason for following either order other than consistency with x86.

> Actually, rcu_nmi_enter() — which is also the main RCU context switch function
> for the IRQ entry path — uses the preempt counter to verify it's not in NMI
> context. So it would make sense to assume all callers have the same updated
> view of the preempt count, which isn't true ATM.

I agree consistency would be nice, assuming there's no issue preventing us from
moving the IRQ preempt_count logic earlier.

It sounds like today the ordering is only *required* when entering an NMI, and
we already do the right thing there. Do you see a case where something would go
wrong (or would behave differently with the flipped ordering) for IRQ today?

> I'm sure there an obscure/non-obvious reason for this, right?

TBH I suspect this is mostly oversight / legacy, and likely something we can
tighten up.

Thanks,
Mark.

> 
> Thanks!
> Nicolas
> 
> [1] 
> IRQ path:
>   -> x86_64 asm (entry_64.S)
>   -> irqentry_enter() -> rcu_irq_enter() -> *rcu_nmi_enter()*
>   -> run_irq_on_irqstack_cond() -> irq_exit_rcu() -> *preempt_count_add(HARDIRQ_OFFSET)*
>   -> // Run IRQ...
> 
> NMI path:
>   -> x86_64 asm (entry_64.S)
>   -> irqentry_nmi_enter() -> __nmi_enter() -> *__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET)*
>                           -> *rcu_nmi_enter()*
> 
> For arm64, see 'arch/arm64/kernel/entry-common.c'.
> 
