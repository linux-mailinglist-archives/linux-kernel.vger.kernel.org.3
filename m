Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF4568326
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiGFJLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiGFJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:11:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51E872872E;
        Wed,  6 Jul 2022 02:08:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2673115A1;
        Wed,  6 Jul 2022 02:08:10 -0700 (PDT)
Received: from [10.57.9.19] (unknown [10.57.9.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08F243F66F;
        Wed,  6 Jul 2022 02:08:06 -0700 (PDT)
Message-ID: <95d76278-ce40-aab8-1418-322f8b4a3072@arm.com>
Date:   Wed, 6 Jul 2022 10:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/4] cpufreq: scmi: Support the power scale in micro-Watts
 in SCMI v3.1
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amitk@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-5-lukasz.luba@arm.com>
 <653f63e5-c794-27fb-115a-7b051850991b@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <653f63e5-c794-27fb-115a-7b051850991b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/22 10:25, Daniel Lezcano wrote:
> On 22/06/2022 16:58, Lukasz Luba wrote:
>> The SCMI v3.1 adds support for power values in micro-Watts. They are not
>> always in milli-Watts anymore (ignoring the bogo-Watts). Thus, the power
>> must be converted conditionally before sending to Energy Model. Add the
>> logic which handles the needed checks and conversions.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/scmi-cpufreq.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c 
>> b/drivers/cpufreq/scmi-cpufreq.c
>> index bfd35583d653..513a071845c2 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -100,7 +100,7 @@ static int __maybe_unused
>>   scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
>>              unsigned long *KHz)
>>   {
>> -    bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
>> +    enum scmi_power_scale power_scale = perf_ops->power_scale_get(ph);
>>       unsigned long Hz;
>>       int ret, domain;
>> @@ -114,8 +114,8 @@ scmi_get_cpu_power(struct device *cpu_dev, 
>> unsigned long *power,
>>       if (ret)
>>           return ret;
>> -    /* Provide bigger resolution power to the Energy Model */
>> -    if (power_scale_mw)
>> +    /* Convert the power to uW if it is mW (ignore bogoW) */
>> +    if (power_scale == SCMI_POWER_MILLIWATTS)
>>           *power *= MICROWATT_PER_MILLIWATT;
>>       /* The EM framework specifies the frequency in KHz. */
>> @@ -255,8 +255,9 @@ static int scmi_cpufreq_exit(struct cpufreq_policy 
>> *policy)
>>   static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
>>   {
>>       struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>> -    bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
>> +    enum scmi_power_scale power_scale = perf_ops->power_scale_get(ph);
>>       struct scmi_data *priv = policy->driver_data;
>> +    bool em_power_scale = false;
> 
> Just pass 'false' to em_dev_register_perf_domain()

We cannot,

> 
>>       /*
>>        * This callback will be called for each policy, but we don't 
>> need to
>> @@ -268,9 +269,13 @@ static void scmi_cpufreq_register_em(struct 
>> cpufreq_policy *policy)
>>       if (!priv->nr_opp)
>>           return;
>> +    if (power_scale == SCMI_POWER_MILLIWATTS
>> +        || power_scale == SCMI_POWER_MICROWATTS)
>> +        em_power_scale = true;
>> +

because sometimes it's 'true'.

>>       em_dev_register_perf_domain(get_cpu_device(policy->cpu), 
>> priv->nr_opp,
>>                       &em_cb, priv->opp_shared_cpus,
>> -                    power_scale_mw);
>> +                    em_power_scale);

Then we just use the variable here in single call.

>>   }
>>   static struct cpufreq_driver scmi_cpufreq_driver = {
> 
> 
