Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F144B4F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352456AbiBNME3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:04:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbiBNMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:04:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963C26C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:03:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EB2N25028540;
        Mon, 14 Feb 2022 12:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=JY/CkGNpD4zyGmkew+M7iWeOszH1sOgXdOhFW7wZEOk=;
 b=rSy+SwYCd74N+hcrpgMzeKB7kRkgQA0vsujUe6kRXcseF0XcNn+1FhEKfbY1jl07M4RK
 A5x91iAX5YnplrKC6Y7xL6MbPc1TFlaeWw7Nb6lI0k7mCiPHmvUiqLRhZjULT2r2SC/y
 uVzvguKKKNSgQF67LxXpGCD+TjGDfwJzcdeaW1njolJThG9SqgvjlpXickUtKSy4+79N
 EbD4GdJra3q0XfP74eAffwWB6hZk5S5YO/svmOfzssRu884Uq56lFMIlzk1bgUdWY+V1
 XSUUZ+gZC/p1WMYzygX3CaWfznuNjuO0RzuB/Ynv7SnPjw935uXHg1wrYCJHWny+/Qs5 RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g148k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EBuOLN176293;
        Mon, 14 Feb 2022 12:03:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 3e62xd07jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aauf4noz1eyns1UladE8KhVpBpNjT+bJ+x3NE6x4u3aRzWZDgguJF8ZeusA8I/l10FLaVFLVyfr9utH4pIa5HDs60B2udrUC0HsQFwrpYRl4N/ILkThmHfGChygYcgSI/wvGEMDTEZm7W7dSmTUDR3zrB1jcDmh7XsuT+I8Nx8P9RXtJn7vbthoib+kAmTHUjMLQ0rXEZnJ4bBGeOcOznIKNsnOeg3VnK61iAQ5Ce3uSxm6HQIpQES/S5m3IyMQigTorhWCrD084o1Arz5p1vVOY1JWZZMPr7+eQNP6abv+yDcV0FeT1FRMtnBGhCniK/JVukpFqYwAyt3xT1wpQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY/CkGNpD4zyGmkew+M7iWeOszH1sOgXdOhFW7wZEOk=;
 b=EfJDk6/rlmKM83aFe7IGd1TJFbdKQqKd9zP1touas/Ihjlcn3TMPbrWpN9nehz5YBY9cAMB9w/sXYLgCmG1QSu2efxsXxhA0VP6DxHuB5fhfcnyD9v9bHcCq2A7IFqr8TKnM8AyFsZgRadlH/S6MmZvKyhtQAaiHspDiyUlmYQTB4In9/n75G3fNkD7iLubFA5ewYvDy2kUCY0jSH/Up6scjFyPF0tSNwitU148QlSz9pdO0SM0FcPcwLfngIH63RnO5F5kRW93+EUQrmWTsbua7X/c4DWpBHRL0IV+AaFdcItWHLXq8KrZMnit8qCk6o9ePTU7R5xPUUV8n0Z1cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY/CkGNpD4zyGmkew+M7iWeOszH1sOgXdOhFW7wZEOk=;
 b=AJqGNDbxgRWgbwE9QyBSK4yVScHUyVdak1Pe3oNLLND9G1Y6vvK7o3V1yDw6fOBXt0B3V0XhUFThpLSgRjtK5noWG89LEwmCAYcWgrWC53zayjqVrXbNfndHJT3SNaIm2KbEk00fnlTK5HQ+oxFZQxGXiHhml1BkjacjsnKUlGs=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 12:03:45 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:03:45 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/7] kernfs: Introduce hashed rw-sem to replace per-fs kernfs_rwsem.
