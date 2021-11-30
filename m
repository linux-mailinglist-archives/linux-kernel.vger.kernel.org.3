Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4BE46324A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhK3L1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:27:36 -0500
Received: from foss.arm.com ([217.140.110.172]:35162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238891AbhK3L1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:27:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CEDF1063;
        Tue, 30 Nov 2021 03:23:59 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 732723F766;
        Tue, 30 Nov 2021 03:23:58 -0800 (PST)
Date:   Tue, 30 Nov 2021 11:23:56 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: Fix rq->uclamp_max not set on first enqueue
Message-ID: <20211130112356.25bm5s66sywtdgw4@e107158-lin.cambridge.arm.com>
References: <20211125165233.1425633-1-qais.yousef@arm.com>
 <87wnkvb35n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnkvb35n.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin

On 11/26/21 10:51, Valentin Schneider wrote:
> On 25/11/21 16:52, Qais Yousef wrote:
> > Commit d81ae8aac85c ("sched/uclamp: Fix initialization of struct
> > uclamp_rq") introduced a bug where uclamp_max of the rq is not reset to
> > match the woken up task's uclamp_max when the rq is idle. This only
> > impacts the first wake up after enabling the static key. And it only
> 
> Wouldn't that rather be all wakeups after enabling the static key, until
> the rq goes idle and gains UCLAMP_FLAG_IDLE? e.g. if you enqueue N
> uclamp_max=512 tasks, the first enqueue flips the static key and the rq
> max-aggregate will stay at 1024 after the remaining enqueues.

Yep. Bad phrasing from my side. How about:

"This is visible from first wake up(s) until the first dequeue to idle after
enabling the static key"?

> 
> > matters if the uclamp_max of this task is < 1024 since only then its
> > uclamp_max will be effectively ignored.
> >
> > Fix it by properly initializing rq->uclamp_flags = UCLAMP_FLAG_IDLE to
> > ensure we reset rq uclamp_max when waking up from idle.
> >
> > Fixes: d81ae8aac85c ("sched/uclamp: Fix initialization of struct uclamp_rq")
> 
> Looking at this again, I'm starting to think this actually stems from the
> introduction of the flag:
> 
>   e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
> 
> Before the commit you point at, we would still initialize ->uclamp_flags to
> 0. This was probably hidden by all the activity at boot-time (e.g. just
> unparking smpboot threads) which yielded an nr_running>0 -> nr_running==0
> transition, IOW we'd most likely get UCLAMP_FLAG_IDLE set on a rq before
> any userspace task could get on there.
> 
> The static key would have only made this problem more visible.

Hmm. I can't see the sequence of events. I guess you could argue in theory that
this commit should have initialized the ->uclamp_flags to UCLAMP_FLAG_IDLE but
I think it used to work because uc_rq->value = 0 by default

	static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
					    enum uclamp_id clamp_id)
	{
		...

		if (uc_se->value > READ_ONCE(uc_rq->value))
			WRITE_ONCE(uc_rq->value, uc_se->value);
	}

The commit I point to changed makes uc_rq->value = 1024 by default, hence we
miss the first update.

I don't mind updating the FIXES tag here, though AFAICT there's no visible side
effect from it.

> 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> 
> Changelog nitpicking aside:
> Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>

Thanks!

--
Qais Yousef
