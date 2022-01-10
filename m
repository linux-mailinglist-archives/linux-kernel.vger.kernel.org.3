Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA30F489766
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbiAJL1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:27:02 -0500
Received: from foss.arm.com ([217.140.110.172]:33070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244686AbiAJL0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:26:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 869FB2B;
        Mon, 10 Jan 2022 03:26:35 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E39EB3F5A1;
        Mon, 10 Jan 2022 03:26:33 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:26:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Ying <heying24@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, joey.gouly@arm.com, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Make CONFIG_ARM64_PSEUDO_NMI macro wrap all the
 pseudo-NMI code
Message-ID: <YdwX5RTVbw8veM98@FVFF77S0Q05N>
References: <20220107085536.214501-1-heying24@huawei.com>
 <Ydg939btY/bzEAe4@FVFF77S0Q05N>
 <bd82d240-34d7-4df9-650b-c039555f05e3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd82d240-34d7-4df9-650b-c039555f05e3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:00:43AM +0800, He Ying wrote:
> Hi Mark,
> 
> I'm just back from the weekend and sorry for the delayed reply.
> 
> 
> 在 2022/1/7 21:19, Mark Rutland 写道:
> > On Fri, Jan 07, 2022 at 03:55:36AM -0500, He Ying wrote:
> > > Our product has been updating its kernel from 4.4 to 5.10 recently and
> > > found a performance issue. We do a bussiness test called ARP test, which
> > > tests the latency for a ping-pong packets traffic with a certain payload.
> > > The result is as following.
> > > 
> > >   - 4.4 kernel: avg = ~20s
> > >   - 5.10 kernel (CONFIG_ARM64_PSEUDO_NMI is not set): avg = ~40s
> > Have you tested with a recent mainline kernel, e.g. v5.15?
> 
> Actuallly no, that's because this test is only available for the product
> environment and
> 
> we don't have an available 5.15 kernel for it yet.

Ok; do you see anything comparable with any tests available to upstream
developers? e.g. hackbench or `perf bench sched` ?

> > Is this test publicly available, and can you say which hardrware (e.g. which
> > CPU implementation) you're testing with?
> 
> Actually no. The test is only available for our product environment now. We
> are testing
> 
> with hisilicon 1213 (4 ARM Cortex-A72 cores).

Thanks for the CPU info; there are a number of other Cortex-A72 platforms out
there, so it might be possible to reproduce the behaviour elsewhere.

> > > I have been just learning arm64 pseudo-NMI code and have a question,
> > > why is the related code not wrapped by CONFIG_ARM64_PSEUDO_NMI?
> > The code in question is all patched via alternatives, and when
> > CONFIG_ARM64_PSEUDO_NMI is not selected, the code was expected to only have the
> > overhead of the regular DAIF manipulation.
> I don't understand alernatives very well and I'll apreciate it if you can
> explain it a bit more.

Code using alternatives is patched at runtime, so for:

	ALTERNATIVE(x, y, cap)

... the `x` instructions will be inline in the code, and the `y` instructions
will be placed in a separate linker section. If the `cap` capability is
detected, the `y` instructions will be copied over the `x` instructions.

So for:

| asm volatile(ALTERNATIVE(
|         "msr    daifclr, #3             // arch_local_irq_enable",
|         __msr_s(SYS_ICC_PMR_EL1, "%0"),
|         ARM64_HAS_IRQ_PRIO_MASKING)
|         :
|         : "r" ((unsigned long) GIC_PRIO_IRQON)
|         : "memory");

... where ARM64_HAS_IRQ_PRIO_MASKING is not detected, the inline instructions
will be:

| msr    daifclr, #3             // arch_local_irq_enable 

A separate linker section will contain:
... and a separate linker section will contain:

| __msr_s(SYS_ICC_PMR_EL1, "%0"

... and some metadata will be recorded in a `struct alt_instr`, which will be
unused and will take some space, but should have no runtime overhead -- the
runtime cost should only be the `msr daifclr, #3` instruction.

> > > I wonder if this brings some performance regression.
> > > 
> > > First, I make this patch and then do the test again. Here's the result.
> > > 
> > >   - 5.10 kernel with this patch not applied: avg = ~40s
> > >   - 5.10 kernel with this patch applied: avg = ~23s
> > > 
> > > Amazing! Note that all kernel is built with CONFIG_ARM64_PSEUDO_NMI not
> > > set. It seems the pseudo-NMI feature actually brings some overhead to
> > > performance event if CONFIG_ARM64_PSEUDO_NMI is not set.
> > I'm surprised the overhead is so significant; as above this is all patched in
> > and so the overhead when this is disabled is expected to be *extremely* small.
> > 
> > For example, wjen CONFIG_ARM64_PSEUDO_NMI, in arch_local_irq_enable():
> > 
> > * The portion under the system_has_prio_mask_debugging() test will be removed
> >    entirely by the compiler, as this internally checks
> >    IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI).
> > 
> > * The assembly will be left as a write to DAIFClr. The only additional cost
> >    should be that of generating GIC_PRIO_IRQON into a register.
> > 
> > * The pmr_sync() will be removed entirely by the compiler as is defined
> >    conditionally dependent on CONFIG_ARM64_PSEUDO_NMI.
> > 
> > I can't spot an obvious issue with that or ther other cases. In the common case
> > those add no new instructions, and in the worst case they only add NOPs.
> 
> Thanks for your detailed explaination! Actually I can't understand the
> result exactly.
> 
> I build two 5.10 kernel images with this patch applied or not and objdump
> them. Indeed, the disassembles of 'arch_local_irq_restore' are the same. Do
> you have any ideas how we can find the root cause why this patch improves the
> performance so much?
> 
> However, the test result is trustworthy because we do it many times and the
> result is always repeatable.

Due to the large numbers, I suspect this must be due to a specific fast-path,
and it's possible that this is due to secondary factors (e.g. alignment of
code) rather than the pseudo-NMK code itself.

