Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7F246621B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357225AbhLBLO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:14:59 -0500
Received: from foss.arm.com ([217.140.110.172]:33668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357206AbhLBLOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:14:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5CDB142F;
        Thu,  2 Dec 2021 03:11:31 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F7093F7D7;
        Thu,  2 Dec 2021 03:11:30 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:11:27 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20211202111127.gew4lqquvtn3lkbc@e107158-lin.cambridge.arm.com>
References: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
 <CAD=FV=UZNxt7y6bTipyvYFGMJhgp6nRozNt=iEaOYP6yc4OFpg@mail.gmail.com>
 <CAJWu+ora8F0eurnYkSXRqcT4mB8k8wy9CyKj1EGk52vEVEkT3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJWu+ora8F0eurnYkSXRqcT4mB8k8wy9CyKj1EGk52vEVEkT3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel, Doug

On 11/30/21 18:36, Joel Fernandes wrote:
> On Tue, Nov 30, 2021 at 11:30 AM Doug Anderson <dianders@chromium.org> wrote:
> > I know this isn't crazy urgent and I'm happy to sit and twiddle my
> > thumbs a bit longer if everyone is still sleepy from tryptophan, but
> > I'm curious if anyone had a chance to look at this. Can anyone confirm
> > that my script reproduces for them on something other than my system?
> 
> Maybe +Qais Yousef can also chime in. Just to add, I think Doug's

I could try :-)

/me tries to find the original posting

> issue is that under RT group scheduling, he expects *other* well
> behaved RT tasks to not be throttled while the tasks that are
> misbehaving to be *gracefully* throttled. Gracefully being- it is
> probably WAI that they are exceeding their runtime and so *should
> naturally* be bandwidth-limited similar to deadline. I am not sure if
> the design of RT throttling considers throttling as an anomaly or
> something that's expected to happen. If it is expected to happen, then
> I see Doug's point that the mechanism shouldn't affect other RT tasks.

I don't know much about RT group throttling, but I am under the impression it
is to give other sched classes a breather, not other lower priority RT tasks.
RT still relies on admins knowing what they're doing when creating RT tasks and
manage their priorities.

What I think is happening in your case is that you're spawning 13 busyloops at
priority 99, assuming you're on a chromebook which probably has at best 8 CPUs,
you're basically killing the machine and there's nothing the scheduler can do
about it. You get what you asked for :-)

If you spawn nr_cpus_id - 1 busyloops, the lower priority tasks should find
1 cpu to get their work done, and I don' expect a hang then. And the RT
throttling should allow CFS to make some progress every now and then on the
other CPUs. So you might end up in a slow system, but not hanging one
hopefully.

Note that Peter fixed the kernel so that it produces known RT priorities (as
opposed to developers setting random values in the past):

  * sched_set_fifo_low() ==> not really RT but needs to be above cfs. Runs at
    priority 1.
  * sched_set_fifo() ==> sets priority MAX_RT_PRIO/2 ==> 50

So most system RT tasks fall into the 2nd category, which is reasonably high
priority. And RT scheduling assumes if you set something higher than that,
then it's your responsibility to make sure they don't starve :-)

Yep, it's easy to shoot yourself in the foot with RT, that's why it's
privileged op ;-)

> 
> > Does my patch seem sane?
> 
> To be honest, I don't understand that bit enough :(

Nope. The patch breaks RT priority scheduling. You basically allow a lower
priority task to run before a higher priority one. Another code path will
probably detect that and tries to correct it later, but still this is not
right.

HTH and I didn't gloss over some detail.

Thanks

--
Qais Yousef
