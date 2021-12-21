Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9647BFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhLUMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:46:05 -0500
Received: from foss.arm.com ([217.140.110.172]:52192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhLUMqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:46:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01B421FB;
        Tue, 21 Dec 2021 04:46:04 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5B33F774;
        Tue, 21 Dec 2021 04:46:02 -0800 (PST)
Subject: Re: [PATCH 2/4] sched/fair: Decay task PELT values during migration
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, lukasz.luba@arm.com
References: <20211209161159.1596018-1-vincent.donnefort@arm.com>
 <20211209161159.1596018-3-vincent.donnefort@arm.com>
 <daa01574-5d7b-c125-48a9-d1ec7bd1fb64@arm.com>
 <20211220155735.GA51378@ubiquitous>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2551684c-c987-b143-ba69-4fb0c55f61c7@arm.com>
Date:   Tue, 21 Dec 2021 13:46:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220155735.GA51378@ubiquitous>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.21 17:09, Vincent Donnefort wrote:
> On Mon, Dec 20, 2021 at 12:26:23PM +0100, Dietmar Eggemann wrote:
>> On 09.12.21 17:11, Vincent Donnefort wrote:

[...]

>> Why do you use `avg.last_update_time` (lut) of the root cfs_rq here?
>>
>> p's lut was just synced to cfs_rq_of(se)'s lut in
>>
>> migrate_task_rq_fair() (1) -> remove_entity_load_avg() ->
>> sync_entity_load_avg(se) (2)
> 
> Huum, indeed, the estimation is an offset on top of the se's last_update_time,
> which I suppose could be different from the rq's cfs_rq.
> 
> I'll add a sched_entity argument for this function, to use either cfs_rq_of(se)
> or se last_update_time

OK, or an `u64 now or lut`.

[...]

>>>  	} else {
>>> +		remove_entity_load_avg(se);
>>> +
>>>  		/*
>>> -		 * We are supposed to update the task to "current" time, then
>>> -		 * its up to date and ready to go to new CPU/cfs_rq. But we
>>> -		 * have difficulty in getting what current time is, so simply
>>> -		 * throw away the out-of-date time. This will result in the
>>> -		 * wakee task is less decayed, but giving the wakee more load
>>> -		 * sounds not bad.
>>> +		 * Here, the task's PELT values have been updated according to
>>> +		 * the current rq's clock. But if that clock hasn't been
>>> +		 * updated in a while, a substantial idle time will be missed,
>>> +		 * leading to an inflation after wake-up on the new rq.
>>> +		 *
>>> +		 * Estimate the PELT clock lag, and update sched_avg to ensure
>>> +		 * PELT continuity after migration.
>>>  		 */
>>> -		remove_entity_load_avg(&p->se);
>>> +		__update_load_avg_blocked_se(rq_clock_pelt_estimator(rq), se);
>>
>> We do __update_load_avg_blocked_se() now twice for p, 1. in (2) and then
>> in (1) again.
> 
> the first __update_load_avg_blocked_se() ensures the se is aligned with the
> cfs_rq's clock and then, update the "removed" struct accordingly. We couldn't
> use the estimator there, it would break that structure.

You're right. I missed this bit.

Related to this: Looks like on CAS/EAS we don't rely on
remove_entity_load_avg()->sync_entity_load_avg(se) since it is already
called during  select_task_rq().
