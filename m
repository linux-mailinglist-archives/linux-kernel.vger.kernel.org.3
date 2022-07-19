Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5802B5795F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiGSJRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiGSJQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:16:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8211FCD5;
        Tue, 19 Jul 2022 02:16:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a11so2452988wmq.3;
        Tue, 19 Jul 2022 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ShvBiJr0BZJfpA9PYReWbsNqbMYlBcd8mzCHrClNfB4=;
        b=BtxOzPmJyaKHd9GzBauBw4Vcljgijat/iKk7rKJHlX519L6FzOG5J50F15jzvut43/
         BrG18tpwsINRNTksxIaqwvAjsqBLiiqh9hyOzDIzzdn+Vxz9QCLD2amGsnSwh+v5xatD
         poypHGevEGqCMA9h5STD0nGD5o3qcwyqGn7pt95Gz8X7n0c6S9pBkss7laSZJMJ6WCMV
         r5hzg1hZHGyxdYcyf3ou5FbhE9O0Mgg6DDebaPuDm9ejQul8R3v+p4AFBDdDmReMVHRZ
         5zhhEopdgW7jlLaNR7DBVq4eSyXixebFKHYA7ksgSFRUDxoLSGiiogPTi0PcqoUPv1ZC
         FzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ShvBiJr0BZJfpA9PYReWbsNqbMYlBcd8mzCHrClNfB4=;
        b=QLc3FTFH/M0gTcoe/SNZCOjYe3LGsm8Qcvg5GHC0PW7MDCnsMIOA2yEh4Eoztc9evw
         gYIjAemphlIAmQXQBqf4q+fPiX/eopAGSzE0PRBxMhACQCP7ieTxQ/6WYvb6Ht3lj3ju
         yTWTbcW7MgWOSAyvAEfUAbJrcyrBo3Zg/2YVKKWQumqEU1i5lZhk9InSaLrBsl3QCF1f
         HBUap22wbx96HsuyfMzappf9o3pw9EOyaYZvM2QX2r192U3Plgg8Ea/Mp+CtcKIcnZpV
         tkSHsugRfrjjkOnxK2ZeG8fsgiu/6Zc7ETmUmejpSk6SteSZ1kMqyxY9yr6BLlmObvO5
         Q0qg==
X-Gm-Message-State: AJIora/FqdnsrPqD/gxa06dAeXB72+hUDR+eRsyjpMH5dLwvNbxHezO5
        MhAEqx4KRvcTQxfXLG7K9lI=
X-Google-Smtp-Source: AGRyM1u82ew6ZpG3h5iWR9v9gBcedw0bV/Azh/3nuCKXCKHDJiF5kCVvKh/q87Uld1zgP3I9l6PEUg==
X-Received: by 2002:a05:600c:4e90:b0:3a0:57d6:4458 with SMTP id f16-20020a05600c4e9000b003a057d64458mr30018400wmq.198.1658222211140;
        Tue, 19 Jul 2022 02:16:51 -0700 (PDT)
