Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06B462190
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhK2UKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353754AbhK2UIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:08:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E988DC08EB3F;
        Mon, 29 Nov 2021 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eKkC6UpK6/i7D2lpHs7XjnCCf7VNK2fmwFzMjXdfzOg=; b=EvbI7SflETvKwufLzieMY/7xfL
        yJtGckfqPeJBLcrSvfQAOee1z5IdIfs/PBBSJxjRdD9uGwaP0LW1L5Win9jipF+NC4CZuvxjFMtC+
        Jet1S67q5LZYYXYsR0MTmKdEVgyhD5D/YBoaxcOiyod45/vbdoxVZ+8pA8vxmqYcs778bJ6pqgFW/
        TSBDefx/HG04bFTu7ERo0YVwYhGPXLSSWN9WHbLZXsgo8x3uLyCzpOhjlLIjbuoxbJYReJj1w9THY
        o50XNOFd3t2t7HE9EbKY/I8/QTa0OU7nr/qwRrgJJzVmMu0ZAKEjjQfbpPdmraGj9uE5EQB/HnCj+
        QWLWHW2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrjiE-008Lwz-7E; Mon, 29 Nov 2021 16:41:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94810300235;
        Mon, 29 Nov 2021 17:41:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 779342B2FEA16; Mon, 29 Nov 2021 17:41:05 +0100 (CET)
Date:   Mon, 29 Nov 2021 17:41:05 +0100
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
Message-ID: <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 04:29:11PM -0800, Peter Oskolkov wrote:

> wait_wake_only is not needed if you have both next_tid and server_tid,
> as your patch has. In my version of the patch, next_tid is the same as
> server_tid, so the flag is needed to indicate to the kernel that
> next_tid is the wakee, not the server.

Ah, okay.

> re: (idle_)server_tid_ptr: it seems that you assume that blocked
> workers keep their servers, while in my patch they "lose them" once
> they block, and so there should be a global idle server pointer to
> wake the server in my scheme (if there is an idle one). The main
> difference is that in my approach a server has only a single, running,
> worker assigned to it, while in your approach it can have a number of
> blocked/idle workers to take care of as well.

Correct; I've been thinking in analogues of the way we schedule CPUs.
Each CPU has a ready/run queue along with the current task.
fundamentally the RUNNABLE tasks need to go somewhere when all servers
are busy. So at that point the previous server is as good a place as
any.

Now, I sympathise with a blocked task not having a relation; I often
argue this same, since we have wakeup balancing etc. And I've not really
thought about how to best do wakeup-balancing, also see below.

> The main difference between our approaches, as I see it: in my
> approach if a worker is running, its server is sleeping, period. If we
> have N servers, and N running workers, there are no servers to wake
> when a previously blocked worker finishes its blocking op. In your
> approach, it seems that N servers have each a bunch of workers
> pointing at them, and a single worker running. If a previously blocked
> worker wakes up, it wakes the server it was assigned to previously,

Right; it does that. It can check the ::state of it's current task,
possibly set TF_PREEMPT or just go back to sleep.

> and so now we have more than N physical tasks/threads running: N
> workers and the woken server. This is not ideal: if the process is
> affined to only N CPUs, that means a worker will be preempted to let
> the woken server run, which is somewhat against the goal of letting
> the workers run more or less uninterrupted. This is not deal breaking,
> but maybe something to keep in mind.

I suppose it's easy enough to make this behaviour configurable though;
simply enqueue and not wake.... Hmm.. how would this worker know if the
server was 'busy' or not? The whole 'current' thing is a user-space
construct. I suppose that's what your pointer was for? Puts an actual
idle server in there, if there is one. Let me ponder that a bit.

However, do note this whole scheme fundamentally has some of that, the
moment the syscall unblocks until sys_exit is 'unmanaged' runtime for
all tasks, they can consume however much time the syscall needs there.

Also, timeout on sys_umcg_wait() gets you the exact same situation (or
worse, multiple running workers).

> Another big concern I have is that you removed UMCG_TF_LOCKED. I

OOh yes, I forgot to mention that. I couldn't figure out what it was
supposed to do.

> definitely needed it to guard workers during "sched work" in the
> userspace in my approach. I'm not sure if the flag is absolutely
> needed with your approach, but most likely it is - the kernel-side
> scheduler does lock tasks and runqueues and disables interrupts and
> migrations and other things so that the scheduling logic is not
> hijacked by concurrent stuff. Why do you assume that the userspace
> scheduling code does not need similar protections?

I've not yet come across a case where this is needed. Migration for
instance is possible when RUNNABLE, simply write ::server_tid before
::state. Userspace just needs to make sure who actually owns the task,
but it can do that outside of this state.

But like I said; I've not yet done the userspace part (and I lost most
of today trying to install a new machine), so perhaps I'll run into it
soon enough.


