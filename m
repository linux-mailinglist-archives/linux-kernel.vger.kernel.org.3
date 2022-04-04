Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A4C4F191D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378830AbiDDQDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 12:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378823AbiDDQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:03:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F8DA2DA96;
        Mon,  4 Apr 2022 09:01:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 423991474;
        Mon,  4 Apr 2022 09:01:47 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC7633F73B;
        Mon,  4 Apr 2022 09:01:46 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:01:45 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: Re: [RESEND][PATCH 3/8] PM: EM: Use the new .get_cost() callback
 while registering EM
Message-ID: <YksWaaskx0YhXFR9@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <20220321095729.20655-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321095729.20655-4-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Monday 21 Mar 2022 at 09:57:24 (+0000), Lukasz Luba wrote:
> The Energy Model (EM) allows to provide the 'cost' values when the device
> driver provides the .get_cost() optional callback. This removes
> restriction which is in the EM calculation function of the 'cost'
> for each performance state. Now, the driver is in charge of providing
> the right values which are then used by Energy Aware Scheduler.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 39 ++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 6ecee99af842..95a3b33001f6 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -121,7 +121,8 @@ static void em_debug_remove_pd(struct device *dev) {}
>  #endif
>  
>  static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
> -				int nr_states, struct em_data_callback *cb)
> +				int nr_states, struct em_data_callback *cb,
> +				unsigned long flags)
>  {
>  	unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
>  	struct em_perf_state *table;
> @@ -173,10 +174,22 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  	/* Compute the cost of each performance state. */
>  	fmax = (u64) table[nr_states - 1].frequency;
>  	for (i = nr_states - 1; i >= 0; i--) {
> -		unsigned long power_res = em_scale_power(table[i].power);
> +		unsigned long power_res, cost;
> +
> +		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> +			ret = cb->get_cost(dev, table[i].frequency, &cost);
> +			if (ret || !cost || cost > EM_MAX_POWER) {
> +				dev_err(dev, "EM: invalid cost %lu %d\n",
> +					cost, ret);
> +				goto free_ps_table;
> +			}
> +		} else {
> +			power_res = em_scale_power(table[i].power);
> +			cost = div64_u64(fmax * power_res, table[i].frequency);
> +		}
> +
> +		table[i].cost = cost;
>  
> -		table[i].cost = div64_u64(fmax * power_res,
> -					  table[i].frequency);
>  		if (table[i].cost >= prev_cost) {
>  			table[i].flags = EM_PERF_STATE_INEFFICIENT;
>  			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> @@ -197,7 +210,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  }
>  
>  static int em_create_pd(struct device *dev, int nr_states,
> -			struct em_data_callback *cb, cpumask_t *cpus)
> +			struct em_data_callback *cb, cpumask_t *cpus,
> +			unsigned long flags)
>  {
>  	struct em_perf_domain *pd;
>  	struct device *cpu_dev;
> @@ -215,7 +229,7 @@ static int em_create_pd(struct device *dev, int nr_states,
>  			return -ENOMEM;
>  	}
>  
> -	ret = em_create_perf_table(dev, pd, nr_states, cb);
> +	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
>  	if (ret) {
>  		kfree(pd);
>  		return ret;
> @@ -332,6 +346,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  				bool milliwatts)
>  {
>  	unsigned long cap, prev_cap = 0;
> +	unsigned long flags = 0;
>  	int cpu, ret;
>  
>  	if (!dev || !nr_states || !cb)
> @@ -378,14 +393,16 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  		}
>  	}
>  
> -	ret = em_create_pd(dev, nr_states, cb, cpus);
> +	if (milliwatts)
> +		flags |= EM_PERF_DOMAIN_MILLIWATTS;
> +	else if (cb->get_cost)
> +		flags |= EM_PERF_DOMAIN_ARTIFICIAL;
> +
> +	ret = em_create_pd(dev, nr_states, cb, cpus, flags);
>  	if (ret)
>  		goto unlock;
>  
> -	if (milliwatts)
> -		dev->em_pd->flags |= EM_PERF_DOMAIN_MILLIWATTS;
> -	else if (cb->get_cost)
> -		dev->em_pd->flags |= EM_PERF_DOMAIN_ARTIFICIAL;
> +	dev->em_pd->flags |= flags;
>  

nit: given that there is a designated function to create the PD which
now requires information on flags to initilise the domains properly,
might be better to have dev->em_pd->flags set inside that function,
rather than here.

>  	em_cpufreq_update_efficiencies(dev);
>  

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks,
Ionela.

> -- 
> 2.17.1
> 
