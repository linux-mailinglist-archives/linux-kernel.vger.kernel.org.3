Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA02C48736A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiAGHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiAGHPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:15:35 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590BC061245;
        Thu,  6 Jan 2022 23:15:35 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 69so5145456qkd.6;
        Thu, 06 Jan 2022 23:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56HRITo7ChMleW+BeqNrnKkV3RGPtDAJozi1fXmCKYk=;
        b=AcT2Nf+Kkq5z+5Q+YBhcv1657RHH1H2Wo67LGSeiLzPMxp3pYRGTnZo7hSi3slNwBa
         qgjUPcL4k5dF1FalGbkC1AVudL1/J/KMVzIfLlbfzjxqOYjUu0WNvcJzIgOihTOzqPIB
         uFgZKrvmSabA1rDHplh6amCjM2mY0sAW58+dfQl8OoOB2ULS5qeg233BYA3iq0j1K3tj
         PZlmYksjuLASEqt9/8cZVlN4s7w/7p6xj8ds1wcO2C6gGaViYMHrfnYPcwFY/AZGFFJY
         myvkyR/WWe5ZJJxUS2l97oVTKPHB+IWBV/bKOeHdayrR8AscIpuzKfJsvGYqd8B0noS9
         R3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56HRITo7ChMleW+BeqNrnKkV3RGPtDAJozi1fXmCKYk=;
        b=YAiaJzOrwcw/e5d4o2Bo8Qbkhhbm6VEYmFZcYxGdy2/QbXOLNCHepFj8k2RWSM8UTM
         8Nue7qpQVMiP1+BRliQPQfPmqhtvfS6y/U7zFh2LTE/8BUa1PoKnScLlSPjaXL8YvLBB
         X6+nqNe74i0e+xH2Pp8FKr5Df4jK61hqdwYcwOvAcWtvS2lqAcjyVkEMtOFIIQrXhNP/
         fC+67yi+Hha9rrf6cHN2Y24B2k1DN5FW7t10SNl/BUmM0VmyZkMNxv6TsFbNjTlPkUP4
         2lQtkMBjgWZm4PQq74vrRMjIabktPcnthcG681r03Nw4+3/SRzIuUHQ1TRxNx2Kr9Uze
         fJUg==
X-Gm-Message-State: AOAM532nmkBaPAsBLKboWIeKBQn0PFqh6WiNkGF1zRSWXYsjNkucVLnu
        K+zQ9XnlrAtEZXlR8Ida/TPBmFaT65FJEsC+/nuV4V3GG/I=
X-Google-Smtp-Source: ABdhPJwq6eQ2CKI1OfrXtFI9iWxxVBMhEYFEjMnixA8FbPdFXnHQu+kPWZqmKitBnxQmcoAPnYRPEeJQ1QkysCc0K5E=
X-Received: by 2002:a05:620a:4105:: with SMTP id j5mr579994qko.335.1641539734168;
 Thu, 06 Jan 2022 23:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-5-gengcixi@gmail.com>
