Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58A953784E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiE3JnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiE3JnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:43:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EC5B4B1F7;
        Mon, 30 May 2022 02:43:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40F97153B;
        Mon, 30 May 2022 02:43:06 -0700 (PDT)
Received: from [192.168.1.11] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90553F73D;
        Mon, 30 May 2022 02:43:04 -0700 (PDT)
Message-ID: <2b2df076-f8fe-10f7-9bc4-3e1f3c1639d0@arm.com>
Date:   Mon, 30 May 2022 11:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1] cpufreq: CPPC: Fix unused-function warning
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
References: <20220530081236.40728-1-pierre.gondois@arm.com>
 <20220530082025.vqzk37dvyzxiq7dv@vireshk-i7>
 <3a26ce90-5d2d-0164-3799-85a9dc1abee6@arm.com>
 <20220530090738.7ycfr7g52b54jzj3@vireshk-i7>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20220530090738.7ycfr7g52b54jzj3@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 11:07, Viresh Kumar wrote:
> On 30-05-22, 10:44, Pierre Gondois wrote:
>>
>>
>> On 5/30/22 10:20, Viresh Kumar wrote:
>>> On 30-05-22, 10:12, Pierre Gondois wrote:
>>>> Building the cppc_cpufreq driver with for arm64 with
>>>> CONFIG_ENERGY_MODEL=n triggers the following warnings:
>>>>    drivers/cpufreq/cppc_cpufreq.c:550:12: error: ‘cppc_get_cpu_cost’ defined but not used
>>>> [-Werror=unused-function]
>>>>      550 | static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>>>>          |            ^~~~~~~~~~~~~~~~~
>>>>    drivers/cpufreq/cppc_cpufreq.c:481:12: error: ‘cppc_get_cpu_power’ defined but not used
>>>> [-Werror=unused-function]
>>>>      481 | static int cppc_get_cpu_power(struct device *cpu_dev,
>>>>          |            ^~~~~~~~~~~~~~~~~~
>>>>
>>>> Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
>>>> Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>>> ---
>>>>    drivers/cpufreq/cppc_cpufreq.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index d092c9bb4ba3..ecd0d3ee48c5 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -478,7 +478,7 @@ static inline unsigned long compute_cost(int cpu, int step)
>>>>    			step * CPPC_EM_COST_STEP;
>>>>    }
>>>> -static int cppc_get_cpu_power(struct device *cpu_dev,
>>>> +static __maybe_unused int cppc_get_cpu_power(struct device *cpu_dev,
>>>>    		unsigned long *power, unsigned long *KHz)
>>>>    {
>>>>    	unsigned long perf_step, perf_prev, perf, perf_check;
>>>> @@ -547,8 +547,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>>>>    	return 0;
>>>>    }
>>>> -static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>>>> -		unsigned long *cost)
>>>> +static __maybe_unused int cppc_get_cpu_cost(struct device *cpu_dev,
>>>> +		unsigned long KHz, unsigned long *cost)
>>>>    {
>>>>    	unsigned long perf_step, perf_prev;
>>>>    	struct cppc_perf_caps *perf_caps;
>>>
>>> Should we actually run cppc_cpufreq_register_em() for
>>> !CONFIG_ENERGY_MODEL ? Why?
>>>
>>
>> Hello Viresh,
>> It seems that when CONFIG_ENERGY_MODEL=n, the compiler is already
>> considering cppc_cpufreq_register_em() as an empty function.
>>
>> Indeed, CONFIG_ENERGY_MODEL=n makes em_dev_register_perf_domain()
>> an empty function, so cppc_cpufreq_register_em() is only made of
>> variable definitions. This compiler optimization also explains
>> why cppc_get_cpu_power() and cppc_get_cpu_cost() trigger the
>> -Wunused-function warning.
>>
>> Putting cppc_cpufreq_register_em() inside an
>> #ifdef CONFIG_ENERGY_MODEL
>> guard seems also valid to me. To avoid too many empty definitions
>> of cppc_cpufreq_register_em(), I guess it should be inside an
>> #if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
>> guard instead.
>> Please let me know what you prefer.
> 
> In that case we shouldn't do:
> 
> cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
> 
> as well, as that is extra work for the cpufreq core, which won't be
> used at all.
> 
> So instead of __maybe_unused, lets put all dependent stuff within
> CONFIG_ENERGY_MODEL ?
> 
Ok yes. Just to be sure and except if disagreed, I will use the
following structure:
#if CONFIG_ARM64
#else
#endif

#if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
int populate_efficiency_class();
#else
int populate_efficiency_class();
#endif

to avoid having multiple empty definitions of
populate_efficiency_class() (for eg.) that we would have with:
#if CONFIG_ARM64
#if CONFIG_ENERGY_MODEL
int populate_efficiency_class();
#else // CONFIG_ENERGY_MODEL
int populate_efficiency_class();
#endif // CONFIG_ENERGY_MODEL
#else // CONFIG_ARM64
int populate_efficiency_class();
#endif // CONFIG_ARM64
