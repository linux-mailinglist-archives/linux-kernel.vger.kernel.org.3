Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B44A33FF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 05:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354185AbiA3Ejw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 23:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiA3Ejt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 23:39:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E18C061714;
        Sat, 29 Jan 2022 20:39:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C2FBB827F6;
        Sun, 30 Jan 2022 04:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC598C36AE2;
        Sun, 30 Jan 2022 04:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643517586;
        bh=lIqRpPgt5ZOVkSCMuU19p1CNRtGg2YZr+XSa0dYDS+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NI37Edd5mq8IuZsVED+WhDdLWfGibvSriiMCP9y9naW5dTZSy06iAr2MoPsW8rA90
         KpN4idAM3HCQ0UlGNxXJ3F+viY09XkOSns2AyowHOCdnQhWkvlKGAjE7nGphqLTgbf
         //UqcC0FvwcCwDYrXH2/okvkkI5788n2jYu0btC7ZuoJ3Ssl7WIDqTkPWXG6cuF5l8
         89Z1umkdtPwoR6NybrJ8UdqBoRGYfwxjzTjwjcajqtLVQ8f6LHLBZDuDXbcUvz60Ic
         JtebXv7aNB3XYXwPvos1hu9l4bWbZt+vJMC/XoL15400IpVpDr1Avqklb1coxgRoRZ
         IEcl96KFrwREw==
Received: by mail-vs1-f54.google.com with SMTP id v6so7894207vsp.11;
        Sat, 29 Jan 2022 20:39:46 -0800 (PST)
X-Gm-Message-State: AOAM530Mq64xAAHKN3GdHMiX3mhiRzqUweYKtM1jKqWFerrfL5BB5RrP
        Xx9EssgbVVbVm08AkqmWmmPtowAISGLnBzgU0pU=
X-Google-Smtp-Source: ABdhPJw880aHNXeYkhi1jcDRAgJdMZlctpuVQKIFd6cUTVvaQDGDk82PM1yPlru7Wy+sN4aZVSRTzKsi4ZuU+1J/Vxw=
X-Received: by 2002:a67:e947:: with SMTP id p7mr6193021vso.59.1643517585723;
 Sat, 29 Jan 2022 20:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20220129162726.1154501-1-guoren@kernel.org> <20220129162726.1154501-3-guoren@kernel.org>
 <87r18qxui9.wl-maz@kernel.org> <CAJF2gTTYN0bxnnMtP9L1KvaH0h6ny+Lr3+fC7GP-YWnwjAYd4A@mail.gmail.com>
 <35b1838d-ef80-1816-46f6-9cba7afc813e@sholland.org>
In-Reply-To: <35b1838d-ef80-1816-46f6-9cba7afc813e@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Jan 2022 12:39:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQsi6uT8ea6MTu6oDA-9xsd3fW5ETHAtpzGZxapLpLsWA@mail.gmail.com>
Message-ID: <CAJF2gTQsi6uT8ea6MTu6oDA-9xsd3fW5ETHAtpzGZxapLpLsWA@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] irqchip/sifive-plic: Fixup thead,c900-plic dt
 parse in opensbi
