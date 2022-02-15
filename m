Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029FD4B684A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiBOJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:57:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBOJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:57:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3783810DA57;
        Tue, 15 Feb 2022 01:57:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04D111063;
        Tue, 15 Feb 2022 01:57:22 -0800 (PST)
Received: from [10.57.13.122] (unknown [10.57.13.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB6F3F66F;
        Tue, 15 Feb 2022 01:57:20 -0800 (PST)
Subject: Re: [PATCH v5] drivers: thermal: clear all mitigation when thermal
 zone is disabled
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1643307093-22501-1-git-send-email-quic_manafm@quicinc.com>
 <4024218b-7938-e181-f456-bff4b3fb157a@arm.com>
 <c02d28ce-bef4-0b71-e90a-991ef4fae9d3@quicinc.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f936ee68-3e2c-273c-38fe-9b37277f54ba@arm.com>
Date:   Tue, 15 Feb 2022 09:57:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c02d28ce-bef4-0b71-e90a-991ef4fae9d3@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/22 8:00 PM, Manaf Meethalavalappu Pallikunhi wrote:
> 
> On 1/31/2022 12:55 PM, Lukasz Luba wrote:
>> Hi Manaf,
>>
>> On 1/27/22 6:11 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>> Whenever a thermal zone is in trip violated state, there is a chance
>>> that the same thermal zone mode can be disabled either via
>>> thermal core API or via thermal zone sysfs. Once it is disabled,
>>> the framework bails out any re-evaluation of thermal zone. It leads
>>> to a case where if it is already in mitigation state, it will stay
>>> the same state forever.
>>>
>>> To avoid above mentioned issue, add support to bind/unbind
>>> governor from thermal zone during thermal zone mode change request
>>> and clear all existing throttling in governor unbind_from_tz()
>>> callback.
>>
>> I have one use case:
>> This would be a bit dangerous, e.g. to switch governors while there is a
>> high temperature. Although, sounds reasonable to left a 'default' state
>> for a next governor.
>>
> I believe only way to change the governror via userspace at runtime.
> 
> Just re-evaluate thermal zone  (thermal_zone_device_update) immediately 
> after
> 
> thermal_zone_device_set_policy()  in same policy_store() context, isn't 
> it good enough ?

It depends. The code would switch the governors very fast, in the
meantime notifying about possible full speed of CPU (cooling state = 0).
If the task scheduler goes via schedutil (cpufreq governor) at that
moment and decides to set this max frequency, it will be set.
This is situation with your patch, since you added in IPA unbind
'allow_maximum_power()'.
Then the new governor is bind, evaluates the max cooling state, the
notification about reduced max freq is sent to schedutil (a workqueue
will call .sugov_limits() callback) and lower freq would be set.

Now there are things which are not greatly covered by these 4
involved sub-systems (thermal fwk, schedutil, scheduler, HW).
It takes time. It also depends when the actual HW freq is possible to be
set. It might take a few milli-seconds or even a dozes of milli-seconds
(depends on HW).

Without your change, we avoid such situation while switching the
thermal governors.

For your requirement, which is 'mode' enable/disable it OK to
un-throttle.

It's probably something to Rafael and Daniel to judge if we want to
pay that cost and introduce this racy time slot.

Maybe there is a way to implement your needed feature differently.
Unfortunately, I'm super busy with other stuff this month so I cannot
spent much time investigating this.


> 
> Not sure how a "default" state  can be reverted once governor change is 
> done.
> 
> Re-evaluating thermal zone doesn't guarantee that it will recover previous
> 
> set default state for all governors, right ?
> 
>>>
>>> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>>> <quic_manafm@quicinc.com>
>>> ---
>>>   drivers/thermal/gov_power_allocator.c |  3 +++
>>>   drivers/thermal/gov_step_wise.c       | 26 ++++++++++++++++++++++++++
>>>   drivers/thermal/thermal_core.c        | 31 
>>> +++++++++++++++++++++++++++----
>>>   3 files changed, 56 insertions(+), 4 deletions(-)
>>
>> Why only two governors need that change and not all?
>> Because they don't have 'bind/unbind' callbacks, then maybe we should
>> change that as well to make it consistent?
> I will update other governors as well in v6

Sounds reasonable based on your code (you've added the unbind_from_tz()
callback to step_wise, but not for others).

