Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459154C3D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiBYFWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiBYFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:22:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11653135E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:21:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4ZeYt019933;
        Fri, 25 Feb 2022 05:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fgjxur0EgX2dWUNVQwOGPe/nuPSLAID3WpmItQ9ROY0=;
 b=eZj+DBaxbZQ0CyvSOusMWXc4VLcDqFjjttkNR0wur+cm/Y/8GAnqSFeRmdCUKgTG7j13
 4NrY3w6UNWrzU/g/OjzHat+9yMG6M7kNaGLjLx72DfMh9P3e6ihqUgjSIcGSv+5jv7qg
 dJPnqfxXrhve0HRuxO0YgTttDtBidzrIcLT0Q5Ag8fsgAL0CL9bIZ6wdlDOt+WVfz/+L
 zhLawBFyeqM82Fzrv3cVNTeXOYHFgrGfHXs38M9fcYBGHDreLHuirTecwBSe8I6jgXaw
 26JjehV9WCxIWn2DQMm2Mna28yC20aRsM9p+Wk38Kur5Yw9F7Lny7hzkcki8nQniPFhW Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3cs1xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5Bg4d011961;
        Fri, 25 Feb 2022 05:21:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3eannykfct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0f5w7nY8FtXdOXn7rB/cQc7DUbrRWoT1fke5EGxVXuj/6cO8kxVQSLtsupoIw8nSZHyWybqEEhMuVy/tsSgsFN13EmyHtYOEYfccxZOW+d02bL9N4U81w4W6M576oMT0YF8cVtpCCu1+e8c2FcsxNndkyB2IFm8y6q31nf+1F/52dE7cFlt6nQHUTMULIxmSyKLGU5CvZby8AmWFyQ3s7dw3rN2dTrnlgGBa/2B/gywq7zghQziMJQH4KJBsbZm04N7AHo0nz6SO+aBPSmS00Uhx50AVcqhQsn5q7aOXEvBuIKD4WrKitYIBa9W8nmt9Ob69cgkcursBA4l7+RHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgjxur0EgX2dWUNVQwOGPe/nuPSLAID3WpmItQ9ROY0=;
 b=Wud/F17/dMkaLWbEgseyuTx8HS/2H/vjADBj21ZNBChAXJPIN2bYyVDfwNFjt0Ig4mGOkqPxL/AikKHyUJYVEG0z+E4D26e92pZ2x9zG2B88SkIZe5gLwZrywdve4miwyrzw5hZGhuY5UmEdJMxb2WhChFeDD7mhQowsptuDrLLiOTO2ifj7j3qobCFpyStC2nvydWNiApPioBTWsprwC3aHESw3wgQblW0J+dYMnc9Mq9MJNxZgKYSiEzCsqjCSDfyLrKq45vNhNq516DKsbqXLJxpi4FouGaI2wUpGm2JVxCcd2qnwVVCzCECYI5z7c3A1nooxQk364THDoTZhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgjxur0EgX2dWUNVQwOGPe/nuPSLAID3WpmItQ9ROY0=;
 b=TbAQkPQ110bHBbF+B3jwkN+1CKYHQzr/ZbkAc0YLwK0+CnojlGOBvuHERHSty5K9C11QS4gQU4QJ14W7mPvFO76Np8X0CgEbQlJSHLV6I5Vub3vhO1CFDb6yeRQ2HgYQvNqixX9NXyRN7UsHIW0+FGIEUhOwBr6gF729++LbjBo=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1677.namprd10.prod.outlook.com (2603:10b6:301:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 05:21:31 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:21:30 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/8] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Fri, 25 Feb 2022 16:21:10 +1100
