Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0454A706
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353373AbiFNCrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351913AbiFNCqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:46:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7061F40A2F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:24:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o6so6629943plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5f3zUmJ+WT5EgbY0xLlYWEtVw9I8E9st0he4AyjXGGg=;
        b=h7EWLwuLsPiCj+hvM2v0Q84XzKt0v34vLKvDyMwttHfhSMLfaml+w2iX06xhffZvcP
         qujvCPdU6uS5Rc3fqc5wtW3Ij3mugyNiZZswz6tTpAjpi8LaceQxpAMefpDpV8bny9kY
         HW0qjvIrLOmlrxUWDsfKUaP4DGdWzURsMgelvBkE/0ELMFqfep/XNxyMKy0a7Un5634e
         5E39hEvfF94t0UpYsa/RKFDA7LL2JyrDvhe/xvUgfYQMXzRSTeca0Q9cFqjmlSoDE8MC
         f2R+pOyx+9y+rbkOQqYqZm8pYo6Oi7K2r4jkEHyUwAi0CTl1UnEYrCjPGQo8Yqss6h03
         gh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5f3zUmJ+WT5EgbY0xLlYWEtVw9I8E9st0he4AyjXGGg=;
        b=T1QBqhF8rxKS3SFaf9zd8jpCqdm/wFoiKuvVEx4icKXYXHIEQMUE1BETFcrCLiRkdd
         5bcdtNL49MvcH3Dt/UbHXm0pZmVRW9XTp/pVWdGlKfQR/pSCtEv3fmOwN+NF3cbSZzf2
         l1P55HOc0tx/IAsHY5nuc0eMRuCKl7uyCf/lH7anlJeqE9GE3G2NgZwNQexOqZ0aOi+n
         IsjsTSxe7+c62NC+egO8PpLqQQZq4dRoxxnBTj41oe9ynx22jBxhzAv2iELWGYPk8s4u
         l8rsv25gPau2k1IdHe1GJ1NCDI/EuqEnsM4JgHSS86TwK9KXXFDf8SLLjU3R8nmtNvkE
         phZw==
X-Gm-Message-State: AJIora9n5BYVkYQFpq3NxvGxLr+Cv7qhpQ4yIjgzU/zY4G1zHXA65LlG
        o9SXb5TeFZnr6lcaKm7UFD9emw==
X-Google-Smtp-Source: ABdhPJzDnEQ46KP/Q51N5hL71Vk3s/mkd7cqv5z/3XRMcbkyMJramr0/YI/DPJ5vBQoskfWGtsgOgQ==
X-Received: by 2002:a17:902:7084:b0:167:95e2:f810 with SMTP id z4-20020a170902708400b0016795e2f810mr2152757plk.34.1655173491463;
        Mon, 13 Jun 2022 19:24:51 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902d64200b00168bee13e8fsm5833603plh.64.2022.06.13.19.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 19:24:51 -0700 (PDT)
Date:   Tue, 14 Jun 2022 07:54:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        mingo@redhat.com
Subject: Re: [PATCH v2 1/4] thermal: cpufreq_cooling: Use private callback
 ops for each cooling device
Message-ID: <20220614022448.pqld3zhqucsfofss@vireshk-i7>
References: <20220613124327.30766-1-lukasz.luba@arm.com>
 <20220613124327.30766-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613124327.30766-2-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-22, 13:43, Lukasz Luba wrote:
> It is very unlikely that one CPU cluster would have the EM and some other
> won't have it (because EM registration failed or DT lacks needed entry).
> Although, we should avoid modifying global variable with callbacks anyway.
> Redesign this and add safety for such situation.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index b8151d95a806..ad8b86f5281b 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -59,6 +59,7 @@ struct time_in_idle {
>   * @cdev: thermal_cooling_device pointer to keep track of the
>   *	registered cooling device.
>   * @policy: cpufreq policy.
> + * @cooling_ops: cpufreq callbacks to thermal cooling device ops
>   * @idle_time: idle time stats
>   * @qos_req: PM QoS contraint to apply
>   *
> @@ -71,6 +72,7 @@ struct cpufreq_cooling_device {
>  	unsigned int max_level;
>  	struct em_perf_domain *em;
>  	struct cpufreq_policy *policy;
> +	struct thermal_cooling_device_ops cooling_ops;
>  #ifndef CONFIG_SMP
>  	struct time_in_idle *idle_time;
>  #endif
> @@ -485,14 +487,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  	return ret;
>  }
>  
> -/* Bind cpufreq callbacks to thermal cooling device ops */
> -
> -static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
> -	.get_max_state		= cpufreq_get_max_state,
> -	.get_cur_state		= cpufreq_get_cur_state,
> -	.set_cur_state		= cpufreq_set_cur_state,
> -};
> -
>  /**
>   * __cpufreq_cooling_register - helper function to create cpufreq cooling device
>   * @np: a valid struct device_node to the cooling device device tree node
> @@ -554,7 +548,10 @@ __cpufreq_cooling_register(struct device_node *np,
>  	/* max_level is an index, not a counter */
>  	cpufreq_cdev->max_level = i - 1;
>  
> -	cooling_ops = &cpufreq_cooling_ops;
> +	cooling_ops = &cpufreq_cdev->cooling_ops;
> +	cooling_ops->get_max_state = cpufreq_get_max_state;
> +	cooling_ops->get_cur_state = cpufreq_get_cur_state;
> +	cooling_ops->set_cur_state = cpufreq_set_cur_state;
>  
>  #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>  	if (em_is_sane(cpufreq_cdev, em)) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
