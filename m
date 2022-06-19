Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73573550CC2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiFST3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiFST3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:29:31 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D259426E3;
        Sun, 19 Jun 2022 12:29:30 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-317803b61e5so56627397b3.1;
        Sun, 19 Jun 2022 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eebabUglYhWenSeh6jBsHcmLWqDqLl0MvlBz4MnYypk=;
        b=dLUGCSFZG2ntKjOKrusxKZ62u3wQQEgFcArn1QDBE5zIe5v/2xX4xBzHq80Td1TwSF
         eYzJJv74r0f/Ky9kivLkJyMqN1UGYHSFwupdHzUYYaw3XL5R0SQv0F8bFotPwA6lG2qt
         sd6GUEj9kIz7JtFJ2IGimuXKva+QqaHrA4fCK6GOmtUUlYT5U5wIITAq/jVXHpe+qvFr
         zfZ6ruQxQ2o1BE7WZhFFh27NGWxgXUvtQSwUrA+SUeP1d4/Tmp6yXCRc4nyM1vaYy7Py
         eAy4jH1JyJiyH4fBVWuKTieEWF6jG79D21stYqTv4px4k0EZdFgP9OqfYajuyaLj/SqS
         O6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eebabUglYhWenSeh6jBsHcmLWqDqLl0MvlBz4MnYypk=;
        b=b8R/XcTWMWlAVG+P25T9I3jZ3icaM2PghvU/E+JHXixJXs9j9Hh9RUkvjalxdxafY2
         1ONtMiJMorroInwD3trk0zE8lOjZyQy38mwXl+QBc/iorjJ89Uboq+ytdLdGvekD4mng
         22dXUFpIdtDhP0Kp5HUHfDOVoRkCxPyJqedGrjLUIdEOlGJe13Xx+y2og+wK632kyikv
         yQr2p1W7cXertUZ99nIdSJyb8+45nwKYIixUpbycF5ni022pDOvOdI7KMunNSn4lRn1W
         LV0PCk3IO+GUW17C2IQxC/gWf2XWtAmOyl7FwoFiR2392M6PnhMVMXEYKdHSr7c3h1GY
         v5Yg==
X-Gm-Message-State: AJIora+j4h+cFytF568Rso7sdAMmj3Hbz8awKpIbtjrQMffoDYy6A98h
        xbrzZ2qSGSoH2EdRb2xklqYtvoaHdNW3KljSM1o=
X-Google-Smtp-Source: AGRyM1tRZsOJhXLrAR8V+9hOvPJwyigsJUTx2ANfoGep/h/g20lguEe51ep8yEZC4DXig4eoxoUN89k+su01PMRaeCQ=
X-Received: by 2002:a81:6e02:0:b0:317:b68d:3870 with SMTP id
 j2-20020a816e02000000b00317b68d3870mr4767307ywc.222.1655666970029; Sun, 19
 Jun 2022 12:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 19 Jun 2022 20:29:02 +0100
Message-ID: <CA+V-a8v4QEOtzPeOvoRQtT7Rvj3ZxzmhQtn6v4U+1toTUbh-Zw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Renesas RZ/G2L IRQC support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
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

Hi Marc

On Mon, May 23, 2022 at 6:42 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> The RZ/G2L Interrupt Controller is a front-end for the GIC found on
> Renesas RZ/G2L SoC's with below pins:
> - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI
>   interrupts
> - GPIO pins used as external interrupt input pins out of GPIOINT0-122 a
>   maximum of only 32 can be mapped to 32 GIC SPI interrupts,
> - NMI edge select.
>
>                                                              _____________
>                                                              |    GIC     |
>                                                              |  ________  |
>                                       ____________           | |        | |
> NMI --------------------------------->|          |  SPI0-479 | | GIC-600| |
>              _______                  |          |------------>|        | |
>              |      |                 |          |  PPI16-31 | |        | |
>              |      | IRQ0-IRQ7       |   IRQC   |------------>|        | |
> P0_P48_4 --->| GPIO |---------------->|          |           | |________| |
>              |      |GPIOINT0-122     |          |           |            |
>              |      |---------------->| TINT0-31 |           |            |
>              |______|                 |__________|           |____________|
>
> The proposed patches add hierarchical IRQ domain, one in IRQC driver and
> another in pinctrl driver. Upon interrupt requests map the interrupt to
> GIC. Out of GPIOINT0-122 only 32 can be mapped to GIC SPI, this mapping is
> handled by the pinctrl and IRQC driver.
>
> Cheers,
> Prabhakar
>
> Changes for v4->v5:
> * Updated commit message for patch 3/5
> * Dropped interrupt-parent from and included RB tag from Geert for patch 4/5
> * Implemented init_valid_mask() callback
> * Dropped ngirq patch from previous series
> * Dropped patches 4/7 and 5/7 from previous patch series will handle it separately.
>
> Changes for v3->v4:
> * Updated description for interrupts-cells property in patch #1
> * Dropped the patch which overriding free callback in gpiolib
> * Used devm helpers in patch#2
> * Patch #4, #5 and #6 are newly added
> * In patch #7 dropped using gpio offset as hwirq
> * Implemented immutable GPIO in patch #7
> * Implemented child_offset_to_irq() callback in patch #7
>
> Changes for v2->v3:
> * Updated description for interrupts-cells property in patch #1
> * Included RB tag from Geert for binding patch
> * Fixed review comments pointed by Geert, Biju and Sergei.
>
> Changes for v1->v2:
> * Included RB tag from Rob
> * Fixed review comments pointed by Geert
> * included GPIO driver changes
>
> Changes for RFCV4 -> V1:
> * Used unevaluatedProperties.
> * Altered the sequence of reg property
> * Set the parent type
> * Used raw_spin_lock() instead of raw_spin_lock_irqsave()
> * Simplified parsing IRQ map.
> * Will send the GPIO and pinctrl changes as part of separate series
>
> Changes for RFC v4:
> * Used locking while RMW
> * Now using interrupts property instead of interrupt-map
> * Patch series depends on [0]
> * Updated binding doc
> * Fixed comments pointed by Andy
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220316200633.28974-1-prabhakar.mahadev-lad.rj@xxxxxxxxxxxxxx/
>
> Changes for RFC v3:
> -> Re-structured the driver as a hierarchical irq domain instead of chained
> -> made use of IRQCHIP_* macros
> -> dropped locking
> -> Added support for IRQ0-7 interrupts
> -> Introduced 2 new patches for GPIOLIB
> -> Switched to using GPIOLIB for irqdomains in pinctrl
>
> RFC v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> 20210921193028.13099-1-prabhakar.mahadev-lad.rj@xxxxxxxxxxxxxx/
>
> RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> 20210803175109.1729-1-prabhakar.mahadev-lad.rj@xxxxxxxxxxxxxx/
>
> Lad Prabhakar (5):
>   dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt
>     Controller
>   irqchip: Add RZ/G2L IA55 Interrupt Controller driver
>   gpio: gpiolib: Allow free() callback to be overridden
>   dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties
>     to handle GPIO IRQ
>   pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO
>     interrupt
>
>  .../renesas,rzg2l-irqc.yaml                   | 133 ++++++
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  15 +
>  drivers/gpio/gpiolib.c                        |   9 +-
>  drivers/irqchip/Kconfig                       |   8 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-renesas-rzg2l.c           | 425 ++++++++++++++++++
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 236 ++++++++++
>  7 files changed, 824 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
>  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
>
Gentle ping.

Are you happy with this series?

Cheers,
Prabhakar
