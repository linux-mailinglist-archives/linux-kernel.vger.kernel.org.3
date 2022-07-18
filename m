Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11381578622
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiGRPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiGRPTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:19:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E4E004
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6C15ACE1285
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4114C341CE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658157587;
        bh=9GQWLZDlqva32cxjz4dS57dreBSPQTQ0231EYYWHAAo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WN/Qg9AyFCVpNyEfzDdm6ZgU/xnNVIyw+l7g0U1GDC8Diggb3jLegzEDakRNTsmtc
         ueiuwKGlrFCEDGFi80wXghBJcJ7IqKnTru7q4QM3ofuKNvJfenmHqsIeuDes/FAAx5
         GGB+iuEwojfIDVE17c2CTK3LxJ2ZfHoK3dTsM9uW7Sp6E54AhvC3YUG5Ifii/OhaWL
         b01bxo5wvqvkJ+McQTWz1zLmeGOZADkmNpxMIiO+eV9EGbKLTovw8bNJ8eWc0oZTFb
         KacPgBhWSS2B/K9B+EqUnsHPU8By65NtlaRIVc16l6Rqw5OWedJ9BMQ8kGRe0g3Ei9
         MtYDBMVNCX19Q==
Received: by mail-vs1-f51.google.com with SMTP id 185so1057738vsi.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:19:47 -0700 (PDT)
X-Gm-Message-State: AJIora/DNHNLUepP4kul3JsvbU9gQztOEG6fgmVHvUy69Q9abYCV/DN7
        4E8J54sJt9Cya7TWPC7CZ52YLdITVL5Z9s1a61U=
X-Google-Smtp-Source: AGRyM1uavXo2YYdOf54qO+/iAjsMV3gNs4fKeNPtLIXbg/6M5+K5mGq2HTh6/iJOiIN6BxcSJJdmWKUEnUOCtb6nRJk=
X-Received: by 2002:a05:6102:3543:b0:357:3ae7:bbd0 with SMTP id
 e3-20020a056102354300b003573ae7bbd0mr10049249vss.84.1658157586775; Mon, 18
 Jul 2022 08:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn> <1658153621-40445-6-git-send-email-lvjianmin@loongson.cn>
In-Reply-To: <1658153621-40445-6-git-send-email-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 18 Jul 2022 23:19:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6C2+LzQFB+0oVZ2NEsJrOswDXB3Th1VHneFdviC7T9EA@mail.gmail.com>
Message-ID: <CAAhV-H6C2+LzQFB+0oVZ2NEsJrOswDXB3Th1VHneFdviC7T9EA@mail.gmail.com>
Subject: Re: [PATCH V16 05/14] LoongArch: Use ACPI_GENERIC_GSI for gsi handling
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jianmin,

On Mon, Jul 18, 2022 at 10:13 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
> For LoongArch, generic gsi code(driver/acpi/irq.c) can be
> reused after following patchs:
>
> APCI: irq: Add support for multiple GSI domains
> ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback
>
> So, config ACPI_GENERIC_GSI for LoongArch with removing the gsi code
> in arch directory.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>  arch/loongarch/Kconfig       |  1 +
>  arch/loongarch/kernel/acpi.c | 65 --------------------------------------------
>  2 files changed, 1 insertion(+), 65 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 1920d52..7f98fc0 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -112,6 +112,7 @@ config LOONGARCH
>         select TRACE_IRQFLAGS_SUPPORT
>         select USE_PERCPU_NUMA_NODE_ID
>         select ZONE_DMA32
> +       select ACPI_GENERIC_GSI if ACPI
Please use alpha-betical order in Kconfig, thanks.

Huacai
>
>  config 32BIT
>         bool
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index bb729ee..03aa145 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -25,7 +25,6 @@
>  int acpi_strict = 1; /* We have no workarounds on LoongArch */
>  int num_processors;
>  int disabled_cpus;
> -enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
>
>  u64 acpi_saved_sp;
>
> @@ -33,70 +32,6 @@
>
>  #define PREFIX                 "ACPI: "
>
> -int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
> -{
> -       if (irqp != NULL)
> -               *irqp = acpi_register_gsi(NULL, gsi, -1, -1);
> -       return (*irqp >= 0) ? 0 : -EINVAL;
> -}
> -EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> -
> -int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
> -{
> -       if (gsi)
> -               *gsi = isa_irq;
> -       return 0;
> -}
> -
> -/*
> - * success: return IRQ number (>=0)
> - * failure: return < 0
> - */
> -int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
> -{
> -       struct irq_fwspec fwspec;
> -
> -       switch (gsi) {
> -       case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
> -               fwspec.fwnode = liointc_domain->fwnode;
> -               fwspec.param[0] = gsi - GSI_MIN_CPU_IRQ;
> -               fwspec.param_count = 1;
> -
> -               return irq_create_fwspec_mapping(&fwspec);
> -
> -       case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
> -               if (!pch_lpc_domain)
> -                       return -EINVAL;
> -
> -               fwspec.fwnode = pch_lpc_domain->fwnode;
> -               fwspec.param[0] = gsi - GSI_MIN_LPC_IRQ;
> -               fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> -               fwspec.param_count = 2;
> -
> -               return irq_create_fwspec_mapping(&fwspec);
> -
> -       case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
> -               if (!pch_pic_domain[0])
> -                       return -EINVAL;
> -
> -               fwspec.fwnode = pch_pic_domain[0]->fwnode;
> -               fwspec.param[0] = gsi - GSI_MIN_PCH_IRQ;
> -               fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
> -               fwspec.param_count = 2;
> -
> -               return irq_create_fwspec_mapping(&fwspec);
> -       }
> -
> -       return -EINVAL;
> -}
> -EXPORT_SYMBOL_GPL(acpi_register_gsi);
> -
> -void acpi_unregister_gsi(u32 gsi)
> -{
> -
> -}
> -EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> -
>  void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long size)
>  {
>
> --
> 1.8.3.1
>
>
