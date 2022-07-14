Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71631574926
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbiGNJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiGNJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:36:48 -0400
Received: from mailgw01.horizon.ai (mailgw01.horizon.ai [42.62.85.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6463342F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.ai; s=bj; c=relaxed/simple;
        q=dns/txt; i=@horizon.ai; t=1657791403; x=2521705003;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OJt4NS1MaZe0Gy/eJ5TjQNiRFmcdRAyWJkkG/Fj2eAg=;
        b=cws8Nmsd3iqNBTL56APR0UgeNHVCqOYAIjxRRR8+7ClKsiuOnbFyHxBQArOAZHYY
        Dg1ptMjmM9kJiz58xZS98/tiBu6unvBHAXC36ctgIYjSVGpsWLALs1bZIQPF+Uir
        C1z8ggR3dT8z8xZBf8su6NE8EUS9Uo2VGlEhp7/u8PU=;
X-AuditID: 0a090144-31781700000015ea-32-62cfe3aa1c61
Received: from mailgw01.horizon.ai ( [10.9.15.112])
        by mailgw01.horizon.ai (Anti-spam for msg) with SMTP id 26.94.05610.AA3EFC26; Thu, 14 Jul 2022 17:36:42 +0800 (HKT)
Received: from MBP (10.9.0.13) by exchange004.hobot.cc (10.9.15.112) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Thu, 14 Jul 2022
 17:36:41 +0800
References: <20220714031645.28004-1-schspa@gmail.com>
 <CAJhGHyD=7t+-Env=Wim-3atq=qJg1j5EKiTvsbqhX1xCdi27Wg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Zhaohui Shi <zhaohui.shi@horizon.ai>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
CC:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: Re: [PATCH v3] workqueue: Use active mask for new worker when pool
 is DISASSOCIATED
Date:   Thu, 14 Jul 2022 16:58:46 +0800
In-Reply-To: <CAJhGHyD=7t+-Env=Wim-3atq=qJg1j5EKiTvsbqhX1xCdi27Wg@mail.gmail.com>
Message-ID: <m2tu7kkpcp.fsf@horizon.ai>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.9.0.13]
X-ClientProxiedBy: exchange002.hobot.cc (10.9.15.111) To exchange004.hobot.cc
 (10.9.15.112)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsXCxclfoLvq8fkkg7XfrS0u75rDZnG89wCT
        xa/lRxkdmD02r9Dy2LSqk83j8ya5AOYoLpuU1JzMstQifbsEroxHM+6zFZzQr/g0MayB8aNS
        FyMnh4SAicSbZ7uYuxi5OIQEVjJK9LUsZIdwzjNKXH6zhAmkSkigRmLhyQ42EFtUQFliy575
        7CA2m4CWRP+yv2BxESB7b+dTMJtZIFfi3IbdLCC2sECcxPtzD8HmsAioSqxcdQbM5hQIlPh4
        ZTdYPa+AusTR1z+ZIWxBiZMzn7BAzJGQOPjiBTPEDcoSTVs/M0NcLSvx+eZxNgg7VuJZ03Sm
        CYyCs5C0z0LSvoCRaRWjcG5iZk56uYGhXkZ+UWZVfp5eYuYmRnCIMrrsYPy24KPeIUYmDsZD
        jBIczEoivN2HziUJ8aYkVlalFuXHF5XmpBYfYpTmYFES571kdiRJSCA9sSQ1OzW1ILUIJsvE
        wSnVwNS81JrRkoH/1L1F2/eVstq89jPk/nbh59H+2dF7jRlk9JTKlqrGVcrsuLxw/zp7nz9V
        SobLuLsWT3Mz1kpcsZNFqla1wN3ONsn054rdZ05c5Nc+U7/ns4n94SfMsxasVsle6PrwxoET
        B9zkvAMbax7qit1aI7voeJN059a5O8Kzo7+sZy1R/6u8tUlf28lN9sXKWvO7kTM287P1Lwov
        feCm3nIra5H3qauhUXcK0mLe27L37/hjq7LCftr9FwYiSvZN/bpXSxZ0i6ioObYFn0xcuvFl
        1zfxrD2rjy6KbHxXFWGW/unQ+pjUrcztIUUmyzs7QtmLTtVZGqhz8E65vHzWyTeTNH8Wlkob
        hk5PV2Ipzkg01GIuKk4EAHfavn/AAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lai Jiangshan <jiangshanlai@gmail.com> writes:

> On Thu, Jul 14, 2022 at 11:16 AM Schspa Shi <schspa@gmail.com> wrote:
>>
>> When CPU-[un]hotplugs, all workers will be bound to active CPU via
>> unbind_workers().
>>
>> But the unbound worker still has a chance to create a new worker, which
>> has bound the newly created task to pool->attrs->cpumask. But the CPU has
>> been unplugged.
>>
>> Please refer to the following scenarios.
>>
>>            CPU0                                  CPU1
>> ------------------------------------------------------------------
>> sched_cpu_deactivate(cpu_active_mask clear)
>> workqueue_offline_cpu(work pool POOL_DISASSOCIATED)
>>   -- all worker will migrate to another cpu --
>>                                     worker_thread
>>                                     -- will create new worker if
>>                                        pool->worklist is not empty
>>                                        create_worker()
>>                                      -- new kworker will bound to CPU0
>
> How will the new kworker bound to CPU0?  Could you give more details?
>

It's because we use pool->attrs->cpumask for the newly created worker
to bind it to CPU0.

Please note that the CPU0 marked here does not correspond to the
fault log below, maybe I should change this CPU0 to CPU3, then it
can be correspond to the exception log below.


> Since the pool is POOL_DISASSOCIATED and kthread_is_per_cpu() will
> be false for the new worker. ttwu() will put it on a fallback CPU IIUC
> (see select_task_rq()).
>

It won't put it on a fallback CPU, is_cpu_allowed() will use
cpu_online_mask to check if a kthread can running on this CPU, we
need cpu_active_mask in this case.

see:
static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
{
	...
	/* KTHREAD_IS_PER_CPU is always allowed. */
	if (kthread_is_per_cpu(p))
		return cpu_online(cpu);
	...
}

>>                                (pool->attrs->cpumask will be mask of CPU0).
>>       kworker/0:x will running on rq
>>
>> sched_cpu_dying
>>   if (rq->nr_running != 1 || rq_has_pinned_tasks(rq))
>>     WARN(true, "Dying CPU not properly vacated!");
>>       ---------OOPS-------------
>>
>
>
>> The stack trace of the bad running task was dumped via the following patch:
>> Link: https://lore.kernel.org/all/20220519161125.41144-1-schspa@gmail.com/
>> And I think this debug patch needs to be added to the mainline,
>> it can help us to debug this kind of problem
>>
>> To fix it, we can use cpu_active_mask when work pool is DISASSOCIATED.
>
> use wq_unbound_cpumask.
>

Yes, I forgot to change this.

>>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> Please solo CC Peter, as:
>
> CC: Peter Zijlstra <peterz@infradead.org>
>

OK, thanks for reminding me.

>>
>> --
>>
>> Changelog:
>> v1 -> v2:
>>         - Move worker task bind to worker_attach_to_pool, remove extra
>>         wq_pool_attach_mutex added.
>>         - Add a timing diagram to make this question clearer.
>> v2 -> v3:
>>         - Add missing PF_NO_SETAFFINITY, use cpumask_intersects to
>>         avoid setting bad mask for unbound work pool as Lai Jiangshan
>>         advised.
>>         - Call kthread_set_pre_cpu correctly for unbound worker.
>> ---
>>  kernel/workqueue.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 1ea50f6be843..b3e9289d9640 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1860,8 +1860,16 @@ static struct worker *alloc_worker(int node)
>>  static void worker_attach_to_pool(struct worker *worker,
>>                                    struct worker_pool *pool)
>>  {
>> +       const struct cpumask *cpu_mask;
>> +
>>         mutex_lock(&wq_pool_attach_mutex);
>>
>> +       if (cpumask_intersects(pool->attrs->cpumask, cpu_active_mask))
>> +               cpu_mask = pool->attrs->cpumask;
>> +       else
>> +               cpu_mask = wq_unbound_cpumask;
>> +
>> +       set_cpus_allowed_ptr(worker->task, cpu_mask);
>>         /*
>>          * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>>          * stable across this function.  See the comments above the flag
>> @@ -1870,10 +1878,8 @@ static void worker_attach_to_pool(struct worker *worker,
>>         if (pool->flags & POOL_DISASSOCIATED)
>>                 worker->flags |= WORKER_UNBOUND;
>>         else
>> -               kthread_set_per_cpu(worker->task, pool->cpu);
>> -
>> -       if (worker->rescue_wq)
>> -               set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>> +               kthread_set_per_cpu(worker->task,
>> +                               cpu_mask == wq_unbound_cpumask ? -1 : pool->cpu);
>
> Only workers for percpu pool need to set kthread_set_per_cpu().
> So it is already handled in the above code, the branch is unneeded.
>
Change this to something like fellowing.

	if (pool->flags & POOL_DISASSOCIATED)
		worker->flags |= WORKER_UNBOUND;
	else if (cpu_mask == pool->attrs->cpumask)
    	kthread_set_per_cpu(worker->task, pool->cpu);

I add this because we will set it = -1 on unbind_workers too.
static void unbind_workers(int cpu)
{
	...
			for_each_pool_worker(worker, pool) {
				kthread_set_per_cpu(worker->task, -1);
				WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
			}
    ...
}

>>
>>         list_add_tail(&worker->node, &pool->workers);
>>         worker->pool = pool;
>> @@ -1952,8 +1958,8 @@ static struct worker *create_worker(struct worker_pool *pool)
>>                 goto fail;
>>
>>         set_user_nice(worker->task, pool->attrs->nice);
>> -       kthread_bind_mask(worker->task, pool->attrs->cpumask);
>>
>> +       worker->task->flags |= PF_NO_SETAFFINITY;
>>         /* successful, attach the worker to the pool */
>>         worker_attach_to_pool(worker, pool);
>>
>> --
>> 2.29.0
>>


-- 
BRs
Zhaohui Shi
