Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32B526935
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383296AbiEMS0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379489AbiEMS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:26:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95441C112
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:25:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so8609247pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LvNaxpjoaUlFTtBNRxE8yjy/4tj0kCCuQmjybWvYbvE=;
        b=FahUVFK2a1Iw3ahxCyvWoRO9xNxENlz4LB7rCEp0mXx2TPZmn4f23VejQkdP4JUu5Y
         KV2f+gaMrHdUb7NH9nh6fV2CoXLsdCfkX25QjsoJaiFcNHynT0d0G2SaVDOn5fwkjn/Q
         BHjfhbeqDVAYWUl1ZnyNG5QiPKVDo2nurAawywrBop3YhDwaQQSI2Ni0OddOtluQmVFA
         wYk7YkXK2+ugO7T2yhDjgEoVkCncjjqhG7akHIgVG88JS2fK6n6DXZEGZuYkw3aXba/t
         JABKNHZxLs9nzVugWgwdUQZOWnGRw1epMufLyG+DObbE8RhgNpaVe+W4IfbHXqp4WTwg
         99Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LvNaxpjoaUlFTtBNRxE8yjy/4tj0kCCuQmjybWvYbvE=;
        b=L10MkcVYSTaI+xSDEmhUShYGeW0Osm8dxqMd9Lem4Z+Gs2axfUDbsKALbluqiRCZvc
         JEHhjJJmtDFfviQ3btpYMDm4ndE1Fq9VzHQfRqzh2ncG1aKw39gw0n0K00+Frv4EhRf5
         29HVo3BZ9E2622lTwwoypWNqsW6rjhmIJeaGHFHtx+Mw/mqZ34up/D+PfXE4AcrzEPiX
         liK8myZooPGLJDCFs51nCkTiaMF/bjstL+iyNy8yQ5O6TYddVO9vIP8GR0tBNQiMZMb5
         6txGEV0xJb2MqAgzfCNkAFHgEqBzUnh6GNXQVEyoKL+DmmTydQd+JFQqeDvnjnosJYBx
         S3Pg==
X-Gm-Message-State: AOAM532wI6uzZo5QpIkuobYe3k5yP2thtUdhDJ0oPro2Fhm41qndRfgF
        QGKKZdEZmomvDynbtSSA16jz
X-Google-Smtp-Source: ABdhPJxYftoYbS3DDm3FCx1gPZLZV0L7aQ07r0ZGdxBj7UiFinhMT3L5C/lgxN2UhfI+GHwwRmqqBA==
X-Received: by 2002:a17:902:eb4d:b0:15e:d25c:4e0a with SMTP id i13-20020a170902eb4d00b0015ed25c4e0amr5882422pli.8.1652466357030;
        Fri, 13 May 2022 11:25:57 -0700 (PDT)
Received: from thinkpad ([117.202.184.246])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b0015e8d4eb222sm2222914plg.108.2022.05.13.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 11:25:56 -0700 (PDT)
Date:   Fri, 13 May 2022 23:55:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 7/7] ufs: use PM OPP when scaling gears
Message-ID: <20220513182546.GD1922@thinkpad>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
 <20220513061347.46480-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513061347.46480-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 08:13:47AM +0200, Krzysztof Kozlowski wrote:
> Scaling gears requires not only scaling clocks, but also voltage levels,
> e.g. via performance states.
> 
> Use the provided OPP table, to set proper OPP frequency which through
> required-opps will trigger performance state change.  This deprecates
> the old freq-table-hz Devicetree property and old clock scaling method
> in favor of PM core code.
> 

