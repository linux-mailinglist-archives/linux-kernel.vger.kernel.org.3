Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8F5181E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiECKEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiECKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:04:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D860CC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED7E6B81CAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94779C385A4;
        Tue,  3 May 2022 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651572063;
        bh=EpMh1FETop0MnFf6AU9Aox0ljL0kqHb42Qr7FU1cIjU=;
        h=From:To:Cc:Subject:Date:From;
        b=rPa/vQbh8fIP9FvT/Np92eiLMpKPylMzcQRyzAVsOh+eRV1JQls7FPuu7Y29+jQgD
         cFwbsEQoMpPDjp+dTGx6vlpAJqp0bRoUf1A39oAqp7klpOZbGYv1g00UZv+MWhJrvG
         kb/aBq4DclsPlDRAMiehakj0+N0ObVuPRujyJgGM3hAHPAPD1zfdKnITCiYCh/reVS
         q0zHeOyXny7v30s57igDMYE6QtPEyhm/it09RPp23mGtp67rImtMWuXw+94aJSWzwf
         S7yE2jQyyJiOwKfy9mpYAKLpuVimDS/fY+sGat0TD/59HXEqBuRoUGRkPHMyToQ8xz
         M8n/1mX8hRMqQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 00/21] rcu/context-tracking: Merge RCU eqs-dynticks counter to context tracking v2
Date:   Tue,  3 May 2022 12:00:30 +0200
Message-Id: <20220503100051.2799723-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
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

This mixes up the RCU dynticks counter and the context tracking state
updates into a single atomic instruction. This may serve several
purposes:

1) Improve CPU isolation with deferring some disturbances until sensitive
   userspace workload completes and goes to the kernel. This can take
   several forms, for example smp_call_function_housekeeping() or
   on_each_housekeeping_cpu() to enqueue and execute work on all
   housekeeping CPUs. Then an atomic operation on ct->state can defer
   the work on nohz_full CPUs until they run in kernel (or IPI them
   if they are in kernel mode), see this proposal by Peter:
   https://lore.kernel.org/all/20210929151723.162004989@infradead.org/#r

2) Unearth sysidle (https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=sysidle.2017.05.11a&id=fe5ac724d81a3c7803e60c2232718f212f3f38d4)
   This feature allowed to shutdown the tick on the last housekeeping
   CPU once the rest of the system is fully idle. We needed some proper
   fully ordered context tracking for that.

Inspired by Peterz: https://lore.kernel.org/all/20210929151723.162004989@infradead.org

Passed 100 hours of TREE01.

---
Changes since v1 after Paul, Nicolas and Peter's reviews:

* Rebased against latest rcu:dev

* Remove context_tracking_in_user()

* Tag rcu_idle_enter() as noinstr

* Add comments to explain why some RCU and context tracking functions can not
  be tagged as noinstr yet even though they should

* Add Acks from Paul

* Rename context_tracking_cpu_set() to ct_cpu_track_user()

* Some changelogs fixed

* Fix missing renames in cpuidle

* Add missing header comments for ct_irq_*()

* Add accessors for ->dynticks_nesting and ->dynticks_nmi_nesting

* Fix ->dynticks_nesting[_nmi] that were printed from the local ct
  instead of the remote one

* Only build rcu_irq_exit_check_preempt() when CONFIG_NO_HZ_FULL=y

* Remove static from rcu_preempt_deferred_qs() for all configs

* CONTEXT_* values now count from 0 to 4 instead of using bit flags,
  since all these states are mutually exclusive anyway.
  Therefore RCU_DYNTICKS_IDX now starts at 4 instead of 8.

* Keep the lowest bits of rcu_dynticks_snap() and expand a bit the
  printing size accordingly.

---
git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/context-tracking-v2

HEAD: 0364ddb8830db4d4b78f7bfd9344e12d22e9cd32

Thanks,
	Frederic
---

