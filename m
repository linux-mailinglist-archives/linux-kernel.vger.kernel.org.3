Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4281A509F36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382783AbiDUMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383356AbiDUMD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:03:27 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F772FFE1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=YBvc9avqMiVzUv5zEL0CqCVNyrKHrc8Ik9lljpgTt70=; b=3AtuvrxqSBebVty1LCRVIP0iaB
        bTDkjVSb8NmMZC5BKmthtpv+pxDcaUEN88ZxAT8x1VtU5M02Kh1Av1bLYTSl/ZD8Ipf35gsrHEwkU
        jA1ig1Gf3JaXQtvJpwbTZecXYrcLeK7G5TbX4Tu46TiWiq49s7NfQfw2L4E/v10qasp0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nhVU3-00GnOY-2m; Thu, 21 Apr 2022 14:00:27 +0200
Date:   Thu, 21 Apr 2022 14:00:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
Message-ID: <YmFHW5joJkxLpU3v@lunn.ch>
References: <20220421015728.86912-1-nathan@nathanrossi.com>
 <87mtgfgx7d.wl-maz@kernel.org>
 <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> > >  {
> > > +#ifdef CONFIG_SMP
> > > +     unsigned int cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
> > > +
> > > +     msg->data = (1 << (cpu + 8)) | (data->hwirq + PCI_MSI_DOORBELL_START);
> >
> > BIT(cpu + 8) | ...
> >
> > > +#else
> > > +     msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
> >
> > This paints the existing code a bit differently. This seems to target
> > all 4 CPUs. Why is that? I'd expect only bit 8 to be set, and the
> > whole #ifdefery to go away.
> 
> I will remove the #ifdef in a v2 patch that addresses your
> other comments.

Please try to remove all the #ifdef'ery.

> > >  static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
> > >                                         const struct cpumask *mask, bool force)
> > >  {
> > > -      return -EINVAL;
> > > +#ifdef CONFIG_SMP
> > > +     unsigned int cpu;
> > > +
> > > +     if (!force)
> > > +             cpu = cpumask_any_and(mask, cpu_online_mask);
> > > +     else
> > > +             cpu = cpumask_first(mask);
> > > +
> > > +     if (cpu >= nr_cpu_ids)
> > > +             return -EINVAL;
> > > +
> > > +     irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
> > > +
> > > +     return IRQ_SET_MASK_OK;
> > > +#else
> > > +     return -EINVAL;
> > > +#endif

A quick look in cpumask.h suggests that if NR_CPUS == 1, there are
stub functions which return constant values. So you might not need
this #ifdef. However, i'm a network guy, not a scheduling guy, so
don't trust what i say...

     Andrew
