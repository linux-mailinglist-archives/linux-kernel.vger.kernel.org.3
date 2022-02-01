Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87BD4A667A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiBAUyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:54:23 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:43775 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiBAUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:54:11 -0500
Received: by mail-ua1-f48.google.com with SMTP id a24so1728102uat.10;
        Tue, 01 Feb 2022 12:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hzPMVYA6JSyF04scFOLCtVol/sa3kyshLCHF8CeYoQ=;
        b=vDWXg2Z/zopD6by1ebOQFuBOjdV31StMoRlJLvF6XWDPnfHA/EcmhuA7aAS0hjX9et
         ge6/1ThY0oZnowVnkPTbExwDno7RijKM+EHMZ02/I/WgQEoRyTFaQ4vMYcuPG96Y6mbt
         GSoJS3znki2HBpYkSKYJuSwbC9WjIulTznxp1YqV5OZ3Bsve7ucXwj+izoX+nMPZS+eG
         HzY/s108Uy1j+WFRLngTjtN/7ifQZsgpNYS44Z/+mpLcT6+Ljl2B1K4N3AjteaVruj2b
         0JNlAIP7X32iyUy9vW/hS2giCen+St7Nb+kW8g481uVvQt+Hwcc5tzM83/5ccffr+sho
         AySA==
X-Gm-Message-State: AOAM530zi66qOlTaVVQUWq7pYqStKQFMpqxN2jaw9vrv8/FsKuhns62p
        KxAErxz2Ax2FHtPIZfqXEemHH/aQ2HGQFQ==
X-Google-Smtp-Source: ABdhPJxWMRTFsT6jXnSEqZ+pkaD88aqDKpzpQ6MjZ7jT77+ZAXfX0CrXUDM7rRK5jMp+i4SM7GIMFQ==
X-Received: by 2002:a05:6102:2922:: with SMTP id cz34mr10596276vsb.55.1643748850537;
        Tue, 01 Feb 2022 12:54:10 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id t190sm74705vst.16.2022.02.01.12.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 12:54:10 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id b37so15394511uad.12;
        Tue, 01 Feb 2022 12:54:09 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr11140054vsj.5.1643748849729;
 Tue, 01 Feb 2022 12:54:09 -0800 (PST)
MIME-Version: 1.0
References: <6a62a531227cd4f20d77d50cdde60c7a18b9f052.1643625325.git.geert+renesas@glider.be>
 <CAHp75Vd68gsU-NWTGv4Y7Mo4-Vq7DBePa_yVxpDq=DAN5GLEBA@mail.gmail.com>
In-Reply-To: <CAHp75Vd68gsU-NWTGv4Y7Mo4-Vq7DBePa_yVxpDq=DAN5GLEBA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 21:53:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUq3qZqVHH-QSVnwemVRyCp7b2Ldd-7Q2V8CXcj0+9aow@mail.gmail.com>
Message-ID: <CAMuHMdUq3qZqVHH-QSVnwemVRyCp7b2Ldd-7Q2V8CXcj0+9aow@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Fix calling into sleeping GPIO controllers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Mikko_Salom=C3=A4ki?= <ms@datarespons.se>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Feb 1, 2022 at 9:35 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 1, 2022 at 10:09 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > If the parent GPIO controller is a sleeping controller (e.g. a GPIO
> > controller connected to I2C), getting or setting a GPIO triggers a
> > might_sleep() warning.  This happens because the GPIO Aggregator takes
> > the can_sleep flag into account only for its internal locking, not for
> > calling into the parent GPIO controller.
> >
> > Fix this by using the gpiod_[gs]et*_cansleep() APIs when calling into a
> > sleeping GPIO controller.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

> > +++ b/drivers/gpio/gpio-aggregator.c
> > @@ -278,7 +278,8 @@ static int gpio_fwd_get(struct gpio_chip *chip, unsigned int offset)
> >  {
> >         struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
> >
> > -       return gpiod_get_value(fwd->descs[offset]);
>
> > +       return chip->can_sleep ? gpiod_get_value_cansleep(fwd->descs[offset])
> > +                              : gpiod_get_value(fwd->descs[offset]);
>
> This indentation kills the perfectionist in me :-)

Why? The above is aligned perfectly ("?" just above ":")?

> What about:
>
>        return chip->can_sleep ?
>                gpiod_get_value_cansleep(fwd->descs[offset]) :
> gpiod_get_value(fwd->descs[offset]);
>
> ?
>
> Or as variant
>
>        struct gpio_desc *desc = fwd->descs[offset];
>
>        return chip->can_sleep ? gpiod_get_value_cansleep(desc) :
> gpiod_get_value(desc);
>
> ?

IMHO, those are ugly as hell ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
