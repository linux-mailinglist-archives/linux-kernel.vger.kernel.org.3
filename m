Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849AF461C42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346560AbhK2Q7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:59:54 -0500
Received: from foss.arm.com ([217.140.110.172]:43550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347633AbhK2Q5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:57:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3D11063;
        Mon, 29 Nov 2021 08:54:34 -0800 (PST)
Received: from ubiquitous (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B894E3F5A1;
        Mon, 29 Nov 2021 08:54:33 -0800 (PST)
Date:   Mon, 29 Nov 2021 16:54:25 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <Valentin.Schneider@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a
 task
Message-ID: <20211129164545.GA3981328@ubiquitous>
References: <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
 <8735nkcwov.mognet@arm.com>
 <CAKfTPtDPskVdEd-KQ_cwe-R_zVFPQOgdbk9x+3eD12pKs8fGFw@mail.gmail.com>
 <87zgpsb6de.mognet@arm.com>
 <CAKfTPtCnusWJXJLDEudQ_q8MWaZYbPJK-QjAbBYWFW8Nw-J+Ww@mail.gmail.com>
 <87sfvjavqk.mognet@arm.com>
 <CAKfTPtC4iXXaptm9+2bHvX2E3xAWU4M3xN0ZuwpFQ1RyXAyxyA@mail.gmail.com>
 <87pmqmc16f.mognet@arm.com>
 <20211126171817.GA3798214@ubiquitous>
 <CAKfTPtCGyp8JZq1EOgEhTeD+PBV2rMnTQ=uV-ZgsaN1RVmPk0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGyp8JZq1EOgEhTeD+PBV2rMnTQ=uV-ZgsaN1RVmPk0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > >
> > > > still i don't see the need of !is_idle_task(current)
> > > >
> > >
> > > Admittedly, belts and braces. The existing condition checks rq->nr_running <= 1
> > > which can lead to coscheduling when the wakeup is issued by the idle task
> > > (or even if rq->nr_running == 0, you can have rq->ttwu_pending without
> > > having sent an IPI due to polling). Essentially this overrides the first
> > > check in sis() that uses idle_cpu(target) (prev == smp_processor_id() ==
> > > target).
> > >
> > > I couldn't prove such wakeups can happen right now, but if/when they do
> > > (AIUI it would just take someone to add a wake_up_process() down some
> > > smp_call_function() callback) then we'll need the above. If you're still
> > > not convinced by now, I won't push it further.
> >
> > From a quick experiment, even with the asym_fits_capacity(), I can trigger
> > the following:
> >
> > [    0.118855] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> > [    0.128214] select_idle_sibling: wakee=rcu_gp:3 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> > [    0.137327] select_idle_sibling: wakee=rcu_par_gp:4 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> > [    0.147221] select_idle_sibling: wakee=kworker/u16:0:7 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> > [    0.156994] select_idle_sibling: wakee=mm_percpu_wq:8 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> 
> Timestamp shows its booting phase and thread name above shows per cpu
> thread. Could it happen just while creating per cpu thread at boot and
> as a result not relevant ?

I have more of those logs a bit later in the boot:

[    0.484791] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.516495] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.525758] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.535078] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.547486] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.579192] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1

The nr_cpus_allowed=8 suggest that none of the threads from the logs I
shared are per-CPU. Sorry if the format is confusing, I used:

  wakee=<comm>:<pid> current=<comm>:<pid>.

> 
> Can you see similar things later after booting ?

I tried few scenarios other than the boot time but none of them produced
"current=swapper/X:1 in_task=1"

> 
> I have tried to trigger the situation but failed to get wrong
> sequence. All are coming from interrupt while idle.
> After adding in_task() condition, I haven't been able to trigger the
> warn() that I added to catch the wrong situations on SMP, Heterogenous
> or NUMA system. Could you share more details on your setup ?
> 

This is just my Hikey960 with the asym_fits_capacity() fix [1] to make sure I
don't simply hit the other issue with asym platforms.

Then I just added my log in the per-CPU kthread wakee stacking exit path

    printk("%s: wakee=%s:%d nr_cpus_allowed=%d current=%s:%d in_task=%d\n",
            __func__, p->comm, p->pid, p->nr_cpus_allowed, current->comm, current->pid, in_task());


[1] https://lore.kernel.org/all/20211125101239.3248857-1-vincent.donnefort@arm.com/


From the same logs I also see:

  wakee=xfsaild/mmcblk0:4855 nr_cpus_allowed=8 current=kworker/1:1:1070 in_task=0

Doesn't that look like a genuine wakeup that would escape the per-CPU kthread
stacking exit path because of the in_task test?
