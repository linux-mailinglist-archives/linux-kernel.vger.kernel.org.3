Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F2505DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbiDRSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiDRSgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:36:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A226113;
        Mon, 18 Apr 2022 11:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8448B8104C;
        Mon, 18 Apr 2022 18:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E621C385A7;
        Mon, 18 Apr 2022 18:34:06 +0000 (UTC)
Date:   Mon, 18 Apr 2022 14:34:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: ftrace: avoid tracing a few functions executed in
 multi_cpu_stop()
Message-ID: <20220418143404.55c8fcab@gandalf.local.home>
In-Reply-To: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 12:37:35 +0800
Patrick Wang <patrick.wang.shcn@gmail.com> wrote:

> A few functions are in the call chain of rcu_momentary_dyntick_idle()
> which is executed in multi_cpu_stop() and marked notrace. They are running
> in traced when ftrace modify code. This may cause non-ftrace_modify_code
> CPUs stall:

I'm confused by this. How is traced functions causing this exactly? Is this
on RISC-V?

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

The rcu_momentary_dyntick_idle() was marked notrace because of RISC-V not
being able to call functions from within stop machine. If that's what is
being prevented, then I'm fine with this (although I'm thinking we need
different kinds of "notrace" for different architectures as one arch's
limitation should not be cause for another's).

But before I ack this patch, I want to understand the real issues here.

-- Steve
