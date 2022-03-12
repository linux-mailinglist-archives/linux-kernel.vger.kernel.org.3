Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF04D7033
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 18:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiCLRqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 12:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiCLRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 12:46:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E482F000
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 09:44:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFBD061126
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 17:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBD5C340EB;
        Sat, 12 Mar 2022 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647107098;
        bh=9Z82X9reKl/9NPOSG9a0GkCFhD5Zbv6LoK94Bqncg/E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XDoFrhfE/TbsBkNlbTuPRLBXy2tCZie2zQysvMNgHS4JEzT0xbdQR0c28q3lnSh3m
         remLSa5b1sJgqd9ItyBQamS1PZCAFNour0lXY0YoGGy6a7IdGJpVtjz24MazFWmhX4
         dXO87Bn5uY5d6KYyiumnlv4DC2ggOZ0FoHcSPcdKv1jd9Bosk2H3/Ya+z/zHJf/Mc4
         +AJLRz67t1skA1ZkDg7wfJg0nZOCB/yWdWrzkdJ1MC/6LqACXm0UXqWcoAjbM0mqJg
         QNpUYY2kXdPRELUcNcdl13PCEw7K7exAhM53cEEiw0aGnuHnXhpbWZBtFvn4ICSSvi
         eiCjQCzvD4n/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D47885C042D; Sat, 12 Mar 2022 09:44:57 -0800 (PST)
Date:   Sat, 12 Mar 2022 09:44:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        vincent.guittot@linaro.org, bristot@redhat.com,
        zhaolei@cn.fujitsu.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Message-ID: <20220312174457.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
 <20220220051426.5274-2-zhouchengming@bytedance.com>
 <CGME20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f@eucas1p2.samsung.com>
 <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
 <YifniVyoJ9NNU+pv@hirez.programming.kicks-ass.net>
 <20220308234403.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <Yim6nUmfGk5FHv6K@hirez.programming.kicks-ass.net>
 <20220310150152.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <20220312121533.GD6235@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312121533.GD6235@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 01:15:33PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 10, 2022 at 07:01:52AM -0800, Paul E. McKenney wrote:
> 
> > > > > > ./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> > > > > 
> > > > > Arguably, with the flavours folded again, rcu_dereference_check() ought
> > > > > to default include rcu_read_lock_sched_held() or its equivalent I
> > > > > suppose.
> > > > > 
> > > > > Paul?
> > > > 
> > > > That would reduce the number of warnings, but it also would hide bugs.
> > > > 
> > > > So, are you sure you really want this?
> > > 
> > > I don't understand... Since the flavours got merged regular RCU has it's
> > > quescent state held off by preempt_disable. So how can relying on that
> > > cause bugs?
> > 
> > Somene forgets an rcu_read_lock() and there happens to be something
> > like a preempt_disable() that by coincidence covers that particular
> > rcu_dereference().  The kernel therefore doesn't complain.  That someone
> > goes on to other things, maybe even posthumously.  Then some time later
> > the preempt_disable() goes away, for good and sufficient reasons.
> > 
> > Good luck figuring out where to put the needed rcu_read_lock() and
> > rcu_read_unlock().
> 
> Well, that's software engineering for you.

My point exactly!!!

>                                            Also in that case the warning
> will work as expected. Then figuring out how to fix it is not the
> problem of the warning -- that worked as advertised.
> 
> (also, I don't think it'll be too hard, you just gotta figure out which
> object is rcu protected -- the warning gives you this, where the lookup
> happens -- again the warning helps, and how long it's used for, all
> relatively well definted things)

Without in any way agreeing with that assessment of difficulty, especially
in the general case...  It is -way- easier just to tell RCU what your
design rules are for the code in question.

> I don't see a problem. No bugs hidden.

C'mon, Peter!

There really was a bug hidden.  That someone intended to add some
calls to rcu_read_lock() and rcu_read_unlock() in the proper places.
Their failure to add them really was a bug.

That bug was hidden by: (1) There being a preempt_disable() or
whatever that by coincidence happened to be covering the part of the
code containing the rcu_dereference() and (2) Your proposed change that
would make rcu_dereference() unable to detect that bug.

And that bug can be quite bad.  Given your proposed change, RCU
cannot detect this bug:


	/* Preemption is enabled. */
	/* There should be an rcu_read_lock() here. */
	preempt_disable();
	p = rcu_dereference(gp);
	do_something_with(p);
	preempt_enable();
	/* Without the rcu_read_lock(), *p is history. */
	do_something_else_with(p);
	/* There should be an rcu_read_unlock() here. */

> > > And if we can rely on that, then surely rcu_dereferenced_check() ought
> > > to play by the same rules, otherwise we get silly warnings like these at
> > > hand.
> > > 
> > > Specifically, we removed the rcu_read_lock() here because this has
> > > rq->lock held, which is a raw_spinlock_t which very much implies preempt
> > > disable, on top of that, it's also an IRQ-safe lock and thus IRQs will
> > > be disabled.
> > > 
> > > There is no possible way for RCU to make progress.
> > 
> > Then let's have that particular rcu_dereference_check() explicitly state
> > what it needs, which seems to be either rcu_read_lock() on the one hand.
> > Right now, that could be just this:
> > 
> > 	p = rcu_dereference_check(gp, rcu_read_lock_sched_held());
> > 
> > Or am I missing something here?
> 
> That will work; I just don't agree with it. Per the rules of RCU it is
> entirely correct to mix rcu_read_lock() and preempt_disable() (or
> anything that implies the same). So I strongly feel that
> rcu_dereference() should not warn about obviously correct code. Why
> would we need to special case this ?

This use case might well be entirely correct, but it is most certainly
not the common case.

Therefore, my answer to this requested chance in rcu_dereference()
semantics is "no".

							Thanx, Paul
