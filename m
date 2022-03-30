Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7204ECB27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbiC3R7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349650AbiC3R7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC5E11DD01
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 566F460A53
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FDEC340EC;
        Wed, 30 Mar 2022 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648663039;
        bh=gPR2JaMS3QMXFWDQQ4k8RKlJdE/tdHBh8RH4ESl7Qj4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=suiQkN2Cgjc968BO1mpWjFF17ln4m1zt7UAO7hNFUMcd4pOzO6o5nFWlrH45CHuNq
         8aX1l0cFQCJ/l8IaJsWvC8AbuTtOQ8M5bEQdlKbdXGdJ5V2R8mKXSGGDUg04Ud5QiW
         3o+SgT3yoMavtnZV2sX8HH8pNqjrFbtWcDYiT1YXGb3E2IdYbQY9dvEVAuBel3EwGY
         HAuiJ/NrZpbJ0kVKifixQQe164heGDty5i8EMpYabbR4aw+s31bjYJ0hXaJe6NN5bB
         TvM3/lJN7Rmqwe6BmLBEG8v2nzPu1CnkZ2Bmmg2y0MGzJfoWjeCy7LwRaCoo6SczWQ
         YPuSacrB54Wjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D16C5C1289; Wed, 30 Mar 2022 10:57:19 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:57:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] rcu: No need to reset the poll request flag before
 completion
Message-ID: <20220330175719.GH4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220316144255.336021-1-frederic@kernel.org>
 <20220316144255.336021-3-frederic@kernel.org>
 <20220330112752.GA1245830@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330112752.GA1245830@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 01:27:52PM +0200, Frederic Weisbecker wrote:
> On Wed, Mar 16, 2022 at 03:42:53PM +0100, Frederic Weisbecker wrote:
> > The flag allowing to requeue the polling work is reset before the
> > polling even starts. However there is no point in having two competing
> > polling on the same grace period. Just reset the flag once we have
> > completed the grace period only.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree_exp.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index b6fd857f34ba..763ec35546ed 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -911,7 +911,6 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
> >  
> >  	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
> >  	s = rnp->exp_seq_poll_rq;
> > -	rnp->exp_seq_poll_rq |= 0x1;
> 
> On a second (or actually twentieth) thought, this patch and all those following
> make wrapping issues more likely:
> 
> * Before this patch, wrapping occuring *after* the 0x1 is set on the beginning
>   of the workqueue is fine. The last vulnerable wrapping scenario is when
>   the wrapping happens before we reach the beginning of the workqueue
>   execution that sets the 0x1, so the work may happen not to be queued.
> 
> 
> * After this patch, wrapping occuring *before* the GP completion in the
>   workqueue will be ignored and fail. Still unlikely, but less unlikely than
>   before this patch.
> 
> So please revert this series. Only the first patch "rcu: Remove needless polling
> work requeue for further waiter" still seem to make sense.

I know that twentieth-thought feeling!

I reverted the following commits, and will remove the original and the
reversion of each on my next rebase:

26632dde0c40 ("rcu: No need to reset the poll request flag before completion")
b889e463d447 ("rcu: Perform early sequence fetch for polling locklessly")
11eccc01200f ("rcu: Name internal polling flag")

Would it make sense to apply rcu_seq_done_exact(), perhaps as follows?
Or is there some reason this would cause problems?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index b6fd857f34ba..bd47fce0e08c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -992,7 +992,7 @@ bool poll_state_synchronize_rcu_expedited(unsigned long oldstate)
 	WARN_ON_ONCE(!(oldstate & RCU_GET_STATE_FROM_EXPEDITED));
 	if (oldstate & RCU_GET_STATE_USE_NORMAL)
 		return poll_state_synchronize_rcu(oldstate & ~RCU_GET_STATE_BAD_FOR_NORMAL);
-	if (!rcu_exp_gp_seq_done(oldstate & ~RCU_SEQ_STATE_MASK))
+	if (!rcu_seq_done_exact(&rcu_state.expedited_sequence, oldstate & ~RCU_SEQ_STATE_MASK))
 		return false;
 	smp_mb(); /* Ensure GP ends before subsequent accesses. */
 	return true;
