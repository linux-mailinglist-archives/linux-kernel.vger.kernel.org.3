Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2775055AE96
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiFZEAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiFZEAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04261180E;
        Sat, 25 Jun 2022 21:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B3C860FD4;
        Sun, 26 Jun 2022 04:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BCAC3411D;
        Sun, 26 Jun 2022 04:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656216019;
        bh=b60zK4UKV2y1466RkbOFZm+HL9e8X8i+C/sCiNT4b4A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C59thovCzSahEwetVV+j9nPrS4x+6yuegep9t0HT3+xR7esoXWapLRDIgXzTbSRL8
         IO7wweee3SIJNbKhV9ej/CZKFsAjd9Z96u4pQo7ucafWKMcC8V6pj0Rj8kSAxo77Hu
         Sf2d1XiCKSgBNt/O2FilLTdEggDgFKjsZxuPS3eRG5/u1CybZmiS2mp/TQTNK7M7X8
         0AE45dLwUNlzI13xTdqABe87iwjziERfmi/OGrGgUFBRxkQ6JqhT8cbr7yGrAednHO
         bacogSsIyZTWuo9FWv7PtOGIQL3rspeEI4H4MQUbPRcGcfaYO5e0rDOuWhkckus10C
         VegPfDzo67iuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 12C9B5C0260; Sat, 25 Jun 2022 21:00:19 -0700 (PDT)
Date:   Sat, 25 Jun 2022 21:00:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> Implement timer-based RCU lazy callback batching. The batch is flushed
> whenever a certain amount of time has passed, or the batch on a
> particular CPU grows too big. Also memory pressure will flush it in a
> future patch.
> 
> To handle several corner cases automagically (such as rcu_barrier() and
> hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
> length has the lazy CB length included in it. A separate lazy CB length
> counter is also introduced to keep track of the number of lazy CBs.
> 
> Suggested-by: Paul McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Not bad, but some questions and comments below.

							Thanx, Paul

> ---
>  include/linux/rcu_segcblist.h |   1 +
>  include/linux/rcupdate.h      |   6 ++
>  kernel/rcu/Kconfig            |   8 +++
>  kernel/rcu/rcu_segcblist.c    |  19 ++++++
>  kernel/rcu/rcu_segcblist.h    |  14 ++++
>  kernel/rcu/tree.c             |  24 +++++--
>  kernel/rcu/tree.h             |  10 +--
>  kernel/rcu/tree_nocb.h        | 125 +++++++++++++++++++++++++---------
>  8 files changed, 164 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> index 659d13a7ddaa..9a992707917b 100644
> --- a/include/linux/rcu_segcblist.h
> +++ b/include/linux/rcu_segcblist.h
> @@ -22,6 +22,7 @@ struct rcu_cblist {
>  	struct rcu_head *head;
>  	struct rcu_head **tail;
>  	long len;
> +	long lazy_len;
>  };
>  
>  #define RCU_CBLIST_INITIALIZER(n) { .head = NULL, .tail = &n.head }
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 1a32036c918c..9191a3d88087 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -82,6 +82,12 @@ static inline int rcu_preempt_depth(void)
>  
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
> +#ifdef CONFIG_RCU_LAZY
> +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
> +#else
> +#define call_rcu_lazy(head, func) call_rcu(head, func)
> +#endif
> +
>  /* Internal to kernel */
>  void rcu_init(void);
>  extern int rcu_scheduler_active;
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 27aab870ae4c..0bffa992fdc4 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -293,4 +293,12 @@ config TASKS_TRACE_RCU_READ_MB
>  	  Say N here if you hate read-side memory barriers.
>  	  Take the default if you are unsure.
>  
> +config RCU_LAZY
> +	bool "RCU callback lazy invocation functionality"
> +	depends on RCU_NOCB_CPU
> +	default n
> +	help
> +	  To save power, batch RCU callbacks and flush after delay, memory
> +          pressure or callback list growing too big.

Spaces vs. tabs.

The checkpatch warning is unhelpful ("please write a help paragraph that
fully describes the config symbol"), but please fix the whitespace if
you have not already done so.

>  endmenu # "RCU Subsystem"
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index c54ea2b6a36b..627a3218a372 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -20,6 +20,7 @@ void rcu_cblist_init(struct rcu_cblist *rclp)
>  	rclp->head = NULL;
>  	rclp->tail = &rclp->head;
>  	rclp->len = 0;
> +	rclp->lazy_len = 0;
>  }
>  
>  /*
> @@ -32,6 +33,15 @@ void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
>  	WRITE_ONCE(rclp->len, rclp->len + 1);
>  }
>  
> +/*
> + * Enqueue an rcu_head structure onto the specified callback list.

Please also note the fact that it is enqueuing lazily.

> + */
> +void rcu_cblist_enqueue_lazy(struct rcu_cblist *rclp, struct rcu_head *rhp)
> +{
> +	rcu_cblist_enqueue(rclp, rhp);
> +	WRITE_ONCE(rclp->lazy_len, rclp->lazy_len + 1);

Except...  Why not just add a "lazy" parameter to rcu_cblist_enqueue()?
IS_ENABLED() can make it fast.

> +}
> +
>  /*
>   * Flush the second rcu_cblist structure onto the first one, obliterating
>   * any contents of the first.  If rhp is non-NULL, enqueue it as the sole
> @@ -60,6 +70,15 @@ void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
>  	}
>  }

Header comment, please.  It can be short, referring to that of the
function rcu_cblist_flush_enqueue().

> +void rcu_cblist_flush_enqueue_lazy(struct rcu_cblist *drclp,
> +			      struct rcu_cblist *srclp,
> +			      struct rcu_head *rhp)

Please line up the "struct" keywords.  (Picky, I know...)

> +{
> +	rcu_cblist_flush_enqueue(drclp, srclp, rhp);
> +	if (rhp)
> +		WRITE_ONCE(srclp->lazy_len, 1);

Shouldn't this instead be a lazy argument to rcu_cblist_flush_enqueue()?
Concerns about speed in the !RCU_LAZY case can be addressed using
IS_ENABLED(), for example:

	if (IS_ENABLED(CONFIG_RCU_LAZY) && rhp)
		WRITE_ONCE(srclp->lazy_len, 1);

> +}
> +
>  /*
>   * Dequeue the oldest rcu_head structure from the specified callback
>   * list.
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 431cee212467..c3d7de65b689 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -15,14 +15,28 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
>  	return READ_ONCE(rclp->len);
>  }
>  
> +/* Return number of callbacks in the specified callback list. */
> +static inline long rcu_cblist_n_lazy_cbs(struct rcu_cblist *rclp)
> +{
> +#ifdef CONFIG_RCU_LAZY
> +	return READ_ONCE(rclp->lazy_len);
> +#else
> +	return 0;
> +#endif

Please use IS_ENABLED().  This saves a line (and lots of characters)
but compiles just as efficienctly.

> +}
> +
>  /* Return number of callbacks in segmented callback list by summing seglen. */
>  long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
>  
>  void rcu_cblist_init(struct rcu_cblist *rclp);
>  void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
> +void rcu_cblist_enqueue_lazy(struct rcu_cblist *rclp, struct rcu_head *rhp);
>  void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
>  			      struct rcu_cblist *srclp,
>  			      struct rcu_head *rhp);
> +void rcu_cblist_flush_enqueue_lazy(struct rcu_cblist *drclp,
> +			      struct rcu_cblist *srclp,
> +			      struct rcu_head *rhp);

