Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B55186AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiECOcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiECOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:32:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787531513
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:28:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 683C3B81EF3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27865C385A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651588137;
        bh=McCEeMufoSF0VhKl03e1b3Tj1gJxcqUA9zBIZZpWMsc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=enbyHLu7V70hvNaDLR6dUjsjZpUquCt+tV7BAuDDafBDVtvvmFUbbR//s/YL6dBKR
         xleq8AZyXTbI/siiXQuLiLrO6679E91/lHTTGIp/qKF2GB/YENPOeb0Z4R0PfLwYz7
         fI3RiyHM4gQROz/N6vkA4Oa/GjlDP7LiPY4iL4v28l/JLVO20p1Bxj0zUSzSDs91/8
         qAQMqM3YZVq4rO7U0FsdJfXQNCG0uPWsitX8DQQ5zKFE5fIFn7rFZ6J9Z/vehTWG2F
         MWFPXEJjkq8sKRxjGAFDVUCgVqoH0C6nQjA5eHjaGkH5S1qQ2bwxMda3S8yG3zvN8K
         73GQgFYd/qLhg==
Received: by mail-oi1-f175.google.com with SMTP id v65so18310744oig.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:28:57 -0700 (PDT)
X-Gm-Message-State: AOAM531UAu2fFPBP18wpwic5ab5z3x6oN4ejI8zPi3ILtOnFVHEafimH
        ynrvFGnwRDaa5lhfC6t8B/ggaEYAhOHv7FnyAOE=
X-Google-Smtp-Source: ABdhPJxwmkCKKyxxzu+sjE8gS2PyWd9JAAqmLXn+SNN8w8OLrJBe32aFpUDna6kO25Xa7KOBDLIh/MAl+haRAYUjFuw=
X-Received: by 2002:a05:6808:1315:b0:326:4405:e405 with SMTP id
 y21-20020a056808131500b003264405e405mr388206oiv.228.1651588136115; Tue, 03
 May 2022 07:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220503134541.2566457-1-daniel.thompson@linaro.org>
In-Reply-To: <20220503134541.2566457-1-daniel.thompson@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 May 2022 16:28:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH0NaDPJPbPUEx+hfyOLC_CwsyoOOX5L-F=Lq6fw5-yvg@mail.gmail.com>
Message-ID: <CAMj1kXH0NaDPJPbPUEx+hfyOLC_CwsyoOOX5L-F=Lq6fw5-yvg@mail.gmail.com>
Subject: Re: [PATCH v3] irqchip/exiu: Fix acknowledgment of edge triggered interrupts
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2022 at 15:45, Daniel Thompson <daniel.thompson@linaro.org> wrote:
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
> Fix this by clearing the interrupt request from .irq_ack() if we are
> configured for edge triggered interrupts. This requires adopting the
> fasteoi-ack flow instead of the fasteoi to ensure the ack gets called.
>
> These changes have been tested using the power button on a
> Developerbox/SC2A11 combined with some hackery in gpio-keys so I can
> play with the different trigger mode [and an mdelay(500) so I can
> can check what happens on a double click in both modes].
>
> Fixes: 706cffc1b912 ("irqchip/exiu: Add support for Socionext Synquacer EXIU controller")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
> Notes:
>     Changes in v3:
>      * Optimize exiu_irq_eoi() to avoid unnecessary register read (Marc Z)
>      * Add comment to exiu_irq_eoi() so future adventurers can better
>        understand how the EXIU on SC2A11 behaves (Marc Z)
>      * Remove redundant trigger mode management from exiu_domain_alloc()
>        (Marc Z)
>
>     Changes in v2:
>
>      * Switch to dynamic selection of handle_fasteoi_irq and
>        handle_fasteoi_ack_irq and reintroduce exiu_irq_eoi() since we need
>        that for level triggered interrupts (Ard B).
>      * Above changes mean we are no longer using sun6i NMI code as a
>        template to tidy up the description accordingly.
>
>  arch/arm64/Kconfig.platforms   |  1 +
>  drivers/irqchip/irq-sni-exiu.c | 25 ++++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
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
> index abd011fcecf4..c7db617e1a2f 100644
> --- a/drivers/irqchip/irq-sni-exiu.c
> +++ b/drivers/irqchip/irq-sni-exiu.c
> @@ -37,11 +37,26 @@ struct exiu_irq_data {
>         u32             spi_base;
>  };
>
> -static void exiu_irq_eoi(struct irq_data *d)
> +static void exiu_irq_ack(struct irq_data *d)
>  {
>         struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
>
>         writel(BIT(d->hwirq), data->base + EIREQCLR);
> +}
> +
> +static void exiu_irq_eoi(struct irq_data *d)
> +{
> +       struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
> +
> +       /*
> +        * Level triggered interrupts are latched and must be cleared during
> +        * EOI or the interrupt will be jammed on. Of course if a level
> +        * triggered interrupt is still asserted then the write will not clear
> +        * the interrupt.
> +        */
> +       if (irqd_is_level_type(d))
> +               writel(BIT(d->hwirq), data->base + EIREQCLR);
> +
>         irq_chip_eoi_parent(d);
>  }
>
> @@ -91,10 +106,13 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
>         writel_relaxed(val, data->base + EILVL);
>
>         val = readl_relaxed(data->base + EIEDG);
> -       if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH)
> +       if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH) {
>                 val &= ~BIT(d->hwirq);
> -       else
> +               irq_set_handler_locked(d, handle_fasteoi_irq);
> +       } else {
>                 val |= BIT(d->hwirq);
> +               irq_set_handler_locked(d, handle_fasteoi_ack_irq);
> +       }
>         writel_relaxed(val, data->base + EIEDG);
>
>         writel_relaxed(BIT(d->hwirq), data->base + EIREQCLR);
> @@ -104,6 +122,7 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
>
>  static struct irq_chip exiu_irq_chip = {
>         .name                   = "EXIU",
> +       .irq_ack                = exiu_irq_ack,
>         .irq_eoi                = exiu_irq_eoi,
>         .irq_enable             = exiu_irq_enable,
>         .irq_mask               = exiu_irq_mask,
>
> base-commit: b2d229d4ddb17db541098b83524d901257e93845
> --
> 2.35.1
>
