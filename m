Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B725A2F41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345121AbiHZSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345181AbiHZSto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:49:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34D07ED005
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:46:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29FB1168F;
        Fri, 26 Aug 2022 11:46:30 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68D353F93E;
        Fri, 26 Aug 2022 11:46:22 -0700 (PDT)
Message-ID: <aad1078b-2620-3122-7796-24e2451d36d6@arm.com>
Date:   Fri, 26 Aug 2022 20:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/2] sched/rt: Trying to push current task when target
 disable migrating
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai
References: <20220713134823.95141-1-schspa@gmail.com>
 <20220713134823.95141-2-schspa@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220713134823.95141-2-schspa@gmail.com>
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

On 13/07/2022 15:48, Schspa Shi wrote:
> When the task to push disable migration, retry to push the current
> running task on this CPU away, instead doing nothing for this migrate
> disabled task.
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Unfortunately, I can't recreate this issue on my Arm64 6 CPUs system on
mainline or PREEMPT_RT (linux-5.19.y-rt and v5.10.59-rt52) (the one you
mentioned in v6.)

With an rt-app rt workload of 12-18 periodic rt-tasks (4/16ms) all with
different priorities I never ran into a `is_migration_disabled(task)`
situation. I only ever get `task_rq(task) != rq` or `task_running(rq,
task)` under the `if (double_lock_balance(rq, lowest_rq))` condition in
find_lock_lowest_rq().

[...]

>  	// XXX validate p is still the highest prio task
>  	if (task_rq(p) == rq) {
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index cb3b886a081c..21af20445e7f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2335,6 +2335,15 @@ static int push_dl_task(struct rq *rq)
>  		 */
>  		task = pick_next_pushable_dl_task(rq);
>  		if (task == next_task) {
> +			/*
> +			 * If next task has now disabled migrating, see if we
> +			 * can push the current task.
> +			 */
> +			if (unlikely(is_migration_disabled(task))) {
> +				put_task_struct(next_task);
> +				goto retry;
> +			}
> +

Looks like for DL this makes no sense since we're not pushing rq->curr
in `retry:` like for RT in case `is_migration_disabled(next_task)`.

[...]

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
