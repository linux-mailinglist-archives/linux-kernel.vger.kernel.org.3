Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE53554CBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbiFOOwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiFOOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:52:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C663A7;
        Wed, 15 Jun 2022 07:52:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z7so16502518edm.13;
        Wed, 15 Jun 2022 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxDlg0EdzPxYwY4K8DTikqmJi02hCqlQxjHuqjSZNfA=;
        b=EwhKhaZrTy3fa3bUhjKdWPD6ieKfbZBuMSPBdfBKI6Uxr86y2RNIUAUxDjo5SjKO//
         SiZ4UFtxDwhURy6JgI+B2wTtikTf4RkHkpT73A7of6oWQCgInzWHEsCxEcS0iO3MGBUg
         gQV26gEqUGpByNVpdyWbXrTQZUWhZ762iYLUl6Kf5Inf/shaj7MVfXoK3C6hFrPJIRnO
         EPxWRRAH/J/F9ShFEsQn0T7ADvI2scnbg3Id0OtI1bQUXhXwp2d+89Pf4lrjMM2KNPoz
         gI0bq8hvynB7Bu367GOwMHA3uAZH/5MJkBzguAxS7538dG/Ki/gth+uoESiYdaUqpGPh
         Fj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxDlg0EdzPxYwY4K8DTikqmJi02hCqlQxjHuqjSZNfA=;
        b=S5CNL6xW8SbqmvGhZcZVAKlOSkVbfRpbvzlz0etQcolE8DymUQLC7EoSsJFdwwkvAn
         T+2Ym6+PUnm8y2PhqnED52gEhR7yFpA0hKXPog0+ZNP/xk9pyAw9fEyi1l6e2h/MwX7D
         HuMVMECXQymMWtvHdpeNeqpr1oCC7Ky0wg7axMMEOq8HVQ0cP3Sx0LehBnL6OdwzElRX
         Yj+oE2iy9p8uYMnbLTxU1DArykv/0B0YqJgqJl7BmB7Ct3D6AyeJlKBelOycIxmrJupn
         1bVzdWQRfa5ThB1VxGmjEPGvOTbxxsUclOWL+1Hd7bEzmps1t+lFx7juY6BG1mBRGOjF
         BsRA==
X-Gm-Message-State: AJIora96481gr68j8GDzJ3vCGy+Kz0WUG+oexaGdrzVQ59+pktwWYfob
        6RNPypqmuChuCP23ocGMnKavQYQ3+2SRs0ovZfc=
X-Google-Smtp-Source: AGRyM1sE207DJv9+1fRWDv51iUOC+CD0NSEaQlIkEakAWD6nsBwwDcwkIt1u8W8zJ1RJ6uK0mJzWuYQE0xfeidGejO0=
X-Received: by 2002:a05:6402:5002:b0:435:1ff1:99ee with SMTP id
 p2-20020a056402500200b004351ff199eemr153892eda.230.1655304748655; Wed, 15 Jun
 2022 07:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com> <20220603135714.12007-11-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220603135714.12007-11-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 16:51:52 +0200
Message-ID: <CAHp75VevetU0p+BTcQ6HcAn=2xgVGAL34ZuAi53rK3SDt=O-cw@mail.gmail.com>
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

On Fri, Jun 3, 2022 at 6:29 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The AXP192 PMIC's GPIO registers are much different from the GPIO
> registers of the AXP20x and AXP813 PMICs supported by the existing
> pinctrl-axp209 driver. It makes more sense to add a new driver for
> the AXP192, rather than add support in the existing axp20x driver.
>
> The pinctrl-axp192 driver is considerably more flexible in terms of
> register layout and should be able to support other X-Powers PMICs.
> Interrupts and pull down resistor configuration are supported too.

Thank you for contribution, overall looks good, below some not very
critical comments.

...

> +static const struct axp192_pctl_reg_info axp192_pin_ctrl_regs[] = {
> +       { .reg = AXP192_GPIO0_CTRL,   .mask = 0x07 },
> +       { .reg = AXP192_GPIO1_CTRL,   .mask = 0x07 },
> +       { .reg = AXP192_GPIO2_CTRL,   .mask = 0x07 },
> +       { .reg = AXP192_GPIO4_3_CTRL, .mask = 0x03 },
> +       { .reg = AXP192_GPIO4_3_CTRL, .mask = 0x0c },
> +       { .reg = AXP192_N_RSTO_CTRL,  .mask = 0xc0 },
> +};

GENMASK()

...

> +       if ((val & reginfo->mask) == (input_muxvals[offset] << (ffs(reginfo->mask) - 1)))
> +               return GPIO_LINE_DIRECTION_IN;

> +       else

Redundant.
Also applies for the other similar cases in your code. Note, this is
also redundant for 'continue' and 'break' in case of loops.

> +               return GPIO_LINE_DIRECTION_OUT;

...

> +       if (!reginfo->mask)
> +               return -EOPNOTSUPP;

Please, double check that this is used by the pin control subsystem
and not ENOTSUP in your case here.

...

> +       default:
> +               return -EOPNOTSUPP;

Ditto.

...

> +               default:
> +                       return -EOPNOTSUPP;

Ditto.

...

> +               default:
> +                       /* unreachable */
> +                       break;

return 0?! Perhaps you need to return an error?

> +               }
> +       }
> +
> +       return 0;

...

> +       if (muxvals[group] == (u8)-1)

limits.h and U8_MAX? Or GENMASK()? Choose one which suits you.

> +               return -EINVAL;

...

> +       if (!of_device_is_available(pdev->dev.of_node))
> +               return -ENODEV;

Dead code.

> +       if (!axp20x) {
> +               dev_err(&pdev->dev, "Parent drvdata not set\n");
> +               return -EINVAL;
> +       }

Another useless piece of code.

...

> +       pctl->desc = of_device_get_match_data(&pdev->dev);

device_get_match_data()

...

> +       pctl->chip.to_irq               = axp192_gpio_to_irq;

Why a custom method?

...

> +       pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
> +       if (IS_ERR(pctl->pctl_dev)) {
> +               dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
> +               return PTR_ERR(pctl->pctl_dev);

Here and everywhere else in ->probe() and Co, use

  return dev_err_probe(...);

pattern.

> +       }

...

> +       ret = gpiochip_add_pin_range(&pctl->chip, dev_name(&pdev->dev),
> +                                    pctl->desc->pins->number,
> +                                    pctl->desc->pins->number,
> +                                    pctl->desc->npins);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to add pin range\n");
> +               return ret;
> +       }

We have a specific callback where you may put this, otherwise on some
systems it may not work as expected.

...

> +       dev_info(&pdev->dev, "AXP192 pinctrl and GPIO driver loaded\n");

Useless.

...

> +static struct platform_driver axp192_pctl_driver = {
> +       .probe          = axp192_pctl_probe,
> +       .driver = {
> +               .name           = "axp192-gpio",
> +               .of_match_table = axp192_pctl_match,
> +       },
> +};

> +

Redundant blank line.

> +module_platform_driver(axp192_pctl_driver);

...

Globally two comments:
1) I also believe that you may utilize gpio-regmap API;
2) try to get rid of OFisms, make it property provider agnostic.

-- 
With Best Regards,
Andy Shevchenko
