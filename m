Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43B3572A32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiGMAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGMAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:20:13 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6BB9B1BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:20:10 -0700 (PDT)
Received: from [192.168.1.101] (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 17BE23F479;
        Wed, 13 Jul 2022 02:20:08 +0200 (CEST)
Message-ID: <be04f034-5aa9-f931-3992-b0fb08fcd202@somainline.org>
Date:   Wed, 13 Jul 2022 02:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/drivers/qcom: Code refactoring
Content-Language: en-US
To:     Carlos Bilbao <carlos.bilbao@amd.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org,
        david.brown@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
References: <20220712173127.3677491-1-carlos.bilbao@amd.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220712173127.3677491-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.07.2022 19:31, Carlos Bilbao wrote:
> Some functions in tsens-8960.c can directly return ret instead of doing an
> extra check. In function calibrate_8960(), a second check for IS_ERR(data)
> can also be avoided in some cases. A constant could be used to represent
> the maximum number of sensors (11). Finally, function code_to_degc() can be
> simplified, avoiding using an extra variable.
> 
> Include these small refactoring changes.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  drivers/thermal/qcom/tsens-8960.c   | 25 +++++++++----------------
>  drivers/thermal/qcom/tsens-common.c | 18 ++++++++----------
>  drivers/thermal/qcom/tsens-v0_1.c   |  6 +++---
>  drivers/thermal/qcom/tsens-v1.c     |  2 +-
>  drivers/thermal/qcom/tsens.h        |  1 +
>  5 files changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 8d9b721dadb6..576bca871655 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -76,10 +76,8 @@ static int suspend_8960(struct tsens_priv *priv)
>  		mask = SLP_CLK_ENA_8660 | EN;
>  
>  	ret = regmap_update_bits(map, CNTL_ADDR, mask, 0);
> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int resume_8960(struct tsens_priv *priv)
> @@ -106,10 +104,8 @@ static int resume_8960(struct tsens_priv *priv)
>  		return ret;
>  
>  	ret = regmap_write(map, CNTL_ADDR, priv->ctx.control);
> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int enable_8960(struct tsens_priv *priv, int id)
> @@ -132,10 +128,8 @@ static int enable_8960(struct tsens_priv *priv, int id)
>  		reg |= mask | SLP_CLK_ENA_8660 | EN;
>  
>  	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg);
> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void disable_8960(struct tsens_priv *priv)
> @@ -206,10 +200,8 @@ static int init_8960(struct tsens_priv *priv)
>  
>  	reg_cntl |= EN;
>  	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int calibrate_8960(struct tsens_priv *priv)
> @@ -221,10 +213,11 @@ static int calibrate_8960(struct tsens_priv *priv)
>  	struct tsens_sensor *s = priv->sensor;
>  
>  	data = qfprom_read(priv->dev, "calib");
> -	if (IS_ERR(data))
> +	if (IS_ERR(data)) {
>  		data = qfprom_read(priv->dev, "calib_backup");
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +		if (IS_ERR(data))
> +			return PTR_ERR(data);
> +	}
>  
>  	for (i = 0; i < num_read; i++, s++)
>  		s->offset = data[i];
> @@ -278,6 +271,6 @@ static const struct tsens_ops ops_8960 = {
>  };
>  
>  const struct tsens_plat_data data_8960 = {
> -	.num_sensors	= 11,
> +	.num_sensors	= MAX_NUM_SENSORS,
>  	.ops		= &ops_8960,
>  };
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 528df8801254..fe5f4459e1cc 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -66,19 +66,17 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>  
>  static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
>  {
> -	int degc, num, den;
> +	int degc, den;
>  
> -	num = (adc_code * SLOPE_FACTOR) - s->offset;
> +	degc = (adc_code * SLOPE_FACTOR) - s->offset;
>  	den = s->slope;
>  
> -	if (num > 0)
> -		degc = num + (den / 2);
> -	else if (num < 0)
> -		degc = num - (den / 2);
> -	else
> -		degc = num;
> -
> -	degc /= den;
> +	if (degc != 0) {
> +		if (degc > 0)
> +			degc = (degc + (den / 2)) / den;
> +		else
> +			degc = (degc - (den / 2)) / den;
> +	}
>  
>  	return degc;
>  }
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 6f26fadf4c27..42e897526345 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -188,7 +188,7 @@ static int calibrate_8916(struct tsens_priv *priv)
>  static int calibrate_8974(struct tsens_priv *priv)
>  {
>  	int base1 = 0, base2 = 0, i;
> -	u32 p1[11], p2[11];
> +	u32 p1[MAX_NUM_SENSORS], p2[MAX_NUM_SENSORS];
>  	int mode = 0;
>  	u32 *calib, *bkp;
>  	u32 calib_redun_sel;
> @@ -324,7 +324,7 @@ static const struct tsens_features tsens_v0_1_feat = {
>  	.crit_int	= 0,
>  	.adc		= 1,
>  	.srot_split	= 1,
> -	.max_sensors	= 11,
> +	.max_sensors	= MAX_NUM_SENSORS,
>  };
>  
>  static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
> @@ -374,7 +374,7 @@ static const struct tsens_ops ops_8974 = {
>  };
>  
>  const struct tsens_plat_data data_8974 = {
> -	.num_sensors	= 11,
> +	.num_sensors	= MAX_NUM_SENSORS,
>  	.ops		= &ops_8974,
>  	.feat		= &tsens_v0_1_feat,
>  	.fields	= tsens_v0_1_regfields,
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 10b595d4f619..98acc9b64555 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -149,7 +149,7 @@ static const struct tsens_features tsens_v1_feat = {
>  	.crit_int	= 0,
>  	.adc		= 1,
>  	.srot_split	= 1,
> -	.max_sensors	= 11,
> +	.max_sensors	= MAX_NUM_SENSORS,
>  };
>  
>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 2fd94997245b..d2d78c7e20c8 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -6,6 +6,7 @@
>  #ifndef __QCOM_TSENS_H__
>  #define __QCOM_TSENS_H__
>  
> +#define MAX_NUM_SENSORS		11
Hi, this number matching up for v0.1 and v1 is purely coincidental
and will change when more platforms are added. Please keep them
separate to avoid confusion in the future.

Konrad
>  #define ONE_PT_CALIB		0x1
>  #define ONE_PT_CALIB2		0x2
>  #define TWO_PT_CALIB		0x3
> 
