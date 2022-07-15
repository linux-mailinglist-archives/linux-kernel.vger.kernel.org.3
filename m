Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19697575FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiGOLSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiGOLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:18:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C20FBC55
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:18:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F03851474;
        Fri, 15 Jul 2022 04:18:36 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E603F73D;
        Fri, 15 Jul 2022 04:18:35 -0700 (PDT)
Message-ID: <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
Date:   Fri, 15 Jul 2022 13:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 07/10] sched/fair: use update_load_avg() to
 attach/detach entity load_avg
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-8-zhouchengming@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220713040430.25778-8-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:04, Chengming Zhou wrote:
> Since update_load_avg() support DO_ATTACH and DO_DETACH now, we can
> use update_load_avg() to implement attach/detach entity load_avg.
> 
> Another advantage of using update_load_avg() is that it will check
> last_update_time before attach or detach, instead of unconditional
> attach/detach in the current code.
> 
> This way can avoid some corner problematic cases of load tracking,
> like twice attach problem, detach unattached NEW task problem.

This explanation is somewhat hard to follow for me. Since both issues
have been fixed already (you mention this further below) you're saying
that with you change you don't reintroduce them?

> 1. switch to fair class (twice attach problem)
> 
> p->sched_class = fair_class;  --> p.se->avg.last_update_time = 0
> if (queued)
>   enqueue_task(p);
>     ...
>       enqueue_entity()
>         update_load_avg(UPDATE_TG | DO_ATTACH)
>           if (!se->avg.last_update_time && (flags & DO_ATTACH))  --> true
>             attach_entity_load_avg()  --> attached, will set last_update_time
> check_class_changed()
>   switched_from() (!fair)
>   switched_to()   (fair)
>     switched_to_fair()
>       attach_entity_load_avg()  --> unconditional attach again!
> 
> 2. change cgroup of NEW task (detach unattached task problem)
> 
> sched_move_group(p)
>   if (queued)
>     dequeue_task()
>   task_move_group_fair()
>     detach_task_cfs_rq()
>       detach_entity_load_avg()  --> detach unattached NEW task
>     set_task_rq()
>     attach_task_cfs_rq()
>       attach_entity_load_avg()
>   if (queued)
>     enqueue_task()
> 
> These problems have been fixed in commit 7dc603c9028e
> ("sched/fair: Fix PELT integrity for new tasks"), which also
> bring its own problems.
> 
> First, it add a new task state TASK_NEW and an unnessary limitation
> that we would fail when change the cgroup of TASK_NEW tasks.
> 
> Second, it attach entity load_avg in post_init_entity_util_avg(),
> in which we only set sched_avg last_update_time for !fair tasks,
> will cause PELT integrity problem when switched_to_fair().

I guess those PELT integrity problems are less severe since we have the
enqueue_task_fair() before the switched_to_fair() for enqueued tasks. So
we always decay the time the task spend outside fair.

Looks to me that you want to replace this by your `freeze PELT when
outside fair` model.

> This patch make update_load_avg() the only location of attach/detach,
> and can handle these corner cases like change cgroup of NEW tasks,
> by checking last_update_time before attach/detach.

[...]

> @@ -11527,9 +11522,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
>  	/* Catch up with the cfs_rq and remove our load when we leave */
> -	update_load_avg(cfs_rq, se, 0);
> -	detach_entity_load_avg(cfs_rq, se);
> -	update_tg_load_avg(cfs_rq);
> +	update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);

IMHO, the DO_[DE|AT]TACH comments in update_load_avg() would have to be
updated in this case.

[...]
