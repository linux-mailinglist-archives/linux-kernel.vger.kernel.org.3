Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E3C47C412
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhLUQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbhLUQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:45:40 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE52C061401;
        Tue, 21 Dec 2021 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=JIgd2jfSglzRbcIc1E1/BJx1EyWbvswuVDf/T+cKOFE=; b=ZM5l
        zLSsClu4WEGbXKyIl3KyKKSdqobTBDDs141ifYCZ1YvcQqVoSFZ3xO2qBLuEiQq+uVgOo/t5+XKrc
        f3CGlQUk0I6cTwnOa/f9RrWCYwB8Nn0qek4QNJ6gq1CU2kfidJYQGgxeQNTBY77eSDTFtFNieHC3C
        0O7P9M/baOlLXmugzwjmwDnD1F4V/b72HzuMlugmoBiX/bfRnMrTun8tFDD575Q5vGwWJ0B78pEXR
        xxh1pF6V2C1c7Z05WTAIu+YmYp2jzcYcz51ZO67z8UYu4aRLhkh3RTnCPoL93KBx9TBWADoYHHcEJ
        NM2+S9uWQvmHh63q858/8ooEDPA5YA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mziGX-00060B-3Y; Tue, 21 Dec 2021 16:45:29 +0000
Date:   Tue, 21 Dec 2021 16:45:28 +0000
From:   John Keeping <john@metanate.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
Message-ID: <20211221164528.3c84543f.john@metanate.com>
In-Reply-To: <87zgou6iq1.mognet@arm.com>
References: <Yb3vXx3DcqVOi+EA@donbot>
        <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com>
        <87zgou6iq1.mognet@arm.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 16:11:34 +0000
Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 20/12/21 18:35, Dietmar Eggemann wrote:
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index ef8228d19382..798887f1eeff 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1895,9 +1895,17 @@ static int push_rt_task(struct rq *rq, bool pull)
> >                 struct task_struct *push_task = NULL;
> >                 int cpu;
> >
> > +               if (WARN_ON_ONCE(!rt_task(rq->curr))) {
> > +                       printk("next_task=[%s %d] rq->curr=[%s %d]\n",
> > +                              next_task->comm, next_task->pid, rq->curr->comm, rq->curr->pid);
> > +               }
> > +
> >                 if (!pull || rq->push_busy)
> >                         return 0;
> >
> > +               if (!rt_task(rq->curr))
> > +                       return 0;
> > +  
> 
> If current is a DL/stopper task, why not; if that's CFS (which IIUC is your
> case), that's buggered: we shouldn't be trying to pull RT tasks when we
> have queued RT tasks and a less-than-RT current, we should be rescheduling
> right now.
> 
> I'm thinking this can happen via rt_mutex_setprio() when we demote an RT-boosted
> CFS task (or straight up sched_setscheduler()):
> check_class_changed()->switched_from_rt() doesn't trigger a resched_curr(),
> so I suspect we get to the push/pull callback before getting a
> resched (I actually don't see where we'd get a resched in that case other
> than at the next tick).
> 
> IOW, feels like we want the below. Unfortunately I can't reproduce the
> issue locally (yet), so that's untested.

This patch doesn't make any difference for me - I hit the BUG on the
first boot with this applied.

> ---
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fd7c4f972aaf..7d61ceec1a3b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2467,10 +2467,13 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>  	 * this is the right place to try to pull some other one
>  	 * from an overloaded CPU, if any.
>  	 */
> -	if (!task_on_rq_queued(p) || rq->dl.dl_nr_running)
> +	if (!task_on_rq_queued(p))
>  		return;
>  
> -	deadline_queue_pull_task(rq);
> +	if (!rq->dl.dl_nr_running)
> +		deadline_queue_pull_task(rq);
> +	else if (task_current(rq, p) && (p->sched_class < &dl_sched_class))
> +		resched_curr(rq);
>  }
>  
>  /*
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ef8228d19382..1ea2567612fb 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2322,10 +2322,13 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
>  	 * we may need to handle the pulling of RT tasks
>  	 * now.
>  	 */
> -	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
> +	if (!task_on_rq_queued(p))
>  		return;
>  
> -	rt_queue_pull_task(rq);
> +	if (!rq->rt.rt_nr_running)
> +		rt_queue_pull_task(rq);
> +	else if (task_current(rq, p) && (p->sched_class < &rt_sched_class))
> +		resched_curr(rq);
>  }
>  
>  void __init init_sched_rt_class(void)

