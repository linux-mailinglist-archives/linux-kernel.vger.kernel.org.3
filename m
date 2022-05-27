Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815585362C4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352366AbiE0MlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348285AbiE0Mjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:39:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044960056
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:26:42 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RBquwV029471;
        Fri, 27 May 2022 12:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JblZ3n6rUD2DYRD5q3wXgP0A41UUGBVDh5m8Ta46bVE=;
 b=owXhvYk/hQHb9eVuFH5ONGdXlxJAdYcJI6DtHSKubaO7SD31ki7BQHBMRce60bYCbfHQ
 d5FiBXsNcqeDByMLyx5/2dmSq2TJvV+1wPhtlbYNgHHtshHMv+JgxbmkjMC+e/j6fkxE
 25qhKzydLHxie5tFAPAmn19NAlY/51bUUOr9B5Ad7NLg8KZlKpUWxPMH8C+BIWCjs6sK
 gda5R9PVPf+fSwwMzDJieP9kb7INGYYhx4KnFPWEqDmq14unmJxhEb0Idpc5OljS6BhM
 atsJMnkjz2ord1cMLdjze8Q5HGsIHuYeHIteiVoFsgin7fGpn0KXIKYnd+SwWysYiNFh dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gax5mrmjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:27 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RBtZix009166;
        Fri, 27 May 2022 12:26:26 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gax5mrmhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:26 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RCKV7Y004717;
        Fri, 27 May 2022 12:26:24 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 3gaas1ew05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:24 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RCQNOi22282558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 12:26:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD017AE05C;
        Fri, 27 May 2022 12:26:23 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC0EBAE05F;
        Fri, 27 May 2022 12:26:16 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.91.191])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 May 2022 12:26:16 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
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
Subject: [RFC PATCH v4 0/7] mm/demotion: Memory tiers and demotion
Date:   Fri, 27 May 2022 17:55:21 +0530
Message-Id: <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gCMUiQZIEMAxn156Nkfu96gvDUp4b_Jo
X-Proofpoint-ORIG-GUID: TDl52CwLXDlW7fdhEOk6Q1uls_smGEKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2205270057
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
default_rank  max_tier  memtier1  power  uevent
:/sys/devices/system/memtier$ cat default_rank 
200
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
default_rank  max_tier  memtier1  power  uevent
:/sys/devices/system/node# echo 2 > node1/memtier 
:/sys/devices/system/node# 
:/sys/devices/system/node# ls ../memtier/
default_rank  max_tier  memtier1  memtier2  power  uevent
:/sys/devices/system/node# cat node1/memtier 
2
:/sys/devices/system/node# 
:/sys/devices/system/node# cat ../memtier/memtier2/rank 
300
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
default_rank  max_tier  memtier1  power  uevent
:/sys/devices/system/node# 

The above also resulted in removal of memtier2 which was created in the earlier step.


Changelog
----------

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


Aneesh Kumar K.V (2):
  mm/demotion: Add support to associate rank with memory tier
  mm/demotion: Add support for removing node from demotion memory tiers

Jagdish Gediya (5):
  mm/demotion: Add support for explicit memory tiers
  mm/demotion: Expose per node memory tier to sysfs
  mm/demotion: Build demotion targets based on explicit memory tiers
  mm/demotion/dax/kmem: Set node's memory tier to MEMORY_TIER_PMEM
  mm/demotion: Demote pages according to allocation fallback order

 drivers/base/node.c     |  43 +++
 drivers/dax/kmem.c      |   4 +
 include/linux/migrate.h |  39 ++-
 mm/Kconfig              |  11 +
 mm/migrate.c            | 756 ++++++++++++++++++++++++++--------------
 mm/vmscan.c             |  38 +-
 mm/vmstat.c             |   5 -
 7 files changed, 590 insertions(+), 306 deletions(-)

-- 
2.36.1

