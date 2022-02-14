Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0024B4F94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350572AbiBNMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:04:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352297AbiBNMDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:03:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CFBD9C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:03:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EBfExE031159;
        Mon, 14 Feb 2022 12:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=i72Zuk4HngpHHy83v0BKVClagpOwW0ASOJv7kdB+Xdo=;
 b=s1Ck9TAZ9iW1PkV66CtzFtt29xEAUS1LtlniyHhehhtIKJe/dWn0G/4IPiQGDqUvLX3C
 ijH4QNkM4EAafz8Sdag86ZMtgKWlrB7Lh1tcyzzxWX36R/FegK8gck1P5KZNDHetAKf8
 sFdJj1rCiofGexxd7qd+qkERct4QUy0rUcAvc32dNlEb2Cx4iuOHUmcKeIy+2mAItUIE
 Jt/m99XmzQ7sc9cTFqJlAtt1trn3ljK3m1a+A0rbOb1jblmtZY9+K3Fjngvx9ftDS4GX
 TPmlcsAs3Mmqqlz5YH+fNbL3SFSxuv3G1wkSJNAoYGDOYst7jUmeU//Mk8fTbONLRtQl yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbv32a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EBuM0C184636;
        Mon, 14 Feb 2022 12:03:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3e620vusue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/qR6rZ60X57zG62xFyRv12WK0OP1M4sqX+L507IuIBccq0otR/wFU7wXTY+TBcoVeXFmB04vRDRiCAVFoTMcFrwpWNlHPN/98SpQoyJAOc62TvuxFuDmSJQCMPrGLyskEMinLMNoYVPW2AZS2IwGMNeUgybpSt6z7OXZMEXGghJs9w7JmZ+Tfh7bWxnssgJ5nZM9Rn07DyD/zqo4iKvMhGbVTJqXMK36d9t0zteRPFZcf69VY0W2W6yRDwekexiYWcKX730qMw9ZjtN4KKxmkR9rLkoA4y8jZf/HieTGxn8xj4kPpTmj/xvju0uNAb7SZ1Y0liwRvJJnzgoYMFe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i72Zuk4HngpHHy83v0BKVClagpOwW0ASOJv7kdB+Xdo=;
 b=KIOSMSxnS30r7QgzSZUdRsNW86fgO8qUJIuA/3rMgMk0iDnIZ4LzZaKlHvFbsT7smJ5uIAV+EjRMJ07Zlje0Ke/TXy77Wed0mdVXLIIxHdZvd6tF66aEejXpV5wtJPqS8QCRrBr+fD8lDPzwyyx3MV3gckXKq+u+CJ/NDsUptyLN63LAZEGRjARpwESZMPc+OBIlWNajthKByKoISh+ghdlwkvbvhGW2OHAM3jv8jXXOBiXeKy3BFBfUQiKy2MTnYLm7J+ivb6KQmiLvzwQqHl1oBzhxrPSkoZDwmcpCaJJh2yKCnUwZXuFmubRy+uTwZFI76nNjxu2sQVmt1DsEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i72Zuk4HngpHHy83v0BKVClagpOwW0ASOJv7kdB+Xdo=;
 b=YBIdVVWaVBl8biNpbJ8eHv22ntRSeYVWOnIec0pot0z1jgvWgPqqIn+l1vtllvq5hi6Ah149fZARL6l0hLq1dL2ILZc3L9v3p6nYVj1rG2uIgHA0l7pxksDpnAh4RHu3vEAWIe0pA8hm/o+Cg41Kz/+Ti2yiXYVs2TriTtKWVyQ=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN8PR10MB3538.namprd10.prod.outlook.com (2603:10b6:408:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 12:03:40 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:03:40 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/7] kernfs: Introduce hashed spinlocks to replace global kernfs_open_node_lock.
