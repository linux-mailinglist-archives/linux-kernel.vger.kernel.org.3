Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDEC4BD164
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbiBTUV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:21:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiBTUV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:21:26 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58315522F9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:21:04 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d641c31776so117627857b3.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D03Egt+d5u/hu8HQ1PRH/U30VtZRlNlzJ55oUTcmJRw=;
        b=NyEdUhmgTmwDRSl9PtHZ0lEsE1JmdzuB1pobFQxn6O9nfTKAewRwenyCfqG6dvbYQm
         IF3iGP2E3xBGtU67aaEzCzrHZnkV2Yug6DUYEuDbl5J2y4AJrXVbrNEiJb4255dG5C8D
         6u+TA4PtB2LmmC4o0bzUizuacIIGFtr65W6dDLBWvN6UVps8zkVIcYJx2BRJxJfKYlIa
         3yPf/d4HY8u+1E5Ia7O+0Too8NKuzuqhyomn56emh32jgjgIHfQ1ORMLxG7n3Kf5xGgD
         IPTXlBKkKPQ+PlLe/d+ZodojxpFojaXGIGiFebj697UVbmkN1Du54JF0sbsa07a/PZuN
         HEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D03Egt+d5u/hu8HQ1PRH/U30VtZRlNlzJ55oUTcmJRw=;
        b=CrO9Mjm4YBQuJ3/Og0wal2NpxfpeFCm9tmWG7WgpCXb3a95rCLLfo64rqr7mw5+DVr
         E1ezFLjgK3KvlNih2w9NigCJGq/atO6ffyXavAqu6P71siswVugVnxdl4ZpVmCqibV0L
         ccDwoQ/jGUY0BC9T0fqvLUe/8UMr5dxaW+rCCwXlvEEeMeWO4s3RfCD6RvB+NLjd2PYL
         LDjqqJz9CDwDEHuYqsN9CaXswNjovz6zkADOJHxu1VW0kL+/Ds5dEd7EAFO5wiJlHyT5
         aDzy3ZbqWGN3bhflYed33uVM0o2z+jkjFV92o/VQ17R/8gy9VVDTO+G6Oc80PPlsqrEv
         mm+w==
X-Gm-Message-State: AOAM5328G90LOgmXGv09AI3BQ0fjKZnv5QQqA8hJk2/9puKCQblCCHas
        O+fGtFB/ohEios7IiO4L6TH1KaqsvtKSlcGrOWQ=
X-Google-Smtp-Source: ABdhPJyPX2PzPzphij3axGKAhqwba4S+SW1RUYy/PvT+X+IlvSb/qg93p6jn9xqLVxkXHuu15XD1Q5gCDDxWZk/ZprA=
X-Received: by 2002:a81:6cc1:0:b0:2cf:c9a6:7e28 with SMTP id
 h184-20020a816cc1000000b002cfc9a67e28mr16500008ywc.406.1645388463566; Sun, 20
 Feb 2022 12:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
 <YhJYct7aW0kGXNXp@shell.armlinux.org.uk> <c10d6044786fdf78ef4bc7fac2544096@kernel.org>
