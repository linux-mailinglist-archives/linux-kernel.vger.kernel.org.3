Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5238447642E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhLOVEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhLOVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:04:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90EFC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:04:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so40374423wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5BKidzd2sc7lu3XwgzfZRbV08/HOJxmZ1PXDsVN3SE=;
        b=N54GLjP7KFCp6NczDZTlxdYgyJMoT0QXnYDL6opU7Pzargvf2lxn3uhprV98bZ5QCS
         nAsIQQSZn1XmVaSrQC2viLcF3ZJ4FdwRki2B/oF8NWVXpadrTxFx3IRobz7jtG4hKOay
         YBwPNXK9/GumcAxwepsGtKMxId4BXJC16AmAiCNPjfyytcyLC1H88C4IsECLO32EjuwA
         YvCZIcZ6DpxOInigp+4h9XSLcIlyCsjykWlmwdtN5IAsrIF6boV1AP042xyZpInFEGrx
         QBZ+IPVkK84rStDUHKZMiIKFH0pSDkV5dSf+oe5FVyw2h8JqARTA3Q/Pja4SFReLirxE
         GzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5BKidzd2sc7lu3XwgzfZRbV08/HOJxmZ1PXDsVN3SE=;
        b=hLm32iWxIwwQ+B++/Z5oeqoBO1Bn0jVDpygGfmx+DpZsSO9+ng2sj6u9VyOp7bhCrc
         52vKvHUW6KUWehzePqskjPjIgXmWNG69v4NHQ/tBHIdLeODpfM0RkO2ok1wejzE0dKWy
         iroaIzdTkgThQ51fT1JuK/gmBLsg5AaCDtRn5nc2K3QYtb93zC1o9oMjS9uDk8QlBfzr
         pbjiRyqhiaeKxN1wNpGUGQ7XvrDzM9B3/0XEd6GbC2Q3wSYlTNDrgRZirVIS/GgEkgf3
         mXcLUpZvcrS69c9EXvb90sv1Uvu+OQ2dfV+/muCOrFs6YlTl2enpxClHiDffHvt9peNN
         y70g==
X-Gm-Message-State: AOAM533hqqQR9i8OkTtsBsk1YlAmhTZV7lUdpDN8Ccs6UVydtx/yQrtk
        FLCetWaTlJ5BGWPf8WXFqOK5M7eAjCsBXeGfTYo6fg==
X-Google-Smtp-Source: ABdhPJxS7OpUSsP6dtUpE9KKh2DzPY+ETEPjCpIv4S/1DOFFL39bu97VJ7p8K8i4aiHxGtPvVe8xCEZADAsZtOGfLsA=
X-Received: by 2002:a5d:5984:: with SMTP id n4mr4002281wri.563.1639602284959;
 Wed, 15 Dec 2021 13:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org> <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net> <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
 <YbozBSLk4PytGp0J@hirez.programming.kicks-ass.net>
In-Reply-To: <YbozBSLk4PytGp0J@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 15 Dec 2021 13:04:33 -0800
Message-ID: <CAPNVh5fenLG7uvdF1tjyfcOe8Ff3_L0-UqeCu9=tn-NMaJ3ikA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 15, 2021 at 09:56:06AM -0800, Peter Oskolkov wrote:
> > On Wed, Dec 15, 2021 at 2:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >  /*
> > > + * Enqueue tsk to it's server's runnable list and wake the server for pickup if
> > > + * so desired. Notable LAZY workers will not wake the server and rely on the
> > > + * server to do pickup whenever it naturally runs next.
> >
> > No, I never suggested we needed per-server runnable queues: in all my
> > patchsets I had a single list of idle (runnable) workers.
>
> This is not about the idle servers..
>
> So without the LAZY thing on, a previously blocked task hitting sys_exit
> will enqueue itself on the runnable list and wake the server for pickup.

How can a blocked task hit sys_exit()? Shouldn't it be RUNNING?

Anyway, servers and workers are supposed to unregister before exiting,
so if they call sys_exit() they break the agreement; in my patch I
just clear all umcg-related state and proceed, without waking the
server: the user broke the protocol, let them figure out what
happened:

+static void umcg_clear_task(struct task_struct *tsk)
+{
+ /*
+ * This is either called for the current task, or for a newly forked
+ * task that is not yet running, so we don't need strict atomicity
+ * below.
+ */
+ if (tsk->umcg_task) {
+ WRITE_ONCE(tsk->umcg_task, NULL);
+
+ /* These can be simple writes - see the comment above. */
+ tsk->pinned_umcg_worker_page = NULL;
+ tsk->pinned_umcg_server_page = NULL;
+ tsk->flags &= ~PF_UMCG_WORKER;
+ }
+}
+
+/* Called both by normally (unregister) and abnormally exiting workers. */
+void umcg_handle_exiting_worker(void)
+{
+ umcg_unpin_pages();
+ umcg_clear_task(current);
+}


>
> IIRC you didn't like the server waking while it was still running
> another task, but instead preferred to have it pick up the newly
> enqueued task when next it ran.

Yes, this is the model I have, as I outlined in another email. I
understand that having queues per-CPU/per-server is how it is done in
the kernel, both for historical reasons (before multiprocessing there
was a single queue/cpu) and for throughput (per-cpu runqueues are
individually faster than a global one). However, this model is known
to lag in presence of load spikes (long per-cpu queues with some CPUs
idle), and is not really easy to work with given the use cases this
whole userspace scheduling effort is trying to address: multiple
priorities and work isolation: these are easy to address directly with
a scheduler that has a global view rather than multiple
per-cpu/per-server schedulers/queues that try to coordinate.

I can even claim (without proof, just a hunch, based on how I would
code this) that strict scheduling policies around priority and
isolation (e.g. never run work item A if work item B becomes runnable,
unless work item A is already running) cannot be enforced without a
global scheduler, so per-cpu/per-server queues do not really fit the
use case here...

>
> LAZY enables that.. *however* it does need to wake the server when it is
> idle, otherwise they'll all sit there waiting for one another.

If all servers are busy running workers, then it is not up to the
kernel to "preempt" them in my model: the userspace can set up another
thread/task to preempt a misbehaving worker, which will wake the
server attached to it. But in practice there are always workers
blocking in the kernel, which wakes their servers, which then reap the
woken/runnable workers list, so well-behaving code does not need this.
Yes, sometimes the code does not behave well, e.g. a worker grabs a
spinlock, blocks in the kernel, its server runs another worker that
starts spinning on the spinlock; but this is fixable by making the
spinlock aware of our stuff: either the worker who got the lock is
marked as LOCKED and so does not release its server (one of the
reasons I have this flag), or the lock itself becomes sleepable (e.g.
after spinning a bit it calls into a futex wait).

And so we need to figure out this high-level thing first: do we go
with the per-server worker queues/lists, or do we go with the approach
I use in my patchset? It seems to me that the kernel-side code in my
patchset is not more complicated than your patchset is shaping up to
be, and some things are actually easier to accomplish, like having a
single idle_server_ptr vs this LAZY and/or server "preemption"
behavior that you have.

Again, I'm OK with having it your way if all needed features are
covered, but I think we should be explicit about why
per-server/per-cpu model is chosen vs the one I proposed, especially
as it seems the kernel side code is not really simpler in the end.