Frederic Weisbecker (21):
      context_tracking: Remove unused context_tracking_in_user()
      rcu: Set rcu_idle_enter() as noinstr
      rcu: Add a note about noinstr VS unsafe eqs functions
      context_tracking: Add a note about noinstr VS unsafe context tracking functions
      context_tracking: Rename __context_tracking_enter/exit() to __ct_user_enter/exit()
      context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
      context_tracking: Rename context_tracking_enter/exit() to ct_user_enter/exit()
      context_tracking: Rename context_tracking_cpu_set() to ct_cpu_track_user()
      context_tracking: Split user tracking Kconfig
      context_tracking: Take idle eqs entrypoints over RCU
      context_tracking: Take IRQ eqs entrypoints over RCU
      context_tracking: Take NMI eqs entrypoints over RCU
      rcu/context-tracking: Remove rcu_irq_enter/exit()
      rcu/context_tracking: Move dynticks counter to context tracking
      rcu/context_tracking: Move dynticks_nesting to context tracking
      rcu/context_tracking: Move dynticks_nmi_nesting to context tracking
      rcu/context-tracking: Move deferred nocb resched to context tracking
      rcu/context-tracking: Move RCU-dynticks internal functions to context_tracking
      rcu/context-tracking: Remove unused and/or unecessary middle functions
      context_tracking: Convert state to atomic_t
      rcu/context_tracking: Merge dynticks counter and context tracking states


 .../RCU/Design/Requirements/Requirements.rst       |  10 +-
 Documentation/RCU/stallwarn.rst                    |   6 +-
 .../time/context-tracking/arch-support.txt         |   6 +-
 arch/Kconfig                                       |   8 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/kernel/entry-common.S                     |   4 +-
 arch/arm/kernel/entry-header.S                     |  12 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  |   5 +-
 arch/arm64/Kconfig                                 |   2 +-
 arch/arm64/kernel/entry-common.c                   |  14 +-
 arch/csky/Kconfig                                  |   2 +-
 arch/csky/kernel/entry.S                           |   8 +-
 arch/mips/Kconfig                                  |   2 +-
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/include/asm/context_tracking.h        |   2 +-
 arch/riscv/Kconfig                                 |   2 +-
 arch/riscv/kernel/entry.S                          |  12 +-
 arch/sparc/Kconfig                                 |   2 +-
 arch/sparc/kernel/rtrap_64.S                       |   2 +-
 arch/x86/Kconfig                                   |   4 +-
 arch/x86/mm/fault.c                                |   2 +-
 drivers/acpi/processor_idle.c                      |   5 +-
 drivers/cpuidle/cpuidle-psci.c                     |   8 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c                |   8 +-
 drivers/cpuidle/cpuidle.c                          |   9 +-
 include/linux/context_tracking.h                   |  89 ++--
 include/linux/context_tracking_irq.h               |  21 +
 include/linux/context_tracking_state.h             | 103 +++-
 include/linux/entry-common.h                       |  10 +-
 include/linux/hardirq.h                            |  12 +-
 include/linux/rcupdate.h                           |  15 +-
 include/linux/rcutiny.h                            |   6 -
 include/linux/rcutree.h                            |  15 +-
 include/linux/tracepoint.h                         |   4 +-
 init/Kconfig                                       |   4 +-
 kernel/context_tracking.c                          | 556 +++++++++++++++++++--
 kernel/cpu_pm.c                                    |   8 +-
 kernel/entry/common.c                              |  16 +-
 kernel/extable.c                                   |   4 +-
 kernel/locking/lockdep.c                           |   2 +-
 kernel/rcu/Kconfig                                 |   2 +
 kernel/rcu/rcu.h                                   |   4 -
 kernel/rcu/tree.c                                  | 476 +-----------------
 kernel/rcu/tree.h                                  |   8 -
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_plugin.h                           |  38 +-
 kernel/rcu/tree_stall.h                            |   8 +-
 kernel/rcu/update.c                                |   2 +-
 kernel/sched/core.c                                |   2 +-
 kernel/sched/idle.c                                |  10 +-
 kernel/sched/sched.h                               |   1 +
 kernel/softirq.c                                   |   4 +-
 kernel/time/Kconfig                                |  22 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/trace/trace.c                               |   8 +-
 55 files changed, 845 insertions(+), 748 deletions(-)
