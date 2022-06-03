Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C31053CBC9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbiFCOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245210AbiFCOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:53:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9965536E29;
        Fri,  3 Jun 2022 07:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54D49B82353;
        Fri,  3 Jun 2022 14:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0635C34115;
        Fri,  3 Jun 2022 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654268003;
        bh=RGs1KTCePcSrsr1+5HQQpGae3Pc4JtwnBu3hdoIvrOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WyGYjYddMk07o8bazntYbtCK4zbeCa7DEFE/TCozDMhF03Fe4kU8LPm3p5kSO9WSj
         t3nk+MJHJEX0Yv2UYRgLUFBV3Hc84R61uyURYdZ3/eSIkFLkP6KKBi0TSTllFLd7JP
         +2teddVxCFSl8S/YtwTHoTophTXWrIyq2O/Ug1pjO3cnW67rIVdln312x0G470x0UX
         002zGcinS6p0imEfVb1ZI5xg2WnTpGyqcQGluIwWrbIwPXAZEWaRdvrWw/TLm8tfnw
         Zp6/LuokL19/fMx0waN2xmdGuMl2dvo+KCy8Hpm+Ilj2IfHgr+e519ywVOgM2cn78o
         PHgMnTz8aZq5g==
Date:   Fri, 3 Jun 2022 16:02:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lars@metafoo.de,
        svarbanov@mm-sol.com, iivanov@mm-sol.com,
        jonathan.cameron@huawei.com, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn
Subject: Re: [PATCH v4] iio: vadc: Fix potential dereference of NULL pointer
Message-ID: <20220603160222.1ad6ef49@jic23-huawei>
In-Reply-To: <1653238427-73587-1-git-send-email-lyz_cs@pku.edu.cn>
References: <20220522120109.7ead18a7@jic23-huawei>
        <1653238427-73587-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2022 09:53:47 -0700
Yongzhi Liu <lyz_cs@pku.edu.cn> wrote:

> The return value of vadc_get_channel() needs to be checked to
> avoid use of NULL pointer. vadc_do_conversion() already provides
> error prints in at least some of it's error paths. Thus it is
> reasonable to add the null pointer check on prop and drop the
> extra reporting in vadc_measure_ref_points().
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>

Hi

Biggest remaining thing is squashing
ret = -ENODEV;
return ret;

into the shorter
return -ENODEV;


> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 34202ba..43a52b1 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -358,22 +358,33 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
>  
>  	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
> +	if (!prop) {
> +		dev_err(vadc->dev, "Please define 1.25V channel\n");
Probably makes more sense to have the error as 
"No 1.25V channel found\n");

It's not obvious to anyone getting this error what 'define' might mean
without them looking at the code, so I'd rather we just said what had
gone wrong rather offering incomplete advice.

> +		ret = -ENODEV;

Don't bother assigning a variable just to return it in the next line.

return -ENODEV;

> +		return ret;
> +	}
>  	ret = vadc_do_conversion(vadc, prop, &read_1);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	/* Try with buffered 625mV channel first */
>  	prop = vadc_get_channel(vadc, VADC_SPARE1);
> -	if (!prop)
> +	if (!prop) {
>  		prop = vadc_get_channel(vadc, VADC_REF_625MV);
> +		if (!prop) {
> +			dev_err(vadc->dev, "Please define 0.625V channel\n");
"No 0.625V channel found\n"
> +			ret = -ENODEV;

return -ENODEV;

> +			return ret;
> +		}
> +	}
>  
>  	ret = vadc_do_conversion(vadc, prop, &read_2);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	if (read_1 == read_2) {
>  		ret = -EINVAL;
> -		goto err;
> +		return ret;
>  	}
>  
>  	vadc->graph[VADC_CALIB_ABSOLUTE].dy = read_1 - read_2;
> @@ -381,25 +392,32 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  
>  	/* Ratiometric calibration */
>  	prop = vadc_get_channel(vadc, VADC_VDD_VADC);
> +	if (!prop) {
> +		dev_err(vadc->dev, "Please define VDD channel\n");

"No VDD channel found\n"

> +		ret = -ENODEV;
> +		return ret;
> +	}
>  	ret = vadc_do_conversion(vadc, prop, &read_1);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	prop = vadc_get_channel(vadc, VADC_GND_REF);
> +	if (!prop) {
> +		dev_err(vadc->dev, "Please define GND channel\n");

"No GND channel found\n"

> +		ret = -ENODEV;
> +		return ret;

return -ENODEV;

> +	}
>  	ret = vadc_do_conversion(vadc, prop, &read_2);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	if (read_1 == read_2) {
>  		ret = -EINVAL;
> -		goto err;
> +		return ret;

return -ENODEV;

>  	}
>  
>  	vadc->graph[VADC_CALIB_RATIOMETRIC].dy = read_1 - read_2;
>  	vadc->graph[VADC_CALIB_RATIOMETRIC].gnd = read_2;
> -err:
> -	if (ret)
> -		dev_err(vadc->dev, "measure reference points failed\n");
>  
>  	return ret;

Can't get here with anything other than ret == 0 so
	return 0;
to make that explicit.


>  }

