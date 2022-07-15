Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2B5766C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiGOSaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGOSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:30:21 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F1747B7;
        Fri, 15 Jul 2022 11:30:19 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31caffa4a45so55017947b3.3;
        Fri, 15 Jul 2022 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nt4bJMHyhYZZNJmsHG+jvKocDnQ/uRBuL8blfA1ku0E=;
        b=JugXTEP6dHNPhtEvF7a+5JHtnQB0Wezxj3mXkDrGYozqfRojDQsyF1yaMm4ScB7/Jm
         WsEkXJ0SEUGVVrZkC8BCoP0SfwdVW7GCvaD3VfdXQIsQWYFdR6LU4jAozR5eLknvx1TA
         ImyChQqdYXJ0emEU0f1Dn5cGjmGGfK8hvylIv7olh1kv26+7rkg/ROqYp55f4+j0shBF
         rb8dsgfz2gABDl/R7/RQA/+frn3Nz/VTzWGjxNJ696EP7aWkPhW2AZ98uCXxLlWzju6y
         gW9J1WwQmK2wGdyYn3ZQfH/AHS1DVivoCmAvm5pg5MqTybZj012lhFCUjYCBV37kdAdW
         bB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nt4bJMHyhYZZNJmsHG+jvKocDnQ/uRBuL8blfA1ku0E=;
        b=3GYe1k6x2hqr9kIsNoQ/zb7wc0Ujbfox0Zajs6Ld4jLgZ/63llqcZgvumMs+wU6+tM
         b7lDsmPUY11ZDNVej89c5CM7IVSivkJZ5Gjs81v+n31srnyVKtR28fmcfOxctvePtOfC
         rlT4a3Q+A+rJyKa6Nx6QEbQ3UZJb87KQQNsE6FBxZqzFtD2uPROmeXwmQLmVbXll9oyx
         imX8wppsjv3p8AEw4uMsBEfCCIh3Obyspi6E757DinJvwuTFFYKk0DgDRbixTozp/zjZ
         nNSbbrB0mqOHesAYESI9gO0n+ToarpMjRh8q5oP582zc6milmVeyiSaxdaNKLp7IT3zl
         wp3g==
X-Gm-Message-State: AJIora/YuE7Gq4sb0NRHl0/Mw8jVopFPnVqoYK5bUa3tA6WOz7UHA23l
        W++HU9yCQQ0I8MYYgDhXsQbRtrodTq6qnaN2Vhs=
X-Google-Smtp-Source: AGRyM1vzP7L4rkzgqFevRJH1d667ZKPy7GjYyztLTPXytxkGqbpO4dyGE5UlcSEsEn68hi2rmxg67+K7y1Uib8FAXL0=
X-Received: by 2002:a81:54c1:0:b0:31d:ec18:fd5d with SMTP id
 i184-20020a8154c1000000b0031dec18fd5dmr7586417ywb.277.1657909819017; Fri, 15
 Jul 2022 11:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-12-peterwu.pub@gmail.com>
In-Reply-To: <20220715112607.591-12-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 20:29:42 +0200
Message-ID: <CAHp75VfyVufzf7CK38BVu_j0B4ax_d1gLAGYDE3H1zaKkuUB=A@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] leds: mt6370: Add MediaTek MT6370 current sink
 type LED Indicator support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 1:29 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> In MediaTek MT6370, there are four channel current-sink RGB LEDs that
> support hardware pattern for constant current, PWM, and breath mode.
> Isink4 channel can also be used as a CHG_VIN power good indicator.

...

> +         This driver can also be built as a module. If so the module

so, the

> +         will be called "leds-mt6370.ko".

No ".ko".

Why did you ignore these comments? Please go and fix _everywhere_ in
your series.
It's basically the rule of thumb, if the reviewer gives a comment
against an occurrence of something, go through entire series and check
if there are other places like commented one and address them all.

...

> + * Author: Alice Chen <alice_chen@richtek.com>

Strange, the commit message doesn't have a corresponding SoB, why?

...

> +#define MT6370_PWM_DUTY                                31
> +#define MT6372_PMW_DUTY                                255

Looks like these are limits by hardware?
Check with the datasheet if (BIT(x) - 1) makes more sense here.

...

> +       switch (led_no) {
> +       case MT6370_LED_ISNK1:
> +               sel_field = F_LED1_DUTY;
> +               break;
> +       case MT6370_LED_ISNK2:
> +               sel_field = F_LED2_DUTY;
> +               break;
> +       case MT6370_LED_ISNK3:
> +               sel_field = F_LED3_DUTY;
> +               break;
> +       default:
> +               sel_field = F_LED4_DUTY;

Missed break;

> +       }

...

> +       switch (led_no) {
> +       case MT6370_LED_ISNK1:
> +               sel_field = F_LED1_FREQ;
> +               break;
> +       case MT6370_LED_ISNK2:
> +               sel_field = F_LED2_FREQ;
> +               break;
> +       case MT6370_LED_ISNK3:
> +               sel_field = F_LED3_FREQ;
> +               break;
> +       default:
> +               sel_field = F_LED4_FREQ;

Ditto.

> +       }

...

> +       switch (led_no) {
> +       case MT6370_LED_ISNK1:
> +       case MT6370_LED_ISNK2:
> +       case MT6370_LED_ISNK3:
> +               *base = MT6370_REG_RGB1_TR + led_no * 3;
> +               break;
> +       default:
> +               *base = MT6370_REG_RGB_CHRIND_TR;

Ditto.
It seems you dropped them for all switch-cases. It's not goot, please
restore them back.

> +       }

...

> +       u8 val[P_MAX_PATTERNS / 2] = {0};

{ } should suffice


> +       /*
> +        * Pattern list
> +        * tr1: byte 0, b'[7: 4]
> +        * tr2: byte 0, b'[3: 0]
> +        * tf1: byte 1, b'[7: 4]
> +        * tf2: byte 1, b'[3: 0]
> +        * ton: byte 2, b'[7: 4]
> +        * toff: byte 2, b'[3: 0]
> +        */
> +       for (i = 0; i < P_MAX_PATTERNS; i++) {
> +               curr = pattern + i;
> +
> +               sel_range = i == P_LED_TOFF ? R_LED_TOFF : R_LED_TRFON;
> +
> +               linear_range_get_selector_within(priv->ranges + sel_range,
> +                                                curr->delta_t, &sel);
> +
> +               val[i / 2] |= sel << (4 * ((i + 1) % 2));
> +       }
> +
> +       memcpy(pattern_val, val, 3);
> +       return 0;
> +}

...

> +out:

out_unlock:

> +       mutex_unlock(&priv->lock);
> +
> +       return ret;

...

> +out:

Ditto. And so on.

> +       mutex_unlock(&priv->lock);
> +
> +       return ret;

...

> +               sub_led = devm_kzalloc(priv->dev,
> +                                      sizeof(*sub_led) * MC_CHANNEL_NUM,
> +                                      GFP_KERNEL);

NIH devm_kcalloc(). Also check if you really need zeroed data.

> +               if (!sub_led)
> +                       return -ENOMEM;

...

> +                       ret = fwnode_property_read_u32(child, "color", &color);
> +                       if (ret) {
> +                               dev_err(priv->dev,
> +                                       "led %d, no color specified\n",
> +                                       led->index);
> +                               return ret;

return dev_err_probe(...) ; ?

Ditto for many places in your entire series.

> +                       }

...

> +       priv = devm_kzalloc(&pdev->dev,
> +                           struct_size(priv, leds, count), GFP_KERNEL);

At least one parameter can be placed on the previous line.

> +       if (!priv)
> +               return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko
