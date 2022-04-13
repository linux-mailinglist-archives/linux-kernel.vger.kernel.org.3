Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57F4FFA95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiDMPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiDMPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:48:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046715EBF7;
        Wed, 13 Apr 2022 08:45:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bg10so4831153ejb.4;
        Wed, 13 Apr 2022 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Pnp4ULPqXAWXDJDnJ6hpu6arXJ+roplkLjdaDjW8b0=;
        b=ieBvnif6uLuAzvAkhp0WVpVrlmNrYIQqvraNtFn8r3Dix/7ms+NI/GLi4vQJpMknrc
         taGL2w2jmyJYYfEFUO8V9+fz5kJONwJoqZasDxEeie2odxIFXwecQkPk7J1C3ErMJvLl
         OI1gM4jbnedIoWKI4eIzUv0TnyEMP+cwGkQwzkIBM6IJh0WlQKl+bQqCyy4jsRewca8m
         RRYEYOwagtu1GLK4AKpJDXYimfvDVQszATEP7ngtdl1wvkqOLJxmWpneIhR2dQculGVD
         FxNBVto4cFKrfCXzuj/HpKAqZuLe1BD+pdrNqq43UTjbpy0NPT8IXxQ3f9PiK1I9sPPa
         Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Pnp4ULPqXAWXDJDnJ6hpu6arXJ+roplkLjdaDjW8b0=;
        b=RtXgMH14h0nLrJ7kmxS//LlJ5Rp2WL23faaoZXlQYTfjNAFvN5h43GO4P9nqdHDqeB
         E/R5fMe1Krx7fW4pCn1k4ZV4I/1pydAXiDPQBmxGi931xMaH5JABmOy0n77Ykd2Ku8AJ
         2Paag/nimh2qVFjA01FSwIYM5gcLWrX0wh2PCk3FmTFYTEJrJLu9V1V0xC2HspTbhFJ3
         k7aIuzXELcaUZ04iuFOuc7hohZoJAlDWN7R/i8rd5milTE8VifXzgeJjf/SkLKkgtb94
         4aOcm6aP61lTytUkTgRhErWIzObt3XwMkqHQ7f2mbUTnB+qBH0oMIhoNDiGOCpJS6WV7
         S3ww==
X-Gm-Message-State: AOAM530L9F3lHApO7BiaT6Dvw32ZhLN4mWPaNdEBRCNvRKhLg2Ttlxc9
        MJTSsOUDCS1kG63e/+9Dt+CiLJnGRIhCFeUBAV0=
X-Google-Smtp-Source: ABdhPJzQLQmu2W5m6COoSNP+uuFC3IcDcfeC2sjIbtLEuWbPYX/QyPRuqc+svHYs71ggMHfxB6uv3FdBCqanqEfxpfs=
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id
 ho13-20020a1709070e8d00b006e019e79549mr39645887ejc.44.1649864746322; Wed, 13
 Apr 2022 08:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220413094011.185269-1-cosmin.tanislav@analog.com> <20220413094011.185269-3-cosmin.tanislav@analog.com>
In-Reply-To: <20220413094011.185269-3-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Apr 2022 18:41:34 +0300
Message-ID: <CAHp75VfzX8u45J3634yN5p-QTeT7w0Bos27OxeWOsb3MQ2VRVw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] iio: adc: ad4130: add AD4130 driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
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

On Wed, Apr 13, 2022 at 1:41 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:


Thanks for the contribution, my comments below.

> AD4130-8 is an ultra-low power, high precision,
> measurement solution for low bandwidth battery
> operated applications.
>
> The fully integrated AFE (Analog Front-End)
> includes a multiplexer for up to 16 single-ended
> or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip
> reference and oscillator, selectable filter
> options, smart sequencer, sensor biasing and
> excitation options, diagnostics, and a FIFO
> buffer.

Indentation issue as per previous patches.

...

> +// SPDX-License-Identifier: GPL-2.0+

The

// SPDX-License-Identifier: GPL-2.0-or-later

can be a bit more explicit, but it's up to your company lawyers.

...

> +#include <asm/div64.h>
> +#include <asm/unaligned.h>

