Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABA648D5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiAMKnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:43:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43860 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbiAMKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:43:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D8kLhG030546;
        Thu, 13 Jan 2022 10:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=UjDzj2/rvEjgMKoQA9PCPuM6uavGnvKEIqnq1sWCmIc=;
 b=fDGxLs8L5hJ4Y562jJ2XUyTfS6DeWeW+H3H+G5GBNv4OYfy1B1kfPzsukcNkr21f7hlh
 6+85uCSekv7x8IFKqguIG99nKQMl8QBx0BblMFHEDpvcOnWLaj1jV1shTbT/kmdTM+/P
 OvVcmkGGjRUhOuG2jGyEUlp+rujqaWIqSbLAtW2zg+T6rQ4018NpTT5huPYKfgCB+cXs
 4hBiem0scwI0mnsFIYEGuBt0Ywn2q0exGGolnX7wqnoFAEBACfWT0CNXPXQROGhE/Pk+
 08EDsvKjmb+IbuIk8GadgX8VIkoCSw+doQzThIlKRlbLawW+Csm3VPofD4ChsQOzmwGF Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djgv688h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:43:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DAgFdw098107;
        Thu, 13 Jan 2022 10:43:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3deyr1hjf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:43:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNwrw5RPUsLHQv5b+Jqz5K+mP+308O7mR/AsWMaK6egqb5IP2KvTDcg92H+KRlxUE2KfyQIYe8iL8tKDObubsCcNgtqRwiTnrSTaB1kmfhlRb0TGZUDLQt6ttxe7b4+OOQyNqzF4ACNRHvm3qFCSZipKq65IKROMpaT54N5ZJOhvHoGJWoInpY8VOosduv74hnuhmxO6/xr/rQHlkytyXa9vIPmWPOg9UNdyLv45dE/GL5r5zmfSYZ1rKneKYmZahV9fRpSijHQo2pmS8/y+O99hCEK9h65sRlvOUxsoOqynHrdTYBHhzkG83xCHXUFXfev2HKn53IK9snubRH6bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjDzj2/rvEjgMKoQA9PCPuM6uavGnvKEIqnq1sWCmIc=;
 b=neDA+Hm/iy24CWDDMUzjH/68jMLd09sThhhdqbeuJx4JXpibiBvO9VG2py/hkfOtbGwMVXhAEdryM/J7/KcsIQ3WooAlyGHFoOrJjPRm39ktsumY2voxdsR3grBnWsRfBmd5gUZJ4RjsaJluPmiK/r56EMiGi3lVeC/3qFSOvkiWAQm/nOOJABialWhXrR8AM5Z9rSaozwQdI55XdZv3cggnsB2aO7iUSANU8qOes9T0JkZxuRdqcqldJtVAbE3S12GIqxYKjKCjyoZonidt5Jwwil00rJy2i72J3ENAvXlmLbdu+dVYYuW82TKBfIhnrcbay8wlPZUyfCEDdv4G2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjDzj2/rvEjgMKoQA9PCPuM6uavGnvKEIqnq1sWCmIc=;
 b=oOPDI7r1Hpq/Fp7i4/6fpJADv6iODqDKhGLnCGtKKbJuozNRCm2yC9yI/RWsYYApCDIi5pulZm4DfbkV3W/YaxGq+FtZlqiI5JMhEKiurzx3VrLBori4IM4aK/jy/K3OruuWZ/1JEdS34sWiMmDwadQRA4HD25qpWtWIa9Sk2Qs=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 10:43:35 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f%4]) with mapi id 15.20.4888.010; Thu, 13 Jan 2022
 10:43:35 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] kernfs: use hashed mutex and spinlock in place of global ones.
