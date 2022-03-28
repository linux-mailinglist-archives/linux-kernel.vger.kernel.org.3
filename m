Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73834E8C99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiC1D3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiC1D3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:29:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9050150468
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 20:27:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id jx9so12773887pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 20:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vixNEnSztPR8utodtJVMHUP5vGc5IFUieG6cY4fj2LI=;
        b=l4+cafefdkk1SKuYN5gW3dNkluFT+Izkym8RFbJXpzSWF/FcmSHtJSjlWnNGp1VRX5
         8fTTT5Fu1YOXwcesLTjW9inl9HSuBPHPUr87DMoTuU4pa2harly0/EinoSfTc6KHy1qr
         mnIsTVIZoxxKqrdUapVZccd6tJjNM6ORGClyKUHYKKGw3dCr0vKYoYOUdmx4pbtf8s+N
         pafNwAylYUOkzCVWpK/kxB+v5/ay3S2avsPq06LJXcL+xxsduO8fqbbVWXuBIBt7zNgY
         3JKdX+QNcKgzt9CM4E3ewuQzk8TX2ZrB8BXpQoje6OE8v+Ny5dt3sR6GOT63yPtvXazN
         Voog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vixNEnSztPR8utodtJVMHUP5vGc5IFUieG6cY4fj2LI=;
        b=Gsd5OCUjzu3hNOlJT7mYTTcZvDQ3dPoL+l4OSp1sVjuRfgUR6TkXUrC8YFonCeNRnT
         ioRg90jXRwJTJE6fuc3JFsc452IPptqP9yGSGJ1GyuyO5T+XQ7fCvP3HNoqHnzybkjH+
         OkqDJ3sEHYIigK3lfjjMYrIoPzfbZmlI/TolltCO5agpZj9VVub4MwJwvdINi4pPYVBL
         fR587m7sw4NS0+HgoAJR1B0LlvNNQml/oVCPyyuXfbVQ2f0J/Q3s1YNP6rst2ln6PWrA
         0CCzQ7Ig2Vr7GIQilbmCXsXYLRLbo003Yo6FtdYNzniSLUv6bNDfxxnx6xYCPzMDspoS
         0hoQ==
X-Gm-Message-State: AOAM532qxDVWKD90m6a0OUNdWaVaQ9AmOZG1uqdobdDMtlu1kvuoMuFA
        OT9fNARy3Qgp6FgQhlAlLs4NGw==
X-Google-Smtp-Source: ABdhPJwV9q7eU9xDrd6oK2UlSipEyCUfSuAQ0dQ8mYg421xzTw+iZO8tpC3efbnOWbahidP0avM5ag==
X-Received: by 2002:a17:90b:17ca:b0:1c7:3010:5901 with SMTP id me10-20020a17090b17ca00b001c730105901mr39307960pjb.22.1648438052109;
        Sun, 27 Mar 2022 20:27:32 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id u18-20020a056a00125200b004fb112ee9b7sm9331890pfi.75.2022.03.27.20.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 20:27:31 -0700 (PDT)
Date:   Mon, 28 Mar 2022 08:57:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: Re: [RESEND][PATCH 7/8] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Message-ID: <20220328032729.mutbjailxbmylffs@vireshk-i7>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <20220321095729.20655-8-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321095729.20655-8-lukasz.luba@arm.com>
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

On 21-03-22, 09:57, Lukasz Luba wrote:
> The Energy Model can now be artificial, which means the power values
> are mathematically generated to leverage EAS while not expected to be on
> an uniform scale with other devices providing power information. If this
> EM type is in use, the thermal governor IPA should not be allowed to
> operate, since the relation between cooling devices is not properly
> defined. Thus, it might be possible that big GPU has lower power values
> than a Little CPU. To mitigate a misbehaviour of the thermal control
> algorithm, simply do not register the cooling device as IPA's power
> actor.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 2 +-
>  drivers/thermal/devfreq_cooling.c | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 0bfb8eebd126..b8151d95a806 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -328,7 +328,7 @@ static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
>  	struct cpufreq_policy *policy;
>  	unsigned int nr_levels;
>  
> -	if (!em)
> +	if (!em || em_is_artificial(em))
>  		return false;
>  
>  	policy = cpufreq_cdev->policy;
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 4310cb342a9f..b04dcbbf721a 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -358,6 +358,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  	struct thermal_cooling_device *cdev;
>  	struct device *dev = df->dev.parent;
>  	struct devfreq_cooling_device *dfc;
> +	struct em_perf_domain *em;
>  	char *name;
>  	int err, num_opps;
>  
> @@ -367,8 +368,9 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  
>  	dfc->devfreq = df;
>  
> -	dfc->em_pd = em_pd_get(dev);
> -	if (dfc->em_pd) {
> +	em = em_pd_get(dev);
> +	if (em && !em_is_artificial(em)) {
> +		dfc->em_pd = em;
>  		devfreq_cooling_ops.get_requested_power =
>  			devfreq_cooling_get_requested_power;
>  		devfreq_cooling_ops.state2power = devfreq_cooling_state2power;
> @@ -379,7 +381,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  		num_opps = em_pd_nr_perf_states(dfc->em_pd);
>  	} else {
>  		/* Backward compatibility for drivers which do not use IPA */
> -		dev_dbg(dev, "missing EM for cooling device\n");
> +		dev_dbg(dev, "missing proper EM for cooling device\n");
>  
>  		num_opps = dev_pm_opp_get_opp_count(dev);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
