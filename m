Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938554F74C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380929AbiFQMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiFQMO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:14:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ABA28E23;
        Fri, 17 Jun 2022 05:14:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b8so5913082edj.11;
        Fri, 17 Jun 2022 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=ydFyEbnVaWWSrDTVNo9E/s79ZYsYTDWr/e2n3lOC/CQ=;
        b=CBAzuT/3SNdBEYzyFXSlQr27NNAViGTYuipk4+FS3fWsXgGbatvUpbQWI7B2uU/FZ3
         z0Lj7w2RWnZGD1Wk3jWo2ct6G5Tx9Bz+0m8Z5F17USH43jBuNCZQAxYRQE/t3FDlsRhp
         6F7vYabAdTYAoSF2CT2UvOYPovWeuzoml9lTYyHUGIB9iQfDrxJp8yYGHg7UxyjVq0AQ
         yzBcUJjFnNe+10OKXj8S8hB72RJkxLzLhrU27t9Uc+S2a3pgxQXjiMF0sU0vcoLiq+VN
         sNe4Mvif8FR4ZLHw1q+kF8wCLbCQlBA4sVI0PCWHuFWZ1+SObFtK87fv0S4su0kDCgoT
         d3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ydFyEbnVaWWSrDTVNo9E/s79ZYsYTDWr/e2n3lOC/CQ=;
        b=RStAg3zkBP/kgSxWgtIAfk0/HKhJJDvSd+BAA1bWPsfWcc+cSX9p2ol9a/sN9EBf5/
         pSFiGuuTv2P4Co/L6yVFnOWhH+aofsbKA8V48NKPCT/jbQ/pCIIMV13vgB5OZQcogeqs
         pm3efMX3GI1oGvSp8FBcB01yx1BZkS/c5W59xkAQ1nUholxtnHx2jhrOlp6SnRvO1s/n
         FFOklnpq3A04LUX9QZN+AdGUUEdKrK04krjjvgXyvBbTH3Pxq7I3If+3lb5Yx4rPLXdB
         WutSHeOcVeeOEg7Jp0Pq5biEHgxrTWKzxKo21HiIwRe31iHOTZMSgPI8nCd5u9hdYHUJ
         JJAA==
X-Gm-Message-State: AJIora+D7pcbWgpLLXtbq7VD9YHLxHRgg8AN5s49UhSUptrPugXrxT4X
        prDuldoSzKMnh+1Wp5RdJtw=
X-Google-Smtp-Source: AGRyM1s4OQqcTAHNZzk78E61Oh2A73AGQnN8S5QSHmcK82apV7c2oIsmFff70+2MNyJGzq/V6gYeeQ==
X-Received: by 2002:a05:6402:5114:b0:42f:b5f3:1f96 with SMTP id m20-20020a056402511400b0042fb5f31f96mr12217153edd.260.1655468063324;
        Fri, 17 Jun 2022 05:14:23 -0700 (PDT)
Received: from localhost (92.40.168.190.threembb.co.uk. [92.40.168.190])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906318200b006fe98fb9523sm2132015ejy.129.2022.06.17.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:14:22 -0700 (PDT)
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-11-aidanmacdonald.0x0@gmail.com>
 <CAHp75VevetU0p+BTcQ6HcAn=2xgVGAL34ZuAi53rK3SDt=O-cw@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH 10/10] pinctrl: Add AXP192 pin control driver
In-reply-to: <CAHp75VevetU0p+BTcQ6HcAn=2xgVGAL34ZuAi53rK3SDt=O-cw@mail.gmail.com>
Date:   Fri, 17 Jun 2022 13:15:27 +0100
Message-ID: <VGkmH1cTj8QZxZXUjbuky58yY3X5QWSY@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Fri, Jun 3, 2022 at 6:29 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>>
>> The AXP192 PMIC's GPIO registers are much different from the GPIO
>> registers of the AXP20x and AXP813 PMICs supported by the existing
>> pinctrl-axp209 driver. It makes more sense to add a new driver for
>> the AXP192, rather than add support in the existing axp20x driver.
>>
>> The pinctrl-axp192 driver is considerably more flexible in terms of
>> register layout and should be able to support other X-Powers PMICs.
>> Interrupts and pull down resistor configuration are supported too.
>
> Thank you for contribution, overall looks good, below some not very
> critical comments.
>
> ...
>

