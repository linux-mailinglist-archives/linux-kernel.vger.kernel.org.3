Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ADD5680B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiGFIDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiGFIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:03:36 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8279EBF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:03:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VIXWrKl_1657094606;
Received: from 30.97.49.75(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VIXWrKl_1657094606)
          by smtp.aliyun-inc.com;
          Wed, 06 Jul 2022 16:03:27 +0800
Message-ID: <8e08efa8-3e64-03b1-fc83-d7fc4babe061@linux.alibaba.com>
Date:   Wed, 6 Jul 2022 16:03:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] sched/core: Make tasks with the same cookie pairs on
 SMT siblings
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1656403045-100840-4-git-send-email-CruzZhao@linux.alibaba.com>
 <YsK2OovozB2XJ9Cl@hirez.programming.kicks-ass.net>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <YsK2OovozB2XJ9Cl@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/7/4 下午5:43, Peter Zijlstra 写道:
> On Tue, Jun 28, 2022 at 03:57:25PM +0800, Cruz Zhao wrote:
>> If the number of tasks in the runqueue of SMT siblings are equal, we call
>> the core balanced, otherwise unbalanced. If the core is balanced, everytime
>> we pick next task, we can pick a pair of tasks with the same cookie for
>> each SMT sibling, and forceidle will be avoided.
>>
>>  - Migrate the task if source core and destination core can balance
>>      If ck->nr_running of src_cpu is the highest among the source core, and
>>      ck->nr_running of dst_cpu is the lowest among the destination core,
>>      migrate the task.
>>
>>  - Select cookie matched idle CPU or idle CPU with the lowest
>>    ck->nr_running among the core
>>      In the fast path of task wakeup, if ck->nr_running of the cpu is the
>>      lowest among the core, we can select this cpu to wake up.
>>
>>  - Find cookie matched idlest CPU or cookie matched CPU with the lowest
>>    ck->nr_running among the core
>>      In the slow path of task wakeup, if ck->nr_running of the cpu is the
>>      lowest among the core, we can select this cpu to wake up.
>>
>> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
>> ---
>>  kernel/sched/fair.c  |  4 ++--
>>  kernel/sched/sched.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>  2 files changed, 61 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 78795a9..c18a716 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6096,7 +6096,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>>  	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
>>  		struct rq *rq = cpu_rq(i);
>>  
>> -		if (!sched_core_cookie_match(rq, p))
>> +		if (!sched_core_cookie_match(NULL, rq, p))
>>  			continue;
>>  
>>  		if (sched_idle_cpu(i))
>> @@ -7681,7 +7681,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>>  	 * Don't migrate task if the task's cookie does not match
>>  	 * with the destination CPU's core cookie.
>>  	 */
>> -	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
>> +	if (!(sched_core_cookie_match(env->src_rq, env->dst_rq, p)))
>>  		return 1;
> 
> superfluous () added.
> 
>>  
>>  	if (sysctl_sched_migration_cost == 0)
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index d852c67..ee0e558 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1195,6 +1195,56 @@ struct sched_core_cookie {
>>  };
>>  
>>  /*
>> + * When tasks with the same cookie can make pairs on SMT siblings, forceidle can be
>> + * avoided a lot, so when wake up and load balance, we try to make and keep the pairs
>> + * with the same cookie on SMT siblings.
>> + */
>> +static inline bool
>> +sched_core_make_pair_balance(struct rq *src_rq, struct rq *dst_rq, struct task_struct *p)
>> +{
>> +	struct sched_core_cookie *ck = (struct sched_core_cookie *)p->core_cookie;
>> +	unsigned int src_cpu, dst_cpu, t;
>> +	unsigned int src_nr_running, dst_nr_running;
>> +
>> +	if (!ck)
>> +		return true;
>> +
>> +	/*
>> +	 * When load balance, if ck->nr_running on src_cpu is less than that on SMT
>> +	 * siblings, don't migrate the task.
>> +	 */
>> +	if (src_rq) {
>> +		if (!sched_core_enabled(src_rq))
>> +			return true;
>> +		src_cpu = cpu_of(src_rq);
>> +		src_nr_running = *per_cpu_ptr(ck->nr_running, src_cpu);
>> +		for_each_cpu(t, cpu_smt_mask(src_cpu)) {
>> +			if (t == src_cpu)
>> +				continue;
>> +			if (*per_cpu_ptr(ck->nr_running, t) >= src_nr_running)
>> +				return false;
>> +		}
>> +
>> +	}
>> +
>> +	/*
>> +	 * If task p can make pair the cookied task with p->core_cookie on the
>> +	 * dst core, we can wake up task p on dst_rq, or migrate it to dst_rq.
>> +	 */
>> +	dst_cpu = cpu_of(dst_rq);
>> +	dst_nr_running = *per_cpu_ptr(ck->nr_running, dst_cpu);
>> +	for_each_cpu(t, cpu_smt_mask(dst_cpu)) {
>> +		if (t == dst_cpu)
>> +			continue;
>> +		if (*per_cpu_ptr(ck->nr_running, t) <= dst_nr_running)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
> 
> I don't see how this doesn't destroy regular load balancing.
> Specifically the case where there are very few tasks of each cookie.

If sched_core_make_pair_balance() returns true, we choose cpu_of(dst_rq)
as backup, and in the case of there is no idle or cookie matched CPU, we
choose backup to wakeup or migrate to. If there are more than one backup
CPU, we choose the most unbalanced one. Is this solution more reasonable？

Many thanks for reviewing.
Best wishes,
Cruz Zhao
