Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495A3484613
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiADQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:39:28 -0500
Received: from foss.arm.com ([217.140.110.172]:33614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235378AbiADQj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:39:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5941113A1;
        Tue,  4 Jan 2022 08:39:27 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.9.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 638603F774;
        Tue,  4 Jan 2022 08:39:25 -0800 (PST)
Date:   Tue, 4 Jan 2022 16:39:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        paulmck <paulmck@kernel.org>, maz <maz@kernel.org>,
        frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Message-ID: <YdR4N9QVYOzjowAb@FVFF77S0Q05N>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 04:54:22PM +0100, Paolo Bonzini wrote:
> On 12/17/21 15:38, Mark Rutland wrote:
> > For example kvm_guest_enter_irqoff() calls guest_enter_irq_off() which calls
> > vtime_account_guest_enter(), but kvm_guest_exit_irqoff() doesn't call
> > guest_exit_irq_off() and the call to vtime_account_guest_exit() is open-coded
> > elsewhere. Also, guest_enter_irq_off() conditionally calls
> > rcu_virt_note_context_switch(), but I can't immediately spot anything on the
> > exit side that corresponded with that, which looks suspicious.
> 
> rcu_note_context_switch() is a point-in-time notification; it's not strictly
> necessary, but it may improve performance a bit by avoiding unnecessary IPIs
> from the RCU subsystem.
> 
> There's no benefit from doing it when you're back from the guest, because at
> that point the CPU is just running normal kernel code.

I see.

My main issue here was just that it's really difficult to see how the
entry/exit logic is balanced, and I reckon we can solve that by splitting
guest_{enter,exit}_irqoff() into helper functions to handle the vtime
accounting separately from the context tracking, so that arch code can do
something like:

  guest_timing_enter_irqoff();
  
  guest_eqs_enter_irqoff();
  < actually run vCPU here >
  guest_eqs_exit_irqoff();
  
  < handle pending IRQs here >
  
  guest_timing_exit_irqoff();

... which I hope should work for RISC-V too.

I've had a go, and I've pushed out a WIP to:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/kvm/rcu

I also see we'll need to add some lockdep/irq-tracing management to arm64, and
it probably makes sense to fold that into common helpers, so I'll have a play
with that tomorrow.

Thanks,
Mark.
