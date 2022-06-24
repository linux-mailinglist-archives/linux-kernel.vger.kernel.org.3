Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28AC559A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiFXNCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiFXNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:02:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F7532DB;
        Fri, 24 Jun 2022 06:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E03C0B828B7;
        Fri, 24 Jun 2022 13:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA83C34114;
        Fri, 24 Jun 2022 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656075733;
        bh=qOkoAj3Cs3l+78kYs69ixIJ+E+RhjTYf6phoLBKg1Vs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZeqwkSFYQPkWyQgLUwUbdHNDJxaJg1223a2m8TiSo6A9mjaalCoxhXYwRcT1Mn9DA
         EXqw05IjZAU+d/6bitVvkSvQ+pzZjynxfOoByg8yYEgk6NOBwheWERCDXnhdxk2Z3C
         w/wQakaxpUKOOZhHlg+f0JzlWsh5GvPxcsjMERTjyTZbc1PzAIlGaLoM8EbrFymLah
         9R0xGiwqmxBB2brp0e/j+O5vPF4BsjfOXZLl8CCKH/IaoQNv3yKRbHJr/4y6G0SdH9
         1c0vUzPRRlZh8M0jqO01E/hwwCTKSNpE6vWW1HftopMQDctHYMa/kgL1B/oG+DznhT
         gHRTmL+8QN7eQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 371FD5C00A1; Fri, 24 Jun 2022 06:02:13 -0700 (PDT)
Date:   Fri, 24 Jun 2022 06:02:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH] rcu: back off on allocation failure in
 fill_page_cache_func
Message-ID: <20220624130213.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622114711.28154-1-mhocko@kernel.org>
 <YrNlXkLfDpd+Ulxf@pc638.lan>
 <20220624033950.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrVlG2XmKHcUSkTS@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrVlG2XmKHcUSkTS@dhcp22.suse.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 09:17:47AM +0200, Michal Hocko wrote:
> On Thu 23-06-22 20:39:50, Paul E. McKenney wrote:
> > On Wed, Jun 22, 2022 at 08:54:22PM +0200, Uladzislau Rezki wrote:
> > > On Wed, Jun 22, 2022 at 01:47:11PM +0200, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > fill_page_cache_func allocates couple of pages to store
> > > > kvfree_rcu_bulk_data. This is a lightweight (GFP_NORETRY) allocation
> > > > which can fail under memory pressure. The function will, however keep
> > > > retrying even when the previous attempt has failed.
> > > > 
> > > > While this is not really incorrect there is one thing to consider. This
> > > > allocation is invoked from the WQ context and that means that if the
> > > > memory reclaim gets stuck it can hog the worker for quite some time.
> > > > WQ concurrency is only triggered when the worker context sleeps and that
> > > > is not guaranteed for __GFP_NORETRY allocation attempts (see
> > > > should_reclaim_retry).
> > > > 
> > > > We have seen WQ lockups
> > > > kernel: BUG: workqueue lockup - pool cpus=93 node=1 flags=0x1 nice=0 stuck for 32s!
> > > > [...]
> > > > kernel: pool 74: cpus=37 node=0 flags=0x1 nice=0 hung=32s workers=2 manager: 2146
> > > > kernel:   pwq 498: cpus=249 node=1 flags=0x1 nice=0 active=4/256 refcnt=5
> > > > kernel:     in-flight: 1917:fill_page_cache_func
> > > > kernel:     pending: dbs_work_handler, free_work, kfree_rcu_monitor
> > > > 
> > > > Originaly, we thought that several retries with direct reclaim being
> > > > stuck is the underlying reason but we couldn't have confirmed that and
> > > > have seen a similar lockups detected even without any heavy memory
> > > > pressure so there is likely something else/more going on. On the other
> > > > hand failing the allocation shouldn't have a big impact and from the
> > > > code it is not really obvious why retrying is desirable so back off
> > > > after the allocation failure.
> > > > 
> > > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > ---
> > > > 
> > > > Hi,
> > > > I am sending this as an RFC because I couldn't prove that the WQ
> > > > concurency issue as a result from the allocation retry is really a
> > > > problem. On the other hand I couldn't see a good reason to retry after a
> > > > previous failure. While the kswapd running in the background could have
> > > > released some memory this is a not really guaranteed and mostly a
> > > > wishful thinking.
> > > > 
> > > > I do not understand the code well enough so I could be easily missing
> > > > something. If the patch is a wrong thing to do then it would be really
> > > > nice to add a comment why the retry is desirable and a good thing to do.
> > > > 
> > > > The retry loop should be bound to rcu_min_cached_objs which is quite
> > > > small but configurable so this can get large in some setups.
> > > > 
> > > > Thanks
> > > > 
> > > >  kernel/rcu/tree.c | 17 +++++++++--------
> > > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index c25ba442044a..54a3a19c4c0b 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3508,15 +3508,16 @@ static void fill_page_cache_func(struct work_struct *work)
> > > >  		bnode = (struct kvfree_rcu_bulk_data *)
> > > >  			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> > > >  
> > > > -		if (bnode) {
> > > > -			raw_spin_lock_irqsave(&krcp->lock, flags);
> > > > -			pushed = put_cached_bnode(krcp, bnode);
> > > > -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > > +		if (!bnode)
> > > > +			break;
> > > >  
> > > > -			if (!pushed) {
> > > > -				free_page((unsigned long) bnode);
> > > > -				break;
> > > > -			}
> > > > +		raw_spin_lock_irqsave(&krcp->lock, flags);
> > > > +		pushed = put_cached_bnode(krcp, bnode);
> > > > +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > > +
> > > > +		if (!pushed) {
> > > > +			free_page((unsigned long) bnode);
> > > > +			break;
> > > >  		}
> > > >  	}
> > > >  
> > > > -- 
> > > > 2.30.2
> > > >
> > > OK. You would like to break the loop once an allocation does not succeed.
> > > To me it also makes sense, i mean there is no reason to repeat it several
> > > times that can lead to worqueue hogging.
> > > 
> > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Thanks for the review!
> 
> > Queued for testing and further review, thank you both!
> > 
> > My normal process would send this not into the upcoming merge window
> > (v5.20?) but instead into the next one (v6.0?).  Please let me know if
> > this is more urgent then that, and I will see what I can do.
> 
> No, it is not really urgent. As I've said, it turned out that there are
> other contributors to the WQ stalls so this is mostly a cosmetic change.

