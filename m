Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC584F96F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiDHNjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiDHNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:39:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CAA1EA2A1;
        Fri,  8 Apr 2022 06:36:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B97F11F47188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649425011;
        bh=PIJNcGwrF6HuxDb11oOTw9f1ZSeNuaYGIFc0+4/olJQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=gVW76N9wfn14hZEjm3jOIj1kFpmgYzU02KWNXq/cGX/4ARvUX5O17sfSrAyCMzHCx
         ccakmCBSDKbEiQtdVQndZWtIdKrH8ovob5nHxt3fVoE1buAZx2IzqOwhSxTxSQ7CAU
         RVEy6t7KTrZgPo7yYfodJwsYpytrI2qRon3+layUTmkjWOQ5a5a5hXj0ZRoU/GvZQ6
         evT88/rT6M/zKxvXNhinA/CbBTgz84dOK2TZLxQm5WrQUHREHymxFOYqaqFBdUWatg
         B2l2dFgFovq+7x5pOAZCtBRgh5MvYSO/0QtmZadFZkM3Ckv1BqMIqBX8ViaplUf1ye
         p44HQ9m8VjctQ==
Message-ID: <4cc24333-3985-5efe-cc5f-c7b8492f6c1e@collabora.com>
Date:   Fri, 8 Apr 2022 15:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 06/15] cpufreq: mediatek: Record previous target vproc
 value
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-7-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-7-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 06:58, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> We found the buck voltage may not be exactly the same with what we set
> because CPU may share the same buck with other module.
> Therefore, we need to record the previous desired value instead of reading
> it from regulators.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 31 +++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index dc4a87e68940..472f4de29e5f 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -40,6 +40,7 @@ struct mtk_cpu_dvfs_info {
>   	struct list_head list_head;
>   	int intermediate_voltage;
>   	bool need_voltage_tracking;
> +	int old_vproc;
>   };
>   
>   static LIST_HEAD(dvfs_info_list);
> @@ -190,11 +191,17 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
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
> +		info->old_vproc = vproc;
> +
> +	return ret;
>   }
>   
>   static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> @@ -211,15 +218,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>   
>   	inter_vproc = info->intermediate_voltage;
>   
> -	old_freq_hz = clk_get_rate(cpu_clk);
> -	old_vproc = regulator_get_voltage(info->proc_reg);
> -	if (old_vproc < 0) {
> -		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
> -		return old_vproc;
> -	}
> -
>   	freq_hz = freq_table[index].frequency * 1000;
> -
>   	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
>   	if (IS_ERR(opp)) {
>   		pr_err("cpu%d: failed to find OPP for %ld\n",
> @@ -229,6 +228,16 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>   	vproc = dev_pm_opp_get_voltage(opp);
>   	dev_pm_opp_put(opp);
>   
> +	old_freq_hz = clk_get_rate(cpu_clk);
> +	old_vproc = info->old_vproc;
> +	if (old_vproc == 0)
> +		old_vproc = regulator_get_voltage(info->proc_reg);
> +	if (old_vproc < 0) {
> +		dev_err(cpu_dev, "%s: invalid Vproc value: %d\n",
> +			__func__, old_vproc);
> +		return old_vproc;
> +	}

 From my understandment, if this fails once, it fails forever!

info->old_vproc is set only if info->need_voltage_tracking is true, and only
in mtk_cpufreq_set_voltage(): this function is called only after the checks
that you've introduced there, and that's on previously stored values.
While this was fine in the previous version, because it was always calling
regulator_get_voltage(), here it's not.

I think that a good option here is to:

old_vproc = info->old_vproc;
if (old_vproc <= 0)
	old_vproc = regulator_get_voltage(info->proc_reg);
if (old_vproc < 0) {
	dev_err and return
}

...or, if this is not applicable, we should still find another way to not
let this driver to simply fail forever in case anything goes wrong.

Regards,
Angelo
