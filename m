Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32088506650
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349635AbiDSHzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349619AbiDSHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:55:06 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E567E31DDB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:52:22 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id b17so12514068qvf.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpM1PtiHq5rdtdF2Z1pptR1cVQG3GJl0J2jHpx0HNOE=;
        b=Ve/Ox7ti93JBrF3at9DJpunuyOOYwJah9HfKkZOTCDrbqwlu775M60CcZD8i6VfeuI
         tpY7QKDebfs2fUjd8nJFjsAr5AN6j0U2T+jghuUhEtYdK1iMReQWyWhYjktJgKmjq9zh
         SUbgx9tmGnxnJIMvuSIzPya7rn84C+VqmPnHKiKzaq3yobypU+YOymGQwefSff028gec
         O4g43fQAvPr0alLM+NUTjW7eg5GYWJiwhfVLzTINcqsirvOHK4MQrjKExJMTemdeImcD
         8JyAmn3PV6ILYUMZ9A6+yDZ2r7Z7aZ88lIppAh2BlmF3YFIzVlJ5T3n7VpZ4zghgWfKu
         g+qg==
X-Gm-Message-State: AOAM533J9Hnjk4RFYE2lMsfNhTf8O716cYxPTw6UUnj52WupEO8GpbD2
        1GDNoF/i9M7LQ4mXWf7F2sz2LiEhjdyyIQ==
X-Google-Smtp-Source: ABdhPJz//HOyy3VL2niCdUzX7QS1+q51CUYQK/Ac7t1zsvJH3KNdVE4PnPD9FUw1Nvocgb/QWIRVOw==
X-Received: by 2002:ad4:5deb:0:b0:446:44ec:8d88 with SMTP id jn11-20020ad45deb000000b0044644ec8d88mr10354001qvb.126.1650354741454;
        Tue, 19 Apr 2022 00:52:21 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id m139-20020a37a391000000b0069e88edfdacsm3877467qke.105.2022.04.19.00.52.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:52:20 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id d19so1173027ybc.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:52:20 -0700 (PDT)
X-Received: by 2002:a25:8087:0:b0:641:dd06:577d with SMTP id
 n7-20020a258087000000b00641dd06577dmr13514790ybk.207.1650354739846; Tue, 19
 Apr 2022 00:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220413162359.325021-1-javierm@redhat.com> <20220413162359.325021-6-javierm@redhat.com>
In-Reply-To: <20220413162359.325021-6-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Apr 2022 09:52:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_myNcA1eG=-qOHhtCEMnnV_eMjQF3dWakd7O6JbXskQ@mail.gmail.com>
Message-ID: <CAMuHMdX_myNcA1eG=-qOHhtCEMnnV_eMjQF3dWakd7O6JbXskQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/solomon: Add SSD130x OLED displays SPI support
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        YueHaibing <yuehaibing@huawei.com>
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

On Wed, Apr 13, 2022 at 6:24 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The ssd130x driver only provides the core support for these devices but it
> does not have any bus transport logic. Add a driver to interface over SPI.
>
> There is a difference in the communication protocol when using 4-wire SPI
> instead of I2C. For the latter, a control byte that contains a D/C# field
> has to be sent. This field tells the controller whether the data has to be
> written to the command register or to the graphics display data memory.
>
> But for 4-wire SPI that control byte is not used, instead a real D/C# line
> must be pulled HIGH for commands data and LOW for graphics display data.
>
> For this reason the standard SPI regmap can't be used and a custom .write
> bus handler is needed.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd130x-spi.c

> +/*
> + * The regmap bus .write handler, it is just a wrapper around spi_write()
> + * but toggling the Data/Command control pin (D/C#). Since for 4-wire SPI
> + * a D/C# pin is used, in contrast with I2C where a control byte is sent,
> + * prior to every data byte, that contains a bit with the D/C# value.
> + *
> + * These control bytes are considered registers by the ssd130x core driver
> + * and can be used by the ssd130x SPI driver to determine if the data sent
> + * is for a command register or for the Graphic Display Data RAM (GDDRAM).
> + */
> +static int ssd130x_spi_write(void *context, const void *data, size_t count)
> +{
> +       struct ssd130x_spi_transport *t = context;
> +       struct spi_device *spi = t->spi;
> +       const u8 *reg = data;
> +
> +       if (*reg == SSD130X_COMMAND)
> +               gpiod_set_value_cansleep(t->dc, 0);
> +
> +       if (*reg == SSD130X_DATA)
> +               gpiod_set_value_cansleep(t->dc, 1);
> +
> +       /* Remove the control byte since is not used by the 4-wire SPI */
> +       return spi_write(spi, ((u8 *)data) + 1, count - 1);

As I don't like casts, perhaps

    spi_write(spi, reg + 1, count - 1);

? But this is up to you.

> +/*
> + * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
> + * if the device was registered via OF. This means that the module will not be
> + * auto loaded, unless it contains an alias that matches the MODALIAS reported.
> + *
> + * To workaround this issue, add a SPI device ID table. Even when this should
> + * not be needed for this driver to match the registered SPI devices.
> + */
> +static const struct spi_device_id ssd130x_spi_table[] = {
> +       { "sh1106",  SH1106_ID },
> +       { "ssd1305", SSD1305_ID },
> +       { "ssd1306", SSD1306_ID },
> +       { "ssd1307", SSD1307_ID },
> +       { "ssd1309", SSD1309_ID },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);

I'm not sure about the need for this part, but as Mark provided his
Ac-ed--by, I assume it's correct.

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
