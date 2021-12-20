Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6F47A7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhLTKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:48:09 -0500
Received: from foss.arm.com ([217.140.110.172]:52110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhLTKsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:48:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38F171042;
        Mon, 20 Dec 2021 02:48:07 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE11A3F718;
        Mon, 20 Dec 2021 02:48:05 -0800 (PST)
Date:   Mon, 20 Dec 2021 10:48:03 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/sugov: Ignore 'busy' filter when rq is capped
 by uclamp_max
Message-ID: <20211220104803.lejehpl44p3b4gvg@e107158-lin.cambridge.arm.com>
References: <20211216225320.2957053-1-qais.yousef@arm.com>
 <20211216225320.2957053-2-qais.yousef@arm.com>
 <CAJZ5v0h4xWs5EregN4nM-WEJYtQ8hyfdrEybyy6eZsaqSFaNmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h4xWs5EregN4nM-WEJYtQ8hyfdrEybyy6eZsaqSFaNmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 16:54, Rafael J. Wysocki wrote:
> On Thu, Dec 16, 2021 at 11:53 PM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > sugov_update_single_{freq, perf}() contains a 'busy' filter that ensures
> > we don't bring the frqeuency down if there's no idle time (CPU is busy).
> >
> > The problem is that with uclamp_max we will have scenarios where a busy
> > task is capped to run at a lower frequency and this filter prevents
> > applying the capping when this task starts running.
> >
> > We handle this by skipping the filter when uclamp is enabled and the rq
> > is being capped by uclamp_max.
> >
> > We introduce a new function uclamp_rq_is_capped() to help detecting when
> > this capping is taking effect. Some code shuffling was required to allow
> > using cpu_util_{cfs, rt}() in this new function.
> >
> > On 2 Core SMT2 Intel laptop I see:
> >
> > Without this patch:
> >
> >         uclampset -M 0 sysbench --test=cpu --threads = 4 run
> >
> > produces a score of ~3200 consistently. Which is the highest possible.
> >
> > Compiling the kernel also results in frequency running at max 3.1GHz all
> > the time - running uclampset -M 400 to cap it has no effect without this
> > patch.
> >
> > With this patch:
> >
> >         uclampset -M 0 sysbench --test=cpu --threads = 4 run
> >
> > produces a score of ~1100 with some outliers in ~1700. Uclamp max
> > aggregates the performance requirements, so having high values sometimes
> > is expected if some other task happens to require that frequency starts
> > running at the same time.
> >
> > When compiling the kernel with uclampset -M 400 I can see the
> > frequencies mostly in the ~2GHz region. Helpful to conserve power and
> > prevent heating when not plugged in.
> >
> > Fixes: 982d9cdc22c9 ("sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks")
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >
> > I haven't dug much into the busy filter, but I assume it is something that is
> > still required right?
> 
> It is AFAICS.
> 
> > If there's a better alternative we can take to make this
> > filter better instead, I'm happy to hear ideas. Otherwise hopefully this
> > proposal is logical too.
> 
> It looks reasonable to me.
> 
> For the schedutil changes:
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for having a look!

Cheers

--
Qais Yousef
