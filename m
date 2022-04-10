Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB824FAEF3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiDJQgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiDJQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA481AE68;
        Sun, 10 Apr 2022 09:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8314CB80DA6;
        Sun, 10 Apr 2022 16:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A88C385A1;
        Sun, 10 Apr 2022 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649608444;
        bh=PoCEF4EXFFLgdTPSLeWBPA2wYwKJKRkllET0D7n7ioc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=byD3v+fvj9YbXFFJK6owno0jqb7vO8kTYvGy15L2VTIIxzjdbEdrfa5Jsb0+dGH9w
         1DDtr67VgJ+H1M1Z4UPowXCzSWy0+m2rLE+CxnnafPGr25pk1+bZMdzZLjJlssG4Km
         D5AT+aKaTP9U1euy/hM2u/o4EJzOyyyrwX/4wC3gGl2L5wlPf4bLQwt12CzA9gdkur
         tthzzJaSSwoojBxVUO2GUe7WV1GpDPRQj/o+/Br+F9rWelEMz/Q7xSBvf8C6A7FF9L
         0RwCazHgYnbF95npXNfuKksesacoiE/WnnKLSMC07tycDI9mhXYAX5BYX/dw6A19Z3
         OVCFNM/qBQt4A==
Date:   Sun, 10 Apr 2022 17:41:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 7/7] iio: adc: sc27xx: add support for PMIC ump9620
Message-ID: <20220410174153.09c53bdc@jic23-huawei>
In-Reply-To: <20220407082148.571442-8-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
        <20220407082148.571442-8-gengcixi@gmail.com>
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

On Thu,  7 Apr 2022 16:21:48 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> The ump9620 is variant from sc27xx chip, add it in here.
> 
> Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Hi Cixi, Yuming,

