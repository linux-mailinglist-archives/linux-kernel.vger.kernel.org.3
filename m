Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5D495D97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379973AbiAUKRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:17:42 -0500
Received: from foss.arm.com ([217.140.110.172]:47230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379968AbiAUKR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:17:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1AB7ED1;
        Fri, 21 Jan 2022 02:17:25 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 609983F73D;
        Fri, 21 Jan 2022 02:17:23 -0800 (PST)
Date:   Fri, 21 Jan 2022 10:17:20 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Chitti Babu Theegala <quic_ctheegal@quicinc.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, joel@joelfernandes.org,
        linux-arm-msm@vger.kernel.org, quic_lingutla@quicinc.com,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com
Subject: Re: [PATCH] sched/fair: Prefer small idle cores for forkees
Message-ID: <YeqIMAqeP9ou7QFr@FVFF7649Q05P>
References: <20220112143902.13239-1-quic_ctheegal@quicinc.com>
 <YeBRD9zKSLPBFX+j@FVFF7649Q05P>
 <b528a922-da84-32c2-963f-458b1e834c15@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b528a922-da84-32c2-963f-458b1e834c15@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 10:15:07PM +0530, Chitti Babu Theegala wrote:
> 
> 
> On 1/13/2022 10:05 PM, Vincent Donnefort wrote:
> > On Wed, Jan 12, 2022 at 08:09:02PM +0530, Chitti Babu Theegala wrote:
> > > Newly forked threads don't have any useful utilization data yet and
> > > it's not possible to forecast their impact on energy consumption.
> > > update_pick_idlest These forkees (though very small, most times) end up waking big
> > > cores from deep sleep for that very small durations.
> > > 
> > > Bias all forkees to small cores to prevent waking big cores from deep
> > > sleep to save power.
> > 
> > This bias might be interesting for some workloads, but what about the
> > others? (see find_energy_efficient_cpu() comment, which discusses forkees).
> > 
> 
> Yes, I agree with the find_energy_efficient_cpu() comment that we don't have
> any useful utilization data yet and hence not possible to forecast. However,
> I don't see any point in penalizing the power by waking up bigger cores
> which are in deep sleep state for very small workloads.
> 
> This patch helps lighter workloads during idle conditions w.r.t power POV.
> For active (interactive or heavier) workloads, on most big.Little systems'
> these foreground tasks get pulled into gold affined cpu-sets where this
> patch would not play any spoilsport. Even for systems with such cpu-sets not
> defined, heavy workloads might need just another 1 or 2 scheduling windows
> for ramping to better freq or core.

Scheduling windows? I suppose you do not refer to PELT here, so I'm not sure
this argument applies here.

Beside, CFS always bias toward performance (except feec(), which does it in a
lesser extent).

> 
> > > 
> > > Signed-off-by: Chitti Babu Theegala <quic_ctheegal@quicinc.com>
> > > ---
> > >   kernel/sched/fair.c | 16 +++++++++++-----
> > >   1 file changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 6e476f6..d407bbc 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5976,7 +5976,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> > >   }
> > >   static struct sched_group *
> > > -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
> > > +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag);
> > >   /*
> > >    * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
> > > @@ -6063,7 +6063,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> > >   			continue;
> > >   		}
> > > -		group = find_idlest_group(sd, p, cpu);
> > > +		group = find_idlest_group(sd, p, cpu, sd_flag);
> > >   		if (!group) {
> > >   			sd = sd->child;
> > >   			continue;
> > > @@ -8997,7 +8997,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> > >   static bool update_pick_idlest(struct sched_group *idlest,
> > >   			       struct sg_lb_stats *idlest_sgs,
> > >   			       struct sched_group *group,
> > > -			       struct sg_lb_stats *sgs)
> > > +			       struct sg_lb_stats *sgs,
> > > +			       int sd_flag)
> > >   {
> > >   	if (sgs->group_type < idlest_sgs->group_type)
> > >   		return true;
> > > @@ -9034,6 +9035,11 @@ static bool update_pick_idlest(struct sched_group *idlest,
> > >   		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
> > >   			return false;
> > > +		/* Select smaller cpu group for newly woken up forkees */
> > > +		if ((sd_flag & SD_BALANCE_FORK) && (idlest_sgs->idle_cpus &&
> > > +			!capacity_greater(idlest->sgc->max_capacity, group->sgc->max_capacity)))
> > > +			return false;
> > > +
> > 
> > Energy biased placement should probably be applied only when EAS is enabled.
> > 
> > It's especially true here, if all CPUs have the same capacity, capacity_greater
> > would be always false. So unless I missed something, we wouldn't let the group_util
> > evaluation happen, would we?
> 
> True. I am uploading new version patch with a EAS enablement check in place.
> 
> > 
> > [...]
