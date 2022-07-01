Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC28F563841
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiGAQqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGAQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C138DB2;
        Fri,  1 Jul 2022 09:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C286625E4;
        Fri,  1 Jul 2022 16:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F79C3411E;
        Fri,  1 Jul 2022 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656694007;
        bh=FLpSjTMwgYK01nyU2snZdBuhJwNNervY+onMcafn2Q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KPKhOgvtshtWG18LD/2F88zR6sewXmcQHXjI+OH795z7+sCZxGz9cdGGe+glrnloS
         ckuiQ/ghB1c64Jis0sBTpNDoGxNrylFzLTibhZHjc1f/020VZ8f5oeByEcvhADPL/H
         C2afx5xF4nC2xMrc/X1ujaiJPkRklVs6zZj5GDG+FiOOSsJ10Y/uHYb9NvuDKpBZhI
         6Lt0C9hEZJHCyQOVfZDSAg3gjRvAtZFX5P6NZAioLE+CMePGGBmmlFLruOzqJoTLHM
         EsXAGcxZmMTEDwcEdQFPkt15K6uqx2G+FdweARFVFTmHIMzHo2bfmfR6nZRRQq3kdc
         NAhYIbim0jJOg==
Date:   Fri, 1 Jul 2022 17:56:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, sre@kernel.org,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 09/15] iio: adc: axp20x_adc: Replace adc_en2 flag
 with adc_en2_mask field
Message-ID: <20220701175617.06d63c91@jic23-huawei>
In-Reply-To: <20220629143046.213584-10-aidanmacdonald.0x0@gmail.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
        <20220629143046.213584-10-aidanmacdonald.0x0@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 15:30:40 +0100
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> The adc_en2 flag is essentially specific to axp20x-compatible devices
> because it hardcodes register values. Replace it with a mask field
> so the register value can be specified in device match data.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/axp20x_adc.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index ab25e6e1ff65..75bda94dbce1 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -623,9 +623,9 @@ struct axp_data {
>  	int				num_channels;
>  	struct iio_chan_spec const	*channels;
>  	unsigned long			adc_en1_mask;
> +	unsigned long			adc_en2_mask;
>  	int				(*adc_rate)(struct axp20x_adc_iio *info,
>  						    int rate);
> -	bool				adc_en2;
>  	struct iio_map			*maps;
>  };
>  
> @@ -634,8 +634,8 @@ static const struct axp_data axp20x_data = {
>  	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
>  	.channels = axp20x_adc_channels,
>  	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
> +	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
>  	.adc_rate = axp20x_adc_rate,
> -	.adc_en2 = true,
>  	.maps = axp20x_maps,
>  };
>  
> @@ -645,7 +645,6 @@ static const struct axp_data axp22x_data = {
>  	.channels = axp22x_adc_channels,
>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>  	.adc_rate = axp22x_adc_rate,
> -	.adc_en2 = false,
>  	.maps = axp22x_maps,
>  };
>  
> @@ -655,7 +654,6 @@ static const struct axp_data axp813_data = {
>  	.channels = axp813_adc_channels,
>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>  	.adc_rate = axp813_adc_rate,
> -	.adc_en2 = false,
>  	.maps = axp22x_maps,
>  };
>  
> @@ -713,10 +711,10 @@ static int axp20x_probe(struct platform_device *pdev)
>  	/* Enable the ADCs on IP */
>  	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
>  
> -	if (info->data->adc_en2)
> -		/* Enable GPIO0/1 and internal temperature ADCs */
> +	if (info->data->adc_en2_mask)
>  		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> -				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> +				   info->data->adc_en2_mask,
> +				   info->data->adc_en2_mask);
>  
>  	/* Configure ADCs rate */
>  	info->data->adc_rate(info, 100);
> @@ -741,7 +739,7 @@ static int axp20x_probe(struct platform_device *pdev)
>  fail_map:
>  	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>  
> -	if (info->data->adc_en2)
> +	if (info->data->adc_en2_mask)
>  		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>  
>  	return ret;
> @@ -757,7 +755,7 @@ static int axp20x_remove(struct platform_device *pdev)
>  
>  	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>  
> -	if (info->data->adc_en2)
> +	if (info->data->adc_en2_mask)
>  		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>  
>  	return 0;

