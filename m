Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF64157D7E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiGVBDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:03:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422FC972CA;
        Thu, 21 Jul 2022 18:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBCF3B826E3;
        Fri, 22 Jul 2022 01:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF77C3411E;
        Fri, 22 Jul 2022 01:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658451821;
        bh=iPdb7jOqh7VuOcc4Z3fRk3Q9Sfd2ZYQGd7640S39Z78=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X4onZ7sF88RD6HXmB1apkf/zDh/33fuF6QBxTljQe6fWbC8uaTZKea5vmAhBMpdRa
         BItWGHI4HymCFdEJ65U31r01zz7EvYdVp9t018yfKsZFsL7k/DXGHI+EdIHeQE2GKz
         AIVzc8q1+78BoRjDSGGz2s+TY/UOlauNMBnBDOW5bfP+1W2uNR6CI/PH++xrxyyKYx
         sJxgDwjYZiekHwfzYli3plcjhKhLS3Hf1Y3kk9Gsk7+LsGwd7EJYsZqOgGrKq1Wx1P
         m5B1d0orXswrihiTNG5kQqoHUz4pE6R2CllrT2JC+Sxcp4tRDn3etUjOUn5xBEMVnB
         VczQJlzQp40cA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0B4155C03A4; Thu, 21 Jul 2022 18:03:41 -0700 (PDT)
Date:   Thu, 21 Jul 2022 18:03:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH rcu 04/12] rcu: Switch polled grace-period APIs to
 ->gp_seq_polled
Message-ID: <20220722010341.GC1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
 <20220620225128.3842050-4-paulmck@kernel.org>
 <Ytijki0fkkyKaD9u@boqun-archlinux>
 <20220721010455.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YtixMeMCcqAyeTiH@boqun-archlinux>
 <20220721044708.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <Ytjo5gPq0TnJEeZY@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytjo5gPq0TnJEeZY@boqun-archlinux>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:49:26PM -0700, Boqun Feng wrote:
> On Wed, Jul 20, 2022 at 09:47:08PM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 20, 2022 at 06:51:45PM -0700, Boqun Feng wrote:
> > > On Wed, Jul 20, 2022 at 06:04:55PM -0700, Paul E. McKenney wrote:
> > > [...]
> > > > > > @@ -3860,7 +3944,7 @@ unsigned long get_state_synchronize_rcu(void)
> > > > > >  	 * before the load from ->gp_seq.
> > > > > >  	 */
> > > > > >  	smp_mb();  /* ^^^ */
> > > > > > -	return rcu_seq_snap(&rcu_state.gp_seq);
> > > > > > +	return rcu_seq_snap(&rcu_state.gp_seq_polled);
> > > > > 
> > > > > I happened to run into this. There is one usage of
> > > > > get_state_synchronize_rcu() in start_poll_synchronize_rcu(), in which
> > > > > the return value of get_state_synchronize_rcu() ("gp_seq") will be used
> > > > > for rcu_start_this_gp(). I don't think this is quite right, because
> > > > > after this change, rcu_state.gp_seq and rcu_state.gp_seq_polled are
> > > > > different values, in fact ->gp_seq_polled is greater than ->gp_seq
> > > > > by how many synchronize_rcu() is called in early boot.
> > > > > 
> > > > > Am I missing something here?
> > > > 
> > > > It does not appear that your are missing anything, sad to say!
> > > > 
> > > > Does the following make it work better?
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 2122359f0c862..cf2fd58a93a41 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3571,7 +3571,7 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
> > > >  unsigned long start_poll_synchronize_rcu(void)
> > > >  {
> > > >  	unsigned long flags;
> > > > -	unsigned long gp_seq = get_state_synchronize_rcu();
> > > > +	unsigned long gp_seq = rcu_seq_snap(&rcu_state.gp_seq);
> > > 
> > > get_state_synchronize_rcu() is still needed, because we need to return
> > > a cookie for polling for this function. Something like below maybe? Hope
> > > I didn't mess up the ordering ;-)
> > 
> > My thought is to combine your comment with my functionally equivalent
> > code that avoids the extra variable.  If that works for you (and if it
> > works, for that matter), does Co-developed-by work for you?
> 
> Sure! Thanks ;-)

I did some summarization on the comment, folded it into the original,
and ended up with the patch shown below.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit bf95b2bc3e42f11f4d7a5e8a98376c2b4a2aa82f
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Apr 13 17:46:15 2022 -0700

    rcu: Switch polled grace-period APIs to ->gp_seq_polled
    
    This commit switches the existing polled grace-period APIs to use a
    new ->gp_seq_polled counter in the rcu_state structure.  An additional
    ->gp_seq_polled_snap counter in that same structure allows the normal
    grace period kthread to interact properly with the !SMP !PREEMPT fastpath
    through synchronize_rcu().  The first of the two to note the end of a
    given grace period will make knowledge of this transition available to
    the polled API.
    
    This commit is in preparation for polled expedited grace periods.
    
    [ paulmck: Fix use of rcu_state.gp_seq_polled to start normal grace period. ]
    
    Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
    Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
    Cc: Brian Foster <bfoster@redhat.com>
    Cc: Dave Chinner <david@fromorbit.com>
    Cc: Al Viro <viro@zeniv.linux.org.uk>
    Cc: Ian Kent <raven@themaw.net>
    Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
    Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 46cfceea87847..b40a5a19ddd2a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1775,6 +1775,78 @@ static void rcu_strict_gp_boundary(void *unused)
 	invoke_rcu_core();
 }
 
