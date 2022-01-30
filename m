Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1BA4A3333
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353742AbiA3CIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiA3CIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:08:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6499C061714;
        Sat, 29 Jan 2022 18:08:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A849AB828A8;
        Sun, 30 Jan 2022 02:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB71C340F0;
        Sun, 30 Jan 2022 02:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643508495;
        bh=3V6H56NIZMHAqm9Z0fpKVQ/bU1deS6S7JAioTpvD1M4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OTmBDMWld2fPY0IAjwncgvnEnCf2fO27sbM9PKyGKVmvZGp76Fvkp0Mfq1Bnu5kfZ
         RBKfUWZPecIyhX3i4GX+Fjes8N0dWUxsY0iyWjQb5m8FSRfpn1cPfrofQ8ZNSms4Bg
         910JJs1mtIep46XPfe3+3FG60Ex20dK0R/MTafeM6MJqN3uL7/yJeifJkPo3pWv1Ib
         flm/U6ZxXGkM9TvQDoWo9BKW2oM89YN39aJos2toLKp3kzAjIjRWgZOPgTwq5yabFe
         HtK/pnjZ76MF8+/o8SJ2GVrHexo2IyVEGDDOVUQNWth6jmOsmRLuZWI9X5ZxB1TMYi
         9CzOHqPqK+yuw==
Received: by mail-vk1-f176.google.com with SMTP id v192so6201237vkv.4;
        Sat, 29 Jan 2022 18:08:15 -0800 (PST)
X-Gm-Message-State: AOAM533XDRkptIDDGhmVVdTR8qW9nB8Lc8i4cz6zPoOPxwg5YX4we0OT
        dPF4b0mfmcFsbHrkq+RxBb9vxLt/2NIlB4ADm1o=
X-Google-Smtp-Source: ABdhPJxrzpxI8bv+XrH5itD+/Oj5rPfN0In7EL12ZCBIWAt1HX33g0ojST0LIWmJqwh28IscrmfNOC4zwCeOVQJd6ko=
X-Received: by 2002:a1f:640e:: with SMTP id y14mr6389746vkb.2.1643508494202;
 Sat, 29 Jan 2022 18:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20220129162726.1154501-1-guoren@kernel.org> <20220129162726.1154501-3-guoren@kernel.org>
 <87r18qxui9.wl-maz@kernel.org>
In-Reply-To: <87r18qxui9.wl-maz@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Jan 2022 10:08:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTYN0bxnnMtP9L1KvaH0h6ny+Lr3+fC7GP-YWnwjAYd4A@mail.gmail.com>
Message-ID: <CAJF2gTTYN0bxnnMtP9L1KvaH0h6ny+Lr3+fC7GP-YWnwjAYd4A@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] irqchip/sifive-plic: Fixup thead,c900-plic dt
 parse in opensbi
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel@sholland.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 2:32 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 29 Jan 2022 16:27:26 +0000,
> guoren@kernel.org wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The thead,c900-plic has been used in opensbi to distinguish
> > PLIC [1]. Although PLICs have the same behaviors in Linux,
> > they are different hardware with some custom initializing in
> > firmware(opensbi).
> >
> > [1]: https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Samuel Holland <samuel@sholland.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index 259065d271ef..245655928076 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -172,7 +172,7 @@ static void plic_irq_eoi(struct irq_data *d)
> >       }
> >  }
> >
> > -static struct irq_chip plic_chip = {
> > +static struct irq_chip sifive_plic_chip = {
> >       .name           = "SiFive PLIC",
> >       .irq_mask       = plic_irq_mask,
> >       .irq_unmask     = plic_irq_unmask,
> > @@ -182,12 +182,24 @@ static struct irq_chip plic_chip = {
> >  #endif
> >  };
> >
> > +static struct irq_chip thead_plic_chip = {
> > +     .name           = "T-Head PLIC",
> > +     .irq_mask       = plic_irq_mask,
> > +     .irq_unmask     = plic_irq_unmask,
> > +     .irq_eoi        = plic_irq_eoi,
> > +#ifdef CONFIG_SMP
> > +     .irq_set_affinity = plic_set_affinity,
> > +#endif
> > +};
>
> For pure entertainment, let's compare the two structures:
>
> static struct irq_chip plic_chip = {
>         .name           = "SiFive PLIC",
>         .irq_mask       = plic_irq_mask,
>         .irq_unmask     = plic_irq_unmask,
>         .irq_eoi        = plic_irq_eoi,
> #ifdef CONFIG_SMP
>         .irq_set_affinity = plic_set_affinity,
> #endif
> };
>
> Oh wait: a string. Must be really important. Not.
No, pls see below comment.

>
> > +
> > +static struct irq_chip *def_plic_chip = &sifive_plic_chip;
> > +
> >  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >                             irq_hw_number_t hwirq)
> >  {
> >       struct plic_priv *priv = d->host_data;
> >
> > -     irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> > +     irq_domain_set_info(d, irq, hwirq, def_plic_chip, d->host_data,
> >                           handle_fasteoi_irq, NULL, NULL);
> >       irq_set_noprobe(irq);
> >       irq_set_affinity(irq, &priv->lmask);
> > @@ -396,5 +408,14 @@ static int __init plic_init(struct device_node *node,
> >       return error;
> >  }
> >
> > +static int __init thead_c900_plic_init(struct device_node *node,
> > +             struct device_node *parent)
> > +{
> > +     def_plic_chip = &thead_plic_chip;
> > +
> > +     return plic_init(node, parent);
> > +}
> > +
> >  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> >  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> > +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
>
> Sorry, but I can't see any point to this patch.
You didn't see the link I've put in the patch. In that opensbi patch:

                intc: interrupt-controller@10000000 {
                        #interrupt-cells = <1>;
-                       compatible = "riscv,plic0";
+                       compatible = "allwinner,sun20i-d1-plic",
+                                    "thead,c900-plic";

+#define THEAD_PLIC_CTRL_REG 0x1ffffc
+
+static void thead_plic_plat_init(struct plic_data *pd)
+{
+       writel_relaxed(BIT(0), (void *)pd->addr + THEAD_PLIC_CTRL_REG);
+}
+
 static const struct fdt_match irqchip_plic_match[] = {
        { .compatible = "riscv,plic0" },
        { .compatible = "sifive,plic-1.0.0" },
+       { .compatible = "thead,c900-plic",
+         .data = thead_plic_plat_init },
        { },
 };

We've changed the compatible name for thead,c900-plic, and there is no
riscv,plic0 / sifive,plic-1.0.0 in dts. Without the patch, the newest
opensbi + newest Linux would be broken in the Allwinner D1 dev board.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
