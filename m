Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD454CA978
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbiCBPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiCBPtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D5A186
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:48:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBC89B8207C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C17C004E1;
        Wed,  2 Mar 2022 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236097;
        bh=0KJEmQMfD0mkItKaL0wbwcXFL0Zc4EphzXf7C8T2G8E=;
        h=From:To:Cc:Subject:Date:From;
        b=hQJxvlx5RF5464dNX1LQjQ0fZ90fvBudjI/2K1jR8y3NAu8GCmozz15B9mbwBqLMN
         CFplBmQxOg4T9/n55V6HOxNCJYJ7PgcQuISCIdbeknEetk9j2CvHxFdbSnauIVwbak
         iv8RIBBqT7K9o9yehV5uMqpAxRhPpNIN06Xl431sTJGC6rtVMJh/HkKNdV6EzepsIR
         UylegeXaZQ20mWcEV52Z2h43IaOrjdH8XZan2Ie1fYkmpRV4fB0Grde2GfUCOPGBCD
         nrvSCNWgWhCbpQs0be+uNNzg8wSP0QdxXJrIykhZkU+ZECqBukX/FDC22WF/RiThUd
         odVUSdV7XrB7Q==
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
Subject: [PATCH 00/19] rcu/context-tracking: Merge RCU eqs-dynticks counter to context tracking
Date:   Wed,  2 Mar 2022 16:47:51 +0100
Message-Id: <20220302154810.42308-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/context-tracking

HEAD: e4eaff86ec91c1cbde9a113cf5232dac9f897337

Thanks,
	Frederic
---

Frederic Weisbecker (19):
      context_tracking: Rename __context_tracking_enter/exit() to __ct_user_enter/exit()
      context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
      context_tracking: Rename context_tracking_enter/exit() to ct_user_enter/exit()
      context_tracking: Rename context_tracking_cpu_set() to context_tracking_cpu_track_user()
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
      rcu/context-tracking: Use accessor for dynticks counter value
      rcu/context_tracking: Merge dynticks counter and context tracking states
      context_tracking: Exempt CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK from non-active tracking


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
 drivers/cpuidle/cpuidle.c                          |   9 +-
 include/linux/context_tracking.h                   |  81 ++--
 include/linux/context_tracking_irq.h               |  21 +
 include/linux/context_tracking_state.h             |  92 +++-
 include/linux/entry-common.h                       |  10 +-
 include/linux/hardirq.h                            |  12 +-
 include/linux/rcupdate.h                           |   7 +-
 include/linux/rcutiny.h                            |   6 -
 include/linux/rcutree.h                            |  15 +-
 include/linux/tracepoint.h                         |   4 +-
 init/Kconfig                                       |   4 +-
 kernel/context_tracking.c                          | 526 +++++++++++++++++++--
 kernel/cpu_pm.c                                    |   8 +-
 kernel/entry/common.c                              |  16 +-
 kernel/extable.c                                   |   4 +-
 kernel/locking/lockdep.c                           |   2 +-
 kernel/rcu/Kconfig                                 |   2 +
 kernel/rcu/rcu.h                                   |   4 -
 kernel/rcu/tree.c                                  | 478 ++-----------------
 kernel/rcu/tree.h                                  |   8 -
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_plugin.h                           |  36 +-
 kernel/rcu/tree_stall.h                            |   7 +-
 kernel/rcu/update.c                                |   2 +-
 kernel/sched/core.c                                |   2 +-
 kernel/sched/idle.c                                |  11 +-
 kernel/softirq.c                                   |   4 +-
 kernel/time/Kconfig                                |  22 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/trace/trace.c                               |   8 +-
 53 files changed, 793 insertions(+), 734 deletions(-)
