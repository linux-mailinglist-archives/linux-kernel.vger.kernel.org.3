Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6719F472E79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbhLMOEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhLMOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:04:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B5C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:04:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so53146559edu.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yENGFlG/mOG5cGmNIIA+b23W/RE/cf9uRfpXrR8/4dQ=;
        b=EEGwuSUw7KgTFdrREsE0p08UJCb9U9xcTzZnqe1qy2ZvHDQW4qdAtMaB5esySIZdHS
         aT6XAv1eVf+illQxC0x0IAf4UJ/4kRerbkNM8EVySfveme/dHtddZTma0U3Cxi5+8ruI
         xO/uXIlBVyw+m6JgU3/mJUcftiDipTL9IOb9xyvzo8Beberqcgp5bAxTWaNct652FM3S
         1T4leKAEln8nvgkoNVVyojBItwZt1gkRABpxt3SM8t5bVUjX4Uua6F22rl4U6RbsQss+
         pYKD/rLsgGYTGq91AcgLddrsry3htOuvIlLKPOVBTHdcq9DFeZweTUqqzId/2t1MfLy0
         i1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yENGFlG/mOG5cGmNIIA+b23W/RE/cf9uRfpXrR8/4dQ=;
        b=OCSq3MZDcp/KKhSkKZl/WjQkrh7TJ52plaRcSXbTnArQXlMl/PRc8VkSkYj9+pRgDp
         TJOqlOtLt9+XZBjRwqATJbhJYWJoFT9ZTBgs01ykRipfp/muDvf61Rw2TenhG4hSLqed
         zDf51pKLRmtpBQHO8PmQs2TlUVHQo3R1IWORMHeLYFCEp1woIPBDA5ygIDHGFaGEGano
         6XYaWfe0e+BjHXn3JgUsRvao9qU0cXyUkmJItBkt2yWwP+m572cm5VyQbiL4BfGrQdob
         hN3J9dqpedZXOP45eM8DylYECOPlCyGB8anZlfaG0kfiL5jx0WGw2i8lSQXI6iUihgwt
         ZBWQ==
X-Gm-Message-State: AOAM533Z08lBLNdEg1qImicdj6RsJzImZLJM22efFjbz02Vz0SU2EzMf
        8V5ZxGwzbjsA3duOdG1jbCg5tHk9tVHaunEr7B412g==
X-Google-Smtp-Source: ABdhPJzhnvPD6hbM84dyyWoCLb2MJSZ/0QUgY6OWiPNIXLB5p3QBA6nKeCUamPgCY4pLxKdEC5KQV41KY7tNgGkH+hY=
X-Received: by 2002:a17:907:7b99:: with SMTP id ne25mr44737768ejc.15.1639404290607;
 Mon, 13 Dec 2021 06:04:50 -0800 (PST)
MIME-Version: 1.0
References: <70b1de02-b674-ca17-9219-61fa8e1c00db@axentia.se>
In-Reply-To: <70b1de02-b674-ca17-9219-61fa8e1c00db@axentia.se>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 Dec 2021 15:04:40 +0100
Message-ID: <CAMRc=Me-gjJabw7Q5y+qvytD17JNV-f18YkXT+nUsjOGAw9MqA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: allow line names from device props to override
 driver names
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexander Dahl <ada@thorsis.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 12:32 PM Peter Rosin <peda@axentia.se> wrote:
>
> Some gpio providers set names for gpio lines that match the names of
> the pins on the SoC, or variations on that theme. These names are
> generally generic, such as pioC12 in the at91 case. These generic names
> block the possibility to name gpio lines with in device properties
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
>
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

Hi Peter,

This looks good, please resend with Andy's comments addressed so that
I can pick it up.

Bart
