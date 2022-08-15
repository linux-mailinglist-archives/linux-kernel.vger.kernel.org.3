Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5304E592DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiHOLEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiHOLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:04:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4305237F3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:03:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so6237300pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nATPCNom0yVvpeM+DRgV1QA3mx4Mni9i8tAQqyW/53U=;
        b=tmKifQYia4vLY7VbqWVM8Yiwe5NsCMi4pDyzBqR9L/hwsst/oNkTNvm8S92wNl+Wg9
         R/f65dv7GNJTAzISMYeoNVpV5Ic74Vwc8KOAk/iLADccAb4odPgkOxSlUKUEeXyu7FaN
         ipoiOD+MVt0QPcoo0FsPRubkGXvk8cGYi/CKLgY5RYyEIFbUlauMl6BOPR+pWv+l5dW4
         mnS4VICw/u1YQEU1VPs3p5tav30aHucQU7fuv1FvUyb5eK09muL61x0XF2YqPWs8822B
         C40RDQsitq8ped0+eo0y9/EGDAPjkrA8LuHfEa/A3qNXdCvCZ2HWcEN3xGYrN7vF6u+q
         auTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nATPCNom0yVvpeM+DRgV1QA3mx4Mni9i8tAQqyW/53U=;
        b=isSjhMzf2DYY30B0JykwUPofemQ3nnkeVHJoykZiCSHaAR/dqR3i7+IQvMiWu/Vo65
         L7V69v9CdYPmz4hndTf840V83UzdSVf/RkF1k+hNnU73PGw8OL0m2bkwmGN+2vrkFoa4
         LKPIdGEh78GIzLIn5cHsKIV0ilIEyzTKg2SYUDddq3/XKe4/5DagI937sVvVko9DWTlV
         l20oC/MGfTdBWjq+iDDveEzyPZ6GkjvpxldRVJOccYaJyuChVDzhi2CsmVtqESYB/rpv
         aS/ctvpDFcgL+NKdopfUk8KDaiihVgU4ISj6+rzamIYQbgOtXItpxU5dFI8rH913ssCa
         LD0g==
X-Gm-Message-State: ACgBeo3sRaaCy0vS0T4P4hVBBsAyDfQwhif/FyaO66319A0EBCaCLUGL
        g4Y2PF2UtcJpijW7BcBxiR2v0g==
X-Google-Smtp-Source: AA6agR4YNRhgiJUvN1wT4r3rzNsisEsqWAhmoF01tFSALCwFrbfkONJoTmFrent3fAEmSaAEVkuVBQ==
X-Received: by 2002:a62:5f06:0:b0:52e:f3a3:ffee with SMTP id t6-20020a625f06000000b0052ef3a3ffeemr16071050pfb.79.1660561416202;
        Mon, 15 Aug 2022 04:03:36 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b00170a359eb0esm6827128plg.63.2022.08.15.04.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 04:03:36 -0700 (PDT)
Message-ID: <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com>
Date:   Mon, 15 Aug 2022 19:03:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
Content-Language: en-US
To:     "zhangsong (J)" <zhangsong34@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com>
 <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 3:34 PM, zhangsong (J) Wrote:
> Thanks for your reply !
> 
> On 2022/8/10 12:02, Abel Wu wrote:
>> Hi Zhang Song,
>>
>> On 8/10/22 9:56 AM, zhangsong Wrote:
>>> For co-location with NORMAL and IDLE tasks, when CFS trigger load 
>>> balance,
>>> it is reasonable to prefer migrating NORMAL(Latency Sensitive) tasks 
>>> from
>>> the busy src CPU to dst CPU, and migrating IDLE tasks lastly.
>>
>> Considering the large weight difference between normal and idle tasks,
>> does the re-ordering really change things? It would be helpful if you
>> can offer more detailed info.
> Please consider the situation that CPU A has several normal tasks and 
> hundreds of idle tasks
> while CPU B is idle, and CPU B needs to pull some tasks from CPU A, but 
> the cfs_tasks in CPU A
> are not in order of priority, and the max number of pulling tasks 
> depends on env->loop_max,
> which value is sysctl_sched_nr_migrate, i.e. 32.

