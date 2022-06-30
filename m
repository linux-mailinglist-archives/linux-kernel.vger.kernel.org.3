Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9384561553
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiF3Ilx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiF3Ilq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:41:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8886419A7;
        Thu, 30 Jun 2022 01:41:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fw3so9913552ejc.10;
        Thu, 30 Jun 2022 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8PWp7CT+a4Cdbu7pbxuMN1p1lItuhAgjjkTwNl1V/A=;
        b=YvD7Wbe7P2DhCWvCmK8nvteCR9/W7mB+DWuDJv3xntXJR4A+I//2Nt5cI+n2TNXbCt
         jdUwkGe0nQqHaljCPo9wuuhWgLQXTon0Qycm7TVjVPvB7tlImbpokyvYw3osVYKfxTkt
         V88H+s3vOsSc5340uZ9shAyjF8VnZwwQrQOelcSQ5pxsdXyY3qdBOYh13/hkDzoRlapU
         GfF8gN3KDO8u9k4+HYzNZciJqCimUK8W1ZvzgOduqBhhVb2dF67CLtXlHJ9gDThiEkgh
         74zGWx0W7FxZpnGNNhhFEhA3WgKd2nJYmyEzInGF+R4M3XoPaS1IF/NE/7WIjs4M7ca7
         W8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8PWp7CT+a4Cdbu7pbxuMN1p1lItuhAgjjkTwNl1V/A=;
        b=ZEzI2PyciCKvNI0d+qmx2NNvgIW8bu2fpu1FTkHCzqvdJFTBSpUXUqM+2YXAQY9CqZ
         e/VmrFuG1uFLrGQpWygSQ8BgLPdR9ySP9RxGeBdHKpU3+MOzod0grz4GaBL8hvrr+wnf
         TJP4ANMmUsxZDhuu16N9/YW0Bjr5YVIQ7BJZFV7+ny+ZX21b8jm7J4H09SGpGCTIsMUC
         RUbaZ0rJhrsWNn2c4WcFt726bwDDb711AZfRGa4BvRhZaR7Lh4/4gIRjzDvcQM3AFi4L
         bYQYAs9F0HwhkpfZQi1ZOmM5E2EsmpMkC1nfu60Voa5SeeasS9RjmtLT8yhYujGwGEDD
         8Vmw==
X-Gm-Message-State: AJIora+EbEBpbju51E0a0f4h1FE7atCgX23O4aawvgPTOa5T5dO2KTKD
        O/hE0jZj9n82dGn0Z0ihVAiDr3VcnQreDfutB7w=
X-Google-Smtp-Source: AGRyM1v0aolLCGsxqvRLvU7XtUB4FDymZT6hhut66ARDGzTHXmFOSBOyNhiRbWqef/qPCoEMvSSgEqZ88TinxZa0ovM=
X-Received: by 2002:a17:907:763a:b0:72a:5128:b34f with SMTP id
 jy26-20020a170907763a00b0072a5128b34fmr3664193ejc.372.1656578503461; Thu, 30
 Jun 2022 01:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220625200600.7582-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220625200600.7582-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <87pmir1ln2.wl-maz@kernel.org>
In-Reply-To: <87pmir1ln2.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Jun 2022 09:41:16 +0100
Message-ID: <CA+V-a8vYaoP3V4XgY+7nWkJx2OL-Ju1yq6Sjr7n_PCw8tt14dA@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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

Hi Marc,

Thank you for the review.

On Wed, Jun 29, 2022 at 5:26 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 25 Jun 2022 21:06:00 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Add IRQ domain to RZ/G2L pinctrl driver to handle GPIO interrupt.
> >
> > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > used as IRQ lines at a given time. Selection of pins as IRQ lines
> > is handled by IA55 (which is the IRQC block) which sits in between the
> > GPIO and GIC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 236 ++++++++++++++++++++++++
> >  1 file changed, 236 insertions(+)
> >
>
> [...]
>
> > +static void *rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
> > +                                            unsigned int parent_hwirq,
> > +                                            unsigned int parent_type)
> > +{
> > +     struct irq_fwspec *fwspec;
> > +
> > +     fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
> > +     if (!fwspec)
> > +             return NULL;
> > +
> > +     fwspec->fwnode = chip->irq.parent_domain->fwnode;
> > +     fwspec->param_count = 2;
> > +     fwspec->param[0] = parent_hwirq;
> > +     fwspec->param[1] = parent_type;
> > +
> > +     return fwspec;
> > +}
>
> I jumped at this one again.
>
> Can you please pick [1] as part of your series and write this in a way
> that doesn't require extra memory allocation? It has already been
> ack'ed by Linus anyway, and we'd put an end to this thing for good.
>
Sure will update and post a v7.

Cheers,
Prabhakar
