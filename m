Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D844952FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377273AbiATRQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:16:01 -0500
Received: from foss.arm.com ([217.140.110.172]:45806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243820AbiATRQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:16:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22100ED1;
        Thu, 20 Jan 2022 09:16:00 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87C573F73D;
        Thu, 20 Jan 2022 09:15:54 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:15:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup.patel@wdc.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: Re: [PATCH v2 4/7] kvm/mips: rework guest entry logic
Message-ID: <20220120171551.GB15464@C02TD0UTHF1T.local>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-5-mark.rutland@arm.com>
 <20220120164455.GA15464@C02TD0UTHF1T.local>
 <a2b628b4-907c-4e15-df91-18c0db099228@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b628b4-907c-4e15-df91-18c0db099228@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 05:57:05PM +0100, Paolo Bonzini wrote:
> On 1/20/22 17:44, Mark Rutland wrote:
> > On Wed, Jan 19, 2022 at 10:58:51AM +0000, Mark Rutland wrote:
> > > In kvm_arch_vcpu_ioctl_run() we use guest_enter_irqoff() and
> > > guest_exit_irqoff() directly, with interrupts masked between these. As
> > > we don't handle any timer ticks during this window, we will not account
> > > time spent within the guest as guest time, which is unfortunate.
> > > 
> > > Additionally, we do not inform lockdep or tracing that interrupts will
> > > be enabled during guest execution, which caan lead to misleading traces
> > > and warnings that interrupts have been enabled for overly-long periods.
> > > 
> > > This patch fixes these issues by using the new timing and context
> > > entry/exit helpers to ensure that interrupts are handled during guest
> > > vtime but with RCU watching, with a sequence:
> > > 
> > > 	guest_timing_enter_irqoff();
> > > 
> > > 	guest_state_enter_irqoff();
> > > 	< run the vcpu >
> > > 	guest_state_exit_irqoff();
> > > 
> > > 	< take any pending IRQs >
> > > 
> > > 	guest_timing_exit_irqoff();
> > 
> > Looking again, this patch isn't sufficient.
> > 
> > On MIPS a guest exit will be handled by kvm_mips_handle_exit() *before*
> > returning into the "< run the vcpu >" step above, so we won't call
> > guest_state_exit_irqoff() before using RCU, etc.
> 
> Indeed.  kvm_mips_handle_exit has a weird mutual recursion through runtime-assembled code, but then this is MIPS...
> 
> This should do it:
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index e59cb6246f76..6f2291f017f5 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1192,6 +1192,7 @@ int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
>  	kvm_mips_set_c0_status();
>  	local_irq_enable();
> +	guest_timing_exit_irqoff();
>  	kvm_debug("kvm_mips_handle_exit: cause: %#x, PC: %p, kvm_run: %p, kvm_vcpu: %p\n",
>  			cause, opc, run, vcpu);
> @@ -1325,6 +1326,7 @@ int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
>  	}
>  	if (ret == RESUME_GUEST) {
> +		guest_timing_enter_irqoff();
>  		trace_kvm_reenter(vcpu);
>  		/*

As above, we'll also need the guest_state_{enter,exit}() calls
surrounding this (e.g. before that local_irq_enable() at the start of
kvm_mips_handle_exit(), and that needs to happen in noinstr code, etc.

It looks like the simplest thing to do is to rename
kvm_mips_handle_exit() to __kvm_mips_handle_exit() and add a
kvm_mips_handle_exit() wrapper that handles that (with the return path
conditional on whether __kvm_mips_handle_exit() returns RESUME_GUEST).

I'll have a go at that tomorrow when I regain the capability to think.

Longer-term MIPS should move to a loop like everyone else has:

	for (;;) {
		status = kvm_mips_enter_exit_vcpu();

		if (handle_exit(status))
			break;
		
		...
	}

... which is far easier to manage.

Thanks,
Mark.