Please, move this after linux/*

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>

Looks like iio.h is missed, in any case, can you split this group of
headers and put it after all the rest of linux/* and asm/* ? Ah, you
even have them below, so move these there.

> +#include <linux/module.h>

> +#include <linux/of_irq.h>

Get rid of this one.

> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

...

> +#define AD4130_8_NAME                  "ad4130-8"

What the meaning of -8 ? Is it number of channels? Or is it part of
the official model (part number)? Can we see, btw, Datasheet: tag with
a corresponding link in the commit message?

...

> +#define AD4130_RESET_CLK_COUNT         64
> +#define AD4130_RESET_BUF_SIZE          (AD4130_RESET_CLK_COUNT / 8)

To be more precise shouldn't the above need to have DIV_ROUND_UP() ?

...

> +#define AD4130_SOFT_RESET_SLEEP                (160 * 1000000 / AD4130_MCLK_FREQ_76_8KHZ)

Units? Also, can you use definitions from units.h?

...

> +#define AD4130_FREQ_FACTOR             1000000000ull
> +#define AD4130_DB3_FACTOR              1000

Ditto.

...

> +enum ad4130_mclk_sel {
> +       AD4130_MCLK_76_8KHZ,
> +       AD4130_MCLK_76_8KHZ_OUT,
> +       AD4130_MCLK_76_8KHZ_EXT,
> +       AD4130_MCLK_153_6KHZ_EXT,
> +       AD4130_MCLK_SEL_MAX,

No comma after MAX, if I understood correctly that it's a terminator.
Ditto for other MAXes in the other enums.

> +};

...

> +enum ad4130_fifo_mode {
> +       AD4130_FIFO_MODE_DISABLED = 0b00,
> +       AD4130_FIFO_MODE_WATERMARK = 0b01,
> +};
> +
> +enum ad4130_mode {
> +       AD4130_MODE_CONTINUOUS = 0b0000,
> +       AD4130_MODE_IDLE = 0b0100,
> +};

0b?! Hmm... Not that this is bad, just not so usual :-)

...

> +enum ad4130_pin_function {
> +       AD4130_PIN_FN_NONE,
> +       AD4130_PIN_FN_SPECIAL = 1 << 0,
> +       AD4130_PIN_FN_DIFF = 1 << 1,
> +       AD4130_PIN_FN_EXCITATION = 1 << 2,
> +       AD4130_PIN_FN_VBIAS = 1 << 3,

Why not BIT()?

> +};

...

> +#define AD4130_SETUP_SIZE              offsetof(struct ad4130_setup_info, \
> +                                                enabled_channels)

It's uglier than simply

#define AD4130_SETUP_SIZE              offsetof(struct
ad4130_setup_info, enabled_channels)

or

#define AD4130_SETUP_SIZE              \
        offsetof(struct ad4130_setup_info, enabled_channels)

...

> +struct ad4130_filter_config {
> +       enum ad4130_filter_mode         filter_mode;
> +       unsigned int                    odr_div;
> +       unsigned int                    fs_max;
> +       unsigned int                    db3_div;
> +       enum iio_available_type         samp_freq_avail_type;
> +       int                             samp_freq_avail_len;
> +       int                             samp_freq_avail[3][2];
> +       enum iio_available_type         db3_freq_avail_type;
> +       int                             db3_freq_avail_len;
> +       int                             db3_freq_avail[3][2];

These 3:s can be defined?

> +};

...

> +       int                             scale_tbls[AD4130_REF_SEL_MAX]
> +                                                 [AD4130_PGA_NUM][2];

Why not on one line?

...

> +       u32                     int_pin_sel;
> +       bool                    int_ref_en;
> +       u32                     int_ref_uv;
> +       u32                     mclk_sel;
> +       bool                    bipolar;

You may save a few bytes if you group bool:s.

...

> +       u8                      fifo_rx_buf[AD4130_FIFO_SIZE *
> +                                           AD4130_FIFO_MAX_SAMPLE_SIZE];

One line?

Also it might be good to add a static_assert() to make sure that
multiplication don't overflow.

...


> +static int ad4130_get_reg_size(struct ad4130_state *st, unsigned int reg,
> +                              unsigned int *size)
> +{

> +       if (reg >= ARRAY_SIZE(ad4130_reg_size))
> +               return -EINVAL;

When this condition is true?

> +       if (reg == AD4130_REG_DATA) {
> +               *size = ad4130_data_reg_size(st);
> +               return 0;
> +       }
> +
> +       *size = ad4130_reg_size[reg];

> +

Redundant blank line.

> +       if (!*size)
> +               return -EINVAL;
> +
> +       return 0;
> +}

...

> +       regmap_update_bits(st->regmap, AD4130_REG_IO_CONTROL, mask,
> +                          value ? mask : 0);

One line?

No error check?

> +}

...

> +static int ad4130_set_watermark_interrupt_en(struct ad4130_state *st, bool en)
> +{
> +       return regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> +                                 AD4130_WATERMARK_INT_EN_MASK,
> +                                 en ? AD4130_WATERMARK_INT_EN_MASK : 0);

I believe with temporary variable for mask it will be neater.

> +}

...

> +       if (setup_info->enabled_channels)
> +               return -EINVAL;

-EBUSY?

...

> +       ret = regmap_update_bits(st->regmap, AD4130_REG_CHANNEL_X(channel),
> +                                AD4130_CHANNEL_EN_MASK,
> +                                status ? AD4130_CHANNEL_EN_MASK : 0);

Temporary variable for mask?

...

> +static void ad4130_freq_to_fs(enum ad4130_filter_mode filter_mode,
> +                             int val, int val2, unsigned int *fs, bool db3)
> +{
> +       const struct ad4130_filter_config *filter_config =
> +               &ad4130_filter_configs[filter_mode];
> +       unsigned long long dividend, divisor;
> +       int temp;
> +
> +       dividend = filter_config->fs_max * filter_config->odr_div *
> +                  (val * AD4130_FREQ_FACTOR + val2);
> +       divisor = AD4130_MAX_ODR * AD4130_FREQ_FACTOR;
> +
> +       if (db3) {
> +               dividend *= AD4130_DB3_FACTOR;
> +               divisor *= filter_config->db3_div;
> +       }
> +
> +       temp = AD4130_FS_MIN + filter_config->fs_max -
> +              DIV64_U64_ROUND_CLOSEST(dividend, divisor);
> +
> +       if (temp < AD4130_FS_MIN)
> +               temp = AD4130_FS_MIN;
> +       else if (temp > filter_config->fs_max)
> +               temp = filter_config->fs_max;
> +
> +       *fs = temp;

Would be nice to put a comment explaining the math behind this code.

> +}
> +
> +static void ad4130_fs_to_freq(enum ad4130_filter_mode filter_mode,
> +                             unsigned int fs, int *val, int *val2, bool db3)
> +{
> +       const struct ad4130_filter_config *filter_config =
> +               &ad4130_filter_configs[filter_mode];
> +       unsigned int dividend, divisor;
> +       u64 temp;
> +
> +       dividend = (filter_config->fs_max - fs + AD4130_FS_MIN) *
> +                  AD4130_MAX_ODR;
> +       divisor = filter_config->fs_max * filter_config->odr_div;
> +
> +       if (db3) {
> +               dividend *= filter_config->db3_div;
> +               divisor *= AD4130_DB3_FACTOR;
> +       }
> +
> +       temp = div_u64(dividend * AD4130_FREQ_FACTOR, divisor);
> +       *val = div_u64_rem(temp, AD4130_FREQ_FACTOR, val2);


Ditto.

> +}

...

> + out:

out_unlock: ?
Ditto for similar cases.

> +       mutex_unlock(&st->lock);
> +
> +       return ret;

...

> +static const struct iio_enum ad4130_filter_mode_enum = {
> +       .items = ad4130_filter_modes_str,
> +       .num_items = ARRAY_SIZE(ad4130_filter_modes_str),
> +       .set = ad4130_set_filter_mode,

> +       .get = ad4130_get_filter_mode

+ Comma at the end.

> +};

...

> +static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[] = {
> +       IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
> +       IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
> +                          &ad4130_filter_mode_enum),

> +       { },

No comma for terminator.

> +};

...

> +               *val = st->bipolar ? -(1 << (chan->scan_type.realbits - 1)) : 0;

Hmm... It seems like specific way to have a sign_extended, or actually
reduced) mask.
Can you rewrite it with the (potential)UB-free approach?

(Note, that if realbits == 32, this will have a lot of fun in
accordance with C standard.)

...

> +               *vals = (int *)st->scale_tbls[setup_info->ref_sel];

Can we get rid of casting here and in the similar cases?

...

> +       for (i = 0; i < indio_dev->num_channels; i++) {
> +               bool status = test_bit(i, scan_mask);
> +
> +               if (!status)
> +                       continue;

Can't you use for_each_set_bit() instead?

> +       }

...

> +static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +       struct ad4130_state *st = iio_priv(indio_dev);
> +       unsigned int eff;

> +       int ret = 0;

Redundant assignment

> +
> +       if (val > AD4130_FIFO_SIZE)
> +               return -EINVAL;
> +
> +       /*
> +        * Always set watermark to a multiple of the number of enabled channels
> +        * to avoid making the FIFO unaligned.
> +        */
> +       eff = rounddown(val, st->num_enabled_channels);
> +
> +       mutex_lock(&st->lock);
> +
> +       ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> +                                AD4130_WATERMARK_MASK,
> +                                FIELD_PREP(AD4130_WATERMARK_MASK,
> +                                           ad4130_watermark_reg_val(eff)));

