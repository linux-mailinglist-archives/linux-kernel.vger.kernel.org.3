Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AFC4FD470
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386313AbiDLIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359420AbiDLHnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:43:02 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9F2B2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:23:51 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id 3so5606899qkj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h09al9GPNRGrgzoVRTG5PYUk3CouyOtKbjw7IpJLnEw=;
        b=uL+kHwbVi2G3PLmHPKhQRezY1+QnylU84gIWnxwYLhAZf4lMYVuPsml1LuIOjLqbB9
         193viVP9OmCOliEoozEq7s7ABQeinAN7Y5n60+KMioz2upgcBYS/69sBneeqIO1d18F/
         3UTCroZSTQACfGriv9S9EHjjkVig1lO5bTNprfQKfvC3RJlKQ9ftmWvfXpipdbdUbXe7
         pIBHHwqpD4N6UCQfVLC7rZjVsBV2WWf9Gcp+79ng0E6Hyb361J8hSJXNu7YjR35rU0Ds
         bxcadl1RjuIg1LHwlFMzlBrqKDrm9DEXBx1OaSufCCiEjcjpQ/PGgdZGKsC8JIEz9/eH
         qhJg==
X-Gm-Message-State: AOAM531EDPPLs/tnrkDHpfwvWA26Z3xMz4JGb3HA5Kd2bSDHTnyeTpSe
        cDX/tj+YtayhOLtwCg7pLl8gPnr8Ypojfr0n
X-Google-Smtp-Source: ABdhPJzRblZrIN6hFP/yVqZSHVaElweTattpKSgtKz5iq+JvRRwl+bSx+IQp93wYLKIay/S5n1jO5g==
X-Received: by 2002:ae9:e8d0:0:b0:69b:ef92:c0b with SMTP id a199-20020ae9e8d0000000b0069bef920c0bmr2105500qkg.498.1649748230394;
        Tue, 12 Apr 2022 00:23:50 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id c7-20020a37e107000000b0069c126c5107sm3890118qkm.39.2022.04.12.00.23.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:23:50 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id x200so7868086ybe.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:23:49 -0700 (PDT)
X-Received: by 2002:a25:29c2:0:b0:641:224f:17d6 with SMTP id
 p185-20020a2529c2000000b00641224f17d6mr10498662ybp.546.1649748229732; Tue, 12
 Apr 2022 00:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220411211243.11121-1-javierm@redhat.com> <20220411211243.11121-5-javierm@redhat.com>
In-Reply-To: <20220411211243.11121-5-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:23:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVSsAtRLob5fLoBMNu-DRXJOaBrEHYEwG5iCA03XR5JSw@mail.gmail.com>
Message-ID: <CAMuHMdVSsAtRLob5fLoBMNu-DRXJOaBrEHYEwG5iCA03XR5JSw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
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

Thanks for your patch!

On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> These are declared in the ssd130x-i2c transport driver but the information
> is not I2C specific, and could be used by other SSD130x transport drivers.
>
> Move them to the ssd130x core driver and just set the OF device entries to
> an ID that could be used to lookup the correct device info from an array.
>
> While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
> bytes. Since even though are used by the I2C interface, it could also be

though they are ... they could

> useful for other transport protocols such as SPI.
>
> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c

> @@ -860,7 +890,14 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>
>         ssd130x->dev = dev;
>         ssd130x->regmap = regmap;
> -       ssd130x->device_info = device_get_match_data(dev);
> +
> +       variant = (enum ssd130x_variants)device_get_match_data(dev);

(uintptr_t), to avoid a cast from pointer to integer of different
size warning.

> +

Please drop the blank line.

> +       if (variant >= NR_SSD130X_VARIANTS)
> +               return ERR_PTR(dev_err_probe(dev, -EINVAL,
> +                                            "Invalid SSD130x variant\n"));
> +
> +       ssd130x->device_info = &ssd130x_variants[variant];
>
>         if (ssd130x->device_info->page_mode_only)
>                 ssd130x->page_address_mode = 1;

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