Date:   Mon, 14 Feb 2022 23:03:18 +1100
Message-Id: <20220214120322.2402628-4-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a753bf1-d98f-475d-3749-08d9efb209f0
X-MS-TrafficTypeDiagnostic: BN8PR10MB3538:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3538694B0597AA108D5BC20EB0339@BN8PR10MB3538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4bDjq0zdxHxemzMJw2VQccv6BXgOp+FwfQ9hizo+Kz5a4n0ed9bjju51Ux8iQFrFuvyRY0beMCkKArOTO95GFEXie6Np5TOWBpDGDpgPwDfqFcknwKuOcjCzKM8KzEt/dpfxBkENVPPDhY8D3N0PlvPTNBaqNEPjpl/WbJQASJX7lLtgLXJHv5CCKFIHb/p7oILyT2mz8SFZXF0Kw1y/UQZLnqiuPOC1t1RlvKq0PStzcvdUrhVfajLBS2ePOov3VFs9lZFzgydzvdpQHcI/nEIIZtWtGANxkyeHC77Cj82y/5FOYKOMsCl5JPWdBxQsCFzYfh4JtLGeEjOrw2wp+50Nou5NVisZL7ooerj+mHaUxLB5WXPERVpvVG7f36JBdXOovQYzzSlxZ7O12aKkWAbKRgVRcm10aTGSE/X+QSBy/c4iwsUqKz1itLSb2HXDN1LZPZhtdYCexDJu2kbOUOrod8oX5/2AnOJSsthsFrCfGKbJf1MeBWsd1iruqFQVNgqDqeBgdP/WQqUGUtY3acFk5J27rlVS1D3Js28ssFbZMd+E/bS1qOw5VUmGQBRkIKexZk3ZHTpEmy0enaw1f+Pe/T8cCjAHEhjUaCrOuCk40w6NvzVQNddljqN5ZiPzGi4XieZSo2EPZEg5dbF/3UvYQIew1sgf7oXD6hDzfBYCCvDtmIVigkicG7eCWebHywOWBZtnEvuzjdJl7cPmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(66946007)(316002)(38100700002)(2616005)(36756003)(6486002)(66556008)(4326008)(66476007)(103116003)(186003)(1076003)(26005)(6666004)(6512007)(2906002)(86362001)(508600001)(52116002)(83380400001)(5660300002)(8936002)(6506007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAsOmEEFKV7/QsX9kABJqAuW0Ns5qTpJXE+GLSJcJi2ftHP+a2SuUu+Im5Ia?=
 =?us-ascii?Q?+DjzktnOXv33ZzUFuvJaKC6ohmnFyhEHfmfhKs6krhadg9f756pGUyhwTFcf?=
 =?us-ascii?Q?zHLkX4+cg+1o7hS9XKyV/2ChfGumzW3jRxW5UA3pd2aICkCZwcf+DLkzuC4f?=
 =?us-ascii?Q?qOSFKWeRdjLM15uDC7JTTl2c39SupOmHYCb+52nPWnh9WHepFSe73V9Hky5u?=
 =?us-ascii?Q?UzLXKsKOV8geYKnwdvfRyyz0XRVNsXQGwODnd+Gh5yscyi+A901CxLZfM+Av?=
 =?us-ascii?Q?jtWePLX09VdXSzlDKn49pPw5u8kAPSmGbWq1uQBgTUDR4GEqP3m+IxHO16nj?=
 =?us-ascii?Q?34YL7aLdJquIOQP9B9Pq5BX3WrBkhwYPL2TGnDR10aSLCc6oFmhYRHhADCak?=
 =?us-ascii?Q?cXYPSS0jwr+A7aoGJRY2A9sKtqfDif4fmsUNL3o28+2VvEb4qtG32YhP8qq7?=
 =?us-ascii?Q?yGrYl9w7DoJPTja0ICAm/mFHmbMUi1WsNyapoltYMY6tEJPyt6njvxP6/NKP?=
 =?us-ascii?Q?hgLM5dhJWV7R6dRgevK/Uq4aHY3AD69UYfrmqltiqAtzmri6ASjMxDJpJ8LG?=
 =?us-ascii?Q?PtyPJ0S9L/rntYcEjwAiLjT54i+3jjaiaqTVAF2fkHRiBU4OKvZwz18EwxOW?=
 =?us-ascii?Q?sbtJN7wvDVIrGIo9aGErhlQ8/X/gyiAeV6Hz6iRZT3wwpqXVIdeFXceiTCO5?=
 =?us-ascii?Q?w8TIysh+RMlNZgN52iLv+V0+UA+9YirOX6Ra99Sn1PrStvpd759hEqeJtl4c?=
 =?us-ascii?Q?+prNtCW5qYWzYPfcrbqZ3F9WFBICnvrsAQvXQ/GBs4zsD9e+Puxd+uP/hiet?=
 =?us-ascii?Q?Qnm7JPxE19jFWI7Ij8XEQSA/CMXbfZAy+uM4rf6kHOwPtbOaG9RjIi4RfOfE?=
 =?us-ascii?Q?5oZxVrAnKR+90V1qdL20WBGKbLhWrkulffDgXeTK7831WWrnPYPLZy/mz41S?=
 =?us-ascii?Q?yFxSwNsQdAOlqSlq0R8hNpHN3pSPMIHFBIv7H8BWkwN72msimyemUhPlo2LK?=
 =?us-ascii?Q?EqGb2dFYnR1b7B7ePzzyn3Q7Y1kEfun0dL9nc0krWuRYWT3STQjrzuaMRocm?=
 =?us-ascii?Q?shHDQzosQei0+LpVeG6fdVcXxNMHgTXVbzeZhy7exHcwH2KDVuhblPh0kyvR?=
 =?us-ascii?Q?yh6Waj6OiDzwJ+OJKySgd0xzKDZ4WK9LDltWWDiNRfH6505HtzaJzIWiIiCt?=
 =?us-ascii?Q?8GbQ8O8DaOQj07FRPeGIhbVwUYNEDFfvnYRnVBTpF49xBZWyePPI/hJGQqKb?=
 =?us-ascii?Q?NlmO2e5FLS0LANGvX4N2ElJFvBa5JYYyP2KVnbR5ii9KOoaERkfxNxWKlMl6?=
 =?us-ascii?Q?HXnxpC0LiN/SzXE6P/ew+6fMqFii0KC24v4C4BxFAiNr4z5tuL5v/fN7yxfD?=
 =?us-ascii?Q?sflmrjvq5rWVlC4DqWqQ2VGm1+MPzgFG67wUdk+Cl+nMi69gFkgY9TfaEkGU?=
 =?us-ascii?Q?94PmmKWNID+ZQFxjTrDXAgxzlBc2BEBEHvLv0gyBuF2amrtaBejVnrR3P2sU?=
 =?us-ascii?Q?s4k8HMvX0bFCpxedRAgnIpRllXiO/EQDCSRAoGmEZ9HCYpVsaG0MY0nZs+/x?=
 =?us-ascii?Q?wt06T4qrT7eUZYyHE0cPPQFlIqSkZb5QIE5P3ZwzuRBI/8ZwTu7ZAlbXTzzp?=
 =?us-ascii?Q?RPiSGeBZUawYKisobj6hhYY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a753bf1-d98f-475d-3749-08d9efb209f0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:03:40.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gS4vAMKIZPqHgYftqhVxizp5IDD3ICt54M7Ie3t0wp3CPMHQ11jbG1UabKka7yW34zyK9KBvIGI3/Zr0gxIwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3538
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140073
X-Proofpoint-GUID: NEBi6_SOzdKV8jckaolFRbUMMHo3s76e
X-Proofpoint-ORIG-GUID: NEBi6_SOzdKV8jckaolFRbUMMHo3s76e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current kernfs design a single spinlock, kernfs_open_node_lock, protects
the kernfs_node->attr.open i.e kernfs_open_node instances corresponding to
a sysfs attribute. So even if different tasks are opening or closing
different sysfs files they can contend on this spinlock. The contention is
more apparent in large scale systems with few hundred CPUs where most of
the CPUs have running tasks that are opening, accessing or closing sysfs
files at any point of time.

Using hashed spinlocks in place of a single global spinlock, can
significantly reduce contention around global spinlock and hence provide
better scalability. Moreover as these hashed spinlocks are not part of
kernfs_node objects we will not see any singnificant change in memory
utilization of kernfs based file systems like sysfs, cgroupfs etc.

This patch introduces hashed spinlocks that can be used in place of above
mentioned global spinlock. It also provides interfaces needed to use hashed
spinlocks. The next patch makes use of these interfaces and replaces global
spinlock with hashed ones.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/kernfs-internal.h | 20 ++++++++++++++++++++
 fs/kernfs/mount.c           |  4 +++-
 include/linux/kernfs.h      | 11 +++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 03e983953eda4..593395f325a18 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -170,4 +170,24 @@ static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
 	return lock;
 }
 
