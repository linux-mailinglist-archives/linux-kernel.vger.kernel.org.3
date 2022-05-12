Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA15246E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350958AbiELH0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiELH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:26:47 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527FA126EA0;
        Thu, 12 May 2022 00:26:46 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id k8so4012590qki.8;
        Thu, 12 May 2022 00:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hXa5ZyCL0c1LJOSj3SaJudX8UU4KaAqyCdW1DHNsjs=;
        b=V4hWpc1M/4xwJCRS2vCe/WUf3PGO1zcTP3zFpN6LvGIbjem+KyMkOZrqjpI1VIyPKW
         YDz8s9UdD2pIP73AmnFPJj4FkkFdzXtzWVLuqRvdy7FU3Ot1YfscsWyKxWH7/G8nYxGw
         3sn9fRqN8n0X6RiWal+f95gWvrdEfA1IAE0snZODd5hZ9SOhYFvnnqRHLNHGYgIiFI1j
         M6sq25JioAhJNiH1h9Je/JjezsXvezi/cCTYpP3E1taxQtBIytaiyAU3bVyg0tGnmz64
         Gf1erSg0jFa7oPBUpz2FHJFgMUBcUnJp74zGTmmA/8ggI9waPAnxjXGT06tuWX9DMA7Y
         Yy9g==
X-Gm-Message-State: AOAM530t5VNWzl36lvoyQ+sot9CFJ6iwXye8oaYFxcbrbDqsG8i3T+dN
        +orv4rthIOv5rmORWa+IX0Zo2BR8EcWF2A==
X-Google-Smtp-Source: ABdhPJyyMnmwQcTDPU7SLDyH+JhA0k7qhJ0V+KILMo7UEVz3ZUqPKl7yQfqbw5fyU5vWgjj9rMR4Bg==
X-Received: by 2002:a37:5d8:0:b0:6a0:91ec:fc64 with SMTP id 207-20020a3705d8000000b006a091ecfc64mr13612549qkf.133.1652340405362;
        Thu, 12 May 2022 00:26:45 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id h197-20020a379ece000000b0069fc13ce227sm2566732qke.88.2022.05.12.00.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:26:44 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id m190so8184105ybf.4;
        Thu, 12 May 2022 00:26:44 -0700 (PDT)
X-Received: by 2002:a25:4506:0:b0:648:cfc2:301d with SMTP id
 s6-20020a254506000000b00648cfc2301dmr26715754yba.380.1652340403876; Thu, 12
 May 2022 00:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <87zgjnmcxt.wl-maz@kernel.org>
In-Reply-To: <87zgjnmcxt.wl-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 May 2022 09:26:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXb0H010_kr_-rMosynKv8HxU+Q45jR88wCYepkWpxB_Q@mail.gmail.com>
Message-ID: <CAMuHMdXb0H010_kr_-rMosynKv8HxU+Q45jR88wCYepkWpxB_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi Marc,

On Thu, May 12, 2022 at 9:23 AM Marc Zyngier <maz@kernel.org> wrote:
> On Wed, 11 May 2022 19:32:07 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> >
> > This supports external pins being used as interrupts. It supports
> > one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> > to be used as IRQ lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > +static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
> > +{
> > +     struct irq_domain *irq_domain, *parent_domain;
> > +     struct reset_control *resetn;
> > +     struct rzg2l_irqc_priv *priv;
> > +     struct clk *clk;
> > +     struct clk *pclk;
> > +     int ret;
> > +
> > +     priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
>
> Since you are implementing this as a platform driver, consider
> converting this to the devm_* helpers (you can obtain the device
> structure via of_find_device_by_node()).

So that's the missing piece.
Still, it would be more efficient to just pass the pointer, as
platform_irqchip_probe() already has the pointer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
