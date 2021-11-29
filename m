Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA804615C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhK2NIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:08:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236522AbhK2NGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:06:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBRjLI021480;
        Mon, 29 Nov 2021 13:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yUeJTVweX2Mt0Sc1BxCm/yWY6oRs88gPvVwlEvefBd8=;
 b=qfowK5wJ7pUBHsMM5Ld2tQo6EecpRSo2nBwIk3vaH5AGL7PyDz9fum6i6s+5D8+sFdzL
 q4Zf3xoS/H0DigUwCwRuULxZJLLGUIF7sk5eMR/pkv67Zj3BMiWbJO+nM46ZrcWugs3F
 lsP1ePxgA5qzEc53L9a2qxUcWd7UuUJpuwms8Sf55vhz9LLsb85oozaEZgCwNsOw+rt+
 Gpd6S/npOzPhuSlVxRVdVRKvpv1wilOe5DJLi/+cK7JBPWmMif+Nda6Yf1+rWFtXxJS6
 UM+6gfvvQi2lYoxHsSpMMd3PhTqeFzPt1mbtS2VaGoYHm46n+V9OWLUHkt22nsCoBW44 zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmx0pt6dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:15 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATBuGqT005875;
        Mon, 29 Nov 2021 13:03:15 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmx0pt6cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:15 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATD2VmY032386;
        Mon, 29 Nov 2021 13:03:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3ckca9m24r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATD3B2E34144726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 13:03:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1152311C05B;
        Mon, 29 Nov 2021 13:03:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C719911C069;
        Mon, 29 Nov 2021 13:03:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 13:03:10 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2 2/3] topology/sysfs: export cluster attributes only if an architectures has support
Date:   Mon, 29 Nov 2021 14:03:08 +0100
Message-Id: <20211129130309.3256168-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211129130309.3256168-1-hca@linux.ibm.com>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0uOURD2lun4jZWnn0ItK-F_IuJ7Evi1K
X-Proofpoint-GUID: yXYmrGCw0U45nqKZi3Dyh3YaPiKPKlVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cluster_id and cluster_cpus topology sysfs attributes have been
added with commit c5e22feffdd7 ("topology: Represent clusters of CPUs
within a die").

They are currently only used for x86, arm64, and riscv (via generic
arch topology), however they are still present with bogus default
values for all other architectures. Instead of enforcing such new
sysfs attributes to all architectures, make them only optional visible
if an architecture opts in by defining both the topology_cluster_id
and topology_cluster_cpumask attributes.

This is similar to what was done when the book and drawer topology
levels were introduced: avoid useless and therefore confusing sysfs
attributes for architectures which cannot make use of them.

This should not break any existing applications, since this is a
new interface introduced with the v5.16 merge window.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/admin-guide/cputopology.rst | 4 ++--
 drivers/base/topology.c                   | 8 ++++++++
 include/linux/topology.h                  | 3 +++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index c68d07533c45..ad2238b41439 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -11,8 +11,8 @@ Architecture-neutral, drivers/base/topology.c, exports these attributes.
 However, the book and drawer related sysfs files will only be created if
 CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
 
-The die hierarchy related sysfs files will only be created if an architecture
-provides the related macros as described below.
+The die and cluster hierarchy related sysfs files will only be created if an
+architecture provides the related macros as described below.
 
 CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
 where they reflect the cpu and cache hierarchy.
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index f079a55793ec..9d049724e4b4 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -50,8 +50,10 @@ define_id_show_func(die_id);
 static DEVICE_ATTR_RO(die_id);
 #endif
 
+#ifdef TOPOLOGY_CLUSTER_SYSFS
 define_id_show_func(cluster_id);
 static DEVICE_ATTR_RO(cluster_id);
+#endif
 
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
@@ -68,9 +70,11 @@ define_siblings_read_func(core_siblings, core_cpumask);
 static BIN_ATTR_RO(core_siblings, 0);
 static BIN_ATTR_RO(core_siblings_list, 0);
 
+#ifdef TOPOLOGY_CLUSTER_SYSFS
 define_siblings_read_func(cluster_cpus, cluster_cpumask);
 static BIN_ATTR_RO(cluster_cpus, 0);
 static BIN_ATTR_RO(cluster_cpus_list, 0);
+#endif
 
 #ifdef TOPOLOGY_DIE_SYSFS
 define_siblings_read_func(die_cpus, die_cpumask);
@@ -105,8 +109,10 @@ static struct bin_attribute *bin_attrs[] = {
 	&bin_attr_thread_siblings_list,
 	&bin_attr_core_siblings,
 	&bin_attr_core_siblings_list,
+#ifdef TOPOLOGY_CLUSTER_SYSFS
 	&bin_attr_cluster_cpus,
 	&bin_attr_cluster_cpus_list,
+#endif
 #ifdef TOPOLOGY_DIE_SYSFS
 	&bin_attr_die_cpus,
 	&bin_attr_die_cpus_list,
@@ -129,7 +135,9 @@ static struct attribute *default_attrs[] = {
 #ifdef TOPOLOGY_DIE_SYSFS
 	&dev_attr_die_id.attr,
 #endif
+#ifdef TOPOLOGY_CLUSTER_SYSFS
 	&dev_attr_cluster_id.attr,
+#endif
 	&dev_attr_core_id.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 8d1bdae76230..d52be69037db 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -183,6 +183,9 @@ static inline int cpu_to_mem(int cpu)
 #if defined(topology_die_id) && defined(topology_die_cpumask)
 #define TOPOLOGY_DIE_SYSFS
 #endif
+#if defined(topology_cluster_id) && defined(topology_cluster_cpumask)
+#define TOPOLOGY_CLUSTER_SYSFS
+#endif
 
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
-- 
2.32.0

