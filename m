Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC24D60AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348244AbiCKLeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348281AbiCKLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:34:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098BA1BFDD4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B5F61C0C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC71C340E9;
        Fri, 11 Mar 2022 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646998379;
        bh=uSZVRIEZmmAI50rSDOLQVVMX+nrIiVbr3OGKRDJH6/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdgodhClckzNLV4qaZqt7BV+YrSBb+4zCmLUQqygGAH4TMFmnD6mm6dehkTjnmsoe
         56QONzPS1JRFxlFO89VnHfcBJJE9/WVKr9QgcgtjuIeVX3z/ihx8J1IMaqmjxoUYUj
         Z5fGNh/APkPuuoak+5PHgCxihQAH/IkVtHYZnzZRN7UdjBHkpY6IRwdVWVCP65mHra
         B55U4tAqr14VvtccnSOASwMUEhOsTcUa02q0mklVaX9uz2VZH70E7UvWSGPLD5z2dc
         ykgfCsb04bWjBvRM5uMd5R/vhQQltkrG4uBrLE70+9P/4bswdIsC0mHV0FroM2NnNU
         RN34ANnEnQhdw==
Date:   Fri, 11 Mar 2022 12:32:56 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scenario TREE07 with CONFIG_PREEMPT_DYNAMIC=n?
Message-ID: <20220311113256.GB96127@lothringen>
References: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
 <20220310224103.GA94994@lothringen>
 <20220310225219.GE4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310225219.GE4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 02:52:19PM -0800, Paul E. McKenney wrote:
> On Thu, Mar 10, 2022 at 11:41:03PM +0100, Frederic Weisbecker wrote:
> > On Thu, Mar 10, 2022 at 01:56:30PM -0800, Paul E. McKenney wrote:
> > > Hello, Frederic,
> > > 
> > > I recently added CONFIG_PREEMPT_DYNAMIC=n to the TREE07 file, and since
> > > then am getting roughly one RCU CPU stall warning (or silent hang)
> > > per few tens of hours of rcutorture testing on dual-socket systems.
> > > The stall warnings feature starvation of RCU grace-period kthread.
> > > 
> > > Any advice on debugging this?
> > 
> > Oh, I'm testing that!
> 
> Even better, thank you!  ;-)

One possibly interesting detail: the stalling CPU is stuck on
sync_rcu_do_polled_gp(), which is launched by the recent start_poll_synchronize_rcu_expedited():

[  463.518410]  <IRQ>
[  463.518691]  dump_stack_lvl+0x33/0x42
[  463.519182]  nmi_cpu_backtrace+0xc0/0xe0
[  463.519706]  ? lapic_can_unplug_cpu+0x90/0x90
[  463.522188]  nmi_trigger_cpumask_backtrace+0x82/0xc0
[  463.522863]  rcu_dump_cpu_stacks+0xc0/0xf0
[  463.523410]  rcu_sched_clock_irq+0x6e3/0xa30
[  463.523982]  ? tick_sched_handle.isra.21+0x40/0x40
[  463.524628]  update_process_times+0x87/0xb0
[  463.525183]  tick_sched_handle.isra.21+0x2b/0x40
[  463.525795]  tick_sched_timer+0x5e/0x70
[  463.526306]  __hrtimer_run_queues+0x108/0x240
[  463.526886]  hrtimer_interrupt+0xe0/0x240
[  463.527419]  __sysvec_apic_timer_interrupt+0x55/0xf0
[  463.528436]  sysvec_apic_timer_interrupt+0x43/0x80
[  463.529074]  </IRQ>
[  463.529366]  <TASK>
[  463.529656]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  463.530333] RIP: 0010:synchronize_rcu_expedited+0x0/0x3f0
[  463.531042] Code: 89 65 48 48 89 ef e8 8f 03 af 00 48 8b 85 80 00 00 00 48 85 c0 0f 84 70 ff ff ff 4c 8b 65 68 48 89 c5 eb b6 66 0f 1f 44 00 00 <41> 54 55 53 48 81 ec 90 00 00 00 44 8b 25 3a 10 7a 01 65 48 8b 04
[  463.533454] RSP: 0018:ffffb2e94045be88 EFLAGS: 00000287
[  463.534141] RAX: 000000000001300c RBX: 0000000000013010 RCX: ffff98941f2298e8
[  463.535078] RDX: 0000000000013011 RSI: 0000000000000286 RDI: ffffffff9bb3ba9c
[  463.536007] RBP: ffffffff9bb3baa8 R08: 000070675f756372 R09: 8080808080808080
[  463.536948] R10: ffffb2e940077d48 R11: fefefefefefefeff R12: ffffffff9bb3ba9c
[  463.537878] R13: 0000000000000000 R14: ffff98941f2298c0 R15: ffff98941f22e005
[  463.538810]  sync_rcu_do_polled_gp+0x39/0xc0
[  463.539382]  process_one_work+0x1ec/0x3b0
[  463.539917]  worker_thread+0x25/0x390
[  463.548472]  ? process_one_work+0x3b0/0x3b0
[  463.549193]  kthread+0xbd/0xe0
[  463.549730]  ? kthread_complete_and_exit+0x20/0x20
[  463.550548]  ret_from_fork+0x22/0x30
[  463.551167]  </TASK>


Could be this:

	while (!sync_exp_work_done(s))
		synchronize_rcu_expedited();

And if synchronize_rcu_expedited() -> rcu_blocking_is_gp() is true, then we
may run in a long loop withing the workqueue without a chance to report a QS,
expecially if we are running a non-preemptible kernel. This could be the cause
of the stalling grace period kthread.

rcu_blocking_is_gp() could be true if all other CPUs but the current one are
offline.

It's just a potential scenario, lemme check...