Message-Id: <20220225052116.1243150-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225052116.1243150-1-imran.f.khan@oracle.com>
References: <20220225052116.1243150-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0043.ausprd01.prod.outlook.com (2603:10c6:1:1::31)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9584ed51-f8d5-447b-b448-08d9f81eae61
X-MS-TrafficTypeDiagnostic: MWHPR10MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16774018EEEA5393EA4577F4B03E9@MWHPR10MB1677.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGHXezNUVijV9LPbE/cbT/LOhUiLaDyu23Q6UTYx2aXbq/rJ/0Z4kTwtvIoZPolcQlbcIi3E28grIdOUMjCdze3RfEk0blfP8rwsdqyw1+RjI+gbodDfB927rmnjWttkWe9m/5YxPKHW3cWq7+UexL4qLsP5jMdP7wVlexNtvTB7V7SmLf5iVeEscRuXfCPEH6eQyMZKV4iT383aZNPDYuDhfyUcpt1OA48ruLup/tRGsmSOTWQIKNUmMlQJTSioFyfXih8iOKuBXSqkTpsvX0lSLB8YAkzu5yAbCgEJDBCUuVxEZwfI+xwPwSPRTKEzJ9XgDV2hXDBHWjKeRo9dT4g5goq9LI2NByZN6HKDMAK8wGesykwm1ygeflsTHsz3ahBzLoyfyWHcz38JXxUen9P5RnC9ZcsfDo7FFDsBduaWcpLVzZsULbm/9/GCdVxYUc9oDb5ydOfG34kAFU/ijTlAeB5U3zTCbwclrt9vBGuRjCXBfR1KeBG/P5cvZpqT6zH44men1pYdDkPd0C1GFZhfaR+g6/7dyzfsjz+kmm2wL7GPX/CXhKcVyhf1OZyJ35JY4sE3p/F6CJ3BxRptuteDpK/gowY4B3uhOLy27kXW3pcNCEIvfucPvPvIGOEYTcW0kqzmTJ9rQz15J1M9XQl3+jrE6JAU+2waxvdKIAcxLGuDP5b2Yj5Q2peUVmG8VzW0vDKqbMDMH0UAQgyJlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(38350700002)(6666004)(8936002)(38100700002)(83380400001)(1076003)(6512007)(508600001)(86362001)(6486002)(6506007)(2906002)(52116002)(316002)(66946007)(36756003)(4326008)(5660300002)(8676002)(66476007)(103116003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2A+Gvp4hIjRf3K3TVa2sPSwbwnUdK88G7Pgg/+CFyextJ4bsQbBHVRST09SJ?=
 =?us-ascii?Q?DAXekWEz6ktGJuTSpLBNesMjZsHGaCJ/ltBGWwwMaeJEJHru0hFLoqnEorgN?=
 =?us-ascii?Q?qKhSpJv5klk/+pcJbpwxDYOUMboxs9sQ9MiKitv/9j8oMk9Ii6ePei7H8KD1?=
 =?us-ascii?Q?C8o2ptfxp456IggtsZkecIdZQqu0M065X3pujgRnKys89afjPKr5I4syIZlR?=
 =?us-ascii?Q?IaP85fr8WQQwxCjF2TDpdK60k0VAutSIdjswRarwdFRcXdkXm53Ghjcgld8u?=
 =?us-ascii?Q?30OtM0QKt2sDY+8P+5tJezXXmnh+mCcVbQ+mQpVudY9ZSn4D4zxPIQSJaPHb?=
 =?us-ascii?Q?YYwESb+unOrtjJfVNps1hYCtKRmjV8FEqmkikWm+goERwBC9CjdvpvcyM40b?=
 =?us-ascii?Q?o2Cou5XwOoiqyvB8YjIpZ41QZjMyD7OkWtW5zm1eQsL7wZdug4pZeLm7CZuC?=
 =?us-ascii?Q?TmIvgALFfl8Sug1uEVvzuH9jKQRa4UcZXkBNXDLDzsfpLGOuDGQdJayHHxZx?=
 =?us-ascii?Q?0HI2ClNQf6pUgtbTlzGOo7Dr7r2jOFdT0++ITTabtsfhxqlG+0MS9GwaKTLh?=
 =?us-ascii?Q?WtjNs0EHW5SmRWomwDUDOo87O/mApJnPkU/AzNulw6/6ugbU9KEC+99YJFV4?=
 =?us-ascii?Q?7qNBN303Yf6qCARzQJ7gfNpRd45rw1ZRL16U4G39tgO8nbmbd3HYPRv/Ck/x?=
 =?us-ascii?Q?cnAOzH331/EIVmDsYrqvmYwl/ByU+kJ+KOj2CL3amEqXM4AH+N3KbiHfvG8O?=
 =?us-ascii?Q?9jZ1OynYQiENHzZB2rfijgcZr1vBxVWSmXDSnf11F0jqSn1H3oqN8Ry1U46Y?=
 =?us-ascii?Q?IZdmXSNMTDxX7jxfwgOfpfxnbubLXGXWV8xK+FxcPdTLL+8JMKJMnZOFHz1N?=
 =?us-ascii?Q?fFJDexmeP22twnz+T1Nkad70+IgGSAKnf3AZOnQl/Lw5qarmJE5FI0eJmZOL?=
 =?us-ascii?Q?HtKa5h53oPKEkHRLOTGxerdFvoOLirwkaWLKPAdevOAscfVrN8MMBf9TF8Lg?=
 =?us-ascii?Q?ZjU111rQapri6xBcxOUNeOIQ4CPf6zQo8lfvOKke97tLsem4WE8mbpOwzDc2?=
 =?us-ascii?Q?xuYj7Q5KGi2lzrAeqP2Eyrr0Pjd8FWPOsdUlydiaSFNdLy3S6UmyfnRtN0DU?=
 =?us-ascii?Q?/d9WqcuBx7xom2c6NjYmTGcJSW+JLu62x8MRj/VBDgv9GIvubaGlghDeQyZa?=
 =?us-ascii?Q?IjSIWZjpkulmNG8SA5VoFyDvJSr9fmKFYS3FB5cMJYAd2ukwVOMQV5HhHIQB?=
 =?us-ascii?Q?hPbSyQLBHkKkCXLABpV1C5iTVXZjrfkEcIZt4p0few2E0nrom734kMuBr6gX?=
 =?us-ascii?Q?F2LsKy8uzg54RQ//bcd8ZcLLFXeHckWzsTAtHqLolLXu2GPrx2nemilrHZNT?=
 =?us-ascii?Q?rNDC2GtIZRRL6W9em7pgad+uibnt5cm8ArVlZCMDpRoXmx3AjAivinXiew6c?=
 =?us-ascii?Q?m64g3/0JPsQNb5ku+9p3pzqU34D2zdK/PwR2wDx0+ECvHvtP8eIiUcxA3EXv?=
 =?us-ascii?Q?UQr/AojqsPwQn39aI1DOoAfVM69F4/IDKAhuIrfEwLBnfFLgtv4TyXnkJnFa?=
 =?us-ascii?Q?4x3MQB/yag7TaZAMm/OwWKvJqWyaoA2saFhiYZbsNBnUjtatNCIA7l6x+YxD?=
 =?us-ascii?Q?6pxH0tvRebtG6HKnWmLSZ1o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9584ed51-f8d5-447b-b448-08d9f81eae61
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:21:30.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkvKpCWri09iZ61k/1r0MiyiD3Eutq6deoPgxMZx10zH3UiDQGBxKALjhHGp9vTyq2u5+5RqCQJUw2nLWSPb5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250027
X-Proofpoint-ORIG-GUID: BOqkGdeQwUjz4QDMsRIBG5ldp11fuDqv
X-Proofpoint-GUID: BOqkGdeQwUjz4QDMsRIBG5ldp11fuDqv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current kernfs design a single mutex, kernfs_open_file_mutex, protects
the list of kernfs_open_file instances corresponding to a sysfs attribute.
So even if different tasks are opening or closing different sysfs files
they can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time.

Using hashed mutexes in place of a single global mutex, can significantly
reduce contention around global mutex and hence can provide better
scalability. Moreover as these hashed mutexes are not part of kernfs_node
objects we will not see any singnificant change in memory utilization of
kernfs based file systems like sysfs, cgroupfs etc.

Modify interface introduced in previous patch to make use of hashed
mutexes. Use kernfs_node address as hashing key.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            |  7 +----
 fs/kernfs/kernfs-internal.h |  9 ++++--
 fs/kernfs/mount.c           | 13 ++++++++
 include/linux/kernfs.h      | 59 +++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 99793c32abc39..8996b00568c38 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -19,18 +19,13 @@
 #include "kernfs-internal.h"
 
 /*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
  * protected by kernfs_open_node_lock.
  *
  * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
+ * kernfs_open_file.
  */
 static DEFINE_SPINLOCK(kernfs_open_node_lock);
-DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
 	atomic_t		refcnt;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 91b7cfb8a1105..03e983953eda4 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -147,11 +147,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
-extern struct mutex kernfs_open_file_mutex;
+/*
+ * kernfs locks
+ */
+extern struct kernfs_global_locks *kernfs_locks;
 
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
-	return &kernfs_open_file_mutex;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->open_file_mutex[idx].lock;
 }
 
 static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a7..fa3fa22c95b21 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -20,6 +20,7 @@
 #include "kernfs-internal.h"
 
 struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
