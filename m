Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B0485B17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiAEVvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbiAEVve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:51:34 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E140C0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:51:34 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id r7-20020a05683001c700b005906f5b0969so916159ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2keR8hCMUDIY7bnNjmG+SAvoD6opBafNXfTHV+Fh0DA=;
        b=PbgzYXDhpebbQ8HJD9s+CMOouBvRusJVw6TWznVldZPDR0uZ7XWAzbyOD2T2J0fp+F
         Ydap/7y3W7BKC389hdxz963xdS2nTHKtAB9I+ZOhq5cbpBqA5KL/Kut7z3mYNHFovUUw
         r+j7JNlTEtkP5hsyBatFonqkP5c87V6ZGoSax83yPAdueQT9UxQJ0unO3lRKGlMqybBm
         VwxlQiEu/ueMijLaX562L8rJZeSeDUJJlueVeRJ18ZXmL/0nRiGwSr+ZbCewtq0ZkrE6
         Kgt4YhmqgazwiwmR5UdP5VDWKaS4v/AxLiADbnHhX8BnWvsSF9cOErYUwQmOEwmrz0YS
         fMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2keR8hCMUDIY7bnNjmG+SAvoD6opBafNXfTHV+Fh0DA=;
        b=vEXhTjN+aoE5KoIrLPlTWYrhTDk5G4pY5VP5CD8Nvu1DOFyIYir5qWlocBtZnB9+EZ
         j6Mn4n/dy8hm4967wsHGZR1WuoPDBz3Yf4E7E7TxKoqdgH+Xay7UVnMnT5MRV5mc57a4
         3mLjtHZuHpu3/1sM/U5oTQxNOy4xyjvscZwI+2RM8yc7EKCe+tHYtGVh0i7Z3dkRvoOK
         c6ln49O+FDQFNFKdZSicqARtA2frJsUeCbN0WUMDyiKFkt4YqpT9PfwLF1TblhMsEZtb
         dQDzHv7XjzNpcf3Eg2eYi6F9I3txcyNX/yioVQyrZjM55TOjjUM1Dd7cQmBAV8FBCdp4
         jiBA==
X-Gm-Message-State: AOAM533tTZy0y0x3mgYy+Mif3P7MEXgOIv/rfbLhBAVxe3em4DfhKqIt
        L+6HrHXaEJFZCGZMP7YnVVJa2Q==
X-Google-Smtp-Source: ABdhPJxzCvfc1uKh7RaRPbxKo+wYz4qfhrjAj2y8Fbw99Dl0hoag8VY3AOGBjREkCSDZqAefpeRdzw==
X-Received: by 2002:a9d:74ca:: with SMTP id a10mr2521610otl.222.1641419493649;
        Wed, 05 Jan 2022 13:51:33 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e20sm48385oiw.32.2022.01.05.13.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 13:51:33 -0800 (PST)
Date:   Wed, 5 Jan 2022 13:52:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/3] thermal: qcom: lmh: Add support for sm8150
Message-ID: <YdYTFu/QTZ5DS95M@ripper>
References: <20211215163400.33349-1-thara.gopinath@linaro.org>
 <20211215163400.33349-2-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215163400.33349-2-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15 Dec 08:33 PST 2021, Thara Gopinath wrote:

> Add compatible to support LMh for sm8150 SoC.
> sm8150 does not require explicit enabling for various LMh subsystems.
> Add a variable indicating the same as match data which is set for sdm845.
> Execute the piece of code enabling various LMh subsystems only if
> enable algorithm match data is present.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v1->v2:
> 	- Added LMH_ENABLE_ALGOS of_device_id match data to indicate
> 	  whether LMh subsytems need explicit enabling or not.
> 
>  drivers/thermal/qcom/lmh.c | 62 +++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> index eafa7526eb8b..80d26d043498 100644
> --- a/drivers/thermal/qcom/lmh.c
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -28,6 +28,8 @@
>  
>  #define LMH_REG_DCVS_INTR_CLR		0x8
>  
> +#define LMH_ENABLE_ALGOS		((void *)1)
> +
>  struct lmh_hw_data {
>  	void __iomem *base;
>  	struct irq_domain *domain;
> @@ -87,6 +89,7 @@ static int lmh_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> +	const struct of_device_id *of_id;
>  	struct device_node *cpu_node;
>  	struct lmh_hw_data *lmh_data;
>  	int temp_low, temp_high, temp_arm, cpu_id, ret;
> @@ -141,32 +144,36 @@ static int lmh_probe(struct platform_device *pdev)
>  	if (!qcom_scm_lmh_dcvsh_available())
>  		return -EINVAL;
>  
> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
> -				 LMH_NODE_DCVS, node_id, 0);
> -	if (ret)
> -		dev_err(dev, "Error %d enabling current subfunction\n", ret);
> -
> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
> -				 LMH_NODE_DCVS, node_id, 0);
> -	if (ret)
> -		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
> -
> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
> -				 LMH_NODE_DCVS, node_id, 0);
> -	if (ret)
> -		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
> -
> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
> -				 LMH_NODE_DCVS, node_id, 0);
> -	if (ret) {
> -		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
> -		return ret;
> -	}
> -
> -	ret = qcom_scm_lmh_profile_change(0x1);
> -	if (ret) {
> -		dev_err(dev, "Error %d changing profile\n", ret);
> -		return ret;
> +	of_id = of_match_device(dev->driver->of_match_table, dev);

I think it would be preferable to use of_device_get_match_data() and
assign this to an unsigned long.

> +
> +	if (of_id && of_id->data == LMH_ENABLE_ALGOS) {

Then you don't need to check of_id for NULL here and this would lend
itself nicely to be a bitmask of enabled algorithms if some platform
would need to enable a subset of these.

> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
> +					 LMH_NODE_DCVS, node_id, 0);
> +		if (ret)
> +			dev_err(dev, "Error %d enabling current subfunction\n", ret);
> +
> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
> +					 LMH_NODE_DCVS, node_id, 0);
> +		if (ret)
> +			dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
> +
> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
> +					 LMH_NODE_DCVS, node_id, 0);
> +		if (ret)
> +			dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
> +
> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
> +					 LMH_NODE_DCVS, node_id, 0);
> +		if (ret) {
> +			dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
> +			return ret;
> +		}
> +
> +		ret = qcom_scm_lmh_profile_change(0x1);
> +		if (ret) {
> +			dev_err(dev, "Error %d changing profile\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	/* Set default thermal trips */
> @@ -213,7 +220,8 @@ static int lmh_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id lmh_table[] = {
> -	{ .compatible = "qcom,sdm845-lmh", },
> +	{ .compatible = "qcom,sdm845-lmh", .data = LMH_ENABLE_ALGOS},

Make LMH_ENABLE_ALGOS just an integer define and add the explicit (void
*) cast here.

Regards,
Bjorn

> +	{ .compatible = "qcom,sm8150-lmh", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, lmh_table);
> -- 
> 2.25.1
> 
