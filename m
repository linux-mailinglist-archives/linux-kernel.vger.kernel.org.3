Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63707487344
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiAGHD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAGHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:03:55 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4227C061245;
        Thu,  6 Jan 2022 23:03:54 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id s19so4743356qtc.5;
        Thu, 06 Jan 2022 23:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nu6xSZmD/9stdGxoHCg7LbxM+/K6TO3sS+qGpWknagg=;
        b=HTvMv7ycYLO0GTdKcnZh7tZYMV4mh9SFFFdzyF01FW72liMV1xbMBsobV0R5xikFlI
         HUPV2JthuqLcKYzsoKgLeio2AnECdZ3sxdTVYWhZXnk7JhERde17Opg+y5eQ+Pp6/3B+
         n9vB/tYuS0oAl58D6RtLA5k0gxuupOeFAYZ4lD0cSObbYyXdEpHQeJULI+6/aXgYuNgs
         lgrNp0RXBFIt31Uh9pmwYdxGb95OuTQr7PHXIkg9YIRQMcIF7KQoVyfb3i5mStcUlWj8
         +08V+21OkTFiPvAOrYqTjYLbKzVtFl2umvC7BfaYjz/rqXdK3nf1CZqR5LBjljsP3SPG
         NV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nu6xSZmD/9stdGxoHCg7LbxM+/K6TO3sS+qGpWknagg=;
        b=Ugw0FgB7Kc36fwMTFzy6q6o9LDbmmDy1AUXSccdsYHReLbjQ/oLe2d9Wfx6nzIBX8U
         bkJzJ6ArPd+x60Gf11JZaE2s/Tjt6109jdqqFfpb6rutnSzpEo/mKgWmlHTwptwvIotU
         /Amegi/vCCsxWMuwW+NqB6NcB34s5oF9j5hv/zIsgPFTX1IPkDAa6KGR5QVIfdMe0RmW
         t8vJkrmzgsOXhxi4nZ1H8NSjV8UotKgg/TNsa9Qk8LjrpQMX+7kNhvR2A53+X8qo9qsq
         MBHqq+UgzvMF8i0ymUEmvU9J3AW2N/K05HFCklboOg14YD31NPZU7/MvsnhivxRW7sAr
         ibaQ==
X-Gm-Message-State: AOAM533cxs4swKsmAvqGyivh9FJzt9xrImulXWIeZjvAuit38BYMPg8X
        tjuHBZm5GMOgXU+GoQEJQ4q03Vm85lM63FfF074=
X-Google-Smtp-Source: ABdhPJzFzl4cFrXxpyEe7Q5Ee59ybRcAAAQh0WVE6gzbZRNdh/x00cyZmXoXlZ+fBgYGJTJEob0UlZdv9Bod/KILk60=
X-Received: by 2002:a05:622a:5cd:: with SMTP id d13mr53968952qtb.47.1641539033929;
 Thu, 06 Jan 2022 23:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-4-gengcixi@gmail.com>
In-Reply-To: <20220106125947.139523-4-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 7 Jan 2022 15:04:35 +0800
Message-ID: <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: sc27xx: structure adjuststment and optimization
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, jic23@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:
>
> From: Cixi Geng <cixi.geng1@unisoc.com>
>
> Introduce one variant device data structure to be compatible
> with SC2731 PMIC since it has different scale and ratio calculation
> and so on.
>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index aee076c8e2b1..d2712e54ee79 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -12,9 +12,9 @@
>  #include <linux/slab.h>
>
>  /* PMIC global registers definition */
> -#define SC27XX_MODULE_EN               0xc08
> +#define SC2731_MODULE_EN               0xc08
>  #define SC27XX_MODULE_ADC_EN           BIT(5)
> -#define SC27XX_ARM_CLK_EN              0xc10
> +#define SC2731_ARM_CLK_EN              0xc10
>  #define SC27XX_CLK_ADC_EN              BIT(5)
>  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
>
> @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
>         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
>         u32 base;
>         int irq;
> +       const struct sc27xx_adc_variant_data *var_data;
> +};
> +
> +/*
> + * Since different PMICs of SC27xx series can have different
> + * address and ratio, we should save ratio config and base
> + * in the device data structure.
> + */
> +struct sc27xx_adc_variant_data {
> +       u32 module_en;
> +       u32 clk_en;
> +       u32 scale_shift;
> +       u32 scale_mask;
> +       const struct sc27xx_adc_linear_graph *bscale_cal;
> +       const struct sc27xx_adc_linear_graph *sscale_cal;
> +       void (*init_scale)(struct sc27xx_adc_data *data);
> +       int (*get_ratio)(int channel, int scale);
>  };
>
>  struct sc27xx_adc_linear_graph {
> @@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
>         100, 341,
>  };
>
> +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
> +       4200, 850,
> +       3600, 728,
> +};
> +
> +static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
> +       1000, 838,
> +       100, 84,
> +};

The original big_scale_graph_calib and small_scale_graph_calib are for
SC2731 PMIC, why add new structure definition for SC2731?

