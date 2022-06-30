Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFBE5613F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiF3IAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiF3H7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:59:44 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E00D41326;
        Thu, 30 Jun 2022 00:59:40 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c1d580e4bso38950797b3.3;
        Thu, 30 Jun 2022 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOxl2Prqz6UobmRg9Gh2VJX2DH6DwQfzt/6gpga1U80=;
        b=k364C5o302VfMSjO+US499AY6pLpTK0cnveuqT6ZIRtBoAjVQlSTEQ5WoWuMvO/eag
         LT3YIWg2wxvAfEKBiIcM2mMJYXqWJR43An1wUArVV7rKyC6TGCkcr3OurLXa2UnzYWXh
         JKJSvk5ihD0tmavzy+fPPlVNe+8y+ivN7UWlhBjFWXMks9LNXrf85/fChZK5Xof6ft+4
         i4fdV4FOfisunz/Ar/RbNfk+oYrJtpIj3acChv/QQUG43D+P0EtZkq99L7DrS5Ak6KHF
         Gf3Vd9OCpnAY5DqVj4U+uL4fUOkvdYP9s77CyKYXTACpVISx574IeoekGA/eSVutaIhs
         a5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOxl2Prqz6UobmRg9Gh2VJX2DH6DwQfzt/6gpga1U80=;
        b=E/sZCCC/oQHHbT9c7Ly5aKZwVivhmVKO+2wFriEggir8khM2trx41OBSRiRjBs+xyg
         x/Gw9DISoMO8CZfTHWdLxuNw86pCjkQhW6/lXlEXdYtNifaN8ALEmA2W5KPJn0dGEKyc
         G78ZJx17n4EL2QbPHZkwfLlSvnp0GR1rcrG6hHgWKJbzt9a3mnPkdG/9/UoheQM+X0AZ
         7IkMCmRps6vPxPiC2fhrQcRZrk060Rsg09ToO5tTmZlc1h5iVRZEEQsJHNKdUXzh61f8
         S5HV2Wv+PE8PIEqpfiiCq7Lq0PIggBbfi0xUgo6kuus3rFDLo89iT0nZZoaKEFdcc2dC
         MGvA==
X-Gm-Message-State: AJIora/F8xHHrXiUw4eeP2PqZQ+wKuWqJVd6mYEup8Pl4lZP+27bhOSH
        VbDaJMFXzgvUtdPKDc2dLzObi2kWqlXw5eVHCHY=
X-Google-Smtp-Source: AGRyM1t3wtEphcNEcMF6Nplkyqq+0n5PHyDGxv+fc5YqZL/GkOdjri4zDM3AfJQbzmxhHHP4SQkNt4dpDO2QFeMjnQI=
X-Received: by 2002:a81:5d88:0:b0:318:31c1:56f3 with SMTP id
 r130-20020a815d88000000b0031831c156f3mr8910121ywb.18.1656575979520; Thu, 30
 Jun 2022 00:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-11-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-11-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 09:58:57 +0200
