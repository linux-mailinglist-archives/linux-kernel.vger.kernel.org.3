Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F03546B33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiFJRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350135AbiFJRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D4F3388D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CF67620DE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7110C34114;
        Fri, 10 Jun 2022 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654880418;
        bh=/bqwqul306Sh+KXd9SpkXpy5R2hgRee4nO68Pcl5w4E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f+NOGDbri1QZx8GM3qmxErN5a11wfrMsOppvSDKskGIpwhJzTZrE6vb/aD7kcyhZ9
         MzTGJDF38iMbmTu32fF9VV0Q+sep8jiE+OCrFHgEvFt6dyTVnFchHXyJ/LLHyMGTnx
         6Zl0DdGps7f8X/eKi3pXK7fRZGgINU1cWl9PkGLS4z2acqIyfXwWlzhx4fCJQ/aBBM
         aBrmTwSMPUYvGUxb7pSUvU5At5bysvwgjb04mqA8fLOjwx7RW+j2OceMhtJY3kLptj
         JTaRmsifqm99JJ5jbct1JX5GNiRgCeBx+XGPlVlpiPOngkww8NgSmud4VZAfxxv5Jv
         /IeMWxfQkjC0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4F50F5C05ED; Fri, 10 Jun 2022 10:00:18 -0700 (PDT)
Date:   Fri, 10 Jun 2022 10:00:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, frederic@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        urezki@gmail.com
Subject: Re: [PATCH] rcu/tree: Add comment to describe GP done condition in
 fqs loop
Message-ID: <20220610170018.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220609071340.30375-1-quic_neeraju@quicinc.com>
 <YqNzUwfII/gJoP52@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqNzUwfII/gJoP52@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:37:39PM +0000, Joel Fernandes wrote:
> On Thu, Jun 09, 2022 at 12:43:40PM +0530, Neeraj Upadhyay wrote:
> > Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
> > is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().
> > 
> > Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > ---
> >  kernel/rcu/tree.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a93c5f4d7e09..9cd1ba512fdc 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2083,7 +2083,17 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
> >  		rcu_gp_torture_wait();
> >  		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
> >  		/* Locking provides needed memory barriers. */
> > -		/* If grace period done, leave loop. */
> > +		/*
> > +		 * If grace period done, leave loop. rcu_preempt_blocked_readers_cgp(rnp)
> > +		 * check is required for the case where we only have single node in the
> > +		 * rcu_node tree; so, root rcu node is also the leaf node, where readers
> > +		 * blocking current gp are queued. For multi-node tree, checking ->qsmask
> > +		 * on the root node is sufficient, as root rcu node's ->qsmask is only
> > +		 * cleared, when all leaf rcu nodes have propagated their quiescent
> > +		 * state to their parent node, which happens only after both ->qsmask
> > +		 * and rcu_preempt_blocked_readers_cgp(rnp_leaf) are cleared for those
> > +		 * leaf nodes.
> > +		 */
> >  		if (!READ_ONCE(rnp->qsmask) &&
> >  		    !rcu_preempt_blocked_readers_cgp(rnp))
> >  			break;
> 
> Paul's wording changes are OK with me.
> 
> For the patch:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you!

							Thanx, Paul