The case you elaborated above is really rare, the only possibility I
can imagine is that all these tasks are affined to one single cpu and
suddenly remove the affinity constrain. Otherwise, the load balancing
including wakeup cpu selection logic will make things right.

> We now cannot guarantee that CPU B can pull a certain number of normal 
> tasks instead of idle tasks
> from the waiting queue of CPU A, so It is necessary to divide cfs_tasks 
> into two different lists
> and ensure that tasks in none-idle list can be migrated first.

Yes, there is no guarantee. And I think your problem is valid (although
rare), while turning cfs_tasks into weight-sorted might be helpful?

>>
>>> ...
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -3034,6 +3034,21 @@ static inline void update_scan_period(struct 
>>> task_struct *p, int new_cpu)
>>>     #endif /* CONFIG_NUMA_BALANCING */
>>>   +#ifdef CONFIG_SMP
>>> +static void
>>> +adjust_rq_cfs_tasks(void (*list_op)(struct list_head *, struct 
>>> list_head *),
>>> +    struct rq *rq,
>>> +    struct sched_entity *se)
>>> +{
>>> +    struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>> +
>>> +    if (task_has_idle_policy(task_of(se)) || tg_is_idle(cfs_rq->tg))
>>
>> The tg_is_idle() doesn't have hierarchical judgement on parent task
>> groups, while rq->cfs{,_idle}_tasks is rq wide. Say A->B where tgA
>> is idle and tgB isn't, a task from B will be added to the non-idle
>> list, is this what you want?
> The tg_is_idle is used to check whether the task group of se is idle.
> I think it is unlikely that the parent group is idle but the child group 
> is none-idle.
> If it happens, the current load balance policy yet not be affected.

It's quite common that an idle group contains several non-idle groups,
and it is so designed. In this case with your patch, tgB's tasks will
be wrongly put to the rq->cfs_tasks list.

>>
>>> + (*list_op)(&se->group_node, &rq->cfs_idle_tasks);
>>> +    else
>>> +        (*list_op)(&se->group_node, &rq->cfs_tasks);
>>> +}
>>> +#endif
>>> +
>>>   static void
>>>   account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>   {
>>> @@ -3043,7 +3058,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, 
>>> struct sched_entity *se)
>>>           struct rq *rq = rq_of(cfs_rq);
>>>             account_numa_enqueue(rq, task_of(se));
>>> -        list_add(&se->group_node, &rq->cfs_tasks);
>>> +        adjust_rq_cfs_tasks(list_add, rq, se);
>>>       }
>>>   #endif
>>>       cfs_rq->nr_running++;
>>> @@ -7465,7 +7480,7 @@ done: __maybe_unused;
>>>        * the list, so our cfs_tasks list becomes MRU
>>>        * one.
>>>        */
>>> -    list_move(&p->se.group_node, &rq->cfs_tasks);
>>> +    adjust_rq_cfs_tasks(list_move, rq, &p->se);
>>>   #endif
>>>         if (hrtick_enabled_fair(rq))
>>> @@ -7788,6 +7803,9 @@ static int task_hot(struct task_struct *p, 
>>> struct lb_env *env)
>>>       if (unlikely(task_has_idle_policy(p)))
>>>           return 0;
>>>   +    if (tg_is_idle(cfs_rq_of(&p->se)->tg))
>>> +        return 0;
>>> +
>>
>> Same as above. But I am not sure this is the right way to do it. We
>> still want to maintain policy behavior inside an idle task group.
> Actually, we do not change the policy behavior of idle task group.
> We only want to ensure migration prioritily when load balance
> pulling/pushing tasks between CPUs.

But the tasks from idle tg could still be SCHED_NORMAL.

