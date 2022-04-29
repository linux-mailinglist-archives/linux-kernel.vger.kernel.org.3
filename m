Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B25153CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbiD2Sjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiD2Sj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:39:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78319D4EE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:36:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso7491937wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+bqbWa5GnbUKdEVr1FeQHbDhte5Tx1qI8dlU9g0cnBs=;
        b=gfZ7Wa6UgJ17gsiOvaAWKu4hgiVeE6tTpXlwEuuC4d1SqYU1TrCjOl8PVuQGiLiM/c
         TGCvnPKu0IOea0HmDA/LwEagdJEzXjST8wbBTRanqpnko29S+OD4sSMaACx78g3KORAR
         FiXH8RyXTrvkeEbEDtWNsUbupjeFXsf9Z00Y5Os8FU+h624WQFXl81S+Ht+SLFl8zvn7
         XDrCi2YBpjXM68CboY84zTq90x9PAu7X1Y8UXRurCbR73ksqXrMZudROr9sxxbCPWSJY
         L8w2vuNgMLl7bgGbGySnP0xnWKkQmKg1WRhvBePOA2KDqmWqgLi1x074iaq1iI/MTBBW
         G0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+bqbWa5GnbUKdEVr1FeQHbDhte5Tx1qI8dlU9g0cnBs=;
        b=JS1k5KXVfFs+Vcvg0ZSpvgm2zJaXQOJfu2dHfJTDQsMvvu6GpA7ybaDUAlJNKxqPQt
         /NWWnBAAykoiuN9puD0TDS1sSOLXb9S5WwLjsfyuU1z5SYNFHMcTq80Gc35jMcCtsk9d
         wM9fXcsuHl7tDgEcRsbeDR/YHGWBsWNJM8wdGMfFGrfSVftxW+ztY/Sp+GmlEHU15qH9
         uN7zE6Uee+G5gK4LYBG1I+Y7s38539h5sC4NViubPEa+uMS3GVL2jjr/lciNbq6oMGWD
         Qnc77GsSyDZr0nL5XPo3JtswZilU6/eYAdnEeXrYlj6vXNyTv9dFZaUrauGf0JnxjF7M
         +OBw==
X-Gm-Message-State: AOAM530VN4VmJMEEUGRWsq4h/hgWO6y8at8eI3ckKKC+TYCqBe5Dyzt1
        LFPYEl9MnUwTSr+v4Jgdjzk4GA==
X-Google-Smtp-Source: ABdhPJyUqyNNp5H48LCat6UMfEw7Y7/SBQSkuJelMLhjRUBpUlw70WPQjk7i6jttdveeLRXtgBKaZw==
X-Received: by 2002:a05:600c:3594:b0:393:fba4:ecfe with SMTP id p20-20020a05600c359400b00393fba4ecfemr4483434wmq.10.1651257368298;
        Fri, 29 Apr 2022 11:36:08 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e12-20020a056000178c00b0020aaf8d351bsm2902263wrg.103.2022.04.29.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 11:36:07 -0700 (PDT)
Date:   Fri, 29 Apr 2022 19:36:05 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] irqchip/exiu: Fix acknowledgment of edge triggered
 interrupts
Message-ID: <20220429183605.gld37gz6taa5k7fk@maple.lan>
References: <20220429165314.2343705-1-daniel.thompson@linaro.org>
 <87pmkz94bc.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmkz94bc.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 06:39:51PM +0100, Marc Zyngier wrote:
