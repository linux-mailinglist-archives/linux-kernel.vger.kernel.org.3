Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98274F9702
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbiDHNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiDHNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:39:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB431EFE34;
        Fri,  8 Apr 2022 06:36:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A1B391F471A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649425016;
        bh=VvRgQU54sdZ6ehxT8S+IpL97VlFITMD9eiM6MHExd5I=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=JLJtOd+gq+xF78yvrkucBm4n9+EqJG4+UWfNQ+13TWtxOSWCSkZG4bBCca7oAtJUr
         WsbiIZo65B0lOnB3hrUpiHmTjnq0u4BTZ8JyA8QTN2kF2LChNENiKPz0I8Cefb6ri4
         z0BfERmefGj3CafuhEzULsoKgtIQAFjiwTabuRf2rqkg7jV09dS4BzFvg5x/haLM79
         Szsjb5syEVisdwhlbQ2Me6J/zgrpt9xuYaiGLdnIuFoHhQpD+w1VUhjg2l4psazjrC
         EErT4sfDbx3GY0CJp1YtmXkKa/9So+HKzyXuCVKpSDOI97chqiSJ0FLGRucT5K7O0i
         aY/jszgQIRABA==
Message-ID: <d9f514b6-1116-30d3-274f-11e04a2dc8e9@collabora.com>
Date:   Fri, 8 Apr 2022 15:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 07/15] cpufreq: mediatek: Add opp notification for SVS
 support
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-8-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-8-rex-bc.chen@mediatek.com>
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
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> The Smart Voltage Scaling (SVS) is a hardware which calculates suitable
> SVS bank voltages to OPP voltage table.
> 
> When the SVS is enabled, cpufreq should listen to opp notification and do
> proper actions when receiving events of disable and voltage adjustment.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 90 +++++++++++++++++++++++++++---
>   1 file changed, 82 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 472f4de29e5f..1369da62780a 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c

..snip..

> +
>   static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>   {
>   	struct device *cpu_dev;
> @@ -392,6 +455,17 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>   	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
>   	dev_pm_opp_put(opp);
>   
> +	info->opp_cpu = cpu;
> +	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
> +	ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);

You are registering this notifier, but never unregistering it.
Please unregister it in error conditions and also upon runtime removal of the
mediatek-cpufreq module.

-> dev_pm_opp_unregister_notifier()

Regards,
Angelo

> +	if (ret) {
> +		dev_warn(cpu_dev, "cpu%d: failed to register opp notifier\n", cpu);
> +		goto out_disable_inter_clock;
> +	}
> +
> +	mutex_init(&info->reg_lock);
> +	info->opp_freq = clk_get_rate(info->cpu_clk);
> +
>   	/*
>   	 * If SRAM regulator is present, software "voltage tracking" is needed
>   	 * for this CPU power domain.