Received: from [192.168.1.126] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id m24-20020a056000181800b0021d68e1fd42sm12974741wrh.89.2022.07.19.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:16:50 -0700 (PDT)
Message-ID: <4ffb757f64fdc2412af37a17242e3bac766aba94.camel@gmail.com>
Subject: Re: [PATCH v3 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 11:16:49 +0200
In-Reply-To: <20220717160802.7690cafe@jic23-huawei>
References: <20220710091837.16057-1-ang.iglesiasg@gmail.com>
         <20220717160802.7690cafe@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On dom, 2022-07-17 at 16:08 +0100, Jonathan Cameron wrote:
> On Sun, 10 Jul 2022 11:18:31 +0200
> Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> 
> > Adds compatibility with the new generation of this sensor, the BMP380
> > 
> > Includes basic sensor initialization to do pressure and temp
> > measurements and allows tuning oversampling settings for each channel.
> > 
> > The compensation algorithms are adapted from the device datasheet and
> > the repository https://github.com/BoschSensortec/BMP3-Sensor-API
> > 
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com> 
> Say what was reported with # whatever
> , or drop these tags.  The message asking you to add them is applicable to
> patches that are fixing things upstream.  Adding them here implies that the
> whole patch is a fix that was reported by the bots.
> 
> One thing I'd previously missed in here is you are doing regmap_bulk_*
> accesses.  Those should be using dma safe buffer. Look for IIO_DMA_MINALIGN
> in the current IIO togreg branch.
> You can't safely use buffers on the stack.
> 
> Otherwise, looks pretty good to me.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c   | 356 +++++++++++++++++++++++++++
> >  drivers/iio/pressure/bmp280-i2c.c    |   5 +
> >  drivers/iio/pressure/bmp280-regmap.c |  55 +++++
> >  drivers/iio/pressure/bmp280-spi.c    |   5 +
> >  drivers/iio/pressure/bmp280.h        | 101 ++++++++
> >  5 files changed, 522 insertions(+)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c
> > b/drivers/iio/pressure/bmp280-core.c
> > index 59e9c5fb4ab4..5d5d20d97cf6 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -12,10 +12,13 @@
> >   *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
> >   *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
> >   *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
> > + *
> > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
> >   */
> >  
> >  #define pr_fmt(fmt) "bmp280: " fmt
> >  
> > +#include <linux/bitops.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> > @@ -29,6 +32,7 @@
> >  #include <linux/completion.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/random.h>
> > +#include <asm/unaligned.h>
> >  
> >  #include "bmp280.h"
> >  
> > @@ -74,6 +78,24 @@ struct bmp280_calib {
> >         s8  H6;
> >  };
> >  
> > +/* See datasheet Section 3.11.1. */
> > +struct bmp380_calib {
> > +       u16 T1;
> > +       u16 T2;
> > +       s8  T3;
> > +       s16 P1;
> > +       s16 P2;
> > +       s8  P3;
> > +       s8  P4;
> > +       u16 P5;
> > +       u16 P6;
> > +       s8  P7;
> > +       s8  P8;
> > +       s16 P9;
> > +       s8  P10;
> > +       s8  P11;
> > +};
> > +
> >  static const char *const bmp280_supply_names[] = {
> >         "vddd", "vdda"
> >  };
> > @@ -90,6 +112,7 @@ struct bmp280_data {
> >         union {
> >                 struct bmp180_calib bmp180;
> >                 struct bmp280_calib bmp280;
> > +               struct bmp380_calib bmp380;
> >         } calib;
> >         struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
> >         unsigned int start_up_time; /* in microseconds */
> > @@ -138,6 +161,25 @@ struct bmp280_chip_info {
> >  enum { T1, T2, T3 };
> >  enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
> >  
> > +enum {
> > +       /* Temperature calib indexes */
> > +       BMP380_T1 = 0,
> > +       BMP380_T2 = 2,
> > +       BMP380_T3 = 4,
> > +       /* Pressure calib indexes */
> > +       BMP380_P1 = 5,
> > +       BMP380_P2 = 7,
> > +       BMP380_P3 = 9,
> > +       BMP380_P4 = 10,
> > +       BMP380_P5 = 11,
> > +       BMP380_P6 = 13,
> > +       BMP380_P7 = 15,
> > +       BMP380_P8 = 16,
> > +       BMP380_P9 = 17,
> > +       BMP380_P10 = 19,
> > +       BMP380_P11 = 20
> > +};
> > +
> >  static const struct iio_chan_spec bmp280_channels[] = {
> >         {
> >                 .type = IIO_PRESSURE,
> > @@ -708,6 +750,310 @@ static const struct bmp280_chip_info bme280_chip_info
> > = {
> >         .read_calib = bmp280_read_calib,
> >  };
> >  
> > +/* Send a command to BMP3XX sensors */
> > +static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
> > +{
> > +       int ret;
> > +       unsigned int reg;
> > +
> > +       /* check if device is ready to process a command */
> > +       ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> > +       if (ret) {
> > +               dev_err(data->dev, "failed to read error register\n");
> > +               return ret;
> > +       }
> > +       if (!(reg & BMP380_STATUS_CMD_RDY_MASK)) {
> > +               dev_err(data->dev, "device is not ready to accept
> > commands\n");
> > +               return -EBUSY;
> > +       }
> > +
> > +       /* send command to process */
> > +       ret = regmap_write(data->regmap, BMP380_REG_CMD, cmd);
> > +       if (ret) {
> > +               dev_err(data->dev, "failed to send command to device\n");
> > +               return ret;
> > +       }
> > +       /* wait for 2ms for command to be proccessed */
> > +       usleep_range(data->start_up_time, data->start_up_time + 100);
> > +       /* check for command processing error */
> > +       ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
> > +       if (ret) {
> > +               dev_err(data->dev, "error reading ERROR reg\n");
> > +               return ret;
> > +       }
> > +       if (reg & BMP380_ERR_CMD_MASK) {
> > +               dev_err(data->dev, "error processing command 0x%X\n", cmd);
> > +               return -EINVAL;
> > +       }
> > +       dev_dbg(data->dev, "Command 0x%X proccessed successfully\n", cmd);
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
> > + * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
> > + * value.
> > + *
> > + * Taken from datasheet, Section Appendix 9, "Compensation formula" and
> > repo
> > + * https://github.com/BoschSensortec/BMP3-Sensor-API
> > + */
> > +static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> > +{
> > +       s64 var1, var2, var3, var4, var5, var6, comp_temp;
> > +       struct bmp380_calib *calib = &data->calib.bmp380;
> > +
> > +       var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
> > +       var2 = var1 * ((s64) calib->T2);
> > +       var3 = var1 * var1;
> > +       var4 = var3 * ((s64) calib->T3);
> > +       var5 = (var2 << 18) + var4;
> > +       var6 = var5 >> 32;
> > +       data->t_fine = (s32) var6;
> > +       comp_temp = (var6 * 25) >> 14;
> > +
> > +       comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
> > +       return (s32) comp_temp;
> > +}
> > +
> > +/*
> > + * Returns pressure in Pa as unsigned 32 bit integer in fractional Pascal.
> > + * Output value of "9528709" represents 9528709/100 = 95287.09 Pa =
> > 952.8709 hPa
> > + *
> > + * Taken from datasheet, Section 9.3. "Pressure compensation" and
> > repository
> > + * https://github.com/BoschSensortec/BMP3-Sensor-API
> > + */
> > +static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
> > +{
> > +       s64 var1, var2, var3, var4, var5, var6, offset, sensitivity;
> > +       u64 comp_press;
> > +       struct bmp380_calib *calib = &data->calib.bmp380;
> > +
> > +       var1 = ((s64)data->t_fine) * ((s64)data->t_fine);
> > +       var2 = var1 >> 6;
> > +       var3 = (var2 * ((s64) data->t_fine)) >> 8;
> > +       var4 = (((s64)calib->P8) * var3) >> 5;
> > +       var5 = (((s64) calib->P7) * var1) << 4;
> > +       var6 = (((s64) calib->P6) * ((s64)data->t_fine)) << 22;
> > +       offset = (((s64)calib->P5) << 47) + var4 + var5 + var6;
> > +       var2 = (((s64)calib->P4) * var3) >> 5;
> > +       var4 = (((s64) calib->P3) * var1) << 2;
> > +       var5 = (((s64) calib->P2) - ((s64) 1<<14)) *
> > +               (((s64)data->t_fine) << 21);
> > +       sensitivity = ((((s64) calib->P1) - ((s64) 1 << 14)) << 46) +
> > +                       var2 + var4 + var5;
> > +       var1 = (sensitivity >> 24) * ((s64)adc_press);
> > +       var2 = ((s64)calib->P10) * ((s64) data->t_fine);
> > +       var3 = var2 + (((s64) calib->P9) << 16);
> > +       var4 = (var3 * ((s64)adc_press)) >> 13;
> > +
> > +       /*
> > +        * Dividing by 10 followed by multiplying by 10 to avoid
> > +        * possible overflow caused by (uncomp_data->pressure *
> > partial_data4)
> > +        */
> > +       var5 = (((s64)adc_press) * (var4 / 10)) >> 9;
> > +       var5 *= 10;
> > +       var6 = ((s64)adc_press) * ((s64)adc_press);
> > +       var2 = (((s64)calib->P11) * var6) >> 16;
> > +       var3 = (var2 * ((s64)adc_press)) >> 7;
> > +       var4 = (offset >> 2) + var1 + var5 + var3;
> > +       comp_press = ((u64)var4 * 25) >> 40;
> > +
> > +       comp_press = clamp_val(comp_press, BMP380_MIN_PRES,
> > BMP380_MAX_PRES);
> > +       return (u32)comp_press;
> > +}
> > +
> > +static int bmp380_read_temp(struct bmp280_data *data, int *val)
> > +{
> > +       int ret;
> > +       u8 tmp[3];
> > +       u32 adc_temp;
> > +       s32 comp_temp;
> > +
> > +       ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB, tmp, 3);
> As below.
> > +       if (ret < 0) {
> > +               dev_err(data->dev, "failed to read temperature\n");
> > +               return ret;
> > +       }
> > +
> > +       adc_temp = get_unaligned_le24(tmp);
> > +       if (adc_temp == BMP380_TEMP_SKIPPED) {
> > +               /* reading was skipped */
> > +               dev_err(data->dev, "reading temperature skipped\n");
> > +               return -EIO;
> > +       }
> > +       comp_temp = bmp380_compensate_temp(data, adc_temp);
> > +
> > +       /*
> > +        * val might be NULL if we're called by the read_press routine,
> > +        * who only cares about the carry over t_fine value.
> > +        */
> > +       if (val) {
> > +               /* IIO reports temperatures in mC */
> > +               *val = comp_temp * 10;
> > +               return IIO_VAL_INT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
> > +{
> > +       int ret;
> > +       u8 tmp[3];
> > +       u32 adc_press;
> > +       s32 comp_press;
> > +
> > +       /* Read and compensate temperature so we get a reading of t_fine. */
> > +       ret = bmp380_read_temp(data, NULL);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB, tmp, 3);
> 
> As below, buffer should be DMA safe.
> 
> > +       if (ret < 0) {
> > +               dev_err(data->dev, "failed to read pressure\n");
> > +               return ret;
> > +       }
> > +
> > +       adc_press = get_unaligned_le24(tmp);
> > +       if (adc_press == BMP380_PRESS_SKIPPED) {
> > +               /* reading was skipped */
> > +               dev_err(data->dev, "reading pressure skipped\n");
> > +               return -EIO;
> > +       }
> > +       comp_press = bmp380_compensate_press(data, adc_press);
> > +
> > +       *val = comp_press;
> > +       /* Compensated pressure is in cPa (centipascals) */
> > +       *val2 = 100000;
> > +
> > +       return IIO_VAL_FRACTIONAL;
> > +}
> > +
> > +static int bmp380_read_calib(struct bmp280_data *data, unsigned int chip)
> > +{
> > +       int ret;
> > +       struct bmp380_calib *calib = &data->calib.bmp380;
> > +       u8 buf[BMP380_CALIB_REG_COUNT];
> 
> I'd missed this previously but for SPI drivers, we should be providing
> regmap_bulk accesses with DMA safe buffers.  That means they can't be on the
> stack and need to be appropriately aligned IIO_DMA_MINALIGN as part of
> the *data structure.
> 
> Last time I checked the SPI regmap implementation doesn't currently use
> the buffers directly but it has in the past and may do again in the future 
> - hence we should be careful to allow for that.
> 

As we only use this buffer once to store temporally the calibration data to
parse, I would like to avoid adding extra overhead to the device data struct.
I've been consulting on DMA rules and safety, and if I understood correctly
(listed the sources below), it should be safe to use a buffer allocated at
runtime with kmalloc, right?
 * https://elinux.org/images/0/03/20181023-Wolfram-Sang-ELCE18-
   safe_dma_buffers.pdf
 * https://linux-arm-kernel.infradead.narkive.com/vyJqy0RQ/question-devm-
   kmalloc-for-dma

Thanks in advance,
Angel

> > +
> > +       /* Read temperature calibration values. */
> > +       ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START,
> > buf,
> > +                              BMP380_CALIB_REG_COUNT);
> > +       if (ret < 0) {
> > +               dev_err(data->dev,
> > +                       "failed to read temperature calibration
> > parameters\n");
> > +               return ret;
> > +       }
> > +
> > +       /* Toss the temperature calibration data into the entropy pool */
> > +       add_device_randomness(buf, sizeof(buf));
> > +
> > +       /* Parse calibration data */
> > +       calib->T1 = get_unaligned_le16(&buf[BMP380_T1]);
> > +       calib->T2 = get_unaligned_le16(&buf[BMP380_T2]);
> > +       calib->T3 = buf[BMP380_T3];
> > +       calib->P1 = get_unaligned_le16(&buf[BMP380_P1]);
> > +       calib->P2 = get_unaligned_le16(&buf[BMP380_P2]);
> > +       calib->P3 = buf[BMP380_P3];
> > +       calib->P4 = buf[BMP380_P4];
> > +       calib->P5 = get_unaligned_le16(&buf[BMP380_P5]);
> > +       calib->P6 = get_unaligned_le16(&buf[BMP380_P6]);
> > +       calib->P7 = buf[BMP380_P7];
> > +       calib->P8 = buf[BMP380_P8];
> > +       calib->P9 = get_unaligned_le16(&buf[BMP380_P9]);
> > +       calib->P10 = buf[BMP380_P10];
> > +       calib->P11 = buf[BMP380_P11];
> > +
> > +       return 0;
> > +}

