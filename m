Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B03552CAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiESELw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiESELu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:11:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70E22ED6B;
        Wed, 18 May 2022 21:11:47 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id d137so6918663ybc.13;
        Wed, 18 May 2022 21:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFhlKzSaR6ttt7NqrtERyj3kXNktY+qnVphxc8I2l0o=;
        b=BLfRsxcxlMi1Y5o++ywuASu81Qy2RkoVzIqFvd9q60/wi4GOhQkpVF9uKahxFeTwRZ
         czRMCieOd03+oLJ/WHdZVi4UIHixQ+f8v0pdmfqeuJtRnCF6OAGYOoymq9ip2NSuLXez
         EBTgyk/roqURkeCZA+YCJ6BMpQj9vwFjcoj8y9Gs1rvnN4GhisBv5mvEvJ4xo0lf+2S9
         6xr118IQC4uWY5gRORMlzH4peJ5j3S8oxVnaRDGrqFgQOkcmwH9gplr6h/MXz/WlbXMz
         oPuSlvVBi6OxZV5JOjBxAYWNP0P5CmPNZwMecvmd+x4BhnONptjdLGXWQrBqB1MoNd/+
         ZG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFhlKzSaR6ttt7NqrtERyj3kXNktY+qnVphxc8I2l0o=;
        b=ZU35FBwTd9LP9B66dLmogxm6f0e2Cq5/SMX8ADDOqs3p4rTnfhjlvibTwqwZ7Ldj8k
         qeEp5ITckQLtbmdI7q+59qJS+yadVD7az8wz27BSAbuchQ+GMe74x2pmBHpLE9QNqKYY
         2f+PI30Zck/FQ6vyqfssIvg7CBXl6MOcC134Flqwozqig5/T1pR6Yi/42V5mcIMnXbIT
         v8EAKG/LSaLJrMTs1qr8cKCLKN/k/bdcgEkWLb57At4WB6+g+o/S1W4YJiKQJBw3GWZ0
         jE5B22Nhz5O0OQecukY4vB/L5NcWaV/J3ZAtct4xrX9SFJVDsDVoMeO1Gr9kbx1TTdEQ
         6Uvg==
X-Gm-Message-State: AOAM531g9JRtb+dK8Zdoj1wLJVtNV/96ziZJ3l/2SqcudE7vljP+UHSi
        y1pG6j0I9eJGjAOAnWLrhg5JJ518VFK/B+P5RC8=
X-Google-Smtp-Source: ABdhPJxrPNHuFfLZdogkAdNbyNhC5Zol80t3bYRV9oHaQG2OfwbsEqx86Ha17cwk8YkMoFGq+CnFUJJwK1lceIbxSZQ=
X-Received: by 2002:a25:2488:0:b0:64e:a74d:fc7e with SMTP id
 k130-20020a252488000000b0064ea74dfc7emr2557167ybk.563.1652933507213; Wed, 18
 May 2022 21:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220518192924.20948-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VfbcYCH5XgnP9VB0hX0W3_jdvSBmXSB1ANMiT66yLQvOA@mail.gmail.com>
In-Reply-To: <CAHp75VfbcYCH5XgnP9VB0hX0W3_jdvSBmXSB1ANMiT66yLQvOA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 19 May 2022 05:11:22 +0100
Message-ID: <CA+V-a8vBxtHeRqo9a9w7wWyAF28stZqoUt-cE1iYKNE4BDNc0w@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] gpio: gpiolib: Add a check to validate GPIO hwirq
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
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
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Andy,

Thank you for the review.

On Wed, May 18, 2022 at 10:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, May 18, 2022 at 9:30 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Add a check to validate GPIO hwirq is always within the range of hwirq_max
> > set in the GPIO irq domain.
>
> ...
>
> > +                       if (WARN(hwirq >= domain->hwirq_max,
> > +                                "error: hwirq 0x%x is too large for %s\n",
> > +                                (int)hwirq, domain->name))
>
> Using castings in the printf() often points to possible mistakes or
> missed custom specifiers.
>
Right, I picked up the printf() just a few lines above where it did
the same exact thing. I will update it in the next version.

> ...
>
> > +               if (WARN(hwirq >= domain->hwirq_max,
> > +                        "error: hwirq 0x%x is too large for %s\n", (int)hwirq, domain->name))
>
> Ditto.
>
Will drop castings.

Cheers,
Prabhakar
