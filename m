Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9848655464B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350870AbiFVI12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352553AbiFVI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:27:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8152C38BF8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:26:57 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M8KFKf021259;
        Wed, 22 Jun 2022 08:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+uvqO3uOGXl1N0qNyonbdqlIe1JLDFIvQPdGy6oSce0=;
 b=juHexkzqEbFwsfcViaymZk5nQ4Z7BsGSB4YqqC6NP3llCB8JS5F/U6AYpGRycrbnXaPU
 DPs97b4jNQwHoMuUd0z4PMtOC+Ap0dy7pftrWOfAo/FJtk9cboEMMiCbebSHVqicGasQ
 MRspj+GaWdNnqHjJc0bxeXyX6ie5V8q8RPqaPMvr7+xdxRwXotWi84s0UqIC2s95Kwn1
 d82DKDhGVsFHpMuJR8TQplyYny4VlY7fczn4iDMNG2Zqv5RAbaOLFCB4J2rWhdIYtWI4
 Q14g0DKVURn2ExQEw9zd+QJg8DX0MPqX8aa4rNJqOkrepP/q90/0cxP0IbqtQ+SiTLEX uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guyfx03xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:44 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25M8MPfX026640;
        Wed, 22 Jun 2022 08:26:43 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guyfx03wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:43 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25M8KNGN009306;
        Wed, 22 Jun 2022 08:26:41 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3gs6b9s9s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:41 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25M8Qegc37814528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 08:26:40 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 764446E058;
        Wed, 22 Jun 2022 08:26:40 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6C8C6E053;
        Wed, 22 Jun 2022 08:26:34 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.69.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 08:26:34 +0000 (GMT)
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
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v7 11/12] mm/demotion: Add documentation for memory tiering
Date:   Wed, 22 Jun 2022 13:55:12 +0530
Message-Id: <20220622082513.467538-12-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wc0LkNisrFRBrGbSbdq50BilpnP63nN9
X-Proofpoint-ORIG-GUID: SaxXRN5USOunLuMoUCIsPPvqZmoeL63t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_11,2022-06-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagdish Gediya <jvgediya@linux.ibm.com>

All N_MEMORY nodes are divided into 3 memoty tiers with tier ID value
MEMORY_TIER_HBM_GPU, MEMORY_TIER_DRAM and MEMORY_TIER_PMEM. By default,
all nodes are assigned to default memory tier.

Demotion path for all N_MEMORY nodes is prepared based on the tier ID value
of memory tiers.

This patch adds documention for memory tiering introduction, its sysfs
interfaces and how demotion is performed based on memory tiers.

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/memory-tiering.rst         | 182 ++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/memory-tiering.rst

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index c21b5823f126..3f211cbca8c3 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -32,6 +32,7 @@ the Linux memory management.
    idle_page_tracking
    ksm
    memory-hotplug
+   memory-tiering
    nommu-mmap
    numa_memory_policy
    numaperf