To be clear, you are not changing the voltages (UFS supplies) through OPP. But
rather handle only clks and leave the power domain handling to parent OPP
device.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> ---
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/scsi/ufs/ufshcd-pltfrm.c |  73 +++++++++++++++
>  drivers/scsi/ufs/ufshcd.c        | 150 ++++++++++++++++++++++++-------
>  drivers/scsi/ufs/ufshcd.h        |   6 ++
>  3 files changed, 195 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index 3ab555f6e66e..a603ca8e383b 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  
> @@ -108,6 +109,72 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>  	return ret;
>  }
>  
> +static int ufshcd_parse_operating_points(struct ufs_hba *hba)
> +{
> +	struct device *dev = hba->dev;
> +	struct device_node *np = dev->of_node;
> +	struct ufs_clk_info *clki;
> +	const char *names[16];
> +	int cnt, i, ret;
> +
> +	if (!of_find_property(dev->of_node, "operating-points-v2", NULL))
> +		return 0;
> +
> +	cnt = of_property_count_strings(np, "clock-names");
> +	if (cnt <= 0) {
> +		dev_warn(dev, "%s: Missing clock-names\n",
> +			 __func__);

This is a hard error, right? So why not dev_err()?

> +		return -EINVAL;
> +	}
> +
> +	if (cnt > ARRAY_SIZE(names)) {
> +		dev_info(dev, "%s: Too many clock-names\n",  __func__);

dev_err()?

> +		return -EINVAL;
> +	}
> +
> +	if (of_find_property(np, "freq-table-hz", NULL)) {
> +		dev_info(dev, "%s: operating-points and freq-table-hz are incompatible\n",
> +			 __func__);

dev_err()?

> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		ret = of_property_read_string_index(np, "clock-names", i,
> +						    &names[i]);
> +		if (ret)
> +			return ret;
> +
> +		clki = devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
> +		if (!clki)
> +			return -ENOMEM;
> +
> +		clki->name = devm_kstrdup(dev, names[i], GFP_KERNEL);
> +		if (!clki->name)
> +			return -ENOMEM;
> +
> +		if (!strcmp(names[i], "ref_clk"))
> +			clki->keep_link_active = true;
> +
> +		list_add_tail(&clki->list, &hba->clk_list_head);
> +	}
> +
> +	ret = devm_pm_opp_set_clknames(dev, names, i);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_opp_register_set_opp_helper(dev, ufshcd_set_opp);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret)
> +		return ret;
> +
> +	hba->use_pm_opp = true;
> +

Since you are only handling the clks in UFS driver's OPP implementation, it
warrants atleast a comment. Otherwise, someone will add voltage to the OPP
table and complain that it is not getting changed. Eventhough the UFS driver
won't allow doing it, it is safer to mention it explicitly.

Also I'm worried about the implementation specific to Qcom platforms. Like we
rely on RPMHPD to handle the power domains, but that may not be true for other
platforms. I know that we cannot support all possible implementations but
atleast we should document this limitation.

Rest looks fine to me. I'll take one more look after testing this series on
SM8450.

Thanks,
Mani