We need to narrow down *where* time is being spent. Since it appears that this
is related to the local IRQ state management, it isn't likely that we can
determine that reliably with the PMU. Given that, I think the first step is to
reproduce the result elsewhere, for which we will need some plublicly available
test-case.

> > > Furthermore, I find the feature also brings some overhead to vmlinux size.
> > > I build 5.10 kernel with this patch applied or not while
> > > CONFIG_ARM64_PSEUDO_NMI is not set.
> > > 
> > >   - 5.10 kernel with this patch not applied: vmlinux size is 384060600 Bytes.
> > >   - 5.10 kernel with this patch applied: vmlinux size is 383842936 Bytes.
> > > 
> > > That means arm64 pseudo-NMI feature may bring ~200KB overhead to
> > > vmlinux size.
> > I suspect that's just the (unused) alternatives, and we could improve that by
> > passing the config into the alternative blocks.
> 
> Do you mean the sections generated by the alternatives? I don't understand
> alernatives very well and I'll apreciate it if you can explain it a bit
> more.

Yes; I meant the sections generated to hold the alternatives code and the
alternatives metadata.


> > > Above all, arm64 pseudo-NMI feature brings some overhead to vmlinux size
> > > and performance even if config is not set. To avoid it, add macro control
> > > all around the related code.
> > > 
> > > Signed-off-by: He Ying <heying24@huawei.com>
> > > ---
> > >   arch/arm64/include/asm/irqflags.h | 38 +++++++++++++++++++++++++++++--
> > >   arch/arm64/kernel/entry.S         |  4 ++++
> > >   2 files changed, 40 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> > > index b57b9b1e4344..82f771b41cf5 100644
> > > --- a/arch/arm64/include/asm/irqflags.h
> > > +++ b/arch/arm64/include/asm/irqflags.h
> > > @@ -26,6 +26,7 @@
> > >    */
> > >   static inline void arch_local_irq_enable(void)
> > >   {
> > > +#ifdef CONFIG_ARM64_PSEUDO_NMI
> > >   	if (system_has_prio_mask_debugging()) {
> > >   		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
> > > @@ -41,10 +42,18 @@ static inline void arch_local_irq_enable(void)
> > >   		: "memory");
> > >   	pmr_sync();
> > > +#else
> > > +	asm volatile(
> > > +		"msr	daifclr, #3		// arch_local_irq_enable"
> > > +		:
> > > +		:
> > > +		: "memory");
> > > +#endif
> > I'm happy to rework this to improve matters, but I am very much not happy with
> > duplicating the logic for the !PSEUDO_NMI case. Adding more ifdeffery and
> > copies of that is not acceptable.
> I agree. Adding these ifdeffery is a bit ugly. Let's see if there are some
> better ways.
> > 
> > Instead, can you please try changing the alternative to also take the config,
> > e.g. here have:
> > 
> > |       asm volatile(ALTERNATIVE(
> > |               "msr    daifclr, #3             // arch_local_irq_enable",
> > |               __msr_s(SYS_ICC_PMR_EL1, "%0"),
> > |               ARM64_HAS_IRQ_PRIO_MASKING,
> > |               CONFIG_ARM64_PSEUDO_NMI)
> > |               :
> > |               : "r" ((unsigned long) GIC_PRIO_IRQON)
> > |               : "memory");
> > 
> > ... and see if that makes a significant difference?
> > 
> > Likewise for the other casees.
> 
> OK, I'll try it. But I have some questions. Here's the comment of
> ALERNATIVE:
> 
> /*
>  * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature));
>  *
>  * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature, CONFIG_FOO));
>  * N.B. If CONFIG_FOO is specified, but not selected, the whole block
>  *      will be omitted, including oldinstr.
>  */
> 
> If CONFIG_FOO is not selected, the whole block will be omitted including
> oldinstr.
> 
> But we still want the oldinstr in this situation. Do I misunderstand
> something?

Sorry; you are right, and my suggestion was broken.

I'll need to have a think about this; we might be able to rework this to use a
static key instead, but IIRC last time I tried there were issues with that
approach. I have some (old) work-in-progress patches at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/daif-rework

I suspect I won't have time to renew that in the near future, but an approach
like that might be worthwhile.

Thanks,
Mark.
