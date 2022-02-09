Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836B84AF179
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiBIM0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiBIMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:25:59 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24685C05CB86;
        Wed,  9 Feb 2022 04:26:00 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id g10so2378263vss.1;
        Wed, 09 Feb 2022 04:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5WVmydqJCvKG/B3ZDDRDsVd5anO+fEWBRVMVdA65vE=;
        b=QcUf41XJq8Z8BFLAEmDOOkhmrGcfpwV+uPLzT++8MceQMrnwx1OsKAsi/9QRQUk0lT
         wO6vURirwXkdRG5hKamE6bZzeELeeTbpEQMe+7iCk4d3z4hW0RDOt/1C5nIIf2O1vVCa
         80PlBuHAeajC2yTafwUtv9652VrBz9T/Z7Z5ZqW6Kb3VhhyFVV4MuwGPnNufR6kJF3zG
         1mlgvYfyunsvHekb/XFml+tD/pW8clcTU0aL0OcIksPPh5k+jgpQAB1cbKDGU/ryCKP1
         bHEJo5hRxnYKuZsKOnvAMXcYwLiuMu6ldhwAk0joe9TVOIiw9NkZcS9/l4/Ms7hVVFp4
         /jtg==
X-Gm-Message-State: AOAM532VJdIIyHBtCJeR42MFoPWBOay+EWy/i3VUxFLQx9bJHLeJ+G5I
        uBOlH3vuyrbPDIxv+6PtD5bVXVtCIq8mTA==
X-Google-Smtp-Source: ABdhPJz1VK8vRtw1kC05gajhhDEp97Q9lPjlFKkuixUSYZCn9yBDt3n0/oaMYm0o0k45XAsttUSKeA==
X-Received: by 2002:a05:6102:364:: with SMTP id f4mr530268vsa.21.1644409558964;
        Wed, 09 Feb 2022 04:25:58 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id k20sm3039188vsg.14.2022.02.09.04.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:25:58 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id n14so1047263vkk.6;
        Wed, 09 Feb 2022 04:25:58 -0800 (PST)
X-Received: by 2002:a1f:294c:: with SMTP id p73mr691592vkp.0.1644409557884;
 Wed, 09 Feb 2022 04:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20220209090314.2511959-1-javierm@redhat.com> <20220209091204.2513437-1-javierm@redhat.com>
In-Reply-To: <20220209091204.2513437-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 13:25:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
Message-ID: <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI support
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The ssd130x driver only provides the core support for these devices but it
> does not have any bus transport logic. Add a driver to interface over SPI.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd130x-spi.c

> +static const struct of_device_id ssd130x_of_match[] = {
> +       {
> +               .compatible = "solomon,ssd1305fb-spi",

This needs an update to the DT bindings.
Hence this may be a good time to deprecate the existing
"solomon,ssd130*fb-i2c" compatible values, and switch to
"solomon,ssd130*fb" instead, for both I2C and SPI.
Of course the I2C subdriver still has to bind against the old values,
too, for backwards compatibility.

> +               .data = (void *)&ssd130x_ssd1305_deviceinfo,

The casts are not needed.

> +       },
> +       {
> +               .compatible = "solomon,ssd1306fb-spi",
> +               .data = (void *)&ssd130x_ssd1306_deviceinfo,
> +       },
> +       {
> +               .compatible = "solomon,ssd1307fb-spi",
> +               .data = (void *)&ssd130x_ssd1307_deviceinfo,
> +       },
> +       {
> +               .compatible = "solomon,ssd1309fb-spi",
> +               .data = (void *)&ssd130x_ssd1309_deviceinfo,
> +       },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ssd130x_of_match);
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
