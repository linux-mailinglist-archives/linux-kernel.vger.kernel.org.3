Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2500E52D690
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiESO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbiESO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:58:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82047D6819
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8035619C4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC86C34100;
        Thu, 19 May 2022 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972311;
        bh=0ikO8WJtv+iIAdZuEolgn4F85pH+GYjf8PmFDWGYUMY=;
        h=From:To:Cc:Subject:Date:From;
        b=NrQAHBoxm/hwymL6D9kDW6tsnESA0/owB75UKKor4XuD3qfBKj5kvCazQKEyWXR8f
         CtsSiiqNHhLlL1h5cYikzqBLwmuqPLidoRku+TQrqwlLJSqIzCZi2d6bWK6JCBFQu0
         b0wwlwYDd6Obl9CDKWbwlK65aUWllJRPm/rShoTeM5f1DaMidTgzZN4ZJ331dNMw2T
         icwF9QImsGb4VGfNpvnrqai4KeSMUN9ra78iabRwXe6ehpZlV68R7mApHZ0H4b+pGD
         2JMbY/11+y7RlEat9kEzlLapozyPyDjKRcB1BBR3P/NzJQlur4SywIy3NzZDwsMjQn
         Cv+e101x/usjA==
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
Subject: [PATCH 00/21] rcu/context-tracking: Merge RCU eqs-dynticks counter to context tracking v3
Date:   Thu, 19 May 2022 16:58:02 +0200
Message-Id: <20220519145823.618983-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rebase on latest rcu:dev

* Unconfuse Kconfig entries and introduce CONFIG_CONTEXT_TRACKING_IDLE
  along with CONFIG_CONTEXT_TRACKING_USER. CONFIG_CONTEXT_TRACKING then
  becomes the meeting point.

* Add a dependency on CONFIG_HAVE_CONTEXT_TRACKING_USER to
  CONFIG_CONTEXT_TRACKING_USER so that Kconfig warns if one of its
  selectors doesn't meet the requirement.

* Add Kconfig help comments

* Pull CONTEXT_TRACKING[_IDLE] out of CONFIG_GENERIC_CLOCKEVENTS
  dependency (fix build issue)

* Tag rcu_irq_*_irqson() as noinstr

* Move rcu_irq_work_resched() declaration from rcutree.h to rcupdate.h
  (fix build splat on rcutiny)

* Reorder eqs functions on context_tracking.c (cosmetic)

* Make CT_WARN_ON() a true stub when CONFIG_CONTEXT_TRACKING_USER=n

* Add Paul as context tracking maintainer

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/context-tracking-v3

HEAD: 6153dca9e37b244684bf472728f5c3688c5b0aca

Thanks,
	Frederic
---

Frederic Weisbecker (21):
      context_tracking: Remove unused context_tracking_in_user()
      rcu: Tag rcu_irq_*_irqson() as noinstr
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
      MAINTAINERS: Add Paul as context tracking maintainer


 .../RCU/Design/Requirements/Requirements.rst       |  10 +-
 Documentation/RCU/stallwarn.rst                    |   6 +-
 .../time/context-tracking/arch-support.txt         |   6 +-
 MAINTAINERS                                        |   1 +
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
 include/linux/context_tracking.h                   |  95 ++--
 include/linux/context_tracking_irq.h               |  21 +
 include/linux/context_tracking_state.h             | 109 +++-
 include/linux/entry-common.h                       |  10 +-
 include/linux/hardirq.h                            |  12 +-
 include/linux/rcupdate.h                           |  17 +-
 include/linux/rcutiny.h                            |   6 -
 include/linux/rcutree.h                            |   9 +-
 include/linux/tracepoint.h                         |   4 +-
 init/Kconfig                                       |   4 +-
 kernel/context_tracking.c                          | 600 +++++++++++++++++++--
 kernel/cpu_pm.c                                    |   8 +-
 kernel/entry/common.c                              |  16 +-
 kernel/extable.c                                   |   4 +-
 kernel/locking/lockdep.c                           |   2 +-
 kernel/rcu/Kconfig                                 |   2 +
 kernel/rcu/rcu.h                                   |   4 -
 kernel/rcu/tree.c                                  | 476 +---------------
 kernel/rcu/tree.h                                  |   8 -
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_plugin.h                           |  38 +-
 kernel/rcu/tree_stall.h                            |   8 +-
 kernel/rcu/update.c                                |   2 +-
 kernel/sched/core.c                                |   2 +-
 kernel/sched/idle.c                                |  10 +-
 kernel/sched/sched.h                               |   1 +
 kernel/softirq.c                                   |   4 +-
 kernel/time/Kconfig                                |  37 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/trace/trace.c                               |   8 +-
 56 files changed, 905 insertions(+), 756 deletions(-)
