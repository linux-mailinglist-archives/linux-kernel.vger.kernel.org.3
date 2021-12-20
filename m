Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD047B0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhLTQKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:10:01 -0500
Received: from foss.arm.com ([217.140.110.172]:58502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234155AbhLTQJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:09:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EE8F1FB;
        Mon, 20 Dec 2021 08:09:57 -0800 (PST)
Received: from ubiquitous (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6615F3F774;
        Mon, 20 Dec 2021 08:09:55 -0800 (PST)
Date:   Mon, 20 Dec 2021 17:09:42 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, lukasz.luba@arm.com
Subject: Re: [PATCH 2/4] sched/fair: Decay task PELT values during migration
Message-ID: <20211220155735.GA51378@ubiquitous>
References: <20211209161159.1596018-1-vincent.donnefort@arm.com>
 <20211209161159.1596018-3-vincent.donnefort@arm.com>
 <daa01574-5d7b-c125-48a9-d1ec7bd1fb64@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa01574-5d7b-c125-48a9-d1ec7bd1fb64@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:26:23PM +0100, Dietmar Eggemann wrote:
> On 09.12.21 17:11, Vincent Donnefort wrote:
> 
> [...]
> 
> > @@ -6899,6 +6899,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >  
> >  static void detach_entity_cfs_rq(struct sched_entity *se);
> >  
> > +static u64 rq_clock_pelt_estimator(struct rq *rq)
> > +{
> > +	u64 pelt_lag = sched_clock_cpu(cpu_of(rq)) -
> > +		       u64_u32_load(rq->clock_pelt_lag);
> > +
> > +	return cfs_rq_last_update_time(&rq->cfs) + pelt_lag;
> 
> Why do you use `avg.last_update_time` (lut) of the root cfs_rq here?
> 
> p's lut was just synced to cfs_rq_of(se)'s lut in
> 
> migrate_task_rq_fair() (1) -> remove_entity_load_avg() ->
> sync_entity_load_avg(se) (2)

Huum, indeed, the estimation is an offset on top of the se's last_update_time,
which I suppose could be different from the rq's cfs_rq.

I'll add a sched_entity argument for this function, to use either cfs_rq_of(se)
or se last_update_time

 
> [...]
> 
> > @@ -6924,26 +6934,29 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >  		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
> >  		 * rq->lock and can modify state directly.
> >  		 */
> > -		lockdep_assert_rq_held(task_rq(p));
> > -		detach_entity_cfs_rq(&p->se);
> > +		lockdep_assert_rq_held(rq);
> > +		detach_entity_cfs_rq(se);
> >  
> >  	} else {
> > +		remove_entity_load_avg(se);
> > +
> >  		/*
> > -		 * We are supposed to update the task to "current" time, then
> > -		 * its up to date and ready to go to new CPU/cfs_rq. But we
> > -		 * have difficulty in getting what current time is, so simply
> > -		 * throw away the out-of-date time. This will result in the
> > -		 * wakee task is less decayed, but giving the wakee more load
> > -		 * sounds not bad.
> > +		 * Here, the task's PELT values have been updated according to
> > +		 * the current rq's clock. But if that clock hasn't been
> > +		 * updated in a while, a substantial idle time will be missed,
> > +		 * leading to an inflation after wake-up on the new rq.
> > +		 *
> > +		 * Estimate the PELT clock lag, and update sched_avg to ensure
> > +		 * PELT continuity after migration.
> >  		 */
> > -		remove_entity_load_avg(&p->se);
> > +		__update_load_avg_blocked_se(rq_clock_pelt_estimator(rq), se);
> 
> We do __update_load_avg_blocked_se() now twice for p, 1. in (2) and then
> in (1) again.

the first __update_load_avg_blocked_se() ensures the se is aligned with the
cfs_rq's clock and then, update the "removed" struct accordingly. We couldn't
use the estimator there, it would break that structure.

> 
> [...]
> 
