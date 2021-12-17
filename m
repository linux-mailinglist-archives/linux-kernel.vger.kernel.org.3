Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA188478C20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhLQNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:21:55 -0500
Received: from foss.arm.com ([217.140.110.172]:57394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236633AbhLQNVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:21:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3844A12FC;
        Fri, 17 Dec 2021 05:21:50 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 972613F5A1;
        Fri, 17 Dec 2021 05:21:48 -0800 (PST)
Date:   Fri, 17 Dec 2021 13:21:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     maz <maz@kernel.org>, Will Deacon <will@kernel.org>,
        paulmck <paulmck@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        frederic <frederic@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Message-ID: <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:51:57PM +0100, Nicolas Saenz Julienne wrote:
> Hi All,

Hi,

> arm64's guest entry code does the following:
> 
> int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> {
> 	[...]
> 
> 	guest_enter_irqoff();
> 
> 	ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
> 
> 	[...]
> 
> 	local_irq_enable();
> 
> 	/*
> 	 * We do local_irq_enable() before calling guest_exit() so
> 	 * that if a timer interrupt hits while running the guest we
> 	 * account that tick as being spent in the guest.  We enable
> 	 * preemption after calling guest_exit() so that if we get
> 	 * preempted we make sure ticks after that is not counted as
> 	 * guest time.
> 	 */
> 	guest_exit();
> 	[...]
> }
> 
> 
> On a nohz-full CPU, guest_{enter,exit}() delimit an RCU extended quiescent
> state (EQS). Any interrupt happening between local_irq_enable() and
> guest_exit() should disable that EQS. Now, AFAICT all el0 interrupt handlers
> do the right thing if trggered in this context, but el1's won't. Is it
> possible to hit an el1 handler (for example __el1_irq()) there?

I think you're right that the EL1 handlers can trigger here and won't exit the
EQS.

I'm not immediately sure what we *should* do here. What does x86 do for an IRQ
taken from a guest mode? I couldn't spot any handling of that case, but I'm not
familiar enough with the x86 exception model to know if I'm looking in the
right place.

Note that the EL0 handlers *cannot* trigger for an exception taken from a
guest. We use separate vectors while running a guest (for both VHE and nVHE
modes), and from the main kernel's PoV we return from kvm_call_hyp_ret(). We
can ony take IRQ from EL1 *after* that returns.

We *might* need to audit the KVM vector handlers to make sure they're not
dependent on RCU protection (I assume they're not, but it's possible something
has leaked into the VHE code).

Thanks,
Mark.