Thanks very much for the review. I'll fix up the issues you spotted
in v3. (v2 doesn't make any changes to the pinctrl driver.)

>> +static const struct axp192_pctl_reg_info axp192_pin_ctrl_regs[] = {
>> +       { .reg = AXP192_GPIO0_CTRL,   .mask = 0x07 },
>> +       { .reg = AXP192_GPIO1_CTRL,   .mask = 0x07 },
>> +       { .reg = AXP192_GPIO2_CTRL,   .mask = 0x07 },
>> +       { .reg = AXP192_GPIO4_3_CTRL, .mask = 0x03 },
>> +       { .reg = AXP192_GPIO4_3_CTRL, .mask = 0x0c },
>> +       { .reg = AXP192_N_RSTO_CTRL,  .mask = 0xc0 },
>> +};
>
> GENMASK()
>
> ...
>
>> +       if ((val & reginfo->mask) == (input_muxvals[offset] << (ffs(reginfo->mask) - 1)))
>> +               return GPIO_LINE_DIRECTION_IN;
>
>> +       else
>
> Redundant.
> Also applies for the other similar cases in your code. Note, this is
> also redundant for 'continue' and 'break' in case of loops.
>

Sorry, I'm not sure what you're referring to here. The "else"?
I'm missing the generalization.

>> +               return GPIO_LINE_DIRECTION_OUT;
>
> ...
>
>> +       if (!reginfo->mask)
>> +               return -EOPNOTSUPP;
>
> Please, double check that this is used by the pin control subsystem
> and not ENOTSUP in your case here.

Whoops. You're right, it should be ENOTSUPP.

>
> ...
>
>> +       default:
>> +               return -EOPNOTSUPP;
>
> Ditto.
>
> ...
>
>> +               default:
>> +                       return -EOPNOTSUPP;
>
> Ditto.
>
> ...
>
>> +               default:
>> +                       /* unreachable */
>> +                       break;
>
> return 0?! Perhaps you need to return an error?
>

Yeah, that sounds like a good idea for maintainability. I think
there's no need to check that the requested configs are supported
beforehand since the caller must deal with errors in the middle of
the sequence anyway, so I'll drop that check and add ENOTSUPP here.

>> +               }
>> +       }
>> +
>> +       return 0;
>
> ...
>
>> +       if (muxvals[group] == (u8)-1)
>
> limits.h and U8_MAX? Or GENMASK()? Choose one which suits you.
>
>> +               return -EINVAL;
>
> ...
>
>> +       if (!of_device_is_available(pdev->dev.of_node))
>> +               return -ENODEV;
>
> Dead code.
>

OK. Did some digging, and this is useless because the parent mfd
device is checking availability.

>> +       if (!axp20x) {
>> +               dev_err(&pdev->dev, "Parent drvdata not set\n");
>> +               return -EINVAL;
>> +       }
>
> Another useless piece of code.
>
> ...
>
>> +       pctl->desc = of_device_get_match_data(&pdev->dev);
>
> device_get_match_data()
>
> ...
>
>> +       pctl->chip.to_irq               = axp192_gpio_to_irq;
>
> Why a custom method?
>
> ...
>

The irq chip is part of the mfd device, not the gpio chip. There does
not seem to be any default implementation for this case so I have to
provide one. A similar example is gpio-wm8994.

I did notice I'm doing something wrong by calling regmap_irq_get_virq()
in the probe function, which creates an irq mapping; I think I should be
doing that in the to_irq() callback like the other drivers do.

>> +       pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
>> +       if (IS_ERR(pctl->pctl_dev)) {
>> +               dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
>> +               return PTR_ERR(pctl->pctl_dev);
>
> Here and everywhere else in ->probe() and Co, use
>
>   return dev_err_probe(...);
>
> pattern.
>
>> +       }
>
> ...
>
>> +       ret = gpiochip_add_pin_range(&pctl->chip, dev_name(&pdev->dev),
>> +                                    pctl->desc->pins->number,
>> +                                    pctl->desc->pins->number,
>> +                                    pctl->desc->npins);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to add pin range\n");
>> +               return ret;
>> +       }
>
> We have a specific callback where you may put this, otherwise on some
> systems it may not work as expected.
>
> ...
>

Ah, sorry, I see that function is deprecated. The documentation points
to doing this in the device tree instead. So if I understand correctly
I should follow the example of pinctrl-thunderbay and add gpio-ranges:

    pinctrl0: gpio@0 {
        compatible = "x-powers,axp192-gpio";
        gpio-controller;
        #gpio-cells = <2>;
        gpio-ranges = <&pinctrl0 0 0 6>;
    };

which means I'll have to update the gpio DT bindings. I'm guessing the
callback you mentioned is add_pin_ranges() or of_gpio_ranges_fallback()
but neither of those seem appropriate in this case. The DT node should
be good enough.

>> +       dev_info(&pdev->dev, "AXP192 pinctrl and GPIO driver loaded\n");
>
> Useless.
>
> ...
>
>> +static struct platform_driver axp192_pctl_driver = {
>> +       .probe          = axp192_pctl_probe,
>> +       .driver = {
>> +               .name           = "axp192-gpio",
>> +               .of_match_table = axp192_pctl_match,
>> +       },
>> +};
>
>> +
>
> Redundant blank line.
>
>> +module_platform_driver(axp192_pctl_driver);
>
> ...
>
> Globally two comments:
> 1) I also believe that you may utilize gpio-regmap API;
> 2) try to get rid of OFisms, make it property provider agnostic.

I wasn't aware of gpio-regmap, will check it out.

Regards,
Aidan
