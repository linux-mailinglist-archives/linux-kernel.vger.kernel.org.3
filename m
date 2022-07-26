Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1BE581157
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiGZKlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiGZKli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:41:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0464B17062;
        Tue, 26 Jul 2022 03:41:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6381D1FB;
        Tue, 26 Jul 2022 03:41:38 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F3C93F70D;
        Tue, 26 Jul 2022 03:41:37 -0700 (PDT)
Date:   Tue, 26 Jul 2022 11:41:34 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [-next] Lockdep warnings
Message-ID: <20220726104134.3b3awfphvafljdgp@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was seeing the below lockdep warnings on my arm64 Juno development
platform almost 2 weeks back with -next. I wanted to check for similar
reports before post and forgot.

--->8

DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
 hardirqs last  enabled at (46157): cpuidle_enter_state+0x174/0x2b4
 WARNING: CPU: 5 PID: 0 at kernel/locking/lockdep.c:5506 check_flags+0x90/0x1e8
 hardirqs last disabled at (46158): el1_interrupt+0x2c/0xc8
 Modules linked in:
 softirqs last  enabled at (46154): __do_softirq+0x2c0/0x388
 softirqs last disabled at (46139): __irq_exit_rcu+0x118/0x18c
 CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.19.0-rc6-next-20220714 #9
 pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : check_flags+0x90/0x1e8
 lr : check_flags+0x90/0x1e8
 Call trace:
  check_flags+0x90/0x1e8
  lock_is_held_type+0x80/0x164
  rcu_read_lock_sched_held+0x40/0x7c
  trace_rcu_dyntick+0x5c/0x140
  ct_kernel_enter+0x78/0xd4
  ct_idle_exit+0x1c/0x44
  cpu_idle_poll+0x74/0xb8
  do_idle+0x90/0x2c4
  cpu_startup_entry+0x30/0x34
  secondary_start_kernel+0x130/0x144
  __secondary_switched+0xb0/0xb4
 irq event stamp: 64229
 hardirqs last  enabled at (64229): cpu_idle_poll+0x40/0xb8
 hardirqs last disabled at (64228): do_idle+0xbc/0x2c4
 softirqs last  enabled at (64190): __do_softirq+0x2c0/0x388
 softirqs last disabled at (64185): __irq_exit_rcu+0x118/0x18c
 ---[ end trace 0000000000000000 ]---
 possible reason: unannotated irqs-off.
 irq event stamp: 64229
 hardirqs last  enabled at (64229): cpu_idle_poll+0x40/0xb8
 hardirqs last disabled at (64228): do_idle+0xbc/0x2c4
 softirqs last  enabled at (64190): __do_softirq+0x2c0/0x388
 softirqs last disabled at (64185): __irq_exit_rcu+0x118/0x18c

----

However I don't see the above warning with the latest -next. When I tried
yesterday's -next now, I see a different warning. Not sure if they are
related. I haven't tried to bisect.

--->8
=============================
[ BUG: Invalid wait context ]
5.19.0-rc8-next-20220725 #38 Not tainted
-----------------------------
swapper/0/0 is trying to lock:
(&drvdata->spinlock){....}-{3:3}, at: cti_cpu_pm_notify+0x54/0x114
other info that might help us debug this:
context-{5:5}
1 lock held by swapper/0/0:
 #0: (cpu_pm_notifier.lock){....}-{2:2}, at: cpu_pm_enter+0x2c/0x80
stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc8-next-20220725-00004-g599e6691ed8c #38
Call trace:
 dump_backtrace+0xe8/0x108
 show_stack+0x18/0x4c
 dump_stack_lvl+0x90/0xc8
 dump_stack+0x18/0x54
 __lock_acquire+0xa70/0x32d0
 lock_acquire+0x160/0x308
 _raw_spin_lock+0x60/0xa0
 cti_cpu_pm_notify+0x54/0x114
 raw_notifier_call_chain_robust+0x50/0xd4
 cpu_pm_enter+0x48/0x80
 psci_enter_idle_state+0x34/0x74
 cpuidle_enter_state+0x120/0x2a8
 cpuidle_enter+0x38/0x50
 do_idle+0x1e8/0x2b8
 cpu_startup_entry+0x24/0x28
 kernel_init+0x0/0x1a0
 start_kernel+0x0/0x470
 start_kernel+0x34c/0x470
 __primary_switched+0xbc/0xc4

----

--
Regards,
Sudeep
