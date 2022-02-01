Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB24A601C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbiBAP2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:28:35 -0500
Received: from foss.arm.com ([217.140.110.172]:46980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240416AbiBAP2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:28:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB9711B3;
        Tue,  1 Feb 2022 07:28:20 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 498BB3F40C;
        Tue,  1 Feb 2022 07:28:18 -0800 (PST)
Subject: Re: [PATCH v2] sched/rt: Plug rt_mutex_setprio() vs push_rt_task()
 race
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20220127154059.974729-1-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c12765d4-6b0e-fd1a-8152-a68e6e56cbb8@arm.com>
Date:   Tue, 1 Feb 2022 16:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220127154059.974729-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 16:40, Valentin Schneider wrote:
> John reported that push_rt_task() can end up invoking
> find_lowest_rq(rq->curr) when curr is not an RT task (in this case a CFS
> one), which causes mayhem down convert_prio().
> 
> This can happen when current gets demoted to e.g. CFS when releasing an
> rt_mutex, and the local CPU gets hit with an rto_push_work irqwork before
> getting the chance to reschedule. Exactly who triggers this work isn't
> entirely clear to me - switched_from_rt() only invokes rt_queue_pull_task()
> if there are no RT tasks on the local RQ, which means the local CPU can't
> be in the rto_mask.
> 
> My current suspected sequence is something along the lines of the below,
> with the demoted task being current.
> 
>   mark_wakeup_next_waiter()
>     rt_mutex_adjust_prio()
>       rt_mutex_setprio() // deboost originally-CFS task
> 	check_class_changed()
> 	  switched_from_rt() // Only rt_queue_pull_task() if !rq->rt.rt_nr_running
> 	  switched_to_fair() // Sets need_resched
>       __balance_callbacks() // if pull_rt_task(), tell_cpu_to_push() can't select local CPU per the above
>       raw_spin_rq_unlock(rq)
> 
>        // need_resched is set, so task_woken_rt() can't
>        // invoke push_rt_tasks(). Best I can come up with is
>        // local CPU has rt_nr_migratory >= 2 after the demotion, so stays
>        // in the rto_mask, and then:
> 
>        <some other CPU running rto_push_irq_work_func() queues rto_push_work on this CPU>
> 	 push_rt_task()
> 	   // breakage follows here as rq->curr is CFS
> 
> Move an existing check to check rq->curr vs the next pushable task's
> priority before getting anywhere near find_lowest_rq(). While at it, add an
> explicit sched_class of rq->curr check prior to invoking
> find_lowest_rq(rq->curr). Align the DL logic to also reschedule regardless
> of next_task's migratability.
> 
> Link: http://lore.kernel.org/r/Yb3vXx3DcqVOi+EA@donbot
> Fixes: a7c81556ec4d ("sched: Fix migrate_disable() vs rt/dl balancing")
> Reported-by: John Keeping <john@metanate.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Tested-by: John Keeping <john@metanate.com>
> ---
> v1 -> v2: Reworded comments, added DL part (Dietmar)
> ---

LGTM.

Rescheduling in case rq->curr has lower prio (including CFS tasks) than
next_task and bailing out in case rq->curr is DL or stop-task prevents
the bug from happening.

The only small issue is the fact that, unlike in push_rt_task(), the DL
logic only compares DL tasks (if (dl_task(rq->curr) ...), so you miss
rescheduling when rq->curr is a lower priority non-DL task.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
