Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9052A563055
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiGAJhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGAJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:37:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C5B747A9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:37:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fw3so2980595ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9INJe9qX/9bU3HwvSByKXrSKAuz8lmh0u26yhKlxq4=;
        b=H/4eD5XypA+RHsbV27UPmTKowV9OgIz+1uwq//MHlSQhrZmuGMGGkAS29VVjfvXw28
         CC5mgnQkvlZwZXdYquw3G2ybVnoavXiZK9FRSBZUjsaemv5tTUO/GvLK8tqx+yy7Y7AU
         DqgwEBvUqET6vhl8DMp353HRoX+UcTCfBPYrjdXE0rUJkj+QPNF+deTL8zd7Jb8MwcZP
         d2/W0z+KvS/RGg6T8VwLjnL5U2Cr8L4dWCAGH9tRbYOvj71dC083STxJI5YfE/cqu6Dp
         qUOVbSjah69tZB0Heh8uZqnGA3yBj2hmX7Poo3fL+UOgQxOvrKkTLwlKilC9Su7M0uuj
         pqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9INJe9qX/9bU3HwvSByKXrSKAuz8lmh0u26yhKlxq4=;
        b=YbInL8lPpLSKfhA6PLibV11/KHhvNHH9AFyT18xOiQVv76EprZzRVFesLeOxCkwyF2
         fHLwOLyt6LhuyacENZNqtpcJ64zKGjEguJY1A2a61igIPKTcBk2SjOO2v1N/fz61+qU+
         juR3TM8Nnes/AoT1Q/2nN76ni9uUKRV3jYd57s00x1pJhyUJwZn0cjbRZYo2MJmvuHSC
         4F07FegU2pIrDdlEMSAyzNqqVSiItyjOeUffUzvRo+kgdcfAllq4oaa7tPNOmJjSCAgX
         LpuGmK3BFb9QiijFafYO+qT4kJ9tQIBGDavBTIuiKBRFvd0O7jQTvqYFtR0Q0cHlMzs3
         ObiA==
X-Gm-Message-State: AJIora8qbofKJz4ZpqgthTypAcL5+0OXxZNwSlL+fNZF4xFv7u5yJsjk
        TJvGdJZSphHjLj45faM7SFckfBNdEBBz2UGAL0HAGQ==
X-Google-Smtp-Source: AGRyM1tnOg4CBN5U2gae3WNEAHzXGo+CBze0iuiWVFefJqUUDMbwmjzhm51wVL7GhQd24hWnGb5+116mgMZOiLBa/x8=
X-Received: by 2002:a17:907:2815:b0:72a:4eda:a35f with SMTP id
 eb21-20020a170907281500b0072a4edaa35fmr9813671ejc.636.1656668269483; Fri, 01
 Jul 2022 02:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220628195913.36940-1-andriy.shevchenko@linux.intel.com> <20220628195913.36940-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220628195913.36940-2-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Jul 2022 11:37:38 +0200
Message-ID: <CAMRc=MfyTC3ryT9ZM7KY0bUL_Tt17swoqGOfTG6zqv=vrAmM-g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: adnp: Make use of device properties
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-adnp.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
> index 075782831044..a6439e3daff0 100644
> --- a/drivers/gpio/gpio-adnp.c
> +++ b/drivers/gpio/gpio-adnp.c
> @@ -6,8 +6,9 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_irq.h>
> +#include <linux/property.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>
> @@ -487,19 +488,15 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios,
>
>  static int adnp_i2c_probe(struct i2c_client *client)
>  {
> -       struct device_node *np = client->dev.of_node;
> +       struct device *dev = &client->dev;
>         struct adnp *adnp;
>         u32 num_gpios;
>         int err;
>
> -       err = of_property_read_u32(np, "nr-gpios", &num_gpios);
> +       err = device_property_read_u32(dev, "nr-gpios", &num_gpios);
>         if (err < 0)
>                 return err;
>
> -       client->irq = irq_of_parse_and_map(np, 0);
> -       if (!client->irq)
> -               return -EPROBE_DEFER;
> -
>         adnp = devm_kzalloc(&client->dev, sizeof(*adnp), GFP_KERNEL);
>         if (!adnp)
>                 return -ENOMEM;
> @@ -507,8 +504,7 @@ static int adnp_i2c_probe(struct i2c_client *client)
>         mutex_init(&adnp->i2c_lock);
>         adnp->client = client;
>
> -       err = adnp_gpio_setup(adnp, num_gpios,
> -                       of_property_read_bool(np, "interrupt-controller"));
> +       err = adnp_gpio_setup(adnp, num_gpios, device_property_read_bool(dev, "interrupt-controller"));
>         if (err)
>                 return err;
>
> --
> 2.35.1
>

Applied, thanks!

Bart
