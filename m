Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329584E5C93
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347049AbiCXBFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiCXBFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2133894
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE3B61922
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AABC340E8;
        Thu, 24 Mar 2022 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648083844;
        bh=rHv7NJgpa63bJ+0QQF4yG6Kjje+PVdEiSiSy51DiNuY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fzGs3EbME7AKoL2gxxtUuBE9AamNUdryf5bW/lJ2MmO78Nx2bPLcbF1bnYlbuOcYN
         rYHpVIiaX2ZSaaVXiEW0CAvxfmGQMcWPXRC8Cwr5TRvff8iIBy5IlftwBxc0J2Vi75
         8yxOfPLbQOWLMuCcx2m3EO0/PIdD4B9yHJOUcHBxYRoDq80TASqWiBo59csUjNiWE1
         uwf5M86rn9Nae2VYG4AdZwv2SWpMe/UR+hTu3QMtwVYHR/vq9+mG1wEM0wWeU0m5j0
         h7yPL40w2gmuv2DVfbi2Mngl33QZqsEUmxSJHfJtpSJUWbwQzn7tpyzE+sByNSfQ9S
         jdIEwnSd4dw4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BCAB65C0192; Wed, 23 Mar 2022 18:04:02 -0700 (PDT)
Date:   Wed, 23 Mar 2022 18:04:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 4/4] rcu: Name internal polling flag
Message-ID: <20220324010402.GU4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220316144255.336021-1-frederic@kernel.org>
 <20220316144255.336021-5-frederic@kernel.org>
 <20220322021107.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <20220322103224.GA701946@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322103224.GA701946@lothringen>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:32:24AM +0100, Frederic Weisbecker wrote:
> On Mon, Mar 21, 2022 at 07:11:07PM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 16, 2022 at 03:42:55PM +0100, Frederic Weisbecker wrote:
> > > Give a proper self-explanatory name to the expedited grace period
> > > internal polling flag.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/rcu.h      | 5 +++++
> > >  kernel/rcu/tree.c     | 2 +-
> > >  kernel/rcu/tree_exp.h | 9 +++++----
> > >  3 files changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index eccbdbdaa02e..8a62bb416ba4 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -30,6 +30,11 @@
> > >  #define RCU_GET_STATE_USE_NORMAL	0x2
> > >  #define RCU_GET_STATE_BAD_FOR_NORMAL	(RCU_GET_STATE_FROM_EXPEDITED | RCU_GET_STATE_USE_NORMAL)
> > >  
> > > +/*
> > > + * Low-order bit definitions for polled grace-period internals.
> > > + */
> > > +#define RCU_EXP_SEQ_POLL_DONE 0x1
> > > +
> > >  /*
> > >   * Return the counter portion of a sequence number previously returned
> > >   * by rcu_seq_snap() or rcu_seq_current().
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 5da381a3cbe5..b3223b365f9f 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -4679,7 +4679,7 @@ static void __init rcu_init_one(void)
> > >  			spin_lock_init(&rnp->exp_lock);
> > >  			mutex_init(&rnp->boost_kthread_mutex);
> > >  			raw_spin_lock_init(&rnp->exp_poll_lock);
> > > -			rnp->exp_seq_poll_rq = 0x1;
> > > +			rnp->exp_seq_poll_rq = RCU_EXP_SEQ_POLL_DONE;
> > >  			INIT_WORK(&rnp->exp_poll_wq, sync_rcu_do_polled_gp);
> > >  		}
> > >  	}
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index c4a19c6a83cf..7ccb909d6355 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -910,14 +910,14 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
> > >  	unsigned long s;
> > >  
> > >  	s = READ_ONCE(rnp->exp_seq_poll_rq);
> > > -	if (s & 0x1)
> > > +	if (s & RCU_EXP_SEQ_POLL_DONE)
> > >  		return;
> > >  	while (!sync_exp_work_done(s))
> > >  		__synchronize_rcu_expedited(true);
> > 
> > One additional question.  If we re-read rnp->exp_seq_poll_rq on each pass
> > through the loop, wouldn't we have less trouble with counter wrap?
> 
> We can indeed do that, though it won't eliminate the possibility of wrapping.

True.  But in conjunction with an exact check for expired grace-period
sequence number, it reduces the maximum addtional penalty for wrapping
to two grace periods.

							Thanx, Paul

> > >  	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
> > >  	s = rnp->exp_seq_poll_rq;
> > > -	if (!(s & 0x1) && sync_exp_work_done(s))
> > > -		WRITE_ONCE(rnp->exp_seq_poll_rq, s | 0x1);
> > > +	if (!(s & RCU_EXP_SEQ_POLL_DONE) && sync_exp_work_done(s))
> > > +		WRITE_ONCE(rnp->exp_seq_poll_rq, s | RCU_EXP_SEQ_POLL_DONE);
> > >  	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
> > >  }
> > >  
> > > @@ -946,7 +946,8 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
> > >  	rnp = rdp->mynode;
> > >  	if (rcu_init_invoked())
> > >  		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
> > > -	if ((rnp->exp_seq_poll_rq & 0x1) || ULONG_CMP_LT(rnp->exp_seq_poll_rq, s)) {
> > > +	if ((rnp->exp_seq_poll_rq & RCU_EXP_SEQ_POLL_DONE) ||
> > > +	    ULONG_CMP_LT(rnp->exp_seq_poll_rq, s)) {
> > >  		WRITE_ONCE(rnp->exp_seq_poll_rq, s);
> > >  		if (rcu_init_invoked())
> > >  			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
> > > -- 
> > > 2.25.1
> > > 
