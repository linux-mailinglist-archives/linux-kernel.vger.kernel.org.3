Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63CE53CACB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbiFCNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbiFCNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:43:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330A39821
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:43:41 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253De4RD029658;
        Fri, 3 Jun 2022 13:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=X2XX+IusDmQgQK+YgsSoXAZ6QSfE0TF+pxVlS4DiwQE=;
 b=Ic/JJHKwgwXjMVAq8ak1ak5rWYbzN7UV4P6XrALeMVm14pxBaabJefDvHN1TDZZzohCu
 AGL1JCGXS2u/BUPRIRx7x7MpOHlJVwdaQ3t4ID9TQFVQR1k8fonZoPBjVLh23VDJfbr/
 xV/ruZ6jZpVIfVpzBZ2U0kWes/r4bm8vqGFwSOYCcU6He0BPG3/dzcm+7UDdv6V+OlH8
 HcIoZMucdWXOHymHWtEQhWvdvt1oNfpFF9Gu8Gt05VsRT3SYm0HYMgV5fbdrFBqzOaAs
 3gJd/ZQ07eweBrHxFVHfU4RAi0Fs44y95sATZXw+0VrQPBjn+P1rtYs9z7wsuFsMW312 sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfhcjjam9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:18 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253COURL032201;
        Fri, 3 Jun 2022 13:43:17 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfhcjjaky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:17 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253Da8sq004207;
        Fri, 3 Jun 2022 13:43:17 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3gbc9w1jkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:17 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253DhGFc25231638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:43:16 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45B18112065;
        Fri,  3 Jun 2022 13:43:16 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9284112067;
        Fri,  3 Jun 2022 13:43:07 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.93.173])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:43:07 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v5 0/9] mm/demotion: Memory tiers and demotion
Date:   Fri,  3 Jun 2022 19:12:28 +0530
Message-Id: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: saRfXI-2iOyLM1JLNAXxIU4OJ__vDvtW
X-Proofpoint-GUID: P4F8gkU50yAz_bKBDyjcAwA_YnPjMkM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030059
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

By default, all memory nodes are assigned to the default tier (1).
The default tier device has a rank value (200).

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
Listing current list of memory tiers and rank details:

:/sys/devices/system/memtier$ ls
default_tier max_tier  memtier1  power  uevent
:/sys/devices/system/memtier$ cat default_tier
memtier1
:/sys/devices/system/memtier$ cat max_tier 
3
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
:/sys/devices/system/node# cat ../memtier/memtier2/rank 
100
:/sys/devices/system/node# 
:/sys/devices/system/node# cat ../memtier/memtier1/rank 
200
:/sys/devices/system/node#

Removing a NUMA node from demotion:
:/sys/devices/system/node# cat node1/memtier 
2
:/sys/devices/system/node# echo none > node1/memtier 
:/sys/devices/system/node# 
:/sys/devices/system/node# cat node1/memtier 
:/sys/devices/system/node# 
:/sys/devices/system/node# ls ../memtier/
default_tier  max_tier  memtier1  power  uevent
:/sys/devices/system/node# 

The above also resulted in removal of memtier2 which was created in the earlier step.


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

Aneesh Kumar K.V (7):
  mm/demotion: Add support for explicit memory tiers
  mm/demotion: Expose per node memory tier to sysfs
  mm/demotion: Move memory demotion related code
  mm/demotion: Build demotion targets based on explicit memory tiers
  mm/demotion/dax/kmem: Set node's memory tier to MEMORY_TIER_PMEM
  mm/demotion: Add support for removing node from demotion memory tiers
  mm/demotion: Update node_is_toptier to work with memory tiers

Jagdish Gediya (2):
  mm/demotion: Demote pages according to allocation fallback order
  mm/demotion: Add documentation for memory tiering

 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/memory-tiering.rst         | 175 +++++
 drivers/base/node.c                           |  43 ++
 drivers/dax/kmem.c                            |   4 +
 include/linux/memory-tiers.h                  |  54 ++
 include/linux/migrate.h                       |  15 -
 include/linux/node.h                          |   5 -
 mm/Kconfig                                    |  11 +
 mm/Makefile                                   |   1 +
 mm/huge_memory.c                              |   1 +
 mm/memory-tiers.c                             | 706 ++++++++++++++++++
 mm/migrate.c                                  | 453 +----------
 mm/mprotect.c                                 |   1 +
 mm/vmscan.c                                   |  39 +-
 mm/vmstat.c                                   |   4 -
 15 files changed, 1017 insertions(+), 496 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/memory-tiering.rst
 create mode 100644 include/linux/memory-tiers.h
 create mode 100644 mm/memory-tiers.c

-- 
2.36.1

