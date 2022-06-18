Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59DE5505E1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiFRPtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiFRPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:49:41 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D4713D07;
        Sat, 18 Jun 2022 08:49:40 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id i186so6687669vsc.9;
        Sat, 18 Jun 2022 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NSdnzEcptp/21mntYpsOEvf1Dfw1K7c5C0sZst0ATS8=;
        b=H6dTUzdGfM0SffVcXTrwTJ1iezvnqUKje8O++elpex8gPBcwYBRR6WYlQHn2hVA6YI
         9nH9coqWNCdyrlTACZ40qtrAJhs78/iqRLhJkEK67zvgm8qohICHgJJvYNL+G5BtpXBk
         ttXn/ooAyfGjuOy/tFiVrIqeZ418/cAmp1gItUfIJdxWd3It6pH5ob3nipvuM/0jPc49
         IcWiM+nEn950raWD6KqKNyJxFPlNkf2NkgERjlXYe8pFSNK5Y6hGexv8ml7uCno5ZEUJ
         y+kzmCeg0xpfMHC/MSojCWoTcfMMrE6SvyMsYfawrnhFDTVomUldDm7hokEZ7C6OE0Kp
         Ipkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NSdnzEcptp/21mntYpsOEvf1Dfw1K7c5C0sZst0ATS8=;
        b=Tl6Gvy/PKJHzeDLk3Kx5okZER6TjGEWXfRi5JGPmOs/l1OqsHkPTJLe7+yFqSDzp+V
         9ug+GvcCNWoykYfDJ8C6+9G/D/hpGyRZs06lCRlpHILn2+VaMebr7XC8KQ5GZ6zvaWEa
         Rskk9yAlGOQn/ZdquK+o2dUx6V4BxVUvZGhydqsLCc3GNJ3TOtz0JndCbEDglJLqePfu
         R3rxF8KUfId72U+wIw3yRtP2g2VNnoTGVdQEZaI5IJM0CxnRoAwLaAyQU6HSoXMH88MO
         7XufLQJ4mGX6/WzC2QxZdgNuA9f7uI3CBmizXGEXxwNkC5G4FHSaj7y13qNQqi0G2aKz
         NskQ==
X-Gm-Message-State: AJIora/5OH01f0mN4oh4iHE63tKHUjrb5hQxHN10HkFP3e4OJlxZOflC
        yuceELJ6wFNCuGjSQQJ1BMcfXp2rAyfGbeYsDAk=
X-Google-Smtp-Source: AGRyM1t+E90oe4u2PY4dTenRuM2jbcubexzuu7US93wwQfniiULYt+IukViwMhBDEYFkx6ZHDaB+mcJ1JdGPBWAyFyY=
X-Received: by 2002:a67:d182:0:b0:337:8e4c:76c7 with SMTP id
 w2-20020a67d182000000b003378e4c76c7mr6157260vsi.75.1655567378898; Sat, 18 Jun
 2022 08:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-3-git-send-email-u0084500@gmail.com> <20220617181027.000074a8@Huawei.com>
In-Reply-To: <20220617181027.000074a8@Huawei.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 18 Jun 2022 23:49:27 +0800
Message-ID: <CADiBU3_LSwDcCrVFTHb8sLBEQWmyUpz94k=yQ=QQ+mC73sGx_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add rtq6056 support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> =E6=96=BC 2022=E5=B9=B46=E6=
=9C=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A81:10=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Fri, 17 Jun 2022 17:32:55 +0800
> cy_huang <u0084500@gmail.com> wrote:
>
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Richtek RTQ6056 supporting.
> >
> > It can be used for the system to monitor load current and power with 16=
bit
> > resolution.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>
> Hi ChiYuan,
>
> Comments inline.
>
> It would be nice to consider how to take advantage of the fact we know wh=
ich
> channels are of interest in buffered mode, and change the operating mode =
to
> suite.
>
I implement the  buffered mode is for the debugging or continuous
tracking purpose.

BUS channel is for input power source voltage
Shunt channel is for the cross voltage difference for Rshunt.
Current channel is calculated by Vshunt/Rshunt and the value converted by H=
W.
Power channel is calculated by BUS voltage multiple Current channel,
and also the value converted by HW.

