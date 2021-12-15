Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADA47659B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhLOW0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhLOWZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:25:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF86C061574;
        Wed, 15 Dec 2021 14:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=szJ15KHMKZBsv0DChMYLKxZNIt1BG/HH7JYdwOh3z+o=; b=pSabiEV8wKQIF1bJ0p4jJ32VHd
        RWNwnjBsA9pfe09CVuo91xR7kCsBbMqyAymGrGa2jwGtmDSemP7eKcDGXJjt6lKyWXCPSVbTzzjr7
        q/A2/tO+VeOyWjeFI/nvHFh3RWsFu+N4FSw/umuiCIyBuv5UGGd9GG0MsSwXnccUiiPDvJk4mHium
        hf1rBU9jXwLWOCzzmEje6QqBxrj92Z4iSXe94eeMHh6EMtEb4fZAIZ83WlS4JgAQsHlwqaI07uRkx
        5myZzsHlWtyzLHELu+Wd1YN95Ga4/tyOQvCqvw3U8SAxSvXlhHBWRT6D33eLCEiiua7AYJfC7WQKI
        jRB6JwZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxciE-001a36-86; Wed, 15 Dec 2021 22:25:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C78F9844F1; Wed, 15 Dec 2021 23:25:25 +0100 (CET)
Date:   Wed, 15 Dec 2021 23:25:24 +0100
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
Message-ID: <20211215222524.GH16608@worktop.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
 <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
 <YboxjUM+D9Kg52mO@hirez.programming.kicks-ass.net>
 <CAPNVh5cJy2y+sTx0cPA1BPSAg=GjXC8XGT7fLzHwzvXH2=xjmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5cJy2y+sTx0cPA1BPSAg=GjXC8XGT7fLzHwzvXH2=xjmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:49:51AM -0800, Peter Oskolkov wrote:

> TL;DR: our models are different here. In your model a single server
> can have a bunch of workers interacting with it; in my model only a
> single RUNNING worker is assigned to a server, which it wakes when it
> blocks.

So part of the problem is that none of that was evident from the code.
It is also completely different from the scheduler code it lives in,
making it double confusing.

After having read the code, I still had no clue what so ever how it was
supposed to be used. Which is where my reverse engineering started :/

> More details:
> 
> "Working servers" cannot get wakeups, because a "working server" has a
> single RUNNING worker attached to it. When a worker blocks, it wakes
> its attached server and becomes a detached blocked worker (same is
> true if the worker is "preempted": it blocks and wakes its assigned
> server).

But who would do the preemption if the server isn't allowed to run?

> Blocked workers upon wakeup do this, in order:
> 
> - always add themselves to the runnable worker list (the list is
> shared among ALL servers, it is NOT per server);

That seems like a scalability issue. And, as said, it is completely
alien when compared to the way Linux itself does scheduling.

> - wake a server pointed to by idle_server_ptr, if not NULL;
> - sleep, waiting for a wakeup from a server;
> 
> Server S, upon becoming IDLE (no worker to run, or woken on idle
> server list) does this, in order, in userspace (simplified, see
> umcg_get_idle_worker() in
> https://lore.kernel.org/lkml/20211122211327.5931-5-posk@google.com/):
> - take a userspace (spin) lock (so the steps below are all within a
> single critical section):

Don't ever suggest userspace spinlocks, they're horrible crap.

> - compare_xchg(idle_server_ptr, NULL, S);
>   - if failed, there is another server in idle_server_ptr, so S adds
> itself to the userspace idle server list, releases the lock, goes to
> sleep;
>   - if succeeded:
>     - check the runnable worker list;
>         - if empty, release the lock, sleep;
>         - if not empty:
>            - get the list
>            - xchg(idle_server_ptr, NULL) (either S removes itself, or
> a worker in the kernel does it first, does not matter);
>            - release the lock;
>            - wake server S1 on idle server list. S1 goes through all
> of these steps.
> 
> The protocol above serializes the userspace dealing with the idle
> server ptr/list. Wakeups in the kernel will be caught if there are
> idle servers. Yes, the protocol in the userspace is complicated (more
> complicated than outlined above, as the reaped idle/runnable worker
> list from the kernel is added to the userspace idle/runnable worker
> list), but the kernel side is very simple. I've tested this
> interaction extensively, I'm reasonably sure that no worker wakeups
> are lost.

Sure, but also seems somewhat congestion prone :/
