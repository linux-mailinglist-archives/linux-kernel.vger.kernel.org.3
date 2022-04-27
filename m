Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E355117A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiD0MjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiD0Mir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:38:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6043D48A;
        Wed, 27 Apr 2022 05:35:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kq17so3128724ejb.4;
        Wed, 27 Apr 2022 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEtwECq38nYRyfITY3UIJzQGx4SloOcHex4sI8pDGK8=;
        b=D6dkGyAmnmDWsov+jU2cho0/U0CBDWFjzyv2TTUGtsGrSzSGl0MtIzBsGDagelRVdW
         WbDCqe7Ox/YdDOzwosSL+87/NXaPlPkqx+W1qvTmLGxmgrm2oxXvZrYpolbEbpZCWyZG
         6hDbJVlAS/jY2ymJYcYz8Ig8HkehOc4CxdNiH8bw1xKTSFB6atwXCm7EW3T0+cIeaSgf
         sION0ljHf1RK1B4THC6eP/VFNHIF6cXILhNBfSbzfVNnhz+Iy4vKaZpiUFWWqNcpDzw1
         BKCSXOyGx3EoSAHUj4Rwt2Q8+YnciX7/5TUQ/3ieLAvSLrBoa9BN3lsIUvdtkGzyPrbb
         GL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEtwECq38nYRyfITY3UIJzQGx4SloOcHex4sI8pDGK8=;
        b=H04FPQHOqc4PVjYClpO2uaNxHkbDkwb0LnWp2BirnkmugxgdXU4PZdJLVtE4kj1YgE
         vGdQ4w4lpjQz/94VQexzt9yAAZebCzA1tVnvjT1wunzHgNhpvdR0YJ/hwagspB1k0QBJ
         i3Sxv1ME6HTShvD3C+vxPaHvvrUuNX+wdwi00oBtMbreRKgKPunSj331GtQfLBS3Jaft
         uljDOT9czRT59c+CD1D7/iSEPAfu9t2qk7Bant71TvsPk70vOXCOGjea3OWIfoEoht7U
         qO6boB0i7jf9QKxMOF2Y204uek9rVqxdNse9iXIA0HCO5esIfwhuLxi72x9oHulP3sFt
         rmLQ==
X-Gm-Message-State: AOAM5321ZkKPeuV9ZolAZLI5pYOyiBJlSa/1q81MoIDt0frd7dWO1WgE
        9wIrVKJQ4eyYAb6xbaKdAKUHmX1JBqkA8i4TZVXDgosf7kIavjin
X-Google-Smtp-Source: ABdhPJwQUCCD6rszL/RzgM9jE6+191e1/Xrsg9Q/Eu0n9Y+x+ASwRpGp6wamtFhwUBL/15gnDGno2boQ2p3VpCpXJWs=
X-Received: by 2002:a17:906:3799:b0:6ec:d25:3afe with SMTP id
 n25-20020a170906379900b006ec0d253afemr26457664ejc.44.1651062933392; Wed, 27
 Apr 2022 05:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com> <20220420211105.14654-5-jagathjog1996@gmail.com>
