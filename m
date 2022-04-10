Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC76C4FAEA5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbiDJQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiDJQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:10:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE395DE63;
        Sun, 10 Apr 2022 09:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B1B8B80D9B;
        Sun, 10 Apr 2022 16:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1138C385AE;
        Sun, 10 Apr 2022 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649606901;
        bh=/Nlx4o4B49uox3p3jL/xY0vtdYZPYp92P6ZZk1VPnBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sh5utZJV+9qKGagd9s9d4HokoXE/SFKxdVTg8Ol0DW9ednAyZnhlk7JxumtOhOQ3I
         Z6AhhHgnCMzxKAIx82tqYalM2c8BfPEwNP2ezeKB+ywgBfEF430ssgWC0zAOuZYsfD
         e2uiLQDhOawfsJ9dwVNMrPSYVsnwsCngTralBj8vMnagtdg+oiq8r6eCHWBHOF5tM0
         2Q8l1NW565Dz4NNLFAqJux1POz5HLZU4oJ+nXZr59IWgqMcoK/5pSp11yRo6cFcwsR
         qptwPdhGypLTAfWSwBeQrWY5FDHV0U7MYAABL+y4VIPP9gMZaLnHVs5gqArpqBLNq+
         NXSb2CGgW/iTg==
Date:   Sun, 10 Apr 2022 17:16:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/7] iio: adc: sc27xx: structure adjuststment and
 optimization
Message-ID: <20220410171610.7baaa3f8@jic23-huawei>
In-Reply-To: <20220407082148.571442-4-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
        <20220407082148.571442-4-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Apr 2022 16:21:44 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
In patch title "adjustment"
> 
> Introduce one variant device data structure to be compatible
> with SC2731 PMIC since it has different scale and ratio calculation
> and so on.
> 
> Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Hi Cixi,

Some minor comments inline. Biggest one is you have some (small) functional
changes in this patch that should be pulled out to their own patch with
explanation of why the scales are changing slightly.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sc27xx_adc.c | 99 ++++++++++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index aee076c8e2b1..28bd70c27420 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -12,9 +12,9 @@
>  #include <linux/slab.h>
>  
>  /* PMIC global registers definition */
> -#define SC27XX_MODULE_EN		0xc08
> +#define SC2731_MODULE_EN		0xc08
>  #define SC27XX_MODULE_ADC_EN		BIT(5)
> -#define SC27XX_ARM_CLK_EN		0xc10
> +#define SC2731_ARM_CLK_EN		0xc10
>  #define SC27XX_CLK_ADC_EN		BIT(5)
>  #define SC27XX_CLK_ADC_CLK_EN		BIT(6)
>  
> @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
>  	int channel_scale[SC27XX_ADC_CHANNEL_MAX];
>  	u32 base;
>  	int irq;
> +	const struct sc27xx_adc_variant_data *var_data;
> +};
> +
> +/*
> + * Since different PMICs of SC27xx series can have different
> + * address and ratio, we should save ratio config and base
> + * in the device data structure.
> + */
> +struct sc27xx_adc_variant_data {
> +	u32 module_en;
> +	u32 clk_en;
> +	u32 scale_shift;
> +	u32 scale_mask;
> +	const struct sc27xx_adc_linear_graph *bscale_cal;
> +	const struct sc27xx_adc_linear_graph *sscale_cal;
> +	void (*init_scale)(struct sc27xx_adc_data *data);
> +	int (*get_ratio)(int channel, int scale);
>  };
>  
>  struct sc27xx_adc_linear_graph {
> @@ -103,14 +120,15 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
>  	100, 341,
>  };
>  
> -static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
> -	4200, 856,
> -	3600, 733,
> +/* Add these for sc2731 pmic, and the [big|small]_scale_graph_calib for common's */
> +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
> +	4200, 850,
> +	3600, 728,
>  };
>  
> -static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
> -	1000, 833,
> -	100, 80,
> +static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
> +	1000, 838,

These changes are small, but they aren't the main topic of the patch
so should be in a separate patch. I expected this patch to be a no-op refactoring
but it's not with these value changes.