The merge window after this coming one, then!

Ah, and I forgot to send the wordsmithed patch, please see below.  Just
in case I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 29dc4a37468641e2a9fca7f8c41c4d30f3c659a9
Author: Michal Hocko <mhocko@suse.com>
Date:   Wed Jun 22 13:47:11 2022 +0200

    rcu: Back off upon fill_page_cache_func() allocation failure
    
    The fill_page_cache_func() function allocates couple of pages to store
    kvfree_rcu_bulk_data structures. This is a lightweight (GFP_NORETRY)
    allocation which can fail under memory pressure. The function will,
    however keep retrying even when the previous attempt has failed.
    
    This retrying is in theory correct, but in practice the allocation is
    invoked from workqueue context, which means that if the memory reclaim
    gets stuck, these retries can hog the worker for quite some time.
    Although the workqueues subsystem automatically adjusts concurrency, such
    adjustment is not guaranteed to happen until the worker context sleeps.
    And the fill_page_cache_func() function's retry loop is not guaranteed
    to sleep (see the should_reclaim_retry() function).
    
    And we have seen this function cause workqueue lockups:
    
    kernel: BUG: workqueue lockup - pool cpus=93 node=1 flags=0x1 nice=0 stuck for 32s!
    [...]
    kernel: pool 74: cpus=37 node=0 flags=0x1 nice=0 hung=32s workers=2 manager: 2146
    kernel:   pwq 498: cpus=249 node=1 flags=0x1 nice=0 active=4/256 refcnt=5
    kernel:     in-flight: 1917:fill_page_cache_func
    kernel:     pending: dbs_work_handler, free_work, kfree_rcu_monitor
    
    Originally, we thought that the root cause of this lockup was several
    retries with direct reclaim, but this is not yet confirmed.  Furthermore,
    we have seen similar lockups without any heavy memory pressure.  This
    suggests that there are other factors contributing to these lockups.
    However, it is not really clear that endless retries are desireable.
    
    So let's make the fill_page_cache_func() function back off after
    allocation failure.
    
    Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Cc: "Paul E. McKenney" <paulmck@kernel.org>
    Cc: Frederic Weisbecker <frederic@kernel.org>
    Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
    Cc: Josh Triplett <josh@joshtriplett.org>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Lai Jiangshan <jiangshanlai@gmail.com>
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Signed-off-by: Michal Hocko <mhocko@suse.com>
    Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8240c4d631eef..89cb173a1a952 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3183,15 +3183,16 @@ static void fill_page_cache_func(struct work_struct *work)
 		bnode = (struct kvfree_rcu_bulk_data *)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
-		if (bnode) {
-			raw_spin_lock_irqsave(&krcp->lock, flags);
-			pushed = put_cached_bnode(krcp, bnode);
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		if (!bnode)
+			break;
 
-			if (!pushed) {
-				free_page((unsigned long) bnode);
-				break;
-			}
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		pushed = put_cached_bnode(krcp, bnode);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+		if (!pushed) {
+			free_page((unsigned long) bnode);
+			break;
 		}
 	}
 
