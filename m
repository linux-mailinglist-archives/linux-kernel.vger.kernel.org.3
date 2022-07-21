Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B1257C204
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiGUB4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGUB4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:56:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4060E6BC0F;
        Wed, 20 Jul 2022 18:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BACBB8221D;
        Thu, 21 Jul 2022 01:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F52C3411E;
        Thu, 21 Jul 2022 01:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658368604;
        bh=4dfoLYB2sR8FbSHG0+ns4sMaFsbfc1Xyk5sBv/G3vCc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U1KxqsB6tbDiGNbqBUQwLt+9x8rAYDMgIogglh6oI80Q/5AgW2FSe6lRqqKesHWuj
         bmaokrTmNv5y5e5J8j1fjCY9zThn1pnrPMK9DFMreHi4tKHp5iTSLtC0tMYROZgnR5
         xqLCNfI2Xxxscgco7P/i6gkHQmidgCR3cm7WCKebWe5/NCjtTyRb5yVluENd2vOvkd
         64XgbhGOFaGOLbAD42BVyDvdcq+SNyObcOrsPZzLjDojVCFpEtCEaZjBLZ8TRwYWN8
         YzK5jk0x56N0O8DQDENMjp4vK3zY4dLxdNQZ8dNWo1Xoi0ygfDF8N+6/6OxbQVkXrP
         19VclThTppKLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B78745C054C; Wed, 20 Jul 2022 18:56:43 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:56:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH rcu 04/12] rcu: Switch polled grace-period APIs to
 ->gp_seq_polled
Message-ID: <20220721015643.GA3791281@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
 <20220620225128.3842050-4-paulmck@kernel.org>
 <Ytijki0fkkyKaD9u@boqun-archlinux>
 <20220721010455.GR1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721010455.GR1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:04:55PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 20, 2022 at 05:53:38PM -0700, Boqun Feng wrote:
