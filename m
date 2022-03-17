Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF44DC01F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiCQH2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiCQH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:28:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D9F1C16DB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3O7oU030081;
        Thu, 17 Mar 2022 07:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ixBrXFQUSYstJbK8GgPPTtLT1s0p6RbjKcjoVmYZqvA=;
 b=WR6cERwF5L4CX3Ea7yR/fSxhkvh1jV6zj4uEjvu/iFmkXROrMxjaVTcySe4Hkccmqc1r
 Ilnf0RpWBILaJHIUmBgfXCuleqP1a6VPzW8bL29Nq8QfMeMfIGgWCj/pakZdBnsvHqvV
 2ffbjEeSJWBHeI2pUBCgycTr032k4jVGnzNc7e9f9OqAH+FP+jq1hvBy+xMEuHL9WNNh
 SufukkVS8OzMbtfSgN1wWViO7xMYgF/e0mkWfahexbwclYgqjhbE9YaR0b9NmeQyg1O4
 QDZ58L94U652JXzqgh/dKDi2HBU8grK76C/9ZnsIumfBBM19S6kvqSgzi93IOIpmRS8D Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu8hcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7C9q2012696;
        Thu, 17 Mar 2022 07:26:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 3et64m4wyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmCxRn080IcnqJsVD2Ll8zNpdjbydP9g8M1f8s09GrNsa51YKDbVhGR2x9sBw0/RKSFtoMewBNNSFEjut9BrYgT6M563qNsvnMC+A0WHW533YGCyIg4j8yG1NNKBOKpedg1UH8BbfLPUbDV6gCyNxQoKSMunIzqzWBrOxxnQ/QI7Ex0PCc+4KLfm0G5cKwBaryGiNUFdxgVbna4TCKYtKQWUyzQhxAhI+hPIXlhyK6hZ1Zq20TxnBmVQ8rhRfSvBTwIiQKbCkCz+2CGmBWfXTbgM2D5k5l9RZsOCH421bwtjTNziFKSB6Lb/76eyIYb2vokn13uKORHlArZ9bKeMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixBrXFQUSYstJbK8GgPPTtLT1s0p6RbjKcjoVmYZqvA=;
 b=ByBDCy2yOP/f8Lt63ZQK6qDj+kiZBRSr3YpwQ5F98k3F+1X2sj9GDbFfjf1/nqxPL2NCM+miayKyzd9sQwkQr6eoNoiZKrJ4SRTN9nj3ZxDA2Td+mIVITEXM0okObbuO4/UJ5Fw6fnP48YnduwqBHeOLq9y7BJqX3hgfWUdoBxtz8X7LRRkNBmiQ2vZoVktPjDgwhZ34e7I5d5ay0ruFadF5Cd2YZ4AJ7RF0Lzhgku4uJpdA/oG1GEsHMKaBoPBhbDSgOeFTBzQBY9QR0+ZmdsD2OgroMAEjfS0lHEao954LsGwwiLLMjPLDg5qGK9iPdsg61D5W+OQhUNQbGI1YOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixBrXFQUSYstJbK8GgPPTtLT1s0p6RbjKcjoVmYZqvA=;
 b=CJsh3hMmmm5xG8p2mYrxrFTQHsrGcbJonWDiwUel0YZBcN7loSCsFmrycjAOpJyfi5HDYdYzsof+i2v3MsZGkwC3G4HHCdDRK7HcWsobXO7+UOXRjzknGX9r9kj8AVBQ6BD3jYdKGQdwRJaUxx431EqnuWObYs7k4xFZxPUcL6U=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 07:26:40 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:40 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 8/8] kernfs: Add a document to describe hashed locks used in kernfs.
