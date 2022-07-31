Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC958601A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 19:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiGaRYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaRYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 13:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E0DE97;
        Sun, 31 Jul 2022 10:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61E9960F52;
        Sun, 31 Jul 2022 17:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8881FC433C1;
        Sun, 31 Jul 2022 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659288239;
        bh=QxJhA3XLqGjY6dj9UUns/GgVd9u2bI1FTYVP5CWajuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C7TBaVuwvEc7pmRi8UAc0btyJBn1Rb6riYw3OHQQPHcrEHvn2jG8n3c/nQxnIn/YA
         Fel3j8bQTsms4O9jfHXKJLS0r2jY05mGhSC4AtwGdkr2jHEMAZq5oiTzvK+g8/B1Kz
         puTlFVN6+vTuw/dDZ9CfrMzcOWPbXwRIZcTGJYgVh7phzIoDt2W1fqWOV9hEhL31AN
         WM4RzP6Y8QccRb+EX33O0lEkMK03nI6jy+05MfcMeCQtw01XMqNBFAznR3lbXBZvjn
         sRoG9ZSwn5Z83Ked4ucyAek5I35D0BqIsUpjMVN7nPJDPlWaESA+LeNHhde6PNgOJD
         hjATqFpOG1Gqw==
Date:   Sun, 31 Jul 2022 18:34:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] iio: adc: Add rtq6056 support
Message-ID: <20220731183411.5572c0c6@jic23-huawei>
In-Reply-To: <CADiBU38OGHyAHReKhB7i_p6PUkGE5eCiN_G9_Es-DKtG0Yc71A@mail.gmail.com>
References: <1658242365-27797-1-git-send-email-u0084500@gmail.com>
        <1658242365-27797-3-git-send-email-u0084500@gmail.com>
        <CADiBU38OGHyAHReKhB7i_p6PUkGE5eCiN_G9_Es-DKtG0Yc71A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 11:38:44 +0800
ChiYuan Huang <u0084500@gmail.com> wrote:

> Hi, Jonathan:
>=20
> cy_huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E6=99=9A=E4=B8=8A10:52=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Richtek rtq6056 supporting.
> >
> > It can be used for the system to monitor load current and power with 16=
-bit
> > resolution.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > Since v8
> > - Instead of 'integraion_time' for voltage channel, use per channel sam=
pling
> >   frequency to be more generic. =20
> For the v8 change, is there still anything need to be refined?

Nothing I can see. I was just on vacation so not reading much email ;)

Applied to the togreg branch of iio.git and pushed out as testing for 0-day=
 to
see if it can find anything we missed. Note I'll be rebasing after rc1 is a=
vailable
and won't push the togreg branch out for linux-next to pick up until after =
that.

Thanks,

Jonathan

> >
> > Since v7
> > - Use 'DEFINE_RUNTIME_DEV_PM_OPS' to replace the explicit declaration o=
f pm_ops.
> >
> > Since v6
> > - Remove specific rtq6056 ABI document.
> > - Remove the redundant blank line.
> > - To prevent the race condition for attribute wrtie and shunt resistor =
write,
> >   use 'iio_device_claim_direct_mode' API.
> > - Refine the order for 'action_reset' and 'pm_runtime'.
> > - Fix text typo in comment like as ohm to Ohm and timea to time.
> >
> > Since v5
> > - Fix kernel version text for ABI.
> >
> > Since v4
> > - Add '__aligned(8)' for timestamp member in buffer_trigger_handler fun=
ction.
> > - Declare timestamp from 'int64_t' to more unified 's64'.
> >
> > Since v3
> > - Refine pm_runtime API calling order in 'read_channel' API.
> > - Fix vshunt wrong scale for divider.
> > - Refine the comment text.
> > - Use 'devm_add_action_or_reset' to decrease the code usage in probe
> >   function.
> > - Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
> > - minor fix for the comma.
> > - Use pm_ptr to replace the direct assigned pm_ops.
> >
> > Since v2
> > - Rename file from 'rtq6056-adc' to 'rtq6056'.
> > - Refine the ABI, if generic already defined it, remove it and check th=
e channel
> >   report unit.
> > - Add copyright text.
> > - include the correct header.
> > - change the property parsing name.
> > - To use iio_chan_spec address field.
> > - Refine each channel separate and shared_by_all.
> > - Use pm_runtime and pm_runtime_autosuspend.
> > - Remove the shutdown callback. From the HW suggestion, it's not recomm=
ended to
> >   use battery as the power supply.
> > - Check all scale unit (voltage->mV, current->mA, power->milliWatt).
> > - Use the read_avail to provide the interface for attribute value list.
> > - Add comma for the last element in the const integer array.
> > - Refine each ADC label text.
> > - In read_label callback, replace snprintf to sysfs_emit.
> > ---
> >  drivers/iio/adc/Kconfig   |  15 ++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/rtq6056.c | 661 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 677 insertions(+)
> >  create mode 100644 drivers/iio/adc/rtq6056.c
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 48ace74..caebd1a 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -908,6 +908,21 @@ config ROCKCHIP_SARADC
> >           To compile this driver as a module, choose M here: the
> >           module will be called rockchip_saradc.
> >
> > +config RICHTEK_RTQ6056
> > +       tristate "Richtek RTQ6056 Current and Power Monitor ADC"
> > +       depends on I2C
> > +       select REGMAP_I2C
> > +       select IIO_BUFFER
> > +       select IIO_TRIGGERED_BUFFER
> > +       help
> > +         Say yes here to enable RQT6056 ADC support.
> > +         RTQ6056 is a high accuracy current-sense monitor with I2C and=
 SMBus
