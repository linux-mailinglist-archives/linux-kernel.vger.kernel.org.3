Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9ED58A9C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbiHEKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiHEKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:54:44 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BEE15701;
        Fri,  5 Aug 2022 03:54:42 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i4so1479724qvv.7;
        Fri, 05 Aug 2022 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1IuwnO7gSr9+HTKZ6nRnM2nx9f/6IsVkUTcZCIS7gDs=;
        b=FgPYUO8oQfcfwANBCcBPyvpGflE0cKvUU3muwGxRksalW+5BQ2drSJxDWcwNLffW2W
         PdvfOVMbrSu1B7AR5YeHREz0TtDVoPRLjtDvPpmGpeaBESa18aUFmdqeN68wBIUJZ4UD
         eqNuIVn1Ri5UAu1lZk+EUWTP9XeJHGAVIDF9CJRBl5t5962UQQ/KcxZH6dyBsSQF7MEf
         WoInD9nbvh4pnzrT5+38jHEGOOe4bOs1DU/ye994k+6syAgGRwIXXEwswVAEzOIvWUWu
         a9kXrGSbjTcp4SVs+C+qn6IM4OdyUPXDuMaBPfXyuTZMSmDOqYF70ElN1gn2mkV16L/j
         WvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1IuwnO7gSr9+HTKZ6nRnM2nx9f/6IsVkUTcZCIS7gDs=;
        b=ZqKEaSEYQqtTsfyNdBXzsYwY3Ze2icJtd1VwmxKZ8XeE7xvey5E6NTC+8U/tAqUtXn
         xlg1d2gejKAff269DYDmxtqMVulB5gyBlQAPMlWv5Qn6L6NEVuOXbnm3RCu2yOMsrc2h
         U+94+XrWk9ItbK8KpKJFP3jseZ5ORgSuFwrIhqc4psP8aziFw0ukx7TQwVyQNpuNXy73
         WiWf3eKVlqywPVf5qMESw2QScKrsWLFxLmFb0vU4QnA9GGrhnzx+wy1Ux6V3f6O5dlOQ
         CX1DajChWs74i22q6ygbpgiKcgV3CKphe3IoeDSvzI9FylCr237ivRnJiw4bFsAU1wtC
         wmrA==
X-Gm-Message-State: ACgBeo0su+klyCD5cUR8K/umlRzCGfhtVzxCJU5oabQEJiMbfirQnR1a
        4c7rMNOiU+RPj3c36iEOXoL1V4pWynamSZzBjts=
X-Google-Smtp-Source: AA6agR574W/5TXhESofdY0GJo78qfkw9igzfei6a43F0u3wRCj3aLsR2jggm7yfIjfJsEzyuxfpiQFxyxOY6/xWHsEM=
X-Received: by 2002:a05:6214:e69:b0:476:b991:586f with SMTP id
 jz9-20020a0562140e6900b00476b991586fmr5045801qvb.48.1659696881750; Fri, 05
 Aug 2022 03:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220805070610.3516-1-peterwu.pub@gmail.com> <20220805070610.3516-10-peterwu.pub@gmail.com>
In-Reply-To: <20220805070610.3516-10-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Aug 2022 12:54:04 +0200
Message-ID: <CAHp75VexyNqEFKY4PG_jYQxQGmdvE12SeuvMzHThfPY-gB4f7A@mail.gmail.com>
Subject: Re: [PATCH v7 09/13] iio: adc: mt6370: Add MediaTek MT6370 support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 9:07 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
>
> Add a support for the MT6370 ADC driver for system monitoring, including
> charger current, voltage, and temperature.