+// Has rcu_init() been invoked?  This is used (for example) to determine
+// whether spinlocks may be acquired safely.
+static bool rcu_init_invoked(void)
+{
+	return !!rcu_state.n_online_cpus;
+}
+
+// Make the polled API aware of the beginning of a grace period.
+static void rcu_poll_gp_seq_start(unsigned long *snap)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	if (rcu_init_invoked())
+		raw_lockdep_assert_held_rcu_node(rnp);
+
+	// If RCU was idle, note beginning of GP.
+	if (!rcu_seq_state(rcu_state.gp_seq_polled))
+		rcu_seq_start(&rcu_state.gp_seq_polled);
+
+	// Either way, record current state.
+	*snap = rcu_state.gp_seq_polled;
+}
+
+// Make the polled API aware of the end of a grace period.
+static void rcu_poll_gp_seq_end(unsigned long *snap)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	if (rcu_init_invoked())
+		raw_lockdep_assert_held_rcu_node(rnp);
+
+	// If the previously noted GP is still in effect, record the
+	// end of that GP.  Either way, zero counter to avoid counter-wrap
+	// problems.
+	if (*snap && *snap == rcu_state.gp_seq_polled) {
+		rcu_seq_end(&rcu_state.gp_seq_polled);
+		rcu_state.gp_seq_polled_snap = 0;
+	} else {
+		*snap = 0;
+	}
+}
+
+// Make the polled API aware of the beginning of a grace period, but
+// where caller does not hold the root rcu_node structure's lock.
+static void rcu_poll_gp_seq_start_unlocked(unsigned long *snap)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	if (rcu_init_invoked()) {
+		lockdep_assert_irqs_enabled();
+		raw_spin_lock_irq_rcu_node(rnp);
+	}
+	rcu_poll_gp_seq_start(snap);
+	if (rcu_init_invoked())
+		raw_spin_unlock_irq_rcu_node(rnp);
+}
+
+// Make the polled API aware of the end of a grace period, but where
+// caller does not hold the root rcu_node structure's lock.
+static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	if (rcu_init_invoked()) {
+		lockdep_assert_irqs_enabled();
+		raw_spin_lock_irq_rcu_node(rnp);
+	}
+	rcu_poll_gp_seq_end(snap);
+	if (rcu_init_invoked())
+		raw_spin_unlock_irq_rcu_node(rnp);
+}
+
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
@@ -1810,6 +1882,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
+	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -2069,6 +2142,7 @@ static noinline void rcu_gp_cleanup(void)
 	 * safe for us to drop the lock in order to mark the grace
 	 * period as completed in all of the rcu_node structures.
 	 */
+	rcu_poll_gp_seq_end(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -3837,8 +3911,18 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
-	if (rcu_blocking_is_gp())
+	if (rcu_blocking_is_gp()) {
+		// Note well that this code runs with !PREEMPT && !SMP.
+		// In addition, all code that advances grace periods runs
+		// at process level.  Therefore, this GP overlaps with other
+		// GPs only by being fully nested within them, which allows
+		// reuse of ->gp_seq_polled_snap.
+		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
+		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
+		if (rcu_init_invoked())
+			cond_resched_tasks_rcu_qs();
 		return;  // Context allows vacuous grace periods.
+	}
 	if (rcu_gp_is_expedited())
 		synchronize_rcu_expedited();
 	else
@@ -3860,7 +3944,7 @@ unsigned long get_state_synchronize_rcu(void)
 	 * before the load from ->gp_seq.
 	 */
 	smp_mb();  /* ^^^ */
-	return rcu_seq_snap(&rcu_state.gp_seq);
+	return rcu_seq_snap(&rcu_state.gp_seq_polled);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
 
@@ -3889,7 +3973,13 @@ unsigned long start_poll_synchronize_rcu(void)
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
 	raw_spin_lock_rcu_node(rnp); // irqs already disabled.
-	needwake = rcu_start_this_gp(rnp, rdp, gp_seq);
+	// Note it is possible for a grace period to have elapsed between
+	// the above call to get_state_synchronize_rcu() and the below call
+	// to rcu_seq_snap.  This is OK, the worst that happens is that we
+	// get a grace period that no one needed.  These accesses are ordered
+	// by smp_mb(), and we are accessing them in the opposite order
+	// from which they are updated at grace-period start, as required.
+	needwake = rcu_start_this_gp(rnp, rdp, rcu_seq_snap(&rcu_state.gp_seq));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
 		rcu_gp_kthread_wake();
@@ -3925,7 +4015,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
 bool poll_state_synchronize_rcu(unsigned long oldstate)
 {
 	if (oldstate == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rcu_state.gp_seq, oldstate)) {
+	    rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2ccf5845957df..9c853033f159d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -323,6 +323,8 @@ struct rcu_state {
 	short gp_state;				/* GP kthread sleep state. */
 	unsigned long gp_wake_time;		/* Last GP kthread wake. */
 	unsigned long gp_wake_seq;		/* ->gp_seq at ^^^. */
+	unsigned long gp_seq_polled;		/* GP seq for polled API. */
+	unsigned long gp_seq_polled_snap;	/* ->gp_seq_polled at normal GP start. */
 
 	/* End of fields guarded by root rcu_node's lock. */
 
