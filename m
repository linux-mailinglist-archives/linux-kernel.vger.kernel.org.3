Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC54C3DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiBYFWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiBYFWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:22:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC16B0A6B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:21:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4Zfp6017855;
        Fri, 25 Feb 2022 05:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=2v+BnuJfqs0WBVA1gqGP5VA8LzXnWDHE7vHZlrqQttw=;
 b=ZFi3MCc+NOYLu0aqsib+1y/Pmheg4k8KJopG5kuQ6jHBXzNVPGHhN3Ugp6PPHaXb1Q9b
 hveXJwTwdrXfRR5E5JsR/bP8ooCcI1nlXgEkL48XtTH3HKVPNYyjPpCoO/AmF29FzTHb
 aixlfCuWLilZ5o91Wu7mkohM4MBS09zMPsaMLYOk2cM4zdp4vF18IvbgVkBGRL6a8InC
 gzr5uE+JccL3mootNQh1oa0JUUF/ATDr8VL4qO03ld8N1zlEKRWa0x57IQqar5zaHeNq
 QrstrNO5aW9K1P6cwl+Ulrpkj0XhBi8cGxQNWSBDsocgD3JWwug7ivSIR7J99AV1Eoys KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfb0msx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5B0PC017724;
        Fri, 25 Feb 2022 05:21:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3020.oracle.com with ESMTP id 3eat0rmw9p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U29IsQIXuWgzt1v8Lj0FTHixGb/UyjzGivDFHEd5Kjgp6srNeY56a5edLAUNmLnwCzt0kFAgLypJ2OVQalAnso12z9mNO8wJewtSVDxjUOLhtGPY/+83M4br8+jsItMqQq7qYxxeF+OFTM9sCqPOZznFzwhrJe+pK+6jPc7UNDat62/63QA0sf+sT6Mi7gi07qKw3paT/RBBuuDmWfe/RzHqGekMXRo3o8Y/lZX0y7jzIgppmbo+AyXNx7vRUIf4t4ZMV421r3aNASpCQz34SA6oOJcmcj9Rwed87Qa60JIh8r7kU0p7uIHHUBf0B8k2sAWwt7AI9SqHsjaj2cFgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v+BnuJfqs0WBVA1gqGP5VA8LzXnWDHE7vHZlrqQttw=;
 b=fLbT2K4hPOg+BRddHdhpp8cJTX99s42YNE3+9KyhLPELkpoEo18HpwDNNDPlGnBocrRaBig7w6v9Y8O3lwWiJv4qzXKVJO51tYiOvaWVowtisdJ6fg6s+FUA27LP3h4DzQ+TtSmqp7dZHiowMXgfFyDXnjiv+/N0kGvSrXv2Mig3Iz2bxICzaqyBu9jCa91q0Iz05dDQkBus4sNB/KrswMRo8/IGOaoR6gG/loxeBmpPd+ksX0rso32bH7VXBzLQt9OOD5N+8rSH8ag6qnLMKIwzwkyELEqIbT5Tbj99lz1AklYSSlyjV1QPVuNYAIcFtItP4tRJVV2LTcrtv8EeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v+BnuJfqs0WBVA1gqGP5VA8LzXnWDHE7vHZlrqQttw=;
 b=YYPK9wfRiCQ0V4/1Wo7xtwVdXRZ1CeRKh3zgvhc9L9HU/KhFslhqPX8yUUa5/7LNgYs7vgCwEJMuv0whyScBecrhplXvmYy6SR+kIXZRNoTXLgMLd3+meSjnMSD3lYNZXzOhsBsNt+vwnJhEIHs7FlL6ScwjYi+UHLmeNciB/Rs=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1677.namprd10.prod.outlook.com (2603:10b6:301:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 05:21:41 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:21:41 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 8/8] kernfs: Add a document to describe hashed locks used in kernfs.
