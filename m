Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D7C505C70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346193AbiDRQbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346156AbiDRQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:31:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D14430556;
        Mon, 18 Apr 2022 09:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C07F6B80E54;
        Mon, 18 Apr 2022 16:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38723C385A7;
        Mon, 18 Apr 2022 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650299296;
        bh=kiP03+BsgafxrEW7VA5Zy62JiyMocWFjKdcGO002e+c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kQkutgBWkCOmtXOWMLr+3A8JQOPABInlUwisScwd1GGco/W9Q0Rx0TZCO/ksQaNMi
         T1L+tVIP+naGXzAkNDw+B1oe4fpBEwbLVjfW/xwceNIEAOgI/qljeve0BgzbaeSyLv
         Xd1iH67jjG2TofhBYWFc+cjjfJeSw1oIKiFtIYF3l0jEp//qMG3QLLRuIWEaH7Ulau
         PO6AXGm38QXECG1dHuBghbuCfcwJqSx1HsN5PU/yEiMZaOvvPy5CzUGpl1j+5XI8jf
         qVi+d3KnLlji7BxTRfzmUOzi85QxC6i75RYtZGUNvjRpc3jgbp5lRnEveFHGsNFGZR
         kc93d0g7p0Y7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D11E65C0970; Mon, 18 Apr 2022 09:28:15 -0700 (PDT)
Date:   Mon, 18 Apr 2022 09:28:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     rostedt@goodmis.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] rcu: ftrace: avoid tracing a few functions executed in
 multi_cpu_stop()
Message-ID: <20220418162815.GV4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:37:35PM +0800, Patrick Wang wrote:
> A few functions are in the call chain of rcu_momentary_dyntick_idle()
> which is executed in multi_cpu_stop() and marked notrace. They are running
> in traced when ftrace modify code. This may cause non-ftrace_modify_code
> CPUs stall:
> 
> [   72.686113] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   72.687344] rcu: 	1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
> [   72.687800] rcu: 	3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
> [   72.688280] 	(detected by 0, t=8137 jiffies, g=5889, q=2 ncpus=4)
> [   72.688739] Task dump for CPU 1:
> [   72.688991] task:migration/1     state:R  running task     stack:    0 pid:   19 ppid:     2 flags:0x00000000
> [   72.689594] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> [   72.690242] Call Trace:
> [   72.690603] Task dump for CPU 3:
> [   72.690761] task:migration/3     state:R  running task     stack:    0 pid:   29 ppid:     2 flags:0x00000000
> [   72.691135] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> [   72.691474] Call Trace:
> [   72.691733] rcu: rcu_preempt kthread timer wakeup didn't happen for 8136 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> [   72.692180] rcu: 	Possible timer handling issue on cpu=2 timer-softirq=594
> [   72.692485] rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
> [   72.692876] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> [   72.693232] rcu: RCU grace-period kthread stack dump:
> [   72.693433] task:rcu_preempt     state:I stack:    0 pid:   14 ppid:     2 flags:0x00000000
> [   72.693788] Call Trace:
> [   72.694018] [<ffffffff807f3740>] schedule+0x56/0xc2
> [   72.694306] [<ffffffff807f9cd8>] schedule_timeout+0x82/0x184
> [   72.694539] [<ffffffff8007c456>] rcu_gp_fqs_loop+0x19a/0x318
> [   72.694809] [<ffffffff8007e408>] rcu_gp_kthread+0x11a/0x140
> [   72.695325] [<ffffffff800324d6>] kthread+0xee/0x118
> [   72.695657] [<ffffffff8000398a>] ret_from_exception+0x0/0x14
> [   72.696089] rcu: Stack dump where RCU GP kthread last ran:
> [   72.696383] Task dump for CPU 2:
> [   72.696562] task:migration/2     state:R  running task     stack:    0 pid:   24 ppid:     2 flags:0x00000000
> [   72.697059] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> [   72.697471] Call Trace:
> 
> Mark rcu_preempt_deferred_qs(), rcu_preempt_need_deferred_qs() and
> rcu_preempt_deferred_qs_irqrestore() notrace to avoid this.
> 
> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>

Good catch!

I have queued this for testing and further review.  I am especially
interested in the tracing guys' take on this.

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c3d212bc5338..07b3e656aedd 100644
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