> > +         compatible interface, and the device provides full informatio=
n for
> > +         system by reading out the load current and power.
> > +
> > +         This driver can also be built as a module. If so, the module =
will be
> > +         called rtq6056.
> > +
> >  config RZG2L_ADC
> >         tristate "Renesas RZ/G2L ADC driver"
> >         depends on ARCH_RZG2L || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 39d806f..cda7580 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -84,6 +84,7 @@ obj-$(CONFIG_QCOM_PM8XXX_XOADC) +=3D qcom-pm8xxx-xoad=
c.o
> >  obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
> >  obj-$(CONFIG_RN5T618_ADC) +=3D rn5t618-adc.o
> >  obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> > +obj-$(CONFIG_RICHTEK_RTQ6056) +=3D rtq6056.o
> >  obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
> >  obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> >  obj-$(CONFIG_SPEAR_ADC) +=3D spear_adc.o
> > diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
> > new file mode 100644
> > index 00000000..c1b2e8d
> > --- /dev/null
> > +++ b/drivers/iio/adc/rtq6056.c
> > @@ -0,0 +1,661 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022 Richtek Technology Corp.
> > + *
> > + * ChiYuan Huang <cy_huang@richtek.com>
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/types.h>
> > +#include <linux/util_macros.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> > +#define RTQ6056_REG_CONFIG     0x00
> > +#define RTQ6056_REG_SHUNTVOLT  0x01
> > +#define RTQ6056_REG_BUSVOLT    0x02
> > +#define RTQ6056_REG_POWER      0x03
> > +#define RTQ6056_REG_CURRENT    0x04
> > +#define RTQ6056_REG_CALIBRATION        0x05
> > +#define RTQ6056_REG_MASKENABLE 0x06
> > +#define RTQ6056_REG_ALERTLIMIT 0x07
> > +#define RTQ6056_REG_MANUFACTID 0xFE
> > +#define RTQ6056_REG_DIEID      0xFF
> > +
> > +#define RTQ6056_VENDOR_ID      0x1214
> > +#define RTQ6056_DEFAULT_CONFIG 0x4127
> > +#define RTQ6056_CONT_ALLON     7
> > +
> > +enum {
> > +       RTQ6056_CH_VSHUNT =3D 0,
> > +       RTQ6056_CH_VBUS,
> > +       RTQ6056_CH_POWER,
> > +       RTQ6056_CH_CURRENT,
> > +       RTQ6056_MAX_CHANNEL
> > +};
> > +
> > +enum {
> > +       F_OPMODE =3D 0,
> > +       F_VSHUNTCT,
> > +       F_VBUSCT,
> > +       F_AVG,
> > +       F_RESET,
> > +       F_MAX_FIELDS
> > +};
> > +
> > +struct rtq6056_priv {
> > +       struct device *dev;
> > +       struct regmap *regmap;
> > +       struct regmap_field *rm_fields[F_MAX_FIELDS];
> > +       u32 shunt_resistor_uohm;
> > +       int vshuntct_us;
> > +       int vbusct_us;
> > +       int avg_sample;
> > +};
> > +
> > +static const struct reg_field rtq6056_reg_fields[F_MAX_FIELDS] =3D {
> > +       [F_OPMODE] =3D REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
> > +       [F_VSHUNTCT] =3D REG_FIELD(RTQ6056_REG_CONFIG, 3, 5),
> > +       [F_VBUSCT] =3D REG_FIELD(RTQ6056_REG_CONFIG, 6, 8),
> > +       [F_AVG] =3D REG_FIELD(RTQ6056_REG_CONFIG, 9, 11),
> > +       [F_RESET] =3D REG_FIELD(RTQ6056_REG_CONFIG, 15, 15),
> > +};
> > +
> > +static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL=
 + 1] =3D {
> > +       {
> > +               .type =3D IIO_VOLTAGE,
> > +               .indexed =3D 1,
> > +               .channel =3D 0,
> > +               .address =3D RTQ6056_REG_SHUNTVOLT,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                     BIT(IIO_CHAN_INFO_SCALE) |
> > +                                     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +               .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SAM=
P_FREQ),
> > +               .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_OVERSAMP=
LING_RATIO),
> > +               .info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INF=
O_OVERSAMPLING_RATIO),
> > +               .scan_index =3D 0,
> > +               .scan_type =3D {
> > +                       .sign =3D 's',
> > +                       .realbits =3D 16,
> > +                       .storagebits =3D 16,
> > +                       .endianness =3D IIO_CPU,
> > +               },
> > +       },
> > +       {
> > +               .type =3D IIO_VOLTAGE,
> > +               .indexed =3D 1,
> > +               .channel =3D 1,
> > +               .address =3D RTQ6056_REG_BUSVOLT,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                     BIT(IIO_CHAN_INFO_SCALE) |
> > +                                     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +               .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SAM=
P_FREQ),
> > +               .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_OVERSAMP=
LING_RATIO),
> > +               .info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INF=
O_OVERSAMPLING_RATIO),
> > +               .scan_index =3D 1,
> > +               .scan_type =3D {
> > +                       .sign =3D 'u',
> > +                       .realbits =3D 16,
> > +                       .storagebits =3D 16,
> > +                       .endianness =3D IIO_CPU,
> > +               },
> > +       },
> > +       {
> > +               .type =3D IIO_POWER,
> > +               .indexed =3D 1,
> > +               .channel =3D 2,
> > +               .address =3D RTQ6056_REG_POWER,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                     BIT(IIO_CHAN_INFO_SCALE) |
> > +                                     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +               .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_OVERSAMP=
LING_RATIO),
> > +               .info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INF=
O_OVERSAMPLING_RATIO),
> > +               .scan_index =3D 2,
> > +               .scan_type =3D {
> > +                       .sign =3D 'u',
> > +                       .realbits =3D 16,
> > +                       .storagebits =3D 16,
> > +                       .endianness =3D IIO_CPU,
> > +               },
> > +       },
> > +       {
> > +               .type =3D IIO_CURRENT,
> > +               .indexed =3D 1,
> > +               .channel =3D 3,
> > +               .address =3D RTQ6056_REG_CURRENT,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +               .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_OVERSAMP=
LING_RATIO),
> > +               .info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INF=
O_OVERSAMPLING_RATIO),
> > +               .scan_index =3D 3,
> > +               .scan_type =3D {
> > +                       .sign =3D 's',
> > +                       .realbits =3D 16,
> > +                       .storagebits =3D 16,
> > +                       .endianness =3D IIO_CPU,
> > +               },
> > +       },
> > +       IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL),
> > +};
> > +
> > +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> > +                                   struct iio_chan_spec const *ch,
> > +                                   int *val)
> > +{
> > +       struct device *dev =3D priv->dev;
> > +       unsigned int addr =3D ch->address;
> > +       unsigned int regval;
> > +       int ret;
> > +
> > +       pm_runtime_get_sync(dev);
> > +       ret =3D regmap_read(priv->regmap, addr, &regval);
> > +       pm_runtime_mark_last_busy(dev);
> > +       pm_runtime_put(dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Power and VBUS is unsigned 16-bit, others are signed 16-bit =
*/
> > +       if (addr =3D=3D RTQ6056_REG_BUSVOLT || addr =3D=3D RTQ6056_REG_=
POWER)
> > +               *val =3D regval;
> > +       else
> > +               *val =3D sign_extend32(regval, 16);
> > +
> > +       return IIO_VAL_INT;
> > +}
> > +
> > +static int rtq6056_adc_read_scale(struct iio_chan_spec const *ch, int =
*val,
> > +                                 int *val2)
> > +{
> > +       switch (ch->address) {
> > +       case RTQ6056_REG_SHUNTVOLT:
> > +               /* VSHUNT lsb  2.5uV */
> > +               *val =3D 2500;
> > +               *val2 =3D 1000000;
> > +               return IIO_VAL_FRACTIONAL;
> > +       case RTQ6056_REG_BUSVOLT:
> > +               /* VBUS lsb 1.25mV */
> > +               *val =3D 1250;
> > +               *val2 =3D 1000;
> > +               return IIO_VAL_FRACTIONAL;
> > +       case RTQ6056_REG_POWER:
> > +               /* Power lsb 25mW */
> > +               *val =3D 25;
> > +               return IIO_VAL_INT;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +/*
> > + * Sample frequency for channel VSHUNT and VBUS. The indices correspond
> > + * with the bit value expected by the chip. And it can be found at
> > + * https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
> > + */
> > +static const int rtq6056_samp_freq_list[] =3D {
> > +       7194, 4926, 3717, 1904, 964, 485, 243, 122,
> > +};
> > +
> > +static int rtq6056_adc_set_samp_freq(struct rtq6056_priv *priv,
> > +                                    struct iio_chan_spec const *ch, in=
t val)
> > +{
> > +       struct regmap_field *rm_field;
> > +       unsigned int selector;
> > +       int *ct, ret;
> > +
> > +       if (val > 7194 || val < 122)
> > +               return -EINVAL;
> > +
> > +       if (ch->address =3D=3D RTQ6056_REG_SHUNTVOLT) {
> > +               rm_field =3D priv->rm_fields[F_VSHUNTCT];
> > +               ct =3D &priv->vshuntct_us;
> > +       } else if (ch->address =3D=3D RTQ6056_REG_BUSVOLT) {
> > +               rm_field =3D priv->rm_fields[F_VBUSCT];
> > +               ct =3D &priv->vbusct_us;
> > +       } else
> > +               return -EINVAL;
> > +
> > +       selector =3D find_closest_descending(val, rtq6056_samp_freq_lis=
t,
> > +                                          ARRAY_SIZE(rtq6056_samp_freq=
_list));
> > +
> > +       ret =3D regmap_field_write(rm_field, selector);
> > +       if (ret)
> > +               return ret;
> > +
> > +       *ct =3D 1000000 / rtq6056_samp_freq_list[selector];
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Available averaging rate for rtq6056. The indices correspond with t=
he bit
> > + * value expected by the chip. And it can be found at
> > + * https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
> > + */
> > +static const int rtq6056_avg_sample_list[] =3D {
> > +       1, 4, 16, 64, 128, 256, 512, 1024,
> > +};
> > +
> > +static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
> > +{
> > +       unsigned int selector;
> > +       int ret;
> > +
> > +       if (val > 1024 || val < 1)
> > +               return -EINVAL;
> > +
> > +       selector =3D find_closest(val, rtq6056_avg_sample_list,
> > +                               ARRAY_SIZE(rtq6056_avg_sample_list));
> > +
> > +       ret =3D regmap_field_write(priv->rm_fields[F_AVG], selector);
> > +       if (ret)
> > +               return ret;
> > +
> > +       priv->avg_sample =3D rtq6056_avg_sample_list[selector];
> > +
> > +       return 0;
> > +}
> > +
> > +static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv,
> > +                                      struct iio_chan_spec const *ch, =
int *val)
> > +{
> > +       int sample_time;
> > +
> > +       if (ch->address =3D=3D RTQ6056_REG_SHUNTVOLT)
> > +               sample_time =3D priv->vshuntct_us;
> > +       else if (ch->address =3D=3D RTQ6056_REG_BUSVOLT)
> > +               sample_time =3D priv->vbusct_us;
> > +       else {
> > +               sample_time =3D priv->vshuntct_us + priv->vbusct_us;
> > +               sample_time *=3D priv->avg_sample;
> > +       }
> > +
> > +       *val =3D 1000000 / sample_time;
> > +
> > +       return IIO_VAL_INT;
> > +}
> > +
> > +static int rtq6056_adc_read_raw(struct iio_dev *indio_dev,
> > +                               struct iio_chan_spec const *chan, int *=
val,
> > +                               int *val2, long mask)
> > +{
> > +       struct rtq6056_priv *priv =3D iio_priv(indio_dev);
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               return rtq6056_adc_read_channel(priv, chan, val);
> > +       case IIO_CHAN_INFO_SCALE:
> > +               return rtq6056_adc_read_scale(chan, val, val2);
> > +       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +               *val =3D priv->avg_sample;
> > +               return IIO_VAL_INT;
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               return rtq6056_adc_get_sample_freq(priv, chan, val);
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int rtq6056_adc_read_avail(struct iio_dev *indio_dev,
> > +                                 struct iio_chan_spec const *chan,
> > +                                 const int **vals, int *type, int *len=
gth,
> > +                                 long mask)
> > +{
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               *vals =3D rtq6056_samp_freq_list;
> > +               *type =3D IIO_VAL_INT;
> > +               *length =3D ARRAY_SIZE(rtq6056_samp_freq_list);
> > +               return IIO_AVAIL_LIST;
> > +       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +               *vals =3D rtq6056_avg_sample_list;
> > +               *type =3D IIO_VAL_INT;
> > +               *length =3D ARRAY_SIZE(rtq6056_avg_sample_list);
> > +               return IIO_AVAIL_LIST;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> > +                                struct iio_chan_spec const *chan, int =
val,
> > +                                int val2, long mask)
> > +{
> > +       struct rtq6056_priv *priv =3D iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       ret =3D iio_device_claim_direct_mode(indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               ret =3D rtq6056_adc_set_samp_freq(priv, chan, val);
> > +               break;
> > +       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +               ret =3D rtq6056_adc_set_average(priv, val);
> > +               break;
> > +       default:
> > +               ret =3D -EINVAL;
> > +               break;
> > +       }
> > +
> > +       iio_device_release_direct_mode(indio_dev);
> > +
> > +       return ret;
> > +}
> > +
> > +static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] =3D {
> > +       [RTQ6056_CH_VSHUNT] =3D "Vshunt",
> > +       [RTQ6056_CH_VBUS] =3D "Vbus",
> > +       [RTQ6056_CH_POWER] =3D "Power",
> > +       [RTQ6056_CH_CURRENT] =3D "Current",
> > +};
> > +
> > +static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
> > +                                 struct iio_chan_spec const *chan,
> > +                                 char *label)
> > +{
> > +       return sysfs_emit(label, "%s\n", rtq6056_channel_labels[chan->c=
hannel]);
> > +}
> > +
> > +static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
> > +                                     int resistor_uohm)
> > +{
> > +       unsigned int calib_val;
> > +       int ret;
> > +
> > +       if (resistor_uohm <=3D 0) {
> > +               dev_err(priv->dev, "Invalid resistor [%d]\n", resistor_=
uohm);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* calibration =3D 5120000 / (Rshunt (uOhm) * current lsb (1mA)=
) */
> > +       calib_val =3D 5120000 / resistor_uohm;
> > +       ret =3D regmap_write(priv->regmap, RTQ6056_REG_CALIBRATION, cal=
ib_val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       priv->shunt_resistor_uohm =3D resistor_uohm;
> > +
> > +       return 0;
> > +}
> > +
> > +static ssize_t shunt_resistor_show(struct device *dev,
> > +                                  struct device_attribute *attr, char =
*buf)
> > +{
> > +       struct rtq6056_priv *priv =3D iio_priv(dev_to_iio_dev(dev));
> > +       int vals[2] =3D { priv->shunt_resistor_uohm, 1000000 };
> > +
> > +       return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
> > +}
> > +
> > +static ssize_t shunt_resistor_store(struct device *dev,
> > +                                   struct device_attribute *attr,
> > +                                   const char *buf, size_t len)
> > +{
> > +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +       struct rtq6056_priv *priv =3D iio_priv(indio_dev);
> > +       int val, val_fract, ret;
> > +
> > +       ret =3D iio_device_claim_direct_mode(indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
> > +       if (ret)
> > +               goto out_store;
> > +
> > +       ret =3D rtq6056_set_shunt_resistor(priv, val * 1000000 + val_fr=
act);
> > +
> > +out_store:
> > +       iio_device_release_direct_mode(indio_dev);
> > +
> > +       return ret ?: len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR_RW(shunt_resistor, 0);
> > +
> > +static struct attribute *rtq6056_attributes[] =3D {
> > +       &iio_dev_attr_shunt_resistor.dev_attr.attr,
> > +       NULL
> > +};
> > +
> > +static const struct attribute_group rtq6056_attribute_group =3D {
> > +       .attrs =3D rtq6056_attributes,
> > +};
> > +
> > +static const struct iio_info rtq6056_info =3D {
> > +       .attrs =3D &rtq6056_attribute_group,
> > +       .read_raw =3D rtq6056_adc_read_raw,
> > +       .read_avail =3D rtq6056_adc_read_avail,
> > +       .write_raw =3D rtq6056_adc_write_raw,
> > +       .read_label =3D rtq6056_adc_read_label,
> > +};
> > +
> > +static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
> > +{
> > +       struct iio_poll_func *pf =3D p;
> > +       struct iio_dev *indio_dev =3D pf->indio_dev;
> > +       struct rtq6056_priv *priv =3D iio_priv(indio_dev);
> > +       struct device *dev =3D priv->dev;
> > +       struct {
> > +               u16 vals[RTQ6056_MAX_CHANNEL];
> > +               s64 timestamp __aligned(8);
> > +       } data;
> > +       unsigned int raw;
> > +       int i =3D 0, bit, ret;
> > +
> > +       memset(&data, 0, sizeof(data));
> > +
> > +       pm_runtime_get_sync(dev);
> > +
> > +       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->m=
asklength) {
> > +               unsigned int addr =3D rtq6056_channels[bit].address;
> > +
> > +               ret =3D regmap_read(priv->regmap, addr, &raw);
> > +               if (ret)
> > +                       goto out;
> > +
> > +               data.vals[i++] =3D raw;
> > +       }
> > +
> > +       iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_ti=
me_ns(indio_dev));
> > +
> > +out:
> > +       pm_runtime_mark_last_busy(dev);
> > +       pm_runtime_put(dev);
> > +
> > +       iio_trigger_notify_done(indio_dev->trig);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static void rtq6056_enter_shutdown_state(void *dev)
> > +{
> > +       struct rtq6056_priv *priv =3D dev_get_drvdata(dev);
> > +
> > +       /* Enter shutdown state */
> > +       regmap_field_write(priv->rm_fields[F_OPMODE], 0);
> > +}
> > +
> > +static bool rtq6056_is_readable_reg(struct device *dev, unsigned int r=
eg)
> > +{
> > +       switch (reg) {
> > +       case RTQ6056_REG_CONFIG ... RTQ6056_REG_ALERTLIMIT:
> > +       case RTQ6056_REG_MANUFACTID ... RTQ6056_REG_DIEID:
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static bool rtq6056_is_writeable_reg(struct device *dev, unsigned int =
reg)
> > +{
> > +       switch (reg) {
> > +       case RTQ6056_REG_CONFIG:
> > +       case RTQ6056_REG_CALIBRATION ... RTQ6056_REG_ALERTLIMIT:
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static const struct regmap_config rtq6056_regmap_config =3D {
> > +       .reg_bits =3D 8,
> > +       .val_bits =3D 16,
> > +       .val_format_endian =3D REGMAP_ENDIAN_BIG,
> > +       .max_register =3D RTQ6056_REG_DIEID,
> > +       .readable_reg =3D rtq6056_is_readable_reg,
> > +       .writeable_reg =3D rtq6056_is_writeable_reg,
> > +};
> > +
> > +static int rtq6056_probe(struct i2c_client *i2c)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct rtq6056_priv *priv;
> > +       struct device *dev =3D &i2c->dev;
> > +       struct regmap *regmap;
> > +       unsigned int vendor_id, shunt_resistor_uohm;
> > +       int ret;
> > +
> > +       if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_=
DATA))
> > +               return -EOPNOTSUPP;
> > +
> > +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       priv =3D iio_priv(indio_dev);
> > +       priv->dev =3D dev;
> > +       priv->vshuntct_us =3D priv->vbusct_us =3D 1037;
> > +       priv->avg_sample =3D 1;
> > +       i2c_set_clientdata(i2c, priv);
> > +
> > +       regmap =3D devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
> > +       if (IS_ERR(regmap))
> > +               return dev_err_probe(dev, PTR_ERR(regmap),
> > +                                    "Failed to init regmap\n");
> > +
> > +       priv->regmap =3D regmap;
> > +
> > +       ret =3D regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to get manufacturer info\n=
");
> > +
> > +       if (vendor_id !=3D RTQ6056_VENDOR_ID)
> > +               return dev_err_probe(dev, -ENODEV,
> > +                                    "Invalid vendor id 0x%04x\n", vend=
or_id);
> > +
> > +       ret =3D devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fiel=
ds,
> > +                                          rtq6056_reg_fields, F_MAX_FI=
ELDS);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret, "Failed to init regmap f=
ield\n");
> > +
> > +       /*
> > +        * By default, configure average sample as 1, bus and shunt con=
version
> > +        * time as 1037 microsecond, and operating mode to all on.
> > +        */
> > +       ret =3D regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAUL=
T_CONFIG);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to enable continuous sensi=
ng\n");
> > +
> > +       ret =3D devm_add_action_or_reset(dev, rtq6056_enter_shutdown_st=
ate, dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> > +       pm_runtime_use_autosuspend(dev);
> > +       pm_runtime_set_active(dev);
> > +       pm_runtime_mark_last_busy(dev);
> > +       ret =3D devm_pm_runtime_enable(dev);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret, "Failed to enable pm_run=
time\n");
> > +
> > +       /* By default, use 2000 micro-Ohm resistor */
> > +       shunt_resistor_uohm =3D 2000;
> > +       device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > +                                &shunt_resistor_uohm);
> > +
> > +       ret =3D rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to init shunt resistor\n");
> > +
> > +       indio_dev->name =3D "rtq6056";
> > +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +       indio_dev->channels =3D rtq6056_channels;
> > +       indio_dev->num_channels =3D ARRAY_SIZE(rtq6056_channels);
> > +       indio_dev->info =3D &rtq6056_info;
> > +
> > +       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                                             rtq6056_buffer_trigger_ha=
ndler,
> > +                                             NULL);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to allocate iio trigger bu=
ffer\n");
> > +
> > +       return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static int rtq6056_runtime_suspend(struct device *dev)
> > +{
> > +       struct rtq6056_priv *priv =3D dev_get_drvdata(dev);
> > +
> > +       /* Configure to shutdown mode */
> > +       return regmap_field_write(priv->rm_fields[F_OPMODE], 0);
> > +}
> > +
> > +static int rtq6056_runtime_resume(struct device *dev)
> > +{
> > +       struct rtq6056_priv *priv =3D dev_get_drvdata(dev);
> > +       int sample_rdy_time_us, ret;
> > +
> > +       ret =3D regmap_field_write(priv->rm_fields[F_OPMODE], RTQ6056_C=
ONT_ALLON);
> > +       if (ret)
> > +               return ret;
> > +
> > +       sample_rdy_time_us =3D priv->vbusct_us + priv->vshuntct_us;
> > +       sample_rdy_time_us *=3D priv->avg_sample;
> > +
> > +       usleep_range(sample_rdy_time_us, sample_rdy_time_us + 100);
> > +
> > +       return 0;
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(rtq6056_pm_ops, rtq6056_runtime_suspe=
nd,
> > +                                rtq6056_runtime_resume, NULL);
> > +
> > +static const struct of_device_id rtq6056_device_match[] =3D {
> > +       { .compatible =3D "richtek,rtq6056" },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, rtq6056_device_match);
> > +
> > +static struct i2c_driver rtq6056_driver =3D {
> > +       .driver =3D {
> > +               .name =3D "rtq6056",
> > +               .of_match_table =3D rtq6056_device_match,
> > +               .pm =3D pm_ptr(&rtq6056_pm_ops),
> > +       },
> > +       .probe_new =3D rtq6056_probe,
> > +};
> > +module_i2c_driver(rtq6056_driver);
> > +
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_DESCRIPTION("Richtek RTQ6056 Driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.7.4
> > =20

