Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFC5A9E15
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiIARdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiIARdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C192F73;
        Thu,  1 Sep 2022 10:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9639D61FEF;
        Thu,  1 Sep 2022 17:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041A8C433D7;
        Thu,  1 Sep 2022 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662053585;
        bh=Tq0rG+ZmykyWv/+uRuggAUDl+ZN37G+pmZ0/EKVVsaw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bB4jwaNZ3efSgeu7GlgNDqRc2nflVPexLMYWu2xef7ZghDNBgJpAJ5c8afhiKUP+M
         kqMx/u7v9KpGHPZjdQbczH1/G8FID3J5pVJkp24aVyR4xNhMuO9KCZA+NePzdYdx8M
         zoK17D7FcgYweZaUu3yz/N4cwBhTVrzs+DE8EVD1JlnGvH/O4q8SPEVpfcRuDr7Obj
         Qd04Jp/6L7HkKlVyu6YQXdGJQFtn/31Cm3hTsFH4hUwMLD7wmwCfbAKsNbUj2lxUuG
         hEG77bwTYgYnjwiRp6DNNVNgv586RendAzBWPZUy0auwhQ/U/bnn9K8P2rklEDUUZ2
         2M2jzKgwz9SWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A96085C0691; Thu,  1 Sep 2022 10:33:04 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:33:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Matthew Wilcox <willy@infradead.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH rcu 04/32] rcu-tasks: Drive synchronous grace periods
 from calling task
Message-ID: <20220901173304.GA2280413@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
 <20220620225411.3842519-4-paulmck@kernel.org>
 <20220901103625.GA1658@pengutronix.de>
 <20220901172725.GC6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901172725.GC6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:27:25AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 01, 2022 at 12:36:25PM +0200, Sascha Hauer wrote:
> > Hi Paul,
> > 
> > On Mon, Jun 20, 2022 at 03:53:43PM -0700, Paul E. McKenney wrote:
> > > This commit causes synchronous grace periods to be driven from the task
> > > invoking synchronize_rcu_*(), allowing these functions to be invoked from
> > > the mid-boot dead zone extending from when the scheduler was initialized
> > > to to point that the various RCU tasks grace-period kthreads are spawned.
> > > This change will allow the self-tests to run in a consistent manner.
> > > 
> > > Reported-by: Matthew Wilcox <willy@infradead.org>
> > > Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > This commit (appeared in mainline as 4a8cc433b8bf) breaks booting my
> > ARMv7 based i.MX6ul board when CONFIG_PROVE_RCU is enabled. Reverting
> > this patch on v6.0-rc3 makes my board boot again. See below for a boot
> > log. The last message is "Running RCU-tasks wait API self tests", after
> > that the board hangs. Any idea what goes wrong here?
> 
> New one on me!
> 
> Is it possible to get a stack trace of the hang, perhaps via
> one form or another of sysrq-T?  Such a stack trace would likely
> include synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), or
> synchronize_rcu_tasks_trace() followed by synchronize_rcu_tasks_generic(),
> rcu_tasks_one_gp(), and one of rcu_tasks_wait_gp(),
> rcu_tasks_rude_wait_gp(), or rcu_tasks_wait_gp().

If there is no chance of sysrq-T, kernel debuggers, kernel crash
dumps, or any other source of the stack trace, please decorate the
code path with printk() or similar and let me know where it goes.
Under normal circumstances, this code path is not sensitive to performance
perturbations of the printk() persuasion.

							Thanx, Paul

> At this point in the boot sequence, there is only one online CPU,
> correct?
> 
> I have seen recent non-boot hangs within synchronize_rcu_tasks()
> due to some other task getting stuck in do_exit() between its calls
> to exit_tasks_rcu_start() and exit_tasks_rcu_finish().  The symptom of
> this is that the aforementioned stack trace includes synchronize_srcu().
> I would not expect much in the way of exiting tasks that early in the
> boot sequence, but who knows?
> 
> 							Thanx, Paul
> 
> > Sascha
> > 
> > ----------------------------8<-----------------------------
> > 
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 5.19.0-rc3-00004-g4a8cc433b8bf (sha@dude02) (arm-v7a-linux-gnueabihf-gcc (OSELAS.Toolchain-2021.07.0 11-20210703) 11.1.1 20210703, GNU ld (GNU Binutils) 2.36.1) #229 SMP Thu Sep 1 12:00:07 CEST 2022
> > [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> > [    0.000000] CPU: div instructions available: patching division code
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > [    0.000000] OF: fdt: Machine model: IDS CU33X
> > [    0.000000] earlycon: ec_imx6q0 at MMIO 0x02020000 (options '')
> > [    0.000000] printk: bootconsole [ec_imx6q0] enabled
> > [    0.000000] Memory policy: Data cache writealloc
> > [    0.000000] cma: Reserved 64 MiB at 0x8c000000
> > [    0.000000] Zone ranges:
> > [    0.000000]   Normal   [mem 0x0000000080000000-0x000000008fffffff]
> > [    0.000000]   HighMem  empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000008fffffff]
> > [    0.000000] percpu: Embedded 17 pages/cpu s38068 r8192 d23372 u69632
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 65024
> > [    0.000000] Kernel command line: console=ttymxc0,115200n8 earlycon ip=dhcp root=/dev/nfs nfsroot=192.168.8.12:/hom
> > e/sha/nfsroot/cu33x,v3,tcp
> > [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
> > [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] Memory: 162600K/262144K available (15360K kernel code, 2146K rwdata, 5472K rodata, 1024K init, 6681K b
> > ss, 34008K reserved, 65536K cma-reserved, 0K highmem)
> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> > [    0.000000] trace event string verifier disabled
> > [    0.000000] Running RCU self tests
> > [    0.000000] rcu: Hierarchical RCU implementation.
> > [    0.000000] rcu:     RCU event tracing is enabled.
> > [    0.000000] rcu:     RCU lockdep checking is enabled.
> > [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
> > [    0.000000]  Tracing variant of Tasks RCU enabled.
> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> > [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> > [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> > [    0.000000] Switching to timer-based delay loop, resolution 41ns
> > [    0.000003] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
> > [    0.007810] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
> > [    0.021748] Console: colour dummy device 80x30
> > [    0.023488] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> > [    0.032009] ... MAX_LOCKDEP_SUBCLASSES:  8
> > [    0.035282] ... MAX_LOCK_DEPTH:          48
> > [    0.039445] ... MAX_LOCKDEP_KEYS:        8192
> > [    0.043886] ... CLASSHASH_SIZE:          4096
> > [    0.048127] ... MAX_LOCKDEP_ENTRIES:     32768
> > [    0.052552] ... MAX_LOCKDEP_CHAINS:      65536
> > [    0.057069] ... CHAINHASH_SIZE:          32768
> > [    0.061405]  memory used by lock dependency info: 4061 kB
> > [    0.066788]  memory used for stack traces: 2112 kB
> > [    0.071645]  per task-struct memory footprint: 1536 bytes
> > [    0.077138] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
> > [    0.087384] pid_max: default: 32768 minimum: 301
> > [    0.093527] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
> > [    0.099327] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
> > [    0.116798] CPU: Testing write buffer coherency: ok
> > [    0.122036] CPU0: update cpu_capacity 1024
> > [    0.123381] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> > [    0.137390] cblist_init_generic: Setting adjustable number of callback queues.
> > [    0.142282] cblist_init_generic: Setting shift to 0 and lim to 1.
> > [    0.149333] Running RCU-tasks wait API self tests
> > 
> > -- 
> > Pengutronix e.K.                           |                             |
> > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
