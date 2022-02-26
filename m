Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5882A4C57C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiBZTGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBZTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:06:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31F673C0;
        Sat, 26 Feb 2022 11:05:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32A15B80B11;
        Sat, 26 Feb 2022 19:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCADC340E8;
        Sat, 26 Feb 2022 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645902327;
        bh=YFpBY9wDvTHmMS1Zc9n4J3oJYs4cbW7dQDrp/3OLfUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a+VwuvCRmM0XTjrQqhS9MkUdCnCBPHIY1COV8/K1rb+Zgct7DHo4uu5MHoTd58+tj
         DALaQVmIScYzZKWlbqOikswSXmt4XodqNQXfqai36bzPHuNRHU+jCtUGardZLIbfTv
         zs3Um0Ijf7vpPw6NqJaXhlKx5AgHb9MB+aB6eUIaXyBvhzIxx6RZgFZAb7FGQMx2vy
         W926gYg+OZR0U1n/t+UESLQ/VpdkMgN6DtmeEyeigSrPsV3iv+Rcf2zBsJqRsO2aYm
         fextJnJMfWrPGml2iPvFP9uPNYjE3p1AH1/yoSf/WapPu7TxpIuArUVeE/9GfGpdMl
         wHUCmoblHBkeA==
Date:   Sat, 26 Feb 2022 19:12:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 1/8] iio: accel: adxl345: Convert to use
 dev_err_probe()
Message-ID: <20220226191228.2d0eca14@jic23-huawei>
In-Reply-To: <CAAd53p7sZL4ppWoXfeM8=N_ucjMUs3vv6-LoyLX4-beYE30fSQ@mail.gmail.com>
References: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
        <CAAd53p7sZL4ppWoXfeM8=N_ucjMUs3vv6-LoyLX4-beYE30fSQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 11:10:47 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> On Tue, Feb 22, 2022 at 4:59 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > It's fine to call dev_err_probe() in ->probe() when error code is known.
> > Convert the driver to use dev_err_probe().
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> Tested on ACPI based platform. Hence, for the whole series,
> 
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Series applied to the togreg branch of iio.git and pushed out as testing
to let 0-day see if it can find anything we missed.

Thanks,

Jonathan

> 
> > ---
> > v2: fixed typo (LKP), shorten one line to satisfy checkpatch
> >  drivers/iio/accel/adxl345_core.c | 26 +++++++++-----------------
> >  drivers/iio/accel/adxl345_i2c.c  |  7 ++-----
> >  drivers/iio/accel/adxl345_spi.c  | 15 +++++----------
> >  3 files changed, 16 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> > index ef2240e356e0..078e1029e49d 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -222,16 +222,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> >         int ret;
> >
> >         ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
> > -       if (ret < 0) {
> > -               dev_err(dev, "Error reading device ID: %d\n", ret);
> > -               return ret;
> > -       }
> > +       if (ret < 0)
> > +               return dev_err_probe(dev, ret, "Error reading device ID\n");
> >
> > -       if (regval != ADXL345_DEVID) {
> > -               dev_err(dev, "Invalid device ID: %x, expected %x\n",
> > -                       regval, ADXL345_DEVID);
> > -               return -ENODEV;
> > -       }
> > +       if (regval != ADXL345_DEVID)
> > +               return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
> > +                                    regval, ADXL345_DEVID);
> >
> >         indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> >         if (!indio_dev)
> > @@ -245,10 +241,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> >
> >         ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> >                            data->data_range);
> > -       if (ret < 0) {
> > -               dev_err(dev, "Failed to set data range: %d\n", ret);
> > -               return ret;
> > -       }
> > +       if (ret < 0)
> > +               return dev_err_probe(dev, ret, "Failed to set data range\n");
> >
> >         indio_dev->name = name;
> >         indio_dev->info = &adxl345_info;
> > @@ -259,10 +253,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> >         /* Enable measurement mode */
> >         ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> >                            ADXL345_POWER_CTL_MEASURE);
> > -       if (ret < 0) {
> > -               dev_err(dev, "Failed to enable measurement mode: %d\n", ret);
> > -               return ret;
> > -       }
> > +       if (ret < 0)
> > +               return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
> >
> >         ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
> >         if (ret < 0)
> > diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> > index 7bc8324c4f07..e3205dce91b8 100644
> > --- a/drivers/iio/accel/adxl345_i2c.c
> > +++ b/drivers/iio/accel/adxl345_i2c.c
> > @@ -28,11 +28,8 @@ static int adxl345_i2c_probe(struct i2c_client *client,
> >                 return -ENODEV;
> >
> >         regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
> > -       if (IS_ERR(regmap)) {
> > -               dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> > -                       PTR_ERR(regmap));
> > -               return PTR_ERR(regmap);
> > -       }
> > +       if (IS_ERR(regmap))
> > +               return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
> >
> >         return adxl345_core_probe(&client->dev, regmap, id->driver_data,
> >                                   id->name);
> > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> > index c752562c5d3b..9223302fdd46 100644
> > --- a/drivers/iio/accel/adxl345_spi.c
> > +++ b/drivers/iio/accel/adxl345_spi.c
> > @@ -26,18 +26,13 @@ static int adxl345_spi_probe(struct spi_device *spi)
> >         struct regmap *regmap;
> >
> >         /* Bail out if max_speed_hz exceeds 5 MHz */
> > -       if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ) {
> > -               dev_err(&spi->dev, "SPI CLK, %d Hz exceeds 5 MHz\n",
> > -                       spi->max_speed_hz);
> > -               return -EINVAL;
> > -       }
> > +       if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
> > +               return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d Hz exceeds 5 MHz\n",
> > +                                    spi->max_speed_hz);
> >
> >         regmap = devm_regmap_init_spi(spi, &adxl345_spi_regmap_config);
> > -       if (IS_ERR(regmap)) {
> > -               dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> > -                       PTR_ERR(regmap));
> > -               return PTR_ERR(regmap);
> > -       }
> > +       if (IS_ERR(regmap))
> > +               return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
> >
> >         return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
> >  }
> > --
> > 2.34.1
> >  

