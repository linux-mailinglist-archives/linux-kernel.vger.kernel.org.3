Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001844FB9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbiDKKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345624AbiDKKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:36:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D9C343AF3;
        Mon, 11 Apr 2022 03:33:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE8F8169C;
        Mon, 11 Apr 2022 03:33:58 -0700 (PDT)
Received: from [192.168.1.11] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9923B3F5A1;
        Mon, 11 Apr 2022 03:33:55 -0700 (PDT)
Message-ID: <a6bea108-5e3b-be13-5852-4607544985a2@arm.com>
Date:   Mon, 11 Apr 2022 12:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, maz@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20220407081620.1662192-1-pierre.gondois@arm.com>
 <20220407081620.1662192-2-pierre.gondois@arm.com>
 <20220411031015.skh3dw6vcbtn5f4u@vireshk-i7>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20220411031015.skh3dw6vcbtn5f4u@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 05:10, Viresh Kumar wrote:
> On 07-04-22, 10:16, Pierre Gondois wrote:
>> From: Pierre Gondois <Pierre.Gondois@arm.com>
>>
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
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 82d370ae6a4a..ffcd9704add2 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -41,6 +41,8 @@
>>    */
>>   static LIST_HEAD(cpu_data_list);
>>   
>> +static struct cppc_cpudata *cppc_cpufreq_search_cpu_data(unsigned int cpu);
>> +
>>   static bool boost_supported;
>>   
>>   struct cppc_workaround_oem_info {
>> @@ -479,6 +481,19 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>>   	policy->driver_data = NULL;
>>   }
>>   
>> +static struct cppc_cpudata *
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
> 
> Did you miss this in cppc_cpufreq_cpu_init() ?
> 
> 	policy->driver_data = cpu_data;
> 
> The data is saved inside the policy and it shouldn't be difficult to
> fetch it from there, instead of going through the list.
> 

A previous (internal) implementation required this function,
but this is not necessary anymore indeed. I will drop this patch,
Thanks for the review,
Pierre
