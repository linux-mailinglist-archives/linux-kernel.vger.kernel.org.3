Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E261472CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhLMNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:09:07 -0500
Received: from foss.arm.com ([217.140.110.172]:54478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhLMNI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:08:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22F771FB;
        Mon, 13 Dec 2021 05:08:58 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9007C3F793;
        Mon, 13 Dec 2021 05:08:56 -0800 (PST)
Date:   Mon, 13 Dec 2021 13:08:53 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Don't reschedule a throttled task even if it's
 higher priority
Message-ID: <20211213130853.gdywukt2ibxnwzse@e107158-lin.cambridge.arm.com>
References: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
 <CAD=FV=UZNxt7y6bTipyvYFGMJhgp6nRozNt=iEaOYP6yc4OFpg@mail.gmail.com>
 <CAJWu+ora8F0eurnYkSXRqcT4mB8k8wy9CyKj1EGk52vEVEkT3A@mail.gmail.com>
 <20211202111127.gew4lqquvtn3lkbc@e107158-lin.cambridge.arm.com>
 <CAD=FV=V8aB7_6tEq9SbW+vNC5Y7G+8JMsWXo6+zdtF3tmJ97EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=V8aB7_6tEq9SbW+vNC5Y7G+8JMsWXo6+zdtF3tmJ97EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug

Sorry for the delayed response.

On 12/02/21 10:05, Doug Anderson wrote:
> Hi,
> 
> On Thu, Dec 2, 2021 at 3:11 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > Hi Joel, Doug
> >
> > On 11/30/21 18:36, Joel Fernandes wrote:
> > > On Tue, Nov 30, 2021 at 11:30 AM Doug Anderson <dianders@chromium.org> wrote:
> > > > I know this isn't crazy urgent and I'm happy to sit and twiddle my
> > > > thumbs a bit longer if everyone is still sleepy from tryptophan, but
> > > > I'm curious if anyone had a chance to look at this. Can anyone confirm
> > > > that my script reproduces for them on something other than my system?
> > >
> > > Maybe +Qais Yousef can also chime in. Just to add, I think Doug's
> >
> > I could try :-)
> >
> > /me tries to find the original posting
> 
> Oops! I thought I had duplicated enough of the content in this patch.
> Should have included a reference. It's:
> 
> https://lore.kernel.org/r/CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com/
> 
> 
> > > issue is that under RT group scheduling, he expects *other* well
> > > behaved RT tasks to not be throttled while the tasks that are
> > > misbehaving to be *gracefully* throttled. Gracefully being- it is
> > > probably WAI that they are exceeding their runtime and so *should
> > > naturally* be bandwidth-limited similar to deadline. I am not sure if
> > > the design of RT throttling considers throttling as an anomaly or
> > > something that's expected to happen. If it is expected to happen, then
> > > I see Doug's point that the mechanism shouldn't affect other RT tasks.
> >
> > I don't know much about RT group throttling, but I am under the impression it
> > is to give other sched classes a breather, not other lower priority RT tasks.
> > RT still relies on admins knowing what they're doing when creating RT tasks and
> > manage their priorities.
> 
> So I guess this is where my fundamental disagreement is. I would say
> that one point of the throttling is to prevent an errant RT task (one
> that's going crazy) from taking the system down with it. It seems a
> bit strange to me that we'd want to protect the normal tasks (which
> should, in general, be less urgent than _all_ the RT tasks) but not
> lower priority RT tasks. In my case the lower priority RT tasks are
> actually important enough that blocking them _does_ take the system
> down.

I tried to read Documentation/scheduler/sched-rt-group.rst now and I'm not
sure how to interpret it still. It mentions

"""
Any time not allocated to a realtime group will be used to run normal priority
tasks (SCHED_OTHER). Any allocated run time not used will also be picked up by
SCHED_OTHER.
"""

I interpret the example in The Solution as allocating enough time for realtime
to do their work but still give the rest of the system chance to run and keep
the pipeline filled, hence avoid the underruns.

