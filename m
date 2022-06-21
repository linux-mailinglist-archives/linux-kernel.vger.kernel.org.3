Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A62553E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiFUWTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiFUWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22923134B;
        Tue, 21 Jun 2022 15:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E4AF61720;
        Tue, 21 Jun 2022 22:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87E5C3411C;
        Tue, 21 Jun 2022 22:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655849965;
        bh=6Cm/7JRGe200BYXUXwRpZmG6i8afEFGvPBoIJ4styLk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q/xsmXUdpBq57JgmPgQxW8yTXBQR78qcwuAsQ3c0eOyyqmYv6iI9xI8Lva360to9+
         P4C0tW9LS1m1vrp/LozlieZ2F+X/hue3IRRZ1n1j5OkTyjTexn+p6QvuTWrhBx2f4G
         Klg9Lm+lp8RTjlx8SyBcnEoPTinKDCTmevyfQR1zj/nj7zwhilPRYGjsPw1Kct3UB5
         D1Qmej/HJ4trSO2vHpH8nydCp89MQABcVj6/6QsWzUMaC902hCaFSJ8PKq+RmkH/NN
         d8/rHzQdIB8USJMz4NAtIu0J5q4fz/eaZyQmCmdo1WssB/xf174VNLCU2kGg6jgvPK
         AXb8uP4vMZw/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8A1E35C0AE0; Tue, 21 Jun 2022 15:19:25 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:19:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 01/12] rcu: Decrease FQS scan wait time in case of
 callback overloading
Message-ID: <20220621221925.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-1-paulmck@kernel.org>
 <87c17e9a-565a-d717-3534-83a4c506b984@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c17e9a-565a-d717-3534-83a4c506b984@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:59:58AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> > The force-quiesce-state loop function rcu_gp_fqs_loop() checks for
> > callback overloading and does an immediate initial scan for idle CPUs
> > if so.  However, subsequent rescans will be carried out at as leisurely a
> > rate as they always are, as specified by the rcutree.jiffies_till_next_fqs
> > module parameter.  It might be tempting to just continue immediately
> > rescanning, but this turns the RCU grace-period kthread into a CPU hog.
> > It might also be tempting to reduce the time between rescans to a single
> > jiffy, but this can be problematic on larger systems.
> > 
> > This commit therefore divides the normal time between rescans by three,
> > rounding up.  Thus a small system running at HZ=1000 that is suffering
> > from callback overload will wait only one jiffy instead of the normal
> > three between rescans.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >   kernel/rcu/tree.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c25ba442044a6..c19d5926886fb 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1993,6 +1993,11 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
> >   			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
> >   				   jiffies + (j ? 3 * j : 2));
> >   		}
> > +		if (rcu_state.cbovld) {
> > +			j = (j + 2) / 3;
> > +			if (j <= 0)
> > +				j = 1;
> > +		}
> 
> We update 'j' here, after setting rcu_state.jiffies_force_qs
> 
>     WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j)
> 
> So, we return from swait_event_idle_timeout_exclusive after 1/3 time
> duration.
> 
>     swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
> 				 rcu_gp_fqs_check_wake(&gf), j);
> 
> This can result in !timer_after check to return false and we will
> enter the 'else' (stray signal block) code?
> 
> This might not matter for first 2 fqs loop iterations, where
> RCU_GP_FLAG_OVLD is set in 'gf', but subsequent iterations won't benefit
> from this patch?
> 
> 
> if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> 	(gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
> 			...
> } else {
> 	/* Deal with stray signal. */
> }
> 
> 
> So, do we need to move this calculation above the 'if' block which sets
> rcu_state.jiffies_force_qs?
> 		if (!ret) {
> 
> 			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies +
> 						j);...
> 		}

Good catch, thank you!  How about the updated patch shown below?

							Thanx, Paul

------------------------------------------------------------------------

commit 77de092c78f549b5c28075bfee9998a525d21f84
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Apr 12 15:08:14 2022 -0700

    rcu: Decrease FQS scan wait time in case of callback overloading
    
    The force-quiesce-state loop function rcu_gp_fqs_loop() checks for
    callback overloading and does an immediate initial scan for idle CPUs
    if so.  However, subsequent rescans will be carried out at as leisurely a
    rate as they always are, as specified by the rcutree.jiffies_till_next_fqs
    module parameter.  It might be tempting to just continue immediately
    rescanning, but this turns the RCU grace-period kthread into a CPU hog.
    It might also be tempting to reduce the time between rescans to a single
    jiffy, but this can be problematic on larger systems.
    
    This commit therefore divides the normal time between rescans by three,
    rounding up.  Thus a small system running at HZ=1000 that is suffering
    from callback overload will wait only one jiffy instead of the normal
    three between rescans.
    
    [ paulmck: Apply Neeraj Upadhyay feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c25ba442044a6..52094e72866e5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1983,7 +1983,12 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 		gf = RCU_GP_FLAG_OVLD;
 	ret = 0;
 	for (;;) {
-		if (!ret) {
+		if (rcu_state.cbovld) {
+			j = (j + 2) / 3;
+			if (j <= 0)
+				j = 1;
+		}
+		if (!ret || time_before(jiffies + j, rcu_state.jiffies_force_qs)) {
 			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j);
 			/*
 			 * jiffies_force_qs before RCU_GP_WAIT_FQS state
