Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E244E53EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiCWOHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiCWOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:07:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79C6258;
        Wed, 23 Mar 2022 07:05:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id v2so1188385qtc.5;
        Wed, 23 Mar 2022 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HA7zjle6C3PsZP6fkux68piPzUwetE30nQWam1Bf1tc=;
        b=JOt1pUF/PlgL822FjfTv28Z4Oxe63ubGnW4du3y4nVMZAqa13qCIQeTHnn41EYfABC
         GDKWp9NSLWzLA0+3zKwU4wGqWGxJF6NVEIdyRXf4RL8lOZGz+d7+B4se7+uGCCEeIVTw
         mVsQmVAewjqeYy0xbf39r1NXyauRLJPZhSx8JqV3qRmzQKp3OSxkI5fxEy0Nr//ugsbK
         tdmylliQvUGSepMDCNNTn8toeK3/9cixJZvcJVv3HmJFCU/Eza7URcoR5sgZokJ0tolH
         taywHAZOMEqfwLw5rYa45sbcCWokKVxhHzjYWq5F3Chb3QL1XzgfrUOkO7zjJszlfUeL
         ZzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HA7zjle6C3PsZP6fkux68piPzUwetE30nQWam1Bf1tc=;
        b=wZ2ZoD5kDEG++4I0hScCKk9HL9jcCx8js3w9Ekxp67P1ei6nEl9CX/KihX+KjF7Cck
         X5TXbjriDyShnimcOQXrWZevqbRjow17kgogJcsriVVJ5EBAQoPve/CtXCu6JjPAvQ/P
         whnTAx6LsEFt19hI+IhQN+Ucn9eqyIvZLP7fU7Afy6dmLL8S4AaGUMy5KxHD0HHFc9QE
         ygQ3amDkhxWqhsVa3RRsp9Zcp8aq10FhyGeMdR/ZhxMsFxylA6PRYJda3cB5ZBAvKLKN
         /1sTYPSxC7a6j1RQ1uWyP5Ey5WdF4DItXsqrx+KtYpIJxNdr1QjmnhuO5KwVWjeIU8h8
         BkgA==
X-Gm-Message-State: AOAM53201N6acLdFMzmlEVo8HvADOBzjSJaqSX4AQfLAsDDGL+dpqWfB
        /0/Awz56NmLd8g4Q6lsHePM4VlnSCGgR+fsaETo=
X-Google-Smtp-Source: ABdhPJzfkF8AAeBkPonZ9KvV9V+959JIJBgxk62vEiMZc4nSc4cqtRRsFQvYt7eo9GwOQ0cJUYYZshAx5qrV+DvjdoY=
X-Received: by 2002:ac8:5b50:0:b0:2e2:38d6:cb36 with SMTP id
 n16-20020ac85b50000000b002e238d6cb36mr867688qtw.311.1648044336798; Wed, 23
 Mar 2022 07:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220311164628.378849-1-gengcixi@gmail.com> <20220311164628.378849-5-gengcixi@gmail.com>
In-Reply-To: <20220311164628.378849-5-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 23 Mar 2022 22:06:23 +0800
Message-ID: <CADBw62pX_f4BYO8uhN2BXrNuZpehx1Nb26xXdzv+22T+NNrr1A@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
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
> sc2720 and sc2721 is the product of sc27xx series.
>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>
> v2 changes:
>
> 1. modify code by the baolin's comment
>
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

I think I did not add a reviewed-by tag for this patch before, please drop it.

>
> 2.fix smatch warnings in sc27xx_adc_read()
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 201 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 200 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 68629fbcfec5..2603ce313b07 100644
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
> @@ -67,8 +71,20 @@
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
>         struct device *dev;
> +       struct regulator *volref;
>         struct regmap *regmap;
>         /*
>          * One hardware spinlock to synchronize between the multiple
> @@ -87,6 +103,7 @@ struct sc27xx_adc_data {
>   * in the device data structure.
>   */
>  struct sc27xx_adc_variant_data {
> +       enum sc27xx_pmic_type pmic_type;
>         u32 module_en;
>         u32 clk_en;
>         u32 scale_shift;
> @@ -188,6 +205,94 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
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
> @@ -216,6 +321,34 @@ static int sc2731_adc_get_ratio(int channel, int scale)
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
> +
>  static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  {
>         int i;
> @@ -231,7 +364,7 @@ static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                            int scale, int *val)
>  {
> -       int ret;
> +       int ret, ret_volref;
>         u32 tmp, value, status;
>
>         ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
> @@ -240,6 +373,22 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                 return ret;
>         }
>
> +       /*
> +        * According to the sc2721 chip data sheet, the reference voltage of
> +        * specific channel 30 and channel 31 in ADC module needs to be set from
> +        * the default 2.8v to 3.5v.
> +        */
> +       if ((data->var_data->pmic_type == SC2721_ADC) && (channel == 30 || channel == 31)) {
> +               ret = regulator_set_voltage(data->volref,
> +                                       SC27XX_ADC_REFVOL_VDD35,
> +                                       SC27XX_ADC_REFVOL_VDD35);
> +               if (ret) {
> +                       dev_err(data->dev, "failed to set the volref 3.5V\n");
> +                       hwspin_unlock_raw(data->hwlock);

Please remove duplicate code, just "goto unlock_adc". Then add a new
label like "regultor_restore" to restore the regulator in the error
path.

> +                       return ret;
> +               }
> +       }
> +
>         ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>                                  SC27XX_ADC_EN, SC27XX_ADC_EN);
>         if (ret)
> @@ -294,6 +443,18 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>         regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>                            SC27XX_ADC_EN, 0);
>  unlock_adc:
> +       if (data->var_data->pmic_type == SC2721_ADC) {
> +               if ((channel == 30) || (channel == 31)) {
> +                       ret_volref = regulator_set_voltage(data->volref,
> +                                                   SC27XX_ADC_REFVOL_VDD28,
> +                                                   SC27XX_ADC_REFVOL_VDD28);
> +                       if (ret_volref) {
> +                               dev_err(data->dev, "failed to set the volref 2.8V, ret_volref = 0x%x\n,ret_volref");
> +                               ret = ret || ret_volref;
> +                       }
> +               }
> +       }
> +
>         hwspin_unlock_raw(data->hwlock);
>
>         if (!ret)
> @@ -523,6 +684,7 @@ static void sc27xx_adc_disable(void *_data)
>  }
>



-- 
Baolin Wang
