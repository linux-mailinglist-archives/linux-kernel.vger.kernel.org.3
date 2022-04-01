Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1834EFA88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347805AbiDATqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiDATqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:46:34 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295201C5909
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:44:43 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id o22-20020a4ad156000000b00324910b18d2so693485oor.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eoDyR5wLKAdUvoHHm1+xh38XadYbaqhL+MtwYEWyQx4=;
        b=VsEowxTR0k/JyCDGGuUfcIkJx6D9iJg0x4e775Hs5IF5VzVDHWy7FTWxg+JaXeooYe
         emKqj242txx5xJs2nNhg0cZ1OOWohlr3NZfRYD69Go9l/uRSEF+kTPlL7u5/rw4MV57D
         okE4+d+KK5c10M5p8KZrO9JnKaR8ZmpUcRv2MaCwl7TSXyCf7oL0evsV7LsN9sFy98Re
         YTOGmJwzQIry8pY0PZWZcAKYdaSr8BqgbSEtq2WRIvFcHE8tRfRuJ9kRL0SOdicBBss4
         5OOgf1fd31O5X5eh9dUyNtUGWPh5BBuHOdXLmo8mx+P6zbX6U24Sb8PSSmT6nQEiZbiv
         9BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eoDyR5wLKAdUvoHHm1+xh38XadYbaqhL+MtwYEWyQx4=;
        b=pufFSvZ7Q3duRzYKsvE4Pq+/2viX5LYdWjx496pombfOd9nmfNSODZ8dCrwX8efBVZ
         lpJt+K9aCW+rynIt5Um1eNzvh4cUkVEFdlo3Ox4UxE1MWX6aQi78Yee9J8XVkGwG+0nx
         Rco14DJgCADVMwloPGyt+7MXGFyd6s1W2U7Os7wZSjN0/XTEmAULY9ryKQfWbgm/9oz5
         LNcJbDkJIThgB1zjhdZ3zjCKG6g1L3DbhmH5QP+6jwNIAaphz0tcTG4DjdAgVORfQzY0
         gZCyS0jeHdClx1HQHGfCOvUorX+gh3Bjp+QsXDP05fyR9jn0CpzVQ4tCy3hMtvulKnNS
         k2RQ==
X-Gm-Message-State: AOAM533p762u7NX/bVumv28Cd0IaHLye6FnMqV/BUSHUu3idPN76AKEf
        ZOEiWVlOMfAu3fnnbgnmPgWDfw==
X-Google-Smtp-Source: ABdhPJzHVq2wM1+PpnlqzdvZWU1jvshpm1Veo28hKMWOVFTl5EbwrKGHejrrf26XPj5IVBEQR+BYfw==
X-Received: by 2002:a4a:8904:0:b0:323:7039:6c68 with SMTP id f4-20020a4a8904000000b0032370396c68mr7182992ooi.8.1648842282375;
        Fri, 01 Apr 2022 12:44:42 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id h8-20020a056830400800b005cdceb42261sm1533435ots.66.2022.04.01.12.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:44:41 -0700 (PDT)
Date:   Fri, 1 Apr 2022 12:47:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] ufs: set power domain performance state when
 scaling gears
Message-ID: <YkdWvVVp4RloGjkC@ripper>
References: <20220401145820.1003826-1-krzysztof.kozlowski@linaro.org>
 <20220401145820.1003826-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401145820.1003826-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Apr 07:58 PDT 2022, Krzysztof Kozlowski wrote:

> Scaling gears requires not only scaling clocks, but also voltage levels,
> e.g. via performance states.
> 
> USe the provided OPP table, to set proper OPP frequency which through
> required-opps will trigger performance state change.
> 

This looks quite nice! Just two questions about the path looking forward.

If we where to extend the opp core to allow specifying the clock rate
for some N first clocks (similar to how e.g. regulators are handled) it
seems possible to extend this to replace the freq-table property as
well. Would you agree?


The other missing required feature (in this area) from the upstream UFS
driver is the ability of voting for interconnect bandwidth. Based on
your path it would be trivial to specify different values for the votes
for each speed, but looking at downstream [1] (each row represents the
vote for the two paths in KB/s) indicates a more complex relationship
between gear and voted bandwidth.