Date:   Thu, 17 Mar 2022 18:26:12 +1100
Message-Id: <20220317072612.163143-9-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220317072612.163143-1-imran.f.khan@oracle.com>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::22) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ba2a070-a5a2-42b1-e018-08da07e77a76
X-MS-TrafficTypeDiagnostic: DM6PR10MB4332:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4332E4E35EE1C1D4FE4C0AD2B0129@DM6PR10MB4332.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yY6XrgF4Er5dSOj0VSUO5ftjBByX5Y9oYqRqddXwup3W+vgyGV+80puyfHB1QSa8I0NkdgP5XIrW9CjVeC0UUfP9LV1hTFH2wQgKUjhsnqbfbqKTfua6fG1XhONjuZCEwHPKFhId0ec2tG2wPzWY0p94NlOV+LeHXaNdiVXRZ9ZfIdXoB1Q8I8NLBM73U+JpK7afUPWW1LnF68Yi7hHutm6IDqFNVtUKi7/5WZSZ1Z6pivsYldXe+7MPTF/2inbc6IJYOsOzqjHgoAGZ9vjfK1OxzdMgttlCBtjIrAPy/3MsdOeHInaEyThLxZoSxGxJSXpJ8LmTdYTX1f9yDKK4fI2o7R6ZRy1ufYBFTiGiEY4DSPXQbcgErjCcl8QxJSazI7fXXeeOix0sxEW4Iq7G6pGkPMlzBWyw9aHYwRzGPhphptWGSftnp903vQ/p48cDZy16gm66VUYyjW4oy7P8SGz4J56kqMqGH+P4a4xWfW+fYNCJk4Vz06MJBEvUU62Sbjm2M0+cywORv9oalWzR5WB20h58b/HIprEbkh4abIgzyoo1qhAzd7QM57LF0olkzPLECO/fF1ifP200igBDME6L6Rqty4oYCZrE5HrLecnyeueZ6WVPs68bFVQsihNrmS9JHQNQKl06SEpQZEKnK6w+EMjnxdb6jflCe48KG7rBMQdr7g8B/nMRu5b/U3zp2hDUna0qCaqUJH1ICvaR7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(8936002)(26005)(52116002)(36756003)(38100700002)(316002)(186003)(38350700002)(103116003)(6506007)(86362001)(6666004)(83380400001)(1076003)(5660300002)(30864003)(4326008)(66946007)(6486002)(8676002)(66556008)(66476007)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1cZKvCg48jUM38TBfZpvpIIR3YotNwU2QyiHz7uk/mjT6IF/cG8u15cUd8fK?=
 =?us-ascii?Q?FTDuyb8ymVpxOD9c4SBuR+hNdOacLpfFah2xsyVz6drt41PXzo2lEr4FKaFV?=
 =?us-ascii?Q?S/vp/dAMBEwppx8tFRTLWj0ZstZXvsaMGPt+QhpUb4KZCRLZ/mnim1uE84sa?=
 =?us-ascii?Q?7c919nGhz95zSL0gplvzn5xzhbJyR3cO6UFItcoMdIXdYnN9qno6j0U/zbWX?=
 =?us-ascii?Q?DKBTivvR3q+T+yYYU+p3QPh41aZJgbEKWuUOhSuNZJIh7LJl/QVXs7A/6k+Y?=
 =?us-ascii?Q?P0xVdtyH92yJoltGcD3a/Rzr0r/ALBFr1MZ10OOiPfNAG4zBMO6tlAREIQgs?=
 =?us-ascii?Q?zR7sWw0UDh2B0ZzaqiWCS3YUJC7cGE+VLSoKkdYtUltiWwGQe5nKRsUupVin?=
 =?us-ascii?Q?rJlWwZAVtOxpMKCST9+M9G8iOyiPgvmxxVbRAdz4C7cL6rtOm8frT7IqwRPl?=
 =?us-ascii?Q?D3fNORtKwVPvb/RNf/pvIejuutnSyFglqCvaY3qUKoC8VYBwnqDGfegFa/I4?=
 =?us-ascii?Q?4BsrziJpmGNx4jdodv6KaTncxlqPCrzE6VjPwZmTY8TutFnAsbKwTvlLN6Kf?=
 =?us-ascii?Q?2uM9MZ9m9PJ7v9sx0NJbMs3FlkgwGUkBCeYHruynsF+oHemLcIkydz2xIqty?=
 =?us-ascii?Q?WC3CqlJKd8D8fRJz/FMiSO83FvfnwWfi0iHwj1FkANSksg9OL6yGe+Ke+ruE?=
 =?us-ascii?Q?MseplgeDQuagynYnMdcpxNEwY36WQgrhh7A1XXAcQhxrZRj3w8H/7jtsGypK?=
 =?us-ascii?Q?fSJOazrBtyTrgndco8HD7qtAbB0L5btaaRm6NGev14oKzZpa8TqPx7bQR6HZ?=
 =?us-ascii?Q?sr4xulfyuHNVJgjKjl7YeziLeD0RCH9vYWOdhrdKxJHC/0wcCOznL5VKec/d?=
 =?us-ascii?Q?H6hIgye8CwZ+vEcONBbaIvQqfFC17njTb+4RNF7YTet03m6WJn2NfCu4jnmy?=
 =?us-ascii?Q?s176uPhhleSagZgYUi7lVEmA6BFdnc/k9DDHhHrV8yjQ85iG2KPWTGzwINjz?=
 =?us-ascii?Q?Do9oqGlPcsSW8Ez2hezAv3s0KXd+OGnyzauZfGhgJxMlfemu7FpEeYpDAgcl?=
 =?us-ascii?Q?9pbonJpAa9QlK/zCFq97BMfRVKG89R7eEKSfao0U5M4zRVHSlT2qCKTtQzy5?=
 =?us-ascii?Q?VZpT7Ogsdv0/kQAIAw3bBjJFqcKPDYGnCpwx/vqOSPCmLBcZ4PzJDiKmWnrT?=
 =?us-ascii?Q?BDIZcn1TZd04h3UPfLRe6gtr2yNHzHqYWvZPbhxFVO75sBPOMnwUjYWHMd1x?=
 =?us-ascii?Q?eQ9zfRLVtLrZ1e9M6G1ZKrJln+k13+n79vEfXxjbx5GiXU2xOo2/zf4lAcu1?=
 =?us-ascii?Q?YEMFfWLoTHq2XSX71CPTuaSAMT6bcr3ZMkshXqpja0FnLyOnzwg7Ehe+ibBC?=
 =?us-ascii?Q?6O3fQ2/Q7a2Hrh+wxP0A4l92XHcbR3gmjwcaQMT3YaKoz3MukjiC8Pr4Cxda?=
 =?us-ascii?Q?JHeS4DdneBTy9kWORZNJ/WpewJYhJDR4GL2fquip7sMsP7UVep082A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba2a070-a5a2-42b1-e018-08da07e77a76
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:40.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwCtIPG50pahGt1lB+NVfELQr4gRUMFQtK31cMqS2U1MDD2N+ZQRXx0Zci2fgwNC/2gNtv5j2oMMRaOX91LJJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170042
X-Proofpoint-GUID: DIwFc6GdqjP8W27Z5HKIGRfYy7q51qgu
X-Proofpoint-ORIG-GUID: DIwFc6GdqjP8W27Z5HKIGRfYy7q51qgu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document describes usage and proof of various hashed locks
introduced in this patch set

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 .../filesystems/kernfs-hashed-locks.rst       | 245 ++++++++++++++++++
 1 file changed, 245 insertions(+)
 create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst

