Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099DD4BD131
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbiBTUJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:09:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiBTUJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:09:54 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5CF4C424
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:09:32 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2d6923bca1aso108519527b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zI2d7Er8M7++1IKjscsscfEMnEx01mHbX//1FSVmoN4=;
        b=KMgqAYs78rgaEyui2CLWsplK/5F7GwimlboPYrU5FTsn5KAZ1+LMDZU6rnv06/9jqo
         omzb9zNELIAZjsUoncAMahC9evIeiwYEHu0p4YY1MbWKxTzoneVkK9kkfs35LeDeEPsQ
         8bkVxpWJzyfVka8PQ1M6d9+1Kr7wXBEfntLm2/cabzXBddZLN3Y9SX2Z8W2cbsrmSStq
         SxaEy3/HntdJgpKho6dv80dwxgE2gzzo1iUCGmAampV8aw40X6boPvKeZ3j0/rYWrllS
         2X2mu72ySrcjdHOEHWAsagI21MrFWy7cv8b/kpq9QJ7aV8y6DT0J6T6QYG9Fv8IaVJK9
         QOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zI2d7Er8M7++1IKjscsscfEMnEx01mHbX//1FSVmoN4=;
        b=NicQksivpR2cIEFKNV/qE9yVRgqlgB+CSE43WdBsjLd+PLm7Jn3ILlhnHHG4potUR5
         Tt/tsqOSowJvlYkmReOTtpG9K+QRgb1YBSnxa3fQS4YQuEcbmebdAQgUWza8zpBlUI86
         i1XbDkfEIAQ9ZZ23J05zIXuvLH6oAcmp0jyS/y+EqxMX/zPtlWqtT23RZXcr2lCtxpcm
         ntGISvLFTrV8DJdNBwdSNsNs4CiNBsB+fKQj9s58+EAPd2xUh3RhX+1qxu50TKc13pie
         61lKzu/n69vY9SowMkGtNnxTtoTx+77gzcSBvqeQtbyJs4vuSURaQrmDZh9n9ukk9V49
         OLCA==
X-Gm-Message-State: AOAM532BUD4x+YkV6wLNyILUCXFGdizDbIPpJH/aVAZuNpOxQ59K7MA9
        MtY1YrFk712PxeMnNNXIgN3z6MYpHD7i+wQHvVY=
X-Google-Smtp-Source: ABdhPJy1q268yipr+5ZN6g4o6pAV8FN5g02LlSVgmJgPZU1lpRKWePrcHJ5TGha8dLuOxUMf+Ds1SDCv9AauxGAl3l4=
X-Received: by 2002:a81:158:0:b0:2d0:8b7f:a539 with SMTP id
 85-20020a810158000000b002d08b7fa539mr16985478ywb.233.1645387771287; Sun, 20
 Feb 2022 12:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
 <6432e7e97b828d887da8794c150161c4@kernel.org> <CAMj1kXF14uEM=eTsqKR8MBWYS_yebMQF5kca86gGyuXkjs+GRg@mail.gmail.com>
 <YhJYu61HkL9Ywq0R@shell.armlinux.org.uk>
In-Reply-To: <YhJYu61HkL9Ywq0R@shell.armlinux.org.uk>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 21 Feb 2022 09:09:20 +1300
Message-ID: <CAGsJ_4yFbK5kf_9Z1hFeF2O0BpmXhFYSB7Pukn1JKGuqjXWTXQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp
 before issuing ipi
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Mon, Feb 21, 2022 at 4:05 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Sun, Feb 20, 2022 at 02:30:24PM +0100, Ard Biesheuvel wrote:
> > On Sat, 19 Feb 2022 at 10:57, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On 2022-02-18 21:55, Barry Song wrote:
> > > > dsb(ishst) should be enough here as we only need to guarantee the
> > > > visibility of data to other CPUs in smp inner domain before we
> > > > send the ipi.
> > > >
> > > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > > ---
> > > >  drivers/irqchip/irq-gic-v3.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/irqchip/irq-gic-v3.c
> > > > b/drivers/irqchip/irq-gic-v3.c
> > > > index 5e935d97207d..0efe1a9a9f3b 100644
> > > > --- a/drivers/irqchip/irq-gic-v3.c
> > > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > > @@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data
> > > > *d, const struct cpumask *mask)
> > > >        * Ensure that stores to Normal memory are visible to the
> > > >        * other CPUs before issuing the IPI.
> > > >        */
> > > > -     wmb();
> > > > +     dsb(ishst);
> > > >
> > > >       for_each_cpu(cpu, mask) {
> > > >               u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
> > >
> > > I'm not opposed to that change, but I'm pretty curious whether this
> > > makes
> > > any visible difference in practice. Could you measure the effect of this
> > > change
> > > for any sort of IPI heavy workload?
> > >
> >
> > Does this have to be a DSB ?
>
> Are you suggesting that smp_wmb() may suffice (which is a dmb(ishst)) ?

usually smp_wmb() is ok, for example drivers/irqchip/irq-bcm2836.c:

static void bcm2836_arm_irqchip_ipi_send_mask(struct irq_data *d,
                                              const struct cpumask *mask)
{
        int cpu;
        void __iomem *mailbox0_base = intc.base + LOCAL_MAILBOX0_SET0;

        /*
         * Ensure that stores to normal memory are visible to the
         * other CPUs before issuing the IPI.
         */
        smp_wmb();

        for_each_cpu(cpu, mask)
                writel_relaxed(BIT(d->hwirq), mailbox0_base + 16 * cpu);
}

but the instruction to send ipi for irq-gic-v3.c isn't a store, so
this driver has been
changed by this commit from dmb(ish) to dsb(sy):

commit 21ec30c0ef5234fb1039cc7c7737d885bf875a9e
Author: Shanker Donthineni <shankerd@codeaurora.org>

    irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

    A DMB instruction can be used to ensure the relative order of only
    memory accesses before and after the barrier. Since writes to system
    registers are not memory operations, barrier DMB is not sufficient
    for observability of memory accesses that occur before ICC_SGI1R_EL1
    writes.

    A DSB instruction ensures that no instructions that appear in program
    order after the DSB instruction, can execute until the DSB instruction
    has completed.

    ...

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d71be9a1f9d2..d99cc07903ec 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -688,7 +688,7 @@ static void gic_raise_softirq(const struct cpumask
*mask, unsigned int irq)
         * Ensure that stores to Normal memory are visible to the
         * other CPUs before issuing the IPI.
         */
-       smp_wmb();
+       wmb();

        for_each_cpu(cpu, mask) {
                u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));

my understanding is that dtb(sy) is too strong as this case we are
asking data to
be observed by other CPUs in smp just as smp_wmb is doing that in other drivers
by dmb(isb). we are not requiring data is observed by everyone in the system.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

Thanks
Barry
