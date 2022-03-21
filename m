Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B7D4E2EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351814AbiCURZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbiCURZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:25:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F1F7ECD90
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:23:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2493F1042;
        Mon, 21 Mar 2022 10:23:44 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E452C3F66F;
        Mon, 21 Mar 2022 10:23:42 -0700 (PDT)
Message-ID: <710b460f-20b9-21c4-3077-8cea35600550@arm.com>
Date:   Mon, 21 Mar 2022 18:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/7] sched/fair: Decay task PELT values during
 migration
Content-Language: en-US
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com
References: <20220308181957.280354-1-vincent.donnefort@arm.com>
 <20220308181957.280354-3-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220308181957.280354-3-vincent.donnefort@arm.com>
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

On 08/03/2022 19:19, Vincent Donnefort wrote:

Patch header:

s/during migration/during wakeup migration ?

To make sure it's not related to lb migration (TASK_ON_RQ_MIGRATING).

[...]

> Neither clock_task, clock_pelt nor clock can be accessed without the
> runqueue lock. The new cfs_rq last_update_lag is therefore created and
> encode those three values when the last_update_time value for that very

s/encode/encodes ... It's not really encoding?

[...]

> Now we have an estimation for A + B, we can create an estimator for the
> PELT value at the time of the migration. We need for this purpose to
> inject last_update_time which is a combination of both clock_pelt and
> lost_idle_time. The latter is a time value which is completely lost form a

s/form/from

> PELT point of view and must be ignored. And finally, we can write:
> 
>   rq_clock_pelt_estimator() = last_update_time + A + B
>                             = last_update_time +
>                                    sched_clock_cpu() - last_update_lag

rq_clock_pelt_estimator() did exist in v2 but does not in v3 anymore.
Might be misleading when people search for it.

[...]

> @@ -3688,6 +3704,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  			   cfs_rq->last_update_time_copy,
>  			   sa->last_update_time);
>  #endif
> +	update_cfs_rq_lag(cfs_rq);
>  
>  	return decayed;
>  }
> @@ -6852,6 +6869,44 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  
>  static void detach_entity_cfs_rq(struct sched_entity *se);
>  
> +#ifdef CONFIG_NO_HZ_COMMON

Couldn't you put update_cfs_rq_lag() and migrate_se_pelt_lag() under one
CONFIG_NO_HZ_COMMON?

> +static inline void migrate_se_pelt_lag(struct sched_entity *se)

[...]

> +	/*
> +	 * The lag estimation comes with a cost we don't want to pay all the
> +	 * time. Hence, limiting to the case where the source CPU is idle and
> +	 * we know we are at the greatest risk to have an outdated clock.
> +	 */
> +	if (!is_idle)
> +		return;
> +
> +	last_update_lag = u64_u32_load(cfs_rq->last_update_lag);

So each taskgroup has its own last_update_lag. I guess it works since we
sync se in migrate_task_rq_fair() -> remove_entity_load_avg() ->
sync_entity_load_avg() with its cfs_rq.

[...]

> @@ -6859,6 +6914,9 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
>   */
>  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  {
> +	struct sched_entity *se = &p->se;
> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);

This line can stay in the if condition below since cfs_rq is only used
there. The brackets are also still there (A).

[...]

> @@ -6866,8 +6924,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	 * the task on the new runqueue.
>  	 */
>  	if (READ_ONCE(p->__state) == TASK_WAKING) {
> -		struct sched_entity *se = &p->se;         <--- (A)
> -		struct cfs_rq *cfs_rq = cfs_rq_of(se);

[...]
