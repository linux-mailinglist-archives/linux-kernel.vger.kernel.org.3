Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B044B46E834
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhLIMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhLIMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:17:33 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D9FC061746;
        Thu,  9 Dec 2021 04:14:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g14so18512118edb.8;
        Thu, 09 Dec 2021 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcqG+yIMRWbvsIxAgzL5tDWYN19ufSQbNnx+qyBgNCg=;
        b=QgTXc4wE4avCeEzHo1LJZgS/oiLIZjIiunW9Tknt4txUs2kSkCsn738zHkg8+KhU5n
         bUs1pdb/vsKbi/RCKitDkFHYlZY4Mev7f7TCwrT+ljOjpn+w1SZ/v1n7+BvDXrNt0qL0
         6ycQpp+eLieRgi1QhAq5GQF1NxvTE236gXi0budmziMEFgkOl0/+4XDq6g1/jT8yldaF
         7Aiv7qaCmU3CCi/p5H9No2xsG7HA3UTxP30UC2apEn4gJJN813l3fq9SqLBIdhZXzId1
         yySPm8rfrhQsDeWStev+/EwibqwZI6xAp7nn5x7to+mcl8Jif4peBXEIEKV2kHaWama0
         u4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcqG+yIMRWbvsIxAgzL5tDWYN19ufSQbNnx+qyBgNCg=;
        b=3j45pZRKZxvePk1vXUzJ+L7esii+KKn3Z8JDAKPffCXXt74zOYbiMLRN0odaZDp2EL
         lVYJxEkGyAROknIAhmhH00swHkhjX6sdVNuPS8ZyVw/nqo5c6DCck92iarTJWAccmXIW
         Z98381FheR66Pn9GxYQRmCZXiw3ijbQr4kZnf0OQ5Plw7bfT8nShG2fbVEN7hJhGebqg
         1GiL+gpEQfKzD70Zcc919/jKkkzkub/mQIe+ommudCG1tzarpKgf/bx4uUS8D5zqRF/C
         H/d0sS6ukhUVA12yl9NFf5jklb0yD+knwf68AmUF6sQ4mZX4NxUsEsRZ46eIvQju6nHU
         EKIA==
X-Gm-Message-State: AOAM5326XmpfJk2VNC+hCo9Fl2MUHBTvWHJEnNs03LP/ydxHQ4Ox2Gm3
        pfL1BO3qrkF2Y2/vxFFFst+k6PbmvcU8MmqxScU=
X-Google-Smtp-Source: ABdhPJyJs+HRFH8FbMd//DCJMgOGyw2wJO5vu3Ro8RaqWU9inUQ0qYs/mopQZYqSpcimKx/Rpktlsk9bBO84sSYZg0c=
X-Received: by 2002:a05:6402:291:: with SMTP id l17mr28483542edv.242.1639052037586;
 Thu, 09 Dec 2021 04:13:57 -0800 (PST)
MIME-Version: 1.0
References: <70b1de02-b674-ca17-9219-61fa8e1c00db@axentia.se>
In-Reply-To: <70b1de02-b674-ca17-9219-61fa8e1c00db@axentia.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Dec 2021 14:12:25 +0200
Message-ID: <CAHp75Ve06-3KU60-tXFR-KMw4iSX9rOSNF3Oq7vm+ST8Qc8ujA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: allow line names from device props to override
 driver names
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexander Dahl <ada@thorsis.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 1:32 PM Peter Rosin <peda@axentia.se> wrote:
>
> Some gpio providers set names for gpio lines that match the names of

gpio -> GPIO here and everywhere else in the patch where it is applicable.

> the pins on the SoC, or variations on that theme. These names are
> generally generic, such as pioC12 in the at91 case. These generic names

"generally generic" (reminds me
https://en.wiktionary.org/wiki/%D0%BC%D0%B0%D1%81%D0%BB%D0%BE_%D0%BC%D0%B0%D1%81%D0%BB%D1%8F%D0%BD%D0%BE%D0%B5)

Perhaps

"These names generally speaking are generic, ..." ?

> block the possibility to name gpio lines with in device properties

within ?

> (i.e. gpio-line-names).
>
> Allow overriding a generic name given by the gpio driver if there is
> a name given to the gpio line using device properties, but leave the
> generic name alone if no better name is available.
>
> However, there is a risk. If user space is depending on the above
> mentioned fixed gpio names, AND there are device properties that
> previously did not reach the surface, the name change might cause
> regressions. But hopefully this stays below the radar...

After addressing the mentioned grammar nit-picks, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpio/gpiolib.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> Instead of doing this only for pinctrl-at91.c as in my recent patch [1], do
> it for everyone.
>
> Cheers,
> Peter
>
> [1] https://lore.kernel.org/lkml/4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se/
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index abfbf546d159..00a2a689c202 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -422,8 +422,15 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
>         if (count > chip->ngpio)
>                 count = chip->ngpio;
>
> -       for (i = 0; i < count; i++)
> -               gdev->descs[i].name = names[chip->offset + i];
> +       for (i = 0; i < count; i++) {
> +               /*
> +                * Allow overriding "fixed" names provided by the gpio
> +                * provider, the "fixed" names are generally generic and less
> +                * informative than the names given in device properties.
> +                */
> +               if (names[chip->offset + i] && names[chip->offset + i][0])
> +                       gdev->descs[i].name = names[chip->offset + i];
> +       }
>
>         kfree(names);
>
> @@ -708,10 +715,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>         INIT_LIST_HEAD(&gdev->pin_ranges);
>  #endif
>
> -       if (gc->names)
> +       if (gc->names) {
>                 ret = gpiochip_set_desc_names(gc);
> -       else
> -               ret = devprop_gpiochip_set_names(gc);
> +               if (ret)
> +                       goto err_remove_from_list;
> +       }
> +       ret = devprop_gpiochip_set_names(gc);
>         if (ret)
>                 goto err_remove_from_list;
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