In-Reply-To: <c10d6044786fdf78ef4bc7fac2544096@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 21 Feb 2022 09:20:52 +1300
Message-ID: <CAGsJ_4ydw64YRtShbevO6f2DgnWHV9kMnwOR3=u+C4k=gO6tVw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp
 before issuing ipi
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 4:21 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-02-20 15:04, Russell King (Oracle) wrote:
> > On Sat, Feb 19, 2022 at 05:55:49AM +0800, Barry Song wrote:
> >> dsb(ishst) should be enough here as we only need to guarantee the
> >> visibility of data to other CPUs in smp inner domain before we
> >> send the ipi.
> >>
> >> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> >> ---
> >>  drivers/irqchip/irq-gic-v3.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/irqchip/irq-gic-v3.c
> >> b/drivers/irqchip/irq-gic-v3.c
> >> index 5e935d97207d..0efe1a9a9f3b 100644
> >> --- a/drivers/irqchip/irq-gic-v3.c
> >> +++ b/drivers/irqchip/irq-gic-v3.c
> >> @@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data
> >> *d, const struct cpumask *mask)
> >>       * Ensure that stores to Normal memory are visible to the
> >>       * other CPUs before issuing the IPI.
> >>       */
> >> -    wmb();
> >> +    dsb(ishst);
> >
> > On ARM, wmb() is a dsb(st) followed by other operations which may
> > include a sync operation at the L2 cache, and SoC specific barriers
> > for the bus. Hopefully, nothing will break if the sledge hammer is
> > replaced by the tack hammer.
>
> The saving grace is that ARMv8 forbids (as per D4.4.11) these
> SW-visible,
> non architected caches (something like PL310 simply isn't allowed).
> Given
> that GICv3 requires ARMv8 the first place, we should be OK.
>
> As for SoC-specific bus barriers, I don't know of any that would affect
> an ARMv8 based SoC. But I'm always prepared to be badly surprised...2

i assume we have been safe since dsb(ish) has been widely used for
smp data visibility in arm64:
arch/arm64/include/asm/assembler.h: dsb ish
arch/arm64/include/asm/cacheflush.h: dsb(ish);
arch/arm64/include/asm/pgtable.h: dsb(ishst);
arch/arm64/include/asm/pgtable.h: dsb(ishst);
arch/arm64/include/asm/pgtable.h: dsb(ishst);
arch/arm64/include/asm/pgtable.h: dsb(ishst);
arch/arm64/include/asm/pgtable.h: * is doing a dsb(ishst), but that
penalises the fastpath.
arch/arm64/include/asm/smp.h: dsb(ishst);
arch/arm64/include/asm/tlbflush.h:        "dsb ish\n tlbi " #op,        \
arch/arm64/include/asm/tlbflush.h:        "dsb ish\n tlbi " #op ", %0",     \
arch/arm64/include/asm/tlbflush.h: dsb(ishst);
arch/arm64/include/asm/tlbflush.h: dsb(ish);
arch/arm64/include/asm/tlbflush.h: dsb(ishst);
arch/arm64/include/asm/tlbflush.h: dsb(ish);
arch/arm64/include/asm/tlbflush.h: dsb(ishst);
arch/arm64/include/asm/tlbflush.h: dsb(ish);
arch/arm64/include/asm/tlbflush.h: dsb(ishst);
arch/arm64/include/asm/tlbflush.h: dsb(ish);
arch/arm64/include/asm/tlbflush.h: dsb(ishst);
arch/arm64/include/asm/tlbflush.h: dsb(ish);
arch/arm64/include/asm/tlbflush.h: dsb(ishst);
arch/arm64/include/asm/tlbflush.h: dsb(ish);
arch/arm64/kernel/alternative.c: dsb(ish);
arch/arm64/kernel/entry.S: dsb ish
arch/arm64/kernel/head.S: dsb ishst // Make zero page visible to PTW
arch/arm64/kernel/hibernate-asm.S: dsb ish /* wait for PoU cleaning to finish */
arch/arm64/kernel/hibernate-asm.S: dsb ish
arch/arm64/kernel/mte.c: dsb(ish);
arch/arm64/kernel/process.c: dsb(ish);
arch/arm64/kernel/sys_compat.c: dsb(ish);
arch/arm64/kvm/hyp/nvhe/tlb.c: dsb(ishst);
arch/arm64/kvm/hyp/nvhe/tlb.c: dsb(ish);
arch/arm64/kvm/hyp/nvhe/tlb.c: dsb(ish);
arch/arm64/kvm/hyp/nvhe/tlb.c: dsb(ishst);
arch/arm64/kvm/hyp/nvhe/tlb.c: dsb(ish);
arch/arm64/kvm/hyp/nvhe/tlb.c: dsb(ishst);
arch/arm64/kvm/hyp/nvhe/tlb.c: dsb(ish);
arch/arm64/kvm/hyp/pgtable.c: dsb(ishst);
arch/arm64/kvm/hyp/pgtable.c: dsb(ishst);
arch/arm64/kvm/hyp/pgtable.c: dsb(ishst);
arch/arm64/kvm/hyp/pgtable.c: dsb(ish);
arch/arm64/kvm/hyp/pgtable.c: dsb(ishst);
arch/arm64/kvm/hyp/pgtable.c: dsb(ishst);
arch/arm64/kvm/hyp/pgtable.c: dsb(ishst);
arch/arm64/kvm/hyp/vhe/tlb.c: dsb(ishst);
arch/arm64/kvm/hyp/vhe/tlb.c: dsb(ish);
arch/arm64/kvm/hyp/vhe/tlb.c: dsb(ish);
arch/arm64/kvm/hyp/vhe/tlb.c: dsb(ishst);
arch/arm64/kvm/hyp/vhe/tlb.c: dsb(ish);
arch/arm64/kvm/hyp/vhe/tlb.c: dsb(ishst);
arch/arm64/kvm/hyp/vhe/tlb.c: dsb(ish);
arch/arm64/mm/cache.S: dsb     ishst
arch/arm64/mm/cache.S: dsb ishst
arch/arm64/mm/kasan_init.c: dsb(ishst);
arch/arm64/mm/mmu.c: * We need dsb(ishst) here to ensure the
page-table-walker sees
arch/arm64/mm/mmu.c: dsb(ishst);
arch/arm64/mm/proc.S: dsb ish
drivers/irqchip/irq-gic-v3-its.c: dsb(ishst);
drivers/irqchip/irq-gic-v3-its.c: dsb(ishst);


Plus, is it even a problem to arm since arm only requires soc-level barrier
for system-level memory barrier rather than smp-level barrier?

#if defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
#define mb()            __arm_heavy_mb()
#define rmb()           dsb()
#define wmb()           __arm_heavy_mb(st)
#define dma_rmb()       dmb(osh)
#define dma_wmb()       dmb(oshst)
#else
#define mb()            barrier()
#define rmb()           barrier()
#define wmb()           barrier()
#define dma_rmb()       barrier()
#define dma_wmb()       barrier()
#endif

#define __smp_mb()      dmb(ish)
#define __smp_rmb()     __smp_mb()
#define __smp_wmb()     dmb(ishst)

I am not seeing arm requires soc-level mb for smp-level barrier though
the mandatory
barriers are using heavy_mb which has soc-level mb.

In this particular case, we are asking the data visibility for
smp-level not system-level. I am
not quite sure Russell's concern is relevant.

>
>          M.
> --
> Jazz is not dead. It just smells funny...

Thanks
Barry
