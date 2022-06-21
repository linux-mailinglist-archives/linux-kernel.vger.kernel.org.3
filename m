Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C87553E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbiFUWVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiFUWVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:21:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C131389;
        Tue, 21 Jun 2022 15:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E243B81A3C;
        Tue, 21 Jun 2022 22:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB433C3411C;
        Tue, 21 Jun 2022 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655850107;
        bh=3hwCwoiZgXhs4iwvVo1i/E9qh2MDXFafPY3HIbc1pNI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FPDZ+eYNtY1Eb6NkDIFZHqM2zdsZyvLKLtEyfPb43hzaDYua+JJWLAaG6cXR/XDeh
         mL4olYmHio40pmSjLjl3qhGuVj2ag2xTgO1JaJNY9Jhg3PqJA02OP0+EgAd1yPlB/t
         8FjGUCMXxnGFR368B4LkAv2yrQDgswmISQZaxRG373jHMLfY6/OVT5wroqHtbMdJbE
         eA6QmKvyxRdSzH3z7dDzN7H3yQjV60q0N0k3pf+3fL5aEN53Fn91p4gZD334ac5JfP
         UUuzkCgDjHmqxZvDO910g8nejU/Jd4HSA4MeEVumW+Pf0dA8Xjs07Uj8Kw9zXPoxke
         GQwXj8p/mdbHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 742BB5C0AE0; Tue, 21 Jun 2022 15:21:47 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:21:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Patrick Wang <patrick.wang.shcn@gmail.com>
Subject: Re: [PATCH rcu 02/12] rcu: Avoid tracing a few functions executed in
 stop machine
Message-ID: <20220621222147.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-2-paulmck@kernel.org>
 <9de7f497-a4cd-ebdb-e912-d4cd73b4a982@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de7f497-a4cd-ebdb-e912-d4cd73b4a982@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:17:10AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> > From: Patrick Wang <patrick.wang.shcn@gmail.com>
> > 
> > Stop-machine recently started calling additional functions while waiting:
> > 
> > ----------------------------------------------------------------
> > Former stop machine wait loop:
> > do {
> >      cpu_relax(); => macro
> >      ...
> > } while (curstate != STOPMACHINE_EXIT);
> > -----------------------------------------------------------------
> > Current stop machine wait loop:
> > do {
> >      stop_machine_yield(cpumask); => function (notraced)
> >      ...
> >      touch_nmi_watchdog(); => function (notraced, inside calls also notraced)
> >      ...
> >      rcu_momentary_dyntick_idle(); => function (notraced, inside calls traced)
> > } while (curstate != MULTI_STOP_EXIT);
> > ------------------------------------------------------------------
> > 
> > These functions (and the functions that they call) must be marked
> > notrace to prevent them from being updated while they are executing.
> > The consequences of failing to mark these functions can be severe:
> > 
> >    rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >    rcu: 	1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
> >    rcu: 	3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
> >    	(detected by 0, t=8137 jiffies, g=5889, q=2 ncpus=4)
> >    Task dump for CPU 1:
> >    task:migration/1     state:R  running task     stack:    0 pid:   19 ppid:     2 flags:0x00000000
> >    Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> >    Call Trace:
> >    Task dump for CPU 3:
> >    task:migration/3     state:R  running task     stack:    0 pid:   29 ppid:     2 flags:0x00000000
> >    Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> >    Call Trace:
> >    rcu: rcu_preempt kthread timer wakeup didn't happen for 8136 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> >    rcu: 	Possible timer handling issue on cpu=2 timer-softirq=594
> >    rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
> >    rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> >    rcu: RCU grace-period kthread stack dump:
> >    task:rcu_preempt     state:I stack:    0 pid:   14 ppid:     2 flags:0x00000000
> >    Call Trace:
> >      schedule+0x56/0xc2
> >      schedule_timeout+0x82/0x184
> >      rcu_gp_fqs_loop+0x19a/0x318
> >      rcu_gp_kthread+0x11a/0x140
> >      kthread+0xee/0x118
> >      ret_from_exception+0x0/0x14
> >    rcu: Stack dump where RCU GP kthread last ran:
> >    Task dump for CPU 2:
> >    task:migration/2     state:R  running task     stack:    0 pid:   24 ppid:     2 flags:0x00000000
> >    Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> >    Call Trace:
> > 
> > This commit therefore marks these functions notrace:
> >   rcu_preempt_deferred_qs()
> >   rcu_preempt_need_deferred_qs()
> >   rcu_preempt_deferred_qs_irqrestore()
> > 
> 
> Only the preemptible RCU definitions are updated; so, this change is not
> required for non-preemptible RCU case?

It appears to me to be required.  How about as shown below?

							Thanx, Paul

------------------------------------------------------------------------

commit 06cfe0c675c93884c3ffc75ec24ece7d0acd7a32
Author: Patrick Wang <patrick.wang.shcn@gmail.com>
Date:   Tue Apr 26 18:45:02 2022 +0800

    rcu: Avoid tracing a few functions executed in stop machine
    
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
      rcu:  1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
      rcu:  3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
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
      rcu:  Possible timer handling issue on cpu=2 timer-softirq=594
      rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
      rcu:  Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
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
    
    [ paulmck: Apply feedback from Neeraj Upadhyay. ]
    
    Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
    Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c8ba0fe17267c..7a07f2ca153e2 100644
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
 
@@ -926,7 +926,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * Because there is no preemptible RCU, there can be no deferred quiescent
  * states.
  */
-static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return false;
 }
@@ -935,7 +935,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 // period for a quiescent state from this CPU.  Note that requests from
 // tasks are handled when removing the task from the blocked-tasks list
 // below.
-static void rcu_preempt_deferred_qs(struct task_struct *t)
+static notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
