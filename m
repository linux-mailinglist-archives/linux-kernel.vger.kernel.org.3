Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218AE4FAEE2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiDJQ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbiDJQ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:28:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E05E74A;
        Sun, 10 Apr 2022 09:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C582B80B00;
        Sun, 10 Apr 2022 16:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A780C385A1;
        Sun, 10 Apr 2022 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649607947;
        bh=NGKU1NW31S2WhJRxze0FB2Ln7FKN0fJi8+bBdLHPWEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uLdIA8rujL0YIz/V7rMMUrvCDJHL+plvWQ4n4O9ky0EcEdJ/Ay9MSl11cfvdTguTY
         epbQVeK+DDzTaBm+2fEqcamujU6Wn7DDTAYNTbQeClIPn4dqIOafjpwwh/BvBbTmR4
         RsyEKzVC0HeMIzBqOR7f0eAUfWZ8FOTZNAl8XOMWaMVS9+2q5bydRvew+pAwVXbZOO
         Q/8exo3u9SYI5rvfwxrH5cytwJF1ZD2WrSak6kuvChs2+6VqlDnJEMf6FsSiQZzt28
         bkv/AvyY81ei2uLH+H4IGXaFfifjF1SgBlHsoqKiyP69slB26lSxCa7I9BNUoq2KGg
         8/A11WagbUaig==
Date:   Sun, 10 Apr 2022 17:33:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 6/7] iio: adc: sc27xx: add support for PMIC sc2730
Message-ID: <20220410173338.35061998@jic23-huawei>
In-Reply-To: <20220407082148.571442-7-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
        <20220407082148.571442-7-gengcixi@gmail.com>
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

On Thu,  7 Apr 2022 16:21:47 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> sc2730 is the product of sc27xx series.
> 
> Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

One minor comment inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sc27xx_adc.c | 105 +++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index eb9e789dd8ee..43655a818d09 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -13,9 +13,11 @@
>  #include <linux/slab.h>
>  
>  /* PMIC global registers definition */
> +#define SC2730_MODULE_EN		0x1808
>  #define SC2731_MODULE_EN		0xc08
>  #define SC27XX_MODULE_ADC_EN		BIT(5)
>  #define SC2721_ARM_CLK_EN		0xc0c
> +#define SC2730_ARM_CLK_EN		0x180c
>  #define SC2731_ARM_CLK_EN		0xc10
>  #define SC27XX_CLK_ADC_EN		BIT(5)
>  #define SC27XX_CLK_ADC_CLK_EN		BIT(6)
> @@ -307,6 +309,80 @@ static int sc2721_adc_get_ratio(int channel, int scale)
>  	return SC27XX_VOLT_RATIO(1, 1);
>  }
>  
> +static int sc2730_adc_get_ratio(int channel, int scale)
> +{
> +	switch (channel) {
> +	case 14:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(68, 900);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(68, 1760);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(68, 2327);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(68, 3654);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	case 15:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(1, 3);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(1000, 5865);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(500, 3879);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(500, 6090);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	case 16:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(48, 100);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(480, 1955);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(480, 2586);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(48, 406);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	case 21:
> +	case 22:
> +	case 23:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(3, 8);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(375, 1955);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(375, 2586);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(300, 3248);
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
> +			return SC27XX_VOLT_RATIO(1000, 2586);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(1000, 4060);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	}
> +	return SC27XX_VOLT_RATIO(1, 1);
> +}
> +
>  static int sc2731_adc_get_ratio(int channel, int scale)
>  {
>  	switch (channel) {
> @@ -363,6 +439,22 @@ static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
>  	}
>  }
>  
> +static void sc2730_adc_scale_init(struct sc27xx_adc_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> +		if (i == 5 || i == 10 || i == 19 || i == 30 || i == 31)

I'd keep this looking like the other instances (in the previous patch)
and use a switch statement.  They are more lines, but easier to read.

> +			data->channel_scale[i] = 3;
> +		else if (i == 7 || i == 9)
> +			data->channel_scale[i] = 2;
> +		else if (i == 13)
> +			data->channel_scale[i] = 1;
> +		else
> +			data->channel_scale[i] = 0;
> +	}
> +}
> +
>  static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  {
>  	int i;
> @@ -720,6 +812,18 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
>  	.get_ratio = sc2731_adc_get_ratio,
>  };
>  
> +static const struct sc27xx_adc_variant_data sc2730_data = {
> +	.pmic_type = SC27XX_ADC,
> +	.module_en = SC2730_MODULE_EN,
> +	.clk_en = SC2730_ARM_CLK_EN,
> +	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
> +	.scale_mask = SC27XX_ADC_SCALE_MASK,
> +	.bscale_cal = &big_scale_graph_calib,
> +	.sscale_cal = &small_scale_graph_calib,
> +	.init_scale = sc2730_adc_scale_init,
> +	.get_ratio = sc2730_adc_get_ratio,
> +};
> +
>  static const struct sc27xx_adc_variant_data sc2721_data = {
>  	.pmic_type = SC2721_ADC,
>  	.module_en = SC2731_MODULE_EN,
> @@ -834,6 +938,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id sc27xx_adc_of_match[] = {
>  	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
> +	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
>  	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
>  	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
>  	{ }

