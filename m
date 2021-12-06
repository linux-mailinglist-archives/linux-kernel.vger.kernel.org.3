Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9EC469314
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbhLFKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:01:30 -0500
Received: from foss.arm.com ([217.140.110.172]:52664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241662AbhLFKB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:01:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767E411FB;
        Mon,  6 Dec 2021 01:57:59 -0800 (PST)
Received: from ubiquitous (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6811C3F73D;
        Mon,  6 Dec 2021 01:57:58 -0800 (PST)
Date:   Mon, 6 Dec 2021 09:57:47 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/fair: Fix detection of per-CPU kthreads waking
 a task
Message-ID: <20211206095747.GA486204@ubiquitous>
References: <20211201143450.479472-1-vincent.donnefort@arm.com>
 <20211204095316.GQ16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204095316.GQ16608@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 10:53:16AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 01, 2021 at 02:34:50PM +0000, Vincent Donnefort wrote:
> > select_idle_sibling() has a special case for tasks woken up by a per-CPU
> > kthread, where the selected CPU is the previous one. However, the current
> > condition for this exit path is incomplete. A task can wake up from an
> > interrupt context (e.g. hrtimer), while a per-CPU kthread is running. A
> > such scenario would spuriously trigger the special case described above.
> > Also, a recent change made the idle task like a regular per-CPU kthread,
> > hence making that situation more likely to happen
> > (is_per_cpu_kthread(swapper) being true now).
> > 
> > Checking for task context makes sure select_idle_sibling() will not
> > interpret a wake up from any other context as a wake up by a per-CPU
> > kthread.
> > 
> > Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > ---
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 945d987246c5..56db4ae85995 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  	 * pattern is IO completions.
> >  	 */
> >  	if (is_per_cpu_kthread(current) &&
> > +	    in_task() &&
> >  	    prev == smp_processor_id() &&
> >  	    this_rq()->nr_running <= 1) {
> >  		return prev;
> 
> Hurmph, so now I have two 'trivial' patches from you that touch this
> same function and they's conflicting. I've fixed it up, but perhaps it
> would've been nice to have them combined in a series or somesuch :-)
>

I definitely should have created a single patchset. Apologies for the
extra work and thanks for taking those two patches!

On another subject, in case you missed them, I also have two tiny fixes,
reviewed by Vincent:

[PATCH v2 1/2] sched/fair: Fix asym_fits_capacity() task_util type
[PATCH v2 2/2] sched/fair: Fix task_fits_capacity() capacity type

