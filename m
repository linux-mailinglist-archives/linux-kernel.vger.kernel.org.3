Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2323855C9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbiF1Med (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbiF1Mea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:34:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2E2DABC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:34:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n12so11948751pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RXjGJANRhboFJY9ZSMgCfYYQ5paGis0Mw1doE2djBic=;
        b=ir0wkb7OuNhe4C+0zGVLpgjw5wtOSmzqW2EKn5h+5Bgs/6AQbvc3jNe060ecvX+15U
         +vMKfVAiqK2lev8hPtfX+QOuNhXy0HcfR88qikQs7F8JfSj4ogHeEwVYBapU18RcyNYJ
         wF8Z/85XXf2063uKlmPiQJyrgBmXdMd6iwddOmWnqRzMj24rRJHYWOYpbtoxp6C2TFPd
         1Ry5psIhoLUacTnbhrtIt8/5OSCUA+FXcE0LiExnhuZ9L162qsnBmNQ0HnTaRHeCWRQY
         T6ljcv56UTdyMcUyiLXgkBLKKMLfDcLfswMdUvdakK4OeYM2R3WfGDbl3GfR5YggO3lh
         f6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RXjGJANRhboFJY9ZSMgCfYYQ5paGis0Mw1doE2djBic=;
        b=iEDDxV/DXqNkcw8A7RexMiVKNmgT6Qzx5oskZuxXJMfgTykMb1ptniZj9JiHL9FOm5
         HXubnnmHY0SdJmYSqBm1bDXztYbKxvSvOvCRCRQ8bVDb3tvfgMZ5gPf5btJBzCXAeW3I
         y8eeSWQg4qyzD1hOEFc0uHUgifoPQAAqvNXckZ6RAw6EUsIKC8vAhkk8/n9IoLef0/TL
         vvJ5r26XjaVceEUgJfp8JNPBT+4w95r6c2k5VK6rsnWOY0ABKW1nXi1vIwbrb3ms18YM
         CvSm5EpFj8xy8PKqj7Xk0d3d7oQaDrH/LBXqYtGNK8aSaYcdgIu7+b1BeM5CzmZ+kYIu
         KQrw==
X-Gm-Message-State: AJIora9LzHc4Gcz5hGTqS9L+j8mc83bD+hKdlZzFInhhNhPSjN03/HqY
        D6toDIKeLHvYGkQ42DvN44PjiQ==
X-Google-Smtp-Source: AGRyM1ukW3BiNU8LZqsGv56vK/sC3TSPLZoklOzI5wlL7g14JI5KkH5VN3cpjQonCbii8uMjwN8o4A==
X-Received: by 2002:a63:2213:0:b0:3fe:7f8:c917 with SMTP id i19-20020a632213000000b003fe07f8c917mr17102889pgi.406.1656419668619;
        Tue, 28 Jun 2022 05:34:28 -0700 (PDT)
Received: from [10.255.246.56] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7888b000000b0052516db7123sm9333082pfe.35.2022.06.28.05.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:34:28 -0700 (PDT)
Message-ID: <a10e9aea-4c9a-f248-d4c7-a69d9143a461@bytedance.com>
Date:   Tue, 28 Jun 2022 20:34:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] sched: remove redundant cpu_cgrp_subsys->fork()
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, rdunlap@infradead.org,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220622094831.22948-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220622094831.22948-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, friendly ping...

Thanks.


