Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ED250C136
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiDVVkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiDVVkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:40:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA0112C425
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:47:24 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MGIOlB005400;
        Fri, 22 Apr 2022 19:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zueQxn5wmtXzK/d/kaHamAzWXXunQfqUIn/SfJ/Zz9o=;
 b=WTRAjaFc4FrIIAQtiJkQdYGpJz1VYoPRLTd22JLVe+L2jBFsIW0K7MWLKpgKN6Um17Et
 h5Oc38pFGLePU9RGwtMKfFblSfVnlvpvdKHV7+FAjPYvuoa+apR5MUR3FmjSjVPTaGcl
 Q9rLgYZo9zy3h5auQE/Vzy+gHRt5Kaym+mvX4iU23EB0p1sRgdBaK6b3vQSzy8iPN6Wr
 oO40JjDRm9cIycE5iCw9QR+i7KGGYwWmHG5Zw7avKKxafhFavdbiZVkTo4/n53h4XhGN
 vQ0nnMyEfFS3tHyAhX+Za1DMZ42VXcdlfe8WtXXS41pMTc4mJCeELw1nVmTnKcqkoYpW 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjyk5rk5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:32 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MJlqv0018348;
        Fri, 22 Apr 2022 19:55:31 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjyk5rk4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:31 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MJjQqR008387;
        Fri, 22 Apr 2022 19:55:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3ffne97tcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MJtPLS39846256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:55:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCC8911C04C;
        Fri, 22 Apr 2022 19:55:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B7BD11C04A;
        Fri, 22 Apr 2022 19:55:22 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.112.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 19:55:22 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 0/7] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
Date:   Sat, 23 Apr 2022 01:25:09 +0530
Message-Id: <20220422195516.10769-1-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7GISJtRrRcVwaEfUzCFfP1NAJuhaJgm6
X-Proofpoint-GUID: ABKT1wf6ZgR7Z4Ge1D3y2ckDJUeP4RUg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=901 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
NUMA node which are N_MEMORY and slow memory(persistent memory)
only NUMA node which are also N_MEMORY. As the current demotion
target finding algorithm works based on N_MEMORY and best distance,
it will choose DRAM only NUMA node as demotion target instead of
persistent memory node on such systems. If DRAM only NUMA node is
filled with demoted pages then at some point new allocations can
start falling to persistent memory, so basically cold pages are in
fast memor (due to demotion) and new pages are in slow memory, this
is why persistent memory nodes should be utilized for demotion and
dram node should be avoided for demotion so that they can be used
for new allocations.

Current implementation can work fine on the system where the memory
only numa nodes are possible only for persistent/slow memory but it
is not suitable for the like of systems mentioned above.

This patch series introduces the new node state N_DEMOTION_TARGETS,
which is used to distinguish the nodes which can be used as demotion
targets, node_states[N_DEMOTION_TARGETS] is used to hold the list of
nodes which can be used as demotion targets.

node state N_DEMOTION_TARGETS is also set from the dax kmem driver,
certain type of memory which registers through dax kmem (e.g. HBM)
may not be the right choices for demotion so in future they should
be distinguished based on certain attributes and dax kmem driver
should avoid setting them as N_DEMOTION_TARGETS, however current
implementation also doesn't distinguish any  such memory and it
considers all N_MEMORY as demotion targets so this patch series
doesn't modify the current behavior.

below command can be used to view the available demotion targets in
the system,

$ cat /sys/devices/system/node/demotion_targets

This patch series sets N_DEMOTION_TARGET from dax device kmem driver,
It may be possible that some memory node desired as demotion target
is not detected in the system from dax-device kmem probe path. It is
also possible that some of the dax-devices are not preferred as
demotion target e.g. HBM, for such devices, node shouldn't be set to
N_DEMOTION_TARGETS, so support is also added to set the demotion
target list from user space so that default behavior can be overridden
to avoid or add specific node to demotion targets manually.

Override the demotion targets in the system (which sets the
node_states[N_DEMOTION_TARGETS] in kernel),
$ echo <node list> > /sys/devices/system/node/demotion_targets

As by default node attributes under /sys/devices/system/node/ are read-
only, support is added to write node_states[] via sysfs so that
node_states[N_DEMOTION_TARGETS] can be modified from user space via
sysfs.

It is also helpful to know per node demotion target path prepared by
kernel to understand the demotion behaviour during reclaim, so this
patch series also adds a /sys/devices/system/node/nodeX/demotion_targets
interface to view per-node demotion targets via sysfs.

Current code which sets migration targets is modified in
this patch series to avoid some of the limitations on the demotion
target sharing and to use N_DEMOTION_TARGETS only nodes while
finding demotion targets.

Changelog
----------

v2:
In v1, only 1st patch of this patch series was sent, which was
implemented to avoid some of the limitations on the demotion
target sharing, however for certain numa topology, the demotion
targets found by that patch was not most optimal, so 1st patch
in this series is modified according to suggestions from Huang
and Baolin. Different examples of demotion list comparasion
between existing implementation and changed implementation can
be found in the commit message of 1st patch.

v3:
- Modify patch 1 subject to make it more specific
- Remove /sys/kernel/mm/numa/demotion_targets interface, use
  /sys/devices/system/node/demotion_targets instead and make
  it writable to override node_states[N_DEMOTION_TARGETS].
- Add support to view per node demotion targets via sysfs

Jagdish Gediya (8):
  mm: demotion: Fix demotion targets sharing among sources
  mm: demotion: Add new node state N_DEMOTION_TARGETS
  drivers/base/node: Add support to write node_states[] via sysfs
  device-dax/kmem: Set node state as N_DEMOTION_TARGETS
  mm: demotion: Build demotion list based on N_DEMOTION_TARGETS
  mm: demotion: expose per-node demotion targets via sysfs
  docs: numa: Add documentation for demotion

 Documentation/admin-guide/mm/index.rst        |  1 +
 .../admin-guide/mm/numa_demotion.rst          | 57 +++++++++++++++
 drivers/base/node.c                           | 70 ++++++++++++++++---
 drivers/dax/kmem.c                            |  2 +
 include/linux/migrate.h                       |  1 +
 include/linux/nodemask.h                      |  1 +
 mm/migrate.c                                  | 54 ++++++++++----
 7 files changed, 162 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/numa_demotion.rst

-- 
2.35.1

