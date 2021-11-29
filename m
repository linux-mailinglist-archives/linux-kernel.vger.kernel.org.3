Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912AF4615C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhK2NIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:08:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239540AbhK2NGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:06:47 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATCm6mo015584;
        Mon, 29 Nov 2021 13:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cFY61gXIBLnkVqeoNTdaCz/txjk0zwIeNX4aRwbK9cA=;
 b=O41F8LJ61HqbI92V+4xqq7pPD0O9EVyTxdmItHI5dvxldu6NcSHfy2d6zlXKDUJS8Yk4
 3O29mzmTMNXVcQKXsOU4E2VDGN8cVCtGPvskQNKJLwHu074SUuPGp+QWelHw6/3AaIng
 I0daPphbsbs2H3kUj6Vz4WAUfj9EvC8pYFKt4BAyKW1V+30bsHNua/AlogyC1BBWNhjy
 vWXmCMzeQnkOzTyHpz3Cig1cbbBwj0NRu9RsbRBXutA0aThg2wVSO5HaMu2neHiXqrjh
 Sbk7oCP8O6jryyyKP/n6t9Jkbe8fAztIWT8ZTLwVf/77d0CNktnulV6zOCnVTzjJOK9D xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmy64gahj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:16 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATCnrNL022371;
        Mon, 29 Nov 2021 13:03:15 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmy64gagp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:15 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATD2Q37010812;
        Mon, 29 Nov 2021 13:03:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ckca94w87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATD3BmK32768354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 13:03:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6412411C05B;
        Mon, 29 Nov 2021 13:03:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2632011C054;
        Mon, 29 Nov 2021 13:03:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 13:03:11 +0000 (GMT)
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
Subject: [PATCH v2 3/3] topology/sysfs: rework book and drawer topology ifdefery
Date:   Mon, 29 Nov 2021 14:03:09 +0100
Message-Id: <20211129130309.3256168-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211129130309.3256168-1-hca@linux.ibm.com>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: caGbo-QIq2Y9SCpRztJ9-KGv2eTGuUgK
X-Proofpoint-ORIG-GUID: wyfYTiqiL71-3sb3UKkgS5e4MFl0Ju5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide default defines for the topology_book_[id|cpumask] and
topology_drawer_[id|cpumask] macros just like for each other topology
level.
This way all topology levels are handled in a similar way. Still the
the book and drawer levels are only used on s390, and also the sysfs
attributes are only created on s390. However other architectures may
opt in if wanted.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/admin-guide/cputopology.rst | 36 ++++++++++-------------
 drivers/base/topology.c                   | 12 ++++----
 include/linux/topology.h                  | 18 ++++++++++++
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index ad2238b41439..677ba1c2c820 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -8,14 +8,9 @@ to /proc/cpuinfo output of some architectures. They reside in
 Documentation/ABI/stable/sysfs-devices-system-cpu.
 
 Architecture-neutral, drivers/base/topology.c, exports these attributes.
-However, the book and drawer related sysfs files will only be created if
-CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
-
-The die and cluster hierarchy related sysfs files will only be created if an
-architecture provides the related macros as described below.
-
-CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
-where they reflect the cpu and cache hierarchy.
+However the die, cluster, book, and drawer hierarchy related sysfs files will
+only be created if an architecture provides the related macros as described
+below.
 
 For an architecture to support this feature, it must define some of
 these macros in include/asm-XXX/topology.h::
@@ -42,19 +37,18 @@ To be consistent on all architectures, include/linux/topology.h
 provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 