Temporary variable for mask?

> +       if (ret)
> +               goto out;
> +
> +       st->effective_watermark = eff;
> +       st->watermark = val;
> +
> +out:

out_unlock: ?

> +       mutex_unlock(&st->lock);
> +
> +       return ret;
> +}

...

> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> +static IIO_CONST_ATTR(hwfifo_watermark_max,
> +                     __stringify(AD4130_FIFO_SIZE));
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +                      ad4130_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +                      ad4130_get_fifo_enabled, NULL, 0);

Can these all be oneliners?

...

> +static const struct attribute *ad4130_fifo_attributes[] = {
> +       &iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +       &iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +       &iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +       &iio_dev_attr_hwfifo_enabled.dev_attr.attr,

> +       NULL,

No comma for terminator.

> +};

...

> +static int ad4130_get_ref_voltage(struct ad4130_state *st,
> +                                 enum ad4130_ref_sel ref_sel,
> +                                 unsigned int *ref_uv)
> +{
> +       struct device *dev = &st->spi->dev;
> +       int ret;
> +
> +       switch (ref_sel) {
> +       case AD4130_REF_REFIN1:
> +               ret = regulator_get_voltage(st->regulators[2].consumer);
> +               break;
> +       case AD4130_REF_REFIN2:
> +               ret = regulator_get_voltage(st->regulators[3].consumer);
> +               break;
> +       case AD4130_REF_AVDD_AVSS:
> +               ret = regulator_get_voltage(st->regulators[0].consumer);
> +               break;
> +       case AD4130_REF_REFOUT_AVSS:

> +               if (!st->int_ref_en) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
> +               ret = st->int_ref_uv;
> +               break;

Can be one if-else instead.

> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       if (ret <= 0)

= 0 ?! Can you elaborate, please, this case taking into account below?

> +               return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> +                                    ref_sel);
> +
> +       if (ref_uv)
> +               *ref_uv = ret;
> +
> +       return 0;
> +}

