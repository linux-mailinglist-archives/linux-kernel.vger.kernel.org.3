Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422104F1918
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 18:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378821AbiDDQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378808AbiDDQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:02:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AA4A245A5;
        Mon,  4 Apr 2022 09:00:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3756D6E;
        Mon,  4 Apr 2022 09:00:49 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888053F73B;
        Mon,  4 Apr 2022 09:00:49 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:00:47 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: Re: [RESEND][PATCH 1/8] PM: EM: Add .get_cost() callback
Message-ID: <YksWL2cWQDXPCuKv@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <20220321095729.20655-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321095729.20655-2-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 Mar 2022 at 09:57:22 (+0000), Lukasz Luba wrote:
> The Energy Model (EM) supports devices which report abstract power scale,
> not only real Watts. The primary goal for EM is to enable the Energy Aware
> Scheduler (EAS) for a given platform. Some of the platforms might not be
> able to deliver proper power values. The only information that they might
> have is the relative efficiency between CPU types.
> 
> Thus, it makes sense to remove some restrictions in the EM framework and
> introduce a mechanism which would support those platforms. What is crucial
> for EAS to operate is the 'cost' field in the EM. The 'cost' is calculated
> internally in EM framework based on knowledge from 'power' values.
> The 'cost' values must be strictly increasing. The existing API with its
> 'power' value size restrictions cannot guarantee that the 'cost' will meet
> this requirement.
> 
> Since the platform is missing this detailed information, but has only
> efficiency details, introduce a new custom callback in the EM framework.
> The new callback would allow to provide the 'cost' values which reflect
> efficiency of the CPUs. This would allow to provide EAS information which
> has different relation than what would be forced by the EM internal
> formulas calculating 'cost' values. Thanks to this new callback it is
> possible to create a system view for EAS which has no overlapping
> performance states across many Performance Domains.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 9f3c400bc52d..0a3a5663177b 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -114,9 +114,30 @@ struct em_data_callback {
>  	 */
>  	int (*active_power)(unsigned long *power, unsigned long *freq,
>  			    struct device *dev);
> +
> +	/**
> +	 * get_cost() - Provide the cost at the given performance state of
> +	 *		a device
> +	 * @dev		: Device for which we do this operation (can be a CPU)
> +	 * @freq	: Frequency at the performance state in kHz
> +	 * @cost	: The cost value for the performance state
> +	 *		(modified)
> +	 *
> +	 * In case of CPUs, the cost is the one of a single CPU in the domain.
> +	 * It is expected to fit in the [0, EM_MAX_POWER] range due to internal
> +	 * usage in EAS calculation.
> +	 *
> +	 * Return 0 on success, or appropriate error value in case of failure.
> +	 */
> +	int (*get_cost)(struct device *dev, unsigned long freq,
> +			unsigned long *cost);
>  };
> -#define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
>  #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
> +#define EM_ADV_DATA_CB(_active_power_cb, _cost_cb)	\
> +	{ .active_power = _active_power_cb,		\
> +	  .get_cost = _cost_cb }
> +#define EM_DATA_CB(_active_power_cb)			\
> +		EM_ADV_DATA_CB(_active_power_cb, NULL)
>  
>  struct em_perf_domain *em_cpu_get(int cpu);
>  struct em_perf_domain *em_pd_get(struct device *dev);
> @@ -264,6 +285,7 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>  
>  #else
>  struct em_data_callback {};
> +#define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
>  #define EM_DATA_CB(_active_power_cb) { }
>  #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) do { } while (0)
>  

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks,
Ionela.

> -- 
> 2.17.1
> 
