Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B932F4EE501
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbiDAAIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243250AbiDAAIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58741DDFFA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB8461783
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23E0C340EE;
        Fri,  1 Apr 2022 00:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648771602;
        bh=6ywENgWzbN6cGONoIw40dVeVIVLnSwwF0nHDBvmIXII=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YIsHKeagB6X/3sKigjxwBnze3bsxnO9QU7hqNn9PKcbb+epo8jsgteApFkM0XplDy
         tyFOu7UVEoLBnzTqquKbFmZfNuN6u/ginBn7rPXzZYb6PrEaWRTonqk7vSdAnlPe5B
         Fc4tESqWx3voteVWifKDT24eZo08SPvVl93KWE7Rl3OhbWRnXmTlH4daYFzwlXe0Ox
         lGvB3UoNb8PoFgFUURIKhmz97qrI/UVfzX0z6rbSTYlR3EuciwG1GfUs1cJN04ryh8
         Y2v1/MvWnaoI8aKqOu2OS/0RqJmvQuq47qZNmE7RigpzoDMfHt2GtWrxgWZZdgwaul
         RgawfPLY8ISHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7921E5C0A0E; Thu, 31 Mar 2022 17:06:42 -0700 (PDT)
Date:   Thu, 31 Mar 2022 17:06:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
Message-ID: <20220401000642.GB4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
 <20220331224222.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <CANn89iJjyp7s1fYB6VCqLhUnF+mmEXyw8GMpFC9Vi22usBsgAQ@mail.gmail.com>
 <CANn89iJaeBneeqiDBUh_ppEQGne_eyPp-BCVYjEyvoYkUxrDxg@mail.gmail.com>
 <20220331231312.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CANn89i+rfrkRrdYAq8Baq04n_ACq+VdB+UcsMoq7U-dB-2hKJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+rfrkRrdYAq8Baq04n_ACq+VdB+UcsMoq7U-dB-2hKJA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:28:04PM -0700, Eric Dumazet wrote:
> On Thu, Mar 31, 2022 at 4:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > The initial setting of ->percpu_enqueue_shift forces all in-range CPU
> > IDs to shift down to zero.  The grace-period kthread is allowed to run
> > where it likes.  The callback lists are protected by locking, even in
> > the case of local access, so this should be safe.
> >
> > Or am I missing your point?
> >
> 
> In fact I have been looking at this code, because we bisected a
> regression back to this patch:
> 
> 4fe192dfbe5ba9780df699d411aa4f25ba24cf61 rcu-tasks: Shorten
> per-grace-period sleep for RCU Tasks Trace
> 
> It is very possible the regression comes because the RCU task thread
> is using more cpu cycles, from 'CPU 0'  where our system daemons are
> pinned.

Heh!  I did express that concern when creating that patch, but was
assured that the latency was much more important.

Yes, that patch most definitely increases CPU utilization during RCU Tasks
Trace grace periods.  If you can tolerate longer grace-period latencies,
it might be worth toning it down a bit.  The ask was for about twice
the latency I achieved in my initial attempt, and I made the mistake of
forwarding that attempt out for testing.  They liked the shorter latency
very much, and objected strenuously to the thought that I might detune
it back to the latency that they originally asked for.  ;-)

But I can easily provide the means to detune it through use of a kernel
boot parameter or some such, if that would help.

> But I could not spot where the RCU task kthread is forced to run on CPU 0.

I never did intend this kthread be bound anywhere.  RCU's policy is
that any binding of its kthreads is the responsibility of the sysadm,
be that carbon-based or otherwise.

But this kthread is spawned early enough that only CPU 0 is online,
so maybe the question is not "what is binding it to CPU 0?" but rather
"why isn't something kicking it off of CPU 0?"

> I attempted to backport to our kernel all related patches that were
> not yet backported,
> and we still see a regression in our tests.

The per-grace-period CPU consumption of rcu_tasks_trace was intentionally
increased by the above commit, and I never have done anything to reduce
that CPU consumption.  In part because you are the first to call my
attention to it.

Oh, and one other issue that I very recently fixed, that has not
yet reached mainline, just in case it matters.  If you are building a
CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y kernel, but also have
CONFIG_RCU_TORTURE_TEST=m (or, for that matter, =y, but please don't in
production!), then your kernel will use RCU Tasks instead of vanilla RCU.
(Note well, RCU Tasks, not RCU Tasks Trace, the latter being necessaary
for sleepable BPF programs regardless of kernel .config).

> Please ignore the sha1 in this current patch series, this is only to
> show my current attempt to fix the regression in our tree.
> 
> 450b3244f29b rcu-tasks: Don't remove tasks with pending IPIs from holdout list
> 5f88f7e9cc36 rcu-tasks: Create per-CPU callback lists
> 1a943d0041dc rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic
> queue selection
> ea5289f12fce rcu-tasks: Convert grace-period counter to grace-period
> sequence number
> 22efd5093c3b rcu/segcblist: Prevent useless GP start if no CBs to accelerate
> 16dee1b3babf rcu: Implement rcu_segcblist_is_offloaded() config dependent
> 8cafaadb6144 rcu: Add callbacks-invoked counters
> 323234685765 rcu/tree: Make rcu_do_batch count how many callbacks were executed
> f48f3386a1cc rcu/segcblist: Add additional comments to explain smp_mb()
> 4408105116de rcu/segcblist: Add counters to segcblist datastructure
> 4a0b89a918d6 rcu/tree: segcblist: Remove redundant smp_mb()s
> 38c0d18e8740 rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor
> 0b5d1031b509 rcu/segcblist: Add debug checks for segment lengths
> 8a82886fbf02 rcu_tasks: Convert bespoke callback list to rcu_segcblist structure
> cbd452a5c01f rcu-tasks: Use spin_lock_rcu_node() and friends
> 073222be51f3 rcu-tasks: Add a ->percpu_enqueue_lim to the rcu_tasks structure
> 5af10fb0f8fb rcu-tasks: Abstract checking of callback lists
> d3e8be598546 rcu-tasks: Abstract invocations of callbacks
> 65784460a392 rcu-tasks: Use workqueues for multiple
> rcu_tasks_invoke_cbs() invocations
> dd6413e355f1 rcu-tasks: Make rcu_barrier_tasks*() handle multiple
> callback queues
> 2499cb3c438e rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set
> initial queueing
> a859f409a503 rcu-tasks: Count trylocks to estimate call_rcu_tasks() contention
> 4ab253ca056e rcu-tasks: Avoid raw-spinlocked wakeups from
> call_rcu_tasks_generic()
> e9a3563fe76e rcu-tasks: Use more callback queues if contention encountered
> 4023187fe31d rcu-tasks: Use separate ->percpu_dequeue_lim for callback
> dequeueing
> 533be3bd47c3 rcu: Provide polling interfaces for Tree RCU grace periods
> f7e5a81d7953 rcu-tasks: Use fewer callbacks queues if callback flood ends
> bb7ad9078e1b rcu-tasks: Fix computation of CPU-to-list shift counts
> d9cebde55539 rcu-tasks: Use order_base_2() instead of ilog2()
> 95606f1248f5 rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention
