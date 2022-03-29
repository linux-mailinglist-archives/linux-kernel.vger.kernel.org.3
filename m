Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474414EAB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiC2KL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiC2KL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:11:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5255F1C34B6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:09:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id o8so14384744pgf.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fcuGv2xjRqAdQjGZoVhGGx4Xa83UWhob6K5ggzH32EQ=;
        b=fDmreJ0Bk5GVeAnIxZDoEHV+ZKvAQNH0eBKQhAZjzb4aTpliha6gjPOXvff4dES1yC
         l6sutoBEr/f98VuevKrIxJsUC7SKBTd87NF7S87Hw+KEw+rcMm+gG9D0UCGCOy6hoGSH
         eFbSmX8zLai4CgZUbLRrklK1uvya8Jfst2h+MAZ5flLBOK9k8qH6cHZ7OqBVdf5cyYNL
         og410Krd7y4IslffC+uc7RFTF8Oj1tjKfWImduFR2aSLemfJLaeGCoY4NFrfP6SCpmqN
         kecUrlk8lf4YODLCx6tq/Ora0kyvwB6y7uZEuNo8RE2l3+8ZvTwSe6Bw2PiXYlo61WqA
         dF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fcuGv2xjRqAdQjGZoVhGGx4Xa83UWhob6K5ggzH32EQ=;
        b=qZCh5vTgPKyqXDAmvQm08eaV6wdxdhHjJgB5rtSm2xX3Q56u52ikUTbM5Fxq369MRX
         YDr2RW/oliG/0gpvhzbqbw1PvHjRJL8gEyxvqrCLqNf4ZWScUIGM8IIwyNq6pK77yI6q
         egIgiA5TsZeIWV/XsxK2ubkrw9Upy1uMcexcbRvQ/d0uZ9RzJUPHTp1rpFNDCzA6VnQH
         JUoTNpM0UlMTYMVlIm6CLK2toSEDdF7q4Ar1PFG0/4NhQSKpY6aVqAdO7T7+v1OVHPKd
         BA+nzkMqa8fxY9bNaalGknsLdLOe36S/bNTNoha7JmARYzvzuoKK+AS6STnra1DIVVkL
         wEjQ==
X-Gm-Message-State: AOAM533EDyA1BMEt/JooVWIRfHLIZcE0KTEv+RvP/cOY+4aSzrAuN23l
        DPWk+z2zcLF4pau9oAvPYNWGKA==
X-Google-Smtp-Source: ABdhPJxlDS3lk2nKTtpfJDz2szqaiySgFoCJLOx/bi3i3N037ncu60qI4zSXF0T0I0mZx22PE6sXIA==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr27458723pfl.38.1648548583732;
        Tue, 29 Mar 2022 03:09:43 -0700 (PDT)
Received: from [10.254.93.221] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm2323219pjk.8.2022.03.29.03.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 03:09:42 -0700 (PDT)
Message-ID: <3a24ba8c-b00d-2f9b-95c9-b8aba1b51493@bytedance.com>
Date:   Tue, 29 Mar 2022 18:09:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] sched/fair: Simple runqueue order on migrate
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@elte.hu>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Yu Chen <yu.c.chen@intel.com>, Walter Mack <walter.mack@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
References: <cover.1648228023.git.tim.c.chen@linux.intel.com>
 <f59f1dfeec4692e7a373cc810168912a2d2f8f3c.1648228023.git.tim.c.chen@linux.intel.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <f59f1dfeec4692e7a373cc810168912a2d2f8f3c.1648228023.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/22 6:54 AM, Tim Chen Wrote:
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> There's a number of problems with SMP migration of fair tasks, but
> basically it boils down to a task not receiving equal service on each
> runqueue (consider the trivial 3 tasks 2 cpus infeasible weight
> scenario).
> 
> Fully solving that with vruntime placement is 'hard', not least
> because a task might be very under-services on a busy runqueue and
> would need to be placed so far left on the new runqueue that it would
> significantly impact latency on the existing tasks.
> 
> Instead do minimal / basic placement instead; when moving to a less
> busy queue place at the front of the queue to receive time sooner.
> When moving to a busier queue, place at the end of the queue to
> receive time later.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Walter Mack <walter.mack@intel.com>
> ---
>   kernel/sched/fair.c     | 33 +++++++++++++++++++++++++++++----
>   kernel/sched/features.h |  2 ++
>   2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2498e97804fd..c5d2cb3a8f42 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4223,6 +4223,27 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>   	se->vruntime = max_vruntime(se->vruntime, vruntime);
>   }
>   
> +static void place_entity_migrate(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
> +	if (!sched_feat(PLACE_MIGRATE))
> +		return;
> +
> +	if (cfs_rq->nr_running < se->migrated) {
> +		/*
> +		 * Migrated to a shorter runqueue, go first because
> +		 * we were under-served on the old runqueue.
> +		 */
> +		se->vruntime = cfs_rq->min_vruntime;
> +		return;
> +	}
> +
> +	/*
> +	 * Migrated to a longer runqueue, go last because
> +	 * we got over-served on the old runqueue.
> +	 */
> +	se->vruntime = cfs_rq->min_vruntime + sched_vslice(cfs_rq, se);
> +}

Should se->migrated be cleared after place_entity_migrate?

> +
>   static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
>   
>   static inline bool cfs_bandwidth_used(void);
> @@ -4296,6 +4317,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   
>   	if (flags & ENQUEUE_WAKEUP)
>   		place_entity(cfs_rq, se, 0);
> +	else if (se->migrated)
> +		place_entity_migrate(cfs_rq, se);
>   
>   	check_schedstat_required();
>   	update_stats_enqueue_fair(cfs_rq, se, flags);
> @@ -6930,6 +6953,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
>    */
>   static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>   {
> +	struct sched_entity *se = &p->se;
>   	/*
>   	 * As blocked tasks retain absolute vruntime the migration needs to
>   	 * deal with this by subtracting the old and adding the new
> @@ -6962,7 +6986,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>   		 * rq->lock and can modify state directly.
>   		 */
>   		lockdep_assert_rq_held(task_rq(p));
> -		detach_entity_cfs_rq(&p->se);
> +		detach_entity_cfs_rq(se);
>   
>   	} else {
>   		/*
> @@ -6973,14 +6997,15 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>   		 * wakee task is less decayed, but giving the wakee more load
>   		 * sounds not bad.
>   		 */
> -		remove_entity_load_avg(&p->se);
> +		remove_entity_load_avg(se);
>   	}
>   
>   	/* Tell new CPU we are migrated */
> -	p->se.avg.last_update_time = 0;
> +	se->avg.last_update_time = 0;
>   
>   	/* We have migrated, no longer consider this task hot */
> -	p->se.migrated = 1;
> +	for_each_sched_entity(se)
> +		se->migrated = READ_ONCE(cfs_rq_of(se)->nr_running) + !se->on_rq;
>   
>   	update_scan_period(p, new_cpu);
>   }
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 1cf435bbcd9c..681c84fd062c 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -100,3 +100,5 @@ SCHED_FEAT(LATENCY_WARN, false)
>   
>   SCHED_FEAT(ALT_PERIOD, true)
>   SCHED_FEAT(BASE_SLICE, true)
> +
> +SCHED_FEAT(PLACE_MIGRATE, true)
