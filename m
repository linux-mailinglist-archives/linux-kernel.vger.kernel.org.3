Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DAE4DC9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiCQPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiCQPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:14:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090ED9A9B4;
        Thu, 17 Mar 2022 08:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89B56CE0622;
        Thu, 17 Mar 2022 15:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95AFC340E9;
        Thu, 17 Mar 2022 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647530012;
        bh=3Gzmo6yhg4CSO7pzc6bkyN6wEITFveIES9j5diOg5bY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y77D8UJroGPR3MjsxfvZyWLjdarxKWkr6hBcdmrX3n7XEHdnLK4AXrTJfPjopX6fx
         Dm9Bn9pB+kfdUPw0NKU4fhuBnlbQUHf2oWQWTyq9+XVh84bekYdX3iaG2ZEXHe+B0h
         PezUT/f77rz1bzwnxdhJRKouS712WpSY/9sI3kg5Y9ZDny+ME0Z49c3LszPXZRvq2W
         n7wHBiLY3C1fygf0bS4mxepJmW8ab4djKpusbUX9tLYskYJoLKdK9pDJIdsIb4Qi3r
         CwFi1xxmJo8r6wfJ0OZBIro0BoVN2jR/aRdPQ3mQiMQK+ZgqypiVR2HTi++39lHkDA
         jHxS8JX7sMG7w==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nUrog-00FDYW-E2; Thu, 17 Mar 2022 15:13:30 +0000
MIME-Version: 1.0
Date:   Thu, 17 Mar 2022 15:13:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Pierre Gondois <Pierre.Gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: CPPC: Add per_cpu efficiency_class
In-Reply-To: <20220317133419.3901736-3-Pierre.Gondois@arm.com>
References: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
 <20220317133419.3901736-3-Pierre.Gondois@arm.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f4356101d8c8d209054566261b300a91@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, mka@chromium.org, daniel.lezcano@linaro.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com, ardb@kernel.org, tabba@google.com, valentin.schneider@arm.com, robh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-17 13:34, Pierre Gondois wrote:
> In ACPI, describing power efficiency of CPUs can be done through the
> following arm specific field:
> ACPI 6.4, s5.2.12.14 'GIC CPU Interface (GICC) Structure',
> 'Processor Power Efficiency Class field':
>   Describes the relative power efficiency of the associated pro-
>   cessor. Lower efficiency class numbers are more efficient than
>   higher ones (e.g. efficiency class 0 should be treated as more
>   efficient than efficiency class 1). However, absolute values
>   of this number have no meaning: 2 isn’t necessarily half as
>   efficient as 1.
> 
> The efficiency_class field is stored in the GicC structure of the
> ACPI MADT table and it's currently supported in Linux for arm64 only.
> Thus, this new functionality is introduced for arm64 only.
> 
> To allow the cppc_cpufreq driver to know and preprocess the
> efficiency_class values of all the CPUs, add a per_cpu efficiency_class
> variable to store them. Also add a static efficiency_class_populated
> to let the driver know efficiency_class values are usable and register
> an artificial Energy Model (EM) based on normalized class values.
> 
> At least 2 different efficiency classes must be present,
> otherwise there is no use in creating an Energy Model.
> 
> The efficiency_class values are squeezed in [0:#efficiency_class-1]
> while conserving the order. For instance, efficiency classes of:
>   [111, 212, 250]
> will be mapped to:
>   [0 (was 111), 1 (was 212), 2 (was 250)].
> 
> Each policy being independently registered in the driver, populating
> the per_cpu efficiency_class is done only once at the driver
> initialization. This prevents from having each policy re-searching the
> efficiency_class values of other CPUs.
> 
> The patch also exports acpi_cpu_get_madt_gicc() to fetch the GicC
> structure of the ACPI MADT table for each CPU.
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  arch/arm64/kernel/smp.c        |  1 +
>  drivers/cpufreq/cppc_cpufreq.c | 55 ++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 27df5c1e6baa..56637cbea5d6 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -512,6 +512,7 @@ struct acpi_madt_generic_interrupt
> *acpi_cpu_get_madt_gicc(int cpu)
>  {
>  	return &cpu_madt_gicc[cpu];
>  }
> +EXPORT_SYMBOL(acpi_cpu_get_madt_gicc);

Why not EXPORT_SYMBOL_GPL()?

> 
>  /*
>   * acpi_map_gic_cpu_interface - parse processor MADT entry
> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
> b/drivers/cpufreq/cppc_cpufreq.c
> index 8f950fe72765..a6cd95c3b474 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -422,12 +422,66 @@ static unsigned int
> cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>  	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
>  }
> 
> +static bool efficiency_class_populated;
> +static DEFINE_PER_CPU(unsigned int, efficiency_class);
> +
> +static int populate_efficiency_class(void)
> +{
> +	unsigned int min = UINT_MAX, max = 0, class;
> +	struct acpi_madt_generic_interrupt *gicc;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		gicc = acpi_cpu_get_madt_gicc(cpu);
> +		if (!gicc)
> +			return -ENODEV;

How can that happen if you made it here using ACPI?

> +
> +		per_cpu(efficiency_class, cpu) = gicc->efficiency_class;
> +		min = min_t(unsigned int, min, gicc->efficiency_class);
> +		max = max_t(unsigned int, max, gicc->efficiency_class);
> +	}

Why don't you use a temporary bitmap of 256 bits, tracking
the classes that are actually being used?

> +
> +	if (min == max) {

This would become (bitmap_weight(used_classes) <= 1). Then from
the same construct you know how many different classes you have.
You also have the min, max, and all the values in between.

> +		pr_debug("Efficiency classes are all equal (=%d). "
> +			"No EM registered", max);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Squeeze efficiency class values on [0:#efficiency_class-1].
> +	 * Values are per spec in [0:255].
> +	 */
> +	for (class = 0; class < 256; class++) {
> +		unsigned int new_min, curr;
> +
> +		new_min = UINT_MAX;
> +		for_each_possible_cpu(cpu) {
> +			curr = per_cpu(efficiency_class, cpu);
> +			if (curr == min)
> +				per_cpu(efficiency_class, cpu) = class;
> +			else if (curr > min)
> +				new_min = min(new_min, curr);
> +		}
> +
> +		if (new_min == UINT_MAX)
> +			break;
> +		min = new_min;
> +	}

I find it really hard to reason about this because you are
dynamically rewriting the values you keep reevaluating.

How about something like this, which I find more readable:

	DECLARE_BITMAP(used_classes, 256) = {};
	int class, index, cpu;

	for_each_possible_cpu(cpu) {
		unsigned int ec;

		ec = acpi_cpu_get_madt_gicc(cpu)->efficiency_class & 0xff;
		bitmap_set(ec, &used_classes);
	}

	if (bitmap_weight(&used_classes, 256) <= 1)
		return;

	index = 0;

	for_each_set_bit(class, &used_classes, 256) {
		for_each_possible_cpu(cpu) {
			if (acpi_cpu_get_madt_gicc(cpu)->efficiency_class == class)
				per_cpu(efficiency_class, cpu) = index;
		}

		index++;
	}


Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