For the opmode question, this IC already designed for low quiescent.
If IC's in continuous mode, the typical quiescent current is still around 5=
50uA.
'Shutdown' mode only use typical 3.5uA.

Like as you said, I may consider to use pm_runtime plus autosuspend to
minimize the wait time for the first new sample ready.

> > ---
> >  .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |  58 +++
> >  drivers/iio/adc/Kconfig                            |  15 +
> >  drivers/iio/adc/Makefile                           |   1 +
> >  drivers/iio/adc/rtq6056-adc.c                      | 548 +++++++++++++=
++++++++
> >  4 files changed, 622 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> >  create mode 100644 drivers/iio/adc/rtq6056-adc.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Docu=
mentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > new file mode 100644
> > index 00000000..0516429
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > @@ -0,0 +1,58 @@
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage0_raw
>
> Documentation can't be duplicated in mulitple files so these standard
> attributes should rely only on the main docs.  If we duplicate it breaks
> building the html docs unfortunately.
>
Does it mean there's no need to explain it here and covert this
voltage to millivolt?
>
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             Shunt IN +/- sensing range from -82mV to +81.9175mV
> > +             Calculating with scale (2.5 uV)
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage1_raw
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             BUS voltage sensing range from 0V to 36V.
> > +             Calculating with scale (1.25 mV)
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_power2_raw
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             Power loading that equals to bus voltage multiple loading
> > +             current.
> > +             Calculating with scale (25 mWatt)
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_current3_raw
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             Consuming current from bus voltage.
> > +             Directly report loading current in mA
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage0_inte=
gration_time
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             Shunt voltage conversion time in uS
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage1_inte=
gration_time
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             BUS voltage conversion time in uS
>
> integration time is not normally about conversion time. It's normally for=
 things
> like light sensors where they are charging up a capacitor for a fixed tim=
e period.
>
> For ADC channels we tend to use _sampling_frequency (so 1/period). An exa=
mple of
> this being per channel is ad7124.
>
> That does mean we tend not to provide the overall 'sampling_frequency' on=
 these
