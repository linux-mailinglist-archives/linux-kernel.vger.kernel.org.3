Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD5497C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiAXJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiAXJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:49:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60BC06173B;
        Mon, 24 Jan 2022 01:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U9bFxdNKcDMMzkGN9dN7g8aA0mdb5+NJJNY3O8L2ma4=; b=B9qYNR+xIyROYlCnwaSlY6zegz
        bxZLShFS4UwlNBJCvIOLbwTcmBRhczE3DWhTiB32BwCxoyTMLpUeK1X47ePxCHyQsCOpF+ZsxMZRq
        9GdaeQnzjLusTcfi9izTGzRsO/nV+XBefDo3PXM+TP2hTtBRAg2hT+xWBVjOJJ6tXqy8GkRsN1JMn
        N9XtS/8i/Jx228S76FhnXpOVRxU5zJR0HixKNTh6SjHf0WoKEb03UInibcW1YDf5nrY3ngUFPkz0C
        f7jDr6HiejuS6BCx0CGTeS86SRle8wjLCFBC9aj+BW2KHhFsi0eR4ca89Ck9pSLZ6UqFiGfp/s9mT
        G9VOp5QA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvxv-00389R-Kb; Mon, 24 Jan 2022 09:48:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3332A986245; Mon, 24 Jan 2022 10:48:46 +0100 (CET)
Date:   Mon, 24 Jan 2022 10:48:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <20220124094846.GN20638@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Yerl+ZrZ2qflIMyg@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yerl+ZrZ2qflIMyg@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 04:57:29PM +0000, Mark Rutland wrote:
> On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:
> > User Managed Concurrency Groups is an M:N threading toolkit that allows
> > constructing user space schedulers designed to efficiently manage
> > heterogeneous in-process workloads while maintaining high CPU
> > utilization (95%+).
> > 
> > XXX moar changelog explaining how this is moar awesome than
> > traditional user-space threading.
> 
> Awaiting a commit message that I can parse, I'm just looking at the entry bits
> for now. TBH I have no idea what this is actually trying to do...

Ha! yes.. I knew I was going to have to do that eventually :-)

It's basically a user-space scheduler that is subservient to the kernel
scheduler (hierarchical scheduling were a user task is a server for
other user tasks), where a server thread is in charge of selecting which
of it's worker threads gets to run. The original idea was that each
server only ever runs a single worker, but PeterO is currently trying to
reconsider that.

The *big* feature here, over traditional N:M scheduling, is that threads
can block, while traditional userspace threading is limited to
non-blocking system calls (and per later, page-faults).

In order to make that happen we must ovbiously hook schedule() for
these worker threads and inform userspace (the server thread) when this
happens such that it can select another worker thread to go vroom.

Meanwhile, a worker task getting woken from schedule() must not continue
running; instead it must enter the server's ready-queue and await it's
turn again. Instead of dealing with arbitrary delays deep inside the
kernel block chain, we punt and let the task complete until
return-to-user and block it there. The time between schedule() and
return-to-user is unmanaged time.

Now, since we can't readily poke at userspace memory from schedule(), we
could be holding mmap_sem etc., we pin the worker and server page on
sys-enter such that when we hit schedule() we can update state and then
unpin the pages such that page pin time is from sys-enter to first
schedule(), or sys-exit which ever comes first. This ensures the
page-pin is *short* term.

Additionally we must deal with signals :-(, the currnt approach is to
let them bust boundaries and run them as unmanaged time. UMCG userspace
can obviously control this by using pthread_sigmask() and friends.

Now, the reason for irqentry_irq_enable() is mostly #PF.  When a worker
faults and blocks we want the same things to happen.

Anyway, so workers have 3 layers of hooks:

		sys_enter
				schedule()
		sys_exit

	return-to-user

There's a bunch of paths through this:

 - sys_enter -> sys_exit:

	no blocking; nothing changes:
	  - sys_enter:
	    * pin pages

	  - sys_exit:
	    * unpin pages

 - sys_enter -> schedule() -> sys_exit:

	we did block:
	  - sys_enter:
	    * pin pages

	  - schedule():
	    * mark worker BLOCKED
	    * wake server (it will observe it's current worker !RUNNING
	      and select a new worker or idles)
	    * unpin pages

	  - sys_exit():
	    * mark worker RUNNABLE
	    * enqueue worker on server's runnable_list
	    * wake server (which will observe a new runnable task, add
	      it to whatever and if it was idle goes run, otherwise goes
	      back to sleep to let it's current worker finish)
	    * block until RUNNING

 - sys_enter -> schedule() -> sys_exit -> return_to_user:

	As above; except now we got a signal while !RUNNING. sys_exit()
	terminates and return-to-user takes over running the signal and
	on return from the signal we'll again block until RUNNING, or do
	the whole signal dance again if so required.


Does this clarify things a little?
