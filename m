Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EDF50C1D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiDVWGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiDVWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:05:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F89156110
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:49:11 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MHnjdp025864;
        Fri, 22 Apr 2022 19:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=04STmEqe5u5BMaOs7DSkgySzGj61M92rE1OARfFQvtE=;
 b=G2MGAsS/y0h79mO20XiIlN3WLTv4vYWfnqSXUlZz8xzFAH1ADXqIytGZD1+djCU534DZ
 QlUjl4iVKSc3FneFqHocBmAhA/1qbVov9/GtgYC/G0u2FLQzciupNvMxDfSF3GFvLHma
 vcz9qFXa/5FYiHBlMgQRsyG69zIfWJsa3ERwBsvN8ROSFAqcIqqlyMFiIUDgiwCVFV2w
 sEgrpDh/ee0YXvbmCah4o0XuYoUxz62sG/PxZsVhIBuZMQ5iG3TiWO/5OaSczV/1lxjx
 xnpAo5n/9aHK0zS/g+0fpHpZ3efYt5ocCpmPIVaIiHMadhnhcde8AI3vlp79JZD23urX 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fkm5q9unv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:56:02 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MJZHwP035931;
        Fri, 22 Apr 2022 19:56:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fkm5q9unb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:56:01 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MJjMko020138;
        Fri, 22 Apr 2022 19:55:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ffne99tgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MJtuBg37749180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:55:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28D5F11C04C;
        Fri, 22 Apr 2022 19:55:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3C0811C04A;
        Fri, 22 Apr 2022 19:55:52 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.112.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 19:55:52 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 7/7] docs: numa: Add documentation for demotion
Date:   Sat, 23 Apr 2022 01:25:16 +0530
Message-Id: <20220422195516.10769-8-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195516.10769-1-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eLaW0tlhh9_-kMbPEf1AAeNqm613K_JR
X-Proofpoint-GUID: 8XX4G7vY-17mP6Mx995RZH3Xu56D4qqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=987 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for demotion mentioning about why is it
required and all the sysfs interfaces available related to
demotion.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 Documentation/admin-guide/mm/index.rst        |  1 +
 .../admin-guide/mm/numa_demotion.rst          | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/numa_demotion.rst

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index c21b5823f126..4bd0ed3de9c5 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -34,6 +34,7 @@ the Linux memory management.
    memory-hotplug
    nommu-mmap
    numa_memory_policy
+   numa_demotion
    numaperf
    pagemap
    soft-dirty
diff --git a/Documentation/admin-guide/mm/numa_demotion.rst b/Documentation/admin-guide/mm/numa_demotion.rst
new file mode 100644
index 000000000000..252be9dc0517
--- /dev/null
+++ b/Documentation/admin-guide/mm/numa_demotion.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+NUMA Demotion
+==================
+
+What is demotion required?
+============================
+
+With the advent of various new memory types, Systems have multiple
+types of memory, e.g. DRAM and PMEM (persistent memory).  The memory
+subsystem of such systems can be called memory tiering system,
+because the performance of the different types of memory are usually
+different.
+
+In a  system with some DRAM and some persistent memory, once DRAM
+fills up, reclaim will start and some of the DRAM contents will be
+thrown out to swap even if there is space in persistent memory.
+Allocations will, at some point, start falling over to the slower
+persistent memory.
+
+Instead of page being discarded during reclaim, it can be moved to
+persistent memory. Allowing page migration during reclaim enables
+these systems to migrate pages from fast tiers to slow tiers when
+the fast tier is under pressure.
+
+SYSFS interface
+======================
+
+Enable/Disable demotion
+------------------------
+
+By default demotion is disabled, it can be enabled/disabled using below
+sysfs interface,
+
+echo 0/1 or false/true > /sys/kernel/mm/numa/demotion_enabled
+
+Read system demotion targets
+-----------------------------
+cat /sys/devices/system/node/demotion_targets
+
+Kernel shows node_states[N_DEMOTION_TARGETS] when this command
+is run.
+
+Override default demotion targets
+---------------------------------
+echo <nodelist> > /sys/devices/system/node/demotion_targets
+
+If nodelist is valid and subset of N_MEMORY then
+node_states[N_DEMOTION_TARGETS] is set to this new nodelist, and
+kernel builds the new demotion list based on it.
+
+Read per node demotion targets
+-------------------------------
+cat /sys/devices/system/node/nodeX/demotion_targets
+
+It shows per node demotion targets configured by kernel.
-- 
2.35.1

