Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAE590BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiHLF6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiHLF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:57:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B597A3D73
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:57:54 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C5npFU026423;
        Fri, 12 Aug 2022 05:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rkwHoRSzG/nHjuW42BRHyHiudNJwEHynkraO734LByY=;
 b=TTs3savu661U5BWmLMpyTD6J6WHsCVJY/L29ctklOLqQ2rCP7MtXm0LVlf8qMYpBBJot
 Jj6FPHZq/UN8MmQnhXkPTrNX9DOUfTGSYqRASH1RHPjGvmhAF43od0voB5S/lqqeDFZA
 +XhgOT4cUJRrVpdfD+k/O7yrAlp2ziwIEr+zzdYL509ur3Kc23+iwmA9GKoJPIyfAfE6
 6RxQyYnFIwZAb4q4UdrzEzoBtJAD8Aa8BUXnvdyOD60n9J2hNWqmant8PlypyXCaPSId
 ubtexbZp5pmYR6BO4LbSiM4VSvkmsbDnw1TpslvF3nO9c8nCfOStMkJ6UUcJNsM+thYQ AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh268455-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:26 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27C5rJPh006305;
        Fri, 12 Aug 2022 05:57:25 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh26844f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:25 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27C5an8r011037;
        Fri, 12 Aug 2022 05:57:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 3hvcmrk058-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:24 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27C5vNga34669046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 05:57:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 876617805E;
        Fri, 12 Aug 2022 05:57:23 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09ECB7805C;
        Fri, 12 Aug 2022 05:57:17 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.116.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Aug 2022 05:57:17 +0000 (GMT)
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
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v14 00/10] mm/demotion: Memory tiers and demotion
Date:   Fri, 12 Aug 2022 11:26:59 +0530
Message-Id: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eb8B3ecXpKBc7oyRRcI4apgWJ7smqh_x
X-Proofpoint-GUID: -qB0ZLjasPw167pSZVf9O6w6gCrWVuY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel has the basic memory tiering support: Inactive pages on a
higher tier NUMA node can be migrated (demoted) to a lower tier NUMA node to
make room for new allocations on the higher tier NUMA node. Frequently accessed
pages on a lower tier NUMA node can be migrated (promoted) to a higher tier NUMA
node to improve the performance.

In the current kernel, memory tiers are defined implicitly via a demotion path
relationship between NUMA nodes, which is created during the kernel
initialization and updated when a NUMA node is hot-added or hot-removed. The
current implementation puts all nodes with CPU into the highest tier, and builds the
tier hierarchy tier-by-tier by establishing the per-node demotion targets based
on the distances between nodes.

This current memory tier kernel implementation needs to be improved for several
important use cases:

* The current tier initialization code always initializes each memory-only NUMA
  node into a lower tier. But a memory-only NUMA node may have a high
  performance memory device (e.g. a DRAM-backed memory-only node on a virtual
  machine) and that should be put into a higher tier.

* The current tier hierarchy always puts CPU nodes into the top tier. But on a
  system with HBM (e.g. GPU memory) devices, these memory-only HBM NUMA nodes
  should be in the top tier, and DRAM nodes with CPUs are better to be placed
  into the next lower tier.

* Also because the current tier hierarchy always puts CPU nodes into the top
  tier, when a CPU is hot-added (or hot-removed) and triggers a memory node from
  CPU-less into a CPU node (or vice versa), the memory tier hierarchy gets
  changed, even though no memory node is added or removed. This can make the
  tier hierarchy unstable and make it difficult to support tier-based memory
  accounting.

* A higher tier node can only be demoted to nodes with shortest distance on the
  next lower tier as defined by the demotion path, not any other node from any
  lower tier. This strict, demotion order does not work in all use
  cases (e.g. some use cases may want to allow cross-socket demotion to another
  node in the same demotion tier as a fallback when the preferred demotion node
  is out of space), and has resulted in the feature request for an interface to
  override the system-wide, per-node demotion order from the userspace. This
  demotion order is also inconsistent with the page allocation fallback order
  when all the nodes in a higher tier are out of space: The page allocation can
  fall back to any node from any lower tier, whereas the demotion order doesn't
  allow that.

This patch series make the creation of memory tiers explicit under
the control of device driver.

Memory Tier Initialization
==========================

Linux kernel presents memory devices as NUMA nodes and each memory device is of
a specific type. The memory type of a device is represented by its abstract 
distance. A memory tier corresponds to a range of abstract distance. This allows
for classifying memory devices with a specific performance range into a memory
tier.

By default, all memory nodes are assigned to the default tier with
abstract distance 512.

A device driver can move its memory nodes from the default tier. For example,
PMEM can move its memory nodes below the default tier, whereas GPU can move its
memory nodes above the default tier.

The kernel initialization code makes the decision on which exact tier a memory
node should be assigned to based on the requests from the device drivers as well
as the memory device hardware information provided by the firmware.

Hot-adding/removing CPUs doesn't affect memory tier hierarchy.

Changes from v13
* Address review feedback.
* Add path dropping memtier from struct memory_dev_type

Changes from v12
* Fix kernel crash on module unload
* Address review feedback.
* Add node_random patch to this series based on review feedback

Changes from v11:
* smaller abstract distance imply faster(higher) memory tier.

Changes from v10:
* rename performance level to abstract distance
* Thanks to all the good feedback from Huang, Ying <ying.huang@intel.com>.
  Updated the patchset to cover most of the review feedback.

Changes from v9:
* Use performance level for initializing memory tiers.

Changes from v8:
* Drop the sysfs interface patches and  related documentation changes.

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



Aneesh Kumar K.V (9):
  mm/demotion: Add support for explicit memory tiers
  mm/demotion: Move memory demotion related code
  mm/demotion: Add hotplug callbacks to handle new numa node onlined
  mm/demotion/dax/kmem: Set node's abstract distance to
    MEMTIER_DEFAULT_DAX_ADISTANCE
  mm/demotion: Build demotion targets based on explicit memory tiers
  mm/demotion: Add pg_data_t member to track node memory tier details
  mm/demotion: Drop memtier from memtype
  mm/demotion: Update node_is_toptier to work with memory tiers
  lib/nodemask: Optimize node_random for nodemask with single NUMA node

Jagdish Gediya (1):
  mm/demotion: Demote pages according to allocation fallback order

 drivers/dax/kmem.c           |  42 ++-
 include/linux/memory-tiers.h |  99 ++++++
 include/linux/migrate.h      |  15 -
 include/linux/mmzone.h       |   3 +
 include/linux/node.h         |   5 -
 include/linux/nodemask.h     |  15 +-
 mm/Makefile                  |   1 +
 mm/huge_memory.c             |   1 +
 mm/memory-tiers.c            | 645 +++++++++++++++++++++++++++++++++++
 mm/migrate.c                 | 453 +-----------------------
 mm/mprotect.c                |   1 +
 mm/vmscan.c                  |  59 +++-
 mm/vmstat.c                  |   4 -
 13 files changed, 846 insertions(+), 497 deletions(-)
 create mode 100644 include/linux/memory-tiers.h
 create mode 100644 mm/memory-tiers.c

-- 
2.37.1

