Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2F50D3EA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiDXRZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiDXRZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:25:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C6C6655;
        Sun, 24 Apr 2022 10:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FDC5B80EAB;
        Sun, 24 Apr 2022 17:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7530CC385A7;
        Sun, 24 Apr 2022 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650820971;
        bh=8TMjDBDgpcomAsVaP9MlNAhl3VrxPdhymQBYOTG9SYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ik8jUjp4qS+NI7aTk/i0P5CHKk/ZZg+mxK556bvdeg7+hu/ipWZ993tkuwhYS5IT9
         BTrJK/7dgzrb9rgNASqJ9aWOl+6TKWK/jRGzty3Kmuj8tOh1pOx8tgd8Q4y7Kbd7nY
         7ECRR0tQAOppVjEFq279WfGM4ZeKoeYvf7WygnYqTq4fK5S0X9ojT9+S5xq9kfVDEU
         1gBlgenoLfY4J2ZbBv87/WYIINllvoop6QKfdWyi3shzpMRJ/UnxhB60Z4j++lM7D7
         Ef77192mSIpc7bOAUopdSCRlwcB5VVA1IlDIi2npkR4Vacf2Hrm1mcrT2D/S/hCbl5
         d0NLHz7/mI0dA==
Date:   Sun, 24 Apr 2022 18:30:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 5/7] iio: adc: refactor some functions for support
 more PMiCs
Message-ID: <20220424183058.5119dbf5@jic23-huawei>
In-Reply-To: <20220419142458.884933-6-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
        <20220419142458.884933-6-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 22:24:56 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
Added sc27xx to patch title whilst applying.

Also a small amount of 'fuzz' as a result of the edit I made to the earlier
patch to drop the comment but I think it all went in cleanly.

Thanks,

Jonathan

> 
> Refactor the common adc_nvmem_cell_calib_data,adc_to_volt and call
> these in the origin sc27xx_adc_scale_calibration,sc27xx_adc_to_volt
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 56 +++++++++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index a8906ffd85bf..27fab579a281 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -138,16 +138,41 @@ static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
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
> @@ -159,24 +184,13 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
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
> @@ -312,7 +326,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
>  	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
>  }
>  
> -static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> +static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
>  			      int raw_adc)
>  {
> 	int tmp;
> @@ -321,6 +335,16 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
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