On Fri, Aug 5, 2022 at 9:07 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> Add a support for the Type-C & Power Delivery controller in
> MediaTek MT6370 IC.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>
> v7
> - Add AICR(100mA ~ 350mA), ICHG(100mA ~ 800mA) macros
> - Remove 400mA AICR and 900mA ICHG macros
> - Revise using 'if-else' to 'switch-case' in mt6370_adc_read_scale()
>   where the adc channel is ibus or ibat
> ---
>  drivers/iio/adc/Kconfig      |  12 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/mt6370-adc.c | 305 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 318 insertions(+)
>  create mode 100644 drivers/iio/adc/mt6370-adc.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7fe5930..995cbb5 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -736,6 +736,18 @@ config MEDIATEK_MT6360_ADC
>           is used in smartphones and tablets and supports a 11 channel
>           general purpose ADC.
>
> +config MEDIATEK_MT6370_ADC
> +       tristate "MediaTek MT6370 ADC driver"
> +       depends on MFD_MT6370
> +       help
> +         Say yes here to enable MediaTek MT6370 ADC support.
> +
> +         This ADC driver provides 9 channels for system monitoring (charger
> +         current, voltage, and temperature).
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called "mt6370-adc".
> +
>  config MEDIATEK_MT6577_AUXADC
>         tristate "MediaTek AUXADC driver"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1772a54..c6bc35f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MCP3911) += mcp3911.o
>  obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
> +obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
>  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
>  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>  obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
> diff --git a/drivers/iio/adc/mt6370-adc.c b/drivers/iio/adc/mt6370-adc.c
> new file mode 100644
> index 0000000..2a46471
> --- /dev/null
> +++ b/drivers/iio/adc/mt6370-adc.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Richtek Technology Corp.
> + *
> + * Author: ChiaEn Wu <chiaen_wu@richtek.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +
> +#include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
> +
> +#define MT6370_REG_CHG_CTRL3           0x113
> +#define MT6370_REG_CHG_CTRL7           0x117
> +#define MT6370_REG_CHG_ADC             0x121
> +#define MT6370_REG_ADC_DATA_H          0x14C
> +
> +#define MT6370_ADC_START_MASK          BIT(0)
> +#define MT6370_ADC_IN_SEL_MASK         GENMASK(7, 4)
> +#define MT6370_AICR_ICHG_MASK          GENMASK(7, 2)
> +
> +#define MT6370_AICR_100_mA             0x0
> +#define MT6370_AICR_150_mA             0x1
> +#define MT6370_AICR_200_mA             0x2
> +#define MT6370_AICR_250_mA             0x3
> +#define MT6370_AICR_300_mA             0x4
> +#define MT6370_AICR_350_mA             0x5
> +
> +#define MT6370_ICHG_100_mA             0x0
> +#define MT6370_ICHG_200_mA             0x1
> +#define MT6370_ICHG_300_mA             0x2
> +#define MT6370_ICHG_400_mA             0x3
> +#define MT6370_ICHG_500_mA             0x4
> +#define MT6370_ICHG_600_mA             0x5
> +#define MT6370_ICHG_700_mA             0x6
> +#define MT6370_ICHG_800_mA             0x7
> +
> +#define ADC_CONV_TIME_MS               35
> +#define ADC_CONV_POLLING_TIME_US       1000
> +
> +struct mt6370_adc_data {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       /*
> +        * This mutex lock is for preventing the different ADC channels
> +        * from being read at the same time.
> +        */
> +       struct mutex adc_lock;
> +};
> +
> +static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
> +                                  unsigned long addr, int *val)
> +{
> +       unsigned int reg_val;
> +       __be16 be_val;
> +       int ret;
> +
> +       mutex_lock(&priv->adc_lock);
> +
> +       reg_val = MT6370_ADC_START_MASK |
> +                 FIELD_PREP(MT6370_ADC_IN_SEL_MASK, addr);
> +       ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, reg_val);
> +       if (ret)
> +               goto adc_unlock;
> +
> +       msleep(ADC_CONV_TIME_MS);
> +
> +       ret = regmap_read_poll_timeout(priv->regmap,
> +                                      MT6370_REG_CHG_ADC, reg_val,
> +                                      !(reg_val & MT6370_ADC_START_MASK),
> +                                      ADC_CONV_POLLING_TIME_US,
> +                                      ADC_CONV_TIME_MS * MILLI * 3);
> +       if (ret) {
> +               dev_err(priv->dev, "Failed to read ADC register (%d)\n", ret);
> +               goto adc_unlock;
> +       }
> +
> +       ret = regmap_raw_read(priv->regmap, MT6370_REG_ADC_DATA_H,
> +                             &be_val, sizeof(be_val));
> +       if (ret)
> +               goto adc_unlock;
> +
> +       *val = be16_to_cpu(be_val);
> +       ret = IIO_VAL_INT;
> +
> +adc_unlock:
> +       mutex_unlock(&priv->adc_lock);
> +
> +       return ret;
> +}
> +
> +static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
> +                                int chan, int *val1, int *val2)
> +{
> +       unsigned int reg_val;
> +       int ret;
> +
> +       switch (chan) {
> +       case MT6370_CHAN_VBAT:
> +       case MT6370_CHAN_VSYS:
> +       case MT6370_CHAN_CHG_VDDP:
> +               *val1 = 5;
> +               return IIO_VAL_INT;
> +       case MT6370_CHAN_IBUS:
> +               ret = regmap_read(priv->regmap, MT6370_REG_CHG_CTRL3, &reg_val);
> +               if (ret)
> +                       return ret;
> +
> +               reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
> +               switch (reg_val) {
> +               case MT6370_AICR_100_mA:
> +               case MT6370_AICR_150_mA:
> +               case MT6370_AICR_200_mA:
> +               case MT6370_AICR_250_mA:
> +               case MT6370_AICR_300_mA:
> +               case MT6370_AICR_350_mA:
> +                       *val1 = 3350;
> +                       break;
> +               default:
> +                       *val1 = 5000;
> +                       break;
> +               }
> +
> +               *val2 = 100;
> +
> +               return IIO_VAL_FRACTIONAL;
> +       case MT6370_CHAN_IBAT:
> +               ret = regmap_read(priv->regmap, MT6370_REG_CHG_CTRL7, &reg_val);
> +               if (ret)
> +                       return ret;
> +
> +               reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
> +               switch (reg_val) {
> +               case MT6370_ICHG_100_mA:
> +               case MT6370_ICHG_200_mA:
> +               case MT6370_ICHG_300_mA:
> +               case MT6370_ICHG_400_mA:
> +                       *val1 = 2375;
> +                       break;
> +               case MT6370_ICHG_500_mA:
> +               case MT6370_ICHG_600_mA:
> +               case MT6370_ICHG_700_mA:
> +               case MT6370_ICHG_800_mA:
> +                       *val1 = 2680;
> +                       break;
> +               default:
> +                       *val1 = 5000;
> +                       break;
> +               }
> +
> +               *val2 = 100;
> +
> +               return IIO_VAL_FRACTIONAL;
> +       case MT6370_CHAN_VBUSDIV5:
> +               *val1 = 25;
> +               return IIO_VAL_INT;
> +       case MT6370_CHAN_VBUSDIV2:
> +               *val1 = 50;
> +               return IIO_VAL_INT;
> +       case MT6370_CHAN_TS_BAT:
> +               *val1 = 25;
> +               *val2 = 10000;
> +               return IIO_VAL_FRACTIONAL;
> +       case MT6370_CHAN_TEMP_JC:
> +               *val1 = 2000;
> +               return IIO_VAL_FRACTIONAL;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int mt6370_adc_read_offset(struct mt6370_adc_data *priv,
> +                                 int chan, int *val)
> +{
> +       *val = -20;
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int mt6370_adc_read_raw(struct iio_dev *iio_dev,
> +                              const struct iio_chan_spec *chan,
> +                              int *val, int *val2, long mask)
> +{
> +       struct mt6370_adc_data *priv = iio_priv(iio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               return mt6370_adc_read_channel(priv, chan->channel,
> +                                              chan->address, val);
> +       case IIO_CHAN_INFO_SCALE:
> +               return mt6370_adc_read_scale(priv, chan->channel, val, val2);
> +       case IIO_CHAN_INFO_OFFSET:
> +               return mt6370_adc_read_offset(priv, chan->channel, val);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const char * const mt6370_channel_labels[MT6370_CHAN_MAX] = {
> +       [MT6370_CHAN_VBUSDIV5] = "vbusdiv5",
> +       [MT6370_CHAN_VBUSDIV2] = "vbusdiv2",
> +       [MT6370_CHAN_VSYS] = "vsys",
> +       [MT6370_CHAN_VBAT] = "vbat",
> +       [MT6370_CHAN_TS_BAT] = "ts_bat",
> +       [MT6370_CHAN_IBUS] = "ibus",
> +       [MT6370_CHAN_IBAT] = "ibat",
> +       [MT6370_CHAN_CHG_VDDP] = "chg_vddp",
> +       [MT6370_CHAN_TEMP_JC] = "temp_jc",
> +};
> +
> +static int mt6370_adc_read_label(struct iio_dev *iio_dev,
> +                                struct iio_chan_spec const *chan, char *label)
> +{
> +       return sysfs_emit(label, "%s\n", mt6370_channel_labels[chan->channel]);
> +}
> +
> +static const struct iio_info mt6370_adc_iio_info = {
> +       .read_raw = mt6370_adc_read_raw,
> +       .read_label = mt6370_adc_read_label,
> +};
> +
> +#define MT6370_ADC_CHAN(_idx, _type, _addr, _extra_info) {     \
> +       .type = _type,                                          \
> +       .channel = MT6370_CHAN_##_idx,                          \
> +       .address = _addr,                                       \
> +       .scan_index = MT6370_CHAN_##_idx,                       \
> +       .indexed = 1,                                           \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> +                             BIT(IIO_CHAN_INFO_SCALE) |        \
> +                             _extra_info,                      \
> +}
> +
> +static const struct iio_chan_spec mt6370_adc_channels[] = {
> +       MT6370_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE, 1, 0),
> +       MT6370_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE, 2, 0),
> +       MT6370_ADC_CHAN(VSYS, IIO_VOLTAGE, 3, 0),
> +       MT6370_ADC_CHAN(VBAT, IIO_VOLTAGE, 4, 0),
> +       MT6370_ADC_CHAN(TS_BAT, IIO_VOLTAGE, 6, 0),
> +       MT6370_ADC_CHAN(IBUS, IIO_CURRENT, 8, 0),
> +       MT6370_ADC_CHAN(IBAT, IIO_CURRENT, 9, 0),
> +       MT6370_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE, 11, 0),
> +       MT6370_ADC_CHAN(TEMP_JC, IIO_TEMP, 12, BIT(IIO_CHAN_INFO_OFFSET)),
> +};
> +
> +static int mt6370_adc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct mt6370_adc_data *priv;
> +       struct iio_dev *indio_dev;
> +       struct regmap *regmap;
> +       int ret;
> +
> +       regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!regmap)
> +               return dev_err_probe(dev, -ENODEV, "Failed to get regmap\n");
> +
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       priv = iio_priv(indio_dev);
> +       priv->dev = dev;
> +       priv->regmap = regmap;
> +       mutex_init(&priv->adc_lock);
> +
> +       ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, 0);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to reset ADC\n");
> +
> +       indio_dev->name = "mt6370-adc";
> +       indio_dev->info = &mt6370_adc_iio_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = mt6370_adc_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(mt6370_adc_channels);
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id mt6370_adc_of_id[] = {
> +       { .compatible = "mediatek,mt6370-adc", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, mt6370_adc_of_id);
> +
> +static struct platform_driver mt6370_adc_driver = {
> +       .driver = {
> +               .name = "mt6370-adc",
> +               .of_match_table = mt6370_adc_of_id,
> +       },
> +       .probe = mt6370_adc_probe,
> +};
> +module_platform_driver(mt6370_adc_driver);
> +
> +MODULE_AUTHOR("ChiaEn Wu <chiaen_wu@richtek.com>");
> +MODULE_DESCRIPTION("MT6370 ADC Driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