A follow up to the earlier comment on trying to avoid using
a part enum when we have a structure to hold part specific data and
can describe better what the feature is / use a callback to avoid
having to handle it in the same code as the case where the feature
isn't present.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sc27xx_adc.c | 249 +++++++++++++++++++++++++++++++----
>  1 file changed, 226 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 43655a818d09..fe4a45f61ac8 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -15,12 +15,16 @@
>  /* PMIC global registers definition */
>  #define SC2730_MODULE_EN		0x1808
>  #define SC2731_MODULE_EN		0xc08
> +#define UMP9620_MODULE_EN		0x2008
>  #define SC27XX_MODULE_ADC_EN		BIT(5)
>  #define SC2721_ARM_CLK_EN		0xc0c
>  #define SC2730_ARM_CLK_EN		0x180c
>  #define SC2731_ARM_CLK_EN		0xc10
> +#define UMP9620_ARM_CLK_EN		0x200c
> +#define UMP9620_XTL_WAIT_CTRL0		0x2378
>  #define SC27XX_CLK_ADC_EN		BIT(5)
>  #define SC27XX_CLK_ADC_CLK_EN		BIT(6)
> +#define UMP9620_XTL_WAIT_CTRL0_EN	BIT(8)
>  
>  /* ADC controller registers definition */
>  #define SC27XX_ADC_CTL			0x0
> @@ -82,6 +86,13 @@
>  enum sc27xx_pmic_type {
>  	SC27XX_ADC,
>  	SC2721_ADC,
> +	UMP9620_ADC,
> +};
> +
> +enum ump96xx_scale_cal {
> +	UMP96XX_VBAT_SENSES_CAL,
> +	UMP96XX_VBAT_DET_CAL,
> +	UMP96XX_CH1_CAL,
>  };
>  
>  struct sc27xx_adc_data {
> @@ -139,6 +150,11 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
>  	100, 341,
>  };
>  
> +static struct sc27xx_adc_linear_graph ump9620_bat_det_graph = {
> +	1400, 3482,
> +	200, 476,
> +};
> +
>  /* Add these for sc2731 pmic, and the [big|small]_scale_graph_calib for common's */
>  static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
>  	4200, 850,
> @@ -221,6 +237,56 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>  	return 0;
>  }
>  
> +static int ump96xx_adc_scale_cal(struct sc27xx_adc_data *data,
> +				enum ump96xx_scale_cal cal_type)
> +{
> +	struct sc27xx_adc_linear_graph *graph;
> +	const char *cell_name1, *cell_name2;
> +	int adc_calib_data1, adc_calib_data2;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (cal_type == UMP96XX_VBAT_DET_CAL) {
> +		graph = &ump9620_bat_det_graph;
> +		cell_name1 = "vbat_det_cal1";
> +		cell_name2 = "vbat_det_cal2";
> +	} else if (cal_type == UMP96XX_VBAT_SENSES_CAL) {
> +		graph = &big_scale_graph;
> +		cell_name1 = "big_scale_calib1";
> +		cell_name2 = "big_scale_calib2";
> +	} else if (cal_type == UMP96XX_CH1_CAL) {
> +		graph = &small_scale_graph;
> +		cell_name1 = "small_scale_calib1";
> +		cell_name2 = "small_scale_calib2";
> +	} else {
> +		graph = &small_scale_graph;
> +		cell_name1 = "small_scale_calib1";
> +		cell_name2 = "small_scale_calib2";
> +	}
> +
> +	adc_calib_data1 = adc_nvmem_cell_calib_data(data, cell_name1);
> +	if (adc_calib_data1 < 0) {
> +		dev_err(data->dev, "err! %s:%d\n", cell_name1, adc_calib_data1);
> +		return adc_calib_data1;
> +	}
> +
> +	adc_calib_data2 = adc_nvmem_cell_calib_data(data, cell_name2);
> +	if (adc_calib_data2 < 0) {
> +		dev_err(data->dev, "err! %s:%d\n", cell_name2, adc_calib_data2);
> +		return adc_calib_data2;
> +	}
> +
> +	/*
> +	 *Read the data in the two blocks of efuse and convert them into the
> +	 *calibration value in the ump9620 adc linear graph.
> +	 */
> +	graph->adc0 = (adc_calib_data1 & 0xfff0) >> 4;
> +	graph->adc1 = (adc_calib_data2 & 0xfff0) >> 4;
> +
> +	return 0;
> +}
> +
>  static int sc2720_adc_get_ratio(int channel, int scale)
>  {
>  	switch (channel) {
> @@ -408,6 +474,50 @@ static int sc2731_adc_get_ratio(int channel, int scale)
>  	return SC27XX_VOLT_RATIO(1, 1);
>  }
>  
> +static int ump9620_adc_get_ratio(int channel, int scale)
> +{
> +	switch (channel) {
> +	case 11:
> +		return SC27XX_VOLT_RATIO(1, 1);
> +	case 14:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(68, 900);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	case 15:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(1, 3);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	case 21:
> +	case 22:
> +	case 23:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(3, 8);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	default:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(1000, 1955);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(1000, 2600);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(1000, 4060);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	}
> +}
> +
>  /*
>   * According to the datasheet set specific value on some channel.
>   */
> @@ -469,6 +579,22 @@ static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  	}
>  }
>  
> +static void ump9620_adc_scale_init(struct sc27xx_adc_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {

As for previous patch, a switch statement here would be easier to read.

> +		if (i == 10 || i == 19 || i == 30 || i == 31)
> +			data->channel_scale[i] = 3;
> +		else if (i == 7 || i == 9)
> +			data->channel_scale[i] = 2;
> +		else if (i == 0 || i == 13)
> +			data->channel_scale[i] = 1;
> +		else
> +			data->channel_scale[i] = 0;
> +	}
> +}
> +
>  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  			   int scale, int *val)
>  {
> @@ -603,29 +729,67 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
>  	return tmp < 0 ? 0 : tmp;
>  }
>  
> +static int ump96xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph, int scale,
> +		int raw_adc)
> +{
> +	int tmp;
> +
> +	tmp = adc_to_volt(graph, raw_adc);
> +
> +	if (scale == 2)
> +		tmp = tmp * 2600 / 1000;
> +	else if (scale == 3)
> +		tmp = tmp * 4060 / 1000;
> +
> +	return tmp < 0 ? 0 : tmp;
> +}
> +
> +
>  static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
>  				   int scale, int raw_adc)
>  {
>  	u32 numerator, denominator;
>  	u32 volt;
>  
> -	/*
> -	 * Convert ADC values to voltage values according to the linear graph,
> -	 * and channel 5 and channel 1 has been calibrated, so we can just
> -	 * return the voltage values calculated by the linear graph. But other
> -	 * channels need be calculated to the real voltage values with the
> -	 * voltage ratio.
> -	 */
> -	switch (channel) {
> -	case 5:
> -		return sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
> +	if (data->var_data->pmic_type == UMP9620_ADC) {

Looks like a case for a callback to me so we end up without the complexity of
handling multiple types via an if / else.

> +		switch (channel) {
> +		case 0:
> +			if (scale == 1)
> +				volt = sc27xx_adc_to_volt(&ump9620_bat_det_graph, raw_adc);
> +			else
> +				volt = ump96xx_adc_to_volt(&small_scale_graph, scale, raw_adc);
> +			break;
> +		case 11:
> +			volt = sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
> +			break;
> +		default:
> +			if (scale == 1)
> +				volt = sc27xx_adc_to_volt(&ump9620_bat_det_graph, raw_adc);
> +			else
> +				volt = ump96xx_adc_to_volt(&small_scale_graph, scale, raw_adc);
> +			break;
> +		}
> +		if (channel == 0 && scale == 1)
> +			return volt;
> +	} else {
> +		/*
> +		 * Convert ADC values to voltage values according to the linear graph,
> +		 * and channel 5 and channel 1 has been calibrated, so we can just
> +		 * return the voltage values calculated by the linear graph. But other
> +		 * channels need be calculated to the real voltage values with the
> +		 * voltage ratio.
> +		 */
> +		switch (channel) {
> +		case 5:
> +			return sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
>  
> -	case 1:
> -		return sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
> +		case 1:
> +			return sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
>  
> -	default:
> -		volt = sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
> -		break;
> +		default:
> +			volt = sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
> +			break;
> +		}
>  	}
>  
>  	sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
> @@ -760,21 +924,42 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  	if (ret)
>  		return ret;
>  
> -	/* Enable ADC work clock and controller clock */
> +	/* Enable 26MHz crvstal oscillator wait cycles for UMP9620 ADC */
> +	if (data->var_data->pmic_type == UMP9620_ADC) {
> +		ret = regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
> +				UMP9620_XTL_WAIT_CTRL0_EN,
> +				UMP9620_XTL_WAIT_CTRL0_EN);
> +	}
> +
> +	/* Enable ADC work clock */
>  	ret = regmap_update_bits(data->regmap, data->var_data->clk_en,
>  				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
>  				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
>  	if (ret)
>  		goto disable_adc;
>  
> -	/* ADC channel scales' calibration from nvmem device */
> -	ret = sc27xx_adc_scale_calibration(data, true);
> -	if (ret)
> -		goto disable_clk;
> +	/* ADC channel scales calibration from nvmem device */
> +	if (data->var_data->pmic_type == UMP9620_ADC) {

As below.  If we need to use a callback for this that is fine too, but
I don't want to see matching on pmic_type as that tends to just make
the code harder to read as we'll gain more and more cases over time.

> +		ret = ump96xx_adc_scale_cal(data, UMP96XX_VBAT_SENSES_CAL);
> +		if (ret)
> +			goto disable_clk;
>  
> -	ret = sc27xx_adc_scale_calibration(data, false);
> -	if (ret)
> -		goto disable_clk;
> +		ret = ump96xx_adc_scale_cal(data, UMP96XX_VBAT_DET_CAL);
> +		if (ret)
> +			goto disable_clk;
> +
> +		ret = ump96xx_adc_scale_cal(data, UMP96XX_CH1_CAL);
> +		if (ret)
> +			goto disable_clk;
> +	} else {
> +		ret = sc27xx_adc_scale_calibration(data, true);
> +		if (ret)
> +			goto disable_clk;
> +
> +		ret = sc27xx_adc_scale_calibration(data, false);
> +		if (ret)
> +			goto disable_clk;
> +	}
>  
>  	return 0;
>  
> @@ -798,6 +983,11 @@ static void sc27xx_adc_disable(void *_data)
>  
>  	regmap_update_bits(data->regmap, data->var_data->module_en,
>  			   SC27XX_MODULE_ADC_EN, 0);
> +
> +	if (data->var_data->pmic_type == UMP9620_ADC)

As with earlier vref bool suggestion, I'd like to see something
descriptive added to the variant_data structure (only currently set for
this device type) rather than using an enum value.
Features descriptions always end up scaling better to lots of
supported parts than matching on particular part IDs.

> +		regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
> +				UMP9620_XTL_WAIT_CTRL0_EN, 0);
> +
>  }
>  
>  static const struct sc27xx_adc_variant_data sc2731_data = {
> @@ -848,6 +1038,18 @@ static const struct sc27xx_adc_variant_data sc2720_data = {
>  	.get_ratio = sc2720_adc_get_ratio,
>  };
>  
> +static const struct sc27xx_adc_variant_data ump9620_data = {
> +	.pmic_type = UMP9620_ADC,
> +	.module_en = UMP9620_MODULE_EN,
> +	.clk_en = UMP9620_ARM_CLK_EN,
> +	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
> +	.scale_mask = SC27XX_ADC_SCALE_MASK,
> +	.bscale_cal = &big_scale_graph,
> +	.sscale_cal = &small_scale_graph,
> +	.init_scale = ump9620_adc_scale_init,
> +	.get_ratio = ump9620_adc_get_ratio,
> +};
> +
>  static int sc27xx_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -941,6 +1143,7 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
>  	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
>  	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
>  	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
> +	{ .compatible = "sprd,ump9620-adc", .data = &ump9620_data},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);