> On Fri, 29 Apr 2022 17:53:14 +0100,
> Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > 
> > Currently the EXIU uses the fasteoi interrupt flow that is configured by
> > it's parent (irq-gic-v3.c). With this flow the only chance to clear the
> > interrupt request happens during .irq_eoi() and (obviously) this happens
> > after the interrupt handler has run. EXIU requires edge triggered
> > interrupts to be acked prior to interrupt handling. Without this we
> > risk incorrect interrupt dismissal when a new interrupt is delivered
> > after the handler reads and acknowledges the peripheral but before the
> > irq_eoi() takes place.
> > 
> > Fix this by clearing the interrupt request from .irq_ack() if we are
> > configured for edge triggered interrupts. This requires adopting the
> > fasteoi-ack flow instead of the fasteoi to ensure the ack gets called.
> > 
> > These changes have been tested using the power button on a
> > Developerbox/SC2A11 combined with some hackery in gpio-keys so I can
> > play with the different trigger mode (and an mdelay(500) so I can
> > can check what happens on a double click in both modes.
> > 
> > Fixes: 706cffc1b912 ("irqchip/exiu: Add support for Socionext Synquacer EXIU controller")
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> > 
> > Notes:
> >     Changes in v2:
> >     
> >      * Switch to dynamic selection of handle_fasteoi_irq and
> >        handle_fasteoi_ack_irq and reintroduce exiu_irq_eoi() since we need
> >        that for level triggered interrupts (Ard B).
> >      * Above changes mean we are no longer using sun6i NMI code as a
> >        template to tidy up the description accordingly.
> > 
> >  arch/arm64/Kconfig.platforms   |  1 +
> >  drivers/irqchip/irq-sni-exiu.c | 33 +++++++++++++++++++++++++++++----
> >  2 files changed, 30 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 30b123cde02c..aaeaf57c8222 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -253,6 +253,7 @@ config ARCH_INTEL_SOCFPGA
> > 
> >  config ARCH_SYNQUACER
> >  	bool "Socionext SynQuacer SoC Family"
> > +	select IRQ_FASTEOI_HIERARCHY_HANDLERS
> > 
> >  config ARCH_TEGRA
> >  	bool "NVIDIA Tegra SoC Family"
> > diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
> > index abd011fcecf4..651a82dead01 100644
> > --- a/drivers/irqchip/irq-sni-exiu.c
> > +++ b/drivers/irqchip/irq-sni-exiu.c
> > @@ -37,11 +37,20 @@ struct exiu_irq_data {
> >  	u32		spi_base;
> >  };
> > 
> > -static void exiu_irq_eoi(struct irq_data *d)
> > +static void exiu_irq_ack(struct irq_data *d)
> >  {
> >  	struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
> > 
> >  	writel(BIT(d->hwirq), data->base + EIREQCLR);
> > +}
> > +
> > +static void exiu_irq_eoi(struct irq_data *d)
> > +{
> > +	struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
> > +	u32 edge_triggered = readl_relaxed(data->base + EIEDG);
> 
> I expect this to be pretty expensive. Why not directly check the state
> flags with irqd_is_level_type()?

Good point. Will change this.


> > +
> > +	if (!(edge_triggered & BIT(d->hwirq)))
> > +		writel(BIT(d->hwirq), data->base + EIREQCLR);
> 
> Is this write even needed for a level interrupt? Or does the register
> always behave as a latch irrespective of the trigger?

It is unconditionally latched; must be cleared or the interrupt will be
jammed on. Of course, for level interrupts that are still asserted then
the write will not clear the interrupt.


> >  	irq_chip_eoi_parent(d);
> >  }
> > 
> > @@ -91,10 +100,13 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
> >  	writel_relaxed(val, data->base + EILVL);
> > 
> >  	val = readl_relaxed(data->base + EIEDG);
> > -	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH)
> > +	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH) {
> >  		val &= ~BIT(d->hwirq);
> > -	else
> > +		irq_set_handler_locked(d, handle_fasteoi_irq);
> > +	} else {
> >  		val |= BIT(d->hwirq);
> > +		irq_set_handler_locked(d, handle_fasteoi_ack_irq);
> > +	}
> >  	writel_relaxed(val, data->base + EIEDG);
> >
> >  	writel_relaxed(BIT(d->hwirq), data->base + EIREQCLR);
> > @@ -104,6 +116,7 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
> > 
> >  static struct irq_chip exiu_irq_chip = {
> >  	.name			= "EXIU",
> > +	.irq_ack		= exiu_irq_ack,
> >  	.irq_eoi		= exiu_irq_eoi,
> >  	.irq_enable		= exiu_irq_enable,
> >  	.irq_mask		= exiu_irq_mask,
> > @@ -148,6 +161,8 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
> >  	struct irq_fwspec parent_fwspec;
> >  	struct exiu_irq_data *info = dom->host_data;
> >  	irq_hw_number_t hwirq;
> > +	int i, ret;
> > +	u32 edge_triggered;
> > 
> >  	parent_fwspec = *fwspec;
> >  	if (is_of_node(dom->parent->fwnode)) {
> > @@ -165,7 +180,17 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
> >  	irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &exiu_irq_chip, info);
> > 
> >  	parent_fwspec.fwnode = dom->parent->fwnode;
> > -	return irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
> > +	ret = irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
> > +	if (ret)
> > +		return ret;
> > +
> > +	edge_triggered = readl_relaxed(info->base + EIEDG);
> > +	for (i = 0; i < nr_irqs; i++)
> > +		irq_set_handler(virq + i, edge_triggered & BIT(i) ?
> > +						  handle_fasteoi_ack_irq :
> > +							handle_fasteoi_irq);
> > +
> > +	return 0;
> 
> Why do you need this at allocation time? I would have expected the
> trigger configuration to be enough.

I saw the following in the description of the interrupt trigger modes
: When requesting an interrupt without specifying a IRQF_TRIGGER, the
: setting should be assumed to be "as already configured", which may
: be as per machine or firmware initialisation.

From that I was concerned that the callback to set the trigger mode
would not be called in all cases. Thus when I saw that calling
__irq_set_trigger() was on a conditional code path in __setup_irq()
then I wrote the above logic.

I assume I overlooked something? Is a call to exiu_irq_set_type()
guaranteed to happen in all cases?


Daniel.
