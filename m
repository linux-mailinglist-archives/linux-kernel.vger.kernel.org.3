Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248B8514A83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359793AbiD2NcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347736AbiD2NcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:32:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479125F25E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:29:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 129so4662779wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hdhnC9KgjzpQicPMmM1itFR8vpColEKHihALIruZkf8=;
        b=GSzeLj+IHSje4PUAdDJbBJiRe96Ag5litMTL0xlQKN792dfSYzI2RePAFS2gMGJOwA
         NgZiHuoq7CiGZnth2hO0v5zjf9f975okTu2c4ZvjrdbP4AsQWNHI6qwFx0cz5HAMy1T+
         RtZSzWyqxF9WzJZP3uGIM3Kz2kYiMBsofEQ0v/4vRyA2hXsS39niR2jcpN933x3AllIy
         YXaxqH66SnojV+0z6ncHPcgOiIH3yjI6M0MLgiKt6IpaQZU++wl0odjQxIEG3OTNGCXk
         zmMM7L5BFSos6pCDPUecKoTF5/e3cfRiEYhnSuuNPMaeJsiLwN4DIO/3THzmmO+IFJs5
         f+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hdhnC9KgjzpQicPMmM1itFR8vpColEKHihALIruZkf8=;
        b=g0WAqIL/V9xvj+SQDeTIG0jY83xMiPY/dWzvqvSKw869PL2MV9HCBi1i/BMMPJDzDW
         NNrNRxzSDSv3H/lEqwVFnex2U0ifyXWvFC4iBjzGakYFr9kOlyv9xp010C6y0vBFyI7V
         2gbHoy8Zy8AtfkUjE4l3qgqgKgCrkJjjc2K7cgs1QhKF2ZnUurgAjwPzGc7821HpR5Yf
         C4TwMZUXs87OURU9IlsEZEuZoB/udNZsZW5nhpuXgfuAtQAiA0oG2bniDJPKDm5c4OMG
         m4PAbPds5g6x8v619tQvCoTXH+ePQjXSksDYIzeEWOxb66k31JthqSU8OVgnb3+mppxa
         Zgbg==
X-Gm-Message-State: AOAM5338V630W87lcUHhyrirpF6FpbZLhAgWQlnfbyFCSncgQwSiXZmV
        mrHfM66HAhTiBuzI/jVaUgk/wA==
X-Google-Smtp-Source: ABdhPJyWVfhE4AEUc4/m4QHAwPxIU/qsK3YPAFde2Mg/w4pyfmSoq68X4WgNlBg/6VQ5b5AxowXBXg==
X-Received: by 2002:a05:600c:a42:b0:393:d831:bf05 with SMTP id c2-20020a05600c0a4200b00393d831bf05mr3175966wmq.187.1651238940616;
        Fri, 29 Apr 2022 06:29:00 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm6544777wmi.17.2022.04.29.06.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:28:59 -0700 (PDT)
Date:   Fri, 29 Apr 2022 14:28:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/exiu: Fix acknowledgment of edge triggered
 interrupts
Message-ID: <20220429132858.gaqhjrxblciacvki@maple.lan>
References: <20220427142647.1736658-1-daniel.thompson@linaro.org>
 <CAMj1kXEYO_HRwZ=Wz5aTWN8XZctemVv2op4B2=DbFEozuxTNVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEYO_HRwZ=Wz5aTWN8XZctemVv2op4B2=DbFEozuxTNVw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 05:29:33PM +0200, Ard Biesheuvel wrote:
> On Wed, 27 Apr 2022 at 16:27, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
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
> > Fix this by clearing the interrupt request from .irq_ack() instead. This
> > requires switching to the fasteoi-ack flow instead of the fasteoi flow.
> > This approach is inspired by the nmi code found in irq-sun6i-r.c .
> >
> 
> How are level triggered EXIU interrupts affected by this change?

