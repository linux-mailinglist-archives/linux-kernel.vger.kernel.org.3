Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE87356CC6D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGJC04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiGJC0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:26:55 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC85B859
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 19:26:53 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id ck6so3265703qtb.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTjH/X+3Hkm1druqKxzfXtGWsd5HAhOB5mxjrqNdQuw=;
        b=f2S5h//Bzd99hB6HI2u0RPQo2LpQj5kUP6jQayprJlzBxCJKlcyBQWBbJZhGa3HNpM
         9lqxFaGaB2A9gkDvPd6UsJXRGQvkGJLH1GqWeRMA/nZGa44GgTo36Tkmrvgjs6cGJCOR
         WR589aomo2Qys+L9XqbAM+ssKwxz8tTZoyAuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTjH/X+3Hkm1druqKxzfXtGWsd5HAhOB5mxjrqNdQuw=;
        b=peXAnRvND6O/0jIPZwFahGb8LrZyyBVXpQSQ6RlCl2Kmdg2EghKqtVGJrxpyJPAxjo
         vBkyTmaj4kw+X2qPdRGPbm0epGpkE95oAneN5aKk5AO66mebkNz5R68r2uwc0lWHwzE7
         u+m40SBXNvIYU95LggqJ2pbLGb7pNZHwhnhSekE5aOOqFxoJnO1ZU9z7SIGqO9d10cZw
         8QxIX7z3QWdh6L08gEUYROwb2LbGYFEiiQsG8zLKXYxV4VlG93QhOdINxGSX+HtfjV7w
         g0xcZjZ8oUC4yuswo2nvj5sF+B3qgwE+KKFrAzO77+/AuYsyBQPHuCp763+zCBdGDZHs
         khlg==
X-Gm-Message-State: AJIora80x4yCsxwHG7nWn77Wr68dOoLoxgAkMxEDvqOOgeWnXXIY3v2y
        KjteUHc4nSUinIA+bes/PNfY4g==
X-Google-Smtp-Source: AGRyM1vbvPSzwYJG6HASNMeIBK/bpwjWl1cpUk0MCp3LP37DKLf8NGcP8JbC6EalDDQSCx/PmqvtLw==
X-Received: by 2002:ac8:5e12:0:b0:31e:a396:19a7 with SMTP id h18-20020ac85e12000000b0031ea39619a7mr9166164qtx.491.1657420012392;
        Sat, 09 Jul 2022 19:26:52 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id q9-20020a05620a0d8900b006a6ce613c7csm2754584qkl.89.2022.07.09.19.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 19:26:52 -0700 (PDT)
Date:   Sun, 10 Jul 2022 02:26:51 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <Yso4690g+lI/8eJS@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I replied some more and will reply more soon, its a really long thread and
thank you for the detailed review :)

