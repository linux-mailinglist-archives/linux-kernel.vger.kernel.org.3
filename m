Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B184596EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiHQM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiHQM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:58:45 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926EDFFC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:58:44 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-333b049f231so117013287b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qzxdSQjjr02NBRetfQSUQv3rkuh4VIDYpy88ZPp5xBM=;
        b=E7rtnd+DR6cTcHjkqxluug76p8YoqApiuug4tu2rRcILNlkwHO4z7YKiPepRMxxA73
         jgwMZDQqcPw8agl99ghzM5r2MPty4ekN/fqu25mto1vRdPlQumpKUMdy7MKIXbh9ebNO
         sqZdgLfKAFwfvnfKpjOWYSqwuCuC0mmLtum+vghVwVclt3S2+1k6aQoMoHV4SqNeDLWg
         3hCgC8Csngfgk55pn9Vy2F9aeACbwF3LJg5zjCNmxtsM3GOkMey3wxIOPqMIxEvTmxlN
         dtvRQ8V3J3hicYfXZlbc1jRwNDcHA5hwMw4XN0i5jWgDc7glW75kHcKl8rB08E9J5em6
         u/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qzxdSQjjr02NBRetfQSUQv3rkuh4VIDYpy88ZPp5xBM=;
        b=cG9ZHLG0xd0IjYFPylywiL6fnN1xGPvsxR96Maa+rKfgehghqUrGtWuH7R4Me72UCt
         A44i8tdMdgoiTqJ2JFLHi++lvR2rpl8sR41oUSjI4JCh7fsDevAL28H+lGKUMMbJyodZ
         9mjHhpEEYYCAKTL4Jr9eWDZoYzHYNj3Zxge19p5VOA7CCkPpAKxwUo/CxEHWVzRq3SFv
         tf0zm1GDKhwZjd/zZcLalODoCUGGJVEXeUw/FOYgFEhnORYtkB1BVL+vFzkyKnzXE1+W
         ekFBf4gclPBqtVpKosvpCqx0Ds/Klof5/GBUdgdHgptwbGn0r/s90fRjXJtx5h/LoGjU
         U3fQ==
X-Gm-Message-State: ACgBeo12D7Z+kQ28wO+AJRruYTtSq50n/NLDGVs+dR3SezbT2QIKma4i
        X3IJ+5dWvdvBRgGOBUIO3CYfZl8Rl/EUvsxmJ5r8Ow==
X-Google-Smtp-Source: AA6agR6/spMZUXWUu+x/T84e+GPEtXdjsLH/1QjPg8nGTT9i7O7lZfD+wJYAmGvghJpJA4+gVHWO0QV9hKWCF9xAqoY=
X-Received: by 2002:a25:b849:0:b0:67b:93e9:2acc with SMTP id
 b9-20020a25b849000000b0067b93e92accmr20186718ybm.241.1660741123124; Wed, 17
 Aug 2022 05:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com> <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
 <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com> <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
In-Reply-To: <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 17 Aug 2022 14:58:31 +0200
Message-ID: <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
To:     "zhangsong (J)" <zhangsong34@huawei.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 at 04:53, zhangsong (J) <zhangsong34@huawei.com> wrote:
>
>
> On 2022/8/15 19:03, Abel Wu wrote:
>
> On 8/10/22 3:34 PM, zhangsong (J) Wrote:
>
> Thanks for your reply !
>
> On 2022/8/10 12:02, Abel Wu wrote:
>
> Hi Zhang Song,
>
> On 8/10/22 9:56 AM, zhangsong Wrote:
>
> For co-location with NORMAL and IDLE tasks, when CFS trigger load balance,
> it is reasonable to prefer migrating NORMAL(Latency Sensitive) tasks from
> the busy src CPU to dst CPU, and migrating IDLE tasks lastly.
>
>
> Considering the large weight difference between normal and idle tasks,
> does the re-ordering really change things? It would be helpful if you
> can offer more detailed info.
>
> Please consider the situation that CPU A has several normal tasks and hundreds of idle tasks
> while CPU B is idle, and CPU B needs to pull some tasks from CPU A, but the cfs_tasks in CPU A
> are not in order of priority, and the max number of pulling tasks depends on env->loop_max,
> which value is sysctl_sched_nr_migrate, i.e. 32.
>
>
> The case you elaborated above is really rare, the only possibility I
> can imagine is that all these tasks are affined to one single cpu and
> suddenly remove the affinity constrain. Otherwise, the load balancing
> including wakeup cpu selection logic will make things right.
>
>
> Yes, this is usually a corner case, but suppose that some non-idle tasks bounds to CPU 1-2
>
> and idle tasks bounds to CPU 0-1, so CPU 1 may has many idle tasks and some non-idle
>
> tasks while idle tasks on CPU 1 can not be pulled to CPU 2, when trigger load balance if
>
> CPU 2 should pull some tasks from CPU 1, the bad result is idle tasks of CPU 1 cannot be
>
> migrated and non-idle tasks also cannot be migrated in case of env->loop_max constraint.

