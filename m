Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D65114F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiD0Kml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiD0Kmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:42:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98FA548E863
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:22:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AD2E143D;
        Wed, 27 Apr 2022 03:22:41 -0700 (PDT)
Received: from [10.0.0.20] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9AA3F774;
        Wed, 27 Apr 2022 03:22:39 -0700 (PDT)
Message-ID: <2c389633-9b9c-3db9-6c07-a124596e3799@arm.com>
Date:   Wed, 27 Apr 2022 11:22:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v6 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
References: <20220426093506.3415588-1-vincent.donnefort@arm.com>
 <20220426093506.3415588-3-vincent.donnefort@arm.com>
 <YmkL7CevuugEHsol@geo.homenetwork>
From:   Vincent Donnefort <vincent.donnefort@arm.com>
In-Reply-To: <YmkL7CevuugEHsol@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2022 10:25, Tao Zhou wrote:
> On Tue, Apr 26, 2022 at 10:35:01AM +0100, Vincent Donnefort wrote:
> 
>> Before being migrated to a new CPU, a task sees its PELT values
>> synchronized with rq last_update_time. Once done, that same task will also
>> have its sched_avg last_update_time reset. This means the time between
>> the migration and the last clock update (B) will not be accounted for in
>> util_avg and a discontinuity will appear. This issue is amplified by the
>> PELT clock scaling. If the clock hasn't been updated while the CPU is
>> idle, clock_pelt will not be aligned with clock_task and that time (A)
>> will be also lost.
>>
>>     ---------|----- A -----|-----------|------- B -----|>
>>          clock_pelt   clock_task     clock            now
>>
>> This is especially problematic for asymmetric CPU capacity systems which
>> need stable util_avg signals for task placement and energy estimation.
>>
>> Ideally, this problem would be solved by updating the runqueue clocks
>> before the migration. But that would require taking the runqueue lock
>> which is quite expensive [1]. Instead estimate the missing time and update
>> the task util_avg with that value:
>>
>>    A + B = clock_task - clock_pelt + sched_clock_cpu() - clock
>>
>> sched_clock_cpu() is a costly functinon. Limit the usage to the case where
>> the source CPU is idle as we know this is when the clock is having the
>> biggest risk of being outdated.
>>
>> Neither clock_task, clock_pelt nor clock can be accessed without the
>> runqueue lock. We then need to store those values in a timestamp variable
>> which can be accessed during the migration. rq's enter_idle will give the
>> wall-clock time when the rq went idle. We have then:
>>
>>    B = sched_clock_cpu() - rq->enter_idle.
>>
>> Then, to catch-up the PELT clock scaling (A), two cases:
>>
>>    * !CFS_BANDWIDTH: We can simply use clock_task(). This value is stored
>>      in rq's clock_pelt_idle, before the rq enters idle. The estimated time
>>      is then:
>>
>>        rq->clock_pelt_idle + sched_clock_cpu() - rq->enter_idle.
>>
>>    * CFS_BANDWIDTH: We can't catch-up with clock_task because of the
>>      throttled_clock_task_time offset. cfs_rq's clock_pelt_idle is then
>>      giving the PELT clock when the cfs_rq becomes idle. This gives:
>>
>>        A = rq->clock_pelt_idle - cfs_rq->clock_pelt_idle
> 
> The code calulating A below is not consistent with this. The order is reversed.
> 

Good catch, but this comment is actually correct, the code is not. 
rq->clock_pelt_idle is updated _after_ cfs_rq->clock_pelt_idle. (see
previous email to Vincent)

Thanks,

[...]
