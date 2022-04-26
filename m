Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EFE510300
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352873AbiDZQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352869AbiDZQSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D6DAA;
        Tue, 26 Apr 2022 09:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8876661AB6;
        Tue, 26 Apr 2022 16:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCABAC385A0;
        Tue, 26 Apr 2022 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650989711;
        bh=8RQQpJCsWhQDGxHZuZXjUu12YJCaQIwL7qwrWFcbQMM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=baAWbZQZFMr/d+VNeUHphrlbADghCMV2wQ8E3fVMdIM25o348Jr/spza+wynOAFJJ
         qliQ39EHBb6c991VuJDRJu3LFec94VAbn0ylJNF6lUtQD0hU+kWTjxCoSkldb27njs
         OGSPpNHCL6LDTgw5F0m2REZSPHagWO4AiZHZmACv3VC0i5wPcxPSL6Ja4D7HhijoEQ
         lRzAcC2K6QEG/fSJJ8IizEVickLoF5zRcXhsIirOII2CVNryo3GOEvsGXFhJ6Vxt8a
         YoxZUXllgL4Hd83jY6RovS29KkHr+Cxmn4qhrpf2UmwlHAoLEMmx5S0SV1DtgCwn1F
         P+wNHXsF0KpIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 89D825C0460; Tue, 26 Apr 2022 09:15:11 -0700 (PDT)
Date:   Tue, 26 Apr 2022 09:15:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, joel@joelfernandes.org,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: ftrace: avoid tracing a few functions executed
 in stop machine
Message-ID: <20220426161511.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220426105511.53010-1-patrick.wang.shcn@gmail.com>
 <20220426112250.6f56e695@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426112250.6f56e695@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:22:50AM -0400, Steven Rostedt wrote:
> On Tue, 26 Apr 2022 18:55:11 +0800
> Patrick Wang <patrick.wang.shcn@gmail.com> wrote:
> 
> > Because of the change of stop machine implementation, there are functions
> > being called while waiting currently:
> > 
> > ----------------------------------------------------------------
> > Former stop machine wait loop:
> > do {
> >     cpu_relax(); => macro
> >     ...
> > } while (curstate != STOPMACHINE_EXIT);
> > -----------------------------------------------------------------
> > Current stop machine wait loop:
> > do {
> >     stop_machine_yield(cpumask); => function (notraced)
> >     ...
> >     touch_nmi_watchdog(); => function (notraced, inside calls also notraced)
> >     ...
> >     rcu_momentary_dyntick_idle(); => function (notraced, inside calls traced)
> > } while (curstate != MULTI_STOP_EXIT);
> > ------------------------------------------------------------------
> > 
> > These functions (including the calls inside) should be marked notrace to avoid
> > their codes being updated when they are being called. The calls inside
> > rcu_momentary_dyntick_idle() still remain traced, and will cause crash:
> > 
> >   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >   rcu: 	1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
> >   rcu: 	3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
> >   	(detected by 0, t=8137 jiffies, g=5889, q=2 ncpus=4)
> >   Task dump for CPU 1:
> >   task:migration/1     state:R  running task     stack:    0 pid:   19 ppid:     2 flags:0x00000000
> >   Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> >   Call Trace:
> >   Task dump for CPU 3:
> >   task:migration/3     state:R  running task     stack:    0 pid:   29 ppid:     2 flags:0x00000000
> >   Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> >   Call Trace:
> >   rcu: rcu_preempt kthread timer wakeup didn't happen for 8136 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> >   rcu: 	Possible timer handling issue on cpu=2 timer-softirq=594
> >   rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
> >   rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> >   rcu: RCU grace-period kthread stack dump:
> >   task:rcu_preempt     state:I stack:    0 pid:   14 ppid:     2 flags:0x00000000
> >   Call Trace:
> >     schedule+0x56/0xc2
> >     schedule_timeout+0x82/0x184
> >     rcu_gp_fqs_loop+0x19a/0x318
> >     rcu_gp_kthread+0x11a/0x140
> >     kthread+0xee/0x118
> >     ret_from_exception+0x0/0x14
> >   rcu: Stack dump where RCU GP kthread last ran:
> >   Task dump for CPU 2:
> >   task:migration/2     state:R  running task     stack:    0 pid:   24 ppid:     2 flags:0x00000000
> >   Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> >   Call Trace:
> > 
> > Mark the calls inside rcu_momentary_dyntick_idle():
> >  rcu_preempt_deferred_qs()
> >  rcu_preempt_need_deferred_qs()
> >  rcu_preempt_deferred_qs_irqrestore()
> > as notrace to prevent this.
> > 
> > Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> > ---
> > v1->v2:
> >  - Modify log message.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I have reverted Patrick's earlier commit and replaced it with this
new one, including Steve's ack.  Thank you both!

							Thanx, Paul
