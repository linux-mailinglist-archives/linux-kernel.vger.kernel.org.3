Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4C58E5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiHJECR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiHJECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:02:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5B6FA06
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:02:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b133so12594194pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JFsV/GakC2wCXshzhvkL3vkjWivoxqwQd4pmVCTfwSA=;
        b=qFPIbkgtwMvIDpJwpk8L2oynawJJqEV5+bLFKdedIPZ6qKy26PJOKWU4ehpHbph1NA
         uJ+ilviOdHHBHa2sH/gWSwJmpDqAwjZpjZ/5AWAxvlEWZqQW6Kgia6n44LK4Z0U79b4W
         53493Skkv/ysZIu56oYi+6XdC4oiLO/KGJpgrd3lC+SmRoPp1KDessU3MCHIaw6g/czi
         ThruAfXu8xU4LXJc3Totl2L3atrw+fV7FS3Xf7Z47XgUP/8JNKHa7aaspwKI/u3IWN0+
         uIrDIJ6yhWWf/BT28x+sRy9g04lV+5A1oKLbmbY+uMMqccfbjx0wwIlljnqnJJO5RdCV
         FmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JFsV/GakC2wCXshzhvkL3vkjWivoxqwQd4pmVCTfwSA=;
        b=QmW9mDbQnqJhlK7oroMpeFw5Sljhk9hC+6KcVEGXvcwFSlr52LgSgOPz9c46LI6dz5
         iWoDg52xec/epwcX5n6eai5AQEiv93YOZCJHplouX71VvODlk4UEbRc1v1a2lnFBYr1Z
         Pw9bP51RQL41w64PYWp1Omp8FZmoUaY9v6I1DwufKPpu9OWNpvduQlR67AHml4RTa0lt
         DhfvzUns0ONVe5mgLfPp8DBNlj/WcElLVyEMLQsE8Vc+pygSd+4sNmQTvHJxRRBy1gbG
         DEepGt0mvNFf8FXgodhmPQPHyPp9gfYO8YCRjZy7pAJ/RlQygqa5uYVglvrlQGzCXt0v
         8wsA==
X-Gm-Message-State: ACgBeo1obX44IUMLoqYXfWzoUuimDYOMhm2H3e3CF+Vr5aJUl4pRLiSf
        YvJnqukUv8bKG/IBicgBSRm9vg==
X-Google-Smtp-Source: AA6agR5lzfd0MO1x+0girLwZUpq9fAjqkGKIBhV65MRVvTY82nsOLroq/HQpyMNXRlA8eHsbKwcnGA==
X-Received: by 2002:a63:1b03:0:b0:41d:c914:d5ba with SMTP id b3-20020a631b03000000b0041dc914d5bamr4156027pgb.536.1660104131848;
        Tue, 09 Aug 2022 21:02:11 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b0016b90620910sm11863825plg.71.2022.08.09.21.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 21:02:11 -0700 (PDT)
Message-ID: <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com>
Date:   Wed, 10 Aug 2022 12:02:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
Content-Language: en-US
To:     zhangsong <zhangsong34@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220810015636.3865248-1-zhangsong34@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang Song,

On 8/10/22 9:56 AM, zhangsong Wrote:
> For co-location with NORMAL and IDLE tasks, when CFS trigger load balance,
> it is reasonable to prefer migrating NORMAL(Latency Sensitive) tasks from
> the busy src CPU to dst CPU, and migrating IDLE tasks lastly.

Considering the large weight difference between normal and idle tasks,
does the re-ordering really change things? It would be helpful if you
can offer more detailed info.

> 
> This is very important for reducing interference from IDLE tasks.
> So the CFS load balance can be optimized to below:
> 
> 1.`cfs_tasks` list of CPU rq is owned by NORMAL tasks.
> 2.`cfs_idle_tasks` list of CPU rq which is owned by IDLE tasks.
> 3.Prefer to migrate NORMAL tasks of cfs_tasks to dst CPU.
> 4.Lastly migrate IDLE tasks of cfs_idle_tasks to dst CPU.
> 
> This was tested with the following reproduction:
> - small number of NORMAL tasks colocated with a large number of IDLE tasks
> 
> With this patch, NORMAL tasks latency can be reduced
> about 5~10% compared with current.
> 
> Signed-off-by: zhangsong <zhangsong34@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>

The Reported-by tag is usually used for reporting a bug in the mainline
kernel, and build error of your patch is not one of them :)