>>
>>>       /* SMT siblings share cache */
>>>       if (env->sd->flags & SD_SHARE_CPUCAPACITY)
>>>           return 0;
>>> @@ -7800,6 +7818,11 @@ static int task_hot(struct task_struct *p, 
>>> struct lb_env *env)
>>>                &p->se == cfs_rq_of(&p->se)->last))
>>>           return 1;
>>>   +    /* Preempt sched idle cpu do not consider migration cost */
>>> +    if (cpus_share_cache(env->src_cpu, env->dst_cpu) &&
>>> +        sched_idle_cpu(env->dst_cpu))
>>> +        return 0;
>>> +
>>>       if (sysctl_sched_migration_cost == -1)
>>>           return 1;
>>>   @@ -7990,11 +8013,14 @@ static void detach_task(struct task_struct 
>>> *p, struct lb_env *env)
>>>   static struct task_struct *detach_one_task(struct lb_env *env)
>>>   {
>>>       struct task_struct *p;
>>> +    struct list_head *tasks = &env->src_rq->cfs_tasks;
>>> +    int loop = 0;
>>
>> Maybe a boolean variable is enough (and more readable)?
>>
>> Thanks,
>> Abel
> OK, let me think more about how to define it an appropriate variable.
>>
>>> lockdep_assert_rq_held(env->src_rq);
>>>   +again:
>>>       list_for_each_entry_reverse(p,
>>> -            &env->src_rq->cfs_tasks, se.group_node) {
>>> +            tasks, se.group_node) {
>>>           if (!can_migrate_task(p, env))
>>>               continue;
>>>   @@ -8009,6 +8035,10 @@ static struct task_struct 
>>> *detach_one_task(struct lb_env *env)
>>>           schedstat_inc(env->sd->lb_gained[env->idle]);
>>>           return p;
>>>       }
>>> +    if (++loop == 1) {
>>> +        tasks = &env->src_rq->cfs_idle_tasks;
>>> +        goto again;
>>> +    }
>>>       return NULL;
>>>   }
>>>   @@ -8026,6 +8056,7 @@ static int detach_tasks(struct lb_env *env)
>>>       unsigned long util, load;
>>>       struct task_struct *p;
>>>       int detached = 0;
>>> +    int loop = 0;
>>>         lockdep_assert_rq_held(env->src_rq);
>>>   @@ -8041,6 +8072,7 @@ static int detach_tasks(struct lb_env *env)
>>>       if (env->imbalance <= 0)
>>>           return 0;
>>>   +again:
>>>       while (!list_empty(tasks)) {
>>>           /*
>>>            * We don't want to steal all, otherwise we may be treated 
>>> likewise,
>>> @@ -8142,6 +8174,11 @@ static int detach_tasks(struct lb_env *env)
>>>           list_move(&p->se.group_node, tasks);
>>>       }
>>>   +    if (env->imbalance > 0 && ++loop == 1) {
>>> +        tasks = &env->src_rq->cfs_idle_tasks;
>>> +        goto again;
>>> +    }
>>> +
>>>       /*
>>>        * Right now, this is one of only two places we collect this stat
>>>        * so we can safely collect detach_one_task() stats here rather
>>> @@ -11643,7 +11680,7 @@ static void set_next_task_fair(struct rq *rq, 
>>> struct task_struct *p, bool first)
>>>            * Move the next running task to the front of the list, so our
>>>            * cfs_tasks list becomes MRU one.
>>>            */
>>> -        list_move(&se->group_node, &rq->cfs_tasks);
>>> +        adjust_rq_cfs_tasks(list_move, rq, se);
>>>       }
>>>   #endif
>>>   diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index e26688d387ae..accb4eea9769 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -1068,6 +1068,7 @@ struct rq {
>>>       int            online;
>>>         struct list_head cfs_tasks;
>>> +    struct list_head cfs_idle_tasks;
>>>         struct sched_avg    avg_rt;
>>>       struct sched_avg    avg_dl;
>> .
