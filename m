Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785B9574DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiGNMdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiGNMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:33:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4677E2BDF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:33:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80CFA1CE2;
        Thu, 14 Jul 2022 05:33:39 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D45E33F792;
        Thu, 14 Jul 2022 05:33:37 -0700 (PDT)
Message-ID: <27f0675e-8ac3-2200-749f-7290a256e3d9@arm.com>
Date:   Thu, 14 Jul 2022 14:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 09/10] sched/fair: stop load tracking when task
 switched_from_fair()
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-10-zhouchengming@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220713040430.25778-10-zhouchengming@bytedance.com>
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
> The same reason as the previous commit, if we don't reset the
> sched_avg last_update_time to 0, after a while in switched_to_fair():
> 
> switched_to_fair
>   attach_task_cfs_rq
>     attach_entity_cfs_rq
>       update_load_avg
>         __update_load_avg_se(now, cfs_rq, se)
> 
> The delta (now - sa->last_update_time) will wrongly contribute/decay
> sched_avg depends on the task running/runnable status at that time.

IMHO, a queued !fair task when switching back to fair will already be
enqueued (attached) as a fair task in __sched_setscheduler() prior to
the check_class_changed() call.

I can't see how this will work with your proposed change in using
last_update_time=0 for fair->!fair->fair class changes?

> This patch reset it's sched_avg last_update_time to 0, stop load
> tracking for !fair task, later in switched_to_fair() ->
> update_load_avg(), we can use its saved sched_avg.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 50f65a2ede32..576028f5a09e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11552,6 +11552,11 @@ static void attach_task_cfs_rq(struct task_struct *p)
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>  {
>  	detach_task_cfs_rq(p);
> +
> +#ifdef CONFIG_SMP
> +	/* Stop load tracking for !fair task */
> +	p->se.avg.last_update_time = 0;
> +#endif
>  }
>  
>  static void switched_to_fair(struct rq *rq, struct task_struct *p)