In-Reply-To: <20220106125947.139523-5-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 7 Jan 2022 15:16:15 +0800
Message-ID: <CADBw62oowgYKa74BuF3CnjdwiuK8tPpqLB7u9+E8zKD27ADYdA@mail.gmail.com>
Subject: Re: [PATCH 4/7] iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
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
> sc2720 and sc2721 is the product of sc27xx series.
>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 198 +++++++++++++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
>
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index d2712e54ee79..7b5c66660ac9 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -9,11 +9,13 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>
>  /* PMIC global registers definition */
>  #define SC2731_MODULE_EN               0xc08
>  #define SC27XX_MODULE_ADC_EN           BIT(5)
> +#define SC2721_ARM_CLK_EN              0xc0c
>  #define SC2731_ARM_CLK_EN              0xc10
>  #define SC27XX_CLK_ADC_EN              BIT(5)
>  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> @@ -37,7 +39,9 @@
>  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
>  #define SC27XX_ADC_CHN_ID_MASK         GENMASK(4, 0)
>  #define SC27XX_ADC_SCALE_MASK          GENMASK(10, 9)
> +#define SC2721_ADC_SCALE_MASK          BIT(5)
>  #define SC27XX_ADC_SCALE_SHIFT         9
> +#define SC2721_ADC_SCALE_SHIFT         5
>
>  /* Bits definitions for SC27XX_ADC_INT_EN registers */
>  #define SC27XX_ADC_IRQ_EN              BIT(0)
> @@ -67,8 +71,21 @@
>  #define SC27XX_RATIO_NUMERATOR_OFFSET  16
>  #define SC27XX_RATIO_DENOMINATOR_MASK  GENMASK(15, 0)
>
> +/* ADC specific channel reference voltage 3.5V */
> +#define SC27XX_ADC_REFVOL_VDD35                3500000
> +
> +/* ADC default channel reference voltage is 2.8V */
> +#define SC27XX_ADC_REFVOL_VDD28                2800000
> +
> +enum sc27xx_pmic_type {
> +       SC27XX_ADC,
> +       SC2721_ADC,
> +};
> +
>  struct sc27xx_adc_data {
> +       struct iio_dev *indio_dev;

Why add an unused member?

>         struct device *dev;
> +       struct regulator *volref;
>         struct regmap *regmap;
>         /*
>          * One hardware spinlock to synchronize between the multiple
> @@ -87,6 +104,7 @@ struct sc27xx_adc_data {
>   * in the device data structure.
>   */
>  struct sc27xx_adc_variant_data {
> +       enum sc27xx_pmic_type pmic_type;
>         u32 module_en;
>         u32 clk_en;
>         u32 scale_shift;
> @@ -187,6 +205,94 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>         return 0;
>  }
>
> +static int sc2720_adc_get_ratio(int channel, int scale)
> +{
> +       switch (channel) {
> +       case 14:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(68, 900);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(68, 1760);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(68, 2327);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(68, 3654);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       case 16:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(48, 100);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(480, 1955);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(480, 2586);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(48, 406);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       case 21:
> +       case 22:
> +       case 23:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(3, 8);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(375, 1955);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(375, 2586);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(300, 3248);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       default:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(1000, 1955);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(1000, 2586);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(100, 406);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       }
> +       return SC27XX_VOLT_RATIO(1, 1);
> +}
> +
> +static int sc2721_adc_get_ratio(int channel, int scale)
> +{
> +       switch (channel) {
> +       case 1:
> +       case 2:
> +       case 3:
> +       case 4:
> +               return scale ? SC27XX_VOLT_RATIO(400, 1025) :
> +                       SC27XX_VOLT_RATIO(1, 1);
> +       case 5:
> +               return SC27XX_VOLT_RATIO(7, 29);
> +       case 7:
> +       case 9:
> +               return scale ? SC27XX_VOLT_RATIO(100, 125) :
> +                       SC27XX_VOLT_RATIO(1, 1);
> +       case 14:
> +               return SC27XX_VOLT_RATIO(68, 900);
> +       case 16:
> +               return SC27XX_VOLT_RATIO(48, 100);
> +       case 19:
> +               return SC27XX_VOLT_RATIO(1, 3);
> +       default:
> +               return SC27XX_VOLT_RATIO(1, 1);
> +       }
> +       return SC27XX_VOLT_RATIO(1, 1);
> +}
> +
>  static int sc2731_adc_get_ratio(int channel, int scale)
>  {
>         switch (channel) {
> @@ -215,6 +321,34 @@ static int sc2731_adc_get_ratio(int channel, int scale)
>  /*
>   * According to the datasheet set specific value on some channel.
>   */
> +static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
> +{
> +       int i;
> +
> +       for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> +               switch (i) {
> +               case 5:
> +                       data->channel_scale[i] = 3;
> +                       break;
> +               case 7:
> +               case 9:
> +                       data->channel_scale[i] = 2;
> +                       break;
> +               case 13:
> +                       data->channel_scale[i] = 1;
> +                       break;
> +               case 19:
> +               case 30:
> +               case 31:
> +                       data->channel_scale[i] = 3;
> +                       break;
> +               default:
> +                       data->channel_scale[i] = 0;
> +                       break;
> +               }
> +       }
> +}

Like previous comments, this is not needed.

> +
>  static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  {
>         int i;
> @@ -239,6 +373,24 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                 return ret;
>         }
>
> +       /*
> +        * According to the sc2721 chip data sheet, the reference voltage of
> +        * specific channel 30 and channel 31 in ADC module needs to be set from
> +        * the default 2.8v to 3.5v.
> +        */
> +       if (data->var_data->pmic_type == SC2721_ADC) {
> +               if ((channel == 30) || (channel == 31)) {

Combine the two branches please.

> +                       ret = regulator_set_voltage(data->volref,
> +                                               SC27XX_ADC_REFVOL_VDD35,
> +                                               SC27XX_ADC_REFVOL_VDD35);
> +                       if (ret) {
> +                               dev_err(data->dev, "failed to set the volref 3.5V\n");
> +                               hwspin_unlock_raw(data->hwlock);
> +                               return ret;
> +                       }
> +               }
> +       }
> +
>         ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>                                  SC27XX_ADC_EN, SC27XX_ADC_EN);
>         if (ret)
> @@ -293,6 +445,16 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>         regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>                            SC27XX_ADC_EN, 0);
>  unlock_adc:
> +       if (data->var_data->pmic_type == SC2721_ADC) {
> +               if ((channel == 30) || (channel == 31)) {
> +                       ret = regulator_set_voltage(data->volref,
> +                                                   SC27XX_ADC_REFVOL_VDD28,
> +                                                   SC27XX_ADC_REFVOL_VDD28);
> +                       if (ret)
> +                               dev_err(data->dev, "failed to set the volref 2.8V\n");
> +               }
> +       }
> +
>         hwspin_unlock_raw(data->hwlock);
>
>         if (!ret)
> @@ -522,6 +684,7 @@ static void sc27xx_adc_disable(void *_data)
>  }
>
>  static const struct sc27xx_adc_variant_data sc2731_data = {
> +       .pmic_type = SC27XX_ADC,
>         .module_en = SC2731_MODULE_EN,
>         .clk_en = SC2731_ARM_CLK_EN,
>         .scale_shift = SC27XX_ADC_SCALE_SHIFT,
> @@ -532,6 +695,30 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
>         .get_ratio = sc2731_adc_get_ratio,
>  };
>
> +static const struct sc27xx_adc_variant_data sc2721_data = {
> +       .pmic_type = SC2721_ADC,
> +       .module_en = SC2731_MODULE_EN,
> +       .clk_en = SC2721_ARM_CLK_EN,
> +       .scale_shift = SC2721_ADC_SCALE_SHIFT,
> +       .scale_mask = SC2721_ADC_SCALE_MASK,
> +       .bscale_cal = &sc2731_big_scale_graph_calib,
> +       .sscale_cal = &sc2731_small_scale_graph_calib,
> +       .init_scale = sc2731_adc_scale_init,
> +       .get_ratio = sc2721_adc_get_ratio,
> +};
> +
> +static const struct sc27xx_adc_variant_data sc2720_data = {
> +       .pmic_type = SC27XX_ADC,
> +       .module_en = SC2731_MODULE_EN,
> +       .clk_en = SC2721_ARM_CLK_EN,
> +       .scale_shift = SC27XX_ADC_SCALE_SHIFT,
> +       .scale_mask = SC27XX_ADC_SCALE_MASK,
> +       .bscale_cal = &big_scale_graph_calib,
> +       .sscale_cal = &small_scale_graph_calib,
> +       .init_scale = sc2720_adc_scale_init,
> +       .get_ratio = sc2720_adc_get_ratio,
> +};
> +
>  static int sc27xx_adc_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -582,6 +769,15 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>         }
>
>         sc27xx_data->dev = dev;
> +       if (pdata->pmic_type == SC2721_ADC) {
> +               sc27xx_data->volref = devm_regulator_get_optional(dev, "vref");
> +               if (IS_ERR_OR_NULL(sc27xx_data->volref)) {

devm_regulator_get_optional() never return NULL, please use IS_ERR().

> +                       ret = PTR_ERR(sc27xx_data->volref);

Should check ret == -ENODEV, since -ENODEV means the regulator is not
supplied which is not a error for 'OPTIONAL_GET' type.

> +                       dev_err(dev, "err! ADC volref, err: %d\n", ret);

Can you elaborate on the error message like other places in this driver?

> +                       return ret;
> +               }
> +       }
> +
>         sc27xx_data->var_data = pdata;
>         sc27xx_data->var_data->init_scale(sc27xx_data);
>
> @@ -611,6 +807,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>
>  static const struct of_device_id sc27xx_adc_of_match[] = {
>         { .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
> +       { .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
> +       { .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
> --
> 2.25.1
>


-- 
Baolin Wang