> 
> 
> > What I think is happening in your case is that you're spawning 13 busyloops at
> > priority 99, assuming you're on a chromebook which probably has at best 8 CPUs,
> > you're basically killing the machine and there's nothing the scheduler can do
> > about it. You get what you asked for :-)
> 
> Well, I asked it to only let those 13 busyloops get 10 ms to run per 1
> second at most (and then put them on ice). ...so in my mind I _didn't_
> get what I asked for. ;-)

The document has a warning that short runtime could lead to instability. Not
sure if this can be considered the case here. But worth trying increasing that
to 100ms and see what happens.

I still think your example is killing the system and I wouldn't be surprised if
you end up starving the lower priority tasks.

> 
> 
> > If you spawn nr_cpus_id - 1 busyloops, the lower priority tasks should find
> > 1 cpu to get their work done, and I don' expect a hang then. And the RT
> > throttling should allow CFS to make some progress every now and then on the
> > other CPUs. So you might end up in a slow system, but not hanging one
> > hopefully.
> >
> > Note that Peter fixed the kernel so that it produces known RT priorities (as
> > opposed to developers setting random values in the past):
> >
> >   * sched_set_fifo_low() ==> not really RT but needs to be above cfs. Runs at
> >     priority 1.
> >   * sched_set_fifo() ==> sets priority MAX_RT_PRIO/2 ==> 50
> >
> > So most system RT tasks fall into the 2nd category, which is reasonably high
> > priority. And RT scheduling assumes if you set something higher than that,
> > then it's your responsibility to make sure they don't starve :-)
> >
> > Yep, it's easy to shoot yourself in the foot with RT, that's why it's
> > privileged op ;-)
> 
> For sure getting RT scheduling wrong will shoot you in the foot, but I
> don't think what I did was wrong.
> 
> From my understanding of the throttling, one big goal (maybe not the
> only goal, but a big one) is to make sure that if a process goes
> haywire (presumably trying to take 100% of the CPU) that the system
> doesn't die and corrective action can be taken on the errant process.
> I think I have shown that this goal is really only achieved if the
> errant process is lower priority than all the other RT tasks in the
> system. That doesn't seem like a reasonable limitation...

My reading of Documentation/scheduler/sched-rt-group.rst interprets it as
ensuring the interaction between realtime and non realtime elements don't end
up with scenarios like buffer underruns because the rest of the system is not
having enough time to fill these buffers (SCHED_OTHER).

> 
> I would also say that with Peter's fix above the problem is perhaps
> _more_ urgent? You just said that there's a whole bunch of kernel

I can't see the problem still tbh.

> tasks that are now created with the lowest RT priority. From your
> description above this means "not really RT but needs to be above
> cfs". If a sysadmin uses RT_GROUP_SCHED and a priority other than the
> lowest priority then it's pretty much guaranteed that if the process
> goes haywire that it will take down all of these important kernel
> tasks. That can't be right, can it?

Did you try something simpler like having 1 task in each group instead of
spawning 13 busy loops?

The sched-rt-group.rst has a warning about a potential starvation scenario by
the way in the 'Future plans' section. I don't think you're affected by it, but
I didn't spend much time thinking about it.

My point is that when using RT you can't expect not to end up with unstable
systems sometimes. Your scenario is one that falls into the unstable region
IMHO.

> 
> Maybe the answer is simply that RT_GROUP_SCHED and RT priority are
> incompatible? I could submit a patch that forces all RT tasks to have
> the same effective priority if RT_GROUP_SCHED is defined. :-/

Personally I can't reach this conclusion based on the scenario you presented.
I think you're doing something unreasonable and the results you're getting are
(likely) not that unreasonable too :-)

> 
> 
> > > > Does my patch seem sane?
> > >
> > > To be honest, I don't understand that bit enough :(
> >
> > Nope. The patch breaks RT priority scheduling. You basically allow a lower
> > priority task to run before a higher priority one. Another code path will
> > probably detect that and tries to correct it later, but still this is not
> > right.
> 
> OK, I'll take your word for it. I'm still hoping someone can tell me a
> better way to fix this?

Hopefully someone more knowledgeable from the RT community can offer better
help and explanation than myself. IMHO the question is whether your scenario
and expected outcome are correct. ie: I'm not sure if there's anything to fix
yet.

I could be wrong of course. So don't let my opinion deter you from pursuing
this further if you believe otherwise.

Cheers

--
Qais Yousef
