Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86173564E50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiGDHIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiGDHIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:08:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C6958D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:07:58 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26475ZuK009966;
        Mon, 4 Jul 2022 07:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=65cRHjMO+R25jHNRzyQNN91kMC0LFckqowx+YeQUvg0=;
 b=lrt0XoUSGWVNs9DmgJGVijPnlzO25ABwORgftswuPgBHNeoi/inPhxqpJDIxOiMa9ZPE
 FY8g/iaWmo2rxdzk5lYUQcofYBmFPae7WGOa3UjilE3LzZIo1JqkY2Mbprk9WP91DhDk
 lGB7dX2OUu//7ueR61jbsQebUMbUb++0yxWzzeJGtVsYJ4YZL/Td6h8AxIPPXwgVXZAr
 hyp6wkoMyE1Wx1JjBaO0aSNd+ugo+AsD3I/JKi5LRvx6aCbx+Kn8rr9mnVBq024ITNMj
 3J/tEVa1ghDuErEFEEYkbJdxUGyaD6sevzOk1E98A/3kupQp/v/gxJcAiLJToDFrVEwg Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3n2kyhac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:40 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2646t5bm010950;
        Mon, 4 Jul 2022 07:07:39 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3n2kyh9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:39 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26476Dvk007161;
        Mon, 4 Jul 2022 07:07:38 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 3h2dn9hak4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26477bBV66847198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 07:07:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60144124055;
        Mon,  4 Jul 2022 07:07:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45CF9124052;
        Mon,  4 Jul 2022 07:07:30 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.74.198])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 07:07:29 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
Date:   Mon,  4 Jul 2022 12:36:00 +0530
Message-Id: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yVXy6oA2DrkBb9Cr8rmHzOyfUwTC3Xx4
X-Proofpoint-ORIG-GUID: bOvTVe0RQATQp4RyAWy7JW0pFO9zljba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel has the basic memory tiering support: Inactive
pages on a higher tier NUMA node can be migrated (demoted) to a lower
tier NUMA node to make room for new allocations on the higher tier
NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
migrated (promoted) to a higher tier NUMA node to improve the
performance.

In the current kernel, memory tiers are defined implicitly via a
demotion path relationship between NUMA nodes, which is created during
the kernel initialization and updated when a NUMA node is hot-added or
hot-removed.  The current implementation puts all nodes with CPU into
the top tier, and builds the tier hierarchy tier-by-tier by establishing
the per-node demotion targets based on the distances between nodes.

This current memory tier kernel interface needs to be improved for
several important use cases:

* The current tier initialization code always initializes
  each memory-only NUMA node into a lower tier.  But a memory-only
  NUMA node may have a high performance memory device (e.g. a DRAM
  device attached via CXL.mem or a DRAM-backed memory-only node on
  a virtual machine) and should be put into a higher tier.

* The current tier hierarchy always puts CPU nodes into the top
  tier. But on a system with HBM (e.g. GPU memory) devices, these
  memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
  with CPUs are better to be placed into the next lower tier.

* Also because the current tier hierarchy always puts CPU nodes
  into the top tier, when a CPU is hot-added (or hot-removed) and
  triggers a memory node from CPU-less into a CPU node (or vice
  versa), the memory tier hierarchy gets changed, even though no
  memory node is added or removed.  This can make the tier
  hierarchy unstable and make it difficult to support tier-based
  memory accounting.

* A higher tier node can only be demoted to selected nodes on the
  next lower tier as defined by the demotion path, not any other
  node from any lower tier.  This strict, hard-coded demotion order
  does not work in all use cases (e.g. some use cases may want to
  allow cross-socket demotion to another node in the same demotion
  tier as a fallback when the preferred demotion node is out of
  space), and has resulted in the feature request for an interface to
  override the system-wide, per-node demotion order from the
  userspace.  This demotion order is also inconsistent with the page
  allocation fallback order when all the nodes in a higher tier are
  out of space: The page allocation can fall back to any node from
  any lower tier, whereas the demotion order doesn't allow that.

* There are no interfaces for the userspace to learn about the memory
  tier hierarchy in order to optimize its memory allocations.

This patch series make the creation of memory tiers explicit under
the control of userspace or device driver.

Memory Tier Initialization
==========================

By default, all memory nodes are assigned to the default tier with
tier ID value 200.

A device driver can move up or down its memory nodes from the default
tier.  For example, PMEM can move down its memory nodes below the
default tier, whereas GPU can move up its memory nodes above the
default tier.

The kernel initialization code makes the decision on which exact tier
a memory node should be assigned to based on the requests from the
device drivers as well as the memory device hardware information
provided by the firmware.

Hot-adding/removing CPUs doesn't affect memory tier hierarchy.

Memory Allocation for Demotion
==============================
This patch series keep the demotion target page allocation logic same.
The demotion page allocation pick the closest NUMA node in the
next lower tier to the current NUMA node allocating pages from.

This will be later improved to use the same page allocation strategy
using fallback list.

