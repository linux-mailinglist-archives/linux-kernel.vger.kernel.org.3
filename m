Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C2657A98A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiGSV5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGSV5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:57:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B152656A;
        Tue, 19 Jul 2022 14:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3B86B81D5C;
        Tue, 19 Jul 2022 21:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E804C341C6;
        Tue, 19 Jul 2022 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658267847;
        bh=wc23qX/JXD3Tc+arLspoae5QHhkRyoi9mBGVrUQeleQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nzLHW0dWwLZY/3G+l7JAxKAjnH9af+j9ZCSp7iHKWIaCNhrqKjqpTzNz8u0mfjBpj
         5X7aMY4hID/T9Uz7xxnHMzSpCtPqXfTYWclzv2kclWZugffrub5ON1riSDLzsnUI0d
         MkHvy4PALnMNzhIg29C3eTHj0aYHSwT2zEemb4NFUEXKqKGMl+goCXMf6qwz0X/nqz
         Vw5OYP6F1IJ39JOHtDmP5AH1oVrR9m6+DN4+wZ5j1HiTkA8VX/ZZrmW+NhBurFL1LT
         /RM22L1qrfhvy5+ahur2rN1Mjr9Dp9LdYoLyl3sEsOqMhQC66FsxcZbEStNVG+/kEN
         6Zp2O8B1NolRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 118825C038F; Tue, 19 Jul 2022 14:57:27 -0700 (PDT)
Date:   Tue, 19 Jul 2022 14:57:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu-tasks: Make RCU Tasks Trace checking for
 userspace execution
Message-ID: <20220719215727.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220719043900.437443-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719043900.437443-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:39:00PM +0800, Zqiang wrote:
> For RCU tasks trace, the userspace execution is also a valid quiescent.
> when the scheduling clock interrupt handler interrupts current task and
> check current tasks running in userspace, then invoke rcu_tasks_trace_qs()
> to check quiescent state, usually, the current tasks ->trc_reader_nesting
> should be zero, if the current tasks ->trc_reader_special.b.need_qs is not
> set, set TRC_NEED_QS_CHECKED to ->trc_reader_special.b.need_qs. this cause
> grace period kthread remove task from holdout list if current tasks is in
> holdout list.
> 
> But sometimes, although the scheduling clock interrupt handler check
> current tasks running in userspace, but the current tasks
> ->trc_reader_nesting maybe not zero (if one of the functions in the
> scheduling-clock interrupt handler were traced/instrumented), and then
> invoke rcu_tasks_trace_qs(), if the current tasks ->trc_reader_nesting
> is still not zero, the current tasks will be insert local CPU blocked list.
> if starts a new RCU tasks trace grace period and the grace period kthread
> scan running tasks on each CPU, find that current tasks is running, will
> also insert it to hold out list.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Thank you!  I queued this with wordsmithing and also with a bit of code
consolidation.  With this consolidation, instead of adding a line of code,
we are removing three of them.

But please check to see whether I messed anything up along the way.

							Thanx, Paul

------------------------------------------------------------------------

commit c3e7fd0449642df8c427b442751fbe593e4673df
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Jul 19 12:39:00 2022 +0800

    rcu-tasks: Make RCU Tasks Trace check for userspace execution
    
    Userspace execution is a valid quiescent state for RCU Tasks Trace,
    but the scheduling-clock interrupt does not currently report such
    quiescent states.
    
    Of course, the scheduling-clock interrupt is not strictly speaking
    userspace execution.  However, the only way that this code is not
    in a quiescent state is if something invoked rcu_read_lock_trace(),
    and that would be reflected in the ->trc_reader_nesting field in
    the task_struct structure.  Furthermore, this field is checked by
    rcu_tasks_trace_qs(), which is invoked by rcu_tasks_qs() which is in
    turn invoked by rcu_note_voluntary_context_switch() in kernels building
    at least one of the RCU Tasks flavors.  It is therefore safe to invoke
    rcu_tasks_trace_qs() from the rcu_sched_clock_irq().
    
    But rcu_tasks_qs() also invokes rcu_tasks_classic_qs() for RCU
    Tasks, which lacks the read-side markers provided by RCU Tasks Trace.
    This raises the possibility that an RCU Tasks grace period could start
    after the interrupt from userspace execution, but before the call to
    rcu_sched_clock_irq().  However, it turns out that this is safe because
    the RCU Tasks grace period waits for an RCU grace period, which will
    wait for the entire scheduling-clock interrupt handler, including any
    RCU Tasks read-side critical section that this handler might contain.
    
    This commit therefore updates the rcu_sched_clock_irq() function's
    check for usermode execution and its call to rcu_tasks_classic_qs()
    to instead check for both usermode execution and interrupt from idle,
    and to instead call rcu_note_voluntary_context_switch().  This
    consolidates code and provides more faster RCU Tasks Trace
    reporting of quiescent states in kernels that do scheduling-clock
    interrupts for userspace execution.
    
    [ paulmck: Consolidate checks into rcu_sched_clock_irq(). ]
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 84d2817766888..2122359f0c862 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2341,8 +2341,8 @@ void rcu_sched_clock_irq(int user)
 	rcu_flavor_sched_clock_irq(user);
 	if (rcu_pending(user))
 		invoke_rcu_core();
-	if (user)
-		rcu_tasks_classic_qs(current, false);
+	if (user || rcu_is_cpu_rrupt_from_idle())
+		rcu_note_voluntary_context_switch(current);
 	lockdep_assert_irqs_disabled();
 
 	trace_rcu_utilization(TPS("End scheduler-tick"));
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4152816dd29f6..b2219577fbe2d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -718,9 +718,6 @@ static void rcu_flavor_sched_clock_irq(int user)
 	struct task_struct *t = current;
 
 	lockdep_assert_irqs_disabled();
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
-		rcu_note_voluntary_context_switch(current);
-	}
 	if (rcu_preempt_depth() > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
@@ -976,7 +973,6 @@ static void rcu_flavor_sched_clock_irq(int user)
 		 * neither access nor modify, at least not while the
 		 * corresponding CPU is online.
 		 */
-
 		rcu_qs();
 	}
 }
