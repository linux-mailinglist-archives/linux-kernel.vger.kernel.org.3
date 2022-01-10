Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E26489DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbiAJQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:40:32 -0500
Received: from foss.arm.com ([217.140.110.172]:36378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237627AbiAJQkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:40:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B01292B;
        Mon, 10 Jan 2022 08:40:31 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FD583F5A1;
        Mon, 10 Jan 2022 08:40:30 -0800 (PST)
Date:   Mon, 10 Jan 2022 16:40:27 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, Morten.Rasmussen@arm.com,
        qperret@google.com
Subject: Re: [PATCH 3/3] sched/fair: Do not raise overutilized for idle CPUs
Message-ID: <Ydxhe7wkHsq5U6Gk@FVFF7649Q05P>
References: <20211220114323.22811-1-vincent.donnefort@arm.com>
 <20211220114323.22811-4-vincent.donnefort@arm.com>
 <CAKfTPtDjVdPimPbOes5Oix=3NYi3ZWY1dvQjZY3hoMfYbxXuDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDjVdPimPbOes5Oix=3NYi3ZWY1dvQjZY3hoMfYbxXuDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:20:17AM +0100, Vincent Guittot wrote:
> On Mon, 20 Dec 2021 at 12:43, Vincent Donnefort
> <vincent.donnefort@arm.com> wrote:
> >
> > During a migration, the lock for the previous runqueue is not taken and
> > hence, the task contribution isn't directly removed from that runqueue
> > utilization but instead temporarily saved, until the next PELT signals
> > update where it would be accounted. There is then a window in which a
> > CPU can ben idle be nonetheless overutilized.
> >
> > The load balancer wouldn't be able to do anything to help a sleeping CPU,
> > it brings then no gain to raise overutilized there, only the risk of
> > spuriously doing it.
> 
> But how do you make the difference between a very short idle time of
> an overutilized CPU and a idle cpu with outdated utilization

No distinction here, but if the CPU is idle there's nothing to pull, so the load
balance wouldn't do anything with this information.

> 
> Being idle is not a good reason for not being overutilized (ie ~80% of
> average utilisation)
> 
> >
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 51f6f55abb37..37f737c5f0b8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8641,26 +8641,28 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >
> >                 nr_running = rq->nr_running;
> >                 sgs->sum_nr_running += nr_running;
> > -
> > -               if (nr_running > 1)
> > -                       *sg_status |= SG_OVERLOAD;
> > -
> > -               if (cpu_overutilized(i))
> > -                       *sg_status |= SG_OVERUTILIZED;
> > -
> >  #ifdef CONFIG_NUMA_BALANCING
> >                 sgs->nr_numa_running += rq->nr_numa_running;
> >                 sgs->nr_preferred_running += rq->nr_preferred_running;
> >  #endif
> > +               if (nr_running > 1)
> > +                       *sg_status |= SG_OVERLOAD;
> 
> Why do you move this code related to overload ?

This was a cosmetic change to put the NUMA related stats next to the other ones.

[...]
