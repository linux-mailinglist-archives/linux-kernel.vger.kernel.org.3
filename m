Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270B6513074
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiD1Jwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349306AbiD1Jph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:45:37 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B3599180;
        Thu, 28 Apr 2022 02:42:23 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id b20so576448qkc.6;
        Thu, 28 Apr 2022 02:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqTvPqe9Ior33TBYfq0U+wCDWY6AJ5fZdCKmCA3PjQ8=;
        b=WL1xPPcrzziq9BGQBl6z0pmwjgeKugguQU1vb+ygzfnb8jEGPEvCdHJN8huF/EJ41m
         EDH3wBjEvySIxz89Y3Qz+OjtpdyBswlf3nHvzuy9S/SXhT0kxb0oIfYjRZGUOWKVlfKO
         VdzI3F89g2ZHIbgvpZsJ5u/eSPetrrRMYUX5TifyNtR346OGDBwhCjjZs1JqzkhP9O97
         rpgvsSZeYFFYECoGStL2J6LTkPWmRXWVqSs95MwiFTiKPkw+qigepc7hWo5zJL3YwVi3
         38tnLYAbnLTr0JLGAJK1gNKSxmct7l9KnMNRa3l6SuhQbT6qOUDAnYKVkUDsEEnyrLne
         1Xgg==
X-Gm-Message-State: AOAM532KbCiIjFdMDX/q9xjowURphsc4iXFnoWf9Khi17XuOpxStMYzW
        8nuJG6tyB2aa5kLwnm4ERYRP8scmf/jakg==
X-Google-Smtp-Source: ABdhPJx27jkCZ/2U/QKFvGdfUHx5AJrVPFc3d6rvyjjpLG0eVJIgLLuvEYe/1MPSXjYzbS7u3I1bxQ==
X-Received: by 2002:a05:620a:1432:b0:69f:87c4:adc9 with SMTP id k18-20020a05620a143200b0069f87c4adc9mr6097536qkj.16.1651138942023;
        Thu, 28 Apr 2022 02:42:22 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id p14-20020a05622a13ce00b002f20a695972sm11820482qtk.14.2022.04.28.02.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:42:21 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id g28so7960688ybj.10;
        Thu, 28 Apr 2022 02:42:21 -0700 (PDT)
X-Received: by 2002:a25:d84c:0:b0:648:7d5e:e2d4 with SMTP id
 p73-20020a25d84c000000b006487d5ee2d4mr16788803ybg.6.1651138940792; Thu, 28
 Apr 2022 02:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220421221159.31729-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220421221159.31729-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 11:42:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVqk1ryzzK9-BZCMDPeyjfF1-8hMpzUoEPCcg8pJ2-ang@mail.gmail.com>
Message-ID: <CAMuHMdVqk1ryzzK9-BZCMDPeyjfF1-8hMpzUoEPCcg8pJ2-ang@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add a driver for the Renesas RZ/G2L Interrupt Controller.
>
> This supports external pins being used as interrupts. It supports
> one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> to be used as IRQ lines.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L IRQC Driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation.
> + *
> + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +
> +#define IRQC_IRQ_START                 1
> +#define IRQC_IRQ_COUNT                 8
> +#define IRQC_TINT_START                        9

= IRQC_IRQ_START + IRQC_IRQ_COUNT

> +#define IRQC_TINT_COUNT                        32
> +#define IRQC_NUM_IRQ                   41

= IRQC_TINT_START + IRQC_TINT_COUNT

Should these be in a DT binding header file?

Combining all types into a single linear number space makes it hard
to extend the range, when reusing for an SoC that supports more
interrupt sources.

> +static void rzg2l_irq_eoi(struct irq_data *d)
> +{
> +       struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> +       unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
> +       u16 bit = BIT(hw_irq);

I guess you can just use u32?

> +       u32 reg;
> +
> +       reg = readl_relaxed(priv->base + ISCR);
> +       if (reg & bit)
> +               writel_relaxed(GENMASK(IRQC_IRQ_COUNT - 1, 0) & ~bit,

As writes to the unused upper bits are ignored, you can drop the
masking with GENMASK(IRQC_IRQ_COUNT - 1, 0), and be prepared for more
interrupt sources.

> +                              priv->base + ISCR);
> +}
> +
> +static void rzg2l_tint_eoi(struct irq_data *d)
> +{
> +       struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> +       unsigned int hw_irq = irqd_to_hwirq(d);

"irqd_to_hwirq(d) - IRQC_TINT_START", for symmetry with
rzg2l_irq_eoi()?

> +       u32 bit = BIT(hw_irq - IRQC_TINT_START);
> +       u32 reg;
> +
> +       reg = readl_relaxed(priv->base + TSCR);
> +       if (reg & bit)
> +               writel_relaxed(GENMASK(IRQC_TINT_COUNT - 1, 0) & ~bit,

Drop the masking with all-ones?

> +                              priv->base + TSCR);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
