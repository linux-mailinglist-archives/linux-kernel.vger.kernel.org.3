Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D2F524673
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350742AbiELHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350774AbiELHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:06:08 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD5CD3;
        Thu, 12 May 2022 00:06:06 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id a22so3997804qkl.5;
        Thu, 12 May 2022 00:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZq5KQ7PbYNEAlZ3QkxMc8y4Xac8EM18MZB7pmG8rGs=;
        b=RFH58T1tiKFNLyf3PNjwmqmRMNNDbE29N9RsKv+FdUpQ8FI3FrnOpL54mLNufp3RnL
         2LtQGFk3TxfNngX+6HdQgvK48s4Jc7+cIywUFsWjQ3us/31C5rPAckmGAoRBXzq4EPj8
         hZjPnWHZtxxVwOALDBWZCpSweyWOc9BM8N/j+M10hmzFPBaEv87xkNojrQY+JEf4pGK/
         nrJ0PFFw3e8hxsIEx0eJSODsp/L7LHmEmClUdZHSfran9APtfFP0srEnrF67AVc3FBwQ
         9yJSuyWdND/pICOafB3x5/rCSR9tIUzmgfgkz4PvjTPbIJZxbIOV3dQiBusQZTK7l0MG
         F80w==
X-Gm-Message-State: AOAM530SrcF7JDabLi4P4mOuFGi6VSiQPTF9tfUMh9KACWqRmB8bKRz4
        DA3VEmaC+WP5eXIQ7oyaWYC/ghsrkinSCA==
X-Google-Smtp-Source: ABdhPJxHdA9T+GeoSG62uIbqlG++dUzTUGAvmmXXRTValPzVDa67XHHYCGDnhfNw9L6rUMkY/5Chkw==
X-Received: by 2002:a37:bbc4:0:b0:69b:db2c:c962 with SMTP id l187-20020a37bbc4000000b0069bdb2cc962mr21881103qkf.565.1652339165226;
        Thu, 12 May 2022 00:06:05 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a0b4400b0069fcebf9c0asm2453284qkg.37.2022.05.12.00.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:06:04 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f7bb893309so45452707b3.12;
        Thu, 12 May 2022 00:06:03 -0700 (PDT)
X-Received: by 2002:a81:2143:0:b0:2fb:1274:247e with SMTP id
 h64-20020a812143000000b002fb1274247emr29285779ywh.384.1652339163593; Thu, 12
 May 2022 00:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220511183210.5248-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 May 2022 09:05:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9kfhr3d=yG8yfAuX+yBTR5vQr8XRi5ymbRyEVfWAjDg@mail.gmail.com>
Message-ID: <CAMuHMdW9kfhr3d=yG8yfAuX+yBTR5vQr8XRi5ymbRyEVfWAjDg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add a driver for the Renesas RZ/G2L Interrupt Controller.
>
> This supports external pins being used as interrupts. It supports
> one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> to be used as IRQ lines.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

LGTM ("I'm no irqchip expert"), so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One suggestion for improvement below, which needs changes to the
irqchip core code, though.

> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c

> +static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
> +{
> +       struct irq_domain *irq_domain, *parent_domain;
> +       struct reset_control *resetn;
> +       struct rzg2l_irqc_priv *priv;
> +       struct clk *clk;
> +       struct clk *pclk;
> +       int ret;
> +
> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->base = of_iomap(node, 0);
> +       if (!priv->base) {
> +               ret = -ENXIO;
> +               goto free_priv;
> +       }
> +
> +       clk = of_clk_get_by_name(node, "clk");
> +       if (IS_ERR(clk)) {
> +               ret = IS_ERR(clk);
> +               goto iounmap_base;
> +       }
> +
> +       pclk = of_clk_get_by_name(node, "pclk");
> +       if (IS_ERR(pclk)) {
> +               ret = IS_ERR(pclk);
> +               goto iounmap_base;
> +       }
> +
> +       resetn = of_reset_control_get_exclusive_by_index(node, 0);
> +       if (IS_ERR(resetn)) {
> +               ret = IS_ERR(resetn);
> +               goto iounmap_base;
> +       }
> +
> +       parent_domain = irq_find_host(parent);
> +       if (!parent_domain) {
> +               pr_err("%pOF: cannot find parent domain\n", node);
> +               ret = -ENODEV;
> +               goto iounmap_base;
> +       }
> +
> +       ret = rzg2l_irqc_parse_map(priv, node);
> +       if (ret) {
> +               pr_err("%pOF: cannot parse interrupts: %d\n", node, ret);
> +               goto iounmap_base;
> +       }
> +
> +       ret = reset_control_deassert(resetn);
> +       if (ret) {
> +               pr_err("%pOF: failed to deassert resetn pin, %d\n", node, ret);
> +               goto iounmap_base;
> +       }
> +
> +       raw_spin_lock_init(&priv->lock);
> +
> +       ret = clk_prepare_enable(clk);
> +       if (ret)
> +               goto assert_reset;
> +
> +       ret = clk_prepare_enable(pclk);
> +       if (ret)
> +               goto disable_clk;

As the driver doesn't care about the properties of the clock, but
just needs to enable them, I think it would be worthwhile to replace
the explicit clock handling by Runtime PM.
But that needs access to the struct device pointer.
Of course that can be done later (see below).

> +
> +       irq_domain = irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
> +                                             node, &rzg2l_irqc_domain_ops,
> +                                             priv);
> +       if (!irq_domain) {
> +               pr_err("%pOF: cannot initialize irq domain\n", node);
> +               ret = -ENOMEM;
> +               goto fail_irq_domain;
> +       }
> +
> +       return 0;
> +
> +fail_irq_domain:
> +       clk_disable_unprepare(pclk);
> +disable_clk:
> +       clk_disable_unprepare(clk);
> +assert_reset:
> +       reset_control_assert(resetn);
> +iounmap_base:
> +       iounmap(priv->base);
> +free_priv:
> +       kfree(priv);
> +       return ret;
> +}
> +
> +IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
> +IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
> +IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)

While platform_irqchip_probe() has access to the platform_device,
it does not pass that to the driver's initialization function, so
that function does not have access to the device framework.
Hence it can not be used for interrupt controllers that are part of a
Power Domain, as, unlike clocks, Power Domains can only be controlled
from Runtime PM, and thus require access to a struct device pointer.
I think it would be good to fix this sooner rather than later; there
are only a handful of users of this interface yet.

> +MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
> +MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