Date:   Thu, 13 Jan 2022 21:42:58 +1100
Message-Id: <20220113104259.1584491-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113104259.1584491-1-imran.f.khan@oracle.com>
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0083.ausprd01.prod.outlook.com
 (2603:10c6:10:3::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f94193-6c33-45aa-ec4e-08d9d6818d13
X-MS-TrafficTypeDiagnostic: BLAPR10MB5138:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5138FE47C87924E7D0064B6BB0539@BLAPR10MB5138.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxO4WbkjWjtog6cESTlUYAuldRzE7hR770B4LX0U3KtHr6JbPFG03tyd3Ig3nedd8PZRMmDrnoTvYH5MEosYY58Pqb/NLuyN50PjkA1OTtMEk2WeVcCAI+SiApyBX2aaNI115I0Wy2f8z3UqE9XhbmkVDXAoHZfBZtKBjYGWQw8QFyTOBzbwkCNLMP3XkFamp5laLMrGi/Pux1suhD69tRsk7ZOU5Iv8JdbDTstEtqmAV52ULHAeNlL6qhoIYcjio3RYH1vrtT9LGFoxeix1D+o7WIZZX87HBvq1DT3QXpijPZENyxPejjlVX5r7qu9YKMqCi82d3xxFS0Y9dUv13Ydmxh9bLUej1oFwv1nUIL+oRuvpvc+XIcQKhs+t8vr+LswuuAo1PV7BFDvRa9WKaD6F1NwjXEvmCbraTEqyiPJdDMnXGi6ZkPWSxgEtDQsH/XMA7VLCjdOD/voIphvmoNR4+gBJ1N5IIg9sMnW876RW1ulGHXAOkF5Rbsn1hGuJnhFBJRiq83MPg5eBT7Kj9CVJ+x+cCQqa0U6+X/Gv+NWXWNWDH7+NYqXigc/3sv80/H+AVcemKUuyHCBNzui33MudRZYlrX+d5m1D2LyHMJNXhfSKl/FJPSzo3f5Xf7EgXpGB7sZo53wxmvOxYLvL2sznkD6IS8IdZRpmKB9613juKvIxJdw7TYcfowYTigfb21lW4DfCXUTqXWmSPK3M2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6512007)(83380400001)(1076003)(2906002)(36756003)(8936002)(6486002)(316002)(38350700002)(38100700002)(8676002)(52116002)(103116003)(186003)(66946007)(4326008)(508600001)(6666004)(2616005)(86362001)(5660300002)(66476007)(66556008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXlw2y8CDxn4XNwgJu5ZKsyE3ED8pIrnAPw3QcQIh0mU/Xf7l2UUviV5cDPV?=
 =?us-ascii?Q?wnlg/riNOaPJYgtOgNeYi6iZgXfnDZFwCT7oJwhL/Z+3YgYw3w9e5rbvVsXN?=
 =?us-ascii?Q?xQPhnqh9PX2nHw/HY39empvJKuksjjGY2TVbj2otSBG6ZoL6N1D3TttsbvlD?=
 =?us-ascii?Q?/9BLtLSnp1WEAay5t3uXysHRAheownHAGXTU6Lhw3gW8I9UtjRoSyHeObUcS?=
 =?us-ascii?Q?o5yuGSmJpl8VAPXlWRoutye6cFA37s5yHYUhFWzVT1dM6nRJhpKDV9RZoL57?=
 =?us-ascii?Q?xoRTLfGv3hLVF7VZqUqjqmNzkIfOvgihbYNb9ZyLZqbhGNAlWTXUwIpnmEoS?=
 =?us-ascii?Q?92q+pmDTR54Ec/zDaAGF/i8NBJlKeH5Yr4txotUsSjkiyZ71Akfn4kW4hB/m?=
 =?us-ascii?Q?baYJNuPtjvnpg+xF4mSSSPZLgqgw5KQOXWzph9g7PWKgTsCRMv8W/UMzyxu/?=
 =?us-ascii?Q?0qiBWHal72PXwPIiv2wrdVofqAzssM75i2gbSQQAWpxlPEC/6v8xzjJbeTsn?=
 =?us-ascii?Q?2YIS/XQKnzX9VTZ8pO7IxKRi0U8w0HCr0IG2H1rExQXipBhnotb9xtm9Rkm+?=
 =?us-ascii?Q?gWyF7Z5t6Ew0hpnFtfyGGx4Z9aNtDUGPulAwMoxODT7eE45RrcXf1qDFHqV4?=
 =?us-ascii?Q?UZTB+zk2/07T0sfKTpqg8YBdPN49ByypKO9dS4s3n5+zfuNIeFxi5GUNVaYo?=
 =?us-ascii?Q?DK3DvMT3zCIQEf04CMKLvdZRGZIDdHd7VHcx7qmtU25vjIIS1XGXb5MZSG/j?=
 =?us-ascii?Q?gxCnTfeT4D+208UzL3sYJFhtaKO60kLNCm8YE3rvK/+OwJCAdzg8UUihUBWN?=
 =?us-ascii?Q?uLiy7Czwp26Wi0foueyO01+bfTmXcwv6EP8Ca0L9576F4ir4NyI0BN0SzVq3?=
 =?us-ascii?Q?N0mOMDe+38dVh9HaLEEia1J1plKmxNsAzQiUYc9swpgn/sp2rKpBP9fxUOuV?=
 =?us-ascii?Q?ol50kSBPw5zuprxaEhV4/f0fVhDi3KTXmUXBmrTiIQ6ue6fC4CzRXiVftgkq?=
 =?us-ascii?Q?9n7Mbqz/1C0+BpYe7kikxFIdcOBbf064JLyJ+QhKhtk4h4cL5VghdPbRu/vB?=
 =?us-ascii?Q?PGBuUWo031ddUGqkrJWCixivDYCAUH8lFxlqTtTUqKbiV5W4cLYRJPnJGAKV?=
 =?us-ascii?Q?y54dVBDGkCcrEmQgoaD7K5y62n2NSRyiyBb0XouJamN1kldIDGMkQhqfA3Sl?=
 =?us-ascii?Q?lBY4C+TEsx9Tl0R1E1y5i10IBj4DJTkgpnDyWFYlL+PtouKbAJlvS5W18t0y?=
 =?us-ascii?Q?mRBzR23yJrWwfMjAuMfWguYaj/XvFiEp4/xACTYdExx5FGiplvMO3/37kA+a?=
 =?us-ascii?Q?nEMmUH3U8MyiCa8YVPQp842Bg1+0sVv+gQnPwzbuysToT3eyBtT01+ube43Z?=
 =?us-ascii?Q?ftF8ipsNw57x2Fhr90sFekQ3OsKEq5Uq2TertoWyvpK/o1+xBZ+ZLm1I1v24?=
 =?us-ascii?Q?/Dbgu/Wrl0zNoY9cPvwSVjkE7CYCb879OWt6bgrrkaj0XbriUYnU0NKqB+5T?=
 =?us-ascii?Q?2P/FDDCO82yvEPlDWwL5ggFIVW4fJdhvSGSRClYegLjWNrHPSiM3JtmxHhII?=
 =?us-ascii?Q?Fi1mJMioAa5zy9qARJ/wm3TkjYcxBAmJtMRs9Gg2m2uVZXs/Ds/3ESLH6S56?=
 =?us-ascii?Q?yrnojbGh6XmGZ+v6VStni6w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f94193-6c33-45aa-ec4e-08d9d6818d13
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 10:43:35.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfTKs3X6liiSnHkklh2wYrH3yZW51kssE/51Bt7/Zyw7tt6b5nXjHH57JDFhZDAMSuHOZjl9mmYnxgzsSqudNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130063
X-Proofpoint-ORIG-GUID: GrndI1PFBXWovoK4_Gq9bYSjsGgJGyx7
X-Proofpoint-GUID: GrndI1PFBXWovoK4_Gq9bYSjsGgJGyx7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now a global mutex (kernfs_open_file_mutex) protects list of
kernfs_open_file instances corresponding to a sysfs attribute. So even
if different tasks are opening or closing different sysfs files they
can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time. Since each list of kernfs_open_file belongs to a
kernfs_open_node instance which in turn corresponds to one kernfs_node,
moving global kernfs_open_file_mutex within kernfs_node would sound like
fixing this contention but it has unwanted side effect of bloating up
kernfs_node size and hence kobject memory usage.

Also since kernfs_node->attr.open points to kernfs_open_node instance
corresponding to the kernfs_node, we can use a kernfs_node specific
spinlock in place of current global spinlock i.e kernfs_open_node_lock.
But this approach will increase kobject memory usage as well.

Use hashed locks in place of above mentioned global locks to reduce
kernfs access contention without increasing kobject memory usage.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            | 65 ++++++++++++++++++-------------------
 fs/kernfs/kernfs-internal.h | 57 ++++++++++++++++++++++++++++++++
 fs/kernfs/mount.c           | 11 +++++++
 3 files changed, 99 insertions(+), 34 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f..5fdff8597082 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -18,20 +18,6 @@
 
 #include "kernfs-internal.h"
 
-/*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
- * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
- *
- * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
- */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
-static DEFINE_MUTEX(kernfs_open_file_mutex);
-
 struct kernfs_open_node {
 	atomic_t		refcnt;
 	atomic_t		event;
@@ -524,10 +510,13 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
-
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
  retry:
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
+	mutex = open_file_mutex_ptr(kn);
+	lock = open_node_lock_ptr(kn);
+	mutex_lock(mutex);
+	spin_lock_irq(lock);
 
 	if (!kn->attr.open && new_on) {
 		kn->attr.open = new_on;
@@ -540,8 +529,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &on->files);
 	}
 
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irq(lock);
+	mutex_unlock(mutex);
 
 	if (on) {
 		kfree(new_on);
@@ -575,10 +564,15 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on = kn->attr.open;
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 	unsigned long flags;
 
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	mutex = open_file_mutex_ptr(kn);
+	lock = open_node_lock_ptr(kn);
+
+	mutex_lock(mutex);
+	spin_lock_irqsave(lock, flags);
 
 	if (of)
 		list_del(&of->list);
@@ -588,8 +582,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	else
 		on = NULL;
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irqrestore(lock, flags);
+	mutex_unlock(mutex);
 
 	kfree(on);
 }
@@ -729,11 +723,11 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	/*
 	 * @of is guaranteed to have no other file operations in flight and
 	 * we just want to synchronize release and drain paths.
-	 * @kernfs_open_file_mutex is enough.  @of->mutex can't be used
+	 * @open_file_mutex is enough.  @of->mutex can't be used
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -752,9 +746,9 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 	struct kernfs_open_file *of = kernfs_of(filp);
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		mutex_lock(open_file_mutex_ptr(kn));
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(open_file_mutex_ptr(kn));
 	}
 
 	kernfs_put_open_node(kn, of);
@@ -769,19 +763,23 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
+	lock = open_node_lock_ptr(kn);
+	spin_lock_irq(lock);
 	on = kn->attr.open;
 	if (on)
 		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(lock);
 	if (!on)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = open_file_mutex_ptr(kn);
+	mutex_lock(mutex);
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -793,8 +791,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
-
+	mutex_unlock(mutex);
 	kernfs_put_open_node(kn, NULL);
 }
 
@@ -922,13 +919,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	spin_lock_irqsave(open_node_lock_ptr(kn), flags);
 	on = kn->attr.open;
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(open_node_lock_ptr(kn), flags);
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1..4bdcf7a71845 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -19,6 +19,63 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/cache.h>
+
+#ifdef CONFIG_SMP
+#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
+#else
+#define NR_KERNFS_LOCK_BITS     1
+#endif
+
+#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
+
+struct kernfs_open_node_lock {
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
+/*
+ * There's one kernfs_open_file for each open file and one kernfs_open_node
+ * for each kernfs_node with one or more open files.
+ *
+ * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
+ * protected by open_node_locks[i].
+ *
+ * filp->private_data points to seq_file whose ->private points to
+ * kernfs_open_file.  kernfs_open_files are chained at
+ * kernfs_open_node->files, which is protected by open_file_mutex[i].
+ *
+ * To reduce possible contention in sysfs access, arising due to single
+ * locks, use an array of locks and use kernfs_node object address as
+ * hash keys to get the index of these locks.
+ */
+
+struct kernfs_global_locks {
+	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
+	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+};
+
+static struct kernfs_global_locks kernfs_global_locks;
+
+static inline spinlock_t *open_node_lock_ptr(struct kernfs_node *kn)
+{
+	int index = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_global_locks.open_node_locks[index].lock;
+}
+
+static inline struct mutex *open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	int index = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_global_locks.open_file_mutex[index].lock;
+}
+
 struct kernfs_iattrs {
 	kuid_t			ia_uid;
 	kgid_t			ia_gid;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a..accfea3ccae9 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -387,6 +387,16 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
+void __init kernfs_lock_init(void)
+{
+	int count;
+
+	for (count = 0; count < NR_KERNFS_LOCKS; count++) {
+		spin_lock_init(&kernfs_global_locks.open_node_locks[count].lock);
+		mutex_init(&kernfs_global_locks.open_file_mutex[count].lock);
+	}
+}
+
 void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
@@ -397,4 +407,5 @@ void __init kernfs_init(void)
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
 					      0, SLAB_PANIC, NULL);
+	kernfs_lock_init();
 }
-- 
2.30.2

