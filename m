Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FBF52C56E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiERVKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiERVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 17:10:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693AE2550B5;
        Wed, 18 May 2022 14:10:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c10so4605689edr.2;
        Wed, 18 May 2022 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKV9lVU79l7/vRGdMw2VsgQs72ssBgmwLYPjAHdPP+k=;
        b=j0k+UnRq5J9c8xRJb8t2ZFQxvhVMSIEUS06QQ3g8MRSG0RhOcHfvHDar/OqRnEUMSg
         eLv81Hp3bTCBl+auQwcV8fuWNnk59F1lpJk1UDYmNTfW00LGRqRRk+I/WpfcCJQmQt2j
         VCnlZy66/ZMgr9Yugy5li82Be3EDvd6utsKvcuG5NZh8YxO7IMo6n11HLKUAZlSjfbFc
         MXGDevQ8kZOJYsd/s1gs8SQXjTVumsBsc6B7Ga/ZUrFFBXFm6n8SBu3y9BbHOtJGf9h7
         UgI0BNHUEchB+aB89eR7A5JeNbs/Jfdz5AI5GZ4dOCqaSLxkz3D0SUNG/GqhTdtpflb4
         Za6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKV9lVU79l7/vRGdMw2VsgQs72ssBgmwLYPjAHdPP+k=;
        b=nJebd5kGxH9Q2BXDqsQD7FHSWw5ylvNxrH+4RPk+YqyAy9Bbci+cXQ2hO44mWHM2C7
         FDMBIW/fGYLIXbGZ/5mIQcUbZLTeGS5jol2CdM3cm4CQT0QVVTjJsePAtuK1HVwaZ92C
         ZkQPT9CbdHg4r2qkcjERO79gF0elHRKcgaHOlb1xZnqoknRrrc317ZFINc+9lGp5D6jr
         Rb03r5+HckqlzHm2cwM4cEiC1GpHkzjK8Hauh7mkIQwMoFzt8MxxtWZrq7JIEEogV1Aa
         euvh0/RaFRhQnY7o+diQKTUhOXDC6URYR1LiTamvIhI50hxIzMvoG2GT8OO/LxW+vghT
         xfYg==
X-Gm-Message-State: AOAM532h8f9I6vxqH0ogtYPBGaagmiSHl82h9hbC1UIziYXuN62KrN2q
        lkUsfZLbNwWjvNCGNbpE3tGuaW6W2Qv4BTTr6VM=
X-Google-Smtp-Source: ABdhPJw51DfdxfGRtfLi5oKyYAPymH2LdfYbR1w83oGWn93l2R5ph/BmGYdd3FNyq5X+5mv5vg8vCwJVKWA3RHzvv80=
X-Received: by 2002:aa7:d911:0:b0:42a:af69:e167 with SMTP id
 a17-20020aa7d911000000b0042aaf69e167mr1825172edr.54.1652908234980; Wed, 18
 May 2022 14:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 May 2022 23:09:58 +0200
Message-ID: <CAHp75VeyU4Ox76wz9VfT8qEKHsE1eAo2iw27Lro1tmjJB0npMg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Renesas RZ/G2L IRQC support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
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

On Wed, May 18, 2022 at 9:29 PM Lad Prabhakar
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

Where is the explanation on why valid_mask can't be used instead?


-- 
With Best Regards,
Andy Shevchenko