> +
>  static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
>         4200, 856,
>         3600, 733,
> @@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>         size_t len;
>
>         if (big_scale) {
> -               calib_graph = &big_scale_graph_calib;
> +               calib_graph = data->var_data->bscale_cal;
>                 graph = &big_scale_graph;
>                 cell_name = "big_scale_calib";
>         } else {
> -               calib_graph = &small_scale_graph_calib;
> +               calib_graph = data->var_data->sscale_cal;
>                 graph = &small_scale_graph;
>                 cell_name = "small_scale_calib";
>         }
> @@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>         return 0;
>  }
>
> -static int sc27xx_adc_get_ratio(int channel, int scale)
> +static int sc2731_adc_get_ratio(int channel, int scale)
>  {
>         switch (channel) {
>         case 1:
> @@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int channel, int scale)
>         return SC27XX_VOLT_RATIO(1, 1);
>  }
>
> +/*
> + * According to the datasheet set specific value on some channel.
> + */
> +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> +{
> +       int i;
> +
> +       for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> +               if (i == 5)
> +                       data->channel_scale[i] = 1;
> +               else
> +                       data->channel_scale[i] = 0;
> +       }
> +}

This is unnecessary I think, please see sc27xx_adc_write_raw() that
can set the channel scale.

> +
>  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                            int scale, int *val)
>  {
> @@ -208,10 +250,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                 goto disable_adc;
>
>         /* Configure the channel id and scale */
> -       tmp = (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MASK;
> +       tmp = (scale << data->var_data->scale_shift) & data->var_data->scale_mask;
>         tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
>         ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CH_CFG,
> -                                SC27XX_ADC_CHN_ID_MASK | SC27XX_ADC_SCALE_MASK,
> +                                SC27XX_ADC_CHN_ID_MASK |
> +                                data->var_data->scale_mask,
>                                  tmp);
>         if (ret)
>                 goto disable_adc;
> @@ -262,8 +305,9 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
>                                   int channel, int scale,
>                                   u32 *div_numerator, u32 *div_denominator)
>  {
> -       u32 ratio = sc27xx_adc_get_ratio(channel, scale);
> +       u32 ratio;
>
> +       ratio = data->var_data->get_ratio(channel, scale);
>         *div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
>         *div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
>  }
> @@ -432,13 +476,13 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  {
>         int ret;
>
> -       ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> +       ret = regmap_update_bits(data->regmap, data->var_data->module_en,
>                                  SC27XX_MODULE_ADC_EN, SC27XX_MODULE_ADC_EN);
>         if (ret)
>                 return ret;
>
>         /* Enable ADC work clock and controller clock */
> -       ret = regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> +       ret = regmap_update_bits(data->regmap, data->var_data->clk_en,
>                                  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
>                                  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
>         if (ret)
> @@ -456,10 +500,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>         return 0;
>
>  disable_clk:
> -       regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> +       regmap_update_bits(data->regmap, data->var_data->clk_en,
>                            SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
>  disable_adc:
> -       regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> +       regmap_update_bits(data->regmap, data->var_data->module_en,
>                            SC27XX_MODULE_ADC_EN, 0);
>
>         return ret;
> @@ -470,21 +514,39 @@ static void sc27xx_adc_disable(void *_data)
>         struct sc27xx_adc_data *data = _data;
>
>         /* Disable ADC work clock and controller clock */
> -       regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> +       regmap_update_bits(data->regmap, data->var_data->clk_en,
>                            SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
>
> -       regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> +       regmap_update_bits(data->regmap, data->var_data->module_en,
>                            SC27XX_MODULE_ADC_EN, 0);
>  }
>
> +static const struct sc27xx_adc_variant_data sc2731_data = {
> +       .module_en = SC2731_MODULE_EN,
> +       .clk_en = SC2731_ARM_CLK_EN,
> +       .scale_shift = SC27XX_ADC_SCALE_SHIFT,
> +       .scale_mask = SC27XX_ADC_SCALE_MASK,
> +       .bscale_cal = &sc2731_big_scale_graph_calib,
> +       .sscale_cal = &sc2731_small_scale_graph_calib,
> +       .init_scale = sc2731_adc_scale_init,
> +       .get_ratio = sc2731_adc_get_ratio,
> +};
> +
>  static int sc27xx_adc_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
>         struct sc27xx_adc_data *sc27xx_data;
> +       const struct sc27xx_adc_variant_data *pdata;
>         struct iio_dev *indio_dev;
>         int ret;
>
> +       pdata = of_device_get_match_data(dev);
> +       if (!pdata) {
> +               dev_err(dev, "No matching driver data found\n");
> +               return -EINVAL;
> +       }
> +
>         indio_dev = devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
>         if (!indio_dev)
>                 return -ENOMEM;
> @@ -520,6 +582,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>         }
>
>         sc27xx_data->dev = dev;
> +       sc27xx_data->var_data = pdata;
> +       sc27xx_data->var_data->init_scale(sc27xx_data);
>
>         ret = sc27xx_adc_enable(sc27xx_data);
>         if (ret) {
> @@ -546,7 +610,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id sc27xx_adc_of_match[] = {
> -       { .compatible = "sprd,sc2731-adc", },
> +       { .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
> --
> 2.25.1
>


-- 
Baolin Wang
