Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817FC4A65C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiBAUfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBAUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:35:02 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52EC061714;
        Tue,  1 Feb 2022 12:35:02 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id j2so57177384ejk.6;
        Tue, 01 Feb 2022 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rBAEWe0d14lBWb+Vsl5lHaaZyxn6U2i2/rJRhaGu09I=;
        b=K8Pg/SnYwiqGGwMKYRi5PWI7KLAJ3jN1eZ5+vwsnh1UO4bWxNmB5imh7fFIpaUKfwq
         ah4QJkBlyc59xahuWEaJjIj2sup3HeSXodD+LPjrt8Mrx+6PxY+7REFds+5mLu5NK+nx
         1j5ZNTCgmW24YmAwBibZFbEg1k8wXbe669LEePnxMY1EZRYlneCymJzt7xe4zFyc+jgt
         wbogeHzmaz9RdzjzIPRQibpyBJp0s5dNyoyTLD7xCOPMbcWG4a8FsUoMuWOKdWjiuQx4
         LFhBDZywoxbQjJW1ov+yXNEb+mT00+v9wBJKdzE/15a3z1/oNXSANK4Xj9XgqvPKgi5v
         vFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rBAEWe0d14lBWb+Vsl5lHaaZyxn6U2i2/rJRhaGu09I=;
        b=4plIUDScXmYxfpXqg/muWfIiZ2nQ3CDyOVVEItrEPU0GpFyCXhn60Oz1JtyctqHJ06
         MBPxSEJYICQw2UK7NqSxwNpfAMOdv6ubTEQ/y1s9IsKW9ybQn5AD73x0Q+hViVogL2Zl
         ELNBZFk7vFRjY5r3MrM7tIHQjcReGopbCL2N67l7EA8yNZ7qOMaJO4Ucqd9RuaqgpUDi
         /6Cre5srierTboxyRtRLScbQJ1nJOzWT4n2QSEKa/67uL8VUDLVWYPwh8pry+b9VAUfo
         BxoHDVtGjjtMUpwOckVK2U9gUoWNk9J+36BxgR0qZ90aw9A9BaGPnzpBslp3f88/z7vk
         328w==
X-Gm-Message-State: AOAM531yaZWEQXdm60IyZJgPJ61oL651lnY1SxI2IbikZmmoi3Yl2K92
        nINxka5mBeURUgsa5sMsb3ALQgVJ8A1n8S6Wyws=
X-Google-Smtp-Source: ABdhPJzuDSTKXphKmJDAwfCq0ryG/LXHHz5dzsibxHRC4MLM6QTN54Dse2l0wUBT2izRRfob3hXcOvXXhFZ5BdDu/IA=
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr22030548ejo.636.1643747700531;
 Tue, 01 Feb 2022 12:35:00 -0800 (PST)
MIME-Version: 1.0
References: <6a62a531227cd4f20d77d50cdde60c7a18b9f052.1643625325.git.geert+renesas@glider.be>
In-Reply-To: <6a62a531227cd4f20d77d50cdde60c7a18b9f052.1643625325.git.geert+renesas@glider.be>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Feb 2022 22:33:25 +0200
Message-ID: <CAHp75Vd68gsU-NWTGv4Y7Mo4-Vq7DBePa_yVxpDq=DAN5GLEBA@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Fix calling into sleeping GPIO controllers
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Mikko_Salom=C3=A4ki?= <ms@datarespons.se>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:09 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> If the parent GPIO controller is a sleeping controller (e.g. a GPIO
> controller connected to I2C), getting or setting a GPIO triggers a
> might_sleep() warning.  This happens because the GPIO Aggregator takes
> the can_sleep flag into account only for its internal locking, not for
> calling into the parent GPIO controller.
>
> Fix this by using the gpiod_[gs]et*_cansleep() APIs when calling into a
> sleeping GPIO controller.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
One nit-pick below, though.

> Reported-by: Mikko Salom=C3=A4ki <ms@datarespons.se>
> Fixes: 828546e24280f721 ("gpio: Add GPIO Aggregator")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I considered splitting the .[gs]et{_multiple}() callbacks for the
> sleeping vs. nonsleeping cases, but the code size increase (measured on
> ARM) would be substantial:
>   +64 bytes for gpio_fwd_[gs]et_cansleep(),
>   +296 bytes for gpio_fwd_[gs]et_multiple_cansleep().
> ---
>  drivers/gpio/gpio-aggregator.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregato=
r.c
> index 869dc952cf45218b..0cb2664085cf8314 100644
> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -278,7 +278,8 @@ static int gpio_fwd_get(struct gpio_chip *chip, unsig=
ned int offset)
>  {
>         struct gpiochip_fwd *fwd =3D gpiochip_get_data(chip);
>
> -       return gpiod_get_value(fwd->descs[offset]);

> +       return chip->can_sleep ? gpiod_get_value_cansleep(fwd->descs[offs=
et])
> +                              : gpiod_get_value(fwd->descs[offset]);

This indentation kills the perfectionist in me :-)
What about:

       return chip->can_sleep ?
               gpiod_get_value_cansleep(fwd->descs[offset]) :
gpiod_get_value(fwd->descs[offset]);

?

Or as variant

       struct gpio_desc *desc =3D fwd->descs[offset];

       return chip->can_sleep ? gpiod_get_value_cansleep(desc) :
gpiod_get_value(desc);

?

>  }
>
>  static int gpio_fwd_get_multiple(struct gpiochip_fwd *fwd, unsigned long=
 *mask,
> @@ -293,7 +294,10 @@ static int gpio_fwd_get_multiple(struct gpiochip_fwd=
 *fwd, unsigned long *mask,
>         for_each_set_bit(i, mask, fwd->chip.ngpio)
>                 descs[j++] =3D fwd->descs[i];
>
> -       error =3D gpiod_get_array_value(j, descs, NULL, values);
> +       if (fwd->chip.can_sleep)
> +               error =3D gpiod_get_array_value_cansleep(j, descs, NULL, =
values);
> +       else
> +               error =3D gpiod_get_array_value(j, descs, NULL, values);
>         if (error)
>                 return error;
>
> @@ -328,7 +332,10 @@ static void gpio_fwd_set(struct gpio_chip *chip, uns=
igned int offset, int value)
>  {
>         struct gpiochip_fwd *fwd =3D gpiochip_get_data(chip);
>
> -       gpiod_set_value(fwd->descs[offset], value);
> +       if (chip->can_sleep)
> +               gpiod_set_value_cansleep(fwd->descs[offset], value);
> +       else
> +               gpiod_set_value(fwd->descs[offset], value);
>  }
>
>  static void gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned lon=
g *mask,
> @@ -343,7 +350,10 @@ static void gpio_fwd_set_multiple(struct gpiochip_fw=
d *fwd, unsigned long *mask,
>                 descs[j++] =3D fwd->descs[i];
>         }
>
> -       gpiod_set_array_value(j, descs, NULL, values);
> +       if (fwd->chip.can_sleep)
> +               gpiod_set_array_value_cansleep(j, descs, NULL, values);
> +       else
> +               gpiod_set_array_value(j, descs, NULL, values);
>  }
>
>  static void gpio_fwd_set_multiple_locked(struct gpio_chip *chip,
> --
> 2.25.1
>


--=20
With Best Regards,
Andy Shevchenko