-1) topology_physical_package_id: -1
-2) topology_die_id: -1
-3) topology_cluster_id: -1
-4) topology_core_id: 0
-5) topology_sibling_cpumask: just the given CPU
-6) topology_core_cpumask: just the given CPU
-7) topology_cluster_cpumask: just the given CPU
-8) topology_die_cpumask: just the given CPU
-
-For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
-default definitions for topology_book_id() and topology_book_cpumask().
-For architectures that don't support drawers (CONFIG_SCHED_DRAWER) there are
-no default definitions for topology_drawer_id() and topology_drawer_cpumask().
+ 1) topology_physical_package_id: -1
+ 2) topology_die_id: -1
+ 3) topology_cluster_id: -1
+ 4) topology_core_id: 0
+ 5) topology_book_id: -1
+ 6) topology_drawer_id: -1
+ 7) topology_sibling_cpumask: just the given CPU
+ 8) topology_core_cpumask: just the given CPU
+ 9) topology_cluster_cpumask: just the given CPU
+10) topology_die_cpumask: just the given CPU
+11) topology_book_cpumask:  just the given CPU
+12) topology_drawer_cpumask: just the given CPU
 
 Additionally, CPU topology information is provided under
 /sys/devices/system/cpu and includes these files.  The internal
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 9d049724e4b4..fc24e89f9592 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -86,7 +86,7 @@ define_siblings_read_func(package_cpus, core_cpumask);
 static BIN_ATTR_RO(package_cpus, 0);
 static BIN_ATTR_RO(package_cpus_list, 0);
 
-#ifdef CONFIG_SCHED_BOOK
+#ifdef TOPOLOGY_BOOK_SYSFS
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
 define_siblings_read_func(book_siblings, book_cpumask);
@@ -94,7 +94,7 @@ static BIN_ATTR_RO(book_siblings, 0);
 static BIN_ATTR_RO(book_siblings_list, 0);
 #endif
 
-#ifdef CONFIG_SCHED_DRAWER
+#ifdef TOPOLOGY_DRAWER_SYSFS
 define_id_show_func(drawer_id);
 static DEVICE_ATTR_RO(drawer_id);
 define_siblings_read_func(drawer_siblings, drawer_cpumask);
@@ -119,11 +119,11 @@ static struct bin_attribute *bin_attrs[] = {
 #endif
 	&bin_attr_package_cpus,
 	&bin_attr_package_cpus_list,
-#ifdef CONFIG_SCHED_BOOK
+#ifdef TOPOLOGY_BOOK_SYSFS
 	&bin_attr_book_siblings,
 	&bin_attr_book_siblings_list,
 #endif
-#ifdef CONFIG_SCHED_DRAWER
+#ifdef TOPOLOGY_DRAWER_SYSFS
 	&bin_attr_drawer_siblings,
 	&bin_attr_drawer_siblings_list,
 #endif
@@ -139,10 +139,10 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_cluster_id.attr,
 #endif
 	&dev_attr_core_id.attr,
-#ifdef CONFIG_SCHED_BOOK
+#ifdef TOPOLOGY_BOOK_SYSFS
 	&dev_attr_book_id.attr,
 #endif
-#ifdef CONFIG_SCHED_DRAWER
+#ifdef TOPOLOGY_DRAWER_SYSFS
 	&dev_attr_drawer_id.attr,
 #endif
 	NULL
diff --git a/include/linux/topology.h b/include/linux/topology.h
index d52be69037db..a6e201758ae9 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -186,6 +186,12 @@ static inline int cpu_to_mem(int cpu)
 #if defined(topology_cluster_id) && defined(topology_cluster_cpumask)
 #define TOPOLOGY_CLUSTER_SYSFS
 #endif
+#if defined(topology_book_id) && defined(topology_book_cpumask)
+#define TOPOLOGY_BOOK_SYSFS
+#endif
+#if defined(topology_drawer_id) && defined(topology_drawer_cpumask)
+#define TOPOLOGY_DRAWER_SYSFS
+#endif
 
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
@@ -199,6 +205,12 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
+#ifndef topology_book_id
+#define topology_book_id(cpu)			((void)(cpu), -1)
+#endif
+#ifndef topology_drawer_id
+#define topology_drawer_id(cpu)			((void)(cpu), -1)
+#endif
 #ifndef topology_sibling_cpumask
 #define topology_sibling_cpumask(cpu)		cpumask_of(cpu)
 #endif
@@ -211,6 +223,12 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_die_cpumask
 #define topology_die_cpumask(cpu)		cpumask_of(cpu)
 #endif
+#ifndef topology_book_cpumask
+#define topology_book_cpumask(cpu)		cpumask_of(cpu)
+#endif
+#ifndef topology_drawer_cpumask
+#define topology_drawer_cpumask(cpu)		cpumask_of(cpu)
+#endif
 
 #if defined(CONFIG_SCHED_SMT) && !defined(cpu_smt_mask)
 static inline const struct cpumask *cpu_smt_mask(int cpu)
-- 
2.32.0