+struct kernfs_global_locks *kernfs_locks;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
@@ -387,6 +388,17 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
+void __init kernfs_lock_init(void)
+{
+	int count;
+
+	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
+	WARN_ON(!kernfs_locks);
+
+	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
+}
+
 void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
@@ -397,4 +409,5 @@ void __init kernfs_init(void)
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
 					      0, SLAB_PANIC, NULL);
+	kernfs_lock_init();
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 861c4f0f8a29f..3f72d38d48e31 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -18,6 +18,7 @@
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/cache.h>
 
 struct file;
 struct dentry;
@@ -34,6 +35,62 @@ struct kernfs_fs_context;
 struct kernfs_open_node;
 struct kernfs_iattrs;
 
+/*
+ * NR_KERNFS_LOCK_BITS determines size (NR_KERNFS_LOCKS) of hash
+ * table of locks.
+ * Having a small hash table would impact scalability, since
+ * more and more kernfs_node objects will end up using same lock
+ * and having a very large hash table would waste memory.
+ *
+ * At the moment size of hash table of locks is being set based on
+ * the number of CPUs as follows:
+ *
+ * NR_CPU      NR_KERNFS_LOCK_BITS      NR_KERNFS_LOCKS
+ *   1                  1                       2
+ *  2-3                 2                       4
+ *  4-7                 4                       16
+ *  8-15                6                       64
+ *  16-31               8                       256
+ *  32 and more         10                      1024
+ *
+ * The above relation between NR_CPU and number of locks is based
+ * on some internal experimentation which involved booting qemu
+ * with different values of smp, performing some sysfs operations
+ * on all CPUs and observing how increase in number of locks impacts
+ * completion time of these sysfs operations on each CPU.
+ */
+#ifdef CONFIG_SMP
+#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
+#else
+#define NR_KERNFS_LOCK_BITS     1
+#endif
+
+#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
+
+/*
+ * There's one kernfs_open_file for each open file and one kernfs_open_node
+ * for each kernfs_node with one or more open files.
+ *
+ * filp->private_data points to seq_file whose ->private points to
+ * kernfs_open_file.
+ * kernfs_open_files are chained at kernfs_open_node->files, which is
+ * protected by kernfs_open_file_mutex.lock.
+ */
+
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
+/*
+ * To reduce possible contention in sysfs access, arising due to single
+ * locks, use an array of locks and use kernfs_node object address as
+ * hash keys to get the index of these locks.
+ */
+
+struct kernfs_global_locks {
+	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+};
+
 enum kernfs_node_type {
 	KERNFS_DIR		= 0x0001,
 	KERNFS_FILE		= 0x0002,
@@ -413,6 +470,8 @@ void kernfs_kill_sb(struct super_block *sb);
 
 void kernfs_init(void);
 
+void kernfs_lock_init(void);
+
 struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 						   u64 id);
 #else	/* CONFIG_KERNFS */
-- 
2.30.2