On Sat, Jun 25, 2022 at 09:00:19PM -0700, Paul E. McKenney wrote:
[..]
> > +}
> > +
> >  /*
> >   * Flush the second rcu_cblist structure onto the first one, obliterating
> >   * any contents of the first.  If rhp is non-NULL, enqueue it as the sole
> > @@ -60,6 +70,15 @@ void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
> >  	}
> >  }
> 
> Header comment, please.  It can be short, referring to that of the
> function rcu_cblist_flush_enqueue().

Done, what I ended up doing is nuking the new function and doing the same
IS_ENABLED() trick to the existing rcu_cblist_flush_enqueue(). diffstat is
also happy!

> > +void rcu_cblist_flush_enqueue_lazy(struct rcu_cblist *drclp,
> > +			      struct rcu_cblist *srclp,
> > +			      struct rcu_head *rhp)
> 
> Please line up the "struct" keywords.  (Picky, I know...)
> 
> > +{
> > +	rcu_cblist_flush_enqueue(drclp, srclp, rhp);
> > +	if (rhp)
> > +		WRITE_ONCE(srclp->lazy_len, 1);
> 
> Shouldn't this instead be a lazy argument to rcu_cblist_flush_enqueue()?
> Concerns about speed in the !RCU_LAZY case can be addressed using
> IS_ENABLED(), for example:
> 
> 	if (IS_ENABLED(CONFIG_RCU_LAZY) && rhp)
> 		WRITE_ONCE(srclp->lazy_len, 1);

Ah indeed exactly what I ended up doing.

> > +}
> > +
> >  /*
> >   * Dequeue the oldest rcu_head structure from the specified callback
> >   * list.
> > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > index 431cee212467..c3d7de65b689 100644
> > --- a/kernel/rcu/rcu_segcblist.h
> > +++ b/kernel/rcu/rcu_segcblist.h
> > @@ -15,14 +15,28 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
> >  	return READ_ONCE(rclp->len);
> >  }
> >  
> > +/* Return number of callbacks in the specified callback list. */
> > +static inline long rcu_cblist_n_lazy_cbs(struct rcu_cblist *rclp)
> > +{
> > +#ifdef CONFIG_RCU_LAZY
> > +	return READ_ONCE(rclp->lazy_len);
> > +#else
> > +	return 0;
> > +#endif
> 
> Please use IS_ENABLED().  This saves a line (and lots of characters)
> but compiles just as efficienctly.

Sounds good, looks a lot better, thanks!

It ends up looking like:

static inline long rcu_cblist_n_lazy_cbs(struct rcu_cblist *rclp)
{
        if (IS_ENABLED(CONFIG_RCU_LAZY))
                return READ_ONCE(rclp->lazy_len);
        return 0;
}

static inline void rcu_cblist_reset_lazy_len(struct rcu_cblist *rclp)
{
        if (IS_ENABLED(CONFIG_RCU_LAZY))
                WRITE_ONCE(rclp->lazy_len, 0);
}

> > +}
> > +
> >  /* Return number of callbacks in segmented callback list by summing seglen. */
> >  long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
> >  
> >  void rcu_cblist_init(struct rcu_cblist *rclp);
> >  void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
> > +void rcu_cblist_enqueue_lazy(struct rcu_cblist *rclp, struct rcu_head *rhp);
> >  void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
> >  			      struct rcu_cblist *srclp,
> >  			      struct rcu_head *rhp);
> > +void rcu_cblist_flush_enqueue_lazy(struct rcu_cblist *drclp,
> > +			      struct rcu_cblist *srclp,
> > +			      struct rcu_head *rhp);
> 
> Please line up the "struct" keywords.  (Still picky, I know...)

Nuked it due to new lazy parameter so no issue now.
 
> >  struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp);
> >  
> >  /*
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c25ba442044a..d2e3d6e176d2 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3098,7 +3098,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
> >   * Implementation of these memory-ordering guarantees is described here:
> >   * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
> >   */
> 
> The above docbook comment needs to move to call_rcu().

Ok sure.

> > -void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > +static void
> > +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
> >  {
> >  	static atomic_t doublefrees;
> >  	unsigned long flags;
> > @@ -3139,7 +3140,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	}
> >  
> >  	check_cb_ovld(rdp);
> > -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
> >  		return; // Enqueued onto ->nocb_bypass, so just leave.
> >  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> >  	rcu_segcblist_enqueue(&rdp->cblist, head);
> > @@ -3161,8 +3162,21 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  		local_irq_restore(flags);
> >  	}
> >  }
> > -EXPORT_SYMBOL_GPL(call_rcu);
> 
> Please add a docbook comment for call_rcu_lazy().  It can be brief, for
> example, by referring to call_rcu()'s docbook comment for memory-ordering
> details.

I added something like the following, hope it looks OK:

