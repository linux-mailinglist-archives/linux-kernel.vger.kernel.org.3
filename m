Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB09530283
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbiEVKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiEVKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10513DC8;
        Sun, 22 May 2022 03:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6658F60F89;
        Sun, 22 May 2022 10:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E1C385AA;
        Sun, 22 May 2022 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653216744;
        bh=XkjzRJOvGbnB6EuU1d328KQW9nW7oibHRbiluKzJMms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ekg6Lmowqi6XMY4Fr/+jw/DJ6EF7j+joDBwDNtGU3vjZezb7uBfIT+VDORZ/HYceB
         eGJV2FJWqmbcolnDdqhvTHxcPXrVsMvmRdY64/O7jwb5B4vTVC/4fdb+uVfS9A1MZ+
         RVvcNGrTZKRaMS1tD+sPdfU1lJkf7KXwsI6VTaUFPvLLtD8BtkHga0X/xV3c1g25kj
         CV2HL6suuC1A1+ce6/BwV604FPvkhqx/iakaNjTcmVONZXVT5Tb7jA2MuFl88U/SEy
         yxPK+oY+6pD9+nqJvS/Z7N0MgIU2gj7r7wkfO4hM/MBKm6HkiTwss8d+OtO3wWFdjn
         cqBqxjNCTVgFA==
Date:   Sun, 22 May 2022 12:01:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lars@metafoo.de,
        svarbanov@mm-sol.com, iivanov@mm-sol.com,
        jonathan.cameron@huawei.com, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn
Subject: Re: [PATCH v3] iio: vadc: Fix potential dereference of NULL pointer
Message-ID: <20220522120109.7ead18a7@jic23-huawei>
In-Reply-To: <1653104135-36259-1-git-send-email-lyz_cs@pku.edu.cn>
References: <20220520181323.00002892@huawei.com>
        <1653104135-36259-1-git-send-email-lyz_cs@pku.edu.cn>
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

On Fri, 20 May 2022 20:35:35 -0700
Yongzhi Liu <lyz_cs@pku.edu.cn> wrote:

> The return value of vadc_get_channel() needs to be checked to
> avoid use of NULL pointer. Fix this by adding the null pointer
> check on prop and dropping general error prints.
> 
> Fixes: 0917de94c02f ("iio: vadc: Qualcomm SPMI PMIC voltage ADC driver")
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
Hi, 

Heading in the right direction. A few comments inline.

Thanks,

Jonathan

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
> +		ret = -ENODEV;
> +		return ret;

		return -ENODEV;

Same for the other case below.

> +	}
>  	ret = vadc_do_conversion(vadc, prop, &read_1);
>  	if (ret)
> -		goto err;

Good to add a note to the patch description that
vadc_do_conversion() already provides error prints in at least
some of it's error paths.  Thus it is reasonable to drop the
extra reporting in this function.

> +		return ret;
>  
>  	/* Try with buffered 625mV channel first */
>  	prop = vadc_get_channel(vadc, VADC_SPARE1);
> -	if (!prop)
> +	if (!prop) {
>  		prop = vadc_get_channel(vadc, VADC_REF_625MV);
> +		if (!prop) {
> +			dev_err(vadc->dev, "Please define 0.625V channel\n");
> +			ret = -ENODEV;
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
> +		ret = -ENODEV;
> +		return ret;
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
>  	}
>  
>  	vadc->graph[VADC_CALIB_RATIOMETRIC].dy = read_1 - read_2;
>  	vadc->graph[VADC_CALIB_RATIOMETRIC].gnd = read_2;
> -err:
> -	if (ret)
> -		dev_err(vadc->dev, "measure reference points failed\n");
>  
>  	return ret;
>  }

