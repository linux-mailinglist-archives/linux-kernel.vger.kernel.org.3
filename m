Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8F595A12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiHPL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiHPLZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:25:50 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49899E1900
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:40:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 12so8888877pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wvpCWFPelfYvvOR63osRrM06DNetuSVNHUgDGm4H9aM=;
        b=bSjMZ7iEbyTXpFuLUx44xYaR082mNc8ByEKirboAleWBqd1IkswN5VZSREirw9iR59
         r5wK9yVziNKIxxS8f8MV8dKwQiS9w7LYFG724i7F3BXa7mIOPiH4a5kS/z3u15RcISHW
         m9BDQG6/8tYtmmg0HEQFHWbKpDUdvArswBLp6yfybYw9Az9kaQlaDFleMjf/FNMiVaKX
         tez3AlEdM/WWzSJGVgE018thXWtnCQ+6RmTWCgwzPePVZU1Ns03iERuYkYA/BUYxxzQb
         ax9hh6rZ3/xub3cMs1iB4xtV66lQjtlLre1rcbjDNy7pVAsE8nQ54VwLAUP2lhhOGZhD
         mfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wvpCWFPelfYvvOR63osRrM06DNetuSVNHUgDGm4H9aM=;
        b=ogdu8W2uIElkS+Ptc2XFFvARz8Zer6fH4inILmNLqHi2z/UTamY+X8Xj5/5PPZ3DqQ
         RCtNqWpFipmKxNDr6KQecUm5B7k5gQUDucZdr2liqfHYTHkBQoNXRIvtlRYGno0YxYja
         mcyEeWCM4LAY2TLTX5cQWO12V7UABGVgv+RPLPD5SIH1Gnqlh9uqXmTe8h2Xk2r2pyif
         +wCsjnuvq9eAtYxsdYZ5eNGsUXZBSkrvbmvxkv5iv3hQ5/Zs5F10nSz72AZX7KXAgJxX
         XYsF5Pbn6AdJvYX77qyl6AhER9boHXzADIWjTxvMfLJjB2vZsvTwhOyM0CNdjjR/pw1Y
         8ZXQ==
X-Gm-Message-State: ACgBeo0MfZDLm+BqtAxRDRljErDSEwZSU2nVeYOLpP1ECiZjPMFitRTE
        edaH9nOsbOpo8qrKAFCPN7HC7w==
X-Google-Smtp-Source: AA6agR5otZevjj13caQ26aMBk4VWrPzYPp5Zo1qcxgTbELDs6pwu9VJAUExUwUDyp8YK/MDBF/qXYw==
X-Received: by 2002:a65:558c:0:b0:415:f20b:9261 with SMTP id j12-20020a65558c000000b00415f20b9261mr17152785pgs.63.1660646456196;
        Tue, 16 Aug 2022 03:40:56 -0700 (PDT)
Received: from [10.4.196.37] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s13-20020a63ff4d000000b0041a615381d5sm7279797pgk.4.2022.08.16.03.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:40:55 -0700 (PDT)
Message-ID: <b8764fc6-15d3-fce7-0102-d3ba732eb98f@bytedance.com>
Date:   Tue, 16 Aug 2022 18:40:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v2 07/10] sched/psi: remove NR_ONCPU task accounting
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-8-zhouchengming@bytedance.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220808110341.15799-8-zhouchengming@bytedance.com>
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

