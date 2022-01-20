Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19139494D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiATL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:57:25 -0500
Received: from foss.arm.com ([217.140.110.172]:35194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbiATL5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:57:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33FA2ED1;
        Thu, 20 Jan 2022 03:57:24 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CAF73F774;
        Thu, 20 Jan 2022 03:57:18 -0800 (PST)
Date:   Thu, 20 Jan 2022 11:57:14 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        bp@alien8.de, catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frankja@linux.ibm.com,
        frederic@kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        james.morse@arm.com, jmattson@google.com, joro@8bytes.org,
        luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Message-ID: <YelOGjuRsMfUb3e7@FVFF77S0Q05N>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
 <20220119192217.GD43919@C02TD0UTHF1T.local>
 <0654e667-1cfa-5147-6661-b3b63288be0b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0654e667-1cfa-5147-6661-b3b63288be0b@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 08:30:17PM +0100, Christian Borntraeger wrote:
> 
> 
> Am 19.01.22 um 20:22 schrieb Mark Rutland:
> > On Wed, Jan 19, 2022 at 07:25:20PM +0100, Christian Borntraeger wrote:
> > > Am 19.01.22 um 11:58 schrieb Mark Rutland:
> > > 
> > > 
> > > CCing new emails for Anup and Atish so that they are aware of this thread.
> > 
> > Ah; whoops. I'd meant to fix the Ccs on the patches.
> > 
> > Thanks!
> > 
> > [...]
> > 
> > > I just gave this a spin on s390 with debugging on and I got the following:
> > > 
> > > [  457.151295] ------------[ cut here ]------------
> > > [  457.151311] WARNING: CPU: 14 PID: 0 at kernel/rcu/tree.c:613 rcu_eqs_enter.constprop.0+0xf8/0x118
> > 
> > Hmm, so IIUC that's:
> > 
> > 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
> > 
> > ... and we're clearly in the idle thread here.
> > 
> > I wonder, is the s390 guest entry/exit *preemptible* ?
> 
> Looks like debug_defconfig is indeed using preemption:
> 
> CONFIG_PREEMPT_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACE_PREEMPT_TOGGLE=y
> CONFIG_PREEMPT_TRACER=y
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set

Thanks for confirming!

Could you try with CONFIG_PROVE_RCU=y ? That can't be selected directly, but
selecting PROVE_LOCKING=y will enable it.

If I'm right, with that we should get a splat out of
rcu_irq_exit_check_preempt().

If so, I think we can solve this with preempt_{disable,enable}() around the
guest_timing_{enter,exit}_irqoff() calls. We'll also need to add some more
comments around arch_in_rcu_eqs() that arch-specific EQSs should be
non-preemptible.

Thanks,
Mark.
