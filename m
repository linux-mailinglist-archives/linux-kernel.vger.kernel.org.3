Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B8476665
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhLOXQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLOXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:16:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A91C061574;
        Wed, 15 Dec 2021 15:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7TkUsFIKpnau7pWBf9h7KSNo4ui5MXEQ/bPdkzjokuQ=; b=SLXbGgUjH+DaIrY4ZUo8aCy0/s
        L+V/vr80d+3sI9qkQTKIkP6lma7r7m6eIzFi3kR4qRIVAuYEtiQY2e3p19RVD9PcYB0QWKdq2Dyta
        nQG14fmI3XbfV7aidrEMGtkecsx/eqePsGtHH5K2tlCxNDZiaYZzhn3gGjh4B48QAHTZPxE3/cQS1
        C9MkCcrfdGuG4IaCqUDtXQc/lz1477Oijrjr8AVZf3VjQzfwBp27Gc8mWE3+/uF2DOLq13qQqN7Le
        GKOVrj1IeeOrbrgSwQ1TE7hEs9zloNKNoPAyyn2wCYntDq8/NOpxv2qEBwuRKka1+utwiKSeo6rrG
        n3oFyBDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxdVL-001aXG-7H; Wed, 15 Dec 2021 23:16:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 925D29844F1; Thu, 16 Dec 2021 00:16:10 +0100 (CET)
Date:   Thu, 16 Dec 2021 00:16:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Andrei Vagin <avagin@google.com>,
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
Message-ID: <20211215231610.GI16608@worktop.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
 <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
 <YbozBSLk4PytGp0J@hirez.programming.kicks-ass.net>
 <CAPNVh5fenLG7uvdF1tjyfcOe8Ff3_L0-UqeCu9=tn-NMaJ3ikA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5fenLG7uvdF1tjyfcOe8Ff3_L0-UqeCu9=tn-NMaJ3ikA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 01:04:33PM -0800, Peter Oskolkov wrote:
> On Wed, Dec 15, 2021 at 10:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Dec 15, 2021 at 09:56:06AM -0800, Peter Oskolkov wrote:
> > > On Wed, Dec 15, 2021 at 2:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >  /*
> > > > + * Enqueue tsk to it's server's runnable list and wake the server for pickup if
> > > > + * so desired. Notable LAZY workers will not wake the server and rely on the
> > > > + * server to do pickup whenever it naturally runs next.
> > >
> > > No, I never suggested we needed per-server runnable queues: in all my
> > > patchsets I had a single list of idle (runnable) workers.
> >
> > This is not about the idle servers..
> >
> > So without the LAZY thing on, a previously blocked task hitting sys_exit
> > will enqueue itself on the runnable list and wake the server for pickup.
> 
> How can a blocked task hit sys_exit()? Shouldn't it be RUNNING?

Task was RUNNING, hits schedule() after passing through sys_enter().
this marks it BLOCKED. Task wakes again and proceeds to sys_exit(), at
which point it's marked RUNNABLE and put on the runnable list. After
which it'll kick the server to process said list.

> Anyway, servers and workers are supposed to unregister before exiting,
> so if they call sys_exit() they break the agreement; in my patch I
> just clear all umcg-related state and proceed, without waking the
> server: the user broke the protocol, let them figure out what
> happened:

No violation of anything there. The time between returning from
schedule() and sys_exit() is unmanaged.

sys_exit() is the spot where we regain control.

> > IIRC you didn't like the server waking while it was still running
> > another task, but instead preferred to have it pick up the newly
> > enqueued task when next it ran.
> 
> Yes, this is the model I have, as I outlined in another email. I
> understand that having queues per-CPU/per-server is how it is done in
> the kernel, both for historical reasons (before multiprocessing there
> was a single queue/cpu) and for throughput (per-cpu runqueues are
> individually faster than a global one). However, this model is known
> to lag in presence of load spikes (long per-cpu queues with some CPUs
> idle), and is not really easy to work with given the use cases this
> whole userspace scheduling effort is trying to address:

Well, that's *your* use-case. I'm fairly sure there's more people that
want to use this thing.

> multiple
> priorities and work isolation: these are easy to address directly with
> a scheduler that has a global view rather than multiple
> per-cpu/per-server schedulers/queues that try to coordinate.

You can trivially create this, even if the underlying thing is
per-server. Simply have a lock and shared data structure between the
servers.

Even in the kernel, it should be mostly trivial to create a global
policy. The only tricky bit (in the kernel) is the whole affinity muck,
but userspace doesn't *need* to do even that.

> > LAZY enables that.. *however* it does need to wake the server when it is
> > idle, otherwise they'll all sit there waiting for one another.
> 
> If all servers are busy running workers, then it is not up to the
> kernel to "preempt" them in my model: the userspace can set up another
> thread/task to preempt a misbehaving worker, which will wake the
> server attached to it. 

So the way I'm seeing things is that the server *is* the 'CPU'. A UP
machine cannot rely on another CPU to make preemption happen.

Also, preemption is very much not about misbehaviour. Wakeup can cause a
preemption event if the woken task is deemed higher priority than the
current running one for example.

And time based preemption is definitely also a thing wrt resource
distribution.

> But in practice there are always workers
> blocking in the kernel, which wakes their servers, which then reap the
> woken/runnable workers list, so well-behaving code does not need this.

This seems to discount pure computational workloads.

> And so we need to figure out this high-level thing first: do we go
> with the per-server worker queues/lists, or do we go with the approach
> I use in my patchset? It seems to me that the kernel-side code in my
> patchset is not more complicated than your patchset is shaping up to
> be, and some things are actually easier to accomplish, like having a
> single idle_server_ptr vs this LAZY and/or server "preemption"
> behavior that you have.
> 
> Again, I'm OK with having it your way if all needed features are
> covered, but I think we should be explicit about why
> per-server/per-cpu model is chosen vs the one I proposed, especially
> as it seems the kernel side code is not really simpler in the end.

So I went with a UP first approach. I made single server preemption
driven scheduling work first (both tick and wakeup-preemption are
supported).

The whole LAZY thing is only meant to supress some of that (notably
wakeup preemption), but you're right in that it's not really nice. I got
it working, but I'm not particularly happy with it either.

Having the sys_enter/sys_exit hooks also made the page pins short lived,
and signals much simpler to handle. You're destroying signals IIUC.


So I see no fundamental reason why userspace cannot do something like:

	struct umcg_task *current = NULL;

	for (;;) {
		self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;

		runnable_ptr = (void *)__atomic_exchange_n(&self->runnable_workers_ptr,
                                                           NULL, __ATOMIC_SEQ_CST);

		pthread_mutex_lock(&global_queue.lock);
		while (runnable_ptr) {
			next = (void *)runnable_ptr->runnable_workers_ptr;
			enqueue_task(&global_queue, runnable_ptr);
			runnable_ptr = next;
		}

		/* complicated bit about current already running goes here */

		current = pick_task(&global_queue);
		self->next_tid = current ? current->tid : 0;
unlock:
		pthread_mutex_unlock(&global_queue.lock);

		ret = sys_umcg_wait(0, 0);

		pthread_mutex_lock(&global_queue.lock);
		/* umcg_wait() didn't switch, make sure to return the task */
		if (self->next_tid) {
			enqueue_task(&global_queue, current);
			current = NULL;
		}
		pthread_mutex_unlock(&global_queue.lock);

		// do something with @ret
	}

to get global scheduling and all the contention^Wgoodness related to it.
Except, of course, it's more complicated, but I think the idea's clear
enough.


