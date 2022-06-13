Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B93054976D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353063AbiFMLTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352946AbiFMLOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:14:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FDE8F0E;
        Mon, 13 Jun 2022 03:37:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAFB0D6E;
        Mon, 13 Jun 2022 03:37:21 -0700 (PDT)
Received: from [10.57.35.216] (unknown [10.57.35.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67F4A3F73B;
        Mon, 13 Jun 2022 03:37:20 -0700 (PDT)
Message-ID: <5bac6f98-e1ba-3584-6eac-21eeaaa0ed26@arm.com>
Date:   Mon, 13 Jun 2022 11:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] thermal: cpufreq_cooling: Use a copy of local ops for
 each cooling device
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com
References: <20220610100343.32378-1-lukasz.luba@arm.com>
 <20220613091611.ncd2hziu4nbyip4x@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220613091611.ncd2hziu4nbyip4x@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Thank you for the ACKs in the other patches and suggestion in this one.

On 6/13/22 10:16, Viresh Kumar wrote:
> On 10-06-22, 11:03, Lukasz Luba wrote:
>> It is very unlikely that one CPU cluster would have the EM and some other
>> won't have it (because EM registration failed or DT lacks needed entry).
>> Although, we should avoid modifying global variable with callbacks anyway.
>> Redesign this and add safety for such situation.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/cpufreq_cooling.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
>> index b8151d95a806..e33183785fac 100644
>> --- a/drivers/thermal/cpufreq_cooling.c
>> +++ b/drivers/thermal/cpufreq_cooling.c
>> @@ -554,7 +554,12 @@ __cpufreq_cooling_register(struct device_node *np,
>>   	/* max_level is an index, not a counter */
>>   	cpufreq_cdev->max_level = i - 1;
>>   
>> -	cooling_ops = &cpufreq_cooling_ops;
>> +	cooling_ops = kmemdup(&cpufreq_cooling_ops, sizeof(*cooling_ops),
>> +			      GFP_KERNEL);
> 
> I don't like the way we are duplicating the ops here. Instead of this it would
> be better to add the OPs field in the cooling device structure and fill its
> fields from here. The ops structure will be allocated with the cooling device
> itself.
> 

I think I know what you mean. Make sense. There are quite a few
different cooling types of devices which are using the API
thermal_of_cooling_device_register() with the custom 'ops'. We
probably don't want to disturb that well working drivers and ecosystem.

Here, I've tried to align this code with the devfreq_cooling, but I
might actually apply your suggestion into the devfreq cooling (so they
will be still aligned). In that case both struct devfreq_cooling_device
and struct cpufreq_cooling_device would get a new field:
struct thermal_cooling_device_ops cooling_ops;
We could then remove the 'global' variables:
devfreq_cooling_ops and cpufreq_cooling_ops from where we copy.
Then we would do the needed assignment to the priv 'cooling_ops' in the
setup code and just use the old API
thermal_of_cooling_device_register() to set the needed 'ops' pointer in
the struct thermal_cooling_device.

Does this sound OK?

Regards,
Lukasz