> devices, but rather let an interested userspace program figure it out - o=
ften
> it depends on which channels are enabled.
>
Ack in next
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_oversampling_=
ratio
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             The number of average sample
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_sampling_freq=
uency
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             Sampling frequency in HZ for power and current report
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/integration_time=
_available
> > +KernelVersion:       5.18.2
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             Sample conversion time available for BUS and Shunt, unit =
in second
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 48ace74..0b2d17c 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -908,6 +908,21 @@ config ROCKCHIP_SARADC
> >         To compile this driver as a module, choose M here: the
> >         module will be called rockchip_saradc.
> >
> > +config RICHTEK_RTQ6056_ADC
> > +     tristate "Richtek RTQ6056 Current and Power Monitor ADC"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> > +     help
> > +       Say yes here to enable RQT6056 ADC support.
> > +       RTQ6056 is a high accuracy current-sense monitor with I2C and S=
MBus
> > +       compatible interface, and the device provides full information =
for
> > +       system by reading out the load current and power.
> > +
> > +       This driver can also be built as a module. If so, the module wi=
ll be
> > +       called rtq6056-adc.
> > +
> >  config RZG2L_ADC
> >       tristate "Renesas RZ/G2L ADC driver"
> >       depends on ARCH_RZG2L || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 39d806f..e8c6e6e 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -84,6 +84,7 @@ obj-$(CONFIG_QCOM_PM8XXX_XOADC) +=3D qcom-pm8xxx-xoad=
c.o
> >  obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
> >  obj-$(CONFIG_RN5T618_ADC) +=3D rn5t618-adc.o
> >  obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> > +obj-$(CONFIG_RICHTEK_RTQ6056_ADC) +=3D rtq6056-adc.o
>
> Is the device anything other than ADC?  If not, drop the -adc.
> The other entries you see here are ADCs that form part of a much
> larger SoC.
>
No, like you said, only ADC. To rename it is OK.
> >  obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
> >  obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> >  obj-$(CONFIG_SPEAR_ADC) +=3D spear_adc.o
> > diff --git a/drivers/iio/adc/rtq6056-adc.c b/drivers/iio/adc/rtq6056-ad=
c.c
> > new file mode 100644
> > index 00000000..8374fce
> > --- /dev/null
> > +++ b/drivers/iio/adc/rtq6056-adc.c
> > @@ -0,0 +1,548 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
>
> property.h and mod_devicetable.h instead of of.h
> once you have moved to generic firmware properties.
>
Ack  in next.
> > +#include <linux/regmap.h>
> > +#include <linux/util_macros.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> > +#define RTQ6056_REG_CONFIG   0x00
> > +#define RTQ6056_REG_SHUNTVOLT        0x01
> > +#define RTQ6056_REG_CALIBRATION      0x05
> > +#define RTQ6056_REG_MASKENABLE       0x06
> > +#define RTQ6056_REG_ALERTLIMIT       0x07
> > +#define RTQ6056_REG_MANUFACTID       0xFE
> > +#define RTQ6056_REG_DIEID    0xFF
> > +
> > +#define RTQ6056_VENDOR_ID    0x1214
> > +#define RTQ6056_DEFAULT_CONFIG       0x4127
>
> This is not defined in terms of the field provided below
> so it's not obvious what the initial state is.
>
To leave a comment about the default state?
Or use the macro to define the all field?
> > +#define RTQ6056_DEFAULT_CONVT        1037
> > +#define RTQ6056_DEFAULT_AVG  1
> This and the next are real world values. Having them as defines
> makes the code less readable.
>
Will remove it. Thx.
> > +#define RTQ6056_DEFAULT_RSHUNT       2000
> > +
> > +enum {
> > +     RTQ6056_CH_VSHUNT =3D 0,
> > +     RTQ6056_CH_VBUS,
> > +     RTQ6056_CH_POWER,
> > +     RTQ6056_CH_CURRENT,
> > +     RTQ6056_MAX_CHANNEL
> > +};
> > +
> > +enum {
> > +     F_OPMODE =3D 0, F_VSHUNTCT, F_VBUSCT, F_AVG, F_RESET,
> > +     F_MAX_FIELDS
> > +};
> > +
> > +struct rtq6056_priv {
> > +     struct device *dev;
> > +     struct regmap *regmap;
> > +     struct regmap_field *rm_fields[F_MAX_FIELDS];
> > +     u32 shunt_resistor_uohm;
> > +     int vshuntct; /* vshunt conversion time in uS */
> > +     int vbusct; /* vbus conversion time in uS */
> > +     int avg_sample;
> > +};
> > +
> > +static const struct reg_field rtq6056_reg_fields[F_MAX_FIELDS] =3D {
> > +     [F_OPMODE] =3D REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
> > +     [F_VSHUNTCT] =3D REG_FIELD(RTQ6056_REG_CONFIG, 3, 5),
> > +     [F_VBUSCT] =3D REG_FIELD(RTQ6056_REG_CONFIG, 6, 8),
> > +     [F_AVG] =3D REG_FIELD(RTQ6056_REG_CONFIG, 9, 11),
> > +     [F_RESET] =3D REG_FIELD(RTQ6056_REG_CONFIG, 15, 15)
> > +};
> > +
> > +static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL=
 + 1] =3D {
> > +     {
> > +             .type =3D IIO_VOLTAGE,
> > +             .indexed =3D 1,
> > +             .channel =3D RTQ6056_CH_VSHUNT,
> Where we have a bunch of different types of channel we generally
> count the channel numbers separately.  Where this is only one of a give
> type, don't bother making it indexed.
>
> Where you need an offset to use for accessing an actual register,
> the .address field is more appropriate.
>
Ack in next.
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE) |
> > +                                   BIT(IIO_CHAN_INFO_INT_TIME),
> > +             .info_mask_shared_by_dir =3D BIT(IIO_CHAN_INFO_SAMP_FREQ)=
 |
> > +                                        BIT(IIO_CHAN_INFO_OVERSAMPLING=
_RATIO),
>
> Why _by_dir as opposed to by_all given there are no output channels regis=
tered?
>
Thanks, I think I need to check all channel attributes again.
>
> > +             .scan_index =3D 0,
> > +             .scan_type =3D {
> > +                     .sign =3D 's',
> > +                     .realbits =3D 16,
> > +                     .storagebits =3D 16,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     {
> > +             .type =3D IIO_VOLTAGE,
> > +             .indexed =3D 1,
> > +             .channel =3D RTQ6056_CH_VBUS,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE) |
> > +                                   BIT(IIO_CHAN_INFO_INT_TIME),
> > +             .info_mask_shared_by_dir =3D BIT(IIO_CHAN_INFO_SAMP_FREQ)=
 |
> > +                                        BIT(IIO_CHAN_INFO_OVERSAMPLING=
_RATIO),
> > +             .scan_index =3D 1,
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 16,
> > +                     .storagebits =3D 16,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     {
> > +             .type =3D IIO_POWER,
> > +             .indexed =3D 1,
> > +             .channel =3D RTQ6056_CH_POWER,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .info_mask_shared_by_dir =3D BIT(IIO_CHAN_INFO_SAMP_FREQ)=
 |
> > +                                        BIT(IIO_CHAN_INFO_OVERSAMPLING=
_RATIO),
> > +             .scan_index =3D 2,
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 16,
> > +                     .storagebits =3D 16,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     {
> > +             .type =3D IIO_CURRENT,
> > +             .indexed =3D 1,
> > +             .channel =3D RTQ6056_CH_CURRENT,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > +             .info_mask_shared_by_dir =3D BIT(IIO_CHAN_INFO_SAMP_FREQ)=
 |
> > +                                        BIT(IIO_CHAN_INFO_OVERSAMPLING=
_RATIO),
> > +             .scan_index =3D 3,
> > +             .scan_type =3D {
> > +                     .sign =3D 's',
> > +                     .realbits =3D 16,
> > +                     .storagebits =3D 16,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL)
> > +};
> > +
> > +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv, int cha=
nnel,
> > +                                 int *val)
> > +{
> > +     unsigned int reg =3D RTQ6056_REG_SHUNTVOLT + channel;
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(priv->regmap, reg, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Only power and vbus channel is unsigned */
> > +     if (channel =3D=3D RTQ6056_CH_VBUS || channel =3D=3D RTQ6056_CH_P=
OWER)
> > +             *val =3D regval;
> > +     else
> > +             *val =3D (s16)regval;
>
> Prefer making it clear this is sign extension with sign_extend32()
>
Ack in next.
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
>
> ...
>
> > +
> > +static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
> > +{
> > +     unsigned int selector;
> > +     int ret;
> > +
> > +     if (val > 1024 || val < 1)
> > +             return -EINVAL;
> > +
> > +     selector =3D find_closest(val, rtq6056_avg_sample_list,
> > +                             ARRAY_SIZE(rtq6056_avg_sample_list));
> > +
> > +     ret =3D regmap_field_write(priv->rm_fields[F_AVG], selector);
> > +     if (ret)
> > +             return ret;
> > +
> > +     priv->avg_sample =3D rtq6056_avg_sample_list[selector];
>
> Blank line - see below. Same for other similar cases.
>
Ack in next.
> > +     return 0;
> > +}
> > +
> > +static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv, int =
*val)
> > +{
> > +     int sample_time;
> > +
> > +     sample_time =3D priv->vshuntct + priv->vbusct;
> > +     sample_time *=3D priv->avg_sample;
>
> > +
> > +     *val =3D DIV_ROUND_UP(1000000, sample_time);
> > +     return IIO_VAL_INT;
> > +}
> > +
>
>
> > +
> > +static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] =3D {
> > +     [RTQ6056_CH_VSHUNT] =3D "Vshunt(uV)",
>
> Units must be the standard ones for the IIO channel types.
> Hence documenting them here is misleading.
>
Can I use the "extend_name' and remove all the 'read_label' and
channel_label variable?
And also , the unit will be removed. Thx.
> > +     [RTQ6056_CH_VBUS] =3D "Vbus(mV)",
> > +     [RTQ6056_CH_POWER] =3D "Power(mW)",
> > +     [RTQ6056_CH_CURRENT] =3D "Current(mA)",
> > +};
> > +
> > +static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
> > +                               struct iio_chan_spec const *chan,
> > +                               char *label)
> > +{
> > +     return snprintf(label, PAGE_SIZE, "%s\n",
> > +                     rtq6056_channel_labels[chan->channel]);
> > +}
> > +
> > +static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
> > +                                   int resistor_uohm)
> > +{
> > +     unsigned int calib_val;
> > +     int ret;
> > +
> > +     if (resistor_uohm <=3D 0) {
> > +             dev_err(priv->dev, "Invalid resistor [%d]\n", resistor_uo=
hm);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* calibration =3D 5120000 / (Rshunt (uohm) * current lsb (1mA)) =
*/
> > +     calib_val =3D 5120000 / resistor_uohm;
> > +     ret =3D regmap_write(priv->regmap, RTQ6056_REG_CALIBRATION, calib=
_val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     priv->shunt_resistor_uohm =3D resistor_uohm;
>
> Blank line before a simple return like this. It slightly helps readabilit=
y.
>
Ack in next.
> > +     return 0;
> > +}
>
> ...
>
> > +static IIO_CONST_ATTR_NAMED(rtq6056_conv_time_available,
> > +                         integration_time_available,
> > +                         "0.000139 0.000203 0.000269 0.000525 0.001037=
 0.002061 0.004109 0.008205");
> > +
> > +static IIO_DEVICE_ATTR(shunt_resistor, 0644,
> > +                    rtq6056_shunt_resistor_show,
> > +                    rtq6056_shunt_resistor_store, 0);
> > +
> > +static struct attribute *rtq6056_attributes[] =3D {
> > +     &iio_const_attr_rtq6056_conv_time_available.dev_attr.attr,
> Whilst I think this particular interface will change anyway, you should
> use the read_avail callback for available attributes for standard ABI.
>
Ack in next.
> > +     &iio_dev_attr_shunt_resistor.dev_attr.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group rtq6056_attribute_group =3D {
> > +     .attrs =3D rtq6056_attributes,
> > +};
> > +
> > +static const struct iio_info rtq6056_info =3D {
> > +     .attrs =3D &rtq6056_attribute_group,
> > +     .read_raw =3D rtq6056_adc_read_raw,
> > +     .write_raw =3D rtq6056_adc_write_raw,
> > +     .read_label =3D rtq6056_adc_read_label,
> > +};
>
> ...
> > +static int rtq6056_probe(struct i2c_client *i2c)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct rtq6056_priv *priv;
> > +     unsigned int vendor_id, shunt_resistor_uohm;
> > +     int ret;
> > +
> > +     if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DA=
TA))
> > +             return -EOPNOTSUPP;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     priv =3D iio_priv(indio_dev);
> > +     priv->dev =3D &i2c->dev;
> > +     priv->vshuntct =3D priv->vbusct =3D RTQ6056_DEFAULT_CONVT;
> > +     priv->avg_sample =3D RTQ6056_DEFAULT_AVG;
> > +     i2c_set_clientdata(i2c, priv);
> > +
> > +     priv->regmap =3D devm_regmap_init_i2c(i2c, &rtq6056_regmap_config=
);
> You make a lot of use of regmap in this function. I would suggest
> first allocating into a local variable, then using that to set
> priv->regmap.  The local variable can then be used avoid having
> priv->regmap everywhere.
>
dev_get_regmap(), instead?
> Similar for dev. once a function has multiple accesses to i2c->dev,
> things are cleaner if you just have
>
> struct device *dev =3D &i2c->dev; and use dev after that.
>
Ack in next.
> > +     if (IS_ERR(priv->regmap))
> > +             return dev_err_probe(&i2c->dev, PTR_ERR(priv->regmap),
> > +                                  "Failed to init regmap\n");
> > +
> > +     ret =3D regmap_read(priv->regmap, RTQ6056_REG_MANUFACTID, &vendor=
_id);
> > +     if (ret)
> > +             return dev_err_probe(&i2c->dev, ret,
> > +                                  "Failed to get manufacturer info\n")=
;
> > +
> > +     if (vendor_id !=3D RTQ6056_VENDOR_ID)
> > +             return dev_err_probe(&i2c->dev, -ENODEV,
> > +                                  "invalid vendor id 0x%04x\n", vendor=
_id);
> > +
> > +     ret =3D devm_regmap_field_bulk_alloc(&i2c->dev, priv->regmap,
> > +                                        priv->rm_fields, rtq6056_reg_f=
ields,
> > +                                        F_MAX_FIELDS);
> > +     if (ret)
> > +             return dev_err_probe(&i2c->dev, ret,
> > +                                  "Failed to init regmap field\n");
> > +
> > +     /* Write the default config value */
> > +     ret =3D regmap_write(priv->regmap, RTQ6056_REG_CONFIG,
> > +                        RTQ6056_DEFAULT_CONFIG);
>
> This write effectively turns the device on so it would be good
> to register a devm_add_action_or_reset() callback here to do what
> you currently have in remove.  That will mean you don't need a separate
> remove at all and that you will put the device in a low power state
> if you get an error after this point.
>
> At some stage it would be nice to do runtime pm with autosuspend so that
> we enter a low power state if no one is looking at the readings.
>
Ack in next.
> > +     if (ret)
> > +             return dev_err_probe(&i2c->dev, ret,
> > +                                  "Failed to write default config\n");
> > +
> > +     ret =3D of_property_read_u32(i2c->dev.of_node,
>
> Please use generic firmware properties not device tree specific ones.
> That lets people use other firmware interfaces such as ACPI using the
> PRP0001 HID.
>
Wil use 'device_property_read_u32', instead.
> > +                                "richtek,shunt-resistor-uohm",
> > +                                &shunt_resistor_uohm);
> > +     if (ret)
> > +             shunt_resistor_uohm =3D RTQ6056_DEFAULT_RSHUNT;
> Flip this around
>
>         shunt_resistor_uohm =3D 2000;
>         device_property_read_u32(dev, "rictek,shunt-resistor-uohm",
>                                  &shunt_resistor_uohm);
>
> if the property read fails, it won't change the value stored.
>
Ack in next.
> > +
> > +     ret =3D rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
> > +     if (ret)
> > +             dev_err_probe(&i2c->dev, ret,
> > +                           "Failed to init shunt resistor\n");
> > +
> > +     indio_dev->name =3D "rtq6056";
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->channels =3D rtq6056_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(rtq6056_channels);
> > +     indio_dev->info =3D &rtq6056_info;
> > +
> > +     ret =3D devm_iio_triggered_buffer_setup(&i2c->dev, indio_dev, NUL=
L,
> > +                                           rtq6056_buffer_trigger_hand=
ler,
> > +                                           NULL);
> > +     if (ret)
> > +             return dev_err_probe(&i2c->dev, ret,
> > +                                  "Failed to allocate iio trigger buff=
er\n");
> > +
> > +     return devm_iio_device_register(&i2c->dev, indio_dev);
> > +}
> > +
> > +static int rtq6056_remove(struct i2c_client *i2c)
> > +{
> > +     struct rtq6056_priv *priv =3D i2c_get_clientdata(i2c);
> > +
> > +     /* Config opmode to 'shutdown' mode to minimize quiescient curren=
t */
> > +     return regmap_field_write(priv->rm_fields[F_OPMODE], 0);
> > +}
> > +
> > +static void rtq6056_shutdown(struct i2c_client *i2c)
> > +{
> > +     struct rtq6056_priv *priv =3D i2c_get_clientdata(i2c);
> > +
> > +     /* Config opmode to 'shutdown' mode to minimize quiescient curren=
t */
> > +     regmap_field_write(priv->rm_fields[F_OPMODE], 0);
>
> Unusual to provide a shutdown for a device as simple as an ADC.  I'd expe=
ct
> the overall system to power down if we hit this and hence also cover
> the ADC.  If that's not the case, then perhaps add a comment explaining
> that.
>
That's because some application use VBAT as the VDD source.
Not all applcation use the PMIC buck or ldo as the supply for RTQ6056.
If use VBAT, then the shutdown quiescent current is important.
> > +}
> > +
> > +static const struct of_device_id rtq6056_device_match[] =3D {
> > +     { .compatible =3D "richtek,rtq6056", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, rtq6056_device_match);
> > +
> > +static struct i2c_driver rtq6056_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "rtq6056",
> > +             .of_match_table =3D rtq6056_device_match,
> > +     },
> > +     .probe_new =3D rtq6056_probe,
> > +     .remove =3D rtq6056_remove,
> > +     .shutdown =3D rtq6056_shutdown,
> > +};
> > +module_i2c_driver(rtq6056_driver);
> > +
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_DESCRIPTION("Richtek RTQ6056 ADC Driver");
> > +MODULE_LICENSE("GPL v2");
>
