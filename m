Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72374E9F64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbiC1THJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiC1THH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:07:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CFD2655F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:05:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso328888pjh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YCYRd62odQbhm1ussqmokuyT2HY6xyQaWKLzA0V0RsY=;
        b=ELQjNE6QPy2I503Gk6OBD4NTAYuy6/XclclMutEveQzRbFQB2kmOmUMLhMzGeZWL4s
         1Jn1i6vCVjjjDS8MszUck2LluHn36mMvSukwaPNXc9DAN6qCjXBjdEtCG4vl3drdqvd/
         p6eWDIA7726ist6iYiB7fu1nn6OQiOd+3BbDxsmXUMgaNW51Unl7caHaebbIgmkEMo4+
         6f9phlCCBpbYUtGYUHJLbjFMnxFNJQFN/UkAdkBcvK1m5KyKHxZUfzT8Xq6J8jYH0LAR
         vFmZl3OwZauZmE5kEGjzfVYwFSf2Ub8lTrA77HeDEgwg13Rsu/EfZY45AskIXEiYtRbc
         6wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=YCYRd62odQbhm1ussqmokuyT2HY6xyQaWKLzA0V0RsY=;
        b=TRxMyhHqzLdzrLbF7oOJKWP+iGgA2dXAhpHD2zFx/smHKEqsKJEfw+KB1MF58WFahP
         WLnw2tQ7SL1YHKvKvKKFv2bWjaFRpFgc4TUAZc3UqvTLrG7vuKjZOG9OXHADaUJbdVU4
         T4KDOPweVADAWurQSfZgpTDtZaiH7HCEmzVQs/drRa08HmG8q/+6E2WaZTYkkjVx8/lE
         7qmi9U2ab9Gg5zT4Lns5MNVIFaAOmoeQRwIsBgPitG/ozRZGRKlscLV0mfmw2vFJL3au
         Y4e0is1+9gbyJg4SnmxBhXkI+mfXinauQPXOnwckapP83OlzW4iilYaDa2o5CUnNpohs
         hkwQ==
X-Gm-Message-State: AOAM532ngraXQDA2GUp1WJVaUBF8NaCySm+qAiRe1YKPBwotTldB/kEG
        8rcUk/cQtq0njUT3um2JOIP3Kw==
