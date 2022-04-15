Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF850298B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353314AbiDOM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353252AbiDOM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:27:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B56AC12EA;
        Fri, 15 Apr 2022 05:24:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 732181F47DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650025451;
        bh=Bq4NmoaVsB4YvDD3gB8YAWRsceselSLBmwF7QkyDIDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SevoovC1ZA4EiKW+q4c0Baopfh0Bd5gO7cZnenEzwZrAkQ3wpY9NQn/Ivt3oRc1b6
         A25/9rHtN/PEfU5ml8njuexOt0L7xQRtVCr2hTDpxVqWF2fNXqS/2+Ku+b78+0sBa8
         lKlNN1oACrPoze1YfbLkurm3/Hl457jxNwjshC79EkpRMb2pdVCKcsRM+jlUwfgNg6
         5jOimFoj6CN1F4gXymrw/RlsMIUxBxV0CZoIEeUgCZ07pw85cp+EVOaZ+UunYyvDDW
         QjYP4BSIbDUq4PmSOb//j6CqMKZxbo8HPW1F5LFD0JiVbxNjFhMaUcZ56vRrFd6Nuf
         rpsVUN619uYtA==
Message-ID: <9fccbb92-1832-bf5d-7804-80dd481663fc@collabora.com>
Date:   Fri, 15 Apr 2022 14:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 11/15] cpufreq: mediatek: Link CCI device to CPU
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-12-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415055916.28350-12-rex-bc.chen@mediatek.com>
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
> In some MediaTek SoCs, like MT8183, CPU and CCI share the same power
> supplies. Cpufreq needs to check if CCI devfreq exists and wait until
> CCI devfreq ready before scaling frequency.
> 
> Before CCI devfreq is ready, we record the voltage when booting to
> kernel and use the max(cpu target voltage, booting voltage) to
> prevent cpufreq adjust to the lower voltage which will cause the CCI
> crash because of high frequency and low voltage.
> 
> - Add is_ccifreq_ready() to link CCI device to CPI, and CPU will start
>    DVFS when CCI is ready.
> - Add platform data for MT8183.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

I am enthusiast to see that the solution that I've proposed was welcome!

I only have one nit on this patch, check below:

> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 80 +++++++++++++++++++++++++++++-
>   1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index d4c00237e862..dd3f739fede1 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c

..snip..

> @@ -225,6 +251,14 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>   	vproc = dev_pm_opp_get_voltage(opp);
>   	dev_pm_opp_put(opp);
>   
> +	/*
> +	 * If MediaTek cci is supported but is not ready, we will use the value
> +	 * of max(target cpu voltage, booting voltage) to prevent high freqeuncy
> +	 * low voltage crash.
> +	 */
> +	if (info->soc_data->ccifreq_supported && !is_ccifreq_ready(info))
> +		vproc = max(vproc, info->vproc_on_boot);
> +
>   	/*
>   	 * If the new voltage or the intermediate voltage is higher than the
>   	 * current voltage, scale up voltage first.

..snip..

> @@ -423,6 +484,13 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>   	if (ret)
>   		goto out_disable_mux_clock;
>   
> +	info->vproc_on_boot = regulator_get_voltage(info->proc_reg);

This result is used only if we use ccifreq, so this should be enclosed in an if
condition: this will spare us some (yes, small) time on devices that don't use it.

	if (info->soc_data->ccifreq_supported) {
		info->vproc_on_boot = regulator_get_voltage(info->proc_reg);
		if (info->vproc_on_boot < 0) {
			dev_err(....
			goto ..
		}
	}

P.S.: While at it, since the maximum width is 100 columns, the dev_err() call fits,
so don't break that line!

After the requested change:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
