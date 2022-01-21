Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C85B4960EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381288AbiAUOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:30:41 -0500
Received: from foss.arm.com ([217.140.110.172]:54140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381210AbiAUOaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:30:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C05A101E;
        Fri, 21 Jan 2022 06:30:09 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.1.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08C0C3F766;
        Fri, 21 Jan 2022 06:30:03 -0800 (PST)
Date:   Fri, 21 Jan 2022 14:30:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <YerDaItJQHvMMHIU@FVFF77S0Q05N>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
 <20220119192217.GD43919@C02TD0UTHF1T.local>
 <2688b779-9cb8-b6ea-f8cc-93bc8ddf72f3@redhat.com>
 <YelPnGM4kONm7ZQa@FVFF77S0Q05N>
 <ff673e4e-c395-701f-f891-36ffa260c3bd@linux.ibm.com>
 <85d3899e-7da5-abad-743b-e5d6dde21800@linux.ibm.com>
 <c90abd39-375a-15cc-847a-d1d28115ca97@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c90abd39-375a-15cc-847a-d1d28115ca97@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:17:01PM +0100, Christian Borntraeger wrote:
> 
> 
> Am 21.01.22 um 10:53 schrieb Christian Borntraeger:
> > Am 20.01.22 um 16:14 schrieb Christian Borntraeger:
> > > 
> > > 
> > > Am 20.01.22 um 13:03 schrieb Mark Rutland:
> > > > On Thu, Jan 20, 2022 at 12:28:09PM +0100, Paolo Bonzini wrote:
> > > > > On 1/19/22 20:22, Mark Rutland wrote:
> > > > > > I wonder, is the s390 guest entry/exit*preemptible*  ?
> > > > > > 
> > > > > > If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
> > > > > > things before a ctx-switch to the idle thread, which would then be able
> > > > > > to hit this.
> > > > > > 
> > > > > > I'll need to go audit the other architectures for similar.
> > > > > 
> > > > > They don't enable interrupts in the entry/exit path so they should be okay.
> > > > 
> > > > True.
> > > > 
> > > > So it sounds like for s390 adding an explicit preempt_{disable,enable}() is the
> > > > right thing to do. I'll add that and explanatory commentary.
> > > 
> > > That would not be trivial I guess. We do allow (and need) page faults on sie for guest
> > > demand paging and
> > > 
> > > this piece of arch/s390/mm/fault.c
> > > 
> > >         case GMAP_FAULT:
> > >                  if (faulthandler_disabled() || !mm)
> > >                          goto out;
> > >                  break;
> > >          }
> > > 
> > > would no longer work since faulthandler_disabled checks for the preempt count.
> > > 
> > 
> > 
> > Something like this
> > 
> > 
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index d30f5986fa85..1c7d45346e12 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -385,10 +385,18 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >                          return 0;
> >                  goto out;
> >          case USER_FAULT:
> > -       case GMAP_FAULT:
> >                  if (faulthandler_disabled() || !mm)
> >                          goto out;
> >                  break;
> > +               /*
> > +                * We know that we interrupted SIE and we are not in a IRQ.
> > +                * preemption might be disabled thus checking for in_atomic
> > +                * would result in failures
> > +                */
> > +       case GMAP_FAULT:
> > +               if (pagefault_disabled() || !mm)
> > +                       goto out;
> > +               break;
> >          }
> > 
> >          perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> > 
> > seems to work with preemption disabled around sie. Not sure yet if this is correct.
> 
> 
> No it does not work. scheduling while preemption is disabled.

Hmm... which exceptions do we expect to take from a guest?

I wonder if we can handle those more like other architectures by getting those
to immediately return from the sie64a() call with some status code that we can
handle outside of the guest_state_{enter,exit}_irqoff() critical section.

On arm64 in VHE mode, we swap our exception vectors when entering/exiting the
guest to allow us to do that; I wonder if we could do similar here?

Thanks,
Mark.