To:     Samuel Holland <samuel@sholland.org>
Cc:     Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:50 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 1/29/22 8:08 PM, Guo Ren wrote:
> > On Sun, Jan 30, 2022 at 2:32 AM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On Sat, 29 Jan 2022 16:27:26 +0000,
> >> guoren@kernel.org wrote:
> >>>
> >>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>
> >>> The thead,c900-plic has been used in opensbi to distinguish
> >>> PLIC [1]. Although PLICs have the same behaviors in Linux,
> >>> they are different hardware with some custom initializing in
> >>> firmware(opensbi).
> >>>
> >>> [1]: https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6
> >>>
> >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>> Cc: Anup Patel <anup@brainfault.org>
> >>> Cc: Marc Zyngier <maz@kernel.org>
> >>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >>> Cc: Samuel Holland <samuel@sholland.org>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> ---
> >>>  drivers/irqchip/irq-sifive-plic.c | 25 +++++++++++++++++++++++--
> >>>  1 file changed, 23 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> >>> index 259065d271ef..245655928076 100644
> >>> --- a/drivers/irqchip/irq-sifive-plic.c
> >>> +++ b/drivers/irqchip/irq-sifive-plic.c
> >>> @@ -172,7 +172,7 @@ static void plic_irq_eoi(struct irq_data *d)
> >>>       }
> >>>  }
> >>>
> >>> -static struct irq_chip plic_chip = {
> >>> +static struct irq_chip sifive_plic_chip = {
> >>>       .name           = "SiFive PLIC",
> >>>       .irq_mask       = plic_irq_mask,
> >>>       .irq_unmask     = plic_irq_unmask,
> >>> @@ -182,12 +182,24 @@ static struct irq_chip plic_chip = {
> >>>  #endif
> >>>  };
> >>>
> >>> +static struct irq_chip thead_plic_chip = {
> >>> +     .name           = "T-Head PLIC",
> >>> +     .irq_mask       = plic_irq_mask,
> >>> +     .irq_unmask     = plic_irq_unmask,
> >>> +     .irq_eoi        = plic_irq_eoi,
> >>> +#ifdef CONFIG_SMP
> >>> +     .irq_set_affinity = plic_set_affinity,
> >>> +#endif
> >>> +};
> >>
> >> For pure entertainment, let's compare the two structures:
> >>
> >> static struct irq_chip plic_chip = {
> >>         .name           = "SiFive PLIC",
> >>         .irq_mask       = plic_irq_mask,
> >>         .irq_unmask     = plic_irq_unmask,
> >>         .irq_eoi        = plic_irq_eoi,
> >> #ifdef CONFIG_SMP
> >>         .irq_set_affinity = plic_set_affinity,
> >> #endif
> >> };
> >>
> >> Oh wait: a string. Must be really important. Not.
> > No, pls see below comment.
> >
> >>
> >>> +
> >>> +static struct irq_chip *def_plic_chip = &sifive_plic_chip;
> >>> +
> >>>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >>>                             irq_hw_number_t hwirq)
> >>>  {
> >>>       struct plic_priv *priv = d->host_data;
> >>>
> >>> -     irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> >>> +     irq_domain_set_info(d, irq, hwirq, def_plic_chip, d->host_data,
> >>>                           handle_fasteoi_irq, NULL, NULL);
> >>>       irq_set_noprobe(irq);
> >>>       irq_set_affinity(irq, &priv->lmask);
> >>> @@ -396,5 +408,14 @@ static int __init plic_init(struct device_node *node,
> >>>       return error;
> >>>  }
> >>>
> >>> +static int __init thead_c900_plic_init(struct device_node *node,
> >>> +             struct device_node *parent)
> >>> +{
> >>> +     def_plic_chip = &thead_plic_chip;
> >>> +
> >>> +     return plic_init(node, parent);
> >>> +}
> >>> +
> >>>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> >>>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> >>> +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
> >>
> >> Sorry, but I can't see any point to this patch.
> > You didn't see the link I've put in the patch. In that opensbi patch:
> >
> >                 intc: interrupt-controller@10000000 {
> >                         #interrupt-cells = <1>;
> > -                       compatible = "riscv,plic0";
> > +                       compatible = "allwinner,sun20i-d1-plic",
> > +                                    "thead,c900-plic";
> >
> > +#define THEAD_PLIC_CTRL_REG 0x1ffffc
> > +
> > +static void thead_plic_plat_init(struct plic_data *pd)
> > +{
> > +       writel_relaxed(BIT(0), (void *)pd->addr + THEAD_PLIC_CTRL_REG);
> > +}
> > +
> >  static const struct fdt_match irqchip_plic_match[] = {
> >         { .compatible = "riscv,plic0" },
> >         { .compatible = "sifive,plic-1.0.0" },
> > +       { .compatible = "thead,c900-plic",
> > +         .data = thead_plic_plat_init },
> >         { },
> >  };
> >
> > We've changed the compatible name for thead,c900-plic, and there is no
> > riscv,plic0 / sifive,plic-1.0.0 in dts. Without the patch, the newest
> > opensbi + newest Linux would be broken in the Allwinner D1 dev board.
>
> Yes, some patch is still necessary, because the hardware is indeed incompatible
> with riscv,plic0. However, this driver does not care about the difference. So
> all you need to do is hook up the existing code to the new compatible:
>
> +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init);
I think we should give clear info in /proc/interrupts. I hope we could
keep thead_plic_init.

>
> Regards,
> Samuel



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