Sysfs Interface:
-------------
Listing current list of memory tiers details:

:/sys/devices/system/memtier$ ls
default_tier max_tier  memtier1  power  uevent
:/sys/devices/system/memtier$ cat default_tier
memtier200
:/sys/devices/system/memtier$ cat max_tier 
400
:/sys/devices/system/memtier$ 

Per node memory tier details:

For a cpu only NUMA node:

:/sys/devices/system/node# cat node0/memtier 
:/sys/devices/system/node# echo 1 > node0/memtier 
:/sys/devices/system/node# cat node0/memtier 
:/sys/devices/system/node# 

For a NUMA node with memory:
:/sys/devices/system/node# cat node1/memtier 
1
:/sys/devices/system/node# ls ../memtier/
default_tier  max_tier  memtier1  power  uevent
:/sys/devices/system/node# echo 2 > node1/memtier 
:/sys/devices/system/node# 
:/sys/devices/system/node# ls ../memtier/
default_tier  max_tier  memtier1  memtier2  power  uevent
:/sys/devices/system/node# cat node1/memtier 
2
:/sys/devices/system/node# 

Removing a memory tier
:/sys/devices/system/node# cat node1/memtier 
2
:/sys/devices/system/node# echo 1 > node1/memtier 
:/sys/devices/system/node# 
:/sys/devices/system/node# cat node1/memtier 
1
:/sys/devices/system/node# 
:/sys/devices/system/node# ls ../memtier/
default_tier  max_tier  memtier1  power  uevent
:/sys/devices/system/node# 

The above resulted in removal of memtier2 which was created in the earlier step.

Changes from v7:
* Fix kernel crash with demotion.
* Improve documentation.

Changes from v6:
* Drop the usage of rank.
* Address other review feedback.

Changes from v5:
* Remove patch supporting N_MEMORY node removal from memory tiers. memory tiers
  are going to be used for features other than demotion. Hence keep all N_MEMORY
  nodes in memory tiers irrespective of whether they want to participate in promotion or demotion.
* Add NODE_DATA->memtier
* Rearrage patches to add sysfs files later.
* Add support to create memory tiers from userspace.
* Address other review feedback.


Changes from v4:
* Address review feedback.
* Reverse the meaning of "rank": higher rank value means higher tier.
* Add "/sys/devices/system/memtier/default_tier".
* Add node_is_toptier

v4:
Add support for explicit memory tiers and ranks.

v3:
- Modify patch 1 subject to make it more specific
- Remove /sys/kernel/mm/numa/demotion_targets interface, use
  /sys/devices/system/node/demotion_targets instead and make
  it writable to override node_states[N_DEMOTION_TARGETS].
- Add support to view per node demotion targets via sysfs

v2:
In v1, only 1st patch of this patch series was sent, which was
implemented to avoid some of the limitations on the demotion
target sharing, however for certain numa topology, the demotion
targets found by that patch was not most optimal, so 1st patch
in this series is modified according to suggestions from Huang
and Baolin. Different examples of demotion list comparasion
between existing implementation and changed implementation can
be found in the commit message of 1st patch.


Aneesh Kumar K.V (10):
  mm/demotion: Add support for explicit memory tiers
  mm/demotion: Move memory demotion related code
  mm/demotion/dax/kmem: Set node's memory tier to MEMORY_TIER_PMEM
  mm/demotion: Add hotplug callbacks to handle new numa node onlined
  mm/demotion: Build demotion targets based on explicit memory tiers
  mm/demotion: Expose memory tier details via sysfs
  mm/demotion: Add per node memory tier attribute to sysfs
  mm/demotion: Add pg_data_t member to track node memory tier details
  mm/demotion: Update node_is_toptier to work with memory tiers
  mm/demotion: Add sysfs ABI documentation

Jagdish Gediya (2):
  mm/demotion: Demote pages according to allocation fallback order
  mm/demotion: Add documentation for memory tiering

 .../ABI/testing/sysfs-kernel-mm-memory-tiers  |  61 ++
 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/memory-tiering.rst         | 192 +++++
 drivers/base/node.c                           |  42 +
 drivers/dax/kmem.c                            |   6 +-
 include/linux/memory-tiers.h                  |  72 ++
 include/linux/migrate.h                       |  15 -
 include/linux/mmzone.h                        |   3 +
 include/linux/node.h                          |   5 -
 mm/Makefile                                   |   1 +
 mm/huge_memory.c                              |   1 +
 mm/memory-tiers.c                             | 791 ++++++++++++++++++
 mm/migrate.c                                  | 453 +---------
 mm/mprotect.c                                 |   1 +
 mm/vmscan.c                                   |  59 +-
 mm/vmstat.c                                   |   4 -
 16 files changed, 1215 insertions(+), 492 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
 create mode 100644 Documentation/admin-guide/mm/memory-tiering.rst
 create mode 100644 include/linux/memory-tiers.h
 create mode 100644 mm/memory-tiers.c

-- 
2.36.1

