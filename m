Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEE85A8563
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiHaSVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiHaSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:21:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B39CF14CF;
        Wed, 31 Aug 2022 11:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6CB9B82276;
        Wed, 31 Aug 2022 18:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958C3C433C1;
        Wed, 31 Aug 2022 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969758;
        bh=jfJ9x14tWQcRlkb5NvDRB5EYKyKS/Qe0IP0owvlvDuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArifacRCUr65momtiKcOGwb4uZf/Nq58QgoVNCfDqxoONKqUDJvqZd5sry6HNFVZd
         fFOWLosEX5pSRG+nnjBvghd6bpdcnjSVkVtAAt8MEs8gP+Ze2KuEH5XSpXqOaNH8bi
         HGBrJVg6EilIjDjWk5GSBv1ukjaU8BzvofFk2JrC880SWmbt+vs9Gnej9YI+VEYt71
         kZTRW8j/vxMFepj5rCXjTal/OSLYssB6BDdd6/Sa7QaU29lnidSkGGkd1ZGb0bxAdY
         /BILveF1pUMuRcjMOZtZM6kgGPeTQs/W//ZiZuA4w80+J2ftIUCgz2UkQw0M+bhMMw
         pkTyn/HCQTV5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 557ED5C02A9; Wed, 31 Aug 2022 11:15:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/3] rcu-tasks: Make RCU Tasks Trace check for userspace execution
Date:   Wed, 31 Aug 2022 11:15:56 -0700
Message-Id: <20220831181556.2696404-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181553.GA2696186@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181553.GA2696186@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

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
---
 kernel/rcu/tree.c        | 4 ++--
 kernel/rcu/tree_plugin.h | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345e..11d5aefd16961 100644
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
index 438ecae6bd7e7..aa64b035c24f2 100644
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
@@ -972,7 +969,6 @@ static void rcu_flavor_sched_clock_irq(int user)
 		 * neither access nor modify, at least not while the
 		 * corresponding CPU is online.
 		 */
-
 		rcu_qs();
 	}
 }
-- 
2.31.1.189.g2e36527f23

