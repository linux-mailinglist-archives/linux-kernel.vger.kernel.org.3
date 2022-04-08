Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E574F96EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiDHNjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiDHNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:39:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF1C23F388;
        Fri,  8 Apr 2022 06:37:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AD1491F471A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649425032;
        bh=yvdhlBbyjy2wKA9A8evE3TntodGtErEGfYOGyB6LfFE=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=iYZD7QeMXd9KAHItKnzoKM1eJ57GcN9prt4CsNMouqebhtmqQXbmNmF9jotgW5SaC
         C422MS/B1sySj4Ha1EtqUCC4xtxR3khH5RqFV+HcrvQwfwnIGVR23M7dm9oAUgqnk0
         23Qf48eqbTSFASP1MTbyMdkAa9FD23coSlnE4t2aEmjjgOdSgaEmu4jhhfBWEn7oRj
         bqO4A2weB9tPRCvgLgIqE8FE20+wbnVkDjADszYHz6fIz9ApK6ZbRDSIh07gfooOps
         6abAoPfBqVazbGedpjpdAGsGpGYkbmZNO0rYo6hXlsOT5gQhzJU8PzWa1widwy/SoF
         DP6d8kUTPUB/Q==
Message-ID: <dc18d877-effb-1286-341d-1792ea6fcc05@collabora.com>
Date:   Fri, 8 Apr 2022 15:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-14-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-14-rex-bc.chen@mediatek.com>
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

Il 08/04/22 06:59, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> In some MediaTek SoCs, like MT8183, CPU and CCI share the same power
> supplies. Cpufreq needs to check if CCI devfreq exists and wait until
> CCI devfreq ready before scaling frequency.
> 
> - Add is_ccifreq_ready() to link CCI device to CPI, and CPU will start
>    DVFS when CCI is ready.
> - Add platform data for MT8183.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 69 +++++++++++++++++++++++++++++-
>   1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index b08ab7c14818..cebe5af2ef5d 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -22,6 +22,7 @@ struct mtk_cpufreq_platform_data {
>   	int proc_max_volt;
>   	int sram_min_volt;
>   	int sram_max_volt;
> +	bool is_ccifreq_support;

bool ccifreq_supported; looks better.

>   };
>   
>   /*
> @@ -38,6 +39,7 @@ struct mtk_cpufreq_platform_data {
>   struct mtk_cpu_dvfs_info {
>   	struct cpumask cpus;
>   	struct device *cpu_dev;
> +	struct device *cci_dev;
>   	struct regulator *proc_reg;
>   	struct regulator *sram_reg;
>   	struct clk *cpu_clk;
> @@ -52,6 +54,7 @@ struct mtk_cpu_dvfs_info {
>   	int opp_cpu;
>   	unsigned long opp_freq;
>   	const struct mtk_cpufreq_platform_data *soc_data;
> +	bool is_ccifreq_bounded;

bool ccifreq_bound; looks better.

>   };
>   
>   static struct platform_device *cpufreq_pdev;
> @@ -171,6 +174,29 @@ static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
>   	return ret;
>   }
>   
> +static bool is_ccifreq_ready(struct mtk_cpu_dvfs_info *info)
> +{
> +	struct device_link *sup_link;
> +
> +	if (info->is_ccifreq_bounded)
> +		return true;
> +
> +	sup_link = device_link_add(info->cpu_dev, info->cci_dev,
> +				   DL_FLAG_AUTOREMOVE_CONSUMER);
> +	if (!sup_link) {
> +		dev_err(info->cpu_dev, "cpu%d: sup_link is NULL\n",
> +			info->opp_cpu);

Please, don't break this line: 84 columns are ok.

> +		return false;
> +	}
> +
> +	if (sup_link->supplier->links.status != DL_DEV_DRIVER_BOUND)
> +		return false;
> +
> +	info->is_ccifreq_bounded = true;
> +
> +	return true;
> +}
> +
>   static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>   				  unsigned int index)
>   {
> @@ -183,6 +209,9 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>   	long freq_hz, old_freq_hz;
>   	int vproc, old_vproc, inter_vproc, target_vproc, ret;
>   
> +	if (info->soc_data->is_ccifreq_support && !is_ccifreq_ready(info))
> +		return 0;

Honestly, I think that pretending that everything is alright and faking
set_target success is *not* a good idea...

You should return -EAGAIN here, not zero.

Regards,
Angelo

