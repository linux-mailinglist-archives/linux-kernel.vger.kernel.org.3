Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C4351D007
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 06:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388924AbiEFETP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388929AbiEFETE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:19:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041832AE0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 21:15:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so5724479pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 21:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/JHLfDAQrV9xOGhzra2h+ainY41c+tt3o0Xd3OLmhw=;
        b=c4fzFuDhsQhD0LdG4dZbWh+NUKlqtf2jrqEoekqkr5CnGWaYf2BpWC31hg9oqK2c0e
         q91xDSAb83uHcs0Uh16R9vRuIqzdQt4zpJfFVJmoSqtqDiWMEbQnlvqJ1uSo5+KCgAoK
         oa5LqI2nct7M+reVdueNvbT6EZB5R325owozcH/prBLXXKAMsMOY0B471IzILPeC0NAX
         NKPzIEyGEuoJouZpY9SbzoKkrYoF27h2KYiTRBm8+QyqonOeiAFu08ALGxUSLmu5YDQ7
         d4DoklmXhMpQMi91NcicCgUHzoG2P0mkTZ6AGCnOsiojCie0UhtjinS0TswK93ZTY1ds
         fHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/JHLfDAQrV9xOGhzra2h+ainY41c+tt3o0Xd3OLmhw=;
        b=62Ib72RkPCmDq1/9g6+1UaheZYgtsFfXNmjIho+M1NBpvFYFDrNudZyn2HXgty5xuh
         dKa4owEPT96AhYRVkO8/A1SS2V/8xE11zA4hqVMr3vKy48b/hmBuNAfUTJ9vF8PygvE3
         Ee5ouMp9qngW/3kJ7n4j40gKg1vPGl4yk34xJU1XdjOssrKCdva8t7caYR6zQ5z0+ppH
         DpgRqDG+fsZQcJPZGMt4GX6DTymQwDOCqNtDPaQEWo+sng/Eb4aOoLe74Lb3JNPsDap6
         tYstmW5vIP0tlLJB2bYpu/31HYuwL9PR7kLwXDWtlfHjfYsYcAWXkiDqpIIyu2CZT1jm
         6U8A==
X-Gm-Message-State: AOAM530+IR9PIU8B9AlvgCSeOuU8vUpZciCeirhdh8CaeNmGYoQ9K3O0
        PdBabHjG+7U/I2+qz4pZYIlx+Q==
X-Google-Smtp-Source: ABdhPJwk5nWnpNJarUlQBxTVR7h7SYQUnYhBQ5GvBhQ/vYBElXoiYPF/PoTKw8y1FcD9glwduGsdgA==
X-Received: by 2002:a17:90b:d91:b0:1da:35d7:a0c with SMTP id bg17-20020a17090b0d9100b001da35d70a0cmr1960385pjb.92.1651810521504;
        Thu, 05 May 2022 21:15:21 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b0015e8d4eb2b5sm447141plq.255.2022.05.05.21.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 21:15:20 -0700 (PDT)
