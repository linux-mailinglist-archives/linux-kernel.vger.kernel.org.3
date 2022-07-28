Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680EB584400
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiG1QPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiG1QPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:15:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30550DEFE;
        Thu, 28 Jul 2022 09:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF9F661ACF;
        Thu, 28 Jul 2022 16:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD3CC433D7;
        Thu, 28 Jul 2022 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659024921;
        bh=4x2rCbBUzhCOqyqDoWtF0OYcCiklc51sPvgvhnU3PLI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cip6szz13Lkf23ci49EvKp1Cjvf0USANL5zUSgk+I9+v8mfSeAERpobOLzwzSMqWs
         DZbooa4SVD1qpxftnf1W3OHijz2x3mhzN5lNhrVtQWudGdri1xRpqhOUF8p9B5+EW+
         HtIaCjd6J2g8kBhJ+H371byX0jGbvCPv6zFr6xYYZ7DP7i29hAD1GXHWLVaRRLvMYK
         cvog3Lv1kwYmh+X0qvkBEOoI6ipfiO+4AbD5V5RHKVyWpEYRCO8667ETUKgnAFIt+U
         8TXUz55wukayErV1C0ho2ggl4ryItbdU1sMF1rmaisHlxSjLU8L7D09f59Cjm6Vbgc
         vB1XdJprDf0Ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD0705C0B3E; Thu, 28 Jul 2022 09:15:20 -0700 (PDT)
Date:   Thu, 28 Jul 2022 09:15:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Display registers of self-detected stall as far
 as possible
Message-ID: <20220728161520.GE2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220728024327.1202-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728024327.1202-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 10:43:27AM +0800, Zhen Lei wrote:
> For architectures that do not support NMI interrupts, registers is not
> printed when rcu stall is self-detected. However, this information is
> useful for analyzing the root cause of the fault. Fortunately, the rcu
> stall is always detected in the tick interrupt handler. So we can take
> it through get_irq_regs() and display it through show_regs(). Further,
> show_regs() unwind the call trace based on 'regs', the worthless call
> trace associated with tick handling will be omitted, this helps us to
> focus more on the problem.
> 
> This is an example on arm64:
> [   27.501721] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   27.502238] rcu:     0-....: (1250 ticks this GP) idle=4f7/1/0x4000000000000000 softirq=2594/2594 fqs=619
> [   27.502632]  (t=1251 jiffies g=2989 q=29 ncpus=4)
> [   27.503845] CPU: 0 PID: 306 Comm: test0 Not tainted 5.19.0-rc7-00009-g1c1a6c29ff99-dirty #46
> [   27.504732] Hardware name: linux,dummy-virt (DT)
> [   27.504947] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   27.504998] pc : arch_counter_read+0x18/0x24
> [   27.505301] lr : arch_counter_read+0x18/0x24
> [   27.505328] sp : ffff80000b29bdf0
> [   27.505345] x29: ffff80000b29bdf0 x28: 0000000000000000 x27: 0000000000000000
> [   27.505475] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> [   27.505553] x23: 0000000000001f40 x22: ffff800009849c48 x21: 000000065f871ae0
> [   27.505627] x20: 00000000000025ec x19: ffff80000a6eb300 x18: ffffffffffffffff
> [   27.505654] x17: 0000000000000001 x16: 0000000000000000 x15: ffff80000a6d0296
> [   27.505681] x14: ffffffffffffffff x13: ffff80000a29bc18 x12: 0000000000000426
> [   27.505709] x11: 0000000000000162 x10: ffff80000a2f3c18 x9 : ffff80000a29bc18
> [   27.505736] x8 : 00000000ffffefff x7 : ffff80000a2f3c18 x6 : 00000000759bd013
> [   27.505761] x5 : 01ffffffffffffff x4 : 0002dc6c00000000 x3 : 0000000000000017
> [   27.505787] x2 : 00000000000025ec x1 : ffff80000b29bdf0 x0 : 0000000075a30653
> [   27.505937] Call trace:
> [   27.506002]  arch_counter_read+0x18/0x24
> [   27.506171]  ktime_get+0x48/0xa0
> [   27.506207]  test_task+0x70/0xf0
> [   27.506227]  kthread+0x10c/0x110
> [   27.506243]  ret_from_fork+0x10/0x20
> 
> The old output is as follows:
> [   27.944550] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   27.944980] rcu:     0-....: (1249 ticks this GP) idle=cbb/1/0x4000000000000000 softirq=2610/2610 fqs=614
> [   27.945407]  (t=1251 jiffies g=2681 q=28 ncpus=4)
> [   27.945731] Task dump for CPU 0:
> [   27.945844] task:test0           state:R  running task     stack:    0 pid:  306 ppid:     2 flags:0x0000000a
> [   27.946073] Call trace:
> [   27.946151]  dump_backtrace.part.0+0xc8/0xd4
> [   27.946378]  show_stack+0x18/0x70
> [   27.946405]  sched_show_task+0x150/0x180
> [   27.946427]  dump_cpu_task+0x44/0x54
> [   27.947193]  rcu_dump_cpu_stacks+0xec/0x130
> [   27.947212]  rcu_sched_clock_irq+0xb18/0xef0
> [   27.947231]  update_process_times+0x68/0xac
> [   27.947248]  tick_sched_handle+0x34/0x60
> [   27.947266]  tick_sched_timer+0x4c/0xa4
> [   27.947281]  __hrtimer_run_queues+0x178/0x360
> [   27.947295]  hrtimer_interrupt+0xe8/0x244
> [   27.947309]  arch_timer_handler_virt+0x38/0x4c
> [   27.947326]  handle_percpu_devid_irq+0x88/0x230
> [   27.947342]  generic_handle_domain_irq+0x2c/0x44
> [   27.947357]  gic_handle_irq+0x44/0xc4
> [   27.947376]  call_on_irq_stack+0x2c/0x54
> [   27.947415]  do_interrupt_handler+0x80/0x94
> [   27.947431]  el1_interrupt+0x34/0x70
> [   27.947447]  el1h_64_irq_handler+0x18/0x24
> [   27.947462]  el1h_64_irq+0x64/0x68                       <--- the above backtrace is worthless
> [   27.947474]  arch_counter_read+0x18/0x24
> [   27.947487]  ktime_get+0x48/0xa0
> [   27.947501]  test_task+0x70/0xf0
> [   27.947520]  kthread+0x10c/0x110
> [   27.947538]  ret_from_fork+0x10/0x20
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

