Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB94843AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiADOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiADOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:49:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ACEC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64BF7B81640
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001B3C36AED;
        Tue,  4 Jan 2022 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641307791;
        bh=ztozpEWELE2nq3Np+6e3jT5ouaGndOf7PurQkyPjP04=;
        h=From:To:Cc:Subject:Date:From;
        b=h9tkOz9/DSXw4nd8hTe3sqQxG/Whi6UogmmrAZU8l7VUPTsLlqhjXLnzIFLQj1OT/
         vNtClaD9O3Gpu+KRsjUavQmDsC4PekSMdkBoP98r9j3uETqftaRSxeR4+TCt7kIcsX
         eo0+kWzyXOmpTbO2tC5zaGL93gkNhnaiCmGdPjx+a7cttkr/BwLDWV3AdORGrnxdBZ
         dwYplaQAFFiUJjDRGVSpglDgEXByjTWcE3bLvM8Mp993Ilbcc3PnGuZ6t2BLBXB72F
         qAYHtFsc9O0ltbpElyZO+4fGldkrlkeIIKf7SQZQhHoOmIQm3C0a3d+/Na5y7d65on
         ZvGVDE7ZZpnEw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 0/8] sched/isolation: Split housekeeping cpumask
Date:   Tue,  4 Jan 2022 15:49:36 +0100
Message-Id: <20220104144944.1278663-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To prepare for extending cpusets to control CPU isolation features
(nohz_full, rcu_nocbs, unbound timers, workqueues, kthreads affinity...),
we need to split the global housekeeping_mask to one cpumask per isolation
feature.

Doing so is quite a chunk already so I'm working on that as a standalone
patchset. Once that get merged, the next step is to finally provide a
cpuset interface for one of these isolation features: rcu_nocb could
be interesting to handle first as nohz_full depends on it.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	isolation/split

HEAD: 2c07a16ff50d1e722babee28b926d70522e6bd3e

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
 kernel/rcu/tree_plugin.h         |   2 +-
 kernel/sched/core.c              |  12 +--
 kernel/sched/fair.c              |  10 +--
 kernel/sched/isolation.c         | 162 +++++++++++++++++++++++++--------------
 kernel/sched/topology.c          |   8 +-
 kernel/watchdog.c                |   2 +-
 kernel/workqueue.c               |   4 +-
 net/core/net-sysfs.c             |   6 +-
 19 files changed, 180 insertions(+), 124 deletions(-)