Functionally they should not be affected simply because the controller
does not care when (or even if) software writes to IREQCLR... and
testing on SC2A11/Developerbox with a hacked gpio-keys driver does
back this up.

Since the controller doesn't really care either way I originally
decided to change the flow globally. We could perhaps optimize things
slightly by switching to the fasteoi flow for level triggered
interrupts... they would then be cheaper than they are today (because
we could avoid the spurious ack entirely).


> > Note: It *is* intentional not to call irq_chip_ack_parent() from
> >       exiu_irq_ack(). Parents that implement the fasteoi-ack flow don't
> >       want us to do that (and we'd crash if we tried).
> >
> > This problem was discovered through code review rather then reproducing
> > missed interrupts in a real platform. Nevertheless the change has been
> > tested for regression on a Developerbox/SC2A11 using the power button
> > (which is edge triggered and is the only thing connected to the EXIU on
> > this platform).
> 
> This is not entirely true. The PHY interrupt is also wired to the
> EXIU, but this never worked reliably, so we don't expose this in the
> DT or ACPI tables.
> I wonder if this change would help, but I don't remember exactly what
> the problem was.

Fair point. Although I'm afraid that, in the short term, I will have to
take the simple approach to fixing this: s/connected/enabled by default/


Daniel.


> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  arch/arm64/Kconfig.platforms   |  1 +
> >  drivers/irqchip/irq-sni-exiu.c | 16 ++++++++++++----
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 30b123cde02c..aaeaf57c8222 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -253,6 +253,7 @@ config ARCH_INTEL_SOCFPGA
> >
> >  config ARCH_SYNQUACER
> >         bool "Socionext SynQuacer SoC Family"
> > +       select IRQ_FASTEOI_HIERARCHY_HANDLERS
> >
> >  config ARCH_TEGRA
> >         bool "NVIDIA Tegra SoC Family"
> > diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
> > index abd011fcecf4..1cc2ec272ebd 100644
> > --- a/drivers/irqchip/irq-sni-exiu.c
> > +++ b/drivers/irqchip/irq-sni-exiu.c
> > @@ -37,12 +37,11 @@ struct exiu_irq_data {
> >         u32             spi_base;
> >  };
> >
> > -static void exiu_irq_eoi(struct irq_data *d)
> > +static void exiu_irq_ack(struct irq_data *d)
> >  {
> >         struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
> >
> >         writel(BIT(d->hwirq), data->base + EIREQCLR);
> > -       irq_chip_eoi_parent(d);
> >  }
> >
> >  static void exiu_irq_mask(struct irq_data *d)
> > @@ -104,7 +103,8 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
> >
> >  static struct irq_chip exiu_irq_chip = {
> >         .name                   = "EXIU",
> > -       .irq_eoi                = exiu_irq_eoi,
> > +       .irq_ack                = exiu_irq_ack,
> > +       .irq_eoi                = irq_chip_eoi_parent,
> >         .irq_enable             = exiu_irq_enable,
> >         .irq_mask               = exiu_irq_mask,
> >         .irq_unmask             = exiu_irq_unmask,
> > @@ -148,6 +148,7 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
> >         struct irq_fwspec parent_fwspec;
> >         struct exiu_irq_data *info = dom->host_data;
> >         irq_hw_number_t hwirq;
> > +       int i, ret;
> >
> >         parent_fwspec = *fwspec;
> >         if (is_of_node(dom->parent->fwnode)) {
> > @@ -165,7 +166,14 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
> >         irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &exiu_irq_chip, info);
> >
> >         parent_fwspec.fwnode = dom->parent->fwnode;
> > -       return irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
> > +       ret = irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (i = 0; i < nr_irqs; i++)
> > +               irq_set_handler(virq+i, handle_fasteoi_ack_irq);
> > +
> > +       return 0;
> >  }
> >
> >  static const struct irq_domain_ops exiu_domain_ops = {
> >
> > base-commit: b2d229d4ddb17db541098b83524d901257e93845
> > --
> > 2.35.1
> >
