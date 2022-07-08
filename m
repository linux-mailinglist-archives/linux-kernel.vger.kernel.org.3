Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698F56B6E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiGHKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbiGHKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:11:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C49684EC5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:11:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E521A1063;
        Fri,  8 Jul 2022 03:11:06 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D303B3F66F;
        Fri,  8 Jul 2022 03:11:04 -0700 (PDT)
Message-ID: <063c4695-a9d4-f77a-55a7-7c554b765c7e@arm.com>
Date:   Fri, 8 Jul 2022 12:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched/fair: fix case with reduced capacity CPU
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, david.chen@nutanix.com,
        zhangqiao22@huawei.com
References: <20220702045254.22922-1-vincent.guittot@linaro.org>
 <88fab4b6-8e5c-3a4e-e32b-a0867d51398b@arm.com>
 <CAKfTPtA07H=nkXdyCto9=7Zzixwnu_N_4L-vfn+0ONCQ464biA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtA07H=nkXdyCto9=7Zzixwnu_N_4L-vfn+0ONCQ464biA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 09:17, Vincent Guittot wrote:
> On Thu, 7 Jul 2022 at 18:43, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 02/07/2022 06:52, Vincent Guittot wrote:

[...]

>>> The rework of the load balance has filterd the case when the CPU is

s/filterd/filtered

>>> classified to be fully busy but its capacity is reduced.
>>>
>>> Check if CPU's capacity is reduced while gathering load balance statistics
>>> and classify it group_misfit_task instead of group_fully_busy so we can

enum group_type {

   ...
   /*
    * SD_ASYM_CPUCAPACITY only: One task doesn't fit with CPU's capacity
    * and must be migrated to a more powerful CPU.
    */
   group_misfit_task
   ...

This `SD_ASYM_CPUCAPACITY only:` should be removed now.

[...]

>>> @@ -8798,6 +8798,19 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>>>       return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>>>  }
>>>
>>> +static inline bool
>>> +sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)

minor: Why not `static inline int check_reduced_capacity()` ? All
similar functions like check_cpu_capacity(), check_cpu_capacity() follow
this approach.

[...]

>>> @@ -8851,11 +8865,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>>               if (local_group)
>>>                       continue;
>>>
>>> -             /* Check for a misfit task on the cpu */
>>> -             if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
>>> -                 sgs->group_misfit_task_load < rq->misfit_task_load) {
>>> -                     sgs->group_misfit_task_load = rq->misfit_task_load;
>>> -                     *sg_status |= SG_OVERLOAD;
>>> +             if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
>>> +                     /* Check for a misfit task on the cpu */
>>> +                     if (sgs->group_misfit_task_load < rq->misfit_task_load) {
>>> +                             sgs->group_misfit_task_load = rq->misfit_task_load;
>>> +                             *sg_status |= SG_OVERLOAD;
>>> +                     }
>>> +             } else if ((env->idle != CPU_NOT_IDLE) &&
>>> +                        sched_reduced_capacity(rq, env->sd) &&
>>> +                        (sgs->group_misfit_task_load < load)) {
>>> +                     /* Check for a task running on a CPU with reduced capacity */
>>> +                     sgs->group_misfit_task_load = load;
>>>               }

Minor:

This now has if(A)
              if(B)
	     else if(C && B')

little bit harder to read.

[...]

>> I'm wondering why you've chosen that hybrid approach `group_misfit_task
>> -> migrate_load` and not `group_misfit_task -> migrate_misfit`.
> 
> because, it means enabling the tracking of misfit task on rq at each
> task enqueue/dequeue/tick ...  Then mistfit for heterogeneous platform
> checks max_cpu_capacity what we don't care and will trigger unwanted
> misfit migration for smp

Agreed, rq->misfit_task_load can't be used here.

>> It looks like this `rq->cfs.h_nr_running = 1` case almost (since we
>> check `busiest->nr_running > 1`) always ends up in the load_balance()
>> `if (!ld_moved)` condition and need_active_balance() can return 1 in
>> case `if ((env->idle != CPU_NOT_IDLE) && ...` condition. This leads to
>> active load_balance and this
>>
>> IMHO, the same you can achieve when you would stay with
>> `group_misfit_task -> migrate_misfit`.
>>
>> I think cpu_load(rq) can be used instead of `rq->misfit_task_load` in
>> the migrate_misfit case of find_busiest_queue() too.
> 
> I don't think because you can have a higher cpu_load() but not being misfit

You're right, I forgot about this. Essentially we would need extra state
(e.g. in lb_env) to save which CPU in the busiest group has the misfit.
