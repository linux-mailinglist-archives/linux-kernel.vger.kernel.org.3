Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA24F1AE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379309AbiDDVTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378919AbiDDQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:04:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D172427DD;
        Mon,  4 Apr 2022 09:02:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47E7DD6E;
        Mon,  4 Apr 2022 09:02:57 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F943F73B;
        Mon,  4 Apr 2022 09:02:56 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:02:55 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: Re: [RESEND][PATCH 7/8] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Message-ID: <YksWrxmb4FYWZqX5@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <20220321095729.20655-8-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321095729.20655-8-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 Mar 2022 at 09:57:28 (+0000), Lukasz Luba wrote:
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
>  

If needed,

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

> -- 
> 2.17.1
> 
