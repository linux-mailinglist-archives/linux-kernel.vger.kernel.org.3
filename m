Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959144624B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhK2WYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhK2WWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:22:51 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF226C06FD69
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 12:18:43 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id az37so36642382uab.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cz2iwfg2ztgnowgU1B6ZR7M9U+ZkilyzOeAnpqC8M6s=;
        b=NytNeHa+6RJcZNYN053R/r2YI/ZFEb8SkpnqAP9REtbH7Rd/PeSAagIqiMzf8/Pocb
         yoKVzuudana6pc9xP5iMPGeN9lMO0BqQgd2FF5wsyARHuepmM4gHTYGfeF8LTR9EWm83
         3fWHANF0Ho1uIvNX5eaSqQXAgHp0mTvLWlw8p0gfBA/RIqyvUtBeNNP+aRsGCJ/iToPf
         5HRdV/kWRjq8rAWxZhhanHFr8UfgbkO36cm8jPIc9Q7vVDPlK1ADyX728oaWakr9KfYM
         TRws7HNOQ2Pdx71/vG7KFwl+wluEAouzGAkcQ3i+Yi2iPN/xsALyXJvtK8FNlrKEGuIc
         GOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cz2iwfg2ztgnowgU1B6ZR7M9U+ZkilyzOeAnpqC8M6s=;
        b=KDXavZen/wd2wAqpOWUNPJOfQdNOZ/pg3yrLBlyfoh7bFaIiMEu0L6xiI8Epe//Cr3
         Vy38rFUpkJWcNji1RYIE447aGThVcE1qzGk5VsX64FbsWMPvMO+gPQNzTrvEzK97ls2M
         frlQWNSmrlrtpjVkF8WB8zrqdynCqP8o0fqVYtXRD504J96aG/90XbsxcS1a7vGdeQbu
         Vat6+/xMPPu11xnKP8JnPGk0bav48LLjHwOojljlPYn1FdzWohmaHoDetA7wFgvvp3OF
         o1DzbbE1diPIhA976pyeEQsb6tEUDU7TX9WMIOcUrCICZvB9TsA/AJ1hnPVU635oL7rS
         /exg==
X-Gm-Message-State: AOAM530rRh+J3q4Vkwzyp/cTZuvwh3u1LAdhzjD2jEwuK/0sd/cTv156
        /7xhNcAhfHiHhUFd9xEDJ2RAkZdAPQEA2zWHSWgX7g==
X-Google-Smtp-Source: ABdhPJyCOQTZhSGaCcpZ0/hUdcFpLljvbTaQOZS4xaxIyN3ah63+FfKwiR4wNEeGhavO+EuY/hCie2K40l4vKcV0CG0=
X-Received: by 2002:a67:3382:: with SMTP id z124mr35921705vsz.57.1638217122958;
 Mon, 29 Nov 2021 12:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
 <20211127223253.19098-6-semen.protsenko@linaro.org> <9a51b37b-d2c4-fb73-bd3f-447c94a66c82@canonical.com>
In-Reply-To: <9a51b37b-d2c4-fb73-bd3f-447c94a66c82@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 29 Nov 2021 22:18:31 +0200
Message-ID: <CAPLW+4=Xp0m3ycm5c1WSJGtr6vRxx1fsW0MOo65fXMfaB1sR+w@mail.gmail.com>
Subject: Re: [PATCH 5/8] tty: serial: samsung: Enable console as module
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 at 10:52, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 27/11/2021 23:32, Sam Protsenko wrote:
> > Enable serial driver to be built as a module. To do so, init the console
> > support on driver/module load instead of using console_initcall().
> >
> > This is needed for proper support of USIv2 driver (which can be built as
> > a module, which in turn makes SERIAL_SAMSUNG be a module too). It also
> > might be useful for Android GKI modularization efforts.
> >
> > Inspired by commit 87a0b9f98ac5 ("tty: serial: meson: enable console as
> > module").
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/tty/serial/Kconfig       |  2 +-
> >  drivers/tty/serial/samsung_tty.c | 21 +++++++++++++++++++--
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index fc543ac97c13..0e5ccb25bdb1 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -263,7 +263,7 @@ config SERIAL_SAMSUNG_UARTS
> >
> >  config SERIAL_SAMSUNG_CONSOLE
> >       bool "Support for console on Samsung SoC serial port"
> > -     depends on SERIAL_SAMSUNG=y
> > +     depends on SERIAL_SAMSUNG
> >       select SERIAL_CORE_CONSOLE
> >       select SERIAL_EARLYCON
> >       help
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index f986a9253dc8..92a63e9392ed 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -1720,10 +1720,10 @@ static int __init s3c24xx_serial_console_init(void)
> >       register_console(&s3c24xx_serial_console);
> >       return 0;
> >  }
> > -console_initcall(s3c24xx_serial_console_init);
> >
> >  #define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
> >  #else
> > +static inline int s3c24xx_serial_console_init(void) { return 0; }
> >  #define S3C24XX_SERIAL_CONSOLE NULL
> >  #endif
> >
> > @@ -2898,7 +2898,24 @@ static struct platform_driver samsung_serial_driver = {
> >       },
> >  };
> >
> > -module_platform_driver(samsung_serial_driver);
> > +static int __init samsung_serial_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = s3c24xx_serial_console_init();
> > +     if (ret)
> > +             return ret;
>
> This will trigger warns on module re-loading, won't it? Either suppress
> unbind or cleanup in module exit.
>

I guess that's already taken care of in  samsung_serial_remove(): it's
doing uart_remove_one_port(), which in turn does unregister_console().
So I don't think anything extra should be done on module exit. Or I'm
missing something?

That case (unload/load) actually doesn't work well in my case: serial
console doesn't work after doing "modprobe -r samsung_tty; modprobe
samsung_tty" (but it works fine e.g. in case of i2c_exynos5 driver).
Not sure what is wrong, but I can see that my board keeps running
(heartbeat LED is still blinking). Not even sure if that use case
(unload/load) was ever functional before.

Anyway, please let me know if you think something should be done about
this particular patch. Right now I don't see anything missing.

> > +
> > +     return platform_driver_register(&samsung_serial_driver);
> > +}
> > +
> > +static void __exit samsung_serial_exit(void)
> > +{
> > +     platform_driver_unregister(&samsung_serial_driver);
> > +}
> > +
> > +module_init(samsung_serial_init);
> > +module_exit(samsung_serial_exit);
> >
> >  #ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
> >  /*
> >
>
>
> Best regards,
> Krzysztof
