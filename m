Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78F85653DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiGDLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiGDLj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:39:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75BE91;
        Mon,  4 Jul 2022 04:39:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z41so11374939ede.1;
        Mon, 04 Jul 2022 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSALfnJIrqvwvQl3weHzn18OhbK70CgX4xeotceqD2E=;
        b=e0YrOXjSjAkqdDoL/2Wd5JTbUAhyJ9R+Pp5NxxzD19e2KlvECDe4iToQbpvTYmNKJd
         nodE/lKssP5DWGIuNO3NryRYeahAxmEwPItTjB1ZB+ZImAIiKe/KrQ4+syYwxO8qt1Tz
         UpvWGq/kEVAYmsSC3JpWLZ3rUriAWOp0DIcGUa/MnPRmfB1VWfAxFHMzK9lAtvVV5t7C
         o4STSLmUF+3xNgYVMKiu0OvhCCNHkEmBVxaPu6fDlYKQcEWXl31EzXX8aArBiPLlUYLK
         I+2lQesyUUTNkHBDzraIypoAe2M/6HK2v/98eNPUc2wrqub9cA1+PlT8w0/SFLD0oRe3
         duQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSALfnJIrqvwvQl3weHzn18OhbK70CgX4xeotceqD2E=;
        b=VmS0FqMIYP3hl2X4SEMZY/O0RK8Eq08u7kw4i9xAIFbYOjd1rFfTqVpWmOM9vM2x31
         d9i1/K3cwJIWs0zztoqyWYZwVvA1qXcc10NLNXTXm64kKeeAGy4wD2SqUVObw82h1DoA
         /Hwefw1AqGm5shxiJxEmO0kT3WQTTPp1+eGyW96qOsjlPvED2erMc5fpAeVCAIWYTY3U
         F8aXPZMUGwbuLY2+uzPUIgRMBCT3LVlN9Y8QYrDQAdYCjXIcVzxmc4fY5hsLRBI61hPS
         Dp+ACa8I7gdsEnTsqp11hoipedvQ5JXGQ6ipVqLUpg6jvls1daDC97Ja8JaJU2XxwKvI
         AIeg==
X-Gm-Message-State: AJIora+9mdbeKSDum4NxEnJKCa4z4fSIpJeJW/27oO4LwEFaiIUXiwTA
        zcN9nmLNv12MgjDheELNenwum6xx8RxQrLG9c2A=
X-Google-Smtp-Source: AGRyM1uETBexWLQxa9erZcP2MV0jR1abFPYZzFG5Pn29hCwSoxqzKw6p+a0qmliA4xqoD3sg+JndfjdaQc13srGnbaw=
X-Received: by 2002:a05:6402:254c:b0:435:c541:fc8d with SMTP id
 l12-20020a056402254c00b00435c541fc8dmr38442100edb.385.1656934765206; Mon, 04
 Jul 2022 04:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220703194020.78701-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <36ebb15c321f33176ed8c064b4a58a739acb8727.camel@pengutronix.de>
In-Reply-To: <36ebb15c321f33176ed8c064b4a58a739acb8727.camel@pengutronix.de>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Jul 2022 12:38:58 +0100
Message-ID: <CA+V-a8sPT3toawVFAYmQkNcu7RxA+4CWuYQY060pG+bM0RVK6A@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Mon, Jul 4, 2022 at 10:19 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Prabhakar,
>
> On So, 2022-07-03 at 20:40 +0100, Lad Prabhakar wrote:
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
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> > new file mode 100644
> > index 000000000000..4e977fa04bbe
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -0,0 +1,393 @@
> [...]
> > +static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
> > +{
> [...]
> > +     resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > +     if (IS_ERR(resetn))
> > +             return IS_ERR(resetn);
>
>                 return PTR_ERR(resetn);
>
Oops, I will fix that and post a v8.

Cheers,
PRabhakar