#ifdef CONFIG_RCU_LAZY
/**
 * call_rcu_lazy() - Lazily queue RCU callback for invocation after grace period.
 * @head: structure to be used for queueing the RCU updates.
 * @func: actual callback function to be invoked after the grace period
 *
 * The callback function will be invoked some time after a full grace
 * period elapses, in other words after all pre-existing RCU read-side
 * critical sections have completed.
 *
 * Use this API instead of call_rcu() if you don't mind the callback being
 * invoked after very long periods of time on systems without memory pressure
 * and on systems which are lightly loaded or mostly idle.
 *
 * Other than the extra delay in callbacks being invoked, this function is
 * identical to, and reuses call_rcu()'s logic. Refer to call_rcu() for more
 * details about memory ordering and other functionality.
 */
void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func)
{
        return __call_rcu_common(head, func, true);
}
EXPORT_SYMBOL_GPL(call_rcu_lazy);
#endif

> 
> > +#ifdef CONFIG_RCU_LAZY
> > +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +	return __call_rcu_common(head, func, true);
> > +}
> > +EXPORT_SYMBOL_GPL(call_rcu_lazy);
> > +#endif
> > +
> > +void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +	return __call_rcu_common(head, func, false);
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(call_rcu);
> >  
> >  /* Maximum number of jiffies to wait before draining a batch. */
> >  #define KFREE_DRAIN_JIFFIES (HZ / 50)
> > @@ -4056,7 +4070,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  	rdp->barrier_head.func = rcu_barrier_callback;
> >  	debug_rcu_head_queue(&rdp->barrier_head);
> >  	rcu_nocb_lock(rdp);
> > -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> > +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
> >  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
> >  		atomic_inc(&rcu_state.barrier_cpu_count);
> >  	} else {
> > @@ -4476,7 +4490,7 @@ void rcutree_migrate_callbacks(int cpu)
> >  	my_rdp = this_cpu_ptr(&rcu_data);
> >  	my_rnp = my_rdp->mynode;
> >  	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
> > -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
> > +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false));
> >  	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
> >  	/* Leverage recent GPs and set GP for new callbacks. */
> >  	needwake = rcu_advance_cbs(my_rnp, rdp) ||
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 2ccf5845957d..fec4fad6654b 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -267,8 +267,9 @@ struct rcu_data {
> >  /* Values for nocb_defer_wakeup field in struct rcu_data. */
> >  #define RCU_NOCB_WAKE_NOT	0
> >  #define RCU_NOCB_WAKE_BYPASS	1
> > -#define RCU_NOCB_WAKE		2
> > -#define RCU_NOCB_WAKE_FORCE	3
> > +#define RCU_NOCB_WAKE_LAZY	2
> > +#define RCU_NOCB_WAKE		3
> > +#define RCU_NOCB_WAKE_FORCE	4
> >  
> >  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
> >  					/* For jiffies_till_first_fqs and */
> > @@ -436,9 +437,10 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
> >  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
> >  static void rcu_init_one_nocb(struct rcu_node *rnp);
> >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -				  unsigned long j);
> > +				  unsigned long j, bool lazy);
> >  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -				bool *was_alldone, unsigned long flags);
> > +				bool *was_alldone, unsigned long flags,
> > +				bool lazy);
> >  static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
> >  				 unsigned long flags);
> >  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index e369efe94fda..b9244f22e102 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -256,6 +256,8 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> >  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
> >  }
> 
> Comment on LAZY_FLUSH_JIFFIES purpose in life, please!  (At some point
> more flexibility may be required, but let's not unnecessarily rush
> into that.)

I added this:
/*
 * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
 * can elapse before lazy callbacks are flushed. Lazy callbacks
 * could be flushed much earlier for a number of other reasons
 * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
 * left unsubmitted to RCU after those many jiffies.
 */

