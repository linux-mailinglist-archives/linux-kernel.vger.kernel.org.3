Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146204AF378
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiBIN74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiBIN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:59:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E524C0613C9;
        Wed,  9 Feb 2022 05:59:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA46C1FB;
        Wed,  9 Feb 2022 05:59:57 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4B4B3F70D;
        Wed,  9 Feb 2022 05:59:55 -0800 (PST)
Date:   Wed, 9 Feb 2022 13:59:41 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Chitti Babu Theegala <quic_ctheegal@quicinc.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, joel@joelfernandes.org,
        linux-arm-msm@vger.kernel.org, quic_lingutla@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: New sysctl to tweak boost for uclamp tasks
Message-ID: <YgPIzXWpWeEpUJbi@FVFF7649Q05P>
References: <20220209134319.1183-1-quic_ctheegal@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209134319.1183-1-quic_ctheegal@quicinc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 634d571e39d77..55019eb9c83c5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1269,6 +1269,14 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
>   */
>  unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
>  
> +/* UCLAMP_MIN knob clamps the util_value within uclamp_min & max. By default,
> + * these uclamped tasks are also boosted to bigger cores which can impact power.
> + *
> + * This knob provides an option to turn-off 'boosting to gold cores' and
> + * just restrict to 'clamping util value' job.
> + */
> +unsigned int sysctl_sched_uclamp_util_min_to_boost = 1;
> +
>  /* All clamps are required to be less or equal than these values */
>  static struct uclamp_se uclamp_default[UCLAMP_CNT];
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7cd316793f4e3..44adcbfa9eb32 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6829,7 +6829,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu, int sy
>  		goto unlock;
>  
>  	latency_sensitive = uclamp_latency_sensitive(p);

I don't think this is the right tree.


> -	boosted = uclamp_boosted(p);
> +	boosted = sysctl_sched_uclamp_util_min_to_boost && uclamp_boosted(p);
>  	target_cap = boosted ? 0 : ULONG_MAX;
>  
>  	for (; pd; pd = pd->next) {
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8f196ed2ec065..6463d60fed84e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1882,6 +1882,15 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= sysctl_sched_uclamp_handler,
>  	},
> +	{
> +		.procname	= "sched_util_clamp_min_to_boost",
> +		.data		= &sysctl_sched_uclamp_util_min_to_boost,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>  #endif
>  #ifdef CONFIG_SCHED_AUTOGROUP
>  	{
> -- 
> 2.17.1
> 
