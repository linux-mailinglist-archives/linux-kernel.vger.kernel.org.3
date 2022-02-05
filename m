Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01A74AA6BC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 06:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiBEFUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 00:20:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57524 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiBEFUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 00:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AF4A614CD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 05:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB95C340E8;
        Sat,  5 Feb 2022 05:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644038416;
        bh=0n6MmxRu0o64NEv593g5GlZHkKualUn5jwpcRbNHQt4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m7DA5E1HwbJwNCAJnjDjpCPet3GeDg4fBeQ9hDnI1JbHbhYSsbFfybfy/C0deJBen
         6QawIRt7Vy1YiVjrGZaTJUET4kueFYELQ4kNOX3SWny6PJtiqTTIvt6tBI608h/lsG
         4kvanuZsPi9+jnSQFtSGavILAA9nf9nJkUKFBJpa1sJNTEtYYV0XMbk1FvgBWVrE/w
         UJiu+siafgIS1VYtaZADWzMGEVuODHpBkTR1hkL7dzwYarvb0ruEQXX/aAc+DrpdLn
         G/i96UiOcG+ZahpodLTeEvYUmzH3btNA1Zvnc6EGB/xpet4QHBnJ0DU6rU5INDP1Ng
         E62ldvVXP0Vsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 406235C0418; Fri,  4 Feb 2022 21:20:16 -0800 (PST)
Date:   Fri, 4 Feb 2022 21:20:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH rcu 19/19] srcu: Add contention check to call_srcu()
 srcu_data ->lock acquisition
Message-ID: <20220205052016.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
 <20220205030303.2408-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205030303.2408-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 11:03:03AM +0800, Hillf Danton wrote:
> On Fri,  4 Feb 2022 15:39:02 -0800
> > This commit increases the sensitivity of contention detection by adding
> > checks to the acquisition of the srcu_data structure's lock on the
> > call_srcu() code path.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 45 ++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 36 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index c3968e091d019..31a7a9e2445da 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -320,18 +320,13 @@ static void srcu_transition_to_big(struct srcu_struct *ssp)
> >  }
> >  
> >  /*
> > - * Acquire the specified srcu_struct structure's ->lock, but check for
> > - * excessive contention, which results in initiation of a transition
> > - * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
> > - * parameter permits this.
> > + * Check to see if the just-encountered contention event justifies
> > + * a transition to SRCU_SIZE_BIG.
> >   */
> > -static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
> > +static void spin_lock_irqsave_check_contention(struct srcu_struct *ssp)
> >  {
> >  	unsigned long j;
> >  
> > -	if (spin_trylock_irqsave_rcu_node(ssp, *flags))
> > -		return;
> > -	spin_lock_irqsave_rcu_node(ssp, *flags);
> 
> Given neither try/lock nor irqsave any longer, a new function name is
> prefered.

This function contains the contention-checking common code for the
spin_lock_irqsave_ssp_contention() and spin_lock_irqsave_sdp_contention()
functions, so the current name is fine.

							Thanx, Paul

> Hillf
> 
> >  	if (!SRCU_SIZING_IS_CONTEND() || ssp->srcu_size_state)
> >  		return;
> >  	j = jiffies;
> > @@ -344,6 +339,38 @@ static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned l
> >  	__srcu_transition_to_big(ssp);
> >  }
> >  
> > +/*
> > + * Acquire the specified srcu_data structure's ->lock, but check for
> > + * excessive contention, which results in initiation of a transition
> > + * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
> > + * parameter permits this.
> > + */
> > +static void spin_lock_irqsave_sdp_contention(struct srcu_data *sdp, unsigned long *flags)
> > +{
> > +	struct srcu_struct *ssp = sdp->ssp;
> > +
> > +	if (spin_trylock_irqsave_rcu_node(sdp, *flags))
> > +		return;
> > +	spin_lock_irqsave_rcu_node(ssp, *flags);
> > +	spin_lock_irqsave_check_contention(ssp);
> > +	spin_unlock_irqrestore_rcu_node(ssp, *flags);
> > +	spin_lock_irqsave_rcu_node(sdp, *flags);
> > +}
> > +
> > +/*
> > + * Acquire the specified srcu_struct structure's ->lock, but check for
> > + * excessive contention, which results in initiation of a transition
> > + * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
> > + * parameter permits this.
> > + */
> > +static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
> > +{
> > +	if (spin_trylock_irqsave_rcu_node(ssp, *flags))
> > +		return;
> > +	spin_lock_irqsave_rcu_node(ssp, *flags);
> > +	spin_lock_irqsave_check_contention(ssp);
> > +}
> > +
> >  /*
> >   * First-use initialization of statically allocated srcu_struct
> >   * structure.  Wiring up the combining tree is more than can be
> > @@ -989,7 +1016,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >  	} else {
> >  		sdp = raw_cpu_ptr(ssp->sda);
> >  	}
> > -	spin_lock_irqsave_rcu_node(sdp, flags);
> > +	spin_lock_irqsave_sdp_contention(sdp, &flags);
> >  	if (rhp)
> >  		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> >  	rcu_segcblist_advance(&sdp->srcu_cblist,
> > -- 
> > 2.31.1.189.g2e36527f23
