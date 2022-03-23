Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8834A4E53A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiCWN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiCWN4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:56:31 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B27484E;
        Wed, 23 Mar 2022 06:55:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d15so1153073qty.8;
        Wed, 23 Mar 2022 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLMUXZLV0UZz0xnnrtW4YxpZGWSswDZ+GXd9YqR6CHY=;
        b=QRzgMv6MrdWyHSrD4uSZBIbUfq/WhX/SlcpWfs+o/6qRoKOf/nI8dM8norLKqNhG+o
         117HyQlclh/PBqxGgj6BK7YD5Oqqd3fSXNUoeCHkpinq0xVJ98TsGcF9Eu00oe+JCo52
         R4qZe8mjzhHC0sOcAcenKRMsmEZcOWWLCeDFhGsnSrYSHyPBzoQLwPXc6YzTcw++BUEP
         2qnm8+b/iqM/l3s1Pn1aANlEFHdMepGPuKBpLa1VT1h0KwKRcD8l7XEzpPq10t2s64jw
         6z/IeU01MqyAhhRD5immytPKjOQiOAeWRppjcM6f4tdrfS4ZFVd0J497vSvk/a1AMYwu
         4H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLMUXZLV0UZz0xnnrtW4YxpZGWSswDZ+GXd9YqR6CHY=;
        b=oi+K4NulYLK7AV1C8TrihbaGnWgrGS0cZUZ3tmTE/DeF+XzQZ1IyM3vk+WP8xv0uPf
         neyzA0bhjHt5SAKCuSragbhJGzFHMqQlQQR8zFh16z006FSTzQxxJLOssZpwmamsD5wd
         PhSxTC/ooomXpE88oe0HU/hHowjcby7AuLbljxPZW8ht1+0wapb/UUKoSzLR6w4OzJv/
         cmqHjfERPPIi84cUldVZyrPPfzPRcQTbHCOFiyHRNzTpYZnNeI5/Imwf1ZBxE5jkaMDo
         XO9a3vAKKXEE79zszGs+qESbl3zh+fhmQk7guIdqxZ9tcnEtJUi8FNMerCymxJ8ZheJQ
         aAgA==
X-Gm-Message-State: AOAM531/KSs0/4IRKfYXFbwaW7CX9s0MQNMKINYlt4wrN3uSXppEOWle
        1S4q/ViLEn9A9f7SoPDQlHVUf0K9OeRBdGvFKqpgmC07hW4=
X-Google-Smtp-Source: ABdhPJxiUccN6oEBsQKjEg1m4NM4h9V2bTwVMsKGnnHCCjX5QRJCOf6JTT5fKVcUvlq8pC6nhl8kEDISy58rarpfoDQ=
X-Received: by 2002:a05:622a:291:b0:2e1:fee4:8a56 with SMTP id
 z17-20020a05622a029100b002e1fee48a56mr20514265qtw.624.1648043700579; Wed, 23
 Mar 2022 06:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220311164628.378849-1-gengcixi@gmail.com> <20220311164628.378849-4-gengcixi@gmail.com>
In-Reply-To: <20220311164628.378849-4-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 23 Mar 2022 21:55:47 +0800
Message-ID: <CADBw62pAitwJK6cf_zMo-N=-NGf3Y5S9SPBRcLpbz5yzNefQOQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] iio: adc: sc27xx: structure adjuststment and optimization
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 12:47 AM Cixi Geng <gengcixi@gmail.com> wrote:
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
>  drivers/iio/adc/sc27xx_adc.c | 95 ++++++++++++++++++++++++++++++------
>  1 file changed, 80 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index aee076c8e2b1..68629fbcfec5 100644
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
> @@ -103,6 +120,17 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
>         100, 341,
>  };
>
> +/* Add these for sc2731 pmic, and the [big|small]_scale_graph_calib for common's */
> +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
> +       4200, 850,
> +       3600, 728,
> +};
> +
> +static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
> +       1000, 838,
> +       100, 84,
> +};
> +
>  static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
>         4200, 856,
>         3600, 733,
> @@ -130,11 +158,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
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

Now which function will use big_scale_graph_calib and
small_scale_graph_calib?  Seems you add an unused warning?

>                 graph = &small_scale_graph;
>                 cell_name = "small_scale_calib";
>         }
> @@ -160,7 +188,7 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>         return 0;
>  }
>
> -static int sc27xx_adc_get_ratio(int channel, int scale)
> +static int sc2731_adc_get_ratio(int channel, int scale)
>  {
>         switch (channel) {
>         case 1:
> @@ -185,6 +213,21 @@ static int sc27xx_adc_get_ratio(int channel, int scale)
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

Can you add some comments to explain why channel 5 needs to set scale to 1?

> +               else
> +                       data->channel_scale[i] = 0;
> +       }
> +}
> +
>  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                            int scale, int *val)
>  {
> @@ -208,10 +251,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
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
> @@ -262,8 +306,9 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
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
> @@ -432,13 +477,13 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
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
> @@ -456,10 +501,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
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
> @@ -470,21 +515,39 @@ static void sc27xx_adc_disable(void *_data)
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
> @@ -520,6 +583,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>         }
>
>         sc27xx_data->dev = dev;
> +       sc27xx_data->var_data = pdata;
> +       sc27xx_data->var_data->init_scale(sc27xx_data);
>
>         ret = sc27xx_adc_enable(sc27xx_data);
>         if (ret) {
> @@ -546,7 +611,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
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