env->loop_max adds a break but load_balance will continue with next
tasks so it also tries to pull your non idle task at the end after
several breaks.

>
> This will cause non-idle  tasks cannot achieve  more CPU utilization.

Your problem is not linked to IDLE vs NORMAL tasks but to the large
number of pinned tasks that can't migrate on CPU2. You can end with
the same behavior without using IDLE tasks but only NORMAL tasks.

>
> The testcase is below:
>
> 1) 1000 idle tasks bounds to CPU 0-1 and 10 non-idle tasks bounds to CPU 1-2
>
> 2) Get non-idle tasks performance metrics with perf tool
>
>
> Without this patch:
>
>           6,930.88 msec cpu-clock                 #    1.385 CPUs utilized
>             21,458      context-switches          #    0.003 M/sec
>                  1      cpu-migrations            #    0.000 K/sec
>                  0      page-faults               #    0.000 K/sec
>     13,761,631,912      cycles                    #    1.986 GHz
>      6,646,844,169      instructions              #    0.48  insn per cycle
>      2,188,053,035      branches                  #  315.696 M/sec
>          1,690,507      branch-misses             #    0.08% of all branches
>
>        5.002701004 seconds time elapsed
>
>
> With this patch:
>
>           8,103.47 msec cpu-clock                 #    1.620 CPUs utilized
>             25,358      context-switches          #    0.003 M/sec
>                318      cpu-migrations            #    0.039 K/sec
>                  0      page-faults               #    0.000 K/sec
>     15,707,367,741      cycles                    #    1.938 GHz
>      7,618,354,166      instructions              #    0.49  insn per cycle
>      2,506,951,511      branches                  #  309.367 M/sec
>          2,017,301      branch-misses             #    0.08% of all branches
>
>        5.002151474 seconds time elapsed
>
>
>
> From above test result comparsion, we can see that non-idle tasks CPU utilization can improve 10%+.
>
>
>
> We now cannot guarantee that CPU B can pull a certain number of normal tasks instead of idle tasks
> from the waiting queue of CPU A, so It is necessary to divide cfs_tasks into two different lists
> and ensure that tasks in none-idle list can be migrated first.
>
>
> Yes, there is no guarantee. And I think your problem is valid (although
> rare), while turning cfs_tasks into weight-sorted might be helpful?
>
>
> I think turning cfs_tasks into weight-sorted may be more complex, this will
>
> change current data structure of cfs_tasks, it will be less helpful.
>
> Thanks a lot.
>
>
>
>
> ...
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3034,6 +3034,21 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
>     #endif /* CONFIG_NUMA_BALANCING */
>   +#ifdef CONFIG_SMP
> +static void
> +adjust_rq_cfs_tasks(void (*list_op)(struct list_head *, struct list_head *),
> +    struct rq *rq,
> +    struct sched_entity *se)
> +{
> +    struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +    if (task_has_idle_policy(task_of(se)) || tg_is_idle(cfs_rq->tg))
>
>
> The tg_is_idle() doesn't have hierarchical judgement on parent task
> groups, while rq->cfs{,_idle}_tasks is rq wide. Say A->B where tgA
> is idle and tgB isn't, a task from B will be added to the non-idle
> list, is this what you want?
>
> The tg_is_idle is used to check whether the task group of se is idle.
> I think it is unlikely that the parent group is idle but the child group is none-idle.
> If it happens, the current load balance policy yet not be affected.
>
>
> It's quite common that an idle group contains several non-idle groups,
> and it is so designed. In this case with your patch, tgB's tasks will
> be wrongly put to the rq->cfs_tasks list.
>
>
> OK, I agree it, this task idle judgement may be modified to below:
>
> static int task_h_idle(struct task_struct *p)
> {
>     struct sched_entity *se = &p->se;
>
>     if (task_has_idle_policy(p))
>         return 1;
>
>     for_each_sched_entity(se)
>         if (cfs_rq_is_idle(cfs_rq_of(se)))
>             return 1;
>
>     return 0;
> }
>
>
> What do you think of above modify?
>
>
>
>
> + (*list_op)(&se->group_node, &rq->cfs_idle_tasks);
> +    else
> +        (*list_op)(&se->group_node, &rq->cfs_tasks);
> +}
> +#endif
> +
>   static void
>   account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   {
> @@ -3043,7 +3058,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>           struct rq *rq = rq_of(cfs_rq);
>             account_numa_enqueue(rq, task_of(se));
> -        list_add(&se->group_node, &rq->cfs_tasks);
> +        adjust_rq_cfs_tasks(list_add, rq, se);
>       }
>   #endif
>       cfs_rq->nr_running++;
> @@ -7465,7 +7480,7 @@ done: __maybe_unused;
>        * the list, so our cfs_tasks list becomes MRU
>        * one.
>        */
> -    list_move(&p->se.group_node, &rq->cfs_tasks);
> +    adjust_rq_cfs_tasks(list_move, rq, &p->se);
>   #endif
>         if (hrtick_enabled_fair(rq))
> @@ -7788,6 +7803,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>       if (unlikely(task_has_idle_policy(p)))
>           return 0;
>   +    if (tg_is_idle(cfs_rq_of(&p->se)->tg))
> +        return 0;
> +
>
>
> Same as above. But I am not sure this is the right way to do it. We
> still want to maintain policy behavior inside an idle task group.
>
> Actually, we do not change the policy behavior of idle task group.
> We only want to ensure migration prioritily when load balance
> pulling/pushing tasks between CPUs.
>
>
> But the tasks from idle tg could still be SCHED_NORMAL.
>
>
> Yes you are right, please see above reply.
>
>
>
>
>       /* SMT siblings share cache */
>       if (env->sd->flags & SD_SHARE_CPUCAPACITY)
>           return 0;
> @@ -7800,6 +7818,11 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>                &p->se == cfs_rq_of(&p->se)->last))
>           return 1;
>   +    /* Preempt sched idle cpu do not consider migration cost */
> +    if (cpus_share_cache(env->src_cpu, env->dst_cpu) &&
> +        sched_idle_cpu(env->dst_cpu))
> +        return 0;
> +
>       if (sysctl_sched_migration_cost == -1)
>           return 1;
>   @@ -7990,11 +8013,14 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
>   static struct task_struct *detach_one_task(struct lb_env *env)
>   {
>       struct task_struct *p;
> +    struct list_head *tasks = &env->src_rq->cfs_tasks;
> +    int loop = 0;
>
>
> Maybe a boolean variable is enough (and more readable)?
>
> Thanks,
> Abel
>
> OK, let me think more about how to define it an appropriate variable.
>
>
> lockdep_assert_rq_held(env->src_rq);
>   +again:
>       list_for_each_entry_reverse(p,
> -            &env->src_rq->cfs_tasks, se.group_node) {
> +            tasks, se.group_node) {
>           if (!can_migrate_task(p, env))
>               continue;
>   @@ -8009,6 +8035,10 @@ static struct task_struct *detach_one_task(struct lb_env *env)
>           schedstat_inc(env->sd->lb_gained[env->idle]);
>           return p;
>       }
> +    if (++loop == 1) {
> +        tasks = &env->src_rq->cfs_idle_tasks;
> +        goto again;
> +    }
>       return NULL;
>   }
>   @@ -8026,6 +8056,7 @@ static int detach_tasks(struct lb_env *env)
>       unsigned long util, load;
>       struct task_struct *p;
>       int detached = 0;
> +    int loop = 0;
>         lockdep_assert_rq_held(env->src_rq);
>   @@ -8041,6 +8072,7 @@ static int detach_tasks(struct lb_env *env)
>       if (env->imbalance <= 0)
>           return 0;
>   +again:
>       while (!list_empty(tasks)) {
>           /*
>            * We don't want to steal all, otherwise we may be treated likewise,
> @@ -8142,6 +8174,11 @@ static int detach_tasks(struct lb_env *env)
>           list_move(&p->se.group_node, tasks);
>       }
>   +    if (env->imbalance > 0 && ++loop == 1) {
> +        tasks = &env->src_rq->cfs_idle_tasks;
> +        goto again;
> +    }
> +
>       /*
>        * Right now, this is one of only two places we collect this stat
>        * so we can safely collect detach_one_task() stats here rather
> @@ -11643,7 +11680,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>            * Move the next running task to the front of the list, so our
>            * cfs_tasks list becomes MRU one.
>            */
> -        list_move(&se->group_node, &rq->cfs_tasks);
> +        adjust_rq_cfs_tasks(list_move, rq, se);
>       }
>   #endif
>   diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e26688d387ae..accb4eea9769 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1068,6 +1068,7 @@ struct rq {
>       int            online;
>         struct list_head cfs_tasks;
> +    struct list_head cfs_idle_tasks;
>         struct sched_avg    avg_rt;
>       struct sched_avg    avg_dl;
>
> .
>
> .