> +	100, 84,
>  };
>  
>  static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
> @@ -130,11 +148,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>  	size_t len;
>  
>  	if (big_scale) {
> -		calib_graph = &big_scale_graph_calib;
> +		calib_graph = data->var_data->bscale_cal;
>  		graph = &big_scale_graph;
>  		cell_name = "big_scale_calib";
>  	} else {
> -		calib_graph = &small_scale_graph_calib;
> +		calib_graph = data->var_data->sscale_cal;
>  		graph = &small_scale_graph;
>  		cell_name = "small_scale_calib";
>  	}
> @@ -160,7 +178,7 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>  	return 0;
>  }
>  
> -static int sc27xx_adc_get_ratio(int channel, int scale)
> +static int sc2731_adc_get_ratio(int channel, int scale)
>  {
>  	switch (channel) {
>  	case 1:
> @@ -185,6 +203,23 @@ static int sc27xx_adc_get_ratio(int channel, int scale)
>  	return SC27XX_VOLT_RATIO(1, 1);
>  }
>  
> +/*
> + * According to the datasheet set specific value on some channel.
> + */
> +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> +{
> +	int i;
> +	/* In the current software design, SC2731 support 2 scales,
Trivial, but in IIO we use
/*
 * In the current software design...
 * channels...
 */
style for multi line comments.

> +	 * channels 5 uses big scale, others use smale.
> +	 */
> +	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> +		if (i == 5)
> +			data->channel_scale[i] = 1;
> +		else
> +			data->channel_scale[i] = 0;
> +	}
> +}
> +
>  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  			   int scale, int *val)
>  {
> @@ -208,10 +243,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  		goto disable_adc;
>  
>  	/* Configure the channel id and scale */
> -	tmp = (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MASK;
> +	tmp = (scale << data->var_data->scale_shift) & data->var_data->scale_mask;
>  	tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
>  	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CH_CFG,
> -				 SC27XX_ADC_CHN_ID_MASK | SC27XX_ADC_SCALE_MASK,
> +				 SC27XX_ADC_CHN_ID_MASK |
> +				 data->var_data->scale_mask,
>  				 tmp);
>  	if (ret)
>  		goto disable_adc;
> @@ -262,8 +298,9 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
>  				  int channel, int scale,
>  				  u32 *div_numerator, u32 *div_denominator)
>  {
> -	u32 ratio = sc27xx_adc_get_ratio(channel, scale);
> +	u32 ratio;
>  
> +	ratio = data->var_data->get_ratio(channel, scale);
>  	*div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
>  	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
>  }
> @@ -432,13 +469,13 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  {
>  	int ret;
>  
> -	ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> +	ret = regmap_update_bits(data->regmap, data->var_data->module_en,
>  				 SC27XX_MODULE_ADC_EN, SC27XX_MODULE_ADC_EN);
>  	if (ret)
>  		return ret;
>  
>  	/* Enable ADC work clock and controller clock */
> -	ret = regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> +	ret = regmap_update_bits(data->regmap, data->var_data->clk_en,
>  				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
>  				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
>  	if (ret)
> @@ -456,10 +493,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  	return 0;
>  
>  disable_clk:
> -	regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> +	regmap_update_bits(data->regmap, data->var_data->clk_en,
>  			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
>  disable_adc:
> -	regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> +	regmap_update_bits(data->regmap, data->var_data->module_en,
>  			   SC27XX_MODULE_ADC_EN, 0);
>  
>  	return ret;
> @@ -470,21 +507,39 @@ static void sc27xx_adc_disable(void *_data)
>  	struct sc27xx_adc_data *data = _data;
>  
>  	/* Disable ADC work clock and controller clock */
> -	regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> +	regmap_update_bits(data->regmap, data->var_data->clk_en,
>  			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
>  
> -	regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> +	regmap_update_bits(data->regmap, data->var_data->module_en,
>  			   SC27XX_MODULE_ADC_EN, 0);
>  }
>  
> +static const struct sc27xx_adc_variant_data sc2731_data = {
> +	.module_en = SC2731_MODULE_EN,
> +	.clk_en = SC2731_ARM_CLK_EN,
> +	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
> +	.scale_mask = SC27XX_ADC_SCALE_MASK,
> +	.bscale_cal = &sc2731_big_scale_graph_calib,
> +	.sscale_cal = &sc2731_small_scale_graph_calib,
> +	.init_scale = sc2731_adc_scale_init,
> +	.get_ratio = sc2731_adc_get_ratio,
> +};
> +
>  static int sc27xx_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct sc27xx_adc_data *sc27xx_data;
> +	const struct sc27xx_adc_variant_data *pdata;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> +	pdata = of_device_get_match_data(dev);
> +	if (!pdata) {
> +		dev_err(dev, "No matching driver data found\n");
> +		return -EINVAL;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -520,6 +575,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	sc27xx_data->dev = dev;
> +	sc27xx_data->var_data = pdata;
> +	sc27xx_data->var_data->init_scale(sc27xx_data);
>  
>  	ret = sc27xx_adc_enable(sc27xx_data);
>  	if (ret) {
> @@ -546,7 +603,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id sc27xx_adc_of_match[] = {
> -	{ .compatible = "sprd,sc2731-adc", },
> +	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);

