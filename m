Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B056C303
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbiGHXKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiGHXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2D93F33D;
        Fri,  8 Jul 2022 16:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B207B82A18;
        Fri,  8 Jul 2022 23:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF5C341D0;
        Fri,  8 Jul 2022 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657321814;
        bh=djzIzVFpeo7WTuaeZTv/ckums1eZ/Ec9nzlvV4baO6A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OiXQaqF6ZvxXW9bprOSn/sI8RkPPeZN7orfdEkqcY9qo1uuB3EcqdUQLT0IVQDVP+
         SQAeeoEVJBy9LX+nHT65uE+rLY2EVbC69W2KzCPrsmCdAqlGKuhjGr/hRpLviHAIVD
         ZzRfWLowNSjCwi9P2djnYpYLEH5D/vM03sdm2gUZI13SeiDrDa0rw4gaNVKQZteTRw
         g8VczXdw577Jbu/8KU5No7ab/mdozwPKZjZlvbCBr7+4dg+Y+8j6tD3LthuOXrG3Vn
         7MsonCtz8ILLtggr9jvgUsLtCeusKDADjp6R4e/5eMtDYzJQguM4E1qWjBw9o9bxKG
         DXqSyWx3gruxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C8E285C0835; Fri,  8 Jul 2022 16:10:13 -0700 (PDT)
Date:   Fri, 8 Jul 2022 16:10:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <20220708231013.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <Ysh6yWThHu6GAfJM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysh6yWThHu6GAfJM@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 06:43:21PM +0000, Joel Fernandes wrote:
> On Sat, Jun 25, 2022 at 09:00:19PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> > > Implement timer-based RCU lazy callback batching. The batch is flushed
> > > whenever a certain amount of time has passed, or the batch on a
> > > particular CPU grows too big. Also memory pressure will flush it in a
> > > future patch.
> > > 
> > > To handle several corner cases automagically (such as rcu_barrier() and
> > > hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
> > > length has the lazy CB length included in it. A separate lazy CB length
> > > counter is also introduced to keep track of the number of lazy CBs.
> > > 
> > > Suggested-by: Paul McKenney <paulmck@kernel.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Not bad, but some questions and comments below.
> 
> Thanks a lot for these, real helpful and I replied below:
> 
> > > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > > index 659d13a7ddaa..9a992707917b 100644
> > > --- a/include/linux/rcu_segcblist.h
> > > +++ b/include/linux/rcu_segcblist.h
> > > @@ -22,6 +22,7 @@ struct rcu_cblist {
> > >  	struct rcu_head *head;
> > >  	struct rcu_head **tail;
> > >  	long len;
> > > +	long lazy_len;
> > >  };
> > >  
> > >  #define RCU_CBLIST_INITIALIZER(n) { .head = NULL, .tail = &n.head }
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 1a32036c918c..9191a3d88087 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -82,6 +82,12 @@ static inline int rcu_preempt_depth(void)
> > >  
> > >  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > >  
> > > +#ifdef CONFIG_RCU_LAZY
> > > +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
> > > +#else
> > > +#define call_rcu_lazy(head, func) call_rcu(head, func)
> > > +#endif
> > > +
> > >  /* Internal to kernel */
> > >  void rcu_init(void);
> > >  extern int rcu_scheduler_active;
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index 27aab870ae4c..0bffa992fdc4 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -293,4 +293,12 @@ config TASKS_TRACE_RCU_READ_MB
> > >  	  Say N here if you hate read-side memory barriers.
> > >  	  Take the default if you are unsure.
> > >  
> > > +config RCU_LAZY
> > > +	bool "RCU callback lazy invocation functionality"
> > > +	depends on RCU_NOCB_CPU
> > > +	default n
> > > +	help
> > > +	  To save power, batch RCU callbacks and flush after delay, memory
> > > +          pressure or callback list growing too big.
> > 
> > Spaces vs. tabs.
> 
> Fixed, thanks.
> 
> > The checkpatch warning is unhelpful ("please write a help paragraph that
> > fully describes the config symbol")
> 
> Good old checkpatch :D

;-) ;-) ;-)

> > >  endmenu # "RCU Subsystem"
> > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > index c54ea2b6a36b..627a3218a372 100644
> > > --- a/kernel/rcu/rcu_segcblist.c
> > > +++ b/kernel/rcu/rcu_segcblist.c
> > > @@ -20,6 +20,7 @@ void rcu_cblist_init(struct rcu_cblist *rclp)
> > >  	rclp->head = NULL;
> > >  	rclp->tail = &rclp->head;
> > >  	rclp->len = 0;
> > > +	rclp->lazy_len = 0;
> > >  }
> > >  
> > >  /*
> > > @@ -32,6 +33,15 @@ void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
> > >  	WRITE_ONCE(rclp->len, rclp->len + 1);
> > >  }
> > >  
> > > +/*
> > > + * Enqueue an rcu_head structure onto the specified callback list.
> > 
> > Please also note the fact that it is enqueuing lazily.
> 
> Sorry, done.
> 
> > > + */
> > > +void rcu_cblist_enqueue_lazy(struct rcu_cblist *rclp, struct rcu_head *rhp)
> > > +{
> > > +	rcu_cblist_enqueue(rclp, rhp);
> > > +	WRITE_ONCE(rclp->lazy_len, rclp->lazy_len + 1);
> > 
> > Except...  Why not just add a "lazy" parameter to rcu_cblist_enqueue()?
> > IS_ENABLED() can make it fast.
> 
> Yeah good idea, it simplifies the code too. Thank you!
> 
> So you mean I should add in this function so that the branch gets optimized:
> if (lazy && IS_ENABLE(CONFIG_RCU_LAZY)) {
>   ...
> }
> 
> That makes total sense considering the compiler may otherwise not be able to
> optimize the function viewing just the individual translation unit. I fixed
> it.

Or the other way around:

	if (IS_ENABLE(CONFIG_RCU_LAZY) && lazy) {

Just in case the compiler is stumbling over its boolean logic.  Or in
case the human reader is.  ;-)

> The 6 month old baby and wife are calling my attention now. I will continue
> to reply to the other parts of this and other emails this evening and thanks
> for your help!

Ah, for those who believe that SIGCHLD can be ignored in real life!  ;-)

							Thanx, Paul