In-Reply-To: <20220420211105.14654-5-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 14:34:57 +0200
Message-ID: <CAHp75Vf5pS_TGm5ptN7TyNmhZe_Oz8pVmETT27VeC=BZk9+ezg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] iio: accel: bma400: Add triggered buffer support
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Added trigger buffer support to read continuous acceleration
> data from device with data ready interrupt which is mapped
> to INT1 pin.

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/Kconfig       |   2 +
>  drivers/iio/accel/bma400.h      |  10 +-
>  drivers/iio/accel/bma400_core.c | 162 +++++++++++++++++++++++++++++++-
>  drivers/iio/accel/bma400_i2c.c  |   2 +-
>  drivers/iio/accel/bma400_spi.c  |   2 +-
>  5 files changed, 170 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index eac3f02662ae..958097814232 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -204,6 +204,8 @@ config BMA220
>  config BMA400
>         tristate "Bosch BMA400 3-Axis Accelerometer Driver"
>         select REGMAP
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
>         select BMA400_I2C if I2C
>         select BMA400_SPI if SPI
>         help
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 1c8c47a9a317..907e1a6c0a38 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -62,6 +62,13 @@
>  #define BMA400_ACC_CONFIG2_REG      0x1b
>  #define BMA400_CMD_REG              0x7e
>
> +/* Interrupt registers */
> +#define BMA400_INT_CONFIG0_REG     0x1f
> +#define BMA400_INT_CONFIG1_REG     0x20
> +#define BMA400_INT1_MAP_REG        0x21
> +#define BMA400_INT_IO_CTRL_REG     0x24
> +#define BMA400_INT_DRDY_MSK        BIT(7)
> +
>  /* Chip ID of BMA 400 devices found in the chip ID register. */
>  #define BMA400_ID_REG_VAL           0x90
>
> @@ -111,6 +118,7 @@
>
>  extern const struct regmap_config bma400_regmap_config;
>
> -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
> +int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
> +                const char *name);
>
>  #endif
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 07674d89d978..57910ccf9180 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -11,6 +11,7 @@
>   *  - Create channel for sensor time
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -20,6 +21,10 @@
>  #include <linux/regulator/consumer.h>
>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>
>  #include "bma400.h"
>
> @@ -61,6 +66,14 @@ struct bma400_data {
>         struct bma400_sample_freq sample_freq;
>         int oversampling_ratio;
>         int scale;
> +       struct iio_trigger *trig;
> +       /* Correct time stamp alignment */
> +       struct {
> +               __le16 buff[3];
> +               u8 temperature;
> +               s64 ts __aligned(8);
> +       } buffer ____cacheline_aligned;
> +       __le16 status;
>  };
>
>  static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
> @@ -152,7 +165,7 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
>         { }
>  };
>
> -#define BMA400_ACC_CHANNEL(_axis) { \
> +#define BMA400_ACC_CHANNEL(_index, _axis) { \
>         .type = IIO_ACCEL, \
>         .modified = 1, \
>         .channel2 = IIO_MOD_##_axis, \
> @@ -164,17 +177,32 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
>                 BIT(IIO_CHAN_INFO_SCALE) | \
>                 BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>         .ext_info = bma400_ext_info, \
> +       .scan_index = _index,   \
> +       .scan_type = {          \
> +               .sign = 's',    \
> +               .realbits = 12,         \
> +               .storagebits = 16,      \
> +               .endianness = IIO_LE,   \
> +       },                              \
>  }
>
>  static const struct iio_chan_spec bma400_channels[] = {
> -       BMA400_ACC_CHANNEL(X),
> -       BMA400_ACC_CHANNEL(Y),
> -       BMA400_ACC_CHANNEL(Z),
> +       BMA400_ACC_CHANNEL(0, X),
> +       BMA400_ACC_CHANNEL(1, Y),
> +       BMA400_ACC_CHANNEL(2, Z),
>         {
>                 .type = IIO_TEMP,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>                 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +               .scan_index = 3,
> +               .scan_type = {
> +                       .sign = 's',
> +                       .realbits = 8,
> +                       .storagebits = 8,
> +                       .endianness = IIO_LE,
> +               },
>         },
> +       IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>
>  static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
> @@ -659,6 +687,10 @@ static int bma400_init(struct bma400_data *data)
>         if (ret)
>                 return ret;
>
> +       /* Configure INT1 pin to open drain */
> +       ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x06);
> +       if (ret)
> +               return ret;
>         /*
>          * Once the interrupt engine is supported we might use the
>          * data_src_reg, but for now ensure this is set to the
> @@ -807,6 +839,29 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
>         }
>  }
>
> +static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +                                            bool state)
> +{
> +       struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +       struct bma400_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> +                                BMA400_INT_DRDY_MSK,
> +                                FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +       if (ret)
> +               return ret;
> +
> +       return regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> +                                 BMA400_INT_DRDY_MSK,
> +                                 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +}
> +
> +static const unsigned long bma400_avail_scan_masks[] = {
> +       GENMASK(3, 0),
> +       0
> +};
> +
>  static const struct iio_info bma400_info = {
>         .read_raw          = bma400_read_raw,
>         .read_avail        = bma400_read_avail,
> @@ -814,7 +869,72 @@ static const struct iio_info bma400_info = {
>         .write_raw_get_fmt = bma400_write_raw_get_fmt,
>  };
>
> -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
> +static const struct iio_trigger_ops bma400_trigger_ops = {
> +       .set_trigger_state = &bma400_data_rdy_trigger_set_state,
> +       .validate_device = &iio_trigger_validate_own_device,
> +};
> +
> +static irqreturn_t bma400_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct bma400_data *data = iio_priv(indio_dev);
> +       int ret, temp;
> +
> +       /* Lock to protect the data->buffer */
> +       mutex_lock(&data->mutex);
> +
> +       /* bulk read six registers, with the base being the LSB register */
> +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> +                              &data->buffer.buff, sizeof(data->buffer.buff));
> +       if (ret)
> +               goto unlock_err;
> +
> +       ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
> +       if (ret)
> +               goto unlock_err;
> +
> +       data->buffer.temperature = temp;
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +                                          iio_get_time_ns(indio_dev));
> +
> +       mutex_unlock(&data->mutex);
> +       iio_trigger_notify_done(indio_dev->trig);
> +       return IRQ_HANDLED;
> +
> +unlock_err:
> +       mutex_unlock(&data->mutex);
> +       return IRQ_NONE;
> +}
> +
> +static irqreturn_t bma400_interrupt(int irq, void *private)
> +{
> +       struct iio_dev *indio_dev = private;
> +       struct bma400_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       /* Lock to protect the data->status */
> +       mutex_lock(&data->mutex);
> +       ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG,
> +                              &data->status,
> +                              sizeof(data->status));
> +       if (ret)
> +               goto unlock_err;
> +
> +       if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
> +               mutex_unlock(&data->mutex);
> +               iio_trigger_poll_chained(data->trig);
> +               return IRQ_HANDLED;
> +       }
> +
> +unlock_err:
> +       mutex_unlock(&data->mutex);
> +       return IRQ_NONE;
> +}
> +
> +int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
> +                const char *name)
>  {
>         struct iio_dev *indio_dev;
>         struct bma400_data *data;
> @@ -841,8 +961,40 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
>         indio_dev->info = &bma400_info;
>         indio_dev->channels = bma400_channels;
>         indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
> +       indio_dev->available_scan_masks = bma400_avail_scan_masks;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> +       if (irq > 0) {
> +               data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +                                                   indio_dev->name,
> +                                                   iio_device_id(indio_dev));
> +               if (!data->trig)
> +                       return -ENOMEM;
> +
> +               data->trig->ops = &bma400_trigger_ops;
> +               iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +               ret = devm_iio_trigger_register(data->dev, data->trig);
> +               if (ret)
> +                       return dev_err_probe(data->dev, ret,
> +                                            "iio trigger register fail\n");
> +
> +               indio_dev->trig = iio_trigger_get(data->trig);
> +               ret = devm_request_threaded_irq(dev, irq, NULL,
> +                                               &bma400_interrupt,
> +                                               IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +                                               indio_dev->name, indio_dev);
> +               if (ret)
> +                       return dev_err_probe(data->dev, ret,
> +                                            "request irq %d failed\n", irq);
> +       }
> +
> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +                                             &bma400_trigger_handler, NULL);
> +       if (ret)
> +               return dev_err_probe(data->dev, ret,
> +                                    "iio triggered buffer setup failed\n");
> +
>         return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS(bma400_probe, IIO_BMA400);
> diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
> index 4f6e01a3b3a1..1ba2a982ea73 100644
> --- a/drivers/iio/accel/bma400_i2c.c
> +++ b/drivers/iio/accel/bma400_i2c.c
> @@ -24,7 +24,7 @@ static int bma400_i2c_probe(struct i2c_client *client,
>                 return PTR_ERR(regmap);
>         }
>
> -       return bma400_probe(&client->dev, regmap, id->name);
> +       return bma400_probe(&client->dev, regmap, client->irq, id->name);
>  }
>
>  static const struct i2c_device_id bma400_i2c_ids[] = {
> diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
> index 28e240400a3f..ec13c044b304 100644
> --- a/drivers/iio/accel/bma400_spi.c
> +++ b/drivers/iio/accel/bma400_spi.c
> @@ -84,7 +84,7 @@ static int bma400_spi_probe(struct spi_device *spi)
>         if (ret)
>                 dev_err(&spi->dev, "Failed to read chip id register\n");
>
> -       return bma400_probe(&spi->dev, regmap, id->name);
> +       return bma400_probe(&spi->dev, regmap, spi->irq, id->name);
>  }
>
>  static const struct spi_device_id bma400_spi_ids[] = {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
