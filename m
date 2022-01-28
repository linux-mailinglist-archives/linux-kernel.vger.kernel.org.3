Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FB949F120
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345463AbiA1Ci6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:38:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:37426 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345465AbiA1Ci5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643337537; x=1674873537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZAjjcmhuOaaXdqxTd5rahvmgFZbpbazWoCOMo86/akU=;
  b=Wg4ETTbxuPjjIvQ1+kxIm+Ze39qLnPINTUdS20A5iR+JnaidnFNS1wIk
   d3bzJMk5n69tdQN6kUU9UDeH9D9WZRBcSEoFCTwfUgGqbYk/aESa7TBDX
   0G0bqYrcrp2kHOy5cpVqGwWPdVTfx2AuSXA5dWjiy/EBsOL9dzjGxrNx5
   D1OcBr08pmoO4YIzKA6mrxYrgI+0M7Xu5RVDQ6yz/9Q9v8QJqsHkmCri/
   +MV5peZpRwM4U5uOC/eWiaf6ToxgJd/GqJHGyepuQhWGtxFgtWtuOBYqq
   xUaIOwms0c6ftPNw9ZuxnL3yvLjITWUMUYqcUhmgbYrWNwaSM+UUzlJYP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227696930"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="227696930"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:38:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="535948896"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:38:55 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/2] NUMA balancing: fix NUMA topology type for memory tiering system
Date:   Fri, 28 Jan 2022 10:38:41 +0800
Message-Id: <20220128023842.1946583-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the advent of various new memory types, such as Intel Optane
DCPMM, some machines will have multiple types of memory, e.g. DRAM and
PMEM (persistent memory).  The memory subsystem of these machines can
be called memory tiering system, because the performance of the
different types of memory are different.

After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
for use like normal RAM"), the PMEM could be used as the
cost-effective volatile memory in separate NUMA nodes.  In a typical
memory tiering system, there are CPUs, DRAM and PMEM in each physical
NUMA node.  The CPUs and the DRAM will be put in one logical node,
while the PMEM will be put in another (faked) logical node.

For example, the ACPI SLIT of one such system is as follows,

[000h 0000   4]                    Signature : "SLIT"    [System Locality Information Table]
[004h 0004   4]                 Table Length : 0000042C
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 59
[00Ah 0010   6]                       Oem ID : "XXXX"
[010h 0016   8]                 Oem Table ID : "XXXXXXX"
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "INTL"
[020h 0032   4]        Asl Compiler Revision : 20091013

[024h 0036   8]                   Localities : 0000000000000004
[02Ch 0044   4]                 Locality   0 : 0A 15 11 1C
[030h 0048   4]                 Locality   1 : 15 0A 1C 11
[034h 0052   4]                 Locality   2 : 11 1C 0A 1C
[038h 0056   4]                 Locality   3 : 1C 11 1C 0A

While the `numactl -H` output is as follows,

available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
node 0 size: 64136 MB
node 0 free: 5981 MB
node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
node 1 size: 64466 MB
node 1 free: 10415 MB
node 2 cpus:
node 2 size: 253952 MB
node 2 free: 253920 MB
node 3 cpus:
node 3 size: 253952 MB
node 3 free: 253951 MB
node distances:
node   0   1   2   3
  0:  10  21  17  28
  1:  21  10  28  17
  2:  17  28  10  28
  3:  28  17  28  10

In this system, there are only 2 sockets.  In each memory controller,
both DRAM and PMEM DIMMs are installed.  Although the physical NUMA
topology is simple, the logical NUMA topology becomes a little
complex.  Because both the distance(0, 1) and distance (1, 3) are less
than the distance (0, 3), it appears that node 1 sits between node 0
and node 3.  And the whole system appears to be a glueless mesh NUMA
topology type.  But it's definitely not, there is even no CPU in node 3.

This isn't a practical problem now yet.  Because the PMEM nodes (node
2 and node 3 in example system) are offlined by default during system
boot.  So init_numa_topology_type() called during system boot will
ignore them and set sched_numa_topology_type to be NUMA_DIRECT.  And
init_numa_topology_type() is only called at runtime when a CPU of a
never-onlined-before node gets plugged in.  And there's no CPU in the
PMEM nodes.  But it appears better to fix this to make the code more
robust.

To test the potential problem.  We have used a debug patch to call
init_numa_topology_type() when the PMEM node is onlined (in
__set_migration_target_nodes()).  And it's verified that
sched_numa_topology_type will be set to NUMA_GLUELESS_MESH with the
debug patch.

One possible fix is to ignore CPU-less nodes when detecting NUMA
topology type in init_numa_topology_type().  That works well for the
example system.  Is it good in general for any system with CPU-less
nodes?

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/topology.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9f26e6b651fe..ba975a29d444 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1738,7 +1738,13 @@ void init_numa_topology_type(void)
 	}
 
 	for_each_online_node(a) {
+		if (!node_state(a, N_CPU))
+			continue;
+
 		for_each_online_node(b) {
+			if (!node_state(b, N_CPU))
+				continue;
+
 			/* Find two nodes furthest removed from each other. */
 			if (node_distance(a, b) < n)
 				continue;
-- 
2.30.2

