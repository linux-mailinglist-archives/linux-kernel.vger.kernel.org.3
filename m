Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BED4FAED1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiDJQPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDJQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:15:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29485E76C;
        Sun, 10 Apr 2022 09:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E2296104E;
        Sun, 10 Apr 2022 16:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316A2C385A4;
        Sun, 10 Apr 2022 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649607181;
        bh=jtJwcBcbIqdZZpkCbauCfaMXTxA3jnmG9MIcebsKJAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JarvrELkFGX0DXRP5rWopewXBmTwBBLn9c7g1ziiQfujHRMHm+mgiGQtGZT/XqDc6
         y+xjCnEAVNfCbnipfXng258rQreuKOnbmytng7FMGt0/5qFmHxWUZQEVgiA/gHpvV1
         C9z3CJwXCi7T4osh0cu2DKJu6UNCwsZ8mKXmSFJio0TVawgTa5zgXDbsHEShpTA7E0
         rHQ7XQsfIJ3BJ4jJcoEIx0AEMkda32qd0r8YNIXhIje/WHskx1O5an23cQ6CCE8w39
         cNhFBHgrXiB8a7/YIzGh9X55ohGYadBBey2DgcxHFBuo9h4Xb2yXlTsnvM2+ACu0FT
         UJw4OD2jrfNkA==
Date:   Sun, 10 Apr 2022 17:20:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/7] iio: adc: refactor some functions for support
 more PMiCs
Message-ID: <20220410172051.4fdf8b85@jic23-huawei>
In-Reply-To: <20220407082148.571442-5-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
        <20220407082148.571442-5-gengcixi@gmail.com>
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

On Thu,  7 Apr 2022 16:21:45 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> refactor the common adc_nvmem_cell_calib_data,adc_to_volt and call
> these in the origin sc27xx_adc_scale_calibration,sc27xx_adc_to_volt
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
One trivial comment inline.

> ---
>  drivers/iio/adc/sc27xx_adc.c | 57 ++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 28bd70c27420..60c0a6aa3f45 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -136,16 +136,41 @@ static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
>  	return ((calib_data & 0xff) + calib_adc - 128) * 4;
>  }
>  
> +/* get the adc nvmem cell calibration data */
> +static int adc_nvmem_cell_calib_data(struct sc27xx_adc_data *data, const char *cell_name)
> +{
> +	struct nvmem_cell *cell;
> +	void *buf;
> +	u32 origin_calib_data = 0;
> +	size_t len;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	cell = nvmem_cell_get(data->dev, cell_name);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	if (IS_ERR(buf)) {
> +		nvmem_cell_put(cell);
> +		return PTR_ERR(buf);
> +	}
> +
> +	memcpy(&origin_calib_data, buf, min(len, sizeof(u32)));
> +
> +	kfree(buf);
> +	nvmem_cell_put(cell);
> +	return origin_calib_data;
> +}
> +
>  static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>  					bool big_scale)
>  {
>  	const struct sc27xx_adc_linear_graph *calib_graph;
>  	struct sc27xx_adc_linear_graph *graph;
> -	struct nvmem_cell *cell;
>  	const char *cell_name;
>  	u32 calib_data = 0;
> -	void *buf;
> -	size_t len;
>  
>  	if (big_scale) {
>  		calib_graph = data->var_data->bscale_cal;
> @@ -157,24 +182,13 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>  		cell_name = "small_scale_calib";
>  	}
>  
> -	cell = nvmem_cell_get(data->dev, cell_name);
> -	if (IS_ERR(cell))
> -		return PTR_ERR(cell);
> -
> -	buf = nvmem_cell_read(cell, &len);
> -	nvmem_cell_put(cell);
> -
> -	if (IS_ERR(buf))
> -		return PTR_ERR(buf);
> -
> -	memcpy(&calib_data, buf, min(len, sizeof(u32)));
> +	calib_data = adc_nvmem_cell_calib_data(data, cell_name);
>  
>  	/* Only need to calibrate the adc values in the linear graph. */
>  	graph->adc0 = sc27xx_adc_get_calib_data(calib_data, calib_graph->adc0);
>  	graph->adc1 = sc27xx_adc_get_calib_data(calib_data >> 8,
>  						calib_graph->adc1);
>  
> -	kfree(buf);
>  	return 0;
>  }
>  
> @@ -285,6 +299,7 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  disable_adc:
>  	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>  			   SC27XX_ADC_EN, 0);
> +

Unrelated change that shouldn't be in this patch.

>  unlock_adc:
>  	hwspin_unlock_raw(data->hwlock);
>  
> @@ -305,7 +320,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
>  	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
>  }
>  
> -static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> +static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
>  			      int raw_adc)
>  {
>  	int tmp;
> @@ -314,6 +329,16 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
>  	tmp /= (graph->adc0 - graph->adc1);
>  	tmp += graph->volt1;
>  
> +	return tmp;
> +}
> +
> +static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> +			      int raw_adc)
> +{
> +	int tmp;
> +
> +	tmp = adc_to_volt(graph, raw_adc);
> +
>  	return tmp < 0 ? 0 : tmp;
>  }
>  

