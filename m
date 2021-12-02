Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66949465B74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354978AbhLBA71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:59:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35524 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344172AbhLBA7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:59:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 64E34CE2102;
        Thu,  2 Dec 2021 00:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B339C00446;
        Thu,  2 Dec 2021 00:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638406556;
        bh=5IKgYnygaasdmaiH6qemymXUNXF2DOAESa/A+qitKNA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nXJALkqOVMY1EIJb/kfHjJ1jn6bTtFr+r+tQo4Ny2wj5J3nus+U5vW4WEnP8mBU3c
         SwhN6rlS9O3bUv+YmXpR5/Xp4JFwV2YajvdJi4kYuk0CmQpHfT34t7M4+vKdSwgGwV
         CSzH/+EBCddsk1q19PQx3JWKrJ8Vbun5cHHpPrNsMjnz9edwR18Xxprq2xgwgHaDnB
         0F28OUELxoSgrFZxrdhgfdEQc8heUyllnZzCzTNqr6RRL0TG7KoZeMYD9Pekr71BRz
         nb0hBA7AG3nv8BRMwJxuKlCBWVHP7Sj0RgjgLXiS9pd3yN+d+p2aRe03Iy6wqlc870
         e36e4huNhIp4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 48C9A5C0FCD; Wed,  1 Dec 2021 16:55:56 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:55:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Guillaume Morin <guillaume@morinfr.org>
Subject: Re: [PATCH rcu 01/18] rcu: Tighten rcu_advance_cbs_nowake() checks
Message-ID: <20211202005556.GM641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
 <20211202002912.3127710-1-paulmck@kernel.org>
 <20211202004142.GA631289@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202004142.GA631289@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 01:41:42AM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 01, 2021 at 04:28:55PM -0800, Paul E. McKenney wrote:
> > Currently, rcu_advance_cbs_nowake() checks that a grace period is in
> > progress, however, that grace period could end just after the check.
> > This commit rechecks that a grace period is still in progress the lock.
> 
> *while holding the node lock.

Good eyes, thank you!  I will fix on next rebase.

							Thanx, Paul

> > The grace period cannot end while the current CPU's rcu_node structure's
> > ->lock is held, thus avoiding false positives from the WARN_ON_ONCE().
> > 
> > As Daniel Vacek noted, it is not necessary for the rcu_node structure
> > to have a CPU that has not yet passed through its quiescent state.
> > 
> > Tested-By: Guillaume Morin <guillaume@morinfr.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks!
> 
> > ---
> >  kernel/rcu/tree.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ef8d36f580fc3..8706b30c2ac88 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1590,10 +1590,11 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
> >  						  struct rcu_data *rdp)
> >  {
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> > -	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
> > -	    !raw_spin_trylock_rcu_node(rnp))
> > +	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) || !raw_spin_trylock_rcu_node(rnp))
> >  		return;
> > -	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
> > +	// The grace period cannot end while we hold the rcu_node lock.
> > +	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
> > +		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
> >  	raw_spin_unlock_rcu_node(rnp);
> >  }
> >  
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
