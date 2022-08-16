Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA259594E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiHPLEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiHPLDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:03:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81CB7C3F62;
        Tue, 16 Aug 2022 03:16:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2785113E;
        Tue, 16 Aug 2022 03:16:32 -0700 (PDT)
Received: from [10.57.14.225] (unknown [10.57.14.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0785A3F70D;
        Tue, 16 Aug 2022 03:16:30 -0700 (PDT)
Message-ID: <04a18937-bb11-736f-2cb3-0cb76a25bcc7@arm.com>
Date:   Tue, 16 Aug 2022 11:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] cpufreq: check only freq_table in __resolve_freq()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org
References: <20220811165408.23027-1-lukasz.luba@arm.com>
 <20220812040545.gcmyjjpqfup3bo5u@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220812040545.gcmyjjpqfup3bo5u@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/22 05:05, Viresh Kumar wrote:
> On 11-08-22, 17:54, Lukasz Luba wrote:
>> The there is no need to check if the cpufreq driver implements callback
> 
> s/The there/There/
> 
>> cpufreq_driver::target_index. The logic in the __resolve_freq uses
>> the frequency table available in the policy. It doesn't matter if the
>> driver provides 'target_index' or 'target' callback. It just has to
>> populate the 'policy->freq_table'.
>>
>> Thus, check only frequency table during the frequency resolving call.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 7820c4e74289..69b3d61852ac 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -532,7 +532,7 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>>   
>>   	target_freq = clamp_val(target_freq, policy->min, policy->max);
>>   
>> -	if (!cpufreq_driver->target_index)
>> +	if (!policy->freq_table)
>>   		return target_freq;
>>   
>>   	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thanks Viresh! I'll resend this patch w/ fixed description and your ACK
