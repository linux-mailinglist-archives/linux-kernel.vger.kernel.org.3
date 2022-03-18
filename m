Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E334DDEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiCRQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiCRQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:30:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3442195D8D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:28:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F2C71515;
        Fri, 18 Mar 2022 09:28:46 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7D03F7B4;
        Fri, 18 Mar 2022 09:28:44 -0700 (PDT)
Message-ID: <7c75e5d4-75a2-8ea5-64ad-13794a6036b6@arm.com>
Date:   Fri, 18 Mar 2022 17:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] sched/fair: Refactor cpu_util_without()
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        linux-kernel@vger.kernel.org
References: <20220301171727.812157-1-dietmar.eggemann@arm.com>
 <CAKfTPtD6i7oYZuAMYFmxFnRHETUAgKYV1gxoMiMjSksBs6Z=rg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtD6i7oYZuAMYFmxFnRHETUAgKYV1gxoMiMjSksBs6Z=rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Valentin Schneider <Valentin.Schneider@arm.com>

On 02/03/2022 10:09, Vincent Guittot wrote:
> On Tue, 1 Mar 2022 at 18:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

[...]

> I have only minor comment

Thanks for the review!

[...]

>> +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
>> +{

[...]

>> +       if (sched_feat(UTIL_EST)) {
>> +               util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
>> +
>> +               /*
>> +                * During wake-up, the task isn't enqueued yet and doesn't
>> +                * appear in the cfs_rq->avg.util_est.enqueued of any rq,
>> +                * so just add it (if needed) to "simulate" what will be
>> +                * cpu_util after the task has been enqueued.
>> +                */
>> +               if (dst_cpu == cpu)
>> +                       util_est += _task_util_est(p);
>> +
> 
> Could you add a comment that explains why the addition above will not
> be removed below by the lsub_positive below so it isn't worth trying
> to optimize such a case?

Yes. I rewored the comments in cpu_util_next() so they also apply when
called by cpu_util_without(). And I use a `if{}/else if{}` here too in v2.
>> +               /*
>> +                * Despite the following checks we still have a small window
>> +                * for a possible race, when an execl's select_task_rq_fair()
>> +                * races with LB's detach_task():
>> +                *
>> +                *   detach_task()
>> +                *     p->on_rq = TASK_ON_RQ_MIGRATING;
>> +                *     ---------------------------------- A
>> +                *     deactivate_task()                   \
>> +                *       dequeue_task()                     + RaceTime
>> +                *         util_est_dequeue()              /
>> +                *     ---------------------------------- B
>> +                *
>> +                * The additional check on "current == p" it's required to
>> +                * properly fix the execl regression and it helps in further
>> +                * reducing the chances for the above race.
>> +                */
>> +               if (unlikely(task_on_rq_queued(p) || current == p))
>> +                       lsub_positive(&util_est, _task_util_est(p));

I did a lot of testing on mainline & v4.20 and there wasn't one
occurrence of `p->on_rq == TASK_ON_RQ_MIGRATING` here. Not for WF_EXEC
tasks (p->on_rq = TASK_ON_RQ_QUEUED) and in case of v4.20 not for
WF_EXEC and WF_TTWU tasks (p->on_rq = 0). So I assume it's not needed. I
left it in v2 though and mentioned it in the additional comment section
of the patch.

[...]

>>  static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>>  {

[...]

>>         /*
>>          * Covered cases:
>>          *
>> @@ -6560,82 +6609,8 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>>          *    estimation of the spare capacity on that CPU, by just
>>          *    considering the expected utilization of tasks already
>>          *    runnable on that CPU.
> 
> The comment about the covered cases above should be moved in
> cpu_util_next() which is where the cases are covered now

Yes. I Incorporated it into the comments in cpu_util_next() in v2.

[...]
