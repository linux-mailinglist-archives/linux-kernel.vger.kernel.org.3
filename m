Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC364DC1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiCQIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiCQIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:48:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E351C404A;
        Thu, 17 Mar 2022 01:47:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id pv16so9287989ejb.0;
        Thu, 17 Mar 2022 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZG5185nJ6k1YXwanTMNCyELYsf9XafiDPUoNL5M7s7c=;
        b=UjRIu4w9EW6mJAEI8yux7EMavG4fNOozHxLNna5jngKBoA0q3QaEUx2jqtlTZO0lUZ
         kMpImqv9K8doOTDIR/6CL+IP2hm9SqjrtBhsIEm/bV2py+4DKNNSYKgA7DH2fcwcIvVx
         0Gcnee6kfeaze1qVSKAuLploPo92n4HRJr2UJ7UW6wo0eHtxblzbcvJMi4fsmIK39bXU
         KxkcnplYZOkLflHie4BWdj9NFfIt/GCMT+f9vUXbchF4bL0cCah3Zl66ebghy3QLFdsw
         boluZplmS0FmDOC3mDc9UtSnCbd00QGblOU2aL8MeIQjqYJlRvG43OryYFRsp+fGSo2h
         c9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZG5185nJ6k1YXwanTMNCyELYsf9XafiDPUoNL5M7s7c=;
        b=pWAhplIKKuqf3smYtXBFeCYQbmVBqH96irWnJu24XTgdAQqJ7XOsClEra1rdxzbGD/
         DHQuvL+rN5dS3RMATwaa1eQ8W0djI1JY3lYCT9+MKRBdEDOeQ5CjNQD9lj8Cc8wtDTNH
         lTo8rhl/lo7TwGhDfsNliZkltuUPHyuLypEDp/U61ag1C7Mfxt+XMFTivGUF3I2exZkp
         d9VNWY7/cYPLngDkzGMwYweI3+3T00sjHzCIsW5LJ8BW/y36PzA/D/5PIOeO+B25Ibe2
         pctAGGbEDxL64Xz0m5C6APnWd9uU0DfSWy37l/K5hmfiHctun77Ll3tuPk1zSgqGL5hW
         AeJg==
X-Gm-Message-State: AOAM5333tdKTITayUyw0sx94gzhlC9oEO3AS/jUoHmAd48M6C8ZlKqhs
        tQ5Nbd2avawPqWlursUeE9R/CEGR7SAmZ3qoTKQ=
X-Google-Smtp-Source: ABdhPJyHwl6Pt0flOWQCs8CzoVmYea2PjIP/v1XQBe5xLIQpQxHGpyqeaZHSvx6ZSFPjZbRCVa1tg1kxTr4BfCAFYYU=
X-Received: by 2002:a17:907:e93:b0:6df:10b3:4fc0 with SMTP id
 ho19-20020a1709070e9300b006df10b34fc0mr3432415ejc.44.1647506846924; Thu, 17
 Mar 2022 01:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 17 Mar 2022 10:46:14 +0200
Message-ID: <CAHp75Vc+uSNF4L0WCfCyadOqJ6szXS3Ct5BmEUbeQ_aKg1zjWg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/5] Renesas RZ/G2L IRQC support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
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

On Thu, Mar 17, 2022 at 5:43 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> The RZ/G2L Interrupt Controller is a front-end for the GIC found on
> Renesas RZ/G2L SoC's with below pins:
> - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> - GPIO pins used as external interrupt input pins out of GPIOINT0-122 a
>   maximum of only 32 can be mapped to 32 GIC SPI interrupts,
> - NMI edge select.
>
>                                                                 _____________
>                                                                 |    GIC     |
>                                                                 |  ________  |
>                                          ____________           | |        | |
> NMI ------------------------------------>|          |  SPI0-479 | | GIC-600| |
>                 _______                  |          |------------>|        | |
>                 |      |                 |          |  PPI16-31 | |        | |
>                 |      | IRQ0-IRQ7       |   IRQC   |------------>|        | |
> P0_P48_4 ------>| GPIO |---------------->|          |           | |________| |
>                 |      |GPIOINT0-122     |          |           |            |
>                 |      |---------------->| TINT0-31 |           |            |
>                 |______|                 |__________|           |____________|
>
> The proposed RFC patches adds hierarchical IRQ domain one in IRQC driver and other in

add
domain, one
another

> pinctrl driver. Upon interrupt requests map the interrupt to GIC. Out of GPIOINT0-122
> only 32 can be mapped to GIC SPI, this mapping is handled by the pinctrl and IRQC driver.

What I want to know now is whether it is going to collide with Marc's
series about GPIO IRQ chip constification?

-- 
With Best Regards,
Andy Shevchenko
