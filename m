Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051C4494D97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiATMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:03:50 -0500
Received: from foss.arm.com ([217.140.110.172]:35446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbiATMDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:03:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1190ED1;
        Thu, 20 Jan 2022 04:03:48 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412283F774;
        Thu, 20 Jan 2022 04:03:43 -0800 (PST)
Date:   Thu, 20 Jan 2022 12:03:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <YelPnGM4kONm7ZQa@FVFF77S0Q05N>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
 <20220119192217.GD43919@C02TD0UTHF1T.local>
 <2688b779-9cb8-b6ea-f8cc-93bc8ddf72f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2688b779-9cb8-b6ea-f8cc-93bc8ddf72f3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:28:09PM +0100, Paolo Bonzini wrote:
> On 1/19/22 20:22, Mark Rutland wrote:
> > I wonder, is the s390 guest entry/exit*preemptible*  ?
> > 
> > If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
> > things before a ctx-switch to the idle thread, which would then be able
> > to hit this.
> > 
> > I'll need to go audit the other architectures for similar.
> 
> They don't enable interrupts in the entry/exit path so they should be okay.

True.

So it sounds like for s390 adding an explicit preempt_{disable,enable}() is the
right thing to do. I'll add that and explanatory commentary.

> RISC-V and x86 have an explicit preempt_disable/enable, while MIPS only has
> local_irq_disable/enable.
> 
> (MIPS is a mess of dead code, I have patches to clean it up).

Sure; I haven't wrapped my head around ppc yet, but I assume they keep
interrupts disabled as with the other simple cases.

Thanks,
Mark.
