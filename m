Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463F3537536
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiE3Gmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiE3Gms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:42:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478333B574;
        Sun, 29 May 2022 23:42:47 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LBQnm1RFxzDqXl;
        Mon, 30 May 2022 14:42:36 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 14:42:44 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: Register EM based on efficiency
 class information
To:     Pierre Gondois <pierre.gondois@arm.com>,
        <linux-kernel@vger.kernel.org>
CC:     <Ionela.Voinescu@arm.com>, <Lukasz.Luba@arm.com>,
        <Morten.Rasmussen@arm.com>, <Dietmar.Eggemann@arm.com>,
        <maz@kernel.org>, <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>, Phil Auld <pauld@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
References: <20220425123819.137735-1-pierre.gondois@arm.com>
 <20220425123819.137735-3-pierre.gondois@arm.com>
Message-ID: <626c99d3-edaf-4544-7e64-5b3653591086@hisilicon.com>
Date:   Mon, 30 May 2022 14:42:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220425123819.137735-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a warning on arm64 platform when CONFIG_ENERGY_MODEL is not set:
 drivers/cpufreq/cppc_cpufreq.c:550:12: error: ‘cppc_get_cpu_cost’ defined but not used
[-Werror=unused-function]
   550 | static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
       |            ^~~~~~~~~~~~~~~~~
 drivers/cpufreq/cppc_cpufreq.c:481:12: error: ‘cppc_get_cpu_power’ defined but not used