Please line up the "struct" keywords.  (Still picky, I know...)

> +{
> +	rcu_cblist_flush_enqueue(drclp, srclp, rhp);
> +	if (rhp)
> +		WRITE_ONCE(srclp->lazy_len, 1);
> +}
> +
>  /*
>   * Dequeue the oldest rcu_head structure from the specified callback
>   * list.
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 431cee212467..c3d7de65b689 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -15,14 +15,28 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
>  	return READ_ONCE(rclp->len);
>  }
>  
> +/* Return number of callbacks in the specified callback list. */
> +static inline long rcu_cblist_n_lazy_cbs(struct rcu_cblist *rclp)
> +{
> +#ifdef CONFIG_RCU_LAZY
> +	return READ_ONCE(rclp->lazy_len);
> +#else
> +	return 0;
> +#endif

Please use IS_ENABLED().  This saves a line (and lots of characters)
but compiles just as efficienctly.

> +}
> +
>  /* Return number of callbacks in segmented callback list by summing seglen. */
>  long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
>  
>  void rcu_cblist_init(struct rcu_cblist *rclp);
>  void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
> +void rcu_cblist_enqueue_lazy(struct rcu_cblist *rclp, struct rcu_head *rhp);
>  void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
>  			      struct rcu_cblist *srclp,
>  			      struct rcu_head *rhp);
> +void rcu_cblist_flush_enqueue_lazy(struct rcu_cblist *drclp,
> +			      struct rcu_cblist *srclp,
> +			      struct rcu_head *rhp);

Please line up the "struct" keywords.  (Even more pickiness, I know...)

