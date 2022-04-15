Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE05029AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353432AbiDOM2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353267AbiDOM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:27:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD02BCA;
        Fri, 15 Apr 2022 05:24:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C73A11F47DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650025462;
        bh=CgoMr81ngES5EOve3elaYWzsRcAHP5/TfWon8crvZeI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MMkbJocU1xYEPcKtyRt9KlIWzn690WXHgcaVc/H0u5GyfrHo6wLilW8U1eS6y7+MV
         IoxmFFurFRiy1cyLOugkg3lvSNul9MZbfcZELqlpw9x20Hk4nORqD2tXBbdUUg7L67
         2pP9E7k2HTH4joiLrnggpWMTNgxrqaZcGUjaPKex0LzNBntNgihy/ne0ZuxJAj/JKY
         BXJ1OO3aoS1pYyUpg5NVQdNiIjyNajfu3DggcUIjWC/3ZZJmNmlqHyXX58lY6/K9hr
         UHI+eUi1KBNm2A20xcaFPrHbSP+J8ZXIhSoKNL4ZTzNy7HluqdGRAbelvpgV9fRk7o
         /4YbAZS3CXtNw==
Message-ID: <9751622e-f969-c025-2a39-efcc9a612392@collabora.com>
Date:   Fri, 15 Apr 2022 14:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 04/15] cpufreq: mediatek: Record previous target vproc
 value
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-5-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415055916.28350-5-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/04/22 07:59, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> We found the buck voltage may not be exactly the same with what we set
> because CPU may share the same buck with other module.
> Therefore, we need to record the previous desired value instead of reading
> it from regulators.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index ff27f77e8ee6..fa8b193bf27b 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -40,6 +40,7 @@ struct mtk_cpu_dvfs_info {
>   	struct list_head list_head;
>   	int intermediate_voltage;
>   	bool need_voltage_tracking;
> +	int pre_vproc;
>   };
>   
>   static LIST_HEAD(dvfs_info_list);
> @@ -191,11 +192,17 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>   
>   static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
>   {
> +	int ret;
> +
>   	if (info->need_voltage_tracking)
> -		return mtk_cpufreq_voltage_tracking(info, vproc);
> +		ret = mtk_cpufreq_voltage_tracking(info, vproc);
>   	else
> -		return regulator_set_voltage(info->proc_reg, vproc,
> -					     vproc + VOLT_TOL);
> +		ret = regulator_set_voltage(info->proc_reg, vproc,
> +					    MAX_VOLT_LIMIT);
> +	if (!ret)
> +		info->pre_vproc = vproc;
> +
> +	return ret;
>   }
>   
>   static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> @@ -213,7 +220,9 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>   	inter_vproc = info->intermediate_voltage;
>   
>   	pre_freq_hz = clk_get_rate(cpu_clk);
> -	pre_vproc = regulator_get_voltage(info->proc_reg);
> +	pre_vproc = info->pre_vproc;
> +	if (pre_vproc <= 0)
> +		pre_vproc = regulator_get_voltage(info->proc_reg);

I would do it like that, instead:

	if (unlikely(info->pre_vproc <= 0))
		pre_vproc = regulator_get_voltage(info->proc_reg);
	else
		pre_vproc = info->pre_vproc;

....as even though it is indeed possible that info->pre_vproc is <= 0, it is
very unlikely to happen ;-)
This also solves a 'pre_vproc' double assignment issue, by the way.

Cheers,
Angelo



