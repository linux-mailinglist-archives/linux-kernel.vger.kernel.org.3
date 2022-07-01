Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7BA563702
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiGAPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGAPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:36:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A4B3969C;
        Fri,  1 Jul 2022 08:36:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v9so3748034wrp.7;
        Fri, 01 Jul 2022 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=sYub0N475p+0VGhz+u6M1TELUK/iEnZfnAN/MojLZIE=;
        b=dG3gWMTpxupxXO5Q1Yvv+bsWdhehMZxuBXH5mWSRK5qvyNzPOk6iHYgtKuXRgtzr1u
         3QAhhbmKg3B0F1sHW7iP59NwsIZQA5BSBsiaNy93hT7b+WQRpOa9A4KcznOX0nLjDxkK
         DWGZsPYbl3YTeWXgkL9XThoAAhc/5eXVopqOidZhV4ZtAeGtlA8INFSkoaT16O1XZX49
         vE1WL4T8PROyZl/q4dJC4UevHEMgYvZrxx9Ppdd+PmOVoMIYfyW0hh4GYjJs/ogqUlMS
         JmcVgJMX78rmCAtFIF8jnsP7CY/kngr+1OH5tlB8Ev2kxKZlGZm+SJISO2zKDBbeboA4
         YSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=sYub0N475p+0VGhz+u6M1TELUK/iEnZfnAN/MojLZIE=;
        b=kjeYi6I++K1zoQCZ4nBpp4xiSCzrdvPDwS4B9to8HjoZ8eqr9NH/FW+dMZrKsXyBi+
         kV8X4qwm5qt846UlzmCgwBpRs5ruw5WkzdFWGmTX+C/yU8/E+nGAOV5RpVcxSUk5b0O8
         UcHzNj4Rf8s2NqYHchzyqY+rIgEKZK4nUgNvf24XoUJRXI/iYf8hOjYPqx46l8EZR3qF
         Bj2anAYrHn70mAkvLGW1zxkthTsG/Nn1aJwPSjvOXXf4k2O30PmwO9TXAtSPvkl98Adk
         p0rCXQi/DdUpmTBruwBY1UknoaCMqla5m5tEE2rfnfs/MUQDH3j9Mu7l01B73vFoF5HL
         pSeA==
X-Gm-Message-State: AJIora9z3S+eYnziX1HD48fo1jXTResbg0Om7ZWPI+7zj20ub3/JfEaN
        nuMFmLczkcN+QAvTWT74N20=
X-Google-Smtp-Source: AGRyM1uXzal0NgDC531OK+6wzV83ogvagHoNoOJlLzY7A1trI1imJ0FnVhho2+YakzVrN5zBn1NY6w==
X-Received: by 2002:adf:f184:0:b0:21b:6c76:5b6e with SMTP id h4-20020adff184000000b0021b6c765b6emr13423763wro.126.1656689799526;
        Fri, 01 Jul 2022 08:36:39 -0700 (PDT)
Received: from localhost (92.40.202.205.threembb.co.uk. [92.40.202.205])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003a03be22f9fsm1656240wmq.18.2022.07.01.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 08:36:38 -0700 (PDT)
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-13-aidanmacdonald.0x0@gmail.com>
 <CAHp75Vduv_fN=2DKbOwReRoPeAYjGqSANT7UhDaRifUJ4zf5XQ@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v4 12/15] pinctrl: Add AXP192 pin control driver
In-reply-to: <CAHp75Vduv_fN=2DKbOwReRoPeAYjGqSANT7UhDaRifUJ4zf5XQ@mail.gmail.com>
Date:   Fri, 01 Jul 2022 16:37:45 +0100
Message-ID: <oMIjFujkw4ZeuMGoTkWq64BbfEejJF12@localhost>
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

> On Wed, Jun 29, 2022 at 4:30 PM Aidan MacDonald
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
> ...
>
>> +config PINCTRL_AXP192
>> +       tristate "X-Powers AXP192 PMIC pinctrl and GPIO Support"
>> +       depends on MFD_AXP20X
>> +       select PINMUX
>> +       select GENERIC_PINCONF
>> +       select GPIOLIB
>> +       help
>> +         AXP PMICs provide multiple GPIOs that can be muxed for different
>> +         functions. This driver bundles a pinctrl driver to select the function
>> +         muxing and a GPIO driver to handle the GPIO when the GPIO function is
>> +         selected.
>> +         Say Y to enable pinctrl and GPIO support for the AXP192 PMIC.
>
> What will be the module name if compiled as a module?
>
> ...
>
>> +/**
>> + * struct axp192_pctl_function - describes a function that GPIOs may have
>> + *
>> + * @name: Function name
>> + * @muxvals: Mux values used for selecting this function, one per GPIO.
>> + *           The i'th element corresponds to the i'th GPIO and is written
>> + *           to the GPIO's control register field to select this function.
>> + *           U8_MAX indicates that the pin does not support this function.
>> + * @groups: Array of @ngroups groups listing pins supporting this function.
>> + * @ngroups: Number of pin groups.
>> + */
>> +struct axp192_pctl_function {
>> +       const char              *name;
>> +       /* Mux value written to the control register to select the function (-1 if unsupported) */
>> +       const u8                *muxvals;
>> +       const char * const      *groups;
>> +       unsigned int            ngroups;
>> +};
>
> Can it be replaced by struct function_desc?
> https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/pinmux.h#L130

That'd work, but using the generic infrastructure doesn't allow me to
simplify anything -- I can eliminate three trivial functions, but the
generic code is higher overhead (extra allocations, radix trees, ...)
so I'd prefer to stick with the current approach.

>> +       ret = devm_gpiochip_add_data(dev, &pctl->chip, pctl);
>> +       if (ret)
>> +               dev_err_probe(dev, ret, "Failed to register GPIO chip\n");
>
> Missed return.

Thanks for catching this, that was pretty silly of me...
