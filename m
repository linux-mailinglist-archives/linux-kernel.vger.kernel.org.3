Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE25611DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiF3Fky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiF3Fku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:40:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2126A213;
        Wed, 29 Jun 2022 22:40:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q6so36701569eji.13;
        Wed, 29 Jun 2022 22:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWgN6CFIETedoR5asDITdmqEoVxTerB8Rm7YXCH/ejI=;
        b=Xka2UZzDjCNUjQ62ik87OhSKy17vv7/K7W44vUPjJg91nvTH9J+1R2Bqfuqtd+Fd9B
         PE5bouoBm6M6Ge1lT76Qxj6L9tzXgc1wY/ujRwwRpHYfDin3aoQjTfEpxgv7DoeYFru/
         7rYl8jkU+ok/de6qD3DO0hgxsDbBIor97JiYk+YMJPpPtOQ1V8FbEWr8nPTvo12pssUh
         iqrbX/iO3Qyj3rP4eQ/Iw3JmOY4hCBKbRgU3N8PyK2qHavMjqdixtDnzguvoFztyd8mr
         77cSnRmro8MbkgwXjPvK2rp9cYjUYXMCoAmF6rvnrLpwPIf/G5H4dOP50KI8SQbFR7qq
         m7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWgN6CFIETedoR5asDITdmqEoVxTerB8Rm7YXCH/ejI=;
        b=CjZyvVHPAIvRY9bKQp5TgEs6IMTBiI2gQ8qiHzz64yH4yuArUETiNydUI8N2pFcmi/
         wsIS7J8L1uq3t8XomeeOUpaIH44BRhfPSaZe1u8EQDz2a5x1EtnXsleTSJpoaOSJyPRz
         ETrzvko4aAziQ702htbdZGzTb2POeIWpA03SuWMrWWazRXcVboIu2H4trfsJfSyu+RXr
         fKCzqp9tDZVFxP6BZvFwxqL3eMEOERjREkLRSEuCSjMkMUqyonYzo/UuB+iALauIW54A
         TWbeNVcIwpBRUO1LMRq96hSUSog15gmrbqENptbyYMzt1iisiEOwtNX1stv2QfXI+URA
         O5jg==
X-Gm-Message-State: AJIora89+FKifqyJs+QMHPxGf5H3deDYagJE1+E5NNV3UZT4RqWOJwVT
        /dw5FFVKv9NATuQdvjMNDulrmJjlbG/aIOtJeOo=
X-Google-Smtp-Source: AGRyM1uoy/Y4xr5vEES0MoYvJmJQ0KxLhYf5Rqg4en/Nz/V0Um49hYuoeLRWMj9Nf1xYbkhlpuZizkIffMUCFZgFK/E=
X-Received: by 2002:a17:906:4985:b0:727:c6ac:5b31 with SMTP id
 p5-20020a170906498500b00727c6ac5b31mr6950859eju.501.1656567647742; Wed, 29
 Jun 2022 22:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220625200600.7582-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220625200600.7582-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <f51a6ccda0f7b4596406789fa73e1bdad85186bc.camel@pengutronix.de>
In-Reply-To: <f51a6ccda0f7b4596406789fa73e1bdad85186bc.camel@pengutronix.de>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Jun 2022 06:40:21 +0100
Message-ID: <CA+V-a8vHZC8DZqJ57WuEeqne09+AB5Z-oLc9aXitp8VxRSV6Lw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for the review.

On Wed, Jun 29, 2022 at 5:29 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Sa, 2022-06-25 at 21:05 +0100, Lad Prabhakar wrote:
> > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> >
> > This supports external pins being used as interrupts. It supports
> > one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> > to be used as IRQ lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/irqchip/Kconfig             |   8 +
> >  drivers/irqchip/Makefile            |   1 +
> >  drivers/irqchip/irq-renesas-rzg2l.c | 393 ++++++++++++++++++++++++++++
> >  3 files changed, 402 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
> >
> [...]
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> > new file mode 100644
> > index 000000000000..cc16fcf2bbc6
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -0,0 +1,393 @@
> [...]
> > +static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
> > +{
> > +     struct irq_domain *irq_domain, *parent_domain;
> > +     struct platform_device *pdev;
> > +     struct reset_control *resetn;
> > +     struct rzg2l_irqc_priv *priv;
> > +     int ret;
> > +
> > +     pdev = of_find_device_by_node(node);
> > +     if (!pdev)
> > +             return -ENODEV;
> > +
> > +     parent_domain = irq_find_host(parent);
> > +     if (!parent_domain) {
> > +             dev_err(&pdev->dev, "cannot find parent domain\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
> > +     if (IS_ERR(priv->base))
> > +             return PTR_ERR(priv->base);
> > +
> > +     ret = rzg2l_irqc_parse_interrupts(priv, node);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     resetn = devm_reset_control_get_exclusive_by_index(&pdev->dev, 0);
>
> Why is this by index? I'd expect
>
>         resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>
> should work just as well?
>
Agreed will replace it to devm_reset_control_get_exclusive().

Cheers,
Prabhakar
