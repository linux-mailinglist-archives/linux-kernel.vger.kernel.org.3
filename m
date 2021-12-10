Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4738046F845
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhLJBMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhLJBMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:12:35 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFDCC061746;
        Thu,  9 Dec 2021 17:09:00 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v138so17895065ybb.8;
        Thu, 09 Dec 2021 17:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfUTbG8PwhmwfcI3X4eb2ef5MT1XzgRcYrG9lHwsTDM=;
        b=IfFmXxUkJzJv5XedaOJcGeZTWEVvHONM1QWiaQ4QURe5r6K11TQcHulAoe9T7u/Al8
         SPYO35vHhZEVg/bdqf3ZLMMfJB3pTNFxDD/ta8gbV9TD7UeamfflV5FyV4EBozqvWNhd
         wChWhBcY5E7Nlv7bhE0Bt6xQSh6sSdMPgih2niZLdLt+o7Tqe7nntUbRCgNT4Fpm3eWz
         XJVr7mJqmq21Lfu0elFpWOvt6c2+5klaYnPZHoMSXLhkJBBM831Ai2uV1FSfJsu+TVDz
         mMHGAyxXn91ffGaeHOesbzuWbdQROeKbYWkDs75kU+xPuUAkQkSn4ho9Yjg39426zYKD
         uiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfUTbG8PwhmwfcI3X4eb2ef5MT1XzgRcYrG9lHwsTDM=;
        b=gpJAvAOudM+GmacPhHCBc6WRD/UGRq3x6rdBdYuviPv5v2DnPNJz0st607tklJfIEl
         AFK3q1qcV/8gzIWScVbGkXW+Npiqn17imPMLO1vQFSrbtOi7M7+7zrrhCeBHtCrCiYd2
         GJ81+A9gvUDdFFtaWCjlS9ypegu6VQALy931Pl+0a4/0605XWrZDNmPrzFhanU5SlCIh
         yrvY9XlDirJqamNlJcDT8oAQrcFDIX5/k8cUMiLXMOePk5uQdjopvN8+xj9cJzK9j7RK
         KCnkvlxdrH0z5vnkSmjJiPmNU3tOC8LF6QkgCO39slE5eTf3Z0WSpcf6NAvGZgJ7Wyhk
         2QdA==
X-Gm-Message-State: AOAM530CLrEOUDGOPYH7cHQedcNkBU0C9FIxpuzsWSVTEXpZvZy4RVSR
        O+1ycTWmEp0R202IZ+/+bYDLUoLinqNw63nYfn8=
X-Google-Smtp-Source: ABdhPJyR+xc9CjrTsAilDjNty8CnaRLCAIyuAyFILdVqL+SkY5euh9XGtuDIB32BdWzfsBWG7PDOh2I0pV/tDFk2e1I=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr10194282ybi.315.1639098540099;
 Thu, 09 Dec 2021 17:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20211110225808.16388-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CA+V-a8sCVkbwYeVGsQpv2q0OjwUSB_jqmjPptHN-ENSdU+pT1Q@mail.gmail.com>
In-Reply-To: <CA+V-a8sCVkbwYeVGsQpv2q0OjwUSB_jqmjPptHN-ENSdU+pT1Q@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 10 Dec 2021 01:08:34 +0000
Message-ID: <CA+V-a8tTm=n+TuE5N1Ptkvh6n1sYjSZWpQpmY1F5RiwK-ocvFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/7] Renesas RZ/G2L IRQC support
To:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc and Linus,

On Mon, Nov 22, 2021 at 7:25 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Marc and Linus,
>
> On Wed, Nov 10, 2021 at 10:58 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Hi All,
> >
> > The RZ/G2L Interrupt Controller is a front-end for the GIC found on
> > Renesas RZ/G2L SoC's with below pins:
> > - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> > - GPIO pins used as external interrupt input pins out of GPIOINT0-122 a
> >   maximum of only 32 can be mapped to 32 GIC SPI interrupts,
> > - NMI edge select.
> >
> >                                                                 _____________
> >                                                                 |    GIC     |
> >                                                                 |  ________  |
> >                                          ____________           | |        | |
> > NMI ------------------------------------>|          |  SPI0-479 | | GIC-600| |
> >                 _______                  |          |------------>|        | |
> >                 |      |                 |          |  PPI16-31 | |        | |
> >                 |      | IRQ0-IRQ8       |   IRQC   |------------>|        | |
> > P0_P48_4 ------>| GPIO |---------------->|          |           | |________| |
> >                 |      |GPIOINT0-122     |          |           |            |
> >                 |      |---------------->| TINT0-31 |           |            |
> >                 |______|                 |__________|           |____________|
> >
> > The proposed RFC patches, add the IRQ domains in GPIO (pinctrl driver) and the
> > IRQC driver. The IRQC domain handles the actual SPI interrupt and upon reception
> > of the interrupt it propagates to the GPIO IRQ domain to handle virq.
> > Out of GPIOINT0-122 only 32 can be mapped to GIC SPI, this mapping is handled by
> > the IRQC driver.
> >
> > Cheers,
> > Prabhakar
> >
> > Changes for v3:
> > -> Re-structured the driver as a hierarchical irq domain instead of chained
> > -> made use of IRQCHIP_* macros
> > -> dropped locking
> > -> Added support for IRQ0-7 interrupts
> > -> Introduced 2 new patches for GPIOLIB
> > -> Switched to using GPIOLIB for irqdomains in pinctrl
> >
> Gentle ping.
>
I plan to post a non RFC version soon, can I have your feedback on this please.

Cheers,
Prabhakar

>
> > RFC v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> > 20210921193028.13099-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> > RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> > 20210803175109.1729-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Lad Prabhakar (7):
> >   dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt
> >     Controller
> >   irqchip: Add RZ/G2L IA55 Interrupt Controller driver
> >   soc: renesas: Enable IRQC driver for RZ/G2L
> >   gpio: gpiolib: Allow free() callback to be overridden
> >   gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
> >   pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO
> >     interrupt
> >   arm64: dts: renesas: r9a07g044: Add IRQC node to SoC DTSI
> >
> >  .../renesas,rzg2l-irqc.yaml                   | 137 ++++++
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  60 +++
> >  drivers/gpio/gpiolib.c                        |  13 +-
> >  drivers/irqchip/Kconfig                       |   8 +
> >  drivers/irqchip/Makefile                      |   1 +
> >  drivers/irqchip/irq-renesas-rzg2l.c           | 465 ++++++++++++++++++
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 197 ++++++++
> >  drivers/soc/renesas/Kconfig                   |   1 +
> >  include/linux/gpio/driver.h                   |   8 +
> >  9 files changed, 885 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> >  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
> >
> > --
> > 2.17.1
> >
