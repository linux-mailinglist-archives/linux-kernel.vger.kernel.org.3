Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076E248ADB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiAKMhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:37:48 -0500
Received: from foss.arm.com ([217.140.110.172]:45706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbiAKMhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:37:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4AC11FB;
        Tue, 11 Jan 2022 04:37:47 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB87E3F774;
        Tue, 11 Jan 2022 04:37:45 -0800 (PST)
Subject: Re: [PATCH v2 1/3] sched/pelt: Don't sync hardly util_sum with
 uti_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al, sachinp@linux.vnet.ibm.com,
        naresh.kamboju@linaro.org
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
 <20211222093802.22357-2-vincent.guittot@linaro.org>
 <9e526482-905c-e759-8aa6-1ff84bb5b2a3@arm.com>
 <CAKfTPtBR3BWCwEaJe0Cq6K5__zNxfU7FFo2f0bpOPkvzxKdiww@mail.gmail.com>
 <8f39d837-2589-4f7b-5232-1ed134fb1ad7@arm.com>
 <CAKfTPtCVD40GiDEG0pnU+k-nwMAh2PSu_OXq4w3k0A0zR4cLpw@mail.gmail.com>
 <f1549032-50f6-e9fc-a7ae-24373352576b@arm.com>
 <CAKfTPtAREuJtj8AuZPwfe_=W7v8J-UOXDWeyBL0-VcKGaTSr5Q@mail.gmail.com>
 <CAKfTPtCgxwK6tYxKK69nBuGwNjsFBbE+WuohmhWJRo++pPKqog@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <50253205-08d9-5ff4-98a9-3aa3bc669a75@arm.com>
Date:   Tue, 11 Jan 2022 13:37:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCgxwK6tYxKK69nBuGwNjsFBbE+WuohmhWJRo++pPKqog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 08:54, Vincent Guittot wrote:
> On Fri, 7 Jan 2022 at 16:21, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>
>> On Fri, 7 Jan 2022 at 12:43, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 05/01/2022 14:57, Vincent Guittot wrote:
>>>> On Wed, 5 Jan 2022 at 14:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>
>>>>> On 04/01/2022 14:42, Vincent Guittot wrote:
>>>>>> On Tue, 4 Jan 2022 at 12:47, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>>>
>>>>>>> On 22/12/2021 10:38, Vincent Guittot wrote:

[...]

>>>> Some of the changes done in PELT signal propagation that replace
>>>> subtracting util_sum  by using util_avg * divider instead, are related
>>>> to other problems with sched group hierarchy and
>>>> throttling/unthrottling. I'm not 100% confident that using fixes tag
>>>> to backport this on stables doesn't need to backport more patches on
>>>> other areas in order to not resurrect old problems. So I wonder if
>>>> it's worth  backporting this on stables
>>>
>>> OK, I see. So only 1c35b07e6d39 (i.e. the util _sum/_avg change in
>>> update_cfs_rq_load_avg() (1)) caused the CPU frequency regression. That
>>> was the reason why I initially suggested to split the patch-set
>>> differently. But you said that you saw the issue also when (1) is fixed.
>>
>> Ok, I think that we were not speaking about the same setup. I wrongly
>> read that you were saying that
>> sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
>> was only needed in update_cfs_rq_load_avg() but not in the other places.
>>
>> But what you said is that we only need the below to fix the perf
>> regression raised by rick ?
>>      r = removed_util;
>>      sub_positive(&sa->util_avg, r);
>>  -   sa->util_sum = sa->util_avg * divider;
>>  +   sub_positive(&sa->util_sum, r * divider);
>>  +   sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
> 
> The test with the code above doesn't trigger any SCHEd_WARN over the
> weekend so it's probably ok to make a dedicated patch for this with
> tag.
> I'm going to prepare a v2

Yes, `sa->X_sum = max_t(u32, sa->X_sum, sa->X_avg * MIN_DIVIDER)` is
needed for all 3 X = [load, runnable, util] in  update_cfs_rq_load_avg()
to not hit the  SCHED_WARN_ON() in cfs_rq_is_decayed().

>> The WARN that I mentioned in my previous email was about not adding
>> the max_t in all 3 places. I rerun some test today and I triggered the
>> WARN after a detach without the max_t line.
>>
>> I can probably isolate the code above in a dedicated patch for the
>> regression raised by Rick and we could consider adding a fixes tag; I
>> will run more tests with only this part during the weekend.
>> That being said, we need to stay consistent in all 3 places where we
>> move or propagate some *_avg. In particular, using  "sa->util_sum =
>> sa->util_avg * divider" has the drawback of filtering the contribution
>> not already accounted for in util_avg and the impact is much larger
>> than expected. It means that  although fixing only
>> update_cfs_rq_load_avg() seems enough for rick's case, some other
>> cases could be impacted by the 2 other places and we need to fixed
>> them now that we have a better view of the root cause

Agreed.