Message-ID: <CAHp75Vc71RZ7D32y=SWO0+gKnKZArtOU_V4COHK4donJNPJhBA@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] iio: adc: axp20x_adc: Add support for AXP192
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 4:30 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The AXP192 is identical to the AXP20x, except for the addition of
> two more GPIO ADC channels.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/iio/adc/axp20x_adc.c | 279 +++++++++++++++++++++++++++++++++++
>  1 file changed, 279 insertions(+)
>
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 75bda94dbce1..8d748b814f20 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -22,11 +22,19 @@
>  #include <linux/iio/machine.h>
>  #include <linux/mfd/axp20x.h>
>
> +#define AXP192_ADC_EN1_MASK                    GENMASK(7, 0)
> +#define AXP192_ADC_EN2_MASK                    (GENMASK(3, 0) | BIT(7))
> +
>  #define AXP20X_ADC_EN1_MASK                    GENMASK(7, 0)
>  #define AXP20X_ADC_EN2_MASK                    (GENMASK(3, 2) | BIT(7))
>
>  #define AXP22X_ADC_EN1_MASK                    (GENMASK(7, 5) | BIT(0))
>
> +#define AXP192_GPIO30_IN_RANGE_GPIO0           BIT(0)
> +#define AXP192_GPIO30_IN_RANGE_GPIO1           BIT(1)
> +#define AXP192_GPIO30_IN_RANGE_GPIO2           BIT(2)
> +#define AXP192_GPIO30_IN_RANGE_GPIO3           BIT(3)
> +
>  #define AXP20X_GPIO10_IN_RANGE_GPIO0           BIT(0)
>  #define AXP20X_GPIO10_IN_RANGE_GPIO1           BIT(1)
>
> @@ -71,6 +79,25 @@ struct axp20x_adc_iio {
>         const struct axp_data   *data;
>  };
>
> +enum axp192_adc_channel_v {
> +       AXP192_ACIN_V = 0,
> +       AXP192_VBUS_V,
> +       AXP192_TS_IN,
> +       AXP192_GPIO0_V,
> +       AXP192_GPIO1_V,
> +       AXP192_GPIO2_V,
> +       AXP192_GPIO3_V,
> +       AXP192_IPSOUT_V,
> +       AXP192_BATT_V,
> +};
> +
> +enum axp192_adc_channel_i {
> +       AXP192_ACIN_I = 0,
> +       AXP192_VBUS_I,
> +       AXP192_BATT_CHRG_I,
> +       AXP192_BATT_DISCHRG_I,
> +};
> +
>  enum axp20x_adc_channel_v {
>         AXP20X_ACIN_V = 0,
>         AXP20X_VBUS_V,
> @@ -158,6 +185,43 @@ static struct iio_map axp22x_maps[] = {
>   * The only exception is for the battery. batt_v will be in_voltage6_raw and
>   * charge current in_current6_raw and discharge current will be in_current7_raw.
>   */
> +static const struct iio_chan_spec axp192_adc_channels[] = {
> +       AXP20X_ADC_CHANNEL(AXP192_ACIN_V, "acin_v", IIO_VOLTAGE,
> +                          AXP20X_ACIN_V_ADC_H),
> +       AXP20X_ADC_CHANNEL(AXP192_ACIN_I, "acin_i", IIO_CURRENT,
> +                          AXP20X_ACIN_I_ADC_H),
> +       AXP20X_ADC_CHANNEL(AXP192_VBUS_V, "vbus_v", IIO_VOLTAGE,
> +                          AXP20X_VBUS_V_ADC_H),
> +       AXP20X_ADC_CHANNEL(AXP192_VBUS_I, "vbus_i", IIO_CURRENT,
> +                          AXP20X_VBUS_I_ADC_H),
> +       {
> +               .type = IIO_TEMP,
> +               .address = AXP20X_TEMP_ADC_H,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +                                     BIT(IIO_CHAN_INFO_SCALE) |
> +                                     BIT(IIO_CHAN_INFO_OFFSET),
> +               .datasheet_name = "pmic_temp",
> +       },
> +       AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
> +                                 AXP20X_GPIO0_V_ADC_H),
> +       AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO1_V, "gpio1_v", IIO_VOLTAGE,
> +                                 AXP20X_GPIO1_V_ADC_H),
> +       AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO2_V, "gpio2_v", IIO_VOLTAGE,
> +                                 AXP192_GPIO2_V_ADC_H),
> +       AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO3_V, "gpio3_v", IIO_VOLTAGE,
> +                                 AXP192_GPIO3_V_ADC_H),
> +       AXP20X_ADC_CHANNEL(AXP192_IPSOUT_V, "ipsout_v", IIO_VOLTAGE,
> +                          AXP20X_IPSOUT_V_HIGH_H),
> +       AXP20X_ADC_CHANNEL(AXP192_BATT_V, "batt_v", IIO_VOLTAGE,
> +                          AXP20X_BATT_V_H),
> +       AXP20X_ADC_CHANNEL(AXP192_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
> +                          AXP20X_BATT_CHRG_I_H),
> +       AXP20X_ADC_CHANNEL(AXP192_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRENT,
> +                          AXP20X_BATT_DISCHRG_I_H),
> +       AXP20X_ADC_CHANNEL(AXP192_TS_IN, "ts_v", IIO_VOLTAGE,
> +                          AXP20X_TS_IN_H),
> +};
> +
>  static const struct iio_chan_spec axp20x_adc_channels[] = {
>         AXP20X_ADC_CHANNEL(AXP20X_ACIN_V, "acin_v", IIO_VOLTAGE,
>                            AXP20X_ACIN_V_ADC_H),
> @@ -231,6 +295,27 @@ static const struct iio_chan_spec axp813_adc_channels[] = {
>                            AXP288_TS_ADC_H),
>  };
>
> +static int axp192_adc_raw(struct iio_dev *indio_dev,
> +                         struct iio_chan_spec const *chan, int *val)
> +{
> +       struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +       int ret, size;
> +
> +       if (chan->type == IIO_CURRENT &&
> +           (chan->channel == AXP192_BATT_CHRG_I ||
> +            chan->channel == AXP192_BATT_DISCHRG_I))
> +               size = 13;
> +       else
> +               size = 12;
> +
> +       ret = axp20x_read_variable_width(info->regmap, chan->address, size);
> +       if (ret < 0)
> +               return ret;
> +
> +       *val = ret;
> +       return IIO_VAL_INT;
> +}
> +
>  static int axp20x_adc_raw(struct iio_dev *indio_dev,
>                           struct iio_chan_spec const *chan, int *val)
>  {
> @@ -283,6 +368,44 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
>         return IIO_VAL_INT;
>  }
>
> +static int axp192_adc_scale_voltage(int channel, int *val, int *val2)
> +{
> +       switch (channel) {
> +       case AXP192_ACIN_V:
> +       case AXP192_VBUS_V:
> +               *val = 1;
> +               *val2 = 700000;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +
> +       case AXP192_GPIO0_V:
> +       case AXP192_GPIO1_V:
> +       case AXP192_GPIO2_V:
> +       case AXP192_GPIO3_V:
> +               *val = 0;
> +               *val2 = 500000;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +
> +       case AXP192_BATT_V:
> +               *val = 1;
> +               *val2 = 100000;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +
> +       case AXP192_IPSOUT_V:
> +               *val = 1;
> +               *val2 = 400000;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +
> +       case AXP192_TS_IN:
> +               /* 0.8 mV per LSB */
> +               *val = 0;
> +               *val2 = 800000;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
>  {
>         switch (channel) {
> @@ -386,6 +509,29 @@ static int axp20x_adc_scale_current(int channel, int *val, int *val2)
>         }
>  }
>
> +static int axp192_adc_scale(struct iio_chan_spec const *chan, int *val,
> +                           int *val2)
> +{
> +       switch (chan->type) {
> +       case IIO_VOLTAGE:
> +               return axp192_adc_scale_voltage(chan->channel, val, val2);
> +
> +       case IIO_CURRENT:
> +               /*
> +                * AXP192 current channels are identical to the AXP20x,
> +                * therefore we can re-use the scaling function.
> +                */
> +               return axp20x_adc_scale_current(chan->channel, val, val2);
> +
> +       case IIO_TEMP:
> +               *val = 100;
> +               return IIO_VAL_INT;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static int axp20x_adc_scale(struct iio_chan_spec const *chan, int *val,
>                             int *val2)
>  {
> @@ -445,6 +591,42 @@ static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
>         }
>  }
>
> +static int axp192_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
> +                                    int *val)
> +{
> +       struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +       unsigned int regval;
> +       int ret;
> +
> +       ret = regmap_read(info->regmap, AXP192_GPIO30_IN_RANGE, &regval);
> +       if (ret < 0)
> +               return ret;
> +
> +       switch (channel) {
> +       case AXP192_GPIO0_V:
> +               regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO0, regval);
> +               break;
> +
> +       case AXP192_GPIO1_V:
> +               regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO1, regval);
> +               break;
> +
> +       case AXP192_GPIO2_V:
> +               regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO2, regval);
> +               break;
> +
> +       case AXP192_GPIO3_V:
> +               regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO3, regval);
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       *val = regval ? 700000 : 0;
> +       return IIO_VAL_INT;
> +}
> +
>  static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>                                      int *val)
>  {
> @@ -473,6 +655,22 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>         return IIO_VAL_INT;
>  }
>
> +static int axp192_adc_offset(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan, int *val)
> +{
> +       switch (chan->type) {
> +       case IIO_VOLTAGE:
> +               return axp192_adc_offset_voltage(indio_dev, chan->channel, val);
> +
> +       case IIO_TEMP:
> +               *val = -1447;
> +               return IIO_VAL_INT;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static int axp20x_adc_offset(struct iio_dev *indio_dev,
>                              struct iio_chan_spec const *chan, int *val)
>  {
> @@ -489,6 +687,25 @@ static int axp20x_adc_offset(struct iio_dev *indio_dev,
>         }
>  }
>
> +static int axp192_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan, int *val,
> +                          int *val2, long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_OFFSET:
> +               return axp192_adc_offset(indio_dev, chan, val);
> +
> +       case IIO_CHAN_INFO_SCALE:
> +               return axp192_adc_scale(chan, val, val2);
> +
> +       case IIO_CHAN_INFO_RAW:
> +               return axp192_adc_raw(indio_dev, chan, val);
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static int axp20x_read_raw(struct iio_dev *indio_dev,
>                            struct iio_chan_spec const *chan, int *val,
>                            int *val2, long mask)
> @@ -549,6 +766,51 @@ static int axp813_read_raw(struct iio_dev *indio_dev,
>         }
>  }
>
> +static int axp192_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan, int val, int val2,
> +                           long mask)
> +{
> +       struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +       unsigned int regmask, regval;
> +
> +       /*
> +        * The AXP192 PMIC allows the user to choose between 0V and 0.7V offsets
> +        * for (independently) GPIO0-3 when in ADC mode.
> +        */
> +       if (mask != IIO_CHAN_INFO_OFFSET)
> +               return -EINVAL;
> +
> +       if (val != 0 && val != 700000)
> +               return -EINVAL;
> +
> +       switch (chan->channel) {
> +       case AXP192_GPIO0_V:
> +               regmask = AXP192_GPIO30_IN_RANGE_GPIO0;
> +               regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO0, !!val);
> +               break;
> +
> +       case AXP192_GPIO1_V:
> +               regmask = AXP192_GPIO30_IN_RANGE_GPIO1;
> +               regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO1, !!val);
> +               break;
> +
> +       case AXP192_GPIO2_V:
> +               regmask = AXP192_GPIO30_IN_RANGE_GPIO2;
> +               regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO2, !!val);
> +               break;
> +
> +       case AXP192_GPIO3_V:
> +               regmask = AXP192_GPIO30_IN_RANGE_GPIO3;
> +               regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO3, !!val);
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return regmap_update_bits(info->regmap, AXP192_GPIO30_IN_RANGE, regmask, regval);
> +}
> +
>  static int axp20x_write_raw(struct iio_dev *indio_dev,
>                             struct iio_chan_spec const *chan, int val, int val2,
>                             long mask)
> @@ -584,6 +846,11 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>         return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
>  }
>
> +static const struct iio_info axp192_adc_iio_info = {
> +       .read_raw = axp192_read_raw,
> +       .write_raw = axp192_write_raw,
> +};
> +
>  static const struct iio_info axp20x_adc_iio_info = {
>         .read_raw = axp20x_read_raw,
>         .write_raw = axp20x_write_raw,
> @@ -629,6 +896,16 @@ struct axp_data {
>         struct iio_map                  *maps;
>  };
>
> +static const struct axp_data axp192_data = {
> +       .iio_info = &axp192_adc_iio_info,
> +       .num_channels = ARRAY_SIZE(axp192_adc_channels),
> +       .channels = axp192_adc_channels,
> +       .adc_en1_mask = AXP192_ADC_EN1_MASK,
> +       .adc_en2_mask = AXP192_ADC_EN2_MASK,
> +       .adc_rate = axp20x_adc_rate,
> +       .maps = axp20x_maps,
> +};
> +
>  static const struct axp_data axp20x_data = {
>         .iio_info = &axp20x_adc_iio_info,
>         .num_channels = ARRAY_SIZE(axp20x_adc_channels),
> @@ -658,6 +935,7 @@ static const struct axp_data axp813_data = {
>  };
>
>  static const struct of_device_id axp20x_adc_of_match[] = {
> +       { .compatible = "x-powers,axp192-adc", .data = (void *)&axp192_data, },
>         { .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
>         { .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
>         { .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
> @@ -666,6 +944,7 @@ static const struct of_device_id axp20x_adc_of_match[] = {
>  MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
>
>  static const struct platform_device_id axp20x_adc_id_match[] = {
> +       { .name = "axp192-adc", .driver_data = (kernel_ulong_t)&axp192_data, },
>         { .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
>         { .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
>         { .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
