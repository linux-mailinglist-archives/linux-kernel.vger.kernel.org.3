Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2902D4E912F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiC1JZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiC1JZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:25:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF67513FB7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:24:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4A7C1480;
        Mon, 28 Mar 2022 02:24:13 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CCCB3F66F;
        Mon, 28 Mar 2022 02:24:10 -0700 (PDT)
Message-ID: <bb92b4ee-293b-7e00-6e74-bd10fc088f7e@arm.com>
Date:   Mon, 28 Mar 2022 11:24:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-6-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220311161406.23497-6-vincent.guittot@linaro.org>
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

On 11/03/2022 17:14, Vincent Guittot wrote:

[...]

> @@ -4412,7 +4417,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  		p->prio = p->normal_prio = p->static_prio;
>  		set_load_weight(p, false);
>  
> -		p->latency_nice = DEFAULT_LATENCY_NICE;
> +		p->latency_prio = NICE_TO_LATENCY(0);
>  		/*
>  		 * We don't need the reset flag anymore after the fork. It has
>  		 * fulfilled its duty:
> @@ -4420,6 +4425,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  		p->sched_reset_on_fork = 0;
>  	}
>  
> +	/* Once latency_prio is set, update the latency weight */
> +	set_latency_weight(p);

I thought we only have to do this in the `sched_reset_on_fork` case?
Like we do with set_load_weight(). Can we not rely on dup_task_struct()
in the other case?

[...]

> @@ -5648,6 +5677,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!task_new)
>  		update_overutilized_status(rq);
>  
> +	if (rq->curr == rq->idle)
> +		check_preempt_from_idle(cfs_rq_of(&p->se), &p->se);

This is done here (1) because check_preempt_wakeup() (2) is only called
if p and rq->curr have CFS sched class?


ttwu_do_activate()
  activate_task()
    enqueue_task <-- (1)
  ttwu_do_wakeup()
    check_preempt_curr()
      if (p->sched_class == rq->curr->sched_class)
        rq->curr->sched_class->check_preempt_curr() <-- (2)

[...]

> @@ -7008,6 +7059,10 @@ static int
>  wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>  {
>  	s64 gran, vdiff = curr->vruntime - se->vruntime;
> +	int latency_weight = se->latency_weight - curr->latency_weight;
> +
> +	latency_weight = min(latency_weight, se->latency_weight);

Why the min out of latency_weight_diff(se, curr) and se->latency_weight
here?

[...]
