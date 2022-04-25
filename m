Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63FC50D8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbiDYFXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbiDYFXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:23:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B672F3B4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:20:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h12so20797211plf.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF5i8xk4P1LEOT63TuPgxEiYnBH2yC9okqwO1o9drxw=;
        b=iOF65cuSfSWhbypFbJBFBMJTl+UaUdhiF/7UOHTuj27ZNSz5/JxyOam6auVBEv4cwM
         bNZ2b3e3LEQcqJY1P5BraqF5BoLFOCGDxNqadUu3ikfZ6xwt7FIeKmjEm/VDqPTJiMOm
         LckAitENppa3vGr18CjGEslM09RD3rZxokOKrDszaN/Mp51F8cEmmOF0cQD+0/qzTTWY
         lOCySKh4JVBwV56+RKOu2qkZuUOd+hKnmUEatiHkpLU9uUgAiJ8G3NHXyIAYebk1N+5V
         TvJQ5rgItaUCxXT4RgXzBB0mhNbY3iDkO+x+hvS7M6E12XKIZxTFbi7V63odtA3jgOep
         fAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF5i8xk4P1LEOT63TuPgxEiYnBH2yC9okqwO1o9drxw=;
        b=sdLQKAO/cfyQ1p00hMka4B+P+Y+HhXrpZF2QEXxh1k234eoQFq21L/CQWHNMfMuHhl
         Ol0kTeYw1/9pJ94IoWlsRJ+LFE25DebbXKyQ3Z3kGRyRqP+xA9c1x+GxqAl2+dCy9v22
         +6hkG5zL1BYomGK4QUk+/mbEBjoQf17iB24G7LvkJhcDJGhQA6IyGARZ21/Uxt70lZWw
         P6nB8wDdafdu/hk+Mvn8je1ZzNRUI0A9yZEwt9YPPbzXKV0Hntdxcxp9EQ/e3GfSYx+E
         b0q60QtMeo4HLAnwChWRiv8K2YWHMaV/UhmgZCGbN5qrLaBkU+VKfKAi6FDfZVdzI0M8
         sKOQ==
X-Gm-Message-State: AOAM533mbGERrntZQcRE52DX7zzVuucBD884bp3RRSc0WNJupa3dkLPr
        Jv2MnjSwpcVErSCeqxDn9tQVPA==
X-Google-Smtp-Source: ABdhPJyx3JUtvWx3NQpb52P2n8q+ehDq/Rx6PQG85kdtJ6/357ZDL4xO9WmowD2hC1CP5Xtun1KeEQ==
X-Received: by 2002:a17:902:690b:b0:159:65c:9044 with SMTP id j11-20020a170902690b00b00159065c9044mr16525727plk.47.1650864029110;
        Sun, 24 Apr 2022 22:20:29 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id y16-20020a63b510000000b00398d8b19bbfsm8323113pge.23.2022.04.24.22.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:20:28 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:50:26 +0530
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
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH V4 05/14] cpufreq: mediatek: Add opp notification support
Message-ID: <20220425052026.k3xfmmil4ujqeynh@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-6-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422075239.16437-6-rex-bc.chen@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-22, 15:52, Rex-BC Chen wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> >From this opp notifier, cpufreq should listen to opp notification and do

Why the extra ">" here ?

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
>  drivers/cpufreq/mediatek-cpufreq.c | 92 +++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
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

I don't see any call to dev_pm_opp_adjust_voltage() for your platform, how is
this ever going to get called ?

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

IIUC, then you are trying to change the frequency if a currently used OPP is
getting removed ? In that case, this problem is generic enough not to be fixed
in a end driver. This should be fixed in core somehow.

-- 
viresh
