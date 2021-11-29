Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F84627C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhK2XJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbhK2XJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:09:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423DC0F74CF;
        Mon, 29 Nov 2021 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NYI5KVFPjbS12X0GrBf9xRuRMianhfD+CgDt6QrOv0E=; b=McA148pZHAp5/mjW/omCEMbH0K
        RAkY7+fT91qeOFoxWPXkglDWlpeZzEUXfC/4Qa9fLRdABt0LkvBXTDnTZjeNMRnGW7P81l4h1GGCl
        A/x5vjUaU2w08Wi9vED9vR76Cm8/Lnl8ZWLbiMekLvZy5pokjjjRih5/rmfNVLsP0t2RvZcneF/iR
        L2yYDxRXwrK05gly7G1WfB0irOX3P/PCwNMug5YGGcrH/FnqQ1dFLYx4Fuyc7s4TcZ/wgQARy9PV2
        05p/obCpKLQKoA4SNFP35QcmzhlF3lwv8+3XmIrYSzUhOSRfbHmwJTk7N6m7QyIQuBJ+Mw/Su4Pq3
        EuXpa6uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrntC-001Jpl-Tt; Mon, 29 Nov 2021 21:08:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7370B98675D; Mon, 29 Nov 2021 22:08:41 +0100 (CET)
Date:   Mon, 29 Nov 2021 22:08:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <20211129210841.GO721624@worktop.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
 <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:34:49AM -0800, Peter Oskolkov wrote:
> On Mon, Nov 29, 2021 at 8:41 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > However, do note this whole scheme fundamentally has some of that, the
> > moment the syscall unblocks until sys_exit is 'unmanaged' runtime for
> > all tasks, they can consume however much time the syscall needs there.
> >
> > Also, timeout on sys_umcg_wait() gets you the exact same situation (or
> > worse, multiple running workers).
> 
> It should not. Timed out workers should be added to the runnable list
> and not become running unless a server chooses so. So sys_umcg_wait()
> with a timeout should behave similarly to a normal sleep, in that the
> server is woken upon the worker blocking, and upon the worker wakeup
> the worker is added to the woken workers list and waits for a server
> to run it. The only difference is that in a sleep the worker becomes
> BLOCKED, while in sys_umcg_wait() the worker is RUNNABLE the whole
> time.

OK, that's somewhat subtle and I hadn't gotten that either.

Currently it return -ETIMEDOUT in RUNNING state for both server and
worker callers.

Let me go fix that then.

> > > Another big concern I have is that you removed UMCG_TF_LOCKED. I
> >
> > OOh yes, I forgot to mention that. I couldn't figure out what it was
> > supposed to do.
> >
> > > definitely needed it to guard workers during "sched work" in the
> > > userspace in my approach. I'm not sure if the flag is absolutely
> > > needed with your approach, but most likely it is - the kernel-side
> > > scheduler does lock tasks and runqueues and disables interrupts and
> > > migrations and other things so that the scheduling logic is not
> > > hijacked by concurrent stuff. Why do you assume that the userspace
> > > scheduling code does not need similar protections?
> >
> > I've not yet come across a case where this is needed. Migration for
> > instance is possible when RUNNABLE, simply write ::server_tid before
> > ::state. Userspace just needs to make sure who actually owns the task,
> > but it can do that outside of this state.
> >
> > But like I said; I've not yet done the userspace part (and I lost most
> > of today trying to install a new machine), so perhaps I'll run into it
> > soon enough.
> 
> The most obvious scenario where I needed locking is when worker A
> wants to context switch into worker B, while another worker C wants to
> context switch into worker A, and worker A pagefaults. This involves:
> 
> worker A context: worker A context switches into worker B:
> 
> - worker B::server_tid = worker A::server_tid
> - worker A::server_tid = none
> - worker A::state = runnable
> - worker B::state = running
> - worker A::next_tid = worker B
> - worker A calls sys_umcg_wait()
> 
> worker B context: before the above completes, worker C wants to
> context switch into worker A, with similar steps.
> 
> "interrupt context": in the middle of the mess above, worker A pagefaults
> 
> Too many moving parts. UMCG_TF_LOCKED helped me make this mess
> manageable. Maybe without pagefaults clever ordering of the operations
> listed above could make things work, but pagefaults mess things badly,
> so some kind of "preempt_disable()" for the userspace scheduling code
> was needed, and UMCG_TF_LOCKED was the solution I had.

I'm not sure I'm following. For this to be true A and C must be running
on a different server right?

So we have something like:

	S0 running A			S1 running B

Therefore:

	S0::state == RUNNABLE		S1::state == RUNNABLE
	A::server_tid == S0.tid		B::server_tid == S1.tid
	A::state == RUNNING		B::state == RUNNING

Now, you want A to switch to C, therefore C had better be with S0, eg we
have:

	C::server_tid == S0.tid
	C::state == RUNNABLE

So then A does:

	A::next_tid = C.tid;
	sys_umcg_wait();

Which will:

	pin(A);
	pin(S0);

	cmpxchg(A::state, RUNNING, RUNNABLE);

	next_tid = A::next_tid; // C

	enqueue(S0::runnable, A);

At which point B steals S0's runnable queue, and tries to make A go.

					runnable = xchg(S0::runnable_list_ptr, NULL); // == A
					A::server_tid = S1.tid;
					B::next_tid = A.tid;
					sys_umcg_wait();

	wake(C)
	  cmpxchg(C::state, RUNNABLE, RUNNING); <-- *fault*


Something like that, right?

What currently happens is that S0 goes back to S0 and S1 ends up in A.
That is, if, for any reason we fail to wake next_tid, we'll wake
server_tid.

So then S0 wakes up and gets to re-evaluate life. If it has another
worker it can go run that, otherwise it can try and steal a worker
somewhere or just idle out.

Now arguably, the only reason A->C can fault is because C is garbage, at
which point your program is malformed and it doesn't matter what
happens one way or the other.
