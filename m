Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97B51206B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbiD0PdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbiD0Pc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE645996A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D415615BA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA558C385B0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651073385;
        bh=SuocwpCjqTu/RoO5/j9WegMtN6XL9gDtWCu5vHJx2sc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KvZdEbjUqXZL11mWpStvoG9h4FTYk6ORMVlEOqu1DVKCADU3IERjZqJ2RYgDrYZJk
         RXCh4WrBoxZVxxrDIN2Y/5lTCi2LljZywJvPtDwzuYcEQZQk14VVq8pGAVKNUjTid7
         OGBrMO8qbFwwusN77C9SIcR+dAc1DObzfTZrvM6UVE+U/Y4k/rGDh/ZrFw3nRs2u+B
         YjSZ5s86x/vqJm012mVc66kHt5CyLChOdiNjoTNAWsWdFEXFcRgUpM03W3Cbm4XqRC
         0yFbKlf6+Dny6IXiySMJEzCMJya5MjaT/EzNRs/Y/3JKiAN741hhibP7ZCzGL46lJA
         WrbYny02tMAow==
Received: by mail-oi1-f170.google.com with SMTP id 12so2304131oix.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:29:45 -0700 (PDT)
X-Gm-Message-State: AOAM5337cXYj9YzjkJKBYkLul4AQBA3zx+5SasYSxRLsrAoo5RGNZqbc
        K/8squzW1VMzR0WD9dJKV5hy99zKfdoqY+4xpOE=
X-Google-Smtp-Source: ABdhPJxyWgdJAnW+Gww5XnytDuqvsPuywxLHfla7SRSoMVZcTzGv9B7Q5QKSuuOeHUEgFtxkIpBUG2TFUYcM2GGkogo=
X-Received: by 2002:a05:6808:e8d:b0:322:bac0:2943 with SMTP id
 k13-20020a0568080e8d00b00322bac02943mr13439392oil.126.1651073384687; Wed, 27
 Apr 2022 08:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220427142647.1736658-1-daniel.thompson@linaro.org>
In-Reply-To: <20220427142647.1736658-1-daniel.thompson@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Apr 2022 17:29:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEYO_HRwZ=Wz5aTWN8XZctemVv2op4B2=DbFEozuxTNVw@mail.gmail.com>
Message-ID: <CAMj1kXEYO_HRwZ=Wz5aTWN8XZctemVv2op4B2=DbFEozuxTNVw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/exiu: Fix acknowledgment of edge triggered interrupts
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 at 16:27, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently the EXIU uses the fasteoi interrupt flow that is configured by
> it's parent (irq-gic-v3.c). With this flow the only chance to clear the
> interrupt request happens during .irq_eoi() and (obviously) this happens
> after the interrupt handler has run. EXIU requires edge triggered
> interrupts to be acked prior to interrupt handling. Without this we
> risk incorrect interrupt dismissal when a new interrupt is delivered
> after the handler reads and acknowledges the peripheral but before the
> irq_eoi() takes place.
>
> Fix this by clearing the interrupt request from .irq_ack() instead. This
> requires switching to the fasteoi-ack flow instead of the fasteoi flow.
> This approach is inspired by the nmi code found in irq-sun6i-r.c .
>

How are level triggered EXIU interrupts affected by this change?

> Note: It *is* intentional not to call irq_chip_ack_parent() from
>       exiu_irq_ack(). Parents that implement the fasteoi-ack flow don't
>       want us to do that (and we'd crash if we tried).
>
> This problem was discovered through code review rather then reproducing
> missed interrupts in a real platform. Nevertheless the change has been
> tested for regression on a Developerbox/SC2A11 using the power button
> (which is edge triggered and is the only thing connected to the EXIU on
> this platform).
>

This is not entirely true. The PHY interrupt is also wired to the
EXIU, but this never worked reliably, so we don't expose this in the
DT or ACPI tables.
I wonder if this change would help, but I don't remember exactly what
the problem was.

> Fixes: 706cffc1b912 ("irqchip/exiu: Add support for Socionext Synquacer EXIU controller")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  arch/arm64/Kconfig.platforms   |  1 +
>  drivers/irqchip/irq-sni-exiu.c | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 30b123cde02c..aaeaf57c8222 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -253,6 +253,7 @@ config ARCH_INTEL_SOCFPGA
>
>  config ARCH_SYNQUACER
>         bool "Socionext SynQuacer SoC Family"
> +       select IRQ_FASTEOI_HIERARCHY_HANDLERS
>
>  config ARCH_TEGRA
>         bool "NVIDIA Tegra SoC Family"
> diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
> index abd011fcecf4..1cc2ec272ebd 100644
> --- a/drivers/irqchip/irq-sni-exiu.c
> +++ b/drivers/irqchip/irq-sni-exiu.c
> @@ -37,12 +37,11 @@ struct exiu_irq_data {
>         u32             spi_base;
>  };
>
> -static void exiu_irq_eoi(struct irq_data *d)
> +static void exiu_irq_ack(struct irq_data *d)
>  {
>         struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
>
>         writel(BIT(d->hwirq), data->base + EIREQCLR);
> -       irq_chip_eoi_parent(d);
>  }
>
>  static void exiu_irq_mask(struct irq_data *d)
> @@ -104,7 +103,8 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
>
>  static struct irq_chip exiu_irq_chip = {
>         .name                   = "EXIU",
> -       .irq_eoi                = exiu_irq_eoi,
> +       .irq_ack                = exiu_irq_ack,
> +       .irq_eoi                = irq_chip_eoi_parent,
>         .irq_enable             = exiu_irq_enable,
>         .irq_mask               = exiu_irq_mask,
>         .irq_unmask             = exiu_irq_unmask,
> @@ -148,6 +148,7 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
>         struct irq_fwspec parent_fwspec;
>         struct exiu_irq_data *info = dom->host_data;
>         irq_hw_number_t hwirq;
> +       int i, ret;
>
>         parent_fwspec = *fwspec;
>         if (is_of_node(dom->parent->fwnode)) {
> @@ -165,7 +166,14 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
>         irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &exiu_irq_chip, info);
>
>         parent_fwspec.fwnode = dom->parent->fwnode;
> -       return irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
> +       ret = irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < nr_irqs; i++)
> +               irq_set_handler(virq+i, handle_fasteoi_ack_irq);
> +
> +       return 0;
>  }
>
>  static const struct irq_domain_ops exiu_domain_ops = {
>
> base-commit: b2d229d4ddb17db541098b83524d901257e93845
> --
> 2.35.1
>
