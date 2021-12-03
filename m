Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9559467F56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353927AbhLCVeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:34:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:15695 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239861AbhLCVel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:34:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237000622"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237000622"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="598116244"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2021 13:31:10 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        Michael Larabel <Michael@MichaelLarabel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Make Cluster Scheduling Configurable
Date:   Fri,  3 Dec 2021 12:32:37 -0800
Message-Id: <cover.1638563225.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cluster scheduling domain was introduced in 5.16 to help even out load
between the clusters. In a last level cache, there can be multiple 
clusters, with each cluster having its own resources and multiple CPUs
in it. With cluster scheduling, contention on cluster resource (e.g. L2
cache) can be reduced for better performance.

These patches made cluster scheduling configurable at run time and
boot time.  When system is moderately loaded, it is worthwhile to do the
extra load balancing to balance out load between the clusters to reduce
contention on cluster resources (e.g. L2 cache).  If the system is
fully utilized, load balancing among cluster is unlikely going to help
to reduce contention of resources a cluster as the cluster
is fully busy.

On a Jacobsville system with 24 Atom cores, where 4 Atom core per cluster
share an L2, we ran the mcf benchmark from very low load of 1 benchmark
copy to 24 benchmark copies on the 24 CPUs system.  We see that
throughput is boosted for medium load but there is little improvement
from cluster scheduling when the system is fully loaded.

     Improvement over baseline kernel for mcf_r
     copies         run time        base rate
     1              -0.1%           -0.2%
     6              25.1%           25.1%
     12             18.8%           19.0%
     24             0.3%            0.3%

If the system is expected to operate close to full utilization, the sys
admin could choose to turn off the cluster feature to reduce scheduler
overhead from load balancing at the cluster level.

Cluster scheduling is disabled by default for x86 hybrid CPUs in the
last patch of this series. For such asymmetric system, the system
should rely strictly on CPU priority to determine the order
of task scheduling.

Tim Chen (5):
  scheduler: Create SDTL_SKIP flag to skip topology level
  scheduler: Add SD_CLUSTER topology flag to cluster sched domain
  scheduler: Add runtime knob sysctl_sched_cluster
  scheduler: Add boot time enabling/disabling of cluster scheduling
  scheduler: Default cluster scheduling to off on x86 hybrid CPU

 .../admin-guide/kernel-parameters.txt         |  4 +
 arch/x86/kernel/smpboot.c                     | 26 +++++++
 drivers/base/arch_topology.c                  | 23 +++++-
 include/linux/sched/sd_flags.h                |  7 ++
 include/linux/sched/sysctl.h                  |  6 ++
 include/linux/sched/topology.h                |  3 +-
 include/linux/topology.h                      |  7 ++
 kernel/sched/core.c                           |  1 +
 kernel/sched/sched.h                          |  6 ++
 kernel/sched/topology.c                       | 75 ++++++++++++++++++-
 kernel/sysctl.c                               | 11 +++
 11 files changed, 163 insertions(+), 6 deletions(-)

-- 
2.20.1