This was the reason I suggested that perhaps we need to key the
opp-table based on the gear? But I don't think there would be any issue
detecting this in runtime...

[1] https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio.dtsi#L1982

Regards,
Bjorn

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/scsi/ufs/ufshcd-pltfrm.c |  6 +++++
>  drivers/scsi/ufs/ufshcd.c        | 42 +++++++++++++++++++++++++-------
>  drivers/scsi/ufs/ufshcd.h        |  3 +++
>  3 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index cca4b2181a81..c8f19b54be92 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -360,6 +360,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>  		goto dealloc_host;
>  	}
>  
> +	if (devm_pm_opp_of_add_table(dev))
> +		dev_dbg(dev, "no OPP table (%d), no performance state control\n",
> +			err);
> +	else
> +		hba->use_pm_opp = true;
> +
>  	ufshcd_init_lanes_per_dir(hba);
>  
>  	err = ufshcd_init(hba, mmio_base, irq);
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 3f9caafa91bf..84912db86da8 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1164,11 +1164,16 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
>  static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
>  {
>  	int ret = 0;
> +	struct ufs_clk_info *clki;
> +	unsigned long pm_opp_target_rate;
>  	struct ufs_pa_layer_attr new_pwr_info;
>  
> +	clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
> +
>  	if (scale_up) {
>  		memcpy(&new_pwr_info, &hba->clk_scaling.saved_pwr_info.info,
>  		       sizeof(struct ufs_pa_layer_attr));
> +		pm_opp_target_rate = clki->max_freq;
>  	} else {
>  		memcpy(&new_pwr_info, &hba->pwr_info,
>  		       sizeof(struct ufs_pa_layer_attr));
> @@ -1184,6 +1189,13 @@ static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
>  			new_pwr_info.gear_tx = hba->clk_scaling.min_gear;
>  			new_pwr_info.gear_rx = hba->clk_scaling.min_gear;
>  		}
> +		pm_opp_target_rate = clki->min_freq;
> +	}
> +
> +	if (hba->use_pm_opp && scale_up) {
> +		ret = dev_pm_opp_set_rate(hba->dev, pm_opp_target_rate);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	/* check if the power mode needs to be changed or not? */
> @@ -1194,6 +1206,11 @@ static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
>  			hba->pwr_info.gear_tx, hba->pwr_info.gear_rx,
>  			new_pwr_info.gear_tx, new_pwr_info.gear_rx);
>  
> +	if (ret && hba->use_pm_opp && scale_up)
> +		dev_pm_opp_set_rate(hba->dev, hba->devfreq->previous_freq);
> +	else if (hba->use_pm_opp && !scale_up)
> +		ret = dev_pm_opp_set_rate(hba->dev, pm_opp_target_rate);
> +
>  	return ret;
>  }
>  
> @@ -1435,9 +1452,11 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
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
> @@ -1449,8 +1468,10 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
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
> @@ -1462,7 +1483,6 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
>  static void ufshcd_devfreq_remove(struct ufs_hba *hba)
>  {
>  	struct list_head *clk_list = &hba->clk_list_head;
> -	struct ufs_clk_info *clki;
>  
>  	if (!hba->devfreq)
>  		return;
> @@ -1470,9 +1490,13 @@ static void ufshcd_devfreq_remove(struct ufs_hba *hba)
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
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 88c20f3608c2..3bd02095897f 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -776,6 +776,8 @@ struct ufs_hba_monitor {
>   * @auto_bkops_enabled: to track whether bkops is enabled in device
>   * @vreg_info: UFS device voltage regulator information
>   * @clk_list_head: UFS host controller clocks list node head
> + * @use_pm_opp: whether OPP table is provided and scaling gears should trigger
> + *              setting OPP
>   * @pwr_info: holds current power mode
>   * @max_pwr_info: keeps the device max valid pwm
>   * @clk_scaling_lock: used to serialize device commands and clock scaling
> @@ -894,6 +896,7 @@ struct ufs_hba {
>  	bool auto_bkops_enabled;
>  	struct ufs_vreg_info vreg_info;
>  	struct list_head clk_list_head;
> +	bool use_pm_opp;
>  
>  	/* Number of requests aborts */
>  	int req_abort_count;
> -- 
> 2.32.0
> 
