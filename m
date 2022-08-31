Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA65A82D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiHaQPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiHaQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:15:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E486F4C620;
        Wed, 31 Aug 2022 09:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67D2BB821EB;
        Wed, 31 Aug 2022 16:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08551C433C1;
        Wed, 31 Aug 2022 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661962523;
        bh=SCqfgJyLIQD7HI1202DMV2VpiKYadpluO6AM1dsF7Ss=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GDyBUKFa0NjK5kefHxgnzNIdYQ0xhwE6M9ghoIgQbE6EiVDSN+B3FQLdtEPAtHizF
         7yNnmPliX9ubT5TD30xMIblvoMSW/0BB48Va1Tu1ZyB7ZeWrvfesQb2Ogt2TN1jQgf
         4ju3BvbZtLDofQT20CDI7FKJQw0MMQxaEfWRZcH8aX/TAkzDrhLLk2n/uFOh9RiUBP
         v/RwKK6OOR7oQsM80M5O/t+IyjMllB4vtb934tSxLarM+vAdgsscO85hPobWWvpcSy
         Bs3k2RekVxPulSi7eobHOiGqpbsPpvcu1BcsZRldO1l+Rsjf6T1kEF7UxlhC9RmFlh
         trF9gqeOLDbzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9934E5C015D; Wed, 31 Aug 2022 09:15:22 -0700 (PDT)
Date:   Wed, 31 Aug 2022 09:15:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, boqun.feng@gmail.com
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
Message-ID: <20220831161522.GA2582451@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-7-kernelfans@gmail.com>
 <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
 <20220823030125.GJ6159@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTup0uTqnKi79Tu+5Q0POYVdcE4UkGes8KfHXBd6VR552A@mail.gmail.com>
 <20220824162050.GA6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824162050.GA6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:20:50AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 24, 2022 at 09:53:11PM +0800, Pingfan Liu wrote:
> > On Tue, Aug 23, 2022 at 11:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Tue, Aug 23, 2022 at 09:50:56AM +0800, Pingfan Liu wrote:
> > > > On Sun, Aug 21, 2022 at 07:45:28PM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
> > > > > > In order to support parallel, rcu_state.n_online_cpus should be
> > > > > > atomic_dec()
> > > > > >
> > > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > >
> > > > > I have to ask...  What testing have you subjected this patch to?
> > > > >
> > > >
> > > > This patch subjects to [1]. The series aims to enable kexec-reboot in
> > > > parallel on all cpu. As a result, the involved RCU part is expected to
> > > > support parallel.
> > >
> > > I understand (and even sympathize with) the expectation.  But results
> > > sometimes diverge from expectations.  There have been implicit assumptions
> > > in RCU about only one CPU going offline at a time, and I am not sure
> > > that all of them have been addressed.  Concurrent CPU onlining has
> > > been looked at recently here:
> > >
> > > https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing
> > >
> > > You did us atomic_dec() to make rcu_state.n_online_cpus decrementing be
> > > atomic, which is good.  Did you look through the rest of RCU's CPU-offline
> > > code paths and related code paths?
> > 
> > I went through those codes at a shallow level, especially at each
> > cpuhp_step hook in the RCU system.
> 
> And that is fine, at least as a first step.
> 
> > But as you pointed out, there are implicit assumptions about only one
> > CPU going offline at a time, I will chew the google doc which you
> > share.  Then I can come to a final result.
> 
> Boqun Feng, Neeraj Upadhyay, Uladzislau Rezki, and I took a quick look,
> and rcu_boost_kthread_setaffinity() seems to need some help.  As it
> stands, it appears that concurrent invocations of this function from the
> CPU-offline path will cause all but the last outgoing CPU's bit to be
> (incorrectly) set in the cpumask_var_t passed to set_cpus_allowed_ptr().
> 
> This should not be difficult to fix, for example, by maintaining a
> separate per-leaf-rcu_node-structure bitmask of the concurrently outgoing
> CPUs for that rcu_node structure.  (Similar in structure to the
> ->qsmask field.)
> 
> There are probably more where that one came from.  ;-)

And here is one more from this week's session.

The calls to tick_dep_set() and tick_dep_clear() use atomic operations,
but they operate on a global variable.  This means that the first call
to rcutree_offline_cpu() would enable the tick and the first call to
rcutree_dead_cpu() would disable the tick.  This might be OK, but it
is at the very least bad practice.  There needs to be a counter
mediating these calls.

For more detail, please see the Google document:

https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing

							Thanx, Paul

> > > > [1]: https://lore.kernel.org/linux-arm-kernel/20220822021520.6996-3-kernelfans@gmail.com/T/#mf62352138d7b040fdb583ba66f8cd0ed1e145feb
> > >
> > > Perhaps I am more blind than usual today, but I am not seeing anything
> > > in this patch describing the testing.  At this point, I am thinking in
> > > terms of making rcutorture test concurrent CPU offlining parallel
> > 
> > Yes, testing results are more convincing in this area.
> > 
> > After making clear the implicit assumptions, I will write some code to
> > bridge my code and rcutorture test. Since the series is a little
> > different from parallel cpu offlining. It happens after all devices
> > are torn down, and there is no way to rollback.
> 
> Very good, looking forward to seeing what you come up with!
> 
> > > Thoughts?
> > 
> > Need a deeper dive into this field. Hope to bring out something soon.
> 
> Again, looking forward to seeing what you find!
> 
> 							Thanx, Paul
