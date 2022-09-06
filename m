Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFE5AEFC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiIFP7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiIFP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:59:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33912B867;
        Tue,  6 Sep 2022 08:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7C1361584;
        Tue,  6 Sep 2022 15:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6394C433D6;
        Tue,  6 Sep 2022 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662477481;
        bh=6bXYrJvn3otuSLF3aA7hYluot/Fn9Xe12IYghkcz9pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUeBZKlIOyqiOkXEFtxsynBhXtE/f/0WKVZ/n+Hmvl2nSM5qc+x+gGnEBQd2yKjo6
         6rcgtiUp5izbkqdEo15Eyl1uVBE3VKUDekkyOe0ztTRodGoa4PVwuCHffIwd5HtxyO
         EGZL2fiXOrWURihOCV/xYy9L3nN0LiBYSnSqjgBV0DtGIOAQa04nHRzx0PNp26SLvs
         ltoWH7/JpG2PMO1ogPZHihQHg6DDEfBDiq+nNRgvuEy8+VVYF6l+ZzkNIOC+1cbjsM
         xFVzTsUGAZEQm1fEaoXkr1374V+fSEYeEWiXn4tZPciZObznIDf84HNkSAY1oYXBgh
         DB6Sdq2bvCM/A==
Date:   Tue, 6 Sep 2022 17:17:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220906151757.GA183806@lothringen>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxa5Ch574cRZxRdo@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:05:46AM +0000, Joel Fernandes wrote:
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 4dc86274b3e8..b201606f7c4f 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -256,6 +256,31 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>  }
>  
> +/*
> + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
> + * can elapse before lazy callbacks are flushed. Lazy callbacks
> + * could be flushed much earlier for a number of other reasons
> + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
> + * left unsubmitted to RCU after those many jiffies.
> + */
> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> +unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;

Still not static.

> @@ -293,12 +322,16 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>   * proves to be initially empty, just return false because the no-CB GP
>   * kthread may need to be awakened in this case.
>   *
> + * Return true if there was something to be flushed and it succeeded, otherwise
> + * false.
> + *

This kind of contradict the comment that follows. Not sure you need to add
that line because the existing comment seem to cover it.

>   * Note that this function always returns true if rhp is NULL.

>   */
>  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				     unsigned long j)
> +				     unsigned long j, unsigned long flush_flags)
>  {
>  	struct rcu_cblist rcl;
> +	bool lazy = flush_flags & FLUSH_BP_LAZY;
>  
>  	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
>  	rcu_lockdep_assert_cblist_protected(rdp);
> @@ -326,13 +372,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j)
> +				  unsigned long j, unsigned long flush_flags)
>  {
> +	bool ret;
> +
>  	if (!rcu_rdp_is_offloaded(rdp))
>  		return true;
>  	rcu_lockdep_assert_cblist_protected(rdp);
>  	rcu_nocb_bypass_lock(rdp);
> -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
> +	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> +
> +	if (flush_flags & FLUSH_BP_WAKE)
> +		wake_nocb_gp(rdp, true);

Why the true above?

Also should we check if the wake up is really necessary (otherwise it means we
force a wake up for all rdp's from rcu_barrier())?

       was_alldone = rcu_segcblist_pend_cbs(&rdp->cblist);
       ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
       if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
       	  wake_nocb_gp(rdp, false);


> @@ -461,16 +521,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	// We need to use the bypass.
>  	rcu_nocb_wait_contended(rdp);
>  	rcu_nocb_bypass_lock(rdp);
> +
>  	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>  	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
>  	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> +
> +	if (IS_ENABLED(CONFIG_RCU_LAZY) && lazy)
> +		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
> +
>  	if (!ncbs) {
>  		WRITE_ONCE(rdp->nocb_bypass_first, j);
>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
>  	}
> +
>  	rcu_nocb_bypass_unlock(rdp);
>  	smp_mb(); /* Order enqueue before wake. */
> -	if (ncbs) {
> +
> +	// We had CBs in the bypass list before. There is nothing else to do if:
> +	// There were only non-lazy CBs before, in this case, the bypass timer

Kind of misleading. I would replace "There were only non-lazy CBs before" with
"There was at least one non-lazy CBs before".

> +	// or GP-thread will handle the CBs including any new lazy ones.
> +	// Or, the new CB is lazy and the old bypass-CBs were also lazy. In this
> +	// case the old lazy timer would have been setup. When that expires,
> +	// the new lazy one will be handled.
> +	if (ncbs && (!bypass_is_lazy || lazy)) {
>  		local_irq_restore(flags);
>  	} else {
>  		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
> @@ -479,6 +552,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  					    TPS("FirstBQwake"));
>  			__call_rcu_nocb_wake(rdp, true, flags);
> +		} else if (bypass_is_lazy && !lazy) {
> +			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> +					    TPS("FirstBQwakeLazy2Non"));
> +			__call_rcu_nocb_wake(rdp, true, flags);

Not sure we need this chunk. Since there are pending callbacks anyway,
nocb_gp_wait() should be handling them and it will set the appropriate
timer on the next loop.

Thanks.

>  		} else {
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  					    TPS("FirstBQnoWake"));
