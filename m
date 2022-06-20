Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306895526E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbiFTWVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244520AbiFTWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0511B7B6;
        Mon, 20 Jun 2022 15:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 903ACB81648;
        Mon, 20 Jun 2022 22:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DCAC3411C;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=IE9ivt9U+MAy3rcGS7RqeSn8fZ9nZNRTzcq4pLgoURo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNZtaJ+cm+x9uTAURYlLmWtUMNpLi05YFqr1zKb0c36rsUEZgY9b1I5cO0XD3JF3Y
         vxVv4F90l4lds2d2dOZXEps6L/+TIdVDQHwFyFcavGtTDz4qKGqRPuuhksUpR2EH4b
         MrDwVn/r/YvI6ghkZAYsBIbbua6y4dbfpPw47CueV7NibuDQS8/fCitGiDuLwQxp8o
         T5CItYE8FkkD4WB8PDTqUnbaPI5P3IuxhCjk2sRQ2mmsNapUsVP5CPgeVALndbF9zq
         kBjW83g939y8flEsLCkzCbGs9I2I8dlkMOheoXX5zsGnmzozHUMl0uP71NkNK5nNKV
         CjXGHB1n/HyqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F40C45C05C8; Mon, 20 Jun 2022 15:20:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Patrick Wang <patrick.wang.shcn@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/12] rcu: Avoid tracing a few functions executed in stop machine
Date:   Mon, 20 Jun 2022 15:20:22 -0700
Message-Id: <20220620222032.3839547-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Wang <patrick.wang.shcn@gmail.com>

Stop-machine recently started calling additional functions while waiting:

----------------------------------------------------------------
Former stop machine wait loop:
do {
    cpu_relax(); => macro
    ...
} while (curstate != STOPMACHINE_EXIT);
-----------------------------------------------------------------
Current stop machine wait loop:
do {
    stop_machine_yield(cpumask); => function (notraced)
    ...
    touch_nmi_watchdog(); => function (notraced, inside calls also notraced)
    ...
    rcu_momentary_dyntick_idle(); => function (notraced, inside calls traced)
} while (curstate != MULTI_STOP_EXIT);
------------------------------------------------------------------

These functions (and the functions that they call) must be marked
notrace to prevent them from being updated while they are executing.
The consequences of failing to mark these functions can be severe:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu: 	1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
  rcu: 	3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
  	(detected by 0, t=8137 jiffies, g=5889, q=2 ncpus=4)
  Task dump for CPU 1:
  task:migration/1     state:R  running task     stack:    0 pid:   19 ppid:     2 flags:0x00000000
  Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
  Call Trace:
  Task dump for CPU 3:
  task:migration/3     state:R  running task     stack:    0 pid:   29 ppid:     2 flags:0x00000000
  Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
  Call Trace:
  rcu: rcu_preempt kthread timer wakeup didn't happen for 8136 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
  rcu: 	Possible timer handling issue on cpu=2 timer-softirq=594
  rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
  rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
  rcu: RCU grace-period kthread stack dump:
  task:rcu_preempt     state:I stack:    0 pid:   14 ppid:     2 flags:0x00000000
  Call Trace:
    schedule+0x56/0xc2
    schedule_timeout+0x82/0x184
    rcu_gp_fqs_loop+0x19a/0x318
    rcu_gp_kthread+0x11a/0x140
    kthread+0xee/0x118
    ret_from_exception+0x0/0x14
  rcu: Stack dump where RCU GP kthread last ran:
  Task dump for CPU 2:
  task:migration/2     state:R  running task     stack:    0 pid:   24 ppid:     2 flags:0x00000000
  Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
  Call Trace:

This commit therefore marks these functions notrace:
 rcu_preempt_deferred_qs()
 rcu_preempt_need_deferred_qs()
 rcu_preempt_deferred_qs_irqrestore()

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c8ba0fe17267c..440d9e02a26e0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -460,7 +460,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * be quite short, for example, in the case of the call from
  * rcu_read_unlock_special().
  */
-static void
+static notrace void
 rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 {
 	bool empty_exp;
@@ -581,7 +581,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  * is disabled.  This function cannot be expected to understand these
  * nuances, so the caller must handle them.
  */
-static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
@@ -595,7 +595,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
  * evaluate safety in terms of interrupt, softirq, and preemption
  * disabling.
  */
-static void rcu_preempt_deferred_qs(struct task_struct *t)
+static notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
 
-- 
2.31.1.189.g2e36527f23

