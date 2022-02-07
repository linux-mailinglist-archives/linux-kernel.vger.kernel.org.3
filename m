Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B114AC4D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386646AbiBGQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244449AbiBGP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:59:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE7AC0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:59:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DEF69CE112B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC39C004E1;
        Mon,  7 Feb 2022 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644249559;
        bh=j0kGUyDUJw033HV2Z4CEEwVfMYvpFRqUcwyRnWBDtrc=;
        h=From:To:Cc:Subject:Date:From;
        b=mKFQ4Sqh0RBAB3CXtg3vGxy7L1ppdm/Klcx9NE4tGGo88N54X4PHKGwHgMeaM0QYU
         CjrdEhNMbxB7li2mh/RMHWJ5jXRdtEPjspxh+sS6Sa691I0oJwNlKCHICOs/71tq0P
         HDcMojaMtTlkJeRZkbOl2ms9YeWDC8FlYg7CDHQQMhqSgcD5t2EfL0M2Rx5tgzvjK1
         PmQXD3zNaRkRuFs8dPN9+u9uK8Yn7j7uKphob/6wPk05DTl37ZCx3d9oaK6rsn3V6f
         lKURCyNdQZGztT/x8As0JB1fmETj01t8zx/OYoMFeRvUYHKcI5Q1izMGzmpse6G9R3
         U3s0sL1C5fYdA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 0/8] sched/isolation: Split housekeeping cpumask v3
Date:   Mon,  7 Feb 2022 16:59:02 +0100
Message-Id: <20220207155910.527133-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a build fix in "sched/isolation: Use single feature type while
							referring to housekeeping cpumask"
because I forgot to convert HK_FLAG_RCU to HK_TYPE_RCU.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	isolation/split-v3

HEAD: 1050d7e05a8ce89066befd77dcdc68400230d888

Thanks,
	Frederic
---

Frederic Weisbecker (8):
      pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      workqueue: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      sched/isolation: Use single feature type while referring to housekeeping cpumask
      sched/isolation: Consolidate check for housekeeping minimum service
      sched/isolation: Consolidate error handling
      sched/isolation: Fix housekeeping_mask memory leak
      sched/isolation: Split housekeeping cpumask per isolation features


 arch/x86/kernel/cpu/aperfmperf.c |   6 +-
 arch/x86/kvm/x86.c               |   2 +-
 drivers/base/cpu.c               |   2 +-
 drivers/pci/pci-driver.c         |  21 +++--
 include/linux/sched/isolation.h  |  43 ++++++-----
 kernel/cgroup/cpuset.c           |   6 +-
 kernel/cpu.c                     |   4 +-
 kernel/irq/cpuhotplug.c          |   4 +-
 kernel/irq/manage.c              |   4 +-
 kernel/kthread.c                 |   4 +-
 kernel/rcu/tasks.h               |   2 +-
 kernel/rcu/tree_plugin.h         |   6 +-
 kernel/sched/core.c              |  12 +--
 kernel/sched/fair.c              |  10 +--
 kernel/sched/isolation.c         | 162 +++++++++++++++++++++++++--------------
 kernel/sched/topology.c          |   8 +-
 kernel/watchdog.c                |   2 +-
 kernel/workqueue.c               |   4 +-
 net/core/net-sysfs.c             |   6 +-
 19 files changed, 182 insertions(+), 126 deletions(-)
