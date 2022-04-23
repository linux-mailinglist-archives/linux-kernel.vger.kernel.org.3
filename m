Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63A050CC57
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiDWQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiDWQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:39:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E0FB76;
        Sat, 23 Apr 2022 09:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0755860EBC;
        Sat, 23 Apr 2022 16:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589E8C385A0;
        Sat, 23 Apr 2022 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650731785;
        bh=B+o9IcDRcehV8mMFnYKSaZ8wkV149HVbvdWwGnCwZIo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tN7a9xYl3T/HXPDAOyugcDba5wn/7JAXK56Je0latRw2vLUCAyG+U2BtjYH9/fy3f
         pPGEg6fYp9vkJrGhNsX0f14DaIvhgKeVPz8LGtx9J2hOVN/jrWeGLS1Ez0+fPPHdgr
         hYYKVk4snNN2aGsusSvaU6Cq4m9Iz+Dj9PSKTfulE15yjMw3zN7IKuJqjY6GiqYN8a
         g0PXy2E6A2wFLpoY4oYxrlD8Q3QctRz39pQqMtRJ2AG9pgmEUtjZwkgIH97qaF123G
         SDAnliJtKWUF2zwZfMOyJ9MosTcDrIM0IfBLztCvlfgHvAmjXoXnO73wYcVDm8zcKI
         1KAdvOoljj9GQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F155C5C038F; Sat, 23 Apr 2022 09:36:24 -0700 (PDT)
Date:   Sat, 23 Apr 2022 09:36:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     rostedt@goodmis.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: ftrace: avoid tracing a few functions executed
 in stop machine
Message-ID: <20220423163624.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220423102844.1371595-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423102844.1371595-1-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 06:28:44PM +0800, Patrick Wang wrote:
> Because of the change of stop machine implementation, there are functions
> being called while waiting currently:
> 
> ----------------------------------------------------------------
> Former stop machine wait loop:
> do {
>     cpu_relax(); => macro
>     ...
> } while (curstate != STOPMACHINE_EXIT);
> -----------------------------------------------------------------
> Current stop machine wait loop:
> do {
>     stop_machine_yield(cpumask); => function (notraced)
>     ...
>     touch_nmi_watchdog(); => function (notraced, inside calls also notraced)
>     ...
>     rcu_momentary_dyntick_idle(); => function (notraced, inside calls traced)
> } while (curstate != MULTI_STOP_EXIT);
> ------------------------------------------------------------------
> 
> These functions (including the calls inside) should be marked notrace to avoid
> their codes being updated when they are being called. The calls inside
> rcu_momentary_dyntick_idle() still remain traced, and will cause crash:
> 
>   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   rcu: 	1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
>   rcu: 	3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
>   	(detected by 0, t=8137 jiffies, g=5889, q=2 ncpus=4)
>   Task dump for CPU 1:
>   task:migration/1     state:R  running task     stack:    0 pid:   19 ppid:     2 flags:0x00000000
>   Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
>   Call Trace:
>   Task dump for CPU 3:
>   task:migration/3     state:R  running task     stack:    0 pid:   29 ppid:     2 flags:0x00000000
>   Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
>   Call Trace:
>   rcu: rcu_preempt kthread timer wakeup didn't happen for 8136 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
>   rcu: 	Possible timer handling issue on cpu=2 timer-softirq=594
>   rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
>   rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
>   rcu: RCU grace-period kthread stack dump:
>   task:rcu_preempt     state:I stack:    0 pid:   14 ppid:     2 flags:0x00000000
>   Call Trace:
>     schedule+0x56/0xc2
>     schedule_timeout+0x82/0x184
>     rcu_gp_fqs_loop+0x19a/0x318
>     rcu_gp_kthread+0x11a/0x140
>     kthread+0xee/0x118
>     ret_from_exception+0x0/0x14
>   rcu: Stack dump where RCU GP kthread last ran:
>   Task dump for CPU 2:
>   task:migration/2     state:R  running task     stack:    0 pid:   24 ppid:     2 flags:0x00000000
>   Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
>   Call Trace:
> 
> Mark the calls inside rcu_momentary_dyntick_idle():
>  rcu_preempt_deferred_qs()
>  rcu_preempt_need_deferred_qs()
>  rcu_preempt_deferred_qs_irqrestore()
> as notrace to prevent this.
> 
> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>

Thank you, Patrick!

Steve, are you good with this version?  If so, I will replace the older
version in -rcu with this version.

							Thanx, Paul

> ---
> v1->v2:
>  - Modify log message.
> 
>  kernel/rcu/tree_plugin.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c8ba0fe17267..971bb6a00ede 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -460,7 +460,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
>   * be quite short, for example, in the case of the call from
>   * rcu_read_unlock_special().
>   */
> -static void
> +notrace static void
>  rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  {
>  	bool empty_exp;
> @@ -581,7 +581,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>   * is disabled.  This function cannot be expected to understand these
>   * nuances, so the caller must handle them.
>   */
> -static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> +notrace static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  {
>  	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
>  		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> @@ -595,7 +595,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>   * evaluate safety in terms of interrupt, softirq, and preemption
>   * disabling.
>   */
> -static void rcu_preempt_deferred_qs(struct task_struct *t)
> +notrace static void rcu_preempt_deferred_qs(struct task_struct *t)
>  {
>  	unsigned long flags;
>  
> -- 
> 2.25.1
> 
