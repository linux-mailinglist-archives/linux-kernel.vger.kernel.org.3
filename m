Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4E54FAD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383174AbiFQQIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383141AbiFQQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:08:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043B33A10;
        Fri, 17 Jun 2022 09:08:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so9637613eja.8;
        Fri, 17 Jun 2022 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyaPAU422RTkmUp3vQSmgWg7DCK+47J/Ak6BUGAJv9g=;
        b=T+pFXVXs2r+jnKz9ngTh0ZNKl5hes6LPoOziVTWMXaG2Q/FnbhCwSNBXQVM1NoKmFw
         dzokG5Bb12FUtkfKvTF8dg9kf3laiK96t1QYl4fOKtPUqlcyJx+o8OS/26SQIgLM/+OZ
         xuLJnS2qJjR33nDhMfVhR4/31KgLMMUqtZvtOHKJ9V71j9d976A/7/vN9MXXgYdlYJ6P
         vRt2QWSIiDszzQnhb3iyubH6H84foOOjcspVK2zmQ87p++vrszkPM3tT+q/6CixA/w6g
         ajUTWiGspTuBwE7j0UlgGD3IYRBy4Gqo/GBDApB5elZBhq1+pqZKnL4InAAQ2y0qWCwP
         uhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyaPAU422RTkmUp3vQSmgWg7DCK+47J/Ak6BUGAJv9g=;
        b=NkZjloiXP68oAre/i2YU4DDqGyRTZGvtkru/FRLTOBkjv88kfWXrDA/eaim3kHdEXJ
         pyjQl6PgiDJJl4SJPu8nmArAXQsqOwa50G1PaFTK5uC1TvI3JBFaJoDzFV7aSai+Rrub
         8fuEpgWA1e5LiLOL/cDUdbWClwLP6f7X2L9YbJgeCIoYEIzMdFHFlN26Dy27RFiZAlp0
         lcY/drCa/2on/BQIps5Vs5eTPnp4rlVEY9JEM1SgvS4CBIHUbeI1AWNEp5SkCEZEIVDS
         1CVHOxA2HcQKD+WMX6fQFmG3Hz4EEY7zFxQSV81bsxNgM0CUfWjHe7GUtWv2zQl5XZrE
         r3JA==
X-Gm-Message-State: AJIora/8AM/F88pSDfrQV98idcsD6RSz1G1FOAQYl4/In+JjgFKlzW/d
        QzMJDjMWk08x/2S9F7+dr12Zdxq5pIFSQmAMmss=
X-Google-Smtp-Source: AGRyM1uSPK+9gOEkIB1Rod/oCh4qsf64lmqJg2CMb1Cevr4ga1D8aaK63zqJQRFdpsane3HyNa/P0wdRDmoRFm+JH2U=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr9944067ejm.636.1655482127352; Fri, 17
 Jun 2022 09:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-11-aidanmacdonald.0x0@gmail.com> <CAHp75VevetU0p+BTcQ6HcAn=2xgVGAL34ZuAi53rK3SDt=O-cw@mail.gmail.com>
 <VGkmH1cTj8QZxZXUjbuky58yY3X5QWSY@localhost>
In-Reply-To: <VGkmH1cTj8QZxZXUjbuky58yY3X5QWSY@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Jun 2022 18:08:09 +0200
Message-ID: <CAHp75VfTLz7Zv1UPROuaGr8g88_BoDb2rd7GQ6m0dNEGSPSasQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] pinctrl: Add AXP192 pin control driver
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 17, 2022 at 2:14 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Fri, Jun 3, 2022 at 6:29 PM Aidan MacDonald
> > <aidanmacdonald.0x0@gmail.com> wrote:

...

> >> +       if ((val & reginfo->mask) == (input_muxvals[offset] << (ffs(reginfo->mask) - 1)))
> >> +               return GPIO_LINE_DIRECTION_IN;
> >
> >> +       else
> >
> > Redundant.
> > Also applies for the other similar cases in your code. Note, this is
> > also redundant for 'continue' and 'break' in case of loops.
>
> Sorry, I'm not sure what you're referring to here. The "else"?

Yes.

> I'm missing the generalization.
>
> >> +               return GPIO_LINE_DIRECTION_OUT;

...

> >> +       pctl->chip.to_irq               = axp192_gpio_to_irq;
> >
> > Why a custom method?
>
> The irq chip is part of the mfd device, not the gpio chip. There does
> not seem to be any default implementation for this case so I have to
> provide one. A similar example is gpio-wm8994.
>
> I did notice I'm doing something wrong by calling regmap_irq_get_virq()
> in the probe function, which creates an irq mapping; I think I should be
> doing that in the to_irq() callback like the other drivers do.

It may be done using different approaches, but this part should be
carefully reviewed by GPIO / pin control maintainers.

...

> Ah, sorry, I see that function is deprecated. The documentation points
> to doing this in the device tree instead. So if I understand correctly
> I should follow the example of pinctrl-thunderbay and add gpio-ranges:
>
>     pinctrl0: gpio@0 {
>         compatible = "x-powers,axp192-gpio";
>         gpio-controller;
>         #gpio-cells = <2>;
>         gpio-ranges = <&pinctrl0 0 0 6>;
>     };
>
> which means I'll have to update the gpio DT bindings. I'm guessing the
> callback you mentioned is add_pin_ranges() or of_gpio_ranges_fallback()
> but neither of those seem appropriate in this case. The DT node should
> be good enough.

Sounds good.

-- 
With Best Regards,
Andy Shevchenko
