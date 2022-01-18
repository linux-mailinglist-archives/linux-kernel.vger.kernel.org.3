Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF149300E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349491AbiARVl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiARVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:41:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A41C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:41:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA62761323
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 21:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CD1C340E0;
        Tue, 18 Jan 2022 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642542116;
        bh=Ml+PGIWNhq5HL3eojk+t9FpCN00DQiaCiCSGYstlGsk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dhJYqSMTdlSclewDmh3TwAjmdhagO+x/KPnrIbSFSAtoDxO5CEjJBxFciiz34oThv
         CIp5/VdP1POJZok0+hRevx7qkTtqvCGL/IHYSOP6CpUzbbZbsr9okiphcfMs3pksR6
         zKqnWzwNqWSRFi2l6teLf8JqsBwiIXjYJNvbukiaOUxkSAmzY8cgcgKE9VxVa30Ewz
         aaF2nIU/csSkxnQKTpHfR6pYjp8U8heI+DXJz975KNvctzWY6L6DhtKkuFbZSrvKmy
         Y5vE0YL5Ev524BZTwojZUvDF5EcSI5mEpNfoU0y3LUuol7u3UhcWaSkgRVuwBrbz7Y
         /vuYDHvHyJ3IA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DCDF25C0A21; Tue, 18 Jan 2022 13:41:55 -0800 (PST)
Date:   Tue, 18 Jan 2022 13:41:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jiangshanlai@gmail.com
Subject: Re: synchronize_rcu_expedited gets stuck in hotplug path
Message-ID: <20220118214155.GK947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com>
 <20220118200646.GJ947480@paulmck-ThinkPad-P17-Gen-1>
 <Yece9mH3nzwGxar6@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yece9mH3nzwGxar6@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:11:34AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jan 18, 2022 at 12:06:46PM -0800, Paul E. McKenney wrote:
> > Interesting.  Adding Tejun and Lai on CC for their perspective.
> > 
> > As you say, the incoming CPU invoked synchronize_rcu_expedited() which
> > in turn invoked queue_work().  By default, workqueues will of course
> > queue that work on the current CPU.  But in this case, the CPU's bit
> > is not yet set in the cpu_active_mask.  Thus, a workqueue scheduled on
> > the incoming CPU won't be invoked until CPUHP_AP_ACTIVE, which won't
> > be reached until after the grace period ends, which cannot happen until
> > the workqueue handler is invoked.
> > 
> > I could imagine doing something as shown in the (untested) patch below,
> > but first does this help?
> > 
> > If it does help, would this sort of check be appropriate here or
> > should it instead go into workqueues?
> 
> Maybe it can be solved by rearranging the hotplug sequence but it's fragile
> to schedule per-cpu work items from hotplug paths. Maybe the whole issue can
> be side-stepped by making synchronize_rcu_expedited() use unbound workqueue
> instead? Does it require to be per-cpu?

Good point!

And now that you mention it, RCU expedited grace periods already avoid
using workqueues during early boot.  The (again untested) patch below
extends that approach to incoming CPUs.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 60197ea24ceb9..1a45667402260 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -816,7 +816,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
-	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+	bool no_wq;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
 	unsigned long s;
@@ -841,9 +841,15 @@ void synchronize_rcu_expedited(void)
 	if (exp_funnel_lock(s))
 		return;  /* Someone else did our work for us. */
 
+	/* Don't use workqueue during boot or from an incoming CPU. */
+	preempt_disable();
+	no_wq = rcu_scheduler_active == RCU_SCHEDULER_INIT ||
+		!cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
+	preempt_enable();
+
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(boottime)) {
-		/* Direct call during scheduler init and early_initcalls(). */
+	if (unlikely(no_wq)) {
+		/* Direct call for scheduler init, early_initcall()s, and incoming CPUs. */
 		rcu_exp_sel_wait_wake(s);
 	} else {
 		/* Marshall arguments & schedule the expedited grace period. */
@@ -861,7 +867,7 @@ void synchronize_rcu_expedited(void)
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
 
-	if (likely(!boottime))
+	if (likely(!no_wq))
 		destroy_work_on_stack(&rew.rew_work);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