> > +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> > +
> >  /*
> >   * Arrange to wake the GP kthread for this NOCB group at some future
> >   * time when it is safe to do so.
> > @@ -272,7 +274,10 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >  	 * Bypass wakeup overrides previous deferments. In case
> >  	 * of callback storm, no need to wake up too early.
> >  	 */
> > -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
> > +	if (waketype == RCU_NOCB_WAKE_LAZY) {
> 
> Presumably we get here only if all of this CPU's callbacks are lazy?

Yes that's right.

> >  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
> >  	WRITE_ONCE(rdp->nocb_bypass_first, j);
> >  	rcu_nocb_bypass_unlock(rdp);
> > @@ -326,13 +337,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >   * Note that this function always returns true if rhp is NULL.
> >   */
> >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -				  unsigned long j)
> > +				  unsigned long j, bool lazy)
> >  {
> >  	if (!rcu_rdp_is_offloaded(rdp))
> >  		return true;
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> >  	rcu_nocb_bypass_lock(rdp);
> > -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
> > +	return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy);
> >  }
> >  
> >  /*
> > @@ -345,7 +356,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
> >  	if (!rcu_rdp_is_offloaded(rdp) ||
> >  	    !rcu_nocb_bypass_trylock(rdp))
> >  		return;
> > -	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
> > +	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
> >  }
> >  
> >  /*
> > @@ -367,12 +378,14 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
> >   * there is only one CPU in operation.
> >   */
> >  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -				bool *was_alldone, unsigned long flags)
> > +				bool *was_alldone, unsigned long flags,
> > +				bool lazy)
> >  {
> >  	unsigned long c;
> >  	unsigned long cur_gp_seq;
> >  	unsigned long j = jiffies;
> >  	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > +	long n_lazy_cbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
> >  
> >  	lockdep_assert_irqs_disabled();
> >  
> > @@ -414,30 +427,37 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  	}
> >  	WRITE_ONCE(rdp->nocb_nobypass_count, c);
> >  
> > -	// If there hasn't yet been all that many ->cblist enqueues
> > -	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
> > -	// ->nocb_bypass first.
> > -	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> > +	// If caller passed a non-lazy CB and there hasn't yet been all that
> > +	// many ->cblist enqueues this jiffy, tell the caller to enqueue it
> > +	// onto ->cblist.  But flush ->nocb_bypass first. Also do so, if total
> > +	// number of CBs (lazy + non-lazy) grows too much.
> > +	//
> > +	// Note that if the bypass list has lazy CBs, and the main list is
> > +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> > +	// the lazy CBs to the main list as well. That's the right thing to do,
> > +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> > +	// one, we can just reuse that GP for the already queued-up lazy ones.
> > +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> > +	    (lazy && n_lazy_cbs >= qhimark)) {
> >  		rcu_nocb_lock(rdp);
> >  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> >  		if (*was_alldone)
> >  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> > -					    TPS("FirstQ"));
> > -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> > +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
> 
> The "false" here instead of "lazy" is because the caller is to do the
> enqueuing, correct?

There is no difference between using false or lazy here, because the bypass
flush is not also enqueuing the lazy callback, right?

We can also pass lazy instead of false if that's less confusing.

Or maybe I missed the issue you're raising?

> >  		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> >  		return false; // Caller must enqueue the callback.
> >  	}
> >  
> >  	// If ->nocb_bypass has been used too long or is too full,
> >  	// flush ->nocb_bypass to ->cblist.
> > -	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
> > -	    ncbs >= qhimark) {
> > +	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark) {
> >  		rcu_nocb_lock(rdp);
> > -		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
> > +		if (!rcu_nocb_flush_bypass(rdp, rhp, j, true)) {
> 
> But shouldn't this "true" be "lazy"?  I don't see how we are guaranteed
> that the callback is in fact lazy at this point in the code.  Also,
> there is not yet a guarantee that the caller will do the enqueuing.
> So what am I missing?

Sorry I screwed this part up. I think I meant 'false' here, if the list grew
too big- then I think I would prefer if the new lazy CB instead is treated as
non-lazy. But if that's too confusing, I will just pass 'lazy' instead. What
do you think?

Will reply more to the rest of the comments soon, thanks!

thanks,

 - Joel