diff --git a/Documentation/filesystems/kernfs-hashed-locks.rst b/Documentation/filesystems/kernfs-hashed-locks.rst
new file mode 100644
index 000000000000..2ffa579ee1e3
--- /dev/null
+++ b/Documentation/filesystems/kernfs-hashed-locks.rst
@@ -0,0 +1,245 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+===================
+kernfs hashed locks
+===================
+
+kernfs uses following hashed locks
+
+1. Hashed mutexes
+2. Hashed spinlock
+3. Hashed rwsem
+
+In certain cases hashed rwsem needs to work in conjunction with a per-fs mutex
+(Described further below).So this document describes this mutex as well.
+
+A kernfs_global_locks object (defined below) provides hashed mutexes,
+hashed spinlocks and hashed rwsems.
+
+	struct kernfs_global_locks {
+		struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+		struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
+		struct rw_semaphore kernfs_rwsem[NR_KERNFS_LOCKS];
+	};
+
+The hashed mutexes and spinlocks are encapsulated in kernfs_open_file_mutex and
+kernfs_open_node_lock respectively as shown below:
+
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
+struct kernfs_open_node_lock {
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
+
+For all hashed locks address of a kernfs_node object acts as hashing key.
+
+For the remainder of this document a node means a kernfs_node object. The
+node can refer to a file, directory or symlink of a kernfs based file system.
+Also a node's mutex, spinlock or rwsem refers to hashed mutex, hashed spinlock
+or hashed rwsem corresponding to the node.
+It does not mean any locking construct embedded in the kernfs_node itself.
+
+What is protected by hashed locks
+=================================
+
+(1) There's one kernfs_open_file for each open file and all kernfs_open_file
+    instances corresponding to a kernfs_node are maintained in a list.
+    hashed mutexes or kernfs_global_locks.open_file_mutex[index].lock protects
+    this list.
+
+(2) For each kernfs file that has been opened there is one instance of
+    kernfs_open_node and kernfs_node->attr.open points to it.
+    hashed spinlocks or kernfs_global_locks.open_node_locks[index].lock protects
+    ->attr.open.
+
+(3) Hashed rwsems or kernfs_global_locks.kernfs_rwsem[index] protects node's
+    state and synchronizes operations that change state of a node or depend on
+    the state of a node.
+
+(4) per-fs mutex (mentioned earlier) provides synchronization between lookup
+    and remove operations.
+    While looking for a node we will not have address of corresponding node
+    so we can't acquire node's rwsem right from the beginning.
+    On the other hand a parallel remove operation for the same node can acquire
+    corresponding rwsem and go ahead with node removal. So it may happen that
+    search operation for the node finds and returns it but before it can be
+    pinned or used, the remove operation, that was going on in parallel, removes
+    the node and hence makes its any future use wrong.
+    per-fs mutex ensures that for competing search and remove operations only
+    one proceeds at a time and since object returned by search is pinned before
+    releasing the per-fs mutex, it will be available for subsequent usage.
+
+
+Lock usage and proof
+=======================
+
+(1) Hashed mutexes
+
+    Since hashed mutexes protect the list of kernfs_open_file instances
+    corresponding to a kernfs_node, ->open and ->release backends of
+    file_operations need to acquire hashed mutex corresponding to kernfs_node.
+    Also when a kernfs_node is removed, all of its kernfs_open_file instances
+    are drained after deactivating the node. This drain operation acquires
+    hashed mutex to traverse list of kernfs_open_file instances.
+    So addition (via ->open), deletion (via ->release) and traversal
+    (during kernfs_drain) of kernfs_open_file list occurs in a synchronous
+    manner.
+
+(2) Hashed spinlocks
+
+    As hashed spinlocks protect ->attr.open, ->open and ->release backends of
+    file operations need to acquire spinlock corresponding the kernfs_node so
+    that kernfs_open_node instances can be properly refcounted and freed when
+    this refcount reaches 0.
+
+    file events notifier uses ->poll backend of kernfs_open_node instance, so
+    it also needs node's spinlock before accessing ->attr.open.
+
+(3) Hashed rwsems
+
+	3.1. A node's rwsem protects its state and needs to be acquired to:
+		3.1.a. Remove the node
+		3.1.b. Move the node
+		3.1.c. Travers or modify a node's children RB tree (for
+		       directories), i.e to add/remove files/subdirectories
+		       within/from a directory.
+		3.1.d. Modify or access node's inode attributes
+
+	3.2. Hashed rwsems are used in following operations:
+
+		3.2.a. Addition of a new node
+
+		While adding a new kernfs_node under a kernfs directory
+		kernfs_add_one acquires directory node's rwsem for
+		writing. Clause 3.1.a ensures that directory exists
+		throughout the operation. Clause 3.1.c ensures proper
+		updation of children rb tree (i.e ->dir.children).
+		Clause 3.1.d ensures correct modification of inode
+		attribute to reflect timestamp of this operation.
+		If the directory gets removed while waiting for semaphore,
+		the subsequent checks in kernfs_add_one will fail resulting
+		in early bail out from kernfs_add_one.
+
+		3.2.b. Removal of a node
+
+		Removal of a node involves recursive removal of all of its
+		descendants as well. per-fs mutex (i.e kernfs_rm_mutex) avoids
+		concurrent node removals even if the nodes are different.
+
+		At first node's rwsem is acquired. Clause 3.1.c avoids parallel
+		modification of descendant tree and while holding this rwsem
+		each of the descendants are deactivated.
+
+		Once a descendant has been deactivated and drained, its parent's
+		rwsem is taken. Clause 3.1.c ensures proper unlinking of this
+		descendant from its siblings. Clause 3.1.d ensures that parent's
+		inode attributes are correctly updated to record time stamp of
+		removal.
+
+		3.2.c. Movement of a node
+
+		Moving or renaming a node (kernfs_rename_ns) acquires rwsem for
+		node and its old and new parents. Clauses 3.1.b and 3.1.c avoid
+		concurrent move operations for the same node.
+		Also if old parent of a node changes while waiting for rwsem,
+		the acquisition of rwsem for 3 involved nodes is attempted
+		again. It is always ensured that as far as old parent is
+		concerned, rwsem corresponding to current parent is acquired.
+
+		3.2.d. Reading a directory
+
+		For diectory reading kernfs_fop_readdir acquires directory
+		node's rwsem for reading. Clause 3.1.c ensures a consistent view
+		of children RB tree.
+		As far as directroy being read is concerned, if it gets removed
+		while waiting for semaphore, the for loop that iterates through
+		children will be ineffective. So for this operation acquiring
+		directory node's rwsem for reading is enough.
+
+		3.2.e. Dentry revalidation
+
+		A dentry revalidation (kernfs_dop_revalidate) can happen for a
+		negative or for a normal dentry.
+		For negative dentries we just need to check parent change, so in
+		this case acquiring parent kernfs_node's rwsem for reading is
+		enough.
+		For a normal dentry acquiring node's rwsem for reading is enough
+		(Clause 3.1.a and 3.1.b).
+		If node gets removed while waiting for the lock subsequent checks
+		in kernfs_dop_revalidate will fail and kernfs_dop_revalidate will
+		exit early.
+
+		3.2.f. kernfs_node lookup
+
+		While searching for a node under a given parent
+		(kernfs_find_and_get_ns, kernfs_walk_and_get_ns) rwsem of parent
+		node is acquired for reading. Clause 3.1.c ensures a consistent
+		view of parent's children RB tree. To avoid parallel removal of
+		found node before it gets pinned, these operation make use of
+		per-fs mutex (kernfs_rm_mutex) as explained earlier.
+		This per-fs mutex is also taken during kernfs_node removal
+		(__kernfs_remove).
+
+		If the node being searched gets removed while waiting for the
+		mutex or rwsem, the subsequent kernfs_find_ns or kernfs_walk_ns
+		will fail.
+
+		3.2.g. kenfs_node's inode lookup
+
+		Looking up for inode instances via kernfs_iop_lookup involves
+		node lookup. So locks acquired are same as ones required in 3.2.f.
+		Also once node lookup is complete parent's rwsem is released and
+		rwsem of found node is acquired to get corresponding inode.
+		Since we are operating under per-fs kernfs_rm_mutex the found node
+		will not disappear in the middle.
+
+		3.2.h. Updating or reading inode attribute
+
+		Interfaces that change inode attributes(i.e kernfs_setattr and
+		kernfs_iop_setattr) acquire node's rwsem for writing.
+		If the kernfs_node gets removed while waiting for the semaphore
+		the subsequent __kernfs_setattr will fail.
+		From 3.2.a and 3.2.b we know that updates due to addition or
+		removal of nodes will not happen in parallel.
+		So just locking the kernfs_node in these cases is enough to
+		guarantee correct modification of inode attributes.
+		Similarly the interfaces that read inode attributes
+		(i.e kernfs_iop_getattr, kernfs_iop_permission) just need to
+		acquire involved node's rwsem for reading.
+
+		3.2.i. kernfs file event generation
+
+		kernfs_notify pins involved node before scheduling
+		kernfs_notify_work and kernfs_notify_workfn acquires node's
+		rwsem. Clauses in 3.1 ensure a consistent view of node state
+		throughout execution of work handler.
+
+		3.2.j. mount
+
+		kernfs_fill_super, invoked during mount operation, acquires root
+		node's rwsem. During mount process there can't be other execution
+		contexts trying to move or delete the node so just locking the
+		involved node(i.e the root node) is enough.
+
+		3.2.k. getting symlink for a kernfs file
+
+		kernfs_getlink locks both parent and target nodes. Clauses
+		3.1.a and 3.1.b avoid movement/removal of parent and target
+		nodes. If parent or target gets moved or removed while
+		kernfs_getlink was waiting for rwsem, the subsequent
+		kernfs_get_target_path will return error.
+
+		3.2.l. while activating a node
+
+		For a node that started as deactivated, kernfs_activate
+		activates the node. In this case acquiring node's rwsem is
+		enough. Since the node is not active yet any parallel removal
+		that wins the race for rwsem will skip this node and its
+		descendents. Also user space can't see a deactivated node so we
+		don't have any parallel access emanating from their as well.
+
+	3.3  For operations that involve locking multiple nodes at the same time
+	     locks are acquired in order of their addresses.
-- 
2.30.2

