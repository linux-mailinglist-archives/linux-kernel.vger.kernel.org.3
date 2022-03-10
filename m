Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F382E4D4CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbiCJPKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344949AbiCJPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:09:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A5190B4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D627B82684
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C258FC340E8;
        Thu, 10 Mar 2022 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646924512;
        bh=td0wkGepnn+FaoZWGBTCTi5yQxK4AepRnqvzrNiImzc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qCycqZyDQTDBXK1X2ukLPJ2MOP/TJfS66iQk68Ll7a/ZfKiMLS6dDi3GC8HVq2eB9
         kRH7E0vscjWVHGD1luXpSsg3OLz64W/yGHvOLnKqz8tvGko7zO6EWLYcZtYVBN+brt
         ks1CMHjDIFcI3IQeUPlTeD+ozKsGrGVCjyRmtO8r9Zi5XI6gsiMX4Yu5KRzSVTn1yt
         U5shPZm2/6IH4U2ukG+sbDvwQs0Am8oH4j1nLw6Niqfm8VxoqcgqHHvIFoKxs6t/bP
         Ivw2eQUwjZrVMwlHzukR5lM6lDDvmPKDv9VcYFhgYlIoWuessrhs6+laTiBIHmfUdn
         m3qjLoduruJZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 577575C015D; Thu, 10 Mar 2022 07:01:52 -0800 (PST)
Date:   Thu, 10 Mar 2022 07:01:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        vincent.guittot@linaro.org, bristot@redhat.com,
        zhaolei@cn.fujitsu.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Message-ID: <20220310150152.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
 <20220220051426.5274-2-zhouchengming@bytedance.com>
 <CGME20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f@eucas1p2.samsung.com>
 <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
 <YifniVyoJ9NNU+pv@hirez.programming.kicks-ass.net>
 <20220308234403.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <Yim6nUmfGk5FHv6K@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yim6nUmfGk5FHv6K@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:45:17AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 08, 2022 at 03:44:03PM -0800, Paul E. McKenney wrote:
> > On Wed, Mar 09, 2022 at 12:32:25AM +0100, Peter Zijlstra wrote:
> > > On Wed, Mar 09, 2022 at 12:20:33AM +0100, Marek Szyprowski wrote:
> > > > On 20.02.2022 06:14, Chengming Zhou wrote:
> > > > > Since cpuacct_charge() is called from the scheduler update_curr(),
> > > > > we must already have rq lock held, then the RCU read lock can
> > > > > be optimized away.
> > > > >
> > > > > And do the same thing in it's wrapper cgroup_account_cputime(),
> > > > > but we can't use lockdep_assert_rq_held() there, which defined
> > > > > in kernel/sched/sched.h.
> > > > >
> > > > > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > > 
> > > > This patch landed recently in linux-next as commit dc6e0818bc9a 
> > > > ("sched/cpuacct: Optimize away RCU read lock"). On my test systems I 
> > > > found that it triggers a following warning in the early boot stage:
> > > > 
> > > > Calibrating delay loop (skipped), value calculated using timer 
> > > > frequency.. 48.00 BogoMIPS (lpj=240000)
> > > > pid_max: default: 32768 minimum: 301
> > > > Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> > > > Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> > > > CPU: Testing write buffer coherency: ok
> > > > CPU0: Spectre v2: using BPIALL workaround
> > > > 
> > > > =============================
> > > > WARNING: suspicious RCU usage
> > > > 5.17.0-rc5-00050-gdc6e0818bc9a #11458 Not tainted
> > > > -----------------------------
> > > > ./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> > > 
> > > Arguably, with the flavours folded again, rcu_dereference_check() ought
> > > to default include rcu_read_lock_sched_held() or its equivalent I
> > > suppose.
> > > 
> > > Paul?
> > 
> > That would reduce the number of warnings, but it also would hide bugs.
> > 
> > So, are you sure you really want this?
> 
> I don't understand... Since the flavours got merged regular RCU has it's
> quescent state held off by preempt_disable. So how can relying on that
> cause bugs?

Somene forgets an rcu_read_lock() and there happens to be something
like a preempt_disable() that by coincidence covers that particular
rcu_dereference().  The kernel therefore doesn't complain.  That someone
goes on to other things, maybe even posthumously.  Then some time later
the preempt_disable() goes away, for good and sufficient reasons.

Good luck figuring out where to put the needed rcu_read_lock() and
rcu_read_unlock().

> And if we can rely on that, then surely rcu_dereferenced_check() ought
> to play by the same rules, otherwise we get silly warnings like these at
> hand.
> 
> Specifically, we removed the rcu_read_lock() here because this has
> rq->lock held, which is a raw_spinlock_t which very much implies preempt
> disable, on top of that, it's also an IRQ-safe lock and thus IRQs will
> be disabled.
> 
> There is no possible way for RCU to make progress.

Then let's have that particular rcu_dereference_check() explicitly state
what it needs, which seems to be either rcu_read_lock() on the one hand.
Right now, that could be just this:

	p = rcu_dereference_check(gp, rcu_read_lock_sched_held());

Or am I missing something here?

							Thanx, Paul
