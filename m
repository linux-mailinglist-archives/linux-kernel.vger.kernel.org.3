Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9347C38D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbhLUQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:11:43 -0500
Received: from foss.arm.com ([217.140.110.172]:55728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239532AbhLUQLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:11:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38E6ED1;
        Tue, 21 Dec 2021 08:11:41 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 586663F774;
        Tue, 21 Dec 2021 08:11:40 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
In-Reply-To: <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com>
References: <Yb3vXx3DcqVOi+EA@donbot> <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com>
Date:   Tue, 21 Dec 2021 16:11:34 +0000
Message-ID: <87zgou6iq1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/21 18:35, Dietmar Eggemann wrote:
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ef8228d19382..798887f1eeff 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1895,9 +1895,17 @@ static int push_rt_task(struct rq *rq, bool pull)
>                 struct task_struct *push_task = NULL;
>                 int cpu;
>
> +               if (WARN_ON_ONCE(!rt_task(rq->curr))) {
> +                       printk("next_task=[%s %d] rq->curr=[%s %d]\n",
> +                              next_task->comm, next_task->pid, rq->curr->comm, rq->curr->pid);
> +               }
> +
>                 if (!pull || rq->push_busy)
>                         return 0;
>
> +               if (!rt_task(rq->curr))
> +                       return 0;
> +

If current is a DL/stopper task, why not; if that's CFS (which IIUC is your
case), that's buggered: we shouldn't be trying to pull RT tasks when we
have queued RT tasks and a less-than-RT current, we should be rescheduling
right now.

I'm thinking this can happen via rt_mutex_setprio() when we demote an RT-boosted
CFS task (or straight up sched_setscheduler()):
check_class_changed()->switched_from_rt() doesn't trigger a resched_curr(),
so I suspect we get to the push/pull callback before getting a
resched (I actually don't see where we'd get a resched in that case other
than at the next tick).

IOW, feels like we want the below. Unfortunately I can't reproduce the
issue locally (yet), so that's untested.

---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fd7c4f972aaf..7d61ceec1a3b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2467,10 +2467,13 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	 * this is the right place to try to pull some other one
 	 * from an overloaded CPU, if any.
 	 */
-	if (!task_on_rq_queued(p) || rq->dl.dl_nr_running)
+	if (!task_on_rq_queued(p))
 		return;
 
-	deadline_queue_pull_task(rq);
+	if (!rq->dl.dl_nr_running)
+		deadline_queue_pull_task(rq);
+	else if (task_current(rq, p) && (p->sched_class < &dl_sched_class))
+		resched_curr(rq);
 }
 
 /*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ef8228d19382..1ea2567612fb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2322,10 +2322,13 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	 * we may need to handle the pulling of RT tasks
 	 * now.
 	 */
-	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
+	if (!task_on_rq_queued(p))
 		return;
 
-	rt_queue_pull_task(rq);
+	if (!rq->rt.rt_nr_running)
+		rt_queue_pull_task(rq);
+	else if (task_current(rq, p) && (p->sched_class < &rt_sched_class))
+		resched_curr(rq);
 }
 
 void __init init_sched_rt_class(void)
