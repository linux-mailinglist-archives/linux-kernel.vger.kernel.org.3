Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A275464AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349143AbiFJKxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348875AbiFJKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:53:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 209F7313349
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:49:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA99D12FC;
        Fri, 10 Jun 2022 03:49:30 -0700 (PDT)
Received: from [10.5.48.228] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E0023F766;
        Fri, 10 Jun 2022 03:49:26 -0700 (PDT)
Message-ID: <67c7e9ea-1d3b-39f0-c1b6-4940ed45844d@arm.com>
Date:   Fri, 10 Jun 2022 12:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] sched/fair: combine detach into dequeue when migrating
 task
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
References: <20220609035326.91544-1-zhouchengming@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220609035326.91544-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 05:53, Chengming Zhou wrote:
> When we are migrating task out of the CPU, we can combine detach
> into dequeue_entity() to save the independent detach_entity_cfs_rq()
> in migrate_task_rq_fair().
> 
> This optimization is like combining DO_ATTACH in the enqueue_entity()
> when migrating task to the CPU.
> 
> So we don't have to traverse the CFS tree twice to do these load
> detach and propagation.

By `propagation` you refer to the detach_entity_cfs_rq() ->
propagate_entity_cfs_rq() call?
This one wouldn't be called anymore with your change.

[...]

> @@ -4426,6 +4435,14 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  static void
>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> +	int action = UPDATE_TG;
> +
> +	/*
> +	 * If we are migrating task from the CPU, detach load_avg when dequeue.
> +	 */
> +	if (entity_is_task(se) && task_of(se)->on_rq == TASK_ON_RQ_MIGRATING)

- if (entity_is_task(se) && task_of(se)->on_rq == TASK_ON_RQ_MIGRATING)
+ if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))

> +		action |= DO_DETACH;

With the `entity_is_task(se)` you make sure we only call
detach_entity_load_avg() and update_tg_load_avg() for the se
representing the task itself (and not taskgroups the task might run in).
So IMHO this looks good.

You save the propagate_entity_cfs_rq(&p->se) call from (2) by doing the
detach_entity_load_avg(), update_tg_load_avg() for a migrating task
inside (1) (the task being the first se in the loop )

detach_task()
  deactivate_task()
    dequeue_task_fair()
      for_each_sched_entity(se)
        dequeue_entity()
          update_load_avg() /* (1) */

  set_task_cpu()
    migrate_task_rq_fair()
      /* called detach_entity_cfs_rq() before the patch (2) */

[...]

> @@ -6940,15 +6957,10 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  		se->vruntime -= min_vruntime;
>  	}
>  
> -	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
> -		/*
> -		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
> -		 * rq->lock and can modify state directly.
> -		 */
> -		lockdep_assert_rq_held(task_rq(p));
> -		detach_entity_cfs_rq(&p->se);
> -
> -	} else {
> +	/*
> +	 * In case of TASK_ON_RQ_MIGRATING we already detach in dequeue_entity.
> +	 */
> +	if (p->on_rq != TASK_ON_RQ_MIGRATING) {

- if (p->on_rq != TASK_ON_RQ_MIGRATING) {
+ if (!task_on_rq_migrating(p)) {

[...]
