Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3148DA47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiAMO7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:59:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38444 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiAMO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:59:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D12261CF5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6DDC36AEC;
        Thu, 13 Jan 2022 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642085941;
        bh=9cSTw/jmQFhSGTiDmcNQb3Wo1Aiy5yG6xkZ5iqLIVvQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YMbACkmPJ13w90hJnQbqnYn73GDox+R8nt2lYg46fr9et76jhCTDaPbiqueFH8tdx
         6MNYf8VsgPkWaEacTy+tXEj9IKknFUnoM0HxkS8XuIMqH2ElNk+s9RdXDjrN3gkUpe
         UG2m2MhdyU/J4JbAfLDnv2crRGaYqzYMFiO41wBJKDZITen1hNIBRgmcnDwDcWLX24
         w56kiwwUaFG+gcjwHq876ERArfYIOmlvQSxbYbwKYRXBSu6ATApAOEbld7SNcWF+1O
         Sf4XkXz2Gbgl8k8g3CjbOjhsXEbUKEhgdekf2m+v6NYNHyMpGzy76DvHF+jGbET7RV
         I6ayFzWLtoIag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9FB95C00E7; Thu, 13 Jan 2022 06:59:00 -0800 (PST)
Date:   Thu, 13 Jan 2022 06:59:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        quic_neeraju@quicinc.com, frederic@kernel.org, urezki@gmail.com,
        boqun.feng@gmail.com
Subject: Re: [syzbot] KASAN: use-after-free Read in srcu_invoke_callbacks
Message-ID: <20220113145900.GS947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <00000000000081b56205d54c6667@google.com>
 <20220111134324.1727-1-hdanton@sina.com>
 <20220112094352.1785-1-hdanton@sina.com>
 <20220112171247.GM947480@paulmck-ThinkPad-P17-Gen-1>
 <20220113044938.1881-1-hdanton@sina.com>
 <20220113131256.1941-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113131256.1941-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 09:12:56PM +0800, Hillf Danton wrote:
> On Wed, 12 Jan 2022 21:14:59 -0800 Paul E. McKenney wrote:
> > On Thu, Jan 13, 2022 at 12:49:38PM +0800, Hillf Danton wrote:
> ...
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit d730d54e543e5cf7376ff61e3ad407490f08c85e
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Wed Jan 12 09:52:44 2022 -0800
> > > > 
> > > >     srcu: Tighten cleanup_srcu_struct() GP checks
> > > >     
> > > >     Currently, cleanup_srcu_struct() checks for a grace period in progress,
> > > >     but it does not check for a grace period that has not yet started but
> > > >     which might start at any time.  Such a situation could result in a
> > > >     use-after-free bug, so this commit adds a check for a grace period that
> > > >     is needed but not yet started to cleanup_srcu_struct().
> > > >     
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 128034f858897..c78391a5e20dc 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -382,9 +382,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> > > >  			return; /* Forgot srcu_barrier(), so just leak it! */
> > > >  	}
> > > >  	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
> > > > +	    WARN_ON(rcu_seq_current(&ssp->srcu_gp_seq) != ssp->srcu_gp_seq_needed) ||
> > > >  	    WARN_ON(srcu_readers_active(ssp))) {
> > > > -		pr_info("%s: Active srcu_struct %p state: %d\n",
> > > > -			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)));
> > > > +		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
> > > > +			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)),
> > > > +			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
> > > >  		return; /* Caller forgot to stop doing call_srcu()? */
> > > >  	}
> > > >  	free_percpu(ssp->sda);
> > > > 
> > > 
> > > Without the help from a covid booster, what I can do for the flush_work()
> > > in cleanup_srcu_struct() is go another round of invoking srcu callbacks
> > > directly without bothering to queue the work again.
> > > 
> > > With the minor change, we are sure work is idle after flush.
> > 
> > First, exactly what sequence of events would this change protect against?
> 
> It makes sure that work is idle after flush only within cleanup_srcu_struct()
> regardless of whatever prior to the cleanup.

Nice try, but that answer does not match the question.  ;-)

I need to know a definite sequence of events corresponding to your
"whatever prior".

Otherwise, we are just as likely to be breaking something as we are to be
fixing something, and the breakage might well be worse than the problem.