diff --git a/Documentation/admin-guide/mm/memory-tiering.rst b/Documentation/admin-guide/mm/memory-tiering.rst
new file mode 100644
index 000000000000..142c36651f5d
--- /dev/null
+++ b/Documentation/admin-guide/mm/memory-tiering.rst
@@ -0,0 +1,182 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _admin_guide_memory_tiering:
+
+===========
+Memory tiers
+============
+
+This document describes explicit memory tiering support along with
+demotion based on memory tiers.
+
+Introduction
+============
+
+Many systems have multiple types of memory devices e.g. GPU, DRAM and
+PMEM. The memory subsystem of these systems can be called a memory
+tiering system because the performance of the different types of
+memory is different. Memory tiers are defined based on the hardware
+capabilities of memory nodes. Each memory tier is assigned a tier ID
+value that determines the memory tier position in demotion order.
+
+The memory tier assignment of each node is independent of each
+other. Moving a node from one tier to another tier doesn't affect
+the tier assignment of any other node.
+
+Memory tiers are used to build the demotion targets for nodes. A node
+can demote its pages to any node of any lower tiers.
+
+Memory tier rank
+=================
+
+Memory nodes are divided into 3 types of memory tiers with tier ID
+value as shown based on their hardware characteristics.
+
+
+MEMORY_TIER_HBM_GPU
+MEMORY_TIER_DRAM
+MEMORY_TIER_PMEM
+
+Memory tiers initialization and (re)assignments
+===============================================
+
+By default, all nodes are assigned to the memory tier with the default tier ID
+DEFAULT_MEMORY_TIER which is 200 (MEMORY_TIER_DRAM). The memory tier of
+the memory node can be either modified through sysfs or from the driver. On
+hotplug, the memory tier with default tier ID is assigned to the memory node.
+
+
+Sysfs interfaces
+================
+
+Nodes belonging to specific tier can be read from,
+/sys/devices/system/memtier/memtierN/nodelist (Read-Only)
+
+Where N is 0 - 2.
+
+Example 1:
+For a system where Node 0 is CPU + DRAM nodes, Node 1 is HBM node,
+node 2 is a PMEM node an ideal tier layout will be
+
+$ cat /sys/devices/system/memtier/memtier0/nodelist
+1
+$ cat /sys/devices/system/memtier/memtier1/nodelist
+0
+$ cat /sys/devices/system/memtier/memtier2/nodelist
+2
+
+Example 2:
+For a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
+nodes.
+
+$ cat /sys/devices/system/memtier/memtier0/nodelist
+cat: /sys/devices/system/memtier/memtier0/nodelist: No such file or
+directory
+$ cat /sys/devices/system/memtier/memtier1/nodelist
+0-1
+$ cat /sys/devices/system/memtier/memtier2/nodelist
+2-3
+
+Default memory tier can be read from,
+/sys/devices/system/memtier/default_tier (Read-Only)
+
+e.g.
+$ cat /sys/devices/system/memtier/default_tier
+memtier200
+
+Max memory tier ID supported can be read from,
+/sys/devices/system/memtier/max_tier (Read-Only)
+
+e.g.
+$ cat /sys/devices/system/memtier/max_tier
+400
+
+Individual node's memory tier can be read of set using,
+/sys/devices/system/node/nodeN/memtier	(Read-Write)
+
+where N = node id
+
+When this interface is written, Node is moved from the old memory tier
+to new memory tier and demotion targets for all N_MEMORY nodes are
+built again.
+
+For example 1 mentioned above,
+$ cat /sys/devices/system/node/node0/memtier
+1
+$ cat /sys/devices/system/node/node1/memtier
+0
+$ cat /sys/devices/system/node/node2/memtier
+2
+
+Additional memory tiers can be created by writing a tier ID value to this file.
+This results in a new memory tier creation and moving the specific NUMA node to
+that memory tier.
+
+Demotion
+========
+
+In a system with DRAM and persistent memory, once DRAM
+fills up, reclaim will start and some of the DRAM contents will be
+thrown out even if there is a space in persistent memory.
+Consequently, allocations will, at some point, start falling over to the slower
+persistent memory.
+
+That has two nasty properties. First, the newer allocations can end up in
+the slower persistent memory. Second, reclaimed data in DRAM are just
+discarded even if there are gobs of space in persistent memory that could
+be used.
+
+Instead of a page being discarded during reclaim, it can be moved to
+persistent memory. Allowing page migration during reclaim enables
+these systems to migrate pages from fast(higher) tiers to slow(lower)
+tiers when the fast(higher) tier is under pressure.
+
+
+Enable/Disable demotion
+-----------------------
+
+By default demotion is disabled, it can be enabled/disabled using
+below sysfs interface,
+
+$ echo 0/1 or false/true > /sys/kernel/mm/numa/demotion_enabled
+
+preferred and allowed demotion nodes
+------------------------------------
+
+Preferred nodes for a specific N_MEMORY node are the best nodes
+from the next possible lower memory tier. Allowed nodes for any
+node are all the nodes available in all possible lower memory
+tiers.
+
+Example:
+
+For a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
+nodes,
+
+node distances:
+node   0    1    2    3
+   0  10   20   30   40
+   1  20   10   40   30
+   2  30   40   10   40
+   3  40   30   40   10
+
+memory_tiers[0] = <empty>
+memory_tiers[1] = 0-1
+memory_tiers[2] = 2-3
+
+node_demotion[0].preferred = 2
+node_demotion[0].allowed   = 2, 3
+node_demotion[1].preferred = 3
+node_demotion[1].allowed   = 3, 2
+node_demotion[2].preferred = <empty>
+node_demotion[2].allowed   = <empty>
+node_demotion[3].preferred = <empty>
+node_demotion[3].allowed   = <empty>
+
+Memory allocation for demotion
+------------------------------
+
+If a page needs to be demoted from any node, the kernel 1st tries
+to allocate a new page from the node's preferred node and fallbacks to
+node's allowed targets in allocation fallback order.
+
-- 
2.36.1