Date:   Fri, 6 May 2022 09:45:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH v6 05/10] cpufreq: mediatek: Add opp notification support
Message-ID: <20220506041518.5j5rfakayur64y7e@vireshk-i7>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220505115226.20130-6-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505115226.20130-6-rex-bc.chen@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-22, 19:52, Rex-BC Chen wrote:
> >From this opp notifier, cpufreq should listen to opp notification and do
> proper actions when receiving events of disable and voltage adjustment.
> 
> One of the user for this opp notifier is MediaTek SVS.
> The MediaTek Smart Voltage Scaling (SVS) is a hardware which calculates
> suitable SVS bank voltages to OPP voltage table.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 91 +++++++++++++++++++++++++++---
>  1 file changed, 83 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index fe205eca657d..06d80ee06bbf 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -46,6 +46,11 @@ struct mtk_cpu_dvfs_info {
>  	int intermediate_voltage;
>  	bool need_voltage_tracking;
>  	int pre_vproc;
> +	/* Avoid race condition for regulators between notify and policy */
> +	struct mutex reg_lock;
> +	struct notifier_block opp_nb;
> +	unsigned int opp_cpu;
> +	unsigned long opp_freq;

The name opp_freq doesn't fit well, I renamed it to current_freq.

>  	const struct mtk_cpufreq_platform_data *soc_data;
>  	int vtrack_max;
>  };
> @@ -182,6 +187,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  	pre_freq_hz = clk_get_rate(cpu_clk);
>  
> +	mutex_lock(&info->reg_lock);
> +
>  	if (unlikely(info->pre_vproc <= 0))
>  		pre_vproc = regulator_get_voltage(info->proc_reg);
>  	else
> @@ -214,7 +221,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  			dev_err(cpu_dev,
>  				"cpu%d: failed to scale up voltage!\n", policy->cpu);
>  			mtk_cpufreq_set_voltage(info, pre_vproc);
> -			return ret;
> +			goto out;
>  		}
>  	}
>  
> @@ -224,8 +231,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  		dev_err(cpu_dev,
>  			"cpu%d: failed to re-parent cpu clock!\n", policy->cpu);
>  		mtk_cpufreq_set_voltage(info, pre_vproc);
> -		WARN_ON(1);
> -		return ret;
> +		goto out;
>  	}
>  
>  	/* Set the original PLL to target rate. */
> @@ -235,7 +241,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  			"cpu%d: failed to scale cpu clock rate!\n", policy->cpu);
>  		clk_set_parent(cpu_clk, armpll);
>  		mtk_cpufreq_set_voltage(info, pre_vproc);
> -		return ret;
> +		goto out;
>  	}
>  
>  	/* Set parent of CPU clock back to the original PLL. */
> @@ -244,8 +250,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  		dev_err(cpu_dev,
>  			"cpu%d: failed to re-parent cpu clock!\n", policy->cpu);
>  		mtk_cpufreq_set_voltage(info, inter_vproc);
> -		WARN_ON(1);
> -		return ret;
> +		goto out;
>  	}
>  
>  	/*
> @@ -260,15 +265,72 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  			clk_set_parent(cpu_clk, info->inter_clk);
>  			clk_set_rate(armpll, pre_freq_hz);
>  			clk_set_parent(cpu_clk, armpll);
> -			return ret;
> +			goto out;
>  		}
>  	}
>  
> -	return 0;
> +	info->opp_freq = freq_hz;
> +
> +out:
> +	mutex_unlock(&info->reg_lock);
> +
> +	return ret;
>  }
>  
>  #define DYNAMIC_POWER "dynamic-power-coefficient"
>  
> +static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
> +				    unsigned long event, void *data)
> +{
> +	struct dev_pm_opp *opp = data;
> +	struct dev_pm_opp *new_opp;
> +	struct mtk_cpu_dvfs_info *info;
> +	unsigned long freq, volt;
> +	struct cpufreq_policy *policy;
> +	int ret = 0;
> +
> +	info = container_of(nb, struct mtk_cpu_dvfs_info, opp_nb);
> +
> +	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
> +		freq = dev_pm_opp_get_freq(opp);
> +
> +		mutex_lock(&info->reg_lock);
> +		if (info->opp_freq == freq) {
> +			volt = dev_pm_opp_get_voltage(opp);
> +			ret = mtk_cpufreq_set_voltage(info, volt);
> +			if (ret)
> +				dev_err(info->cpu_dev,
> +					"failed to scale voltage: %d\n", ret);
> +		}
> +		mutex_unlock(&info->reg_lock);
> +	} else if (event == OPP_EVENT_DISABLE) {
> +		freq = dev_pm_opp_get_freq(opp);
> +
> +		/* case of current opp item is disabled */
> +		if (info->opp_freq == freq) {
> +			freq = 1;
> +			new_opp = dev_pm_opp_find_freq_ceil(info->cpu_dev,
> +							    &freq);
> +			if (IS_ERR(new_opp)) {
> +				dev_err(info->cpu_dev,
> +					"all opp items are disabled\n");
> +				ret = PTR_ERR(new_opp);
> +				return notifier_from_errno(ret);
> +			}
> +
> +			dev_pm_opp_put(new_opp);
> +			policy = cpufreq_cpu_get(info->opp_cpu);
> +			if (policy) {
> +				cpufreq_driver_target(policy, freq / 1000,
> +						      CPUFREQ_RELATION_L);
> +				cpufreq_cpu_put(policy);
> +			}
> +		}
> +	}
> +
> +	return notifier_from_errno(ret);
> +}
> +
>  static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  {
>  	struct device *cpu_dev;
> @@ -357,6 +419,18 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
>  
> +	mutex_init(&info->reg_lock);
> +
> +	info->opp_cpu = cpu;
> +	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
> +	ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);
> +	if (ret) {
> +		dev_err(cpu_dev, "cpu%d: failed to register opp notifier\n", cpu);
> +		goto out_disable_inter_clock;
> +	}
> +
> +	info->opp_freq = clk_get_rate(info->cpu_clk);

This is a resource as well, which should have been initialized before
registering notifier.

Applied with above changes. Thanks.

-- 
viresh
