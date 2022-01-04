Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0CA48424D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiADNYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:24:10 -0500
Received: from foss.arm.com ([217.140.110.172]:59170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbiADNYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:24:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3304C1FB;
        Tue,  4 Jan 2022 05:24:09 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.9.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91CD63F774;
        Tue,  4 Jan 2022 05:24:07 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:24:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, maz <maz@kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Message-ID: <YdRJA79bs1Im7h01@FVFF77S0Q05N>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <20211220161014.GC918551@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220161014.GC918551@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:10:14PM +0100, Frederic Weisbecker wrote:
> On Fri, Dec 17, 2021 at 01:21:39PM +0000, Mark Rutland wrote:
> > On Fri, Dec 17, 2021 at 12:51:57PM +0100, Nicolas Saenz Julienne wrote:
> > > Hi All,
> > 
> > Hi,
> > 
> > > arm64's guest entry code does the following:
> > > 
> > > int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > > {
> > > 	[...]
> > > 
> > > 	guest_enter_irqoff();
> > > 
> > > 	ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
> > > 
> > > 	[...]
> > > 
> > > 	local_irq_enable();
> > > 
> > > 	/*
> > > 	 * We do local_irq_enable() before calling guest_exit() so
> > > 	 * that if a timer interrupt hits while running the guest we
> > > 	 * account that tick as being spent in the guest.  We enable
> > > 	 * preemption after calling guest_exit() so that if we get
> > > 	 * preempted we make sure ticks after that is not counted as
> > > 	 * guest time.
> > > 	 */
> > > 	guest_exit();
> > > 	[...]
> > > }
> > > 
> > > 
> > > On a nohz-full CPU, guest_{enter,exit}() delimit an RCU extended quiescent
> > > state (EQS). Any interrupt happening between local_irq_enable() and
> > > guest_exit() should disable that EQS. Now, AFAICT all el0 interrupt handlers
> > > do the right thing if trggered in this context, but el1's won't. Is it
> > > possible to hit an el1 handler (for example __el1_irq()) there?
> > 
> > I think you're right that the EL1 handlers can trigger here and won't exit the
> > EQS.
> > 
> > I'm not immediately sure what we *should* do here. What does x86 do for an IRQ
> > taken from a guest mode? I couldn't spot any handling of that case, but I'm not
> > familiar enough with the x86 exception model to know if I'm looking in the
> > right place.
> 
> This is one of the purposes of rcu_irq_enter(). el1 handlers don't call irq_enter()?

Due to lockep/tracing/etc ordering, we don't use irq_enter() directly and
instead call rcu_irq_enter() and irq_enter_rcu() separately. Critically we only
call rcu_irq_enter() for IRQs taken from the idle thread, as this was
previously thought to be the only place where we could take an IRQ from an EL1
EQS.

See __el1_irq(), __enter_from_kernel_mode(), and __exit_to_kernel_mode() in
arch/arm64/kernel/entry-common.c. The latter two are largely analogous to the
common irqentry_enter9) and irqentry_exit() helpers in kernel/entry/common.c.

We need to either rework the KVM code or that entry code. I'll dig into this a
bit more...

Thanks,
Mark.