+static inline spinlock_t *
+kernfs_open_node_spinlock_ptr(struct kernfs_node *kn)
+{
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->open_node_locks[idx].lock;
+}
+
+static inline spinlock_t *
+kernfs_open_node_spinlock(struct kernfs_node *kn)
+{
+	spinlock_t *lock;
+
+	lock = kernfs_open_node_spinlock_ptr(kn);
+
+	spin_lock_irq(lock);
+
+	return lock;
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index fa3fa22c95b21..809b738739b18 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -395,8 +395,10 @@ void __init kernfs_lock_init(void)
 	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
 	WARN_ON(!kernfs_locks);
 
-	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+	for (count = 0; count < NR_KERNFS_LOCKS; count++) {
 		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
+		spin_lock_init(&kernfs_locks->open_node_locks[count].lock);
+	}
 }
 
 void __init kernfs_init(void)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 3f72d38d48e31..7ee0595b315a2 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -19,6 +19,7 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 #include <linux/cache.h>
+#include <linux/spinlock.h>
 
 struct file;
 struct dentry;
@@ -75,20 +76,26 @@ struct kernfs_iattrs;
  * kernfs_open_file.
  * kernfs_open_files are chained at kernfs_open_node->files, which is
  * protected by kernfs_open_file_mutex.lock.
+ *
+ * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
+ * protected by kernfs_open_node_lock.lock.
  */
-
 struct kernfs_open_file_mutex {
 	struct mutex lock;
 } ____cacheline_aligned_in_smp;
 
+struct kernfs_open_node_lock {
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
 /*
  * To reduce possible contention in sysfs access, arising due to single
  * locks, use an array of locks and use kernfs_node object address as
  * hash keys to get the index of these locks.
  */
-
 struct kernfs_global_locks {
 	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
 };
 
 enum kernfs_node_type {
-- 
2.30.2