On 2022/8/8 19:03, Chengming Zhou wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> We put all fields updated by the scheduler in the first cacheline of
> struct psi_group_cpu for performance.
> 
> Since we want add another PSI_IRQ_FULL to track IRQ/SOFTIRQ pressure,
> we need to reclaim space first. This patch remove NR_ONCPU task accounting
> in struct psi_group_cpu, use one bit in state_mask to track instead.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  include/linux/psi_types.h | 16 +++++++---------
>  kernel/sched/psi.c        | 36 ++++++++++++++++++++++++++++--------
>  2 files changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index c7fe7c089718..54cb74946db4 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -15,13 +15,6 @@ enum psi_task_count {
>  	NR_IOWAIT,
>  	NR_MEMSTALL,
>  	NR_RUNNING,
> -	/*
> -	 * This can't have values other than 0 or 1 and could be
> -	 * implemented as a bit flag. But for now we still have room
> -	 * in the first cacheline of psi_group_cpu, and this way we
> -	 * don't have to special case any state tracking for it.
> -	 */
> -	NR_ONCPU,
>  	/*
>  	 * For IO and CPU stalls the presence of running/oncpu tasks
>  	 * in the domain means a partial rather than a full stall.
> @@ -32,16 +25,18 @@ enum psi_task_count {
>  	 * threads and memstall ones.
>  	 */
>  	NR_MEMSTALL_RUNNING,
> -	NR_PSI_TASK_COUNTS = 5,
> +	NR_PSI_TASK_COUNTS = 4,
>  };
>  
>  /* Task state bitmasks */
>  #define TSK_IOWAIT	(1 << NR_IOWAIT)
>  #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
>  #define TSK_RUNNING	(1 << NR_RUNNING)
> -#define TSK_ONCPU	(1 << NR_ONCPU)
>  #define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
>  
> +/* Only one task can be scheduled, no corresponding task count */
> +#define TSK_ONCPU	(1 << NR_PSI_TASK_COUNTS)
> +
>  /* Resources that workloads could be stalled on */
>  enum psi_res {
>  	PSI_IO,
> @@ -68,6 +63,9 @@ enum psi_states {
>  	NR_PSI_STATES = 7,
>  };
>  
> +/* Use one bit in the state mask to track TSK_ONCPU */
> +#define PSI_ONCPU	(1 << NR_PSI_STATES)
> +
>  enum psi_aggregators {
>  	PSI_AVGS = 0,
>  	PSI_POLL,
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 595a6c8230b7..1c675715ed33 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -216,7 +216,7 @@ void __init psi_init(void)
>  	group_init(&psi_system);
>  }
>  
> -static bool test_state(unsigned int *tasks, enum psi_states state)
> +static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
>  {
>  	switch (state) {
>  	case PSI_IO_SOME:
> @@ -229,9 +229,9 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
>  		return unlikely(tasks[NR_MEMSTALL] &&
>  			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
>  	case PSI_CPU_SOME:
> -		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
> +		return unlikely(tasks[NR_RUNNING] > oncpu);
>  	case PSI_CPU_FULL:
> -		return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
> +		return unlikely(tasks[NR_RUNNING] && !oncpu);
>  	case PSI_NONIDLE:
>  		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
>  			tasks[NR_RUNNING];
> @@ -693,9 +693,9 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  			     bool wake_clock)
>  {
>  	struct psi_group_cpu *groupc;
> -	u32 state_mask = 0;
>  	unsigned int t, m;
>  	enum psi_states s;
> +	u32 state_mask;
>  
>  	groupc = per_cpu_ptr(group->pcpu, cpu);
>  
> @@ -711,6 +711,26 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  
>  	record_times(groupc, now);
>  
> +	/*
> +	 * Start with TSK_ONCPU, which doesn't have a corresponding
> +	 * task count - it's just a boolean flag directly encoded in
> +	 * the state mask. Clear, set, or carry the current state if
> +	 * no changes are requested.
> +	 */
> +	if (clear & TSK_ONCPU) {
> +		state_mask = 0;
> +		clear &= ~TSK_ONCPU;
> +	} else if (set & TSK_ONCPU) {
> +		state_mask = PSI_ONCPU;
> +		set &= ~TSK_ONCPU;

These two conditions should use "unlikely()", which would be better
in the perf bench sched pipe testcase.


> +	} else {
> +		state_mask = groupc->state_mask & PSI_ONCPU;
> +	}
> +
> +	/*
> +	 * The rest of the state mask is calculated based on the task
> +	 * counts. Update those first, then construct the mask.
> +	 */
>  	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
>  		if (!(m & (1 << t)))
>  			continue;
> @@ -730,9 +750,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		if (set & (1 << t))
>  			groupc->tasks[t]++;
>  
> -	/* Calculate state mask representing active states */
>  	for (s = 0; s < NR_PSI_STATES; s++) {
> -		if (test_state(groupc->tasks, s))
> +		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
>  			state_mask |= (1 << s);
>  	}
>  
> @@ -744,7 +763,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  	 * task in a cgroup is in_memstall, the corresponding groupc
>  	 * on that cpu is in PSI_MEM_FULL state.
>  	 */
> -	if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
> +	if (unlikely((state_mask & PSI_ONCPU) && cpu_curr(cpu)->in_memstall))
>  		state_mask |= (1 << PSI_MEM_FULL);
>  
>  	groupc->state_mask = state_mask;
> @@ -835,7 +854,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 */
>  		iter = NULL;
>  		while ((group = iterate_groups(next, &iter))) {
> -			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
> +			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
> +			    PSI_ONCPU) {
>  				common = group;
>  				break;
>  			}
