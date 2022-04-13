Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CC5002D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiDMXx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiDMXxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:53:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7524851E4D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:51:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E594E1424;
        Wed, 13 Apr 2022 16:51:29 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D9E33F73B;
        Wed, 13 Apr 2022 16:51:27 -0700 (PDT)
Date:   Thu, 14 Apr 2022 00:51:21 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "Valentin.Schneider@arm.com" <Valentin.Schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Wei Wang <wvw@google.com>
Subject: Re: Scheduling tasks on idle cpu
Message-ID: <20220413235121.tzefvdvnwcipzo7p@airbuntu>
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu>
 <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/22 08:39, David Laight wrote:
> From: Qais Yousef
> > Sent: 12 April 2022 00:35
> > 
> > On 04/11/22 08:26, David Laight wrote:
> > > From: Qais Yousef
> > > > Sent: 09 April 2022 18:09
> > > ...
> > > > RT scheduler will push/pull tasks to ensure the task will get to run ASAP if
> > > > there's another cpu at lower priority is available
> > >
> > > Does that actually happen?
> > 
> > For RT tasks, yes. They should get distributed.
> 
> Ok, that is something slightly different from what I'm seeing.

If you have multiple SCHED_FIFO/SCHED_RR tasks with the same priority, they
don't end up being distributed on different CPUs? Assuming number of tasks is
not higher than number of CPUs.

Generally if there are two RT tasks on the same CPU and there's another CPU
that is running something that is lower priority than these two, then the lower
priority of these 2 tasks should move to that CPU.

Eh, hope that's readable :-)

> 
> > > I've seen the following:
> > >   34533 [017]: sys_futex(uaddr: 1049104, op: 85, val: 1, utime: 1, uaddr2: 1049100, val3: 4000001)
> > >   34533 [017]: sched_migrate_task: pid=34512 prio=120 orig_cpu=14 dest_cpu=17
> > >   34533 [017]: sched_wakeup: pid=34512 prio=120 success=1 target_cpu=017
> > 
> > prio=120 is a CFS task, no?
> 
> CFS = 'normal time-slice processes ? Then yes.

Sorry, yes. CFS = SCHED_NORMAL/SCHED_OTHER.

> 
> > > and pid 34512 doesn't get scheduled until pid 34533 finally sleeps.
> > > This is in spite of there being 5 idle cpu.
> > > cpu 14 is busy running a RT thread, but migrating to cpu 17 seems wrong.
> > >
> > > This is on a RHEL7 kernel, I've not replicated it on anything recent.
> > > But I've very much like a RT thread to be able to schedule a non-RT
> > > thread to run on an idle cpu.
> > 
> > Oh, you want CFS to avoid CPUs that are running RT tasks.
> > 
> > We had a proposal in the past, but it wasn't good enough
> > 
> > 	https://lore.kernel.org/lkml/1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com/
> 
> That seems to be something different.
> Related to something else I've seen where a RT process is scheduled
> on its old cpu (to get the hot cache) but the process running on
> that cpu is looping in kernel - so the RT process doesn't start.

I *think* you're hitting softirq latencies. Most likely it's the network RX
softirq processing the packets. If this latency is a problem, then PREEMPT_RT
[1] should help with this. For Android we hit this issue and there's a long
living out of tree patch that I'm trying to find an upstream replacement for.

There's a new knob to reduce how long netdev spends in the loop. Might be worth
a try:

	https://lore.kernel.org/netdev/1492619830-7561-1-git-send-email-tedheadster@gmail.com/

[1] https://wiki.linuxfoundation.org/realtime/start

> 
> I've avoided most of the pain that caused by not using a single
> cv_broadcast() to wake up the 34 RT threads (in this config).
> (Each kernel thread seemed to wake up the next one, so the
> delays were cumulative.)
> Instead there is a separate cv for each RT thread.
> I actually want the 'herd of wildebeest' :-)

It seems you have a big RT app running in userspace. I thought initially you're
hitting issues with random kthreads or something. If you have control over
these tasks, then that should be easier to handle (as you suggest at the end).

I'm not sure about the delays when using cv_broadcast(). Could it be the way
this library is implemented is causing the problem rather than a kernel
limitation?

> 
> > The approach in that patch modified RT to avoid CFS actually.
> 
> Yes I want the CFS scheduler to pick an idle cpu in preference
> to an active RT one.

I think that's what should happen. But I think it's racy. Vincent knows this
code better though, so I'll defer to him.

> 
> > Can you verify whether the RT task woke up after task 34512 was migrated to CPU
> > 17? Looking at the definition of available_idle_cpu() we should have avoided
> > that CPU if the RT task was already running. Both waking up at the same time
> > would explain what you see. Otherwise I'm not sure why it picked CPU 17.
> 
> All 35 RT tasks are running when the request to schedule task 34512 is made.
> (They wake every 10ms to process UDP/RTP audio packets.)
> The RT task on cpu 17 carried on running until it ran out of work (after about 1ms).
> Task 34512 then ran on cpu 17.
> 
> In this case task 34512 actually finished quite quickly.
> (It is creating and binding more UDP sockets.)
> But it looks like if it were still running on the next 10ms 'tick'
> it would be pre-empted by the RT task and be idle.
> Not ideal when I'm trying to schedule a background activity.
> 
> I don't think the load-balancer will ever pick it up.
> All the process scheduling is happening far too fast.
> 
> What I think might be happening is that the futex() code is requesting
> the woken up thread run on the current cpu.

Hmm. Looking at kernel/futex/waitwake.c::futex_wake() it just ends up calling
wake_up_process(). So that might not be the case.

> This can be advantageous in some circumstances - usually if you
> know the current thread is about to sleep.
> (I remember another scheduler doing that, but I can't remember why!
> The only sequence I can think of is a shell doing fork+exec+wait.)
> But it seems like a bad idea when a RT thread is waking a CFS one.
> (Or any case where the one being woken is lower priority.)
> 
> I might have to run the 'background tasks' at low RT priority
> just to get them scheduled on idle cpu.

If you make it an RT task (which I think is a good idea), then the RT scheduler
will handle it in the push/pull remark that seem to have started this
discussion and get pushed/pulled to another CPU that is running lower priority
task.

Cheers

--
Qais Yousef
