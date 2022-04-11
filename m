Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EF4FB25A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbiDKD3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244539AbiDKD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:29:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796A2ED73
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:26:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h19so13466766pfv.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iePzAY4s9oNe9r1gZgKsDyZfLq/xq3Wu66mTe2SS1a8=;
        b=cz2urYf9dwqT9+3vV4unBRv44lrda5K2NgGGJn4QFKGmycwHI0lX7CAWFGlSTGL9rL
         OS5fKMUOfs5PnPiPLC/5Z/VnUHIz9oxxdWbBFX9GiK5KFhzeJ0KWDTpxXy3Roj7JDKdC
         JmqiKdOmnmX6dQc4/pkvI+tfj7bMmwGDFjIuPuLS72FmeMk5Yv+cn7rMXGnkVA5LjBAe
         x1o7U2a9JLUPC9brFZGJAnUW1o7504pH7MES2SsFkuDbViqIw9n+Pk7I91+fQEbqEYz+
         bhXhQctiOrrQxVvLNuDmKsQqZpDo99D6u7fxoKouWxtGTcmH5SRGgVtxouIKlOtsH1c1
         jTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iePzAY4s9oNe9r1gZgKsDyZfLq/xq3Wu66mTe2SS1a8=;
        b=VwvXVTWMqQI8J+4whGOeZnswLpndvgZyuyYqDcpQA/ApJ3bsHLn/HLxwu+qbtpqDm5
         WfAIqap2lrvONwmKfpsS+h1qTjzB6QzR2pH2Eo9dNxRkPMsOY2FhuA6fACe9/XO9/sd0
         pgWwmRERO6v/hsubjkZX/WEoBzrXE//lDh5q8dhiu1cpkXe/wNsHxZ3dBlcgy36mkXrN
         dwRxUmyGte70PzcwpwlBsrOexsog3i5RA2roGcaY9sjBNcwbrcZFvrPzF63hZC0drCWC
         nPjO/198LSGpk7TVRROlQ7rWKIVakmkSCq/MH0cRzivRGH9AscSDEKBZQ1v2mJeOOYdr
         12Mw==
X-Gm-Message-State: AOAM532ur2DiyibmsPHnN5LQ6F34TjmsO+JXjd4a7L1EV2RAGEyBGMEU
        LV/g8TyaDhiTaji2QmfV2shkSuw6T6hvTw==
X-Google-Smtp-Source: ABdhPJy7iOPr39nrGVdmH8I35PUMwel6TcCkay2LmFP7c9ln6hx9kug3RyhDMEv5UH3EOIemmlc0zA==
X-Received: by 2002:a63:2a92:0:b0:398:a420:4faa with SMTP id q140-20020a632a92000000b00398a4204faamr24765350pgq.222.1649647617063;
        Sun, 10 Apr 2022 20:26:57 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a3fc500b001cb3fec230bsm8849985pjm.14.2022.04.10.20.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:26:56 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:56:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH V2 06/15] cpufreq: mediatek: Record previous target vproc
 value
Message-ID: <20220411032654.5tqqivmstqkojfj5@vireshk-i7>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-7-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408045908.21671-7-rex-bc.chen@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-22, 12:58, Rex-BC Chen wrote:
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
>  drivers/cpufreq/mediatek-cpufreq.c | 31 +++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index dc4a87e68940..472f4de29e5f 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -40,6 +40,7 @@ struct mtk_cpu_dvfs_info {
>  	struct list_head list_head;
>  	int intermediate_voltage;
>  	bool need_voltage_tracking;
> +	int old_vproc;

I like prev_vproc better somehow, but it is up to you to name it :)

>  };
>  
>  static LIST_HEAD(dvfs_info_list);
> @@ -190,11 +191,17 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  
>  static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
>  {
> +	int ret;
> +
>  	if (info->need_voltage_tracking)
> -		return mtk_cpufreq_voltage_tracking(info, vproc);
> +		ret = mtk_cpufreq_voltage_tracking(info, vproc);
>  	else
> -		return regulator_set_voltage(info->proc_reg, vproc,
> -					     vproc + VOLT_TOL);
> +		ret = regulator_set_voltage(info->proc_reg, vproc,
> +					    MAX_VOLT_LIMIT);
> +	if (!ret)
> +		info->old_vproc = vproc;
> +
> +	return ret;
>  }
>  
>  static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> @@ -211,15 +218,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  	inter_vproc = info->intermediate_voltage;
>  
> -	old_freq_hz = clk_get_rate(cpu_clk);
> -	old_vproc = regulator_get_voltage(info->proc_reg);
> -	if (old_vproc < 0) {
> -		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
> -		return old_vproc;
> -	}
> -

Why did you move it down from here? I think it was fine to error out
early if voltage isn't available.

>  	freq_hz = freq_table[index].frequency * 1000;
> -
>  	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
>  	if (IS_ERR(opp)) {
>  		pr_err("cpu%d: failed to find OPP for %ld\n",
> @@ -229,6 +228,16 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  	vproc = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
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
> +
>  	/*
>  	 * If the new voltage or the intermediate voltage is higher than the
>  	 * current voltage, scale up voltage first.
> -- 
> 2.18.0

-- 
viresh
