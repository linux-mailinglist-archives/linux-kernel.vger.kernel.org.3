Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF57574DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiGNMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiGNMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:31:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E55C258847
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:30:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0390913D5;
        Thu, 14 Jul 2022 05:30:52 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53F323F792;
        Thu, 14 Jul 2022 05:30:50 -0700 (PDT)
Message-ID: <8025988d-7d1d-0b4a-6eed-8b3698bc9bad@arm.com>
Date:   Thu, 14 Jul 2022 14:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 03/10] sched/fair: maintain task se depth in
 set_task_rq()
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-4-zhouchengming@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220713040430.25778-4-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:04, Chengming Zhou wrote:
> Previously we only maintain task se depth in task_move_group_fair(),
> if a !fair task change task group, its se depth will not be updated,
> so commit eb7a59b2c888 ("sched/fair: Reset se-depth when task switched to FAIR")
> fix the problem by updating se depth in switched_to_fair() too.

Maybe it's worth mentioning how the se.depth setting from
task_move_group_fair() and switched_to_fair() went into
attach_task_cfs_rq() with commit daa59407b558 ("sched/fair: Unify
switched_{from,to}_fair() and task_move_group_fair()"}  and further into
attach_entity_cfs_rq() with commit df217913e72e ("sched/fair: Factorize
attach/detach entity").

> This patch move task se depth maintainence to set_task_rq(), which will be
> called when CPU/cgroup change, so its depth will always be correct.
> 
> This patch is preparation for the next patch.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

> ---
>  kernel/sched/fair.c  | 8 --------
>  kernel/sched/sched.h | 1 +
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2a3e12ead144..bf595b622656 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11539,14 +11539,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
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
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index aad7f5ee9666..8cc3eb7b86cd 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1940,6 +1940,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
>  	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
>  	p->se.cfs_rq = tg->cfs_rq[cpu];
>  	p->se.parent = tg->se[cpu];
> +	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
>  #endif
>  
>  #ifdef CONFIG_RT_GROUP_SCHED

