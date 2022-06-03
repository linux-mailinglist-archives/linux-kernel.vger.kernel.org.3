Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089C453CADB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiFCNqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbiFCNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:44:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED13A1AB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:44:45 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253CLWHE020315;
        Fri, 3 Jun 2022 13:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AH6mkUwA+QjCqwLZVtpQSiVa/wTru13R4bBfOxu/+tY=;
 b=MTNYJHg0s0IeyUQsVkmKQIG1l75PjXPWv7f0eGHaAlr4N12OmwQrgqNT6RH4bMwdkgWQ
 FhzII9ukDl1QkydFjaUJq9ABTplUxmkiPwvtmMJTeQqIFHg0MhJWwJC04CkE6hvcaxK8
 yxxwtfCUi6rpXZqv5uWGi6sqdEioEzArASD3xMFjd6BLZMJXBozu/lioI2fhUH6vvj8e
 jP5b6efj4XMIArTPtwTB7Ryfj1a1XohX4Keqm8aPqB9nmDoJWNiAWxGkYmQJLCVcTGbF
 xn0AehJ5slfZH+QZqUBMuYVMxdOrvmffyO6kGJPDOB47eFhWbddL4NyeH4Qg2lc+F9l7 eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfhcjjb9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:28 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253CPLLO005641;
        Fri, 3 Jun 2022 13:44:27 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfhcjjb9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:27 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253DaMt9031229;
        Fri, 3 Jun 2022 13:44:26 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 3gbcbjhj6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:26 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253DiPWX18547142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:44:25 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5FFC112067;
        Fri,  3 Jun 2022 13:44:25 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68659112064;
        Fri,  3 Jun 2022 13:44:17 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.93.173])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:44:16 +0000 (GMT)
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v5 8/9] mm/demotion: Add documentation for memory tiering
Date:   Fri,  3 Jun 2022 19:12:36 +0530
Message-Id: <20220603134237.131362-9-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dc_m-Uxzs3C13ricJFlPdqJoArj-P2aN
X-Proofpoint-GUID: kG7U20EY_9fnH35KKDdv9Uf-bO_ymnLB
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

From: Jagdish Gediya <jvgediya@linux.ibm.com>

All N_MEMORY nodes are divided into 3 memoty tiers with rank value
MEMORY_RANK_HBM_GPU, MEMORY_RANK_DRAM and MEMORY_RANK_PMEM. By default,
All nodes are assigned to memory tier with rank value MEMORY_RANK_DRAM.

Demotion path for all N_MEMORY nodes is prepared based on the rank value
of memory tiers.

This patch adds documention for memory tiering introduction, its sysfs
interfaces and how demotion is performed based on memory tiers.

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/memory-tiering.rst         | 175 ++++++++++++++++++
 2 files changed, 176 insertions(+)
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
index 000000000000..afbb9591f301
--- /dev/null
+++ b/Documentation/admin-guide/mm/memory-tiering.rst
@@ -0,0 +1,175 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _admin_guide_memory_tiering:
+
+============
+Memory tiers
+============
+
+This document describes explicit memory tiering support along with
+demotion based on memory tiers.
+
+Introduction
+============
+
+Many systems have multiple type of memory devices e.g. GPU, DRAM and
+PMEM. The memory subsystem of these systems can be called memory
+tiering system because the performance of the different types of
+memory is different. Memory tiers are defined based on hardware
+capabilities of memory nodes. Each memory tier is assigned a rank
+value that determines the memory tier position in demotion order.
+
+The memory tier assignment of each node is independent from each
+other. Moving a node from one tier to another tier doesn't affect
+the tier assignment of any other node.
+
+Memory tiers are used to build the demotion targets for nodes, a node
+can demote its pages to any node of any lower tiers.
+
+Memory tier rank
+=================
+
+Memory nodes are divided into below 3 types of memory tiers with rank value
+as shown base on their hardware characteristics.
+
+MEMORY_RANK_HBM_GPU
+MEMORY_RANK_DRAM
+MEMORY_RANK_PMEM
+
+Memory tiers initialization and (re)assignments
+===============================================
+
+By default, all nodes are assigned to memory tier with default rank
+DEFAULT_MEMORY_RANK which is 1 (MEMORY_RANK_DRAM). Memory tier of
+memory node can be either modified through sysfs or from driver. On
+hotplug, memory tier with default rank is assigned to memory node.
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
+node 2 is PMEM node an ideal tier layout will be
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
+memtier1
+
+Max memory tier can be read from,
+/sys/devices/system/memtier/max_tier (Read-Only)
+
+e.g.
+$ cat /sys/devices/system/memtier/max_tier
+3
+
+Individual node's memory tier can be read of set using,
+/sys/devices/system/node/nodeN/memtier	(Read-Write)
+
+where N = node id
+
+When this interface is written, Node is moved from old memory tier
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
+Demotion
+========
+
+In a system with DRAM and persistent memory, once DRAM
+fills up, reclaim will start and some of the DRAM contents will be
+thrown out even if there is a space in persistent memory.
+Consequently allocations will, at some point, start falling over to the slower
+persistent memory.
+
+That has two nasty properties. First, the newer allocations can end up in
+the slower persistent memory. Second, reclaimed data in DRAM are just
+discarded even if there are gobs of space in persistent memory that could
+be used.
+
+Instead of page being discarded during reclaim, it can be moved to
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
+Preffered nodes for a specific N_MEMORY nodes are best nodes
+from next possible lower memory tier. Allowed nodes for any
+node are all the node available in all possible lower memory
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
+If page needs to be demoted from any node, the kernel 1st tries
+to allocate new page from node's preferred node and fallbacks to
+node's allowed targets in allocation fallback order.
-- 
2.36.1

