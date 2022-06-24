Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF29558F32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiFXDkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiFXDjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DE63AA;
        Thu, 23 Jun 2022 20:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34F8D6209B;
        Fri, 24 Jun 2022 03:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE81C3411D;
        Fri, 24 Jun 2022 03:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656041991;
        bh=NpSSGPtiOhvDDmEzPBYJ461neo9OWr8+rN+qdrQTdQM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WwuY2xGxR8pBmy3A/ywmQbvWHUSxfI+NeEWtr/0QAua9GbKFpw6gc7QbGTf6srHaj
         8mMOaLvePLzTNbiP2/7v4orqzfAdo4hKW7+57WVMibAc1GSqo1EOEh9TOqbzMctf/C
         Vadr+RX1HDnELheUIwGgtPzeuASrFycM/49CmwWBX0allriiHPwdmtoWXvdmKRhRba
         PU196FPXMiPvNsWQomlze2lrfbufmQ2tyPF/q/65vijrH0WynSaK72NnsXdWFS4Er/
         JooFE56HUA2rA4iNG39glS1Vvta6GOadWmSjFr7ez5bYRhovAu93pK+dFItpVJSSEX
         j/nDwCnvh+Y1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F10B25C0A6A; Thu, 23 Jun 2022 20:39:50 -0700 (PDT)
Date:   Thu, 23 Jun 2022 20:39:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH] rcu: back off on allocation failure in
 fill_page_cache_func
Message-ID: <20220624033950.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622114711.28154-1-mhocko@kernel.org>
 <YrNlXkLfDpd+Ulxf@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrNlXkLfDpd+Ulxf@pc638.lan>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 08:54:22PM +0200, Uladzislau Rezki wrote:
> On Wed, Jun 22, 2022 at 01:47:11PM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > fill_page_cache_func allocates couple of pages to store
> > kvfree_rcu_bulk_data. This is a lightweight (GFP_NORETRY) allocation
> > which can fail under memory pressure. The function will, however keep
> > retrying even when the previous attempt has failed.
> > 
> > While this is not really incorrect there is one thing to consider. This
> > allocation is invoked from the WQ context and that means that if the
> > memory reclaim gets stuck it can hog the worker for quite some time.
> > WQ concurrency is only triggered when the worker context sleeps and that
> > is not guaranteed for __GFP_NORETRY allocation attempts (see
> > should_reclaim_retry).
> > 
> > We have seen WQ lockups
> > kernel: BUG: workqueue lockup - pool cpus=93 node=1 flags=0x1 nice=0 stuck for 32s!
> > [...]
> > kernel: pool 74: cpus=37 node=0 flags=0x1 nice=0 hung=32s workers=2 manager: 2146
> > kernel:   pwq 498: cpus=249 node=1 flags=0x1 nice=0 active=4/256 refcnt=5
> > kernel:     in-flight: 1917:fill_page_cache_func
> > kernel:     pending: dbs_work_handler, free_work, kfree_rcu_monitor
> > 
> > Originaly, we thought that several retries with direct reclaim being
> > stuck is the underlying reason but we couldn't have confirmed that and
> > have seen a similar lockups detected even without any heavy memory
> > pressure so there is likely something else/more going on. On the other
> > hand failing the allocation shouldn't have a big impact and from the
> > code it is not really obvious why retrying is desirable so back off
> > after the allocation failure.
> > 
> > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> > 
> > Hi,
> > I am sending this as an RFC because I couldn't prove that the WQ
> > concurency issue as a result from the allocation retry is really a
> > problem. On the other hand I couldn't see a good reason to retry after a
> > previous failure. While the kswapd running in the background could have
> > released some memory this is a not really guaranteed and mostly a
> > wishful thinking.
> > 
> > I do not understand the code well enough so I could be easily missing
> > something. If the patch is a wrong thing to do then it would be really
> > nice to add a comment why the retry is desirable and a good thing to do.
> > 
> > The retry loop should be bound to rcu_min_cached_objs which is quite
> > small but configurable so this can get large in some setups.
> > 
> > Thanks
> > 
> >  kernel/rcu/tree.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c25ba442044a..54a3a19c4c0b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3508,15 +3508,16 @@ static void fill_page_cache_func(struct work_struct *work)
> >  		bnode = (struct kvfree_rcu_bulk_data *)
> >  			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> >  
> > -		if (bnode) {
> > -			raw_spin_lock_irqsave(&krcp->lock, flags);
> > -			pushed = put_cached_bnode(krcp, bnode);
> > -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > +		if (!bnode)
> > +			break;
> >  
> > -			if (!pushed) {
> > -				free_page((unsigned long) bnode);
> > -				break;
> > -			}
> > +		raw_spin_lock_irqsave(&krcp->lock, flags);
> > +		pushed = put_cached_bnode(krcp, bnode);
> > +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > +
> > +		if (!pushed) {
> > +			free_page((unsigned long) bnode);
> > +			break;
> >  		}
> >  	}
> >  
> > -- 
> > 2.30.2
> >
> OK. You would like to break the loop once an allocation does not succeed.
> To me it also makes sense, i mean there is no reason to repeat it several
> times that can lead to worqueue hogging.
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued for testing and further review, thank you both!

My normal process would send this not into the upcoming merge window
(v5.20?) but instead into the next one (v6.0?).  Please let me know if
this is more urgent then that, and I will see what I can do.

							Thanx, Paul