>  struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp);
>  
>  /*
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c25ba442044a..d2e3d6e176d2 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3098,7 +3098,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
>   * Implementation of these memory-ordering guarantees is described here:
>   * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
>   */

The above docbook comment needs to move to call_rcu().

> -void call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static void
> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
>  {
>  	static atomic_t doublefrees;
>  	unsigned long flags;
> @@ -3139,7 +3140,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	}
>  
>  	check_cb_ovld(rdp);
> -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
>  		return; // Enqueued onto ->nocb_bypass, so just leave.
>  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
>  	rcu_segcblist_enqueue(&rdp->cblist, head);
> @@ -3161,8 +3162,21 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		local_irq_restore(flags);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(call_rcu);

Please add a docbook comment for call_rcu_lazy().  It can be brief, for
example, by referring to call_rcu()'s docbook comment for memory-ordering
details.

> +#ifdef CONFIG_RCU_LAZY
> +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func)
> +{
> +	return __call_rcu_common(head, func, true);
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_lazy);
> +#endif
> +
> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +	return __call_rcu_common(head, func, false);
> +
> +}
> +EXPORT_SYMBOL_GPL(call_rcu);
>  
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (HZ / 50)
> @@ -4056,7 +4070,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	rdp->barrier_head.func = rcu_barrier_callback;
>  	debug_rcu_head_queue(&rdp->barrier_head);
>  	rcu_nocb_lock(rdp);
> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>  		atomic_inc(&rcu_state.barrier_cpu_count);
>  	} else {
> @@ -4476,7 +4490,7 @@ void rcutree_migrate_callbacks(int cpu)
>  	my_rdp = this_cpu_ptr(&rcu_data);
>  	my_rnp = my_rdp->mynode;
>  	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false));
>  	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
>  	/* Leverage recent GPs and set GP for new callbacks. */
>  	needwake = rcu_advance_cbs(my_rnp, rdp) ||
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 2ccf5845957d..fec4fad6654b 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -267,8 +267,9 @@ struct rcu_data {
>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
>  #define RCU_NOCB_WAKE_NOT	0
>  #define RCU_NOCB_WAKE_BYPASS	1
> -#define RCU_NOCB_WAKE		2
> -#define RCU_NOCB_WAKE_FORCE	3
> +#define RCU_NOCB_WAKE_LAZY	2
> +#define RCU_NOCB_WAKE		3
> +#define RCU_NOCB_WAKE_FORCE	4
>  
>  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
>  					/* For jiffies_till_first_fqs and */
> @@ -436,9 +437,10 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j);
> +				  unsigned long j, bool lazy);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				bool *was_alldone, unsigned long flags);
> +				bool *was_alldone, unsigned long flags,
> +				bool lazy);
>  static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
>  				 unsigned long flags);
>  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index e369efe94fda..b9244f22e102 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -256,6 +256,8 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>  }

Comment on LAZY_FLUSH_JIFFIES purpose in life, please!  (At some point
more flexibility may be required, but let's not unnecessarily rush
into that.)

> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> +
>  /*
>   * Arrange to wake the GP kthread for this NOCB group at some future
>   * time when it is safe to do so.
> @@ -272,7 +274,10 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  	 * Bypass wakeup overrides previous deferments. In case
>  	 * of callback storm, no need to wake up too early.
>  	 */
> -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
> +	if (waketype == RCU_NOCB_WAKE_LAZY) {

Presumably we get here only if all of this CPU's callbacks are lazy?

> +		mod_timer(&rdp_gp->nocb_timer, jiffies + LAZY_FLUSH_JIFFIES);
> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>  	} else {
> @@ -296,7 +301,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				     unsigned long j)
> +				     unsigned long j, bool lazy)
>  {
>  	struct rcu_cblist rcl;
>  
> @@ -310,7 +315,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
>  	if (rhp)
>  		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
> -	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> +
> +	trace_printk("call_rcu_lazy callbacks = %ld\n", READ_ONCE(rdp->nocb_bypass.lazy_len));

This debug code need to go, of course.  If you would like, you could
replace it with a trace event.

> +	/* The lazy CBs are being flushed, but a new one might be enqueued. */
> +	if (lazy)
> +		rcu_cblist_flush_enqueue_lazy(&rcl, &rdp->nocb_bypass, rhp);
> +	else
> +		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);

Shouldn't these be a single function with a "lazy" argument, as noted
earlier?

