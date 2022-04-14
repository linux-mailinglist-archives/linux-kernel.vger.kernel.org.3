Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2064C501E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346977AbiDNW2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiDNW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:28:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DBAAC1CB5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:26:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D47D23A;
        Thu, 14 Apr 2022 15:26:10 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56E63F73B;
        Thu, 14 Apr 2022 15:26:07 -0700 (PDT)
Date:   Thu, 14 Apr 2022 23:26:02 +0100
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
Message-ID: <20220414222412.r5gn66lyg6zo4gq3@airbuntu>
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu>
 <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
 <20220413235121.tzefvdvnwcipzo7p@airbuntu>
 <c831736b76c3411baea48a7c3e18cf4d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c831736b76c3411baea48a7c3e18cf4d@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/22 06:09, David Laight wrote:

[...]

> > > That seems to be something different.
> > > Related to something else I've seen where a RT process is scheduled
> > > on its old cpu (to get the hot cache) but the process running on
> > > that cpu is looping in kernel - so the RT process doesn't start.
> > 
> > I *think* you're hitting softirq latencies. Most likely it's the network RX
> > softirq processing the packets. If this latency is a problem, then PREEMPT_RT
> > [1] should help with this. For Android we hit this issue and there's a long
> > living out of tree patch that I'm trying to find an upstream replacement for.
> 
> I suspect the costs of PREEMPT_RT would slow things down too much.

It shouldn't.. If it did it's worth reporting to the RT folks, or consider
whether some bad usage in userspace is causing the problem.

linux-rt-users mailing list is a good place to ask questions. The details are
in the link to linuxfoundation realtime wiki page.

> This test system has 40 cpu, 35 of them are RT and processing the same 'jobs'.
> It doesn't really matter if one is delayed by the network irq + softirq code.
> The problems arise if they all stop.
> The 'job' list was protected by a mutex - usually not too bad.
> But if a network irq interrupts the code while it holds the mutex then all
> the RT tasks stall until the softirq code completes.
> I've replaced the linked list with an array and used atomic_inc().

I see. So an interrupt that happens in the wrong time could block everything.

You can try 'threadirqs' kernel parameter to see if this helps. PREEMPT_RT will
help with softirq latencies too. So I think this problem should be handled by
PREEMPT_RT.

There's _probably_ room for improving how userspace manages the job list too..
Do the readers have to block?

You can use irq affinities and task affinities to ensure the two never happen
on the same cpu.

> I can imagine that a PREEMPT_RT kernel will have the same problem
> because (I think) all the spin locks get replaced by sleep locks.

I don't think so. The point of PREEMPT_RT is to not block that RT tasks. With
PREEMPT_RT + threadirqs, irqs and softirqs will run as kernel threads. I think
they run as RT tasks, so you can manage which is more important by assigning
the right priorities to your tasks vs irq/softirqs kthreads priorities.

> 
> > 
> > There's a new knob to reduce how long netdev spends in the loop. Might be worth
> > a try:
> > 
> > 	https://lore.kernel.org/netdev/1492619830-7561-1-git-send-email-tedheadster@gmail.com/
> > 
> > [1] https://wiki.linuxfoundation.org/realtime/start
> 
> I think the patch that runs the softirq in a separate thread might help.
> But it probably needs a test to only to that if it would 'stall' a RT process.

I think people have been using this in rt-kernels for a long time now.
I believe you'd just need to be mindful about priorities since they'll run as
RT tasks.

threadirqs kernel parameter is available in mainline kernel too. But the
softirqs part still didn't get merged, last I checked which was a while ago.
So in mainline irqs will get threaded, but not softirqs - when I last checked.

You might find good info here about tuning systems for RT from Red Hat:

	https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_for_real_time/7/html/tuning_guide/interrupt_and_process_binding

There's lots of advise regarding various aspects of the system, so worth
exploring if you didn't come across it before.

> 
> > > I've avoided most of the pain that caused by not using a single
> > > cv_broadcast() to wake up the 34 RT threads (in this config).
> > > (Each kernel thread seemed to wake up the next one, so the
> > > delays were cumulative.)
> > > Instead there is a separate cv for each RT thread.
> > > I actually want the 'herd of wildebeest' :-)
> > 
> > It seems you have a big RT app running in userspace. I thought initially you're
> > hitting issues with random kthreads or something. If you have control over
> > these tasks, then that should be easier to handle (as you suggest at the end).
> 
> I've a big app with a lot of RT threads doing network send/receive.
> (All the packets as ~200 byte UDP, 50/sec on 1000+ port numbers.)
> But there are other things going on as well.
> 
> > I'm not sure about the delays when using cv_broadcast(). Could it be the way
> > this library is implemented is causing the problem rather than a kernel
> > limitation?
> 
> I was definitely seeing the threads wake up one by one.
> Every 10ms one of the RT threads wakes up and then wakes up all the others.
> There weren't any 'extra' system calls, once one thread was running
> in kernel the next one got woken up.
> Most (and always) noticeable were the delays getting each cpu out
> of its sleep state.

Oh, yeah idle states and dvfs are known sources of latencies. You can prevent
the cpus from going into deep idle states.

	https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_for_real_time/8/html-single/optimizing_rhel_8_for_real_time_for_low_latency_operation/index#con_power-saving-states_assembly_controlling-power-management-transitions

> But if one of the required cpu was (eg) running the softint code
> none of the latter ones would wake up.
> 

[...]

> > If you make it an RT task (which I think is a good idea), then the RT scheduler
> > will handle it in the push/pull remark that seem to have started this
> > discussion and get pushed/pulled to another CPU that is running lower priority
> > task.
> 
> The problem is that while I'd like this thread to start immediately
> what it is doing isn't THAT important.
> There are other things that might run on the CFS scheduler that are
> more important.
> I can make it RT for experiments.

You can isolate 35 cpus if you like to run your RT app and keep the remaining
5 cpus for everything else. Depends what else you use the system for. The red
hat guide I pasted above have a section on using isolated cpus feature.

	https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_for_real_time/7/html/tuning_guide/isolating_cpus_using_tuned-profiles-realtime

Although this seems a bit of a stretch for your use case. You can still use
irq and task affinities to ensure certain things don't happen on the same CPU.

Cheers

--
Qais Yousef
