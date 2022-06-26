Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828BE55AE94
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiFZEA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiFZEA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4291183B;
        Sat, 25 Jun 2022 21:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 960DD6103B;
        Sun, 26 Jun 2022 04:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024F2C3411D;
        Sun, 26 Jun 2022 04:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656216055;
        bh=O4t1/B727qQst0OKzSOCPBDoZYNLnSq8J0clOIPvxkU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I/YqsozQdwNCQrB4fkW8TsoWewmGIBeogJVkKq8cCZrBaZkAAfq40LZuy0zE8AMNW
         NFFapkGVwPQ07Jh/OJWJmO7Mc4UC6IRClSDAKVBnODIRHsbtykubx2mo1Ngl6kjTp4
         Q+yW0T5ik1oIvPi5Bb+MbP+qJc24jW7U0cUX2NPCbx0KwwnP5flbkzBo+bbCftw10D
         5fU+lEoQIcn2T5yRfdYVI7/bG6FqHOTGPz8UDn1zYUXQ6ABBBoSbTzJejeYyRcXOgJ
         KxFh79O2pQlxi7HuWXXJIFXBSJqj5/vQdDeBnYd69DuNfCSCuiJlGxAY6kZjamy6ej
         OQFGPjPOFDUnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9DCFC5C0260; Sat, 25 Jun 2022 21:00:54 -0700 (PDT)
Date:   Sat, 25 Jun 2022 21:00:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <20220626040054.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <YrOjKnMHo4/NNDwy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrOjKnMHo4/NNDwy@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:18:02PM +0000, Joel Fernandes wrote:
> On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> [..]
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
> >  
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
> > +		mod_timer(&rdp_gp->nocb_timer, jiffies + LAZY_FLUSH_JIFFIES);
> > +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > +	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
> >  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
> >  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> >  	} else {
> > @@ -296,7 +301,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >   * Note that this function always returns true if rhp is NULL.
> >   */
> >  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -				     unsigned long j)
> > +				     unsigned long j, bool lazy)
> >  {
> >  	struct rcu_cblist rcl;
> >  
> > @@ -310,7 +315,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
> >  	if (rhp)
> >  		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
> > -	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > +
> > +	trace_printk("call_rcu_lazy callbacks = %ld\n", READ_ONCE(rdp->nocb_bypass.lazy_len));
> 
> Before anyone yells at me, that trace_printk() has been politely asked to take
> a walk :-). It got mad at me, but on the next iteration, it wont be there.

;-) ;-) ;-)

							Thanx, Paul
