Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32265029A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353353AbiDOM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353264AbiDOM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:27:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA0D5D;
        Fri, 15 Apr 2022 05:24:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EDEE71F47DFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650025460;
        bh=ye+4fdRe53S0QH+OP5c/z3Iob+laLZgHFEm+D3U1sFk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FDNeHvdSzM94W/WjgTPbkKBW/YJS/dBhPOMdmnBFLDamE+6xg0daIXguGDn21Te/R
         2yEU/RXycV0XBOy35hiS5zGs6AbUrXLTsQ88PYoq808Q+4HHa/aPMc6o4cKb/QBZTS
         QFPiWY2IhpIUnxnAfcM1yvbXJVyiK6jJwlMNbfl4UyR/JkM+bYSZ+ymYGIPhka79db
         OO++dBH/m6/kLZIsMOsMPLKxPCukFSb9dIabSz6Q13fqd07zdPSnyUexwrc6iL6lCR
         JBlQ7C1L/zQbhBQMN0lHXwNxxQOTkCjOhvMcGUk+x1yf30ONwC4ht8NkWB3faOPjho
         EcpcEtiPvB6Eg==
Message-ID: <6f5e44e3-c690-5e39-bbb6-fb6bd0091099@collabora.com>
Date:   Fri, 15 Apr 2022 14:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 05/15] cpufreq: mediatek: Add opp notification support
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
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-6-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415055916.28350-6-rex-bc.chen@mediatek.com>
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
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
>  From this opp notifier, cpufreq should listen to opp notification and do
> proper actions when receiving events of disable and voltage adjustment.
> 
> One of the user for this opp notifier is MediaTek SVS.
> The MediaTek Smart Voltage Scaling (SVS) is a hardware which calculates
> suitable SVS bank voltages to OPP voltage table.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 93 +++++++++++++++++++++++++++---
>   1 file changed, 85 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index fa8b193bf27b..221f249f8d21 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -41,6 +41,11 @@ struct mtk_cpu_dvfs_info {
>   	int intermediate_voltage;
>   	bool need_voltage_tracking;
>   	int pre_vproc;
> +	/* Avoid race condition for regulators between notify and policy */
> +	struct mutex reg_lock;
> +	struct notifier_block opp_nb;
> +	int opp_cpu;

This should be unsigned int because:
1. A negative CPU number is impossible;
2. The only usage is as a parameter of cpufreq_cpu_get(unsigned int cpu).

Please change this to unsigned int, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