>  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>  	WRITE_ONCE(rdp->nocb_bypass_first, j);
>  	rcu_nocb_bypass_unlock(rdp);
> @@ -326,13 +337,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j)
> +				  unsigned long j, bool lazy)
>  {
>  	if (!rcu_rdp_is_offloaded(rdp))
>  		return true;
>  	rcu_lockdep_assert_cblist_protected(rdp);
>  	rcu_nocb_bypass_lock(rdp);
> -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
> +	return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy);
>  }
>  
>  /*
> @@ -345,7 +356,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
>  	if (!rcu_rdp_is_offloaded(rdp) ||
>  	    !rcu_nocb_bypass_trylock(rdp))
>  		return;
> -	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
> +	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
>  }
>  
>  /*
> @@ -367,12 +378,14 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
>   * there is only one CPU in operation.
>   */
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				bool *was_alldone, unsigned long flags)
> +				bool *was_alldone, unsigned long flags,
> +				bool lazy)
>  {
>  	unsigned long c;
>  	unsigned long cur_gp_seq;
>  	unsigned long j = jiffies;
>  	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +	long n_lazy_cbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
>  
>  	lockdep_assert_irqs_disabled();
>  
> @@ -414,30 +427,37 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	}
>  	WRITE_ONCE(rdp->nocb_nobypass_count, c);
>  
> -	// If there hasn't yet been all that many ->cblist enqueues
> -	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
> -	// ->nocb_bypass first.
> -	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> +	// If caller passed a non-lazy CB and there hasn't yet been all that
> +	// many ->cblist enqueues this jiffy, tell the caller to enqueue it
> +	// onto ->cblist.  But flush ->nocb_bypass first. Also do so, if total
> +	// number of CBs (lazy + non-lazy) grows too much.
> +	//
> +	// Note that if the bypass list has lazy CBs, and the main list is
> +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> +	// the lazy CBs to the main list as well. That's the right thing to do,
> +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> +	// one, we can just reuse that GP for the already queued-up lazy ones.
> +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> +	    (lazy && n_lazy_cbs >= qhimark)) {
>  		rcu_nocb_lock(rdp);
>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  		if (*was_alldone)
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> -					    TPS("FirstQ"));
> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));

The "false" here instead of "lazy" is because the caller is to do the
enqueuing, correct?

>  		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>  		return false; // Caller must enqueue the callback.
>  	}
>  
>  	// If ->nocb_bypass has been used too long or is too full,
>  	// flush ->nocb_bypass to ->cblist.
> -	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
> -	    ncbs >= qhimark) {
> +	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark) {
>  		rcu_nocb_lock(rdp);
> -		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
> +		if (!rcu_nocb_flush_bypass(rdp, rhp, j, true)) {

But shouldn't this "true" be "lazy"?  I don't see how we are guaranteed
that the callback is in fact lazy at this point in the code.  Also,
there is not yet a guarantee that the caller will do the enqueuing.
So what am I missing?

>  			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  			if (*was_alldone)
>  				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> -						    TPS("FirstQ"));
> +						    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
>  			WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>  			return false; // Caller must enqueue the callback.
>  		}
> @@ -455,12 +475,20 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	rcu_nocb_wait_contended(rdp);
>  	rcu_nocb_bypass_lock(rdp);
>  	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +	n_lazy_cbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
>  	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
> -	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> +	if (lazy)
> +		rcu_cblist_enqueue_lazy(&rdp->nocb_bypass, rhp);
> +	else
> +		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);

And this is one reason to add the "lazy" parameter to rcu_cblist_enqueue().