On 2022/6/22 17:48, Chengming Zhou wrote:
> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
> in cgroup_post_fork().
> 
> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
> has already set task group for the new fair task in sched_cgroup_fork(),
> so cpu_cgrp_subsys->fork() can be removed.
> 
>   cgroup_can_fork()	--> pin parent's sched_task_group
>   sched_cgroup_fork()
>     __set_task_cpu	--> set task group
>   cgroup_post_fork()
>     ss->fork() := cpu_cgroup_fork()	--> set again
> 
> After this change, task_change_group_fair() only need to care about
> task cgroup migration, make the code much simplier.
> 
> This patch move the task se depth setting to set_task_rq(), which
> is called when task moves across CPUs/groups, is a better place than
> attach_entity_cfs_rq(). The latter is also used when change task's
> sched_class, in which case the group/depth doesn't change actually.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/core.c  | 27 ++++-----------------------
>  kernel/sched/fair.c  | 31 +------------------------------
>  kernel/sched/sched.h |  6 ++----
>  3 files changed, 7 insertions(+), 57 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c16f8cc5de08..f44bc5b889ab 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -481,8 +481,7 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>   *				p->se.load, p->rt_priority,
>   *				p->dl.dl_{runtime, deadline, period, flags, bw, density}
>   *  - sched_setnuma():		p->numa_preferred_nid
> - *  - sched_move_task()/
> - *    cpu_cgroup_fork():	p->sched_task_group
> + *  - sched_move_task():	p->sched_task_group
>   *  - uclamp_update_active()	p->uclamp*
>   *
>   * p->state <- TASK_*:
> @@ -10098,7 +10097,7 @@ void sched_release_group(struct task_group *tg)
>  	spin_unlock_irqrestore(&task_group_lock, flags);
>  }
>  
> -static void sched_change_group(struct task_struct *tsk, int type)
> +static void sched_change_group(struct task_struct *tsk)
>  {
>  	struct task_group *tg;
>  
> @@ -10114,7 +10113,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	if (tsk->sched_class->task_change_group)
> -		tsk->sched_class->task_change_group(tsk, type);
> +		tsk->sched_class->task_change_group(tsk);
>  	else
>  #endif
>  		set_task_rq(tsk, task_cpu(tsk));
> @@ -10145,7 +10144,7 @@ void sched_move_task(struct task_struct *tsk)
>  	if (running)
>  		put_prev_task(rq, tsk);
>  
> -	sched_change_group(tsk, TASK_MOVE_GROUP);
> +	sched_change_group(tsk);
>  
>  	if (queued)
>  		enqueue_task(rq, tsk, queue_flags);
> @@ -10223,23 +10222,6 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>  	sched_unregister_group(tg);
>  }
>  
> -/*
> - * This is called before wake_up_new_task(), therefore we really only
> - * have to set its group bits, all the other stuff does not apply.
> - */
> -static void cpu_cgroup_fork(struct task_struct *task)
> -{
> -	struct rq_flags rf;
> -	struct rq *rq;
> -
> -	rq = task_rq_lock(task, &rf);
> -
> -	update_rq_clock(rq);
> -	sched_change_group(task, TASK_SET_GROUP);
> -
> -	task_rq_unlock(rq, task, &rf);
> -}
> -
>  static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
>  {
>  	struct task_struct *task;
> @@ -11136,7 +11118,6 @@ struct cgroup_subsys cpu_cgrp_subsys = {
>  	.css_released	= cpu_cgroup_css_released,
>  	.css_free	= cpu_cgroup_css_free,
>  	.css_extra_stat_show = cpu_extra_stat_show,
> -	.fork		= cpu_cgroup_fork,
>  	.can_attach	= cpu_cgroup_can_attach,
>  	.attach		= cpu_cgroup_attach,
>  	.legacy_cftypes	= cpu_legacy_files,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8bed75757e65..fdb9125fe34e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11325,14 +11325,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>  {
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
> -#ifdef CONFIG_FAIR_GROUP_SCHED
> -	/*
> -	 * Since the real-depth could have been changed (only FAIR
> -	 * class maintain depth value), reset depth properly.
> -	 */
> -	se->depth = se->parent ? se->parent->depth + 1 : 0;
> -#endif
> -
>  	/* Synchronize entity with its cfs_rq */
>  	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>  	attach_entity_load_avg(cfs_rq, se);
> @@ -11431,15 +11423,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>  }
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -static void task_set_group_fair(struct task_struct *p)
> -{
> -	struct sched_entity *se = &p->se;
> -
> -	set_task_rq(p, task_cpu(p));
> -	se->depth = se->parent ? se->parent->depth + 1 : 0;
> -}
> -
> -static void task_move_group_fair(struct task_struct *p)
> +static void task_change_group_fair(struct task_struct *p)
>  {
>  	detach_task_cfs_rq(p);
>  	set_task_rq(p, task_cpu(p));
> @@ -11451,19 +11435,6 @@ static void task_move_group_fair(struct task_struct *p)
>  	attach_task_cfs_rq(p);
>  }
>  
> -static void task_change_group_fair(struct task_struct *p, int type)
> -{
> -	switch (type) {
> -	case TASK_SET_GROUP:
> -		task_set_group_fair(p);
> -		break;
> -
> -	case TASK_MOVE_GROUP:
> -		task_move_group_fair(p);
> -		break;
> -	}
> -}
> -
>  void free_fair_sched_group(struct task_group *tg)
>  {
>  	int i;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 317480d535b0..8433e22da3ab 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1901,6 +1901,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
>  	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
>  	p->se.cfs_rq = tg->cfs_rq[cpu];
>  	p->se.parent = tg->se[cpu];
> +	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
>  #endif
>  
>  #ifdef CONFIG_RT_GROUP_SCHED
> @@ -2163,11 +2164,8 @@ struct sched_class {
>  
>  	void (*update_curr)(struct rq *rq);
>  
> -#define TASK_SET_GROUP		0
> -#define TASK_MOVE_GROUP		1
> -
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -	void (*task_change_group)(struct task_struct *p, int type);
> +	void (*task_change_group)(struct task_struct *p);
>  #endif
>  };
>  
