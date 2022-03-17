Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC94DC924
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiCQOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiCQOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:46:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90DAED9EAE;
        Thu, 17 Mar 2022 07:44:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A451570;
        Thu, 17 Mar 2022 07:44:45 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C71FD3F7B4;
        Thu, 17 Mar 2022 07:44:41 -0700 (PDT)
Message-ID: <76a15179-560f-d412-1512-7ec28ea62cd9@arm.com>
Date:   Thu, 17 Mar 2022 15:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/3] cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
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
        Fuad Tabba <tabba@google.com>, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
 <20220317133419.3901736-2-Pierre.Gondois@arm.com>
 <746641141c630dc1d02943d6133a6c8d@kernel.org>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <746641141c630dc1d02943d6133a6c8d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/22 15:20, Marc Zyngier wrote:
> On 2022-03-17 13:34, Pierre Gondois wrote:
>> cppc_cpufreq_get_cpu_data() allocates a new struct cppc_cpudata
>> for the input CPU at each call.
>>
>> To search the struct associated with a cpu without allocating
>> a new one, add cppc_cpufreq_search_cpu_data().
>> Also add an early prototype.
>>
>> This will be used in a later patch, when generating artificial
>> performance states to register an artificial Energy Model in the
>> cppc_cpufreq driver and enable the Energy Aware Scheduler for ACPI
>> based systems.
>>
>> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 82d370ae6a4a..8f950fe72765 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -41,6 +41,8 @@
>>    */
>>   static LIST_HEAD(cpu_data_list);
>>
>> +static struct cppc_cpudata *cppc_cpufreq_search_cpu_data(unsigned int
>> cpu);
>> +
>>   static bool boost_supported;
>>
>>   struct cppc_workaround_oem_info {
>> @@ -479,6 +481,19 @@ static void cppc_cpufreq_put_cpu_data(struct
>> cpufreq_policy *policy)
>>   	policy->driver_data = NULL;
>>   }
>>
>> +static inline struct cppc_cpudata *
> 
> Why the inline? This is hardly performance critical, and if
> it is, you want something better than iterating over a list.

This was made inline mainly because the function was small. The function
is called only at boot, so it should not be performance critical. The
'inline' can be removed if necessary.
Would letting it inlined have a negative impact ?


> 
>> +cppc_cpufreq_search_cpu_data(unsigned int cpu)
>> +{
>> +	struct cppc_cpudata *iter, *tmp;
>> +
>> +	list_for_each_entry_safe(iter, tmp, &cpu_data_list, node) {
>> +		if (cpumask_test_cpu(cpu, iter->shared_cpu_map))
>> +			return iter;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>>   	unsigned int cpu = policy->cpu;
> 
> Thanks,
> 
>           M.

Regards,
Pierre