>  	if (!ncbs) {
>  		WRITE_ONCE(rdp->nocb_bypass_first, j);
> -		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
> +		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> +				    lazy ? TPS("FirstLazyBQ") : TPS("FirstBQ"));
> +	} else if (!n_lazy_cbs && lazy) {
> +		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstLazyBQ"));

But in this case, there already are callbacks.  In that case, how does it
help to keep track of the laziness of this callback?

In fact, aren't the only meaningful states "empty", "all lazy", and
"at least one non-lazy callback"?  After all, if you have at least one
non-lazy callback, it needs to be business as usual, correct?

>  	}
> +
>  	rcu_nocb_bypass_unlock(rdp);
>  	smp_mb(); /* Order enqueue before wake. */
>  	if (ncbs) {
> @@ -493,7 +521,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  {
>  	unsigned long cur_gp_seq;
>  	unsigned long j;
> -	long len;
> +	long len, lazy_len, bypass_len;
>  	struct task_struct *t;
>  
>  	// If we are being polled or there is no kthread, just leave.
> @@ -506,9 +534,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  	}
>  	// Need to actually to a wakeup.
>  	len = rcu_segcblist_n_cbs(&rdp->cblist);
> +	bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +	lazy_len = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
>  	if (was_alldone) {
>  		rdp->qlen_last_fqs_check = len;
> -		if (!irqs_disabled_flags(flags)) {
> +		// Only lazy CBs in bypass list
> +		if (lazy_len && bypass_len == lazy_len) {

And this is one piece of evidence -- you are only checking for all
callbacks being lazy.  So do you really need to count them, as
opposed to note that all are lazy on the one hand or some are
non-lazy on the other?

> +			rcu_nocb_unlock_irqrestore(rdp, flags);
> +			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
> +					   TPS("WakeLazy"));
> +		} else if (!irqs_disabled_flags(flags)) {
>  			/* ... if queue was empty ... */
>  			rcu_nocb_unlock_irqrestore(rdp, flags);
>  			wake_nocb_gp(rdp, false);
> @@ -599,8 +634,8 @@ static inline bool nocb_gp_update_state_deoffloading(struct rcu_data *rdp,
>   */
>  static void nocb_gp_wait(struct rcu_data *my_rdp)
>  {
> -	bool bypass = false;
> -	long bypass_ncbs;
> +	bool bypass = false, lazy = false;
> +	long bypass_ncbs, lazy_ncbs;
>  	int __maybe_unused cpu = my_rdp->cpu;
>  	unsigned long cur_gp_seq;
>  	unsigned long flags;
> @@ -648,12 +683,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  			continue;
>  		}
>  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> -		if (bypass_ncbs &&
> +		lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
> +		if (lazy_ncbs &&

This one works either way.  The current approach works because the
timeout is longer.  If you have exceeded the lazy timeout, you don't
care that there are non-lazy callbacks queued.

> +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + LAZY_FLUSH_JIFFIES) ||
> +		     bypass_ncbs > qhimark)) {
> +			// Bypass full or old, so flush it.
> +			(void)rcu_nocb_try_flush_bypass(rdp, j);
> +			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +			lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
> +		} else if (bypass_ncbs &&
>  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
>  		     bypass_ncbs > 2 * qhimark)) {
>  			// Bypass full or old, so flush it.
>  			(void)rcu_nocb_try_flush_bypass(rdp, j);
>  			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +			lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);

And these two "if" bodies are identical, correct?  Can they be merged?

>  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
>  			rcu_nocb_unlock_irqrestore(rdp, flags);
>  			if (needwake_state)
> @@ -662,8 +706,11 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  		}
>  		if (bypass_ncbs) {
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> -					    TPS("Bypass"));
> -			bypass = true;
> +				    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));
> +			if (bypass_ncbs == lazy_ncbs)
> +				lazy = true;
> +			else
> +				bypass = true;

Another place where a lazy flag rather than count would suit.

>  		}
>  		rnp = rdp->mynode;
>  
> @@ -713,12 +760,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	my_rdp->nocb_gp_gp = needwait_gp;
>  	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
>  
> -	if (bypass && !rcu_nocb_poll) {
> -		// At least one child with non-empty ->nocb_bypass, so set
> -		// timer in order to avoid stranding its callbacks.
> -		wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
> -				   TPS("WakeBypassIsDeferred"));
> +	// At least one child with non-empty ->nocb_bypass, so set
> +	// timer in order to avoid stranding its callbacks.
> +	if (!rcu_nocb_poll) {
> +		// If bypass list only has lazy CBs. Add a deferred
> +		// lazy wake up.
> +		if (lazy && !bypass) {
> +			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
> +					TPS("WakeLazyIsDeferred"));
> +		// Otherwise add a deferred bypass wake up.
> +		} else if (bypass) {
> +			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
> +					TPS("WakeBypassIsDeferred"));
> +		}
>  	}
> +
>  	if (rcu_nocb_poll) {
>  		/* Polling, so trace if first poll in the series. */
>  		if (gotcbs)
> @@ -999,7 +1055,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  	 * return false, which means that future calls to rcu_nocb_try_bypass()
>  	 * will refuse to put anything into the bypass.
>  	 */
> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
>  	/*
>  	 * Start with invoking rcu_core() early. This way if the current thread
>  	 * happens to preempt an ongoing call to rcu_core() in the middle,
> @@ -1500,13 +1556,14 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  }
>  
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j)
> +				  unsigned long j, bool lazy)
>  {
>  	return true;
>  }
>  
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				bool *was_alldone, unsigned long flags)
> +				bool *was_alldone, unsigned long flags,
> +				bool lazy)
>  {
>  	return false;
>  }
> -- 
> 2.37.0.rc0.104.g0611611a94-goog
> 
