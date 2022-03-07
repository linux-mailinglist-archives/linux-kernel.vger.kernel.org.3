Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85934CF466
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiCGJOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiCGJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:14:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7079D45536
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:13:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w4so16368597edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6o3CiUuUnMz0HnogpVCxbmqNwkYaC8XOsfIDIjyN14=;
        b=TxOZWmSdsLVRK5BjTbMRMvYcpIjhv4FDpcBHiEQLOTjQwqCYWTSjVnMOIWiqth3r97
         RedCbmJEbeGHq5VgJ3VmvWY6F4zhb+dq9mNhyc7+XfgZ3C+EzT44T656o1zTa1sAg5Gh
         RAp051bsZo+yg69F+8INouYW5QF0yrv2i3qROAa3faIc07DaCtuy2vtxE6+jxf70iK39
         /Z5wDs6s7xDpl1Ba8tEd2rI3R1OmPR0RpRpvY4lgZk55uhZH5psKVXavi5JgCLaX8VYG
         0sv6XkH9701y0H58fvfEsHFc1Ot0NNgtbPpXgFbR5wKZj3KCjeZ91WhHF1kQfi9SEicE
         LJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6o3CiUuUnMz0HnogpVCxbmqNwkYaC8XOsfIDIjyN14=;
        b=UYLx3FgjNnfIGQqR/5kNFFe5/H9+f0jGyHX/0NFH2ZmQ+lPUvc8uGFFoVknZ2dtzBh
         9sKuSKOr2LsZ1iWypUspfWpCaXEnJ+zewtbL0sALPrvcHbguRW+Edcr7kfP+P5myt9xa
         ltQMxaY47Lrm9OffOt91k20NPdIsRz5WKPdzs8/5AnT1haRTzIzP0CxScJVYV0qd3zhN
         Pgmb596izhVLhBvF0HqT9PiUxQ91yrDGtZe7aNm5Wxz1jXLRlXGAm+GmyAS8z4bXKZtG
         TfsFOxzrzQzbX6gaLuvMGwB5XOkwr9BNOqI1fgSiPcyVQPbSLP4ooRRwfchcZl7NsxDf
         QZtg==
X-Gm-Message-State: AOAM533H4S/++K59oFliaWY/xnzQ6UlUqIPxKD7KCnlEmfieFhwwsVbd
        MYxTlAnszeJSSzDtiBKNnwfherAv4n1P+J2SZrz6bA==
X-Google-Smtp-Source: ABdhPJyMQTolfgBB3byDQUjuRxUwV3m5DtZO69+ewybZEOA0pse92b6VD/6dlSgoKgkLW6TptKyus3Z0HiHyQUkH+9I=
X-Received: by 2002:a05:6402:d0d:b0:416:1d69:f23b with SMTP id
 eb13-20020a0564020d0d00b004161d69f23bmr10064731edb.141.1646644401992; Mon, 07
 Mar 2022 01:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20220304221517.30213-1-kris@embeddedTS.com>
In-Reply-To: <20220304221517.30213-1-kris@embeddedTS.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Mar 2022 10:13:11 +0100
Message-ID: <CAMRc=MeHT4pX1ZRbOz0owDDec5rv+FE84rp464ugffbH5PuS5w@mail.gmail.com>
Subject: Re: [PATCH] gpio: ts4900: Do not set DAT and OE together
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 11:15 PM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> From: Mark Featherston <mark@embeddedTS.com>
>
> This works around an issue with the hardware where both OE and
> DAT are exposed in the same register. If both are updated
> simultaneously, the harware makes no guarantees that OE or DAT
> will actually change in any given order and may result in a
> glitch of a few ns on a GPIO pin when changing direction and value
> in a single write.
>
> Setting direction to input now only affects OE bit. Setting
> direction to output updates DAT first, then OE.
>
> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
>  drivers/gpio/gpio-ts4900.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
> index d885032cf814..fbabfca030c0 100644
> --- a/drivers/gpio/gpio-ts4900.c
> +++ b/drivers/gpio/gpio-ts4900.c
> @@ -1,7 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Digital I/O driver for Technologic Systems I2C FPGA Core
>   *
> - * Copyright (C) 2015 Technologic Systems
> + * Copyright (C) 2015-2018 Technologic Systems
>   * Copyright (C) 2016 Savoir-Faire Linux
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -55,19 +56,33 @@ static int ts4900_gpio_direction_input(struct gpio_chip *chip,
>  {
>         struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
>
> -       /*
> -        * This will clear the output enable bit, the other bits are
> -        * dontcare when this is cleared
> +       /* Only clear the OE bit here, requires a RMW. Prevents potential issue
> +        * with OE and data getting to the physical pin at different times.
>          */
> -       return regmap_write(priv->regmap, offset, 0);
> +       return regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OE, 0);
>  }
>
>  static int ts4900_gpio_direction_output(struct gpio_chip *chip,
>                                         unsigned int offset, int value)
>  {
>         struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
> +       unsigned int reg;
>         int ret;
>
> +       /* If changing from an input to an output, we need to first set the
> +        * proper data bit to what is requested and then set OE bit. This
> +        * prevents a glitch that can occur on the IO line
> +        */
> +       regmap_read(priv->regmap, offset, &reg);
> +       if (!(reg & TS4900_GPIO_OE)) {
> +               if (value)
> +                       reg = TS4900_GPIO_OUT;
> +               else
> +                       reg &= ~TS4900_GPIO_OUT;
> +
> +               regmap_write(priv->regmap, offset, reg);
> +       }
> +
>         if (value)
>                 ret = regmap_write(priv->regmap, offset, TS4900_GPIO_OE |
>                                                          TS4900_GPIO_OUT);
> --
> 2.11.0
>

This looks like a fix, can you add a Fixes tag?

Bart
