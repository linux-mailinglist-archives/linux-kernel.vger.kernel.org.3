Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4547BC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhLUJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:09:17 -0500
Received: from foss.arm.com ([217.140.110.172]:46810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhLUJJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:09:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 076216D;
        Tue, 21 Dec 2021 01:09:16 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 983B03F5A1;
        Tue, 21 Dec 2021 01:09:14 -0800 (PST)
Date:   Tue, 21 Dec 2021 10:09:08 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, qperret@google.com
Subject: Re: [PATCH 1/3] sched/fair: Make cpu_overutilized() EAS dependent
Message-ID: <20211221090444.GA2747@ubiquitous>
References: <20211220114323.22811-1-vincent.donnefort@arm.com>
 <20211220114323.22811-2-vincent.donnefort@arm.com>
 <875yrj8acq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yrj8acq.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:17:09PM +0000, Valentin Schneider wrote:
> On 20/12/21 12:43, Vincent Donnefort wrote:
> > On a system with Energy Aware Scheduling (EAS), tasks are placed according
> > to their energy consumption estimation and load balancing is disabled to
> > not break that energy biased placement. If the system becomes
> > overutilized, i.e. one of the CPU has too much utilization, energy
> > placement would then be disabled, in favor of Capacity-Aware Scheduling
> > (CAS), including load balancing. This is the sole usage for
> > rd->overutilized. Hence, there is no need to raise it for !EAS systems.
> >
> > Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> 
> I'm not sure a Fixes: is warranted, this does not fix any misbehaviour or
> performance regression (even if this might gain us a few extra IPS by not
> writing 1's to rd->overutilized on SMP systems, note that this still gives
> us writes of 0's).

I put the tag to make sure this patch would be taken for stable releases
with:

  [PATCH 2/3] sched/fair: Fix newidle_balance() for overutilized systems

Without the EAS requirement for cpu_overutilized() (patch 1/3), patch 2/3
could lead to useless newidle_balance() for !EAS systems.

Maybe that means in the end 2/3 and 1/3 should be squashed?

> 
> Regardless:
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 095b0aa378df..e2f6fa14e5e7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5511,7 +5511,8 @@ static inline void hrtick_update(struct rq *rq)
> >  #ifdef CONFIG_SMP
> >  static inline bool cpu_overutilized(int cpu)
> >  {
> > -	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
> > +	return sched_energy_enabled() &&
> > +	       !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
> >  }
> >
> >  static inline void update_overutilized_status(struct rq *rq)
> > --
> > 2.25.1
