Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDAE4A99A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbiBDNEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbiBDNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:04:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9B775CE222D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E0EC004E1;
        Fri,  4 Feb 2022 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643979883;
        bh=EcktkasdKOYWGAEp171LFY4lFvjNFhDRlbA3YnZVi7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Ft2MWyz0uUulWH9jfx7/+oiCuVC005D5eqcdJMeI8hkjOO5tevKwnxT2avh9D+uOo
         eBepSfkpxA5Lu+T6O0I8UBm5Ns37Rxe8OaqL6FiaF6g8iEnqbSwx1c1VQSVcdv2Tfs
         HLCRk1/xrw+GbKGu2nPNsRAqGOoQ1JKzF/G7QejaTYY80TM1S9uUNjzglVsMipIOMa
         1huPe0IH6hLZKwAdRt9+zDyWcn/23jadwIwptl11H7eq9UVvOiyvVe8kX72VmrPDRn
         sJWuLy3xjiHEewuwqstZoytUB+pgdoLcvje4M3INw9AnHXDPHVxFyxQ2Tseh1DfP3z
         DObckrba8kCHw==
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
Subject: [PATCH 0/8] sched/isolation: Split housekeeping cpumask v2
Date:   Fri,  4 Feb 2022 14:04:25 +0100
Message-Id: <20220204130433.488085-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the v2 of https://lore.kernel.org/lkml/20220104144944.1278663-1-frederic@kernel.org/

No change in this v2. Only acks and reviewed-by tags added.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	isolation/split-v2

HEAD: 31b398242699300304defda3f388cc15b314c1b0

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
