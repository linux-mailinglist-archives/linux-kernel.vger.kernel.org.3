Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC43F54BB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353022AbiFNUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359112AbiFNUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:15:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7564E20BC7;
        Tue, 14 Jun 2022 13:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38836B81B3D;
        Tue, 14 Jun 2022 20:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0BDC3411B;
        Tue, 14 Jun 2022 20:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655237516;
        bh=eqag6uuSHc8NZizUmIJ0eO9wLfheHHjsA7++w7jzMgQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SY4qRctUBfITLHd4kc65jOj2XIujNztHSm3L9C547knPmAH9acA0zHM0AxWR7gd7O
         Ml49R/brz3iSMYvksxsjBOqCWPnyaIRpgwTIx+EKLIh47bhh8O1gYbOMzDfBysX69H
         V/cS4mdk4taOCPcgbPfX3KUNjwHe8ypTC+vJBgcRw+4flgDB0xWBUrkYaWzd27xTjx
         z6AsHKzcdhMyEwTbTevRPM/gE5SWTB+AJRAiU8D/yGAT0jj3/XCckXUeCO42JtNq/e
         jdd6u0IxNIS8Nbg7wUB+9EnxRUQlFWXLJnDUaq0qkgz2KJbygVletMd5BC4WVwm9CS
         BfOK8FOHHd7PA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5A9B55C0BCC; Tue, 14 Jun 2022 13:11:56 -0700 (PDT)
Date:   Tue, 14 Jun 2022 13:11:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Message-ID: <20220614201156.GX1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220611110044.2999157-1-qiang1.zhang@intel.com>
 <20220614114219.GB1892551@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614114219.GB1892551@lothringen>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 01:42:19PM +0200, Frederic Weisbecker wrote:
> On Sat, Jun 11, 2022 at 07:00:44PM +0800, Zqiang wrote:
> > Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog kthreads
> > enter polling mode. however, due to only insert CPU's rdp which belong to
> > rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp served by rcuog
> > kthread have been de-offloaded, these cause the 'nocb_head_rdp' list
> > served by rcuog kthread is empty, when the 'nocb_head_rdp' is empty,
> > the rcuog kthread in polling mode not actually do anything. fix it by
> > exiting polling mode when the 'nocb_head_rdp'list is empty, otherwise
> > entering polling mode.
> > 
> > Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Thanks!
> 
> (might be worth testing with TREE01 and --bootargs "rcu_gp_poll" )

A short run passes, so I am queuing this for further review and
testing, thank you both!

With the usual wordsmithing, so please check.

							Thanx, Paul

------------------------------------------------------------------------

commit 5d3a7cbf3bc24dd5540ecf5be7a3e0e94b9a15d8
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Sat Jun 11 19:00:44 2022 +0800

    rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list is empty
    
    Currently, If the 'rcu_nocb_poll' kernel boot parameter is enabled, all
    rcuog kthreads enter polling mode.  However, if all of a given group
    of rcuo kthreads correspond to CPUs that have been de-offloaded, the
    corresponding rcuog kthread will nonetheless still wake up periodically,
    unnecessarily consuming power and perturbing workloads.  Fortunately,
    this situation is easily detected by the fact that the rcuog kthread's
    CPU's rcu_data structure's ->nocb_head_rdp list is empty.
    
    This commit saves power and avoids unnecessarily perturbing workloads
    by putting an rcuog kthread to sleep during any time period when all of
    its rcuo kthreads' CPUs are de-offloaded.
    
    Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c0..a8f574d8850d2 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -584,6 +584,14 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
 	return ret;
 }
 
+static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
+{
+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
+	swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
+					!READ_ONCE(my_rdp->nocb_gp_sleep));
+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
+}
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
@@ -701,13 +709,19 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
 			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
-		schedule_timeout_idle(1);
+		if (list_empty(&my_rdp->nocb_head_rdp)) {
+			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+			if (!my_rdp->nocb_toggling_rdp)
+				WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
+			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
+			/* Wait for any offloading rdp */
+			nocb_gp_sleep(my_rdp, cpu);
+		} else {
+			schedule_timeout_idle(1);
+		}
 	} else if (!needwait_gp) {
 		/* Wait for callbacks to appear. */
-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
-		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
-				!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
+		nocb_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