...

> +       ret = ad4130_get_ref_voltage(st, setup_info->ref_sel, NULL);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

  return ad4130_get_ref_voltage(st, setup_info->ref_sel, NULL);

...

> +       fwnode_property_read_u32(child, "adi,excitation-pin-0",
> +                                &chan_info->iout0);

No default and/or error check?

...

> +       fwnode_property_read_u32(child, "adi,excitation-pin-1",
> +                                &chan_info->iout1);

Ditto.

...

> +static int ad4130_parse_fw_children(struct iio_dev *indio_dev)
> +{
> +       struct ad4130_state *st = iio_priv(indio_dev);
> +       struct device *dev = &st->spi->dev;
> +       struct fwnode_handle *child;
> +       int ret;
> +
> +       indio_dev->channels = st->chans;
> +
> +       device_for_each_child_node(dev, child) {
> +               ret = ad4130_parse_fw_channel(indio_dev, child);
> +               if (ret)
> +                       break;
> +       }

> +       fwnode_handle_put(child);

There is no need to put fwnode if child is NULL. Moreover, the above
pattern might be percepted wrongly, i.e. one may think that
fwnode_handle_put() is a must after a loop.

> +       return ret;
> +}

...

> +       for (i = 0; i < ARRAY_SIZE(ad4130_int_pin_names); i++) {
> +               irq = of_irq_get_byname(dev->of_node, ad4130_int_pin_names[i]);

fwnode_irq_get_byname()

> +               if (irq > 0) {
> +                       st->int_pin_sel = i;
> +                       break;
> +               }
> +       }

...

> +               st->num_vbias_pins = ret;

I haven't checked this, but be sure that it won't overflow any
preallocated array in the code.

> +               ret = device_property_read_u32_array(dev, "adi,vbias-pins",
> +                                                    st->vbias_pins,
> +                                                    st->num_vbias_pins);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to read vbias pins\n");

...

> +               for (j = 0; j < AD4130_PGA_NUM; j++) {
> +                       unsigned int pow = st->chip_info->resolution + j -
> +                                          st->bipolar;
> +                       unsigned int nv = div_u64(((ref_uv * 1000000000ull) >>
> +                                                  pow), 1000);

Perhaps macros from units.h?

> +                       st->scale_tbls[i][j][0] = 0;
> +                       st->scale_tbls[i][j][1] = nv;
> +               }

...

> +       [ID_AD4130_8_24_LFCSP] = {
> +               .name = AD4130_8_NAME,
> +               .resolution = 24,

> +               .has_int_pin = false,

No need.

> +       },

...

> +       [ID_AD4130_8_16_LFCSP] = {
> +               .name = AD4130_8_NAME,
> +               .resolution = 16,

> +               .has_int_pin = false,

Ditto.

> +       },

...

> +static const struct of_device_id ad4130_of_match[] = {

> +       { },

No comma for terminator.

> +};

...

Can you explain why regmap locking is needed?

-- 
With Best Regards,
Andy Shevchenko
