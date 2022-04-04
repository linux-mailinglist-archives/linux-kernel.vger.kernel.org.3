Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6154F191A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 18:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357764AbiDDQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378885AbiDDQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:03:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51776245A5;
        Mon,  4 Apr 2022 09:01:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B086D6E;
        Mon,  4 Apr 2022 09:01:18 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55ED3F73B;
        Mon,  4 Apr 2022 09:01:17 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:01:16 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: Re: [RESEND][PATCH 2/8] PM: EM: Add artificial EM flag
Message-ID: <YksWTEwcmymS8+zm@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <20220321095729.20655-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321095729.20655-3-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 Mar 2022 at 09:57:23 (+0000), Lukasz Luba wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> The Energy Model (EM) can be used on platforms which are missing real
> power information. Those platforms would implement .get_cost() which
> populates needed values for the Energy Aware Scheduler (EAS). The EAS
> doesn't use 'power' fields from EM, but other frameworks might use them.
> Thus, to avoid miss-usage of this specific type of EM, introduce a new
> flags which can be checked by other frameworks.
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 5 +++++
>  kernel/power/energy_model.c  | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 0a3a5663177b..92e82a322859 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -67,11 +67,16 @@ struct em_perf_domain {
>   *
>   *  EM_PERF_DOMAIN_SKIP_INEFFICIENCIES: Skip inefficient states when estimating
>   *  energy consumption.
> + *
> + *  EM_PERF_DOMAIN_ARTIFICIAL: The power values are artificial and might be
> + *  created by platform missing real power information
>   */
>  #define EM_PERF_DOMAIN_MILLIWATTS BIT(0)
>  #define EM_PERF_DOMAIN_SKIP_INEFFICIENCIES BIT(1)
> +#define EM_PERF_DOMAIN_ARTIFICIAL BIT(2)
>  
>  #define em_span_cpus(em) (to_cpumask((em)->cpus))
> +#define em_is_artificial(em) ((em)->flags & EM_PERF_DOMAIN_ARTIFICIAL)
>  
>  #ifdef CONFIG_ENERGY_MODEL
>  #define EM_MAX_POWER 0xFFFF
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 0153b0ca7b23..6ecee99af842 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -384,6 +384,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  
>  	if (milliwatts)
>  		dev->em_pd->flags |= EM_PERF_DOMAIN_MILLIWATTS;
> +	else if (cb->get_cost)
> +		dev->em_pd->flags |= EM_PERF_DOMAIN_ARTIFICIAL;
>  
>  	em_cpufreq_update_efficiencies(dev);
>  

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

> -- 
> 2.17.1
> 