[-Werror=unused-function]
   481 | static int cppc_get_cpu_power(struct device *cpu_dev,
       |            ^~~~~~~~~~~~~~~~~~

Thanks,
Shaokun

On 2022/4/25 20:38, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> Performance states and energy consumption values are not advertised
> in ACPI. In the GicC structure of the MADT table, the "Processor
> Power Efficiency Class field" (called efficiency class from now)
> allows to describe the relative energy efficiency of CPUs.
> 
> To leverage the EM and EAS, the CPPC driver creates a set of
> artificial performance states and registers them in the Energy Model
> (EM), such as:
> - Every 20 capacity unit, a performance state is created.
> - The energy cost of each performance state gradually increases.
> No power value is generated as only the cost is used in the EM.
> 
> During task placement, a task can raise the frequency of its whole
> pd. This can make EAS place a task on a pd with CPUs that are
> individually less energy efficient.
> As cost values are artificial, and to place tasks on CPUs with the
> lower efficiency class, a gap in cost values is generated for adjacent
> efficiency classes.
> E.g.:
> - efficiency class = 0, capacity is in [0-1024], so cost values
>   are in [0: 51] (one performance state every 20 capacity unit)
> - efficiency class = 1, capacity is in [0-1024], cost values
>   are in [1*gap+0: 1*gap+51].
> 
> The value of the cost gap is chosen to absorb a the energy of 4 CPUs
> at their maximum capacity. This means that between:
> 1- a pd of 4 CPUs, each of them being used at almost their full
>    capacity. Their efficiency class is N.
> 2- a CPU using almost none of its capacity. Its efficiency class is
>    N+1
> EAS will choose the first option.
> 
> This patch also populates the (struct cpufreq_driver).register_em
> callback if the valid efficiency_class ACPI values are provided.
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 144 +++++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 3cd05651707d..3eaa23d1aaf5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -421,6 +421,134 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>  }
>  
>  static DEFINE_PER_CPU(unsigned int, efficiency_class);
> +static void cppc_cpufreq_register_em(struct cpufreq_policy *policy);
> +
> +/* Create an artificial performance state every CPPC_EM_CAP_STEP capacity unit. */
> +#define CPPC_EM_CAP_STEP	(20)
> +/* Increase the cost value by CPPC_EM_COST_STEP every performance state. */
> +#define CPPC_EM_COST_STEP	(1)
> +/* Add a cost gap correspnding to the energy of 4 CPUs. */
> +#define CPPC_EM_COST_GAP	(4 * SCHED_CAPACITY_SCALE * CPPC_EM_COST_STEP \
> +				/ CPPC_EM_CAP_STEP)
> +
> +static unsigned int get_perf_level_count(struct cpufreq_policy *policy)
> +{
> +	struct cppc_perf_caps *perf_caps;
> +	unsigned int min_cap, max_cap;
> +	struct cppc_cpudata *cpu_data;
> +	int cpu = policy->cpu;
> +
> +	cpu_data = policy->driver_data;
> +	perf_caps = &cpu_data->perf_caps;
> +	max_cap = arch_scale_cpu_capacity(cpu);
> +	min_cap = div_u64(max_cap * perf_caps->lowest_perf, perf_caps->highest_perf);
> +	if ((min_cap == 0) || (max_cap < min_cap))
> +		return 0;
> +	return 1 + max_cap / CPPC_EM_CAP_STEP - min_cap / CPPC_EM_CAP_STEP;
> +}
> +
> +/*
> + * The cost is defined as:
> + *   cost = power * max_frequency / frequency
> + */
> +static inline unsigned long compute_cost(int cpu, int step)
> +{
> +	return CPPC_EM_COST_GAP * per_cpu(efficiency_class, cpu) +
> +			step * CPPC_EM_COST_STEP;
> +}
> +
> +static int cppc_get_cpu_power(struct device *cpu_dev,
> +		unsigned long *power, unsigned long *KHz)
> +{
> +	unsigned long perf_step, perf_prev, perf, perf_check;
> +	unsigned int min_step, max_step, step, step_check;
> +	unsigned long prev_freq = *KHz;
> +	unsigned int min_cap, max_cap;
> +	struct cpufreq_policy *policy;
> +
> +	struct cppc_perf_caps *perf_caps;
> +	struct cppc_cpudata *cpu_data;
> +
> +	policy = cpufreq_cpu_get_raw(cpu_dev->id);
> +	cpu_data = policy->driver_data;
> +	perf_caps = &cpu_data->perf_caps;
> +	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
> +	min_cap = div_u64(max_cap * perf_caps->lowest_perf,
> +			perf_caps->highest_perf);
> +
> +	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
> +	min_step = min_cap / CPPC_EM_CAP_STEP;
> +	max_step = max_cap / CPPC_EM_CAP_STEP;
> +
> +	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +	step = perf_prev / perf_step;
> +
> +	if (step > max_step)
> +		return -EINVAL;
> +
> +	if (min_step == max_step) {
> +		step = max_step;
> +		perf = perf_caps->highest_perf;
> +	} else if (step < min_step) {
> +		step = min_step;
> +		perf = perf_caps->lowest_perf;
> +	} else {
> +		step++;
> +		if (step == max_step)
> +			perf = perf_caps->highest_perf;
> +		else
> +			perf = step * perf_step;
> +	}
> +
> +	*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
> +	perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +	step_check = perf_check / perf_step;
> +
> +	/*
> +	 * To avoid bad integer approximation, check that new frequency value
> +	 * increased and that the new frequency will be converted to the
> +	 * desired step value.
> +	 */
> +	while ((*KHz == prev_freq) || (step_check != step)) {
> +		perf++;
> +		*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
> +		perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +		step_check = perf_check / perf_step;
> +	}
> +
> +	/*
> +	 * With an artificial EM, only the cost value is used. Still the power
> +	 * is populated such as 0 < power < EM_MAX_POWER. This allows to add
> +	 * more sense to the artificial performance states.
> +	 */
> +	*power = compute_cost(cpu_dev->id, step);
> +
> +	return 0;
> +}
> +
> +static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
> +		unsigned long *cost)
> +{
> +	unsigned long perf_step, perf_prev;
> +	struct cppc_perf_caps *perf_caps;
> +	struct cpufreq_policy *policy;
> +	struct cppc_cpudata *cpu_data;
> +	unsigned int max_cap;
> +	int step;
> +
> +	policy = cpufreq_cpu_get_raw(cpu_dev->id);
> +	cpu_data = policy->driver_data;
> +	perf_caps = &cpu_data->perf_caps;
> +	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
> +
> +	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, KHz);
> +	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
> +	step = perf_prev / perf_step;
> +
> +	*cost = compute_cost(cpu_dev->id, step);
> +
> +	return 0;
> +}
>  
>  static int populate_efficiency_class(void)
>  {
> @@ -453,10 +581,23 @@ static int populate_efficiency_class(void)
>  		}
>  		index++;
>  	}
> +	cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
>  
>  	return 0;
>  }
>  
> +static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data;
> +	struct em_data_callback em_cb =
> +		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
> +
> +	cpu_data = policy->driver_data;
> +	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
> +			get_perf_level_count(policy), &em_cb,
> +			cpu_data->shared_cpu_map, 0);
> +}
> +
>  #else
>  
>  static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
> @@ -467,6 +608,9 @@ static int populate_efficiency_class(void)
>  {
>  	return 0;
>  }
> +static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> +{
> +}
>  #endif
>  
>  
> 
