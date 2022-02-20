Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD94BCF42
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbiBTPGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:06:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbiBTPGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:06:00 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0131DC8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Hx07QwGIcmDyJPlDIB9QXqGTx5LC42XoxgPoFwSTsRM=; b=Bv4UBb1+i2NdY4g+/Z5zrAZMV7
        t4LEdq1Mel8kuOPT+jvhRaw2pyjfAXII4C53wkmCFEpdczqqg1IhaJF+U80ItRczOQFHFoGbQAHZk
        A+0sHrR4Y8AlySGcoWzwro4kwh/+XPAkFgkKMZLBOwqUznm0vWEV+lk1kp5+LheMnSS6usZdUtIlK
        drfwJjI2XD5BTxObu9KgMcyfh1S/WfOG6SKcE0G8a38itBqcQawMShGpArqCeIy7CzEF4MHGB3UHS
        V7EbcajqEiuQPQVXpAe4pN3NTO1p1Ku8SP0MZpifJ+L8Sfc2mcCyh1P8QigFnIjDP6t2bpQILJceU
        RPRYH/Dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57380)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nLnmG-0007m7-J2; Sun, 20 Feb 2022 15:05:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nLnmG-0006RM-0J; Sun, 20 Feb 2022 15:05:32 +0000
Date:   Sun, 20 Feb 2022 15:05:31 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Barry Song <21cnbao@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to
 smp before issuing ipi
Message-ID: <YhJYu61HkL9Ywq0R@shell.armlinux.org.uk>
References: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
 <6432e7e97b828d887da8794c150161c4@kernel.org>
 <CAMj1kXF14uEM=eTsqKR8MBWYS_yebMQF5kca86gGyuXkjs+GRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF14uEM=eTsqKR8MBWYS_yebMQF5kca86gGyuXkjs+GRg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 02:30:24PM +0100, Ard Biesheuvel wrote:
> On Sat, 19 Feb 2022 at 10:57, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On 2022-02-18 21:55, Barry Song wrote:
> > > dsb(ishst) should be enough here as we only need to guarantee the
> > > visibility of data to other CPUs in smp inner domain before we
> > > send the ipi.
> > >
> > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > ---
> > >  drivers/irqchip/irq-gic-v3.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/irqchip/irq-gic-v3.c
> > > b/drivers/irqchip/irq-gic-v3.c
> > > index 5e935d97207d..0efe1a9a9f3b 100644
> > > --- a/drivers/irqchip/irq-gic-v3.c
> > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > @@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data
> > > *d, const struct cpumask *mask)
> > >        * Ensure that stores to Normal memory are visible to the
> > >        * other CPUs before issuing the IPI.
> > >        */
> > > -     wmb();
> > > +     dsb(ishst);
> > >
> > >       for_each_cpu(cpu, mask) {
> > >               u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
> >
> > I'm not opposed to that change, but I'm pretty curious whether this
> > makes
> > any visible difference in practice. Could you measure the effect of this
> > change
> > for any sort of IPI heavy workload?
> >
> 
> Does this have to be a DSB ?

Are you suggesting that smp_wmb() may suffice (which is a dmb(ishst)) ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