> +	return 0;
> +}
> +
>  #define MAX_PROP_SIZE 32
>  static int ufshcd_populate_vreg(struct device *dev, const char *name,
>  		struct ufs_vreg **out_vreg)
> @@ -363,6 +430,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>  		goto dealloc_host;
>  	}
>  
> +	err = ufshcd_parse_operating_points(hba);
> +	if (err) {
> +		dev_err(dev, "%s: OPP parse failed %d\n", __func__, err);
> +		goto dealloc_host;
> +	}
> +
>  	ufshcd_init_lanes_per_dir(hba);
>  
>  	err = ufshcd_init(hba, mmio_base, irq);
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index ea43aa2d26e1..9f07c4fd0087 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -20,6 +20,7 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/pm_opp.h>
>  #include <linux/regulator/consumer.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_dbg.h>
> @@ -259,7 +260,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba);
>  static void ufshcd_resume_clkscaling(struct ufs_hba *hba);
>  static void ufshcd_suspend_clkscaling(struct ufs_hba *hba);
>  static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba);
> -static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up);
> +static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up,
> +			     unsigned long freq);
>  static irqreturn_t ufshcd_intr(int irq, void *__hba);
>  static int ufshcd_change_power_mode(struct ufs_hba *hba,
>  			     struct ufs_pa_layer_attr *pwr_mode);
> @@ -962,7 +964,7 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
>  }
>  
>  /**
> - * ufshcd_set_clk_freq - set UFS controller clock frequencies
> + * ufshcd_set_clk_freq - set UFS controller clock frequencies (directly)
>   * @hba: per adapter instance
>   * @scale_up: If True, set max possible frequency othewise set low frequency
>   *
> @@ -1024,15 +1026,48 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
>  	return ret;
>  }
>  
> +/**
> + * ufshcd_set_opp - scale UFS controller clocks, called via PM OPP
> + * @data: PM OPP data
> + *
> + * Returns 0 for success, non-zero error value for errors.
> + */
> +int ufshcd_set_opp(struct dev_pm_set_opp_data *data)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(data->dev);
> +	int i, ret;
> +
> +	if (!data->clk_count)
> +		return 0;
> +
> +	for (i = 0; i < data->clk_count; i++) {
> +		if (!data->new_opp.rates[i])
> +			continue;
> +
> +		ret = clk_set_rate(data->clks[i].clk, data->new_opp.rates[i]);
> +		if (ret) {
> +			dev_err(hba->dev, "%s: %pC clk set rate(%luHz) failed, %d\n",
> +				__func__, data->clks[i].clk,
> +				data->new_opp.rates[i], ret);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_set_opp);
> +
>  /**
>   * ufshcd_scale_clks - scale up or scale down UFS controller clocks
>   * @hba: per adapter instance
>   * @scale_up: True if scaling up and false if scaling down
> + * @freq: Target frequency
>   *
>   * Returns 0 if successful
>   * Returns < 0 for any other errors
>   */
> -static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
> +static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up,
> +			     unsigned long freq)
>  {
>  	int ret = 0;
>  	ktime_t start = ktime_get();
> @@ -1041,13 +1076,21 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
>  	if (ret)
>  		goto out;
>  
> -	ret = ufshcd_set_clk_freq(hba, scale_up);
> +	if (hba->use_pm_opp)
> +		ret = dev_pm_opp_set_rate(hba->dev, freq);
> +	else
> +		ret = ufshcd_set_clk_freq(hba, scale_up);
>  	if (ret)
>  		goto out;
>  
>  	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
> -	if (ret)
> -		ufshcd_set_clk_freq(hba, !scale_up);
> +	if (ret) {
> +		if (hba->use_pm_opp)
> +			dev_pm_opp_set_rate(hba->dev,
> +					    hba->devfreq->previous_freq);
> +		else
> +			ufshcd_set_clk_freq(hba, !scale_up);
> +	}
>  
>  out:
>  	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
> @@ -1059,11 +1102,13 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
>  /**
>   * ufshcd_is_devfreq_scaling_required - check if scaling is required or not
>   * @hba: per adapter instance
> + * @freq: Target frequency
>   * @scale_up: True if scaling up and false if scaling down
>   *
>   * Returns true if scaling is required, false otherwise.
>   */
>  static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
> +					       unsigned long freq,
>  					       bool scale_up)
>  {
>  	struct ufs_clk_info *clki;
> @@ -1072,6 +1117,9 @@ static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
>  	if (list_empty(head))
>  		return false;
>  
> +	if (hba->use_pm_opp)
> +		return freq != hba->clk_scaling.target_freq;
> +
>  	list_for_each_entry(clki, head, list) {
>  		if (!IS_ERR_OR_NULL(clki->clk)) {
>  			if (scale_up && clki->max_freq) {
> @@ -1251,13 +1299,15 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, bool writelock)
>  /**
>   * ufshcd_devfreq_scale - scale up/down UFS clocks and gear
>   * @hba: per adapter instance
> + * @freq: Target frequency
>   * @scale_up: True for scaling up and false for scalin down
>   *
>   * Returns 0 for success,
>   * Returns -EBUSY if scaling can't happen at this time
>   * Returns non-zero for any other errors
>   */
> -static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
> +static int ufshcd_devfreq_scale(struct ufs_hba *hba, unsigned long freq,
> +				bool scale_up)
>  {
>  	int ret = 0;
>  	bool is_writelock = true;
> @@ -1273,7 +1323,7 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
>  			goto out_unprepare;
>  	}
>  
> -	ret = ufshcd_scale_clks(hba, scale_up);
> +	ret = ufshcd_scale_clks(hba, scale_up, freq);
>  	if (ret) {
>  		if (!scale_up)
>  			ufshcd_scale_gear(hba, true);
> @@ -1284,7 +1334,8 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
>  	if (scale_up) {
>  		ret = ufshcd_scale_gear(hba, true);
>  		if (ret) {
> -			ufshcd_scale_clks(hba, false);
> +			ufshcd_scale_clks(hba, false,
> +					  hba->devfreq->previous_freq);
>  			goto out_unprepare;
>  		}
>  	}
> @@ -1347,9 +1398,20 @@ static int ufshcd_devfreq_target(struct device *dev,
>  	if (!ufshcd_is_clkscaling_supported(hba))
>  		return -EINVAL;
>  
> -	clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
>  	/* Override with the closest supported frequency */
> -	*freq = (unsigned long) clk_round_rate(clki->clk, *freq);
> +	if (hba->use_pm_opp) {
> +		struct dev_pm_opp *opp;
> +
> +		opp = devfreq_recommended_opp(dev, freq, flags);
> +		if (IS_ERR(opp))
> +			return PTR_ERR(opp);
> +		dev_pm_opp_put(opp);
> +	} else {
> +		clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info,
> +					list);
> +		*freq =	(unsigned long) clk_round_rate(clki->clk, *freq);
> +	}
> +
>  	spin_lock_irqsave(hba->host->host_lock, irq_flags);
>  	if (ufshcd_eh_in_progress(hba)) {
>  		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
> @@ -1365,11 +1427,11 @@ static int ufshcd_devfreq_target(struct device *dev,
>  	}
>  
>  	/* Decide based on the rounded-off frequency and update */
> -	scale_up = *freq == clki->max_freq;
> -	if (!scale_up)
> +	scale_up = (*freq > hba->clk_scaling.target_freq);
> +	if (!hba->use_pm_opp && !scale_up)
>  		*freq = clki->min_freq;
>  	/* Update the frequency */
> -	if (!ufshcd_is_devfreq_scaling_required(hba, scale_up)) {
> +	if (!ufshcd_is_devfreq_scaling_required(hba, *freq, scale_up)) {
>  		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
>  		ret = 0;
>  		goto out; /* no state change required */
> @@ -1377,7 +1439,9 @@ static int ufshcd_devfreq_target(struct device *dev,
>  	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
>  
>  	start = ktime_get();
> -	ret = ufshcd_devfreq_scale(hba, scale_up);
> +	ret = ufshcd_devfreq_scale(hba, *freq, scale_up);
> +	if (!ret)
> +		hba->clk_scaling.target_freq = *freq;
>  
>  	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
>  		(scale_up ? "up" : "down"),
> @@ -1397,8 +1461,6 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
>  	struct ufs_hba *hba = dev_get_drvdata(dev);
>  	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
>  	unsigned long flags;
> -	struct list_head *clk_list = &hba->clk_list_head;
> -	struct ufs_clk_info *clki;
>  	ktime_t curr_t;
>  
>  	if (!ufshcd_is_clkscaling_supported(hba))
> @@ -1411,13 +1473,20 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
>  	if (!scaling->window_start_t)
>  		goto start_window;
>  
> -	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> -	/*
> -	 * If current frequency is 0, then the ondemand governor considers
> -	 * there's no initial frequency set. And it always requests to set
> -	 * to max. frequency.
> -	 */
> -	stat->current_frequency = clki->curr_freq;
> +	if (hba->use_pm_opp) {
> +		stat->current_frequency = hba->clk_scaling.target_freq;
> +	} else {
> +		struct list_head *clk_list = &hba->clk_list_head;
> +		struct ufs_clk_info *clki;
> +
> +		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> +		/*
> +		 * If current frequency is 0, then the ondemand governor considers
> +		 * there's no initial frequency set. And it always requests to set
> +		 * to max. frequency.
> +		 */
> +		stat->current_frequency = clki->curr_freq;
> +	}
>  	if (scaling->is_busy_started)
>  		scaling->tot_busy_t += ktime_us_delta(curr_t,
>  				scaling->busy_start_t);
> @@ -1450,9 +1519,11 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
>  	if (list_empty(clk_list))
>  		return 0;
>  
> -	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> -	dev_pm_opp_add(hba->dev, clki->min_freq, 0);
> -	dev_pm_opp_add(hba->dev, clki->max_freq, 0);
> +	if (!hba->use_pm_opp) {
> +		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> +		dev_pm_opp_add(hba->dev, clki->min_freq, 0);
> +		dev_pm_opp_add(hba->dev, clki->max_freq, 0);
> +	}
>  
>  	ufshcd_vops_config_scaling_param(hba, &hba->vps->devfreq_profile,
>  					 &hba->vps->ondemand_data);
> @@ -1464,8 +1535,10 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
>  		ret = PTR_ERR(devfreq);
>  		dev_err(hba->dev, "Unable to register with devfreq %d\n", ret);
>  
> -		dev_pm_opp_remove(hba->dev, clki->min_freq);
> -		dev_pm_opp_remove(hba->dev, clki->max_freq);
> +		if (!hba->use_pm_opp) {
> +			dev_pm_opp_remove(hba->dev, clki->min_freq);
> +			dev_pm_opp_remove(hba->dev, clki->max_freq);
> +		}
>  		return ret;
>  	}
>  
> @@ -1477,7 +1550,6 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
>  static void ufshcd_devfreq_remove(struct ufs_hba *hba)
>  {
>  	struct list_head *clk_list = &hba->clk_list_head;
> -	struct ufs_clk_info *clki;
>  
>  	if (!hba->devfreq)
>  		return;
> @@ -1485,9 +1557,13 @@ static void ufshcd_devfreq_remove(struct ufs_hba *hba)
>  	devfreq_remove_device(hba->devfreq);
>  	hba->devfreq = NULL;
>  
> -	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> -	dev_pm_opp_remove(hba->dev, clki->min_freq);
> -	dev_pm_opp_remove(hba->dev, clki->max_freq);
> +	if (!hba->use_pm_opp) {
> +		struct ufs_clk_info *clki;
> +
> +		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> +		dev_pm_opp_remove(hba->dev, clki->min_freq);
> +		dev_pm_opp_remove(hba->dev, clki->max_freq);
> +	}
>  }
>  
>  static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
> @@ -1571,8 +1647,14 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
>  	if (value) {
>  		ufshcd_resume_clkscaling(hba);
>  	} else {
> +		struct dev_pm_opp *opp;
> +		unsigned long freq = ULONG_MAX;
> +
> +		opp = dev_pm_opp_find_freq_floor(dev, &freq);
> +		dev_pm_opp_put(opp);
> +
>  		ufshcd_suspend_clkscaling(hba);
> -		err = ufshcd_devfreq_scale(hba, true);
> +		err = ufshcd_devfreq_scale(hba, freq, true);
>  		if (err)
>  			dev_err(hba->dev, "%s: failed to scale clocks up %d\n",
>  					__func__, err);
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 0b8d0192f069..6962d36e6c65 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -400,6 +400,7 @@ struct ufs_saved_pwr_info {
>   * @is_initialized: Indicates whether clock scaling is initialized or not
>   * @is_busy_started: tracks if busy period has started or not
>   * @is_suspended: tracks if devfreq is suspended or not
> + * @target_freq: frequency requested by devfreq framework
>   */
>  struct ufs_clk_scaling {
>  	int active_reqs;
> @@ -417,6 +418,7 @@ struct ufs_clk_scaling {
>  	bool is_initialized;
>  	bool is_busy_started;
>  	bool is_suspended;
> +	unsigned long target_freq;
>  };
>  
>  #define UFS_EVENT_HIST_LENGTH 8
> @@ -771,6 +773,8 @@ struct ufs_hba_monitor {
>   * @auto_bkops_enabled: to track whether bkops is enabled in device
>   * @vreg_info: UFS device voltage regulator information
>   * @clk_list_head: UFS host controller clocks list node head
> + * @use_pm_opp: whether OPP table is provided and scaling gears should trigger
> + *              setting OPP
>   * @req_abort_count: number of times ufshcd_abort() has been called
>   * @lanes_per_direction: number of lanes per data direction between the UFS
>   *	controller and the UFS device.
> @@ -906,6 +910,7 @@ struct ufs_hba {
>  	bool auto_bkops_enabled;
>  	struct ufs_vreg_info vreg_info;
>  	struct list_head clk_list_head;
> +	bool use_pm_opp;
>  
>  	/* Number of requests aborts */
>  	int req_abort_count;
> @@ -1037,6 +1042,7 @@ void ufshcd_remove(struct ufs_hba *);
>  int ufshcd_uic_hibern8_enter(struct ufs_hba *hba);
>  int ufshcd_uic_hibern8_exit(struct ufs_hba *hba);
>  void ufshcd_delay_us(unsigned long us, unsigned long tolerance);
> +int ufshcd_set_opp(struct dev_pm_set_opp_data *data);
>  void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk);
>  void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val);
>  void ufshcd_hba_stop(struct ufs_hba *hba);
> -- 
> 2.32.0
> 

-- 
மணிவண்ணன் சதாசிவம்
