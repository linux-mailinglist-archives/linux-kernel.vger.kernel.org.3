Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359B94615C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377593AbhK2NI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:08:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241386AbhK2NGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:06:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATCqZ8R010845;
        Mon, 29 Nov 2021 13:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lQGHCViU9pMCISfrjvRnR8A+clzO3k15UFzkDOHrJsA=;
 b=rljPda3E+wIMGL2YmFTX8hNoPIOfkWFl/6Uv1nJKpEYzE5BY6ab7PmgWQY6bQB5iIo3j
 P1O3TqfaMbYIJnhzsjMdl6E19DwZYL7RRuJdsvnuF59oEfTdIqYsx13KqGG3R0naOD5V
 37A/2QOe7pqWt55vB3vzCsWpIh5uZB3zLx+g1cWi+rKSgPwKlcFsYpEeRUAxN/Y6CML0
 Y1fjeOJ/FkMhJrhaQp51rwCSTsPibqzlk9CcfsFRZ17zD0W1eZe3fPXJqef7SVfhnad+
 1F9ikaD9Kl1GPUCM6wV6S1ugyG+fDdt8STHbYZe/e7xk3nNNhOcs27FhWtd0xrCDtp8a 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmy8kr86c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:18 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATCranP015296;
        Mon, 29 Nov 2021 13:03:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmy8kr85m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATD2wq5006784;
        Mon, 29 Nov 2021 13:03:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3ckcac4vn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:15 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATD3AEl27984368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 13:03:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC47311C052;
        Mon, 29 Nov 2021 13:03:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73E1811C077;
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
Subject: [PATCH v2 1/3] topology/sysfs: export die attributes only if an architectures has support
Date:   Mon, 29 Nov 2021 14:03:07 +0100
Message-Id: <20211129130309.3256168-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211129130309.3256168-1-hca@linux.ibm.com>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F4KoeKv00nxTcSdrpelmnchXDAhgM7JP
X-Proofpoint-ORIG-GUID: VGyq4QqfdyzZQkuOF2mugbi9IvSNH1I4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_id and die_cpus topology sysfs attributes have been added with
commit 0e344d8c709f ("cpu/topology: Export die_id") and commit
2e4c54dac7b3 ("topology: Create core_cpus and die_cpus sysfs attributes").

While they are currently only used and useful for x86 they are still
present with bogus default values for all architectures. Instead of
enforcing such new sysfs attributes to all architectures, make them
only optional visible if an architecture opts in by defining both the
topology_die_id and topology_die_cpumask attributes.

This is similar to what was done when the book and drawer topology
levels were introduced: avoid useless and therefore confusing sysfs
attributes for architectures which cannot make use of them.

This should not break any existing applications, since this is a
rather new interface and applications should be able to handle also
older kernel versions without such attributes - besides that they
contain only useful information for x86.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/admin-guide/cputopology.rst | 3 +++
 drivers/base/topology.c                   | 8 ++++++++
 include/linux/topology.h                  | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index 6b62e182baf4..c68d07533c45 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -11,6 +11,9 @@ Architecture-neutral, drivers/base/topology.c, exports these attributes.
 However, the book and drawer related sysfs files will only be created if
 CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
 
+The die hierarchy related sysfs files will only be created if an architecture
+provides the related macros as described below.
+
 CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
 where they reflect the cpu and cache hierarchy.
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 8f2b641d0b8c..f079a55793ec 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -45,8 +45,10 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
 define_id_show_func(physical_package_id);
 static DEVICE_ATTR_RO(physical_package_id);
 
+#ifdef TOPOLOGY_DIE_SYSFS
 define_id_show_func(die_id);
 static DEVICE_ATTR_RO(die_id);
+#endif
 
 define_id_show_func(cluster_id);
 static DEVICE_ATTR_RO(cluster_id);
@@ -70,9 +72,11 @@ define_siblings_read_func(cluster_cpus, cluster_cpumask);
 static BIN_ATTR_RO(cluster_cpus, 0);
 static BIN_ATTR_RO(cluster_cpus_list, 0);
 
+#ifdef TOPOLOGY_DIE_SYSFS
 define_siblings_read_func(die_cpus, die_cpumask);
 static BIN_ATTR_RO(die_cpus, 0);
 static BIN_ATTR_RO(die_cpus_list, 0);
+#endif
 
 define_siblings_read_func(package_cpus, core_cpumask);
 static BIN_ATTR_RO(package_cpus, 0);
@@ -103,8 +107,10 @@ static struct bin_attribute *bin_attrs[] = {
 	&bin_attr_core_siblings_list,
 	&bin_attr_cluster_cpus,
 	&bin_attr_cluster_cpus_list,
+#ifdef TOPOLOGY_DIE_SYSFS
 	&bin_attr_die_cpus,
 	&bin_attr_die_cpus_list,
+#endif
 	&bin_attr_package_cpus,
 	&bin_attr_package_cpus_list,
 #ifdef CONFIG_SCHED_BOOK
@@ -120,7 +126,9 @@ static struct bin_attribute *bin_attrs[] = {
 
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
+#ifdef TOPOLOGY_DIE_SYSFS
 	&dev_attr_die_id.attr,
+#endif
 	&dev_attr_cluster_id.attr,
 	&dev_attr_core_id.attr,
 #ifdef CONFIG_SCHED_BOOK
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 0b3704ad13c8..8d1bdae76230 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -180,6 +180,10 @@ static inline int cpu_to_mem(int cpu)
 
 #endif	/* [!]CONFIG_HAVE_MEMORYLESS_NODES */
 
+#if defined(topology_die_id) && defined(topology_die_cpumask)
+#define TOPOLOGY_DIE_SYSFS
+#endif
+
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
 #endif
-- 
2.32.0