Date:   Mon, 14 Feb 2022 23:03:21 +1100
Message-Id: <20220214120322.2402628-7-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214120322.2402628-1-imran.f.khan@oracle.com>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:1:14::28) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3e4dd9b-230c-4d67-efcd-08d9efb20cce
X-MS-TrafficTypeDiagnostic: MN2PR10MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4191CB0D8F247FDD2A69913CB0339@MN2PR10MB4191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSk4s1i1OrYw46TftMZM7aSMiYv4J0SvxSEl1+1qv8umLT1lbZbsByIIjNcPBaA0fmpb7I8/c2zlv/ACmmikpJ31O+lzfmwKUY1VyY02IdElIUciBTrXHkZnTShGlarKmpbY0mgRnomwha1vCVO/oCsPwhUFfR7DjKS3yAn8s43Hg8Z8/zLbSNRDnE+8stM5yoj/6GVC0UOafv9WgJij6L9lTkhJ1qUiZdH/yhXpkuSFi6xKK/LkdecZ10MSl3zWhfjeaHhSWk9sSbzfwkNlBM8nyug2MgOk6mXB69M9J/17JEkaDZqhePCGs8tUzvXcdDnckpCjyNciqZwgzZdtGVPuQ7a9DTXcj2qBgCZh2f6291CT+bAadvLsf8LbLS1+N0QTXyh0w+hMCV2RHM0udPZiYnrv9SOYNf4GCYewF0yp15A0QQpQGxq+PeoUWp3jpdDtACnqzU0z3AxgEA+OTpzPJTjgYndYNhnT9yZ/+6HO6VwypktD2DiRUqybKM8V/WSikxUCBiaTPj9g37QVinQ5zXwI3U6QY5zTPEXaNN/HVW06Z+RMVjWNqRuMp1ZwzazhA841GnTZAVhV/wDl1gGkmIhZlO1HR21aQ8CK+OjzWIgtSDPIndyGCpEkAU500LzpJ67VZpQZIIkvlrIQDO1J3c1MpRY3ZjRq23MsZHffvzggAAj4ofOqoZF2JsI6eIXd0W3fyK2irvKs6+VWHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2616005)(103116003)(5660300002)(38350700002)(1076003)(26005)(186003)(6512007)(38100700002)(2906002)(6666004)(6506007)(8676002)(36756003)(66946007)(30864003)(66556008)(66476007)(316002)(6486002)(83380400001)(8936002)(4326008)(52116002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AiodMEx///tDNmn8/yY0z8Mwot9tU0DD82vSGMgGPQbRap29lLphPFoubHb+?=
 =?us-ascii?Q?KGIOGo26560iW/87sZ1yiNOTYbjCDLU956xsVlV5LO+L6HdosCRvPykFQ6Pr?=
 =?us-ascii?Q?Ofr8xLb0LuFQv4o8ga3hjLBdh4YMB4+k6zzRuPzuoBvrgG4iYeB/XvGl929g?=
 =?us-ascii?Q?/Lhpki6NH4Wr29smCglitg+/5HO99G0PRohENLW82CHdszz5ePduXZw683PX?=
 =?us-ascii?Q?Ag5IeUNizCDT/DazHrB/96KjSzrFBnAHwAGD/O857DxqoeKHNVRN5n+l2sRt?=
 =?us-ascii?Q?zAaz5uDiRdtDJVcEqUYrgot1rXMBNFAV+tPhhyT2H6n91kwq8wbQ0TB6bpvz?=
 =?us-ascii?Q?/rF4IltIklQAqOwKapAwQ0Xnn/P+fsg41Ij40AhFveWe0HXIGWbq8CC5DUmD?=
 =?us-ascii?Q?lMRljeI/HJcvmngMq7jBqeo8+BwZ4xXe02OE5gGj7jjnqxfgUM0rCzBCp6dJ?=
 =?us-ascii?Q?c8Ey7IFapi9nxvoew+f15k5olTKgwbhTtL43DU8s47/JuZhJAhwjt3+xThhi?=
 =?us-ascii?Q?C6lrW/3/63bYTC6ndiK7aIWYNztfBDtP7zXbtf8klAiPyH18TCuESu5RxPfj?=
 =?us-ascii?Q?uTBkjdjO9AkQYTX/9SdJDyahib+9VQJ7/8yGasMPoFyMmw6bD/kGuAw/1snW?=
 =?us-ascii?Q?mYSFQMClsmUOqMRrd/lqZqZmyKnw7puxfbMb9+bNyraqlO6I+XDLJkyjoDCp?=
 =?us-ascii?Q?nrZiud1TyVbzluE5ZzV3syuuEVSUCwZvRjdF/+8EvYGCsn/sVmupIEc5tFDl?=
 =?us-ascii?Q?bg4qrosSb5U6hSCbHJieFWCGJRZl6KM01WUKmRq7jGEW+myR1mZ+OhPS9bUs?=
 =?us-ascii?Q?2pDfRvlLr08Vxpmbig+GBUy3EwQUAFSX7LubP/5s+C7/1ETpDU4j+OppBuK/?=
 =?us-ascii?Q?RUZpF3ghh2QGeJpLxonoPaSj7Ilp5OZAiwRgaaGnqvliM84t+y5YBKTvRktD?=
 =?us-ascii?Q?sT3VM77Cw5Fw0Dlh15IraLtd+vcjYUQfrFo6/N/ZKPRGdsD1FKRIPKyMCOqM?=
 =?us-ascii?Q?IFKMkcavflunTJpb0mwoveMWRH+6HOjacZg2KKNphtFHEKB8rv8IkDWoKHcp?=
 =?us-ascii?Q?s/UHD5vCj78hOJr89dI2LOW8/PXL/4+gignq6gUqNjOIEMIkeSU6mw3DWECv?=
 =?us-ascii?Q?CSv6sMTEhIDwwZxdcmE3xx/VEokiRWcwKhywNul0BXAw9z/i50y5I4QGKA9Q?=
 =?us-ascii?Q?6w3pymhOY9+l44Zl8D5/AxVQi/DRorM9Ko/d03nsZVzHc8Qd1h3zYasrm8bK?=
 =?us-ascii?Q?A1RIjsV9RRtIsFCgY9EFfPPt46uhT0/OCvA4OxMv1DVATZqrp9yfy26ayXck?=
 =?us-ascii?Q?pmySL0HLYeTWOjakL1lDxmWgnkT+kqlTqjX6yJyaKVSDFCWHORkPniGnTBUF?=
 =?us-ascii?Q?kAV4Br8myrWdX56zbMNSHFMUNEZmdrCTV9rno8If7zufW8yQso8SmDInn/Gn?=
 =?us-ascii?Q?wt1cOWSYaxFKyCBBPjOeqsWKPVcB7kCVy+MMNgKzqaG0HCFh2YtQXeGQkyRQ?=
 =?us-ascii?Q?GiXG0IDQNHOSv0IMqeKfi+/Lt36aTqS9Hu4q5KbIzZob2GysFioKqX6YGrwR?=
 =?us-ascii?Q?ZlvixlvBV31tGteRekLolqXiMNU2T/swGpFkygoRHwmZt0rl3nua6vInqlHS?=
 =?us-ascii?Q?6DDEYu1OIRCt0HMJe0U15GY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e4dd9b-230c-4d67-efcd-08d9efb20cce
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:03:45.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiVhGKuisdhnxqFLf86sX6oXz25KjGEGjVksNdXkVW5fqAvaFSbgQpMphiXrOZG75Bb7pbCbKETueLI1GXEKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140073
X-Proofpoint-GUID: dQKN3ykCevxnCO5lzK14NdjKFmzOi_qI
X-Proofpoint-ORIG-GUID: dQKN3ykCevxnCO5lzK14NdjKFmzOi_qI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a single rwsem to synchronize all operations across a kernfs
based file system (cgroup, sysfs etc.) does not scale well. The contention
around this single rwsem becomes more apparent in large scale systems with
few hundred CPUs where most of the CPUs have running tasks that are
opening, accessing or closing sysfs files at any point of time.

Using hashed rwsems in place of a per-fs rwsem, can significantly reduce
contention around per-fs rwsem and hence provide better scalability.
Moreover as these hashed rwsems are not part of kernfs_node objects we will
not see any singnificant change in memory utilization of kernfs based file
systems like sysfs, cgroupfs etc.

This patch introduces hashed rwsems that can be used in place of per-fs
rwsem. It also provides interfaces to use hashed rwsems and interfaces for
lockdep annotation as well. The next patch makes use of these interfaces
and replaces per-fs rwsem with hashed ones.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             |   1 -
 fs/kernfs/kernfs-internal.h | 560 ++++++++++++++++++++++++++++++++++++
 fs/kernfs/mount.c           |   1 +
 include/linux/kernfs.h      |   2 +
 4 files changed, 563 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index dc769301ac96b..0dac58f8091c9 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -25,7 +25,6 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
 	return atomic_read(&kn->active) >= 0;
 }
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 593395f325a18..ba89de378f240 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -19,6 +19,17 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 
+/*
+ * kernfs_rwsem locking pattern:
+ *
+ * KERNFS_RWSEM_LOCK_SELF: lock kernfs_node only.
+ * KERNFS_RWSEM_LOCK_SELF_AND_PARENT: lock kernfs_node and its parent.
+ */
+enum kernfs_rwsem_lock_pattern {
+	KERNFS_RWSEM_LOCK_SELF,
+	KERNFS_RWSEM_LOCK_SELF_AND_PARENT
+};
+
 struct kernfs_iattrs {
 	kuid_t			ia_uid;
 	kgid_t			ia_gid;
@@ -190,4 +201,553 @@ kernfs_open_node_spinlock(struct kernfs_node *kn)
 	return lock;
 }
 
