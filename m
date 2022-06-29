Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADCE560B72
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiF2VOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiF2VOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:14:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B43EA81;
        Wed, 29 Jun 2022 14:14:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id h187so28030320ybg.0;
        Wed, 29 Jun 2022 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7xwnj6Omy1Mv9voGpoMY3zpjYfFQMfuRepOySAIgS4=;
        b=WfS71ZTiSnDX1aATjVreV1HbNo091JyEfm8QJh627lY6noiQ8XgjGFnLiRn9CKxe8l
         3BTo0O466GNfluf5WWv1v1iAK9yc4GIYah+3R/eIHpHNqheMQAqLLzttLdPej13V0AmK
         ej3F2alPtB3s683ANgVdCwLSQa2oUT8Kyz3X8pw++RfbMs3LSkofjPu45cR6FeHj4tPy
         XYUipf7Y6G23xtXmpUECgC1cKLLo78J/+9UY0DcI46wzi0/0IBQmFFPcYpYAWpB5zYlE
         cGHCyUQGs7henjYR2UIPWRUCDOnpKpjQS/2UcZszIZxOXfdeRP14RHPr12O0abTieM3U
         dNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7xwnj6Omy1Mv9voGpoMY3zpjYfFQMfuRepOySAIgS4=;
        b=Y16ehhWTUymGOuP2Gi8cTi5DsYyGMQv76wlvw15994U1jfjLd4xVN4FBbVpXA/bNN5
         6DzRWJNfQQSNVNf5YFaLaVo6S+Dl9kSR4HEAh5o0l5Stno3mSi4YrgZgsGm5Nu0M19Vn
         a/jtKdW9N3hM8HNNuM1HBSMUswJ7BXaMF5WksANbKT6dtEDID7iMIE1WAk7Y4gH7NqYf
         MIK20wBwp4UF/XNIqRR7k/PJVy69KtTS4PZYmiyTUhIOZ20QRY4bUcRlw4hY+b23pHuL
         y5bu1+sXWrkTZaKXvWhz7+5dcxLl+eUcKP47EnBWWl8AsWLp1jeSjiQTFlLaQyAY2W2m
         UrVQ==
X-Gm-Message-State: AJIora96iavGZuEcLWd38oyNpq1iF3JvIjLDnw6LtDShKEUZYQ6uC3cv
        2N9z/5z7xzFqRuwCm8bb8bhFNVxBqr3j6FzTRPk=
X-Google-Smtp-Source: AGRyM1tK7/ApIWaYffqYFe+Z8/VUynQyRB3OyvTpRk1OQdz+7Fuc/c5lCrTUxZyH4pGW8DucwBeGOVY6wEjL7FAo6pw=
X-Received: by 2002:a05:6902:1549:b0:66d:5f76:27ba with SMTP id
 r9-20020a056902154900b0066d5f7627bamr5395898ybu.385.1656537272682; Wed, 29
 Jun 2022 14:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-13-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-13-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 23:13:55 +0200
Message-ID: <CAHp75Vduv_fN=2DKbOwReRoPeAYjGqSANT7UhDaRifUJ4zf5XQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] pinctrl: Add AXP192 pin control driver
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 4:30 PM Aidan MacDonald
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

...

> +config PINCTRL_AXP192
> +       tristate "X-Powers AXP192 PMIC pinctrl and GPIO Support"
> +       depends on MFD_AXP20X
> +       select PINMUX
> +       select GENERIC_PINCONF
> +       select GPIOLIB
> +       help
> +         AXP PMICs provide multiple GPIOs that can be muxed for different
> +         functions. This driver bundles a pinctrl driver to select the function
> +         muxing and a GPIO driver to handle the GPIO when the GPIO function is
> +         selected.
> +         Say Y to enable pinctrl and GPIO support for the AXP192 PMIC.

What will be the module name if compiled as a module?

...

> +/**
> + * struct axp192_pctl_function - describes a function that GPIOs may have
> + *
> + * @name: Function name
> + * @muxvals: Mux values used for selecting this function, one per GPIO.
> + *           The i'th element corresponds to the i'th GPIO and is written
> + *           to the GPIO's control register field to select this function.
> + *           U8_MAX indicates that the pin does not support this function.
> + * @groups: Array of @ngroups groups listing pins supporting this function.
> + * @ngroups: Number of pin groups.
> + */
> +struct axp192_pctl_function {
> +       const char              *name;
> +       /* Mux value written to the control register to select the function (-1 if unsupported) */
> +       const u8                *muxvals;
> +       const char * const      *groups;
> +       unsigned int            ngroups;
> +};

Can it be replaced by struct function_desc?
https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/pinmux.h#L130

...

> +       ret = devm_gpiochip_add_data(dev, &pctl->chip, pctl);
> +       if (ret)
> +               dev_err_probe(dev, ret, "Failed to register GPIO chip\n");

Missed return.

-- 
With Best Regards,
Andy Shevchenko