X-Google-Smtp-Source: ABdhPJzUFAsOERMBjOAlloqdgnMCLOKlP6NUmhzJFN4yBCS2J8U1gCkv5F2P4RZylqv4DQ3+z/PEdQ==
X-Received: by 2002:a17:90a:4897:b0:1c7:5fce:cbcd with SMTP id b23-20020a17090a489700b001c75fcecbcdmr601267pjh.45.1648494324920;
        Mon, 28 Mar 2022 12:05:24 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00194400b004fb358ffe84sm9017211pfk.104.2022.03.28.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 12:05:23 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH] sched/fair: fix broken bandwidth control with nohz_full
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
Date:   Mon, 28 Mar 2022 12:05:20 -0700
In-Reply-To: <20220328110751.39987-1-zhouchengming@bytedance.com> (Chengming
        Zhou's message of "Mon, 28 Mar 2022 19:07:51 +0800")
Message-ID: <xm26wngduccv.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chengming Zhou <zhouchengming@bytedance.com> writes:

> With nohz_full enabled on cpu, the scheduler_tick() will be stopped
> when only one CFS task left on rq.
>
> scheduler_tick()
>   task_tick_fair()
>     entity_tick()
>       update_curr()
>         account_cfs_rq_runtime(cfs_rq, delta_exec) --> stopped
>
> So that running task can't account its runtime periodically, but
> the cfs_bandwidth hrtimer still __refill_cfs_bandwidth_runtime()
> periodically. Later in one period, the task would account very
> big delta_exec, which cause the cfs_rq to be throttled for a
> long time.
>
> There are two solutions for the problem, the first is that we
> can check in sched_can_stop_tick() if current task's cfs_rq
> have runtime_enabled, in which case we don't stop tick. But
> it will make nohz_full almost useless in cloud environment
> that every container has the cpu bandwidth control setting.
>
> The other is what this patch implemented, cfs_bandwidth hrtimer
> would sync unaccounted runtime from all running cfs_rqs with
> tick stopped, just before __refill_cfs_bandwidth_runtime().
> Also do the same thing in tg_set_cfs_bandwidth().

>
> A testcase to reproduce:
> ```
> cd /sys/fs/cgroup
> echo "+cpu" > cgroup.subtree_control
>
> mkdir test
> echo "105000 100000" > test/cpu.max


The other half of this problem I think would be that it also won't
throttle when it /is/ out of bandwidth. That is, 'echo "50000 100000" >
test/cpu.max' would not stop after 50ms of runtime is spent, it would
only stop (with this patch) after 100ms. It would then correctly need to
repay that debt, so the (very) long-run ratio should be correct, but a
misbehaving task could be use practically arbitrarily more than their
supposed quota over the ~100s of milliseconds timescales cfsb is
generally supposed to work on.

However, I don't really see a way for cfsb's current design to avoid
that on nohz_full (without vetoing sched_can_stop_tick). It might be
possible to try and guess when quota will run out by tracking the number
of running or runnable threads, but that would be a nontrivial
undertaking and involve a bunch of hrtimer reprogramming (particularly
in cases when some cgroups actually have tasks that wake/sleep frequently).


>
> echo $$ > test/cgroup.procs
> taskset -c 1 bash -c "while true; do let i++; done"
> ```
> Ctrl-C and cat test/cpu.stat to see if nr_throttled > 0.
>
> The above testcase uses period 100ms and quota 105ms, would
> only see nr_throttled > 0 on nohz_full system. The problem
> is gone in test with this patch.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/core.c  |  4 ++++
>  kernel/sched/fair.c  | 30 ++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  3 +++
>  3 files changed, 37 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d575b4914925..17b5e3d27401 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10443,6 +10443,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  	 */
>  	if (runtime_enabled && !runtime_was_enabled)
>  		cfs_bandwidth_usage_inc();
> +
> +	if (runtime_was_enabled)
> +		sync_cfs_bandwidth_runtime(cfs_b);
> +
>  	raw_spin_lock_irq(&cfs_b->lock);
>  	cfs_b->period = ns_to_ktime(period);
>  	cfs_b->quota = quota;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ee0664c9d291..ebda70a0e3a8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5339,6 +5339,34 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +#ifdef CONFIG_NO_HZ_FULL
> +void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
> +{
> +	unsigned int cpu;
> +	struct rq *rq;
> +	struct rq_flags rf;
> +	struct cfs_rq *cfs_rq;
> +	struct task_group *tg;
> +
> +	tg = container_of(cfs_b, struct task_group, cfs_bandwidth);
> +
> +	for_each_online_cpu(cpu) {
> +		if (!tick_nohz_tick_stopped_cpu(cpu))
> +			continue;
> +
> +		rq = cpu_rq(cpu);
> +		cfs_rq = tg->cfs_rq[cpu];
> +
> +		rq_lock_irqsave(rq, &rf);

A for-every-nohz-cpu rqlock is definitely not great when the cgroup is
likely to be running on much fewer cpus. I'm not sure what the current
opinion would be on doing some sort of optimistic locking like

if (!READ_ONCE(cfs_rq->curr)) continue;
rq_lock_irqsave(...);
if (cfs_rq->curr) { ... }

but solutions to the other problem I mentioned earlier might provide
help here anyways.


> +		if (cfs_rq->curr) {
> +			update_rq_clock(rq);
> +			update_curr(cfs_rq);
> +		}
> +		rq_unlock_irqrestore(rq, &rf);
> +	}
> +}
> +#endif
> +
>  extern const u64 max_cfs_quota_period;
>  
>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> @@ -5350,6 +5378,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  	int idle = 0;
>  	int count = 0;
>  
> +	sync_cfs_bandwidth_runtime(cfs_b);
> +
>  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
>  	for (;;) {
>  		overrun = hrtimer_forward_now(timer, cfs_b->period);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 58263f90c559..57f9da9c50c1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2351,9 +2351,12 @@ static inline void sched_update_tick_dependency(struct rq *rq)
>  	else
>  		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
>  }
> +
> +extern void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
>  #else
>  static inline int sched_tick_offload_init(void) { return 0; }
>  static inline void sched_update_tick_dependency(struct rq *rq) { }
> +static inline void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b) {}
>  #endif
>  
>  static inline void add_nr_running(struct rq *rq, unsigned count)