+static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
+{
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->kernfs_rwsem[idx];
+}
+
+static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
+{
+	lockdep_assert_held(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_write(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_read(struct kernfs_node *kn)
+{
+	lockdep_assert_held_read(kernfs_rwsem_ptr(kn));
+}
+
+/**
+ * down_write_kernfs_rwsem_for_two_nodes() - Acquire hashed rwsem for 2 nodes
+ *
+ * @kn1: kernfs_node for which hashed rwsem needs to be taken
+ * @kn2: kernfs_node for which hashed rwsem needs to be taken
+ *
+ * In certain cases we need to acquire hashed rwsem for 2 nodes that don't have a
+ * parent child relationship. This is one of the cases of nested locking involving
+ * hashed rwsem and rwsem with lower address is acquired first.
+ */
+static inline void down_write_kernfs_rwsem_for_two_nodes(struct kernfs_node *kn1,
+							 struct kernfs_node *kn2)
+{
+	struct rw_semaphore *rwsem1 = kernfs_rwsem_ptr(kn1);
+	struct rw_semaphore *rwsem2 = kernfs_rwsem_ptr(kn2);
+
+	if (rwsem1 == rwsem2)
+		down_write_nested(rwsem1, 0);
+	else {
+		if (rwsem1 < rwsem2) {
+			down_write_nested(rwsem1, 0);
+			down_write_nested(rwsem2, 1);
+		} else {
+			down_write_nested(rwsem2, 0);
+			down_write_nested(rwsem1, 1);
+		}
+	}
+	kernfs_get(kn1);
+	kernfs_get(kn2);
+}
+
+/**
+ * up_write_kernfs_rwsem_for_two_nodes() - Release hashed rwsem for 2 nodes
+ *
+ * @kn1: kernfs_node for which hashed rwsem needs to be released
+ * @kn2: kernfs_node for which hashed rwsem needs to be released
+ *
+ * In case of nested locking, rwsem with higher address is released first.
+ */
+static inline void up_write_kernfs_rwsem_for_two_nodes(struct kernfs_node *kn1,
+						       struct kernfs_node *kn2)
+{
+	struct rw_semaphore *rwsem1 = kernfs_rwsem_ptr(kn1);
+	struct rw_semaphore *rwsem2 = kernfs_rwsem_ptr(kn2);
+
+	if (rwsem1 == rwsem2)
+		up_write(rwsem1);
+	else {
+		if (rwsem1 > rwsem2) {
+			up_write(rwsem1);
+			up_write(rwsem2);
+		} else {
+			up_write(rwsem2);
+			up_write(rwsem1);
+		}
+	}
+
+	kernfs_put(kn1);
+	kernfs_put(kn2);
+}
+
+/**
+ * down_read_kernfs_rwsem_for_two_nodes() - Acquire hashed rwsem for 2 nodes
+ *
+ * @kn1: kernfs_node for which hashed rwsem needs to be taken
+ * @kn2: kernfs_node for which hashed rwsem needs to be taken
+ *
+ * In certain cases we need to acquire hashed rwsem for 2 nodes that don't have a
+ * parent child relationship. This is one of the cases of nested locking involving
+ * hashed rwsem and rwsem with lower address is acquired first.
+ */
+static inline void down_read_kernfs_rwsem_for_two_nodes(struct kernfs_node *kn1,
+							struct kernfs_node *kn2)
+{
+	struct rw_semaphore *rwsem1 = kernfs_rwsem_ptr(kn1);
+	struct rw_semaphore *rwsem2 = kernfs_rwsem_ptr(kn2);
+
+	if (rwsem1 == rwsem2)
+		down_read_nested(rwsem1, 0);
+	else {
+		if (rwsem1 < rwsem2) {
+			down_read_nested(rwsem1, 0);
+			down_read_nested(rwsem2, 1);
+		} else {
+			down_read_nested(rwsem2, 0);
+			down_read_nested(rwsem1, 1);
+		}
+	}
+	kernfs_get(kn1);
+	kernfs_get(kn2);
+}
+
+/**
+ * up_read_kernfs_rwsem_for_two_nodes() - Release hashed rwsem for 2 nodes
+ *
+ * @kn1: kernfs_node for which hashed rwsem needs to be released
+ * @kn2: kernfs_node for which hashed rwsem needs to be released
+ *
+ * In case of nested locking, rwsem with higher address is released first.
+ */
+static inline void up_read_kernfs_rwsem_for_two_nodes(struct kernfs_node *kn1,
+						       struct kernfs_node *kn2)
+{
+	struct rw_semaphore *rwsem1 = kernfs_rwsem_ptr(kn1);
+	struct rw_semaphore *rwsem2 = kernfs_rwsem_ptr(kn2);
+
+	if (rwsem1 == rwsem2)
+		up_read(rwsem1);
+	else {
+		if (rwsem1 > rwsem2) {
+			up_read(rwsem1);
+			up_read(rwsem2);
+		} else {
+			up_read(rwsem2);
+			up_read(rwsem1);
+		}
+	}
+
+	kernfs_put(kn1);
+	kernfs_put(kn2);
+}
+
+/**
+ * down_write_kernfs_rwsem() - Acquire hashed rwsem
+ *
+ * @kn: kernfs_node for which hashed rwsem needs to be taken
+ * @ptrn: locking pattern i.e whether to lock only given node or to lock
+ *	  node and its parent as well
+ *
+ * In case of nested locking, rwsem with lower address is acquired first.
+ *
+ * Return: void
+ */
+static inline void down_write_kernfs_rwsem(struct kernfs_node *kn,
+				      enum kernfs_rwsem_lock_pattern ptrn)
+{
+	struct rw_semaphore *p_rwsem = NULL;
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+	int lock_parent = 0;
+
+	if (ptrn == KERNFS_RWSEM_LOCK_SELF_AND_PARENT && kn->parent)
+		lock_parent = 1;
+
+	if (lock_parent)
+		p_rwsem = kernfs_rwsem_ptr(kn->parent);
+
+	if (!lock_parent || rwsem == p_rwsem) {
+		down_write_nested(rwsem, 0);
+		kernfs_get(kn);
+		kn->unlock_parent = 0;
+	} else {
+		/**
+		 * In case of nested locking, locks are taken in order of their
+		 * addresses. lock with lower address is taken first, followed
+		 * by lock with higher address.
+		 */
+		if (rwsem < p_rwsem) {
+			down_write_nested(rwsem, 0);
+			down_write_nested(p_rwsem, 1);
+		} else {
+			down_write_nested(p_rwsem, 0);
+			down_write_nested(rwsem, 1);
+		}
+		kernfs_get(kn);
+		kernfs_get(kn->parent);
+		kn->unlock_parent = 1;
+	}
+}
+
+/**
+ * up_write_kernfs_rwsem() - Release hashed rwsem
+ *
+ * @kn: kernfs_node for which hashed rwsem was taken
+ *
+ * In case of nested locking, rwsem with higher address is released first.
+ *
+ * Return: void
+ */
+static inline void up_write_kernfs_rwsem(struct kernfs_node *kn)
+{
+	struct rw_semaphore *p_rwsem = NULL;
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	if (kn->unlock_parent) {
+		kn->unlock_parent = 0;
+		p_rwsem = kernfs_rwsem_ptr(kn->parent);
+		if (rwsem > p_rwsem) {
+			up_write(rwsem);
+			up_write(p_rwsem);
+		} else {
+			up_write(p_rwsem);
+			up_write(rwsem);
+		}
+		kernfs_put(kn->parent);
+	} else
+		up_write(rwsem);
+
+	kernfs_put(kn);
+}
+
+/**
+ * down_read_kernfs_rwsem() - Acquire hashed rwsem
+ *
+ * @kn: kernfs_node for which hashed rwsem needs to be taken
+ * @ptrn: locking pattern i.e whether to lock only given node or to lock
+ *	  node and its parent as well
+ *
+ * In case of nested locking, rwsem with lower address is acquired first.
+ *
+ * Return: void
+ */
+static inline void down_read_kernfs_rwsem(struct kernfs_node *kn,
+				      enum kernfs_rwsem_lock_pattern ptrn)
+{
+	struct rw_semaphore *p_rwsem = NULL;
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+	int lock_parent = 0;
+
+	if (ptrn == KERNFS_RWSEM_LOCK_SELF_AND_PARENT && kn->parent)
+		lock_parent = 1;
+
+	if (lock_parent)
+		p_rwsem = kernfs_rwsem_ptr(kn->parent);
+
+	if (!lock_parent || rwsem == p_rwsem) {
+		down_read_nested(rwsem, 0);
+		kernfs_get(kn);
+		kn->unlock_parent = 0;
+	} else {
+		/**
+		 * In case of nested locking, locks are taken in order of their
+		 * addresses. lock with lower address is taken first, followed
+		 * by lock with higher address.
+		 */
+		if (rwsem < p_rwsem) {
+			down_read_nested(rwsem, 0);
+			down_read_nested(p_rwsem, 1);
+		} else {
+			down_read_nested(p_rwsem, 0);
+			down_read_nested(rwsem, 1);
+		}
+		kernfs_get(kn);
+		kernfs_get(kn->parent);
+		kn->unlock_parent = 1;
+	}
+}
+
+/**
+ * up_read_kernfs_rwsem() - Release hashed rwsem
+ *
+ * @kn: kernfs_node for which hashed rwsem was taken
+ *
+ * In case of nested locking, rwsem with higher address is released first.
+ *
+ * Return: void
+ */
+static inline void up_read_kernfs_rwsem(struct kernfs_node *kn)
+{
+	struct rw_semaphore *p_rwsem = NULL;
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	if (kn->unlock_parent) {
+		kn->unlock_parent = 0;
+		p_rwsem = kernfs_rwsem_ptr(kn->parent);
+		if (rwsem > p_rwsem) {
+			up_read(rwsem);
+			up_read(p_rwsem);
+		} else {
+			up_read(p_rwsem);
+			up_read(rwsem);
+		}
+		kernfs_put(kn->parent);
+	} else
+		up_read(rwsem);
+
+	kernfs_put(kn);
+}
+
+static inline void kernfs_swap_rwsems(struct rw_semaphore **array, int i, int j)
+{
+	struct rw_semaphore *tmp;
+
+	tmp = array[i];
+	array[i] = array[j];
+	array[j] = tmp;
+}
+
+static inline void kernfs_sort_rwsems(struct rw_semaphore **array)
+{
+	if (array[0] > array[1])
+		kernfs_swap_rwsems(array, 0, 1);
+
+	if (array[0] > array[2])
+		kernfs_swap_rwsems(array, 0, 2);
+
+	if (array[1] > array[2])
+		kernfs_swap_rwsems(array, 1, 2);
+}
+
+/**
+ * down_write_kernfs_rwsem_rename_ns() - take hashed rwsem during
+ * rename or similar operations.
+ *
+ * @kn: kernfs_node of interest
+ * @current_parent: current parent of kernfs_node of interest
+ * @new_parent: about to become new parent of kernfs_node
+ *
+ * During rename or similar operations the parent of a node changes,
+ * and this means we will see different parents of a kernfs_node at
+ * the time of taking and releasing its or its parent's hashed rwsem.
+ * This function separately takes locks corresponding to node, and
+ * corresponding to its current and future parents (if needed).
+ *
+ * Return: void
+ */
+static inline void down_write_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
+					struct kernfs_node *current_parent,
+					struct kernfs_node *new_parent)
+{
+	struct rw_semaphore *array[3];
+
+	array[0] = kernfs_rwsem_ptr(kn);
+	array[1] = kernfs_rwsem_ptr(current_parent);
+	array[2] = kernfs_rwsem_ptr(new_parent);
+
+	if (array[0] == array[1] && array[0] == array[2]) {
+		/* All 3 nodes hash to same rwsem */
+		down_write_nested(array[0], 0);
+	} else {
+		/**
+		 * All 3 nodes are not hashing to the same rwsem, so sort the
+		 * array.
+		 */
+		kernfs_sort_rwsems(array);
+
+		if (array[0] == array[1] || array[1] == array[2]) {
+			/**
+			 * Two nodes hash to same rwsem, and these
+			 * will occupy consecutive places in array after
+			 * sorting.
+			 */
+			down_write_nested(array[0], 0);
+			down_write_nested(array[2], 1);
+		} else {
+			/* All 3 nodes hashe to different rwsems */
+			down_write_nested(array[0], 0);
+			down_write_nested(array[1], 1);
+			down_write_nested(array[2], 2);
+		}
+	}
+
+	kernfs_get(kn);
+	kernfs_get(current_parent);
+	kernfs_get(new_parent);
+}
+
+/**
+ * up_write_kernfs_rwsem_rename_ns() - release hashed rwsem during
+ * rename or similar operations.
+ *
+ * @kn: kernfs_node of interest
+ * @current_parent: current parent of kernfs_node of interest
+ * @old_parent: old parent of kernfs_node
+ *
+ * During rename or similar operations the parent of a node changes,
+ * and this means we will see different parents of a kernfs_node at
+ * the time of taking and releasing its or its parent's hashed rwsem.
+ * This function separately releases locks corresponding to node, and
+ * corresponding to its current and old parents (if needed).
+ *
+ * Return: void
+ */
+static inline void up_write_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
+					struct kernfs_node *current_parent,
+					struct kernfs_node *old_parent)
+{
+	struct rw_semaphore *array[3];
+
+	array[0] = kernfs_rwsem_ptr(kn);
+	array[1] = kernfs_rwsem_ptr(current_parent);
+	array[2] = kernfs_rwsem_ptr(old_parent);
+
+	if (array[0] == array[1] && array[0] == array[2]) {
+		/* All 3 nodes hash to same rwsem */
+		up_write(array[0]);
+	} else {
+		/**
+		 * All 3 nodes are not hashing to the same rwsem, so sort the
+		 * array.
+		 */
+		kernfs_sort_rwsems(array);
+
+		if (array[0] == array[1] || array[1] == array[2]) {
+			/**
+			 * Two nodes hash to same rwsem, and these
+			 * will occupy consecutive places in array after
+			 * sorting.
+			 */
+			up_write(array[2]);
+			up_write(array[0]);
+		} else {
+			/* All 3 nodes hashe to different rwsems */
+			up_write(array[2]);
+			up_write(array[1]);
+			up_write(array[0]);
+		}
+	}
+
+	kernfs_put(old_parent);
+	kernfs_put(current_parent);
+	kernfs_put(kn);
+}
+
+/**
+ * down_read_kernfs_rwsem_rename_ns() - take hashed rwsem during
+ * rename or similar operations.
+ *
+ * @kn: kernfs_node of interest
+ * @current_parent: current parent of kernfs_node of interest
+ * @new_parent: about to become new parent of kernfs_node
+ *
+ * During rename or similar operations the parent of a node changes,
+ * and this means we will see different parents of a kernfs_node at
+ * the time of taking and releasing its or its parent's hashed rwsem.
+ * This function separately takes locks corresponding to node, and
+ * corresponding to its current and future parents (if needed).
+ *
+ * Return: void
+ */
+static inline void down_read_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
+					struct kernfs_node *current_parent,
+					struct kernfs_node *new_parent)
+{
+	struct rw_semaphore *array[3];
+
+	array[0] = kernfs_rwsem_ptr(kn);
+	array[1] = kernfs_rwsem_ptr(current_parent);
+	array[2] = kernfs_rwsem_ptr(new_parent);
+
+	if (array[0] == array[1] && array[0] == array[2]) {
+		/* All 3 nodes hash to same rwsem */
+		down_read_nested(array[0], 0);
+	} else {
+		/**
+		 * All 3 nodes are not hashing to the same rwsem, so sort the
+		 * array.
+		 */
+		kernfs_sort_rwsems(array);
+
+		if (array[0] == array[1] || array[1] == array[2]) {
+			/**
+			 * Two nodes hash to same rwsem, and these
+			 * will occupy consecutive places in array after
+			 * sorting.
+			 */
+			down_read_nested(array[0], 0);
+			down_read_nested(array[2], 1);
+		} else {
+			/* All 3 nodes hashe to different rwsems */
+			down_read_nested(array[0], 0);
+			down_read_nested(array[1], 1);
+			down_read_nested(array[2], 2);
+		}
+	}
+
+	kernfs_get(kn);
+	kernfs_get(current_parent);
+	kernfs_get(new_parent);
+}
+
+/**
+ * up_read_kernfs_rwsem_rename_ns() - release hashed rwsem during
+ * rename or similar operations.
+ *
+ * @kn: kernfs_node of interest
+ * @current_parent: current parent of kernfs_node of interest
+ * @old_parent: old parent of kernfs_node
+ *
+ * During rename or similar operations the parent of a node changes,
+ * and this means we will see different parents of a kernfs_node at
+ * the time of taking and releasing its or its parent's hashed rwsem.
+ * This function separately releases locks corresponding to node, and
+ * corresponding to its current and old parents (if needed).
+ *
+ * Return: void
+ */
+static inline void up_read_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
+					struct kernfs_node *current_parent,
+					struct kernfs_node *old_parent)
+{
+	struct rw_semaphore *array[3];
+
+	array[0] = kernfs_rwsem_ptr(kn);
+	array[1] = kernfs_rwsem_ptr(current_parent);
+	array[2] = kernfs_rwsem_ptr(old_parent);
+
+	if (array[0] == array[1] && array[0] == array[2]) {
+		/* All 3 nodes hash to same rwsem */
+		up_read(array[0]);
+	} else {
+		/**
+		 * All 3 nodes are not hashing to the same rwsem, so sort the
+		 * array.
+		 */
+		kernfs_sort_rwsems(array);
+
+		if (array[0] == array[1] || array[1] == array[2]) {
+			/**
+			 * Two nodes hash to same rwsem, and these
+			 * will occupy consecutive places in array after
+			 * sorting.
+			 */
+			up_read(array[2]);
+			up_read(array[0]);
+		} else {
+			/* All 3 nodes hashe to different rwsems */
+			up_read(array[2]);
+			up_read(array[1]);
+			up_read(array[0]);
+		}
+	}
+
+	kernfs_put(old_parent);
+	kernfs_put(current_parent);
+	kernfs_put(kn);
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d35142226c340..d28f8a3eeb215 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -398,6 +398,7 @@ void __init kernfs_lock_init(void)
 	for (count = 0; count < NR_KERNFS_LOCKS; count++) {
 		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
 		spin_lock_init(&kernfs_locks->open_node_locks[count].lock);
+		init_rwsem(&kernfs_locks->kernfs_rwsem[count]);
 	}
 }
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 84653c609a5c0..8451f153b2291 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -96,6 +96,7 @@ struct kernfs_open_node_lock {
 struct kernfs_global_locks {
 	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
 	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
+	struct rw_semaphore kernfs_rwsem[NR_KERNFS_LOCKS];
 };
 
 enum kernfs_node_type {
@@ -206,6 +207,7 @@ struct kernfs_node {
 	 */
 	struct kernfs_node	*parent;
 	const char		*name;
+	u8			unlock_parent; /* release parent's rwsem */
 
 	struct rb_node		rb;
 
-- 
2.30.2

