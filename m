Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80F545AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbiFJDlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346186AbiFJDlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:41:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082C22CBFF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 20:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C74D61D0F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7440C3411B;
        Fri, 10 Jun 2022 03:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654832495;
        bh=FOBgQxnOIG6Vjg4rMqHVi9/WCZ3QzT7QfFx2JmFock4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ffMcbXXfGBlVTAGcATiVCNOWXJbmiPXjoa6wQtIWoAbVI8Mi2ksQSxlaEEBMfDL+9
         sZxE3gp2RQOegMk8SC3Cgj6Rd5i2MYADu/jmTcj9osq/fLKnNVaSTlPVV7Qz71sAwV
         YCTMdoqaUiSLO9gqhWErSdH8yL8vsHXrf4+0m9dj8Pp+IPyerq/NkVhZShKEox4rXt
         zuN1L/ux0nc5olNBUekj/JHIYgbkt7wDKOWTZpeiZ7WktCLXpiWqWeKKfwc3pP/Ey+
         l+vuhaVBG0WFwtQz4Ew1Bs1+oBIqT49n4QReYezGDDK1a4IuGO/RTvM8fizRNoWoOi
         EnNXwOwv6gOOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 50B815C05E4; Thu,  9 Jun 2022 20:41:35 -0700 (PDT)
Date:   Thu, 9 Jun 2022 20:41:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     frederic@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, urezki@gmail.com
Subject: Re: [PATCH] rcu/tree: Add comment to describe GP done condition in
 fqs loop
Message-ID: <20220610034135.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220609071340.30375-1-quic_neeraju@quicinc.com>
 <20220609202312.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <2768ac0a-6f39-e6ba-cb57-33cb3b39de2a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2768ac0a-6f39-e6ba-cb57-33cb3b39de2a@quicinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 08:45:42AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/10/2022 1:53 AM, Paul E. McKenney wrote:
> > On Thu, Jun 09, 2022 at 12:43:40PM +0530, Neeraj Upadhyay wrote:
> > > Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
> > > is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().
> > > 
> > > Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > 
> > Thank you, Neeraj!  As usual, I could not resist the urge to wordsmith
> > as shown below.  Could you please check to see if I messed something up?
> 
> Thanks!
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit bdf3a744d3ad21336a390bfcc2e41de63f193eaf
> > Author: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Date:   Thu Jun 9 12:43:40 2022 +0530
> > 
> >      rcu/tree: Add comment to describe GP-done condition in fqs loop
> >      Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
> >      is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().
> >      Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a93c5f4d7e092..9a941e7ee6109 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2083,7 +2083,15 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
> >   		rcu_gp_torture_wait();
> >   		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
> >   		/* Locking provides needed memory barriers. */
> > -		/* If grace period done, leave loop. */
> > +		/*
> > +		 * Exit the loop if the root rcu_node structure indicates that the grace period
> > +		 * has ended, leave the loop.  The rcu_preempt_blocked_readers_cgp(rnp) check
> 
> We can remove ", leave the loop" ?
> 
> > +		 * is required only for single-node rcu_node trees because readers blocking
> > +		 * the current grace period are queued only on leaf rcu_node structures.
> > +		 * For multi-node trees, checking the root node's ->qsmask suffices, because a
> > +		 * given root node's ->qsmask bit is cleared only when all CPUs and tasks from
> 
> Do we need to say "a given root node's" , we have only single RCU node in
> the system, so we can just say, "because root node's ->qsmask bit is
> cleared..." ?
> 
> > +		 * the corresponding leaf node have passed through their quiescent state.
> 
> Change "the corresponding leaf node" to "their corresponding leaf nodes" or
> "the corresponding leaf nodes"?

And the winner is "the corresponding leaf nodes"!  Good catch, and
thank you!

							Thanx, Paul

> Thanks
> Neeraj
> 
> > +		 */
> >   		if (!READ_ONCE(rnp->qsmask) &&
> >   		    !rcu_preempt_blocked_readers_cgp(rnp))
> >   			break;