> > Hi Paul,
> > 
> > On Mon, Jun 20, 2022 at 03:51:20PM -0700, Paul E. McKenney wrote:
> > > This commit switches the existing polled grace-period APIs to use a
> > > new ->gp_seq_polled counter in the rcu_state structure.  An additional
> > > ->gp_seq_polled_snap counter in that same structure allows the normal
> > > grace period kthread to interact properly with the !SMP !PREEMPT fastpath
> > > through synchronize_rcu().  The first of the two to note the end of a
> > > given grace period will make knowledge of this transition available to
> > > the polled API.
> > > 
> > > This commit is in preparation for polled expedited grace periods.
> > > 
> > > Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
> > > Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
> > > Cc: Brian Foster <bfoster@redhat.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Ian Kent <raven@themaw.net>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/tree.c | 90 +++++++++++++++++++++++++++++++++++++++++++++--
> > >  kernel/rcu/tree.h |  2 ++
> > >  2 files changed, 89 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 46cfceea87847..637e8f9454573 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1775,6 +1775,78 @@ static void rcu_strict_gp_boundary(void *unused)
> > >  	invoke_rcu_core();
> > >  }
> > >  
> > > +// Has rcu_init() been invoked?  This is used (for example) to determine
> > > +// whether spinlocks may be acquired safely.
> > > +static bool rcu_init_invoked(void)
> > > +{
> > > +	return !!rcu_state.n_online_cpus;
> > > +}
> > > +
> > > +// Make the polled API aware of the beginning of a grace period.
> > > +static void rcu_poll_gp_seq_start(unsigned long *snap)
> > > +{
> > > +	struct rcu_node *rnp = rcu_get_root();
> > > +
> > > +	if (rcu_init_invoked())
> > > +		raw_lockdep_assert_held_rcu_node(rnp);
> > > +
> > > +	// If RCU was idle, note beginning of GP.
> > > +	if (!rcu_seq_state(rcu_state.gp_seq_polled))
> > > +		rcu_seq_start(&rcu_state.gp_seq_polled);
> > > +
> > > +	// Either way, record current state.
> > > +	*snap = rcu_state.gp_seq_polled;
> > > +}
> > > +
> > > +// Make the polled API aware of the end of a grace period.
> > > +static void rcu_poll_gp_seq_end(unsigned long *snap)
> > > +{
> > > +	struct rcu_node *rnp = rcu_get_root();
> > > +
> > > +	if (rcu_init_invoked())
> > > +		raw_lockdep_assert_held_rcu_node(rnp);
> > > +
> > > +	// If the the previously noted GP is still in effect, record the
> > > +	// end of that GP.  Either way, zero counter to avoid counter-wrap
> > > +	// problems.
> > > +	if (*snap && *snap == rcu_state.gp_seq_polled) {
> > > +		rcu_seq_end(&rcu_state.gp_seq_polled);
> > > +		rcu_state.gp_seq_polled_snap = 0;
> > > +	} else {
> > > +		*snap = 0;
> > > +	}
> > > +}
> > > +
> > > +// Make the polled API aware of the beginning of a grace period, but
> > > +// where caller does not hold the root rcu_node structure's lock.
> > > +static void rcu_poll_gp_seq_start_unlocked(unsigned long *snap)
> > > +{
> > > +	struct rcu_node *rnp = rcu_get_root();
> > > +
> > > +	if (rcu_init_invoked()) {
> > > +		lockdep_assert_irqs_enabled();
> > > +		raw_spin_lock_irq_rcu_node(rnp);
> > > +	}
> > > +	rcu_poll_gp_seq_start(snap);
> > > +	if (rcu_init_invoked())
> > > +		raw_spin_unlock_irq_rcu_node(rnp);
> > > +}
> > > +
> > > +// Make the polled API aware of the end of a grace period, but where
> > > +// caller does not hold the root rcu_node structure's lock.
> > > +static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> > > +{
> > > +	struct rcu_node *rnp = rcu_get_root();
> > > +
> > > +	if (rcu_init_invoked()) {
> > > +		lockdep_assert_irqs_enabled();
> > > +		raw_spin_lock_irq_rcu_node(rnp);
> > > +	}
> > > +	rcu_poll_gp_seq_end(snap);
> > > +	if (rcu_init_invoked())
> > > +		raw_spin_unlock_irq_rcu_node(rnp);
> > > +}
> > > +
> > >  /*
> > >   * Initialize a new grace period.  Return false if no grace period required.
> > >   */
> > > @@ -1810,6 +1882,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> > >  	rcu_seq_start(&rcu_state.gp_seq);
> > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > > +	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > >  
> > >  	/*
> > > @@ -2069,6 +2142,7 @@ static noinline void rcu_gp_cleanup(void)
> > >  	 * safe for us to drop the lock in order to mark the grace
> > >  	 * period as completed in all of the rcu_node structures.
> > >  	 */
> > > +	rcu_poll_gp_seq_end(&rcu_state.gp_seq_polled_snap);
> > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > >  
> > >  	/*
> > > @@ -3837,8 +3911,18 @@ void synchronize_rcu(void)
> > >  			 lock_is_held(&rcu_lock_map) ||
> > >  			 lock_is_held(&rcu_sched_lock_map),
> > >  			 "Illegal synchronize_rcu() in RCU read-side critical section");
> > > -	if (rcu_blocking_is_gp())
> > > +	if (rcu_blocking_is_gp()) {
> > > +		// Note well that this code runs with !PREEMPT && !SMP.
> > > +		// In addition, all code that advances grace periods runs
> > > +		// at process level.  Therefore, this GP overlaps with other
> > > +		// GPs only by being fully nested within them, which allows
> > > +		// reuse of ->gp_seq_polled_snap.
> > > +		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
> > > +		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
> > > +		if (rcu_init_invoked())
> > > +			cond_resched_tasks_rcu_qs();
> > >  		return;  // Context allows vacuous grace periods.
> > > +	}
> > >  	if (rcu_gp_is_expedited())
> > >  		synchronize_rcu_expedited();
> > >  	else
> > > @@ -3860,7 +3944,7 @@ unsigned long get_state_synchronize_rcu(void)
> > >  	 * before the load from ->gp_seq.
> > >  	 */
> > >  	smp_mb();  /* ^^^ */
> > > -	return rcu_seq_snap(&rcu_state.gp_seq);
> > > +	return rcu_seq_snap(&rcu_state.gp_seq_polled);
> > 
> > I happened to run into this. There is one usage of
> > get_state_synchronize_rcu() in start_poll_synchronize_rcu(), in which
> > the return value of get_state_synchronize_rcu() ("gp_seq") will be used
> > for rcu_start_this_gp(). I don't think this is quite right, because
> > after this change, rcu_state.gp_seq and rcu_state.gp_seq_polled are
> > different values, in fact ->gp_seq_polled is greater than ->gp_seq
> > by how many synchronize_rcu() is called in early boot.
> > 
> > Am I missing something here?
> 
> It does not appear that your are missing anything, sad to say!
> 
> Does the following make it work better?

Well, rcutorture doesn't like this change much.  ;-)

No surprise, given that it is only the value feeding into
rcu_start_this_gp() that needs to change, not the value returned from
start_poll_synchronize_rcu().

Take 2, still untested.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2122359f0c862..061c1f6737ddc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3581,7 +3581,7 @@ unsigned long start_poll_synchronize_rcu(void)
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
 	raw_spin_lock_rcu_node(rnp); // irqs already disabled.
-	needwake = rcu_start_this_gp(rnp, rdp, gp_seq);
+	needwake = rcu_start_this_gp(rnp, rdp, rcu_seq_snap(&rcu_state.gp_seq));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
 		rcu_gp_kthread_wake();