> ---
> V1->V2:
> - fix build test error
> ---
>   kernel/sched/core.c  |  1 +
>   kernel/sched/fair.c  | 45 ++++++++++++++++++++++++++++++++++++++++----
>   kernel/sched/sched.h |  1 +
>   3 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ee28253c9ac0..7325c6e552d8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9733,6 +9733,7 @@ void __init sched_init(void)
>   		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
>   
>   		INIT_LIST_HEAD(&rq->cfs_tasks);
> +		INIT_LIST_HEAD(&rq->cfs_idle_tasks);
>   
>   		rq_attach_root(rq, &def_root_domain);
>   #ifdef CONFIG_NO_HZ_COMMON
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 914096c5b1ae..b62bec5b1eb9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3034,6 +3034,21 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
>   
>   #endif /* CONFIG_NUMA_BALANCING */
>   
> +#ifdef CONFIG_SMP
> +static void
> +adjust_rq_cfs_tasks(void (*list_op)(struct list_head *, struct list_head *),
> +	struct rq *rq,
> +	struct sched_entity *se)
> +{
> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +	if (task_has_idle_policy(task_of(se)) || tg_is_idle(cfs_rq->tg))

The tg_is_idle() doesn't have hierarchical judgement on parent task
groups, while rq->cfs{,_idle}_tasks is rq wide. Say A->B where tgA
is idle and tgB isn't, a task from B will be added to the non-idle
list, is this what you want?

> +		(*list_op)(&se->group_node, &rq->cfs_idle_tasks);
> +	else
> +		(*list_op)(&se->group_node, &rq->cfs_tasks);
> +}
> +#endif
> +
>   static void
>   account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   {
> @@ -3043,7 +3058,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   		struct rq *rq = rq_of(cfs_rq);
>   
>   		account_numa_enqueue(rq, task_of(se));
> -		list_add(&se->group_node, &rq->cfs_tasks);
> +		adjust_rq_cfs_tasks(list_add, rq, se);
>   	}
>   #endif
>   	cfs_rq->nr_running++;
> @@ -7465,7 +7480,7 @@ done: __maybe_unused;
>   	 * the list, so our cfs_tasks list becomes MRU
>   	 * one.
>   	 */
> -	list_move(&p->se.group_node, &rq->cfs_tasks);
> +	adjust_rq_cfs_tasks(list_move, rq, &p->se);
>   #endif
>   
>   	if (hrtick_enabled_fair(rq))
> @@ -7788,6 +7803,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>   	if (unlikely(task_has_idle_policy(p)))
>   		return 0;
>   
> +	if (tg_is_idle(cfs_rq_of(&p->se)->tg))
> +		return 0;
> +

Same as above. But I am not sure this is the right way to do it. We
still want to maintain policy behavior inside an idle task group.

>   	/* SMT siblings share cache */
>   	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
>   		return 0;
> @@ -7800,6 +7818,11 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>   			 &p->se == cfs_rq_of(&p->se)->last))
>   		return 1;
>   
> +	/* Preempt sched idle cpu do not consider migration cost */
> +	if (cpus_share_cache(env->src_cpu, env->dst_cpu) &&
> +	    sched_idle_cpu(env->dst_cpu))
> +		return 0;
> +
>   	if (sysctl_sched_migration_cost == -1)
>   		return 1;
>   
> @@ -7990,11 +8013,14 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
>   static struct task_struct *detach_one_task(struct lb_env *env)
>   {
>   	struct task_struct *p;
> +	struct list_head *tasks = &env->src_rq->cfs_tasks;
> +	int loop = 0;

Maybe a boolean variable is enough (and more readable)?

Thanks,
Abel

>   
>   	lockdep_assert_rq_held(env->src_rq);
>   
> +again:
>   	list_for_each_entry_reverse(p,
> -			&env->src_rq->cfs_tasks, se.group_node) {
> +			tasks, se.group_node) {
>   		if (!can_migrate_task(p, env))
>   			continue;
>   
> @@ -8009,6 +8035,10 @@ static struct task_struct *detach_one_task(struct lb_env *env)
>   		schedstat_inc(env->sd->lb_gained[env->idle]);
>   		return p;
>   	}
> +	if (++loop == 1) {
> +		tasks = &env->src_rq->cfs_idle_tasks;
> +		goto again;
> +	}
>   	return NULL;
>   }
>   
> @@ -8026,6 +8056,7 @@ static int detach_tasks(struct lb_env *env)
>   	unsigned long util, load;
>   	struct task_struct *p;
>   	int detached = 0;
> +	int loop = 0;
>   
>   	lockdep_assert_rq_held(env->src_rq);
>   
> @@ -8041,6 +8072,7 @@ static int detach_tasks(struct lb_env *env)
>   	if (env->imbalance <= 0)
>   		return 0;
>   
> +again:
>   	while (!list_empty(tasks)) {
>   		/*
>   		 * We don't want to steal all, otherwise we may be treated likewise,
> @@ -8142,6 +8174,11 @@ static int detach_tasks(struct lb_env *env)
>   		list_move(&p->se.group_node, tasks);
>   	}
>   
> +	if (env->imbalance > 0 && ++loop == 1) {
> +		tasks = &env->src_rq->cfs_idle_tasks;
> +		goto again;
> +	}
> +
>   	/*
>   	 * Right now, this is one of only two places we collect this stat
>   	 * so we can safely collect detach_one_task() stats here rather
> @@ -11643,7 +11680,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>   		 * Move the next running task to the front of the list, so our
>   		 * cfs_tasks list becomes MRU one.
>   		 */
> -		list_move(&se->group_node, &rq->cfs_tasks);
> +		adjust_rq_cfs_tasks(list_move, rq, se);
>   	}
>   #endif
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e26688d387ae..accb4eea9769 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1068,6 +1068,7 @@ struct rq {
>   	int			online;
>   
>   	struct list_head cfs_tasks;
> +	struct list_head cfs_idle_tasks;
>   
>   	struct sched_avg	avg_rt;
>   	struct sched_avg	avg_dl;