Date:   Fri, 25 Feb 2022 16:21:16 +1100
Message-Id: <20220225052116.1243150-9-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225052116.1243150-1-imran.f.khan@oracle.com>
References: <20220225052116.1243150-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0043.ausprd01.prod.outlook.com (2603:10c6:1:1::31)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1804c7b5-6180-4155-98df-08d9f81eb48a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB167720C74D92C40E4593EDC8B03E9@MWHPR10MB1677.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sC2XTWOaHgyGNmPaXyxiD1mKDTClQG/9pscN8VZGT+d0Yx7wkg/tFF7QJWiMv4iJoxb6s9SmqvV6ldyT/qsnsic9HEoInwsDTBcyFbXZV0NT9ksWAQ+dteB2OG7DcSxYZl1hbgymILrz8SYqpoxCW+tznXi9zvtU7oaldVBpJoobe/4VKZlV+wB4iugIEVHCcWYheY16RpRWx9dPK/cYOJ+qc/EFwHaShjCdw3zVuRbZ24KwZVtqTblQtyZoiMRqAzxX3CWoh+E6aD2RXVF9jr5BGCldmnMvlKdcYB2GDtQfM1qk7cH0ODSriKbUzw/C1CPJjtP6vJzOyybJcctQjGw2MvUfdRpMjZdocHnHaBxWRGNd/JRZiIVzqPFAX2yDL4Ruzcv4/e5+A51aQpTPZVRgDl6BOBjYPLc9AzX8ZTaxwykdv3iXhK/fULwsoO2nSPuNqpMZd51FYqxN2HQ9f4TpSgNM3Lodm1iGoqSTNr3hOSerjzIMOumEtodnjFUFph5YV5ba7eFS9yGe1u2fSwHOe1x8A3tppemvXGrZJGKwqXxrk60SKIWc0PGVRU6pGswcXeQj+7hkvY8ipQ5p8Ft6k+370jGZrtelJiIHnfDcLMLAVFnC6+1da9atFIgSpHeBblqEH1/VSlyK8FkN27/Vcq5SxJOTHWu8O2zgIboY7i7Cw8RV01vhpLoUabrEeV5K5UWh8SlbwkXLk4AJHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(38350700002)(6666004)(8936002)(38100700002)(83380400001)(1076003)(30864003)(6512007)(508600001)(86362001)(6486002)(6506007)(2906002)(52116002)(316002)(66946007)(36756003)(4326008)(5660300002)(8676002)(66476007)(103116003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IN06vPShCOLNadPw8F5JSxWOzdKPa9EihtlTUycUhgCFrfTmpA8SDgvLYR8?=
 =?us-ascii?Q?H3cEYgsp2CmCC3+K+PhfFRuqUJolRTfXUJMEx3vBuAdoV3fp7beBBljTeG0A?=
 =?us-ascii?Q?fYYYuCAT095/2Tr52XgGDErseupFD8vWy3mpB38D36aQub7IBsu3FxwT5hnI?=
 =?us-ascii?Q?WNWcPZjeEfeeDERmColcFiB8SL5aNjkLDhLsEjHr49W9fFpjz97+fmMXwWm7?=
 =?us-ascii?Q?9cu9QKFpwfZBGgBPIwKKV0M5ziuShZfkOEbN5c1t2kUPcEjoTWepl+OQ+5IW?=
 =?us-ascii?Q?SQ1HzHTNIEvgx+LCWpw84xSWjihqFawcamwIURID+bo8i0Dp4FAeciqO0bzd?=
 =?us-ascii?Q?BrOd9VT1fmBFlegRvDQc+c+8Lz4k0EsmIDj5VqcFrSAOeZdlS1gA2wmTTJSB?=
 =?us-ascii?Q?OmYMaSKZnNBJv6H4b2ObR6bMTJKK+BQS5Hj/iVvZnzaRsP/xgMgOsVo9mLEo?=
 =?us-ascii?Q?mNuqXgcfupZ5uAJgVByb41+3wIkuceokvJa7cAjivn4Xzpw7T37YiYZzf51m?=
 =?us-ascii?Q?2mVnt0fn4kd/QOwhcJDTQNwf3uo6wVRl81nZ/l4lOvMmRMgLO++oSQD9aewv?=
 =?us-ascii?Q?BRTUSfsX5gpI/zFIao3UnZI7OXyu/uMYqWDNPNcGhc+u4mweeEcW/OaZLMiG?=
 =?us-ascii?Q?klne7ueD96LRtePX89LG4Bo+sUUPcTx7iQ8aV5CZJOyk4KJgPsvrfslp6b+A?=
 =?us-ascii?Q?+uN2cw7ckN6wf8EGAwEjypqauGRFquCFCrRymjFVmhDNoLzwPdmYwtNDDe++?=
 =?us-ascii?Q?YsWjRCDyFIgyimxD/7Y7ae3PBBVHkqqRn+YbW5WgGE+pdLoz4qL9c1QI6mdl?=
 =?us-ascii?Q?ypnHvEHpI83Q6mVDdGgHXARzKR1kZ0yJMiUR8hogp96BgAGeK1cZHtmvXSRu?=
 =?us-ascii?Q?wNmQRTmQEy3popUN8xCAikzBpIE2zMwe9ashH1tBQKQc4eiOaxkTpijAORP3?=
 =?us-ascii?Q?s7nl7ld54K2kTlOZ9SEk33+Ia0F1fTJfA+hCxwFf1Rq0BgGZnUY1+g6DDrXa?=
 =?us-ascii?Q?9y5ag7ddh0hi9ribZ60ES+zCA0n/bO2otTgS/xr3CInQkxcs2DqbtfYU1mtl?=
 =?us-ascii?Q?ZtVFVuBfVa1QEAs8w0hwARPzxTa+5dE//swBe1P+BxRTaVbGBrSP05XDnfnn?=
 =?us-ascii?Q?ip5MazKcttSBZQ30w8TCLBL4tbN1SBjuFTogRdwBM+QNKhetgZpbLLBtnOaa?=
 =?us-ascii?Q?P1XP1OCZmbcnm3kJoMhqnF6LHfi7wEDuwP9N79qxNX9Ey8qJcKMgF3oZeB33?=
 =?us-ascii?Q?mZgUgkZlheMaJGf7OpZIbxFLY9fB/XKN1ANGIQpSRsjP2xzqJD312s+UYPaZ?=
 =?us-ascii?Q?yRwMiDkn9RNhDE1UBjGeKGfd0OvUB6dm3QZqnEPyITNU3t8kN5GuVUPb6RhC?=
 =?us-ascii?Q?Lb5rZaaFAtL7v+MCUH+8PovWPwmQjzHahLh7lqxk+1lr2wnztF0NLWyTNPwe?=
 =?us-ascii?Q?PFnzHUFrFFEqDRHF66Co94nO8zRIDbsy3dyQ6JsHZO6TkPmqi3yfKnlapGbs?=
 =?us-ascii?Q?pMdMfxhNEykHS6WsRgJVpF6jgkg7Nj2yf+6T1JhlK9+9fUzg5s6aZLBJPRD9?=
 =?us-ascii?Q?8CVu9nJW2/qt2sG/oHY6WyWh7sCzWjc8Xsy/aRVFAh+FKueDbLnNF8Sln8YK?=
 =?us-ascii?Q?Bt2jZyAPQ3eaAqXW+gFXUng=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1804c7b5-6180-4155-98df-08d9f81eb48a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:21:41.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaQkGCoyz9iYb6A+6iaiIIQAOD3ky7bqbOla7zrD8nfq4BUdl7JI4x1O3ayUOWoNQQkTHc5AMJ2X00JWnGCkeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250027
X-Proofpoint-GUID: VdyQSemIQ_FQFdLSTbWdLYBaAinWz-C9
X-Proofpoint-ORIG-GUID: VdyQSemIQ_FQFdLSTbWdLYBaAinWz-C9
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
index 0000000000000..2ffa579ee1e3b
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