A nice improvement!

But wouldn't it be better to push this code down into dump_cpu_task()
itself, so that all callers could gain this benefit?

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> v1 --> v2:
> Fix C99 build warning:
> kernel/rcu/tree_stall.h:358:10: error: call to undeclared function 'get_irq_regs';
> ISO C99 and later do not support implicit function declarations
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index a001e1e7a99269c..23bfd755c3f6e5b 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/kvm_para.h>
> +#include <asm/irq_regs.h>
>  
>  //////////////////////////////////////////////////////////////////////////////
>  //
> @@ -350,6 +351,21 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>  }
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
> +static void rcu_dump_cpu_task(int cpu)
> +{
> +	if (cpu == smp_processor_id() && in_irq()) {
> +		struct pt_regs *regs;
> +
> +		regs = get_irq_regs();
> +		if (regs) {
> +			show_regs(regs);
> +			return;
> +		}
> +	}
> +
> +	dump_cpu_task(cpu);
> +}
> +
>  /*
>   * Dump stacks of all tasks running on stalled CPUs.  First try using
>   * NMIs, but fall back to manual remote stack tracing on architectures
> @@ -369,7 +385,7 @@ static void rcu_dump_cpu_stacks(void)
>  				if (cpu_is_offline(cpu))
>  					pr_err("Offline CPU %d blocking current GP.\n", cpu);
>  				else if (!trigger_single_cpu_backtrace(cpu))
> -					dump_cpu_task(cpu);
> +					rcu_dump_cpu_task(cpu);
>  			}
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
> -- 
> 2.25.1
> 