> > > Hillf
> > > 
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1232,12 +1232,6 @@ static void srcu_advance_state(struct sr
> > >  	}
> > >  }
> > >  
> > > -/*
> > > - * Invoke a limited number of SRCU callbacks that have passed through
> > > - * their grace period.  If there are more to do, SRCU will reschedule
> > > - * the workqueue.  Note that needed memory barriers have been executed
> > > - * in this task's context by srcu_readers_active_idx_check().
> > > - */
> > >  static void srcu_invoke_callbacks(struct work_struct *work)
> > >  {
> > >  	long len;
> > > @@ -1249,6 +1243,7 @@ static void srcu_invoke_callbacks(struct
> > >  
> > >  	sdp = container_of(work, struct srcu_data, work);
> > >  
> > > +again:
> > >  	ssp = sdp->ssp;
> > >  	rcu_cblist_init(&ready_cbs);
> > >  	spin_lock_irq_rcu_node(sdp);
> > > @@ -1276,7 +1271,7 @@ static void srcu_invoke_callbacks(struct
> > >  
> > >  	/*
> > >  	 * Update counts, accelerate new callbacks, and if needed,
> > > -	 * schedule another round of callback invocation.
> > > +	 * go another round of callback invocation.
> > >  	 */
> > >  	spin_lock_irq_rcu_node(sdp);
> > >  	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
> > > @@ -1286,7 +1281,7 @@ static void srcu_invoke_callbacks(struct
> > >  	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
> > >  	spin_unlock_irq_rcu_node(sdp);
> > >  	if (more)
> > > -		srcu_schedule_cbs_sdp(sdp, 0);
> > > +		goto again;
> > >  }
> > >  
> > >  /*
> > 
> > Second, in non-shutdown conditions, what prevents an infinite loop inside
> > of srcu_invoke_callbacks()?
> 
> That tight loop can be avoid by adding a flushing flag to srcu_data,
> which is set before flush in cleanup_srcu_struct() and checked at the
> end of srcu_invoke_callbacks().
> 
> Only for thoughts now.

Is the syzbot report reproducible?

							Thanx, Paul

> Hillf
> 
> +++ b/kernel/rcu/srcutree.c
> @@ -376,6 +376,9 @@ void cleanup_srcu_struct(struct srcu_str
>  	for_each_possible_cpu(cpu) {
>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
> +		spin_lock_irq_rcu_node(sdp);
> +		sdp->flushing = true;
> +		spin_unlock_irq_rcu_node(sdp);
>  		del_timer_sync(&sdp->delay_work);
>  		flush_work(&sdp->work);
>  		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> @@ -1232,16 +1235,11 @@ static void srcu_advance_state(struct sr
>  	}
>  }
>  
> -/*
> - * Invoke a limited number of SRCU callbacks that have passed through
> - * their grace period.  If there are more to do, SRCU will reschedule
> - * the workqueue.  Note that needed memory barriers have been executed
> - * in this task's context by srcu_readers_active_idx_check().
> - */
>  static void srcu_invoke_callbacks(struct work_struct *work)
>  {
>  	long len;
>  	bool more;
> +	bool flushing;
>  	struct rcu_cblist ready_cbs;
>  	struct rcu_head *rhp;
>  	struct srcu_data *sdp;
> @@ -1249,6 +1247,7 @@ static void srcu_invoke_callbacks(struct
>  
>  	sdp = container_of(work, struct srcu_data, work);
>  
> +again:
>  	ssp = sdp->ssp;
>  	rcu_cblist_init(&ready_cbs);
>  	spin_lock_irq_rcu_node(sdp);
> @@ -1276,17 +1275,21 @@ static void srcu_invoke_callbacks(struct
>  
>  	/*
>  	 * Update counts, accelerate new callbacks, and if needed,
> -	 * schedule another round of callback invocation.
> +	 * go another round of callback invocation.
>  	 */
>  	spin_lock_irq_rcu_node(sdp);
>  	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
>  	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
>  				       rcu_seq_snap(&ssp->srcu_gp_seq));
>  	sdp->srcu_cblist_invoking = false;
> +	flushing = sdp->flushing;
>  	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
>  	spin_unlock_irq_rcu_node(sdp);
>  	if (more)
> -		srcu_schedule_cbs_sdp(sdp, 0);
> +		if (flushing)
> +			goto again;
> +		else
> +			srcu_schedule_cbs_sdp(sdp, 0); 
>  }
>  
>  /*
