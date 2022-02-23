Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408214C0A01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiBWDLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiBWDL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:11:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F9953E33
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:11:01 -0800 (PST)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B87C3F1B6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645585860;
        bh=7Q1qJ9Pfx7Ku4H3hFgD/kJyjwtmDcZ5E96SpjSPCl9c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pPKZd1QK3K80i7nQRMInypWc7sBLYTiG0aUaQuwNj1hSfC+VZBRE8gXqE6CO4Z7xc
         dZgJB9hH4ZOtmtsAcX+or75xajix2avOVTj9NcSjRfJutRWUsSZkAVekRD3bHJyUf7
         /TZ3tEr9i73Cy08MhxZbAlAErU+wuT32AoxGtxXn5OSmSVBMrpa+rFi8mCeGw5H/A8
         j2eRiqLVtzLtrHWj5l0CEATK+F2+pp4VEh1TkCAYtrWWh55FLGBv4yg1elx4m6qMWN
         qdC9BZBIS2zwFqTbbl7ngatcSmj8n3OTZ/6agduRgTfi32gu9njGd5nmxf3w2itiMZ
         z0wcADwKk2i1w==
Received: by mail-ot1-f70.google.com with SMTP id 88-20020a9d0f61000000b005ad1fe3c347so10574533ott.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Q1qJ9Pfx7Ku4H3hFgD/kJyjwtmDcZ5E96SpjSPCl9c=;
        b=gVt5b1fSsKKnydBdkxIMXF1a8AliyO8pSxP1/OCLHG+HDvBv5PkN/lRLidQ9hMsE2r
         YrhFnacg2iqrqptJl/6skCguM55Y79ak4BCklJYJtt1Ncup6NL/0bWTEKl8ZfS9RK7Vf
         zxA2bbTDaR+awdk/pvOF7no8ZSDHqaN5elc3D3+//aL8H5SoPvUOA3dH1EzO/XoxaGIa
         IFUa3fFIQB+ScDluoCHOIcMYRCvHgl5rmoqLIGnGrbIreZIcNg2Xlh2ANJ8qeUeF6zhp
         8w+eYJWgwP3PLosO1admokIf1ctuOZIaeUsvvUXzNrBDS4dwsmOPKsVf4l0hKrKNVW4q
         HZLw==
X-Gm-Message-State: AOAM533ElkfrjGKqtEageWel7pahc0jDmhjcs8XZKLgJFM2lj2PoKpJo
        fIRvi6hnd8kQM8nzKIaOI7x/z+8u5qFf2YBnoqFiaus5EicqfFdur7pQ/EOApRaGoM4k0HYu538
        UYHx/w6XYpdg6gT2DSo9c+b5qZDclom9Ymcbr2/ZDqWZOouFg4OVrn7Talg==
X-Received: by 2002:a05:6808:2110:b0:2d4:4137:b4fc with SMTP id r16-20020a056808211000b002d44137b4fcmr3735325oiw.111.1645585859076;
        Tue, 22 Feb 2022 19:10:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpWBcNcPhRbtOhXgOZnzEqnmru/8cLKymulPlM/BRdSjbj8OVCCoMJ15KE/rOa80SJf6aqIsf2k2u/+hLf0Pk=
X-Received: by 2002:a05:6808:2110:b0:2d4:4137:b4fc with SMTP id
 r16-20020a056808211000b002d44137b4fcmr3735314oiw.111.1645585858753; Tue, 22
 Feb 2022 19:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 23 Feb 2022 11:10:47 +0800
Message-ID: <CAAd53p7sZL4ppWoXfeM8=N_ucjMUs3vv6-LoyLX4-beYE30fSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] iio: accel: adxl345: Convert to use dev_err_probe()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 4:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It's fine to call dev_err_probe() in ->probe() when error code is known.
> Convert the driver to use dev_err_probe().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested on ACPI based platform. Hence, for the whole series,

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
> v2: fixed typo (LKP), shorten one line to satisfy checkpatch
>  drivers/iio/accel/adxl345_core.c | 26 +++++++++-----------------
>  drivers/iio/accel/adxl345_i2c.c  |  7 ++-----
>  drivers/iio/accel/adxl345_spi.c  | 15 +++++----------
>  3 files changed, 16 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index ef2240e356e0..078e1029e49d 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -222,16 +222,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>         int ret;
>
>         ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
> -       if (ret < 0) {
> -               dev_err(dev, "Error reading device ID: %d\n", ret);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Error reading device ID\n");
>
> -       if (regval != ADXL345_DEVID) {
> -               dev_err(dev, "Invalid device ID: %x, expected %x\n",
> -                       regval, ADXL345_DEVID);
> -               return -ENODEV;
> -       }
> +       if (regval != ADXL345_DEVID)
> +               return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
> +                                    regval, ADXL345_DEVID);
>
>         indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>         if (!indio_dev)
> @@ -245,10 +241,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>
>         ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
>                            data->data_range);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set data range: %d\n", ret);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Failed to set data range\n");
>
>         indio_dev->name = name;
>         indio_dev->info = &adxl345_info;
> @@ -259,10 +253,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>         /* Enable measurement mode */
>         ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
>                            ADXL345_POWER_CTL_MEASURE);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to enable measurement mode: %d\n", ret);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
>
>         ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
>         if (ret < 0)
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 7bc8324c4f07..e3205dce91b8 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -28,11 +28,8 @@ static int adxl345_i2c_probe(struct i2c_client *client,
>                 return -ENODEV;
>
>         regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
> -       if (IS_ERR(regmap)) {
> -               dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> -                       PTR_ERR(regmap));
> -               return PTR_ERR(regmap);
> -       }
> +       if (IS_ERR(regmap))
> +               return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>
>         return adxl345_core_probe(&client->dev, regmap, id->driver_data,
>                                   id->name);
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index c752562c5d3b..9223302fdd46 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -26,18 +26,13 @@ static int adxl345_spi_probe(struct spi_device *spi)
>         struct regmap *regmap;
>
>         /* Bail out if max_speed_hz exceeds 5 MHz */
> -       if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ) {
> -               dev_err(&spi->dev, "SPI CLK, %d Hz exceeds 5 MHz\n",
> -                       spi->max_speed_hz);
> -               return -EINVAL;
> -       }
> +       if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
> +               return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d Hz exceeds 5 MHz\n",
> +                                    spi->max_speed_hz);
>
>         regmap = devm_regmap_init_spi(spi, &adxl345_spi_regmap_config);
> -       if (IS_ERR(regmap)) {
> -               dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> -                       PTR_ERR(regmap));
> -               return PTR_ERR(regmap);
> -       }
> +       if (IS_ERR(regmap))
> +               return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>
>         return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
>  }
> --
> 2.34.1
>
