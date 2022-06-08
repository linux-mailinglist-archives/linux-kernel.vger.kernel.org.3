Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B635432D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbiFHOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbiFHOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:41:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D46146777
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 779E7B827F3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D11C341C4;
        Wed,  8 Jun 2022 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654699244;
        bh=tSO7B/Wo4Xenv8wh6eVt8n6/MW3j5fTGvztsupDFeHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=e3wja00bczAKsAp74qWA+xyTUHHP1MuH75L2PxltGC9AmsMHgkRlVskF8qem3PS+i
         4Hr28VRTok3SmaMZt2ncVjCGsMys7vnW1t8Ks/ss6mSbSdG3nW78prHVrl7EAvx0gl
         Rz61o5/2cV/7l47bBGV8yDrVKwoGXBf/9pXPBNaI3H6IuJ49riQAnasEt1dSLyjeoM
         ZN45ZbJXMu9BNmRbRSr0ExZB0egwVsljI7YGrsDUv9LrqdZpZI7v2/viQimxh7p6Y5
         BAzSTWSW+0SrL0EvWWYIXJmAM6McAf84zDuAOSFfsQGdF/tKLaU6aS+Ap/mni0NJPo
         4cy4SIjcQwyvQ==
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
Subject: [PATCH 00/20] rcu/context-tracking: Merge RCU eqs-dynticks counter to context tracking v4
Date:   Wed,  8 Jun 2022 16:40:17 +0200
Message-Id: <20220608144037.1765000-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No big issue reported or reviewed in the last take.
Changes in this version:

* Dropped noinstr related "fixes" as it's worth a whole patchset of its
  own. Just comment on why some context tracking functions are not going
  to be fixed (because they are obsolete).

* Fixed several build splats reported by the kernel test robot

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/context-tracking-v4

HEAD: 82e4a1998ec3a58b865249c6015d3ee9b94e3004

Thanks,
	Frederic
---

Frederic Weisbecker (20):
      context_tracking: Remove unused context_tracking_in_user()
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
 kernel/context_tracking.c                          | 618 +++++++++++++++++++--
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
 56 files changed, 923 insertions(+), 756 deletions(-)
