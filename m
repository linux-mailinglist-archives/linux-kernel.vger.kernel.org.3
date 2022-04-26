Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34127510146
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351861AbiDZPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDZPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:04:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B50A3AA6D;
        Tue, 26 Apr 2022 08:01:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CDF723A;
        Tue, 26 Apr 2022 08:01:49 -0700 (PDT)
Received: from [10.57.12.108] (unknown [10.57.12.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B9C63F73B;
        Tue, 26 Apr 2022 08:01:47 -0700 (PDT)
Message-ID: <36852629-f803-5ac9-bef5-bcfae3ed947d@arm.com>
Date:   Tue, 26 Apr 2022 16:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v3 2/5] cpuidle: Add Cpufreq Active Stats calls
 tracking idle entry/exit
Content-Language: en-US
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406220809.22555-1-lukasz.luba@arm.com>
 <20220406220809.22555-3-lukasz.luba@arm.com>
 <97e7e3f5110702fab727b4df7d53511aef5c60b1.camel@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <97e7e3f5110702fab727b4df7d53511aef5c60b1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

Thanks for comments!

On 4/26/22 13:05, Artem Bityutskiy wrote:
> Hi Lukasz,
> 
> On Wed, 2022-04-06 at 23:08 +0100, Lukasz Luba wrote:
>> @@ -231,6 +232,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct
>> cpuidle_driver *drv,
>>          trace_cpu_idle(index, dev->cpu);
>>          time_start = ns_to_ktime(local_clock());
>>   
>> +       cpufreq_active_stats_cpu_idle_enter(time_start);
>> +
>>          stop_critical_timings();
>>          if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>>                  rcu_idle_enter();
>> @@ -243,6 +246,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct
>> cpuidle_driver *drv,
>>          time_end = ns_to_ktime(local_clock());
>>          trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
>>   
>> +       cpufreq_active_stats_cpu_idle_exit(time_end);
>> +
> 
> At this point the interrupts are still disabled, and they get enabled later. So
> the more code you add here and the longer it executes, the longer you delay the
> interrupts. Therefore, you are effectively increasing IRQ latency from idle by
> adding more code here.

Good point, I've added it just below the trace_cpu_idle().

> 
> How much? I do not know, depends on how much code you need to execute. But the
> amount of code in functions like this tends to increase over time.
> 
> So the risk is that we'll keep making 'cpufreq_active_stats_cpu_idle_exit()',
> and (may be unintentionally) increase idle interrupt latency.
> 
> This is not ideal.

I agree,  I will try to find a better place to put this call.

> 
> We use the 'wult' tool (https://github.com/intel/wult) to measure C-states
> latency and interrupt latency on Intel platforms, and for fast C-states like
> Intel C1, we can see that even the current code between C-state exit and
> interrupt re-enabled adds measurable overhead.

Thanks for the hint and the link. I'll check that tool. I don't know if
that would work with my platforms. I might create some tests for this
latency measurements.

> 
> I am worried about adding more stuff here.
> 
> Please, consider getting the stats after interrupts are re-enabled. You may lose
> some "precision" because of that, but it is probably overall better that adding
> to idle interrupt latency.

Definitely. I don't need such precision, so later when interrupts are
re-enabled is OK for me.

> 
>>          /* The cpu is no longer idle or about to enter idle. */
>>          sched_idle_set_state(NULL);
> 
> 

This new call might be empty for your x86 kernels, since probably
you set the CONFIG_CPU_FREQ_STAT.I can add additional config
so platforms might still have CONFIG_CPU_FREQ_STAT but avoid this
new feature and additional overhead in idle exit when e.g.
CONFIG_CPU_FREQ_ACTIVE_STAT is not set.

The x86 platforms won't use IPA governor, so it's reasonable to
do this way.

Does this sounds good?

Regards,
Lukasz

