Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC6571CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiGLOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiGLOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:30:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2394A0262
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7050EB816E1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D1DC3411C;
        Tue, 12 Jul 2022 14:29:54 +0000 (UTC)
Date:   Tue, 12 Jul 2022 10:29:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        zhaohui.shi@horizon.ai
Subject: Re: [PATCH v5 2/2] sched/rt: Trying to push current task when
 target disable migrating
Message-ID: <20220712102953.02d4a3bd@gandalf.local.home>
In-Reply-To: <20220712013125.623338-2-schspa@gmail.com>
References: <20220712013125.623338-1-schspa@gmail.com>
        <20220712013125.623338-2-schspa@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 09:31:25 +0800
Schspa Shi <schspa@gmail.com> wrote:

> When the task to push disable migration, retry to push the current
> running task on this CPU away, instead doing nothing for this migrate
> disabled task.
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  kernel/sched/core.c | 6 +++++-
>  kernel/sched/rt.c   | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da0bf6fe9ecdc..0b1fefd97d874 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2509,8 +2509,12 @@ int push_cpu_stop(void *arg)
>  	if (p->sched_class->find_lock_rq)
>  		lowest_rq = p->sched_class->find_lock_rq(p, rq);
>  
> -	if (!lowest_rq)
> +	if (!lowest_rq) {

Probably should add a comment reminding us that the find_lock() function
above could have released the rq lock and allow p to schedule and be
preempted again, and that lowest_rq could be NULL because p now has the
migrate_disable flag set and not because it could not find the lowest rq.

-- Steve


> +		if (unlikely(is_migration_disabled(p)))
> +			p->migration_flags |= MDF_PUSH;
> +
>  		goto out_unlock;
> +	}
>  
>  	// XXX validate p is still the highest prio task
>  	if (task_rq(p) == rq) {
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7c32ba51b6d85..877380e465b7a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2136,6 +2136,12 @@ static int push_rt_task(struct rq *rq, bool pull)
>  		 */
>  		task = pick_next_pushable_task(rq);
>  		if (task == next_task) {
> +			/*
> +			 * If next task has now disabled migrating, see if we
> +			 * can push the current task.
> +			 */
> +			if (unlikely(is_migration_disabled(task)))
> +				goto retry;
>  			/*
>  			 * The task hasn't migrated, and is still the next
>  			 * eligible task, but we failed to find a run-queue

