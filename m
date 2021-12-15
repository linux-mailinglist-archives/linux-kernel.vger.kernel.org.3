Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784F7475B66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhLOPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:07:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30686 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243742AbhLOPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:07:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFEKY3i005935;
        Wed, 15 Dec 2021 15:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=DAr/dYSarv4F5Wwto1tsklIaUHTmKOKHwc7aaZZowWs=;
 b=opOV6uW4HIvnLg7xiTPSCHnttDP77NGL4W+/HLwtY/Xjoio78sZ881UPYQDHEOh/qEvq
 3LsoSXuSp3l2xE9aU6grT6yT1oUHEZXQcm9dIhTdUdufMcI17lk5fOptBma1zahnhhiN
 b4mNIX9Juh7HvUxZb5ShMFtgJVbN9ZND4OGEIBun5AVXB6XIjl4c2VNsLs8FtZlgdUnU
 xE4zQpjEp6486sjjTvPNTxEY43LFfuwKRtAvUoAJy3l71kY+o7W4ql/E8mbKpQ5gU+dn
 PZJWuWo/Q5Y6asTyiuMYILVsFtdLfbZhccSLlbBYdBPUS4LBQdbrZPlxQW+7kpSDguMb cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u6rrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 15:06:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFF0RJt148754;
        Wed, 15 Dec 2021 15:06:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3cvh409xc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 15:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz7D2UP2xkPHUm0RrzuHf82nSdoKnYO/Nu+as7zH9fdbM270+VoVD4e91kOsBN9KyFb5agIG37wdEq1xMT4ZwiaVi1E9HUAYWc1z4BnpkFepsDcqJBvpmh6+LMj2lbYAUB5SmFdQ/AzvgP24uPuYkPeBuBu1MBzcmem6oTuXQ8bGgFWlpC95NSq6CYHsax9m+GFRFXPABgNXheT10TFXzVnR++diFfJlcxV50d9GzPB4VxtR/3af0Q5285+b0QMcvmX1mGBQuZxCr9XdTz50NRnGfBOmhlLCppOHeeh2jUzoyUGPpYtDSYhiS3G75+yfWM1yB6iKOcJ/NrFWvND78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAr/dYSarv4F5Wwto1tsklIaUHTmKOKHwc7aaZZowWs=;
 b=JJ9zDKgVNv7T4F0IXEQplPpfdD5vU2lcA46twxu8xC2F+IMyMOxKdUiaqXIusKd186HTUN6uzFslUvksCvsBeDMNMzSwniNg8Ft0X5MS9XEjGdmVH53dAZEFstiw0yboSHmfv/T//TPVmP7f/vYBNz2iN5cwYxFugoBHp43tlaAGlbPeRwraWqEkXQHTYd2X9afY+pfFtDD1+QKao9j8pipuz+Q3ZRxURsluNZon8CMvZzXszR+rnTfQofyahDJeME/KJajaDr1FaNXCm+NEVkf+iqXgDcp3tFjDiCQyKPiw1sWuQ9dUXTHd67gRA9xvUQpnS1VD9HABXTAu68AU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAr/dYSarv4F5Wwto1tsklIaUHTmKOKHwc7aaZZowWs=;
 b=xGVcRqQdJoiY30BeDZNa4c+DZSuyg7jWoy3I+Eo9CjHEit8kMvhwbsZFpZBLwTtABszHm4IcPu/aEwfskprQ2bQDv2diH71LmeVnqoAQSVty4bpVraTrBmiHhN0pCikmX/EVbtO6DYl2hZFafcacM0aZdHm52iUSAXAIj2GRt8E=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:18e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 15 Dec
 2021 15:06:55 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 15:06:55 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kernfs: use kernfs_node specific mutex and spinlock.
Date:   Thu, 16 Dec 2021 02:06:38 +1100
Message-Id: <20211215150638.390466-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0131.ausprd01.prod.outlook.com
 (2603:10c6:10:5::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e8b85e6-907d-4069-2be5-08d9bfdc8816
X-MS-TrafficTypeDiagnostic: MW4PR10MB5861:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5861388F2306162D7A4EBEF2B0769@MW4PR10MB5861.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6jie08SC0hT7HNwMmJkoFJbRTwCLSQxrTPpWhcW/U+fsMYsUzcKN48YMJho28xxDCemyoiOO6we4IycPf0H9AmK0Jwi07fkt9ck8JQtEPiL4vDWbQQjcWshMcUo+0qf8LpsT3l0w35ZY4TZ5+Z6M6M+t8zdb7Ea2uy3uZgTSRSTExdj/CwF8AQ+s1g4nkeYiEHJ7KuCn195iLERGfPCo5Q1uV5kR4Zm3vAhUjUINwF5opEBLx4akrhmfX0nXWkjhde39oElDfSCF+npYXQlUEFh2+8s/A4ma6FOulpXd6nT4/abmIksAJxZtWhY4ujINQmt6pyF8IvXr5GU9WTY59lpmsEK1i6MyMPc9tNYW+pyumGxf2tjV7PedzDMtqjHtw6UxDt6bTFNd+ao/4vI0wKXqScLV5oDrseLCtCjklYevurnj/stP0j1KJDvAxL1MefOewE4r+fa64VVv5l690Frw1uzKY8XoTS4xThB0MpdcoWG+j1ndoO8wTKZ8o0yuadxW5GdJLNxOru+yTfMON0YmOyfhL8xm3kJIqNVuINIscKP9t7NXYO71yAHxSzDiHQ/CMPQ8Y4+E43voVuz14DWfDXjAmkm0wAHD0V+tehRt5jBR2sAfAtOKyERGUq0A3Okp3JA1a+RbY3UTMiJNHFVQ03XXYBZyzM/knMZpAzDY1S8+rM/Ccdd4Oa2J6UuWDT1i5bDMx6b4wJZxUf80A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(4326008)(38100700002)(38350700002)(52116002)(66946007)(6486002)(508600001)(83380400001)(186003)(103116003)(8936002)(6666004)(2616005)(86362001)(6506007)(316002)(5660300002)(66556008)(26005)(36756003)(66476007)(2906002)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewMAUztFOYjp+KlCIutJpKc4DLacw/pzKgsMRuiaZVxQxN7+AlghMbuBmnr2?=
 =?us-ascii?Q?7WBetiOGZrjjtJBAFimQreG70HvTpAh63FMQiZ8Lh65qR3RuxkIKHSxYE0gz?=
 =?us-ascii?Q?Sw8R3G5G3BY1aJO2DPrLJKLOYOt9omaMDc3EKf/5Bk/sAIUj+3KZ8cffwv44?=
 =?us-ascii?Q?AbFkJ9mOVDud+ip7eyC12lCM7CWfZgjXwlaLEoaeM0O8jRp4RKFLTM5LSvEW?=
 =?us-ascii?Q?xGYNrXbWe3u1nMtqR9CjsY0YxJhJ1tqxjfuelcUYyTGiEriaj6f+xwlULgE3?=
 =?us-ascii?Q?ddKRnqC3x88v/pKG49kSJZ5v4HI9WGHngzpqnxgQotS9U45j5ywcZ2QMEtuX?=
 =?us-ascii?Q?oDhL13r+OMEkpt3co349PY9Tc8/u9CPBcrpVhIRgd7bzQ8SkUgDNVgQHnlwl?=
 =?us-ascii?Q?JjqcZEs5u45QLWaELmcaC9L7j4SLrlflLQ82LGvHluONuPPW5wNmlDmoenb7?=
 =?us-ascii?Q?8zgrcz40pLCOcmT1iGKUQohXNHwOsljuc6fThVUY3xAlqVPYmJF5HDwOm8dB?=
 =?us-ascii?Q?Nyz48cpbPyGpfc2RYa1VTrq06YZuGn+uubrM3VAV3kg2UHHVj2zixdCWBGxD?=
 =?us-ascii?Q?iT3rH8u6bWeebm8jfL7Te7m5iDGbz6oF4F1nmqdw9u2q8Yvy1soDyGuSYQZq?=
 =?us-ascii?Q?YhgQc16zL1ENwv3PC5/qG2CdJvz8AtkVvwCPQBXNsYAPUQH7stUnWLf0b70E?=
 =?us-ascii?Q?Dgpq77sq6wCfTRRE5Y7adHoU1WWMlO9HMbDcIhx7dVw41++WT4xkRifv2sbO?=
 =?us-ascii?Q?bHeefq5gC4TYnC/Fw3Roedap1R5zPmu+MnB3JVHDTgixO8luE5u/ubmOOaIw?=
 =?us-ascii?Q?lFYMn3BJ5Q61FYLAX4ZOUHRJPVKhmOw8p29zx+tbYn8GAg5nItC5RtWjXbez?=
 =?us-ascii?Q?OcypTewPuKVK3hG4HN0t0YDmRbA5YWy75HWy6uf7t1gOa+gML4N6i+dktENP?=
 =?us-ascii?Q?VK/OGWCqRBkAvTmY0sNeHUF8D27b2tMaX20/RNvgU8aqF3EE+JSXZ4YvRBBl?=
 =?us-ascii?Q?Sxy6zlvnWGEC6r5uJUdgUlsFphMMmzDYmlcp1VJ2S3pydvaZX4CwoifqFrPO?=
 =?us-ascii?Q?sxQufHvt0esA94WfNIAgMp8IHChRltrcou4qowF2EsI7cm7gpXkwLmOR2cgB?=
 =?us-ascii?Q?Nt56IlCA2gvCMfRr3r1lq/MyU+5DSHH33FgRHJpLaxl97zTzFTWBXUBdocCl?=
 =?us-ascii?Q?u5kNruJk/i5TcM0fhoPJ70ulGlgiJ3Fp0S2kCSpWD8S9NKCIwSSaIsN1XEhA?=
 =?us-ascii?Q?093m5NLAiPhNS0As3MvAGJomKNlXRNg9R39Lhuq7igvJeSSwDUFUFTh7CXhL?=
 =?us-ascii?Q?TWzpdoczocRSIVBiCH9cPgFUz6BfS1a02W0bbEUlxHxJhQezn501nk6NzoSO?=
 =?us-ascii?Q?58MreIHhH1RpamaqFmDT6raNpUZyDcEIP7zN1UdgRR/99ggPa8osWq5HZxtS?=
 =?us-ascii?Q?UMD/oXFfo7YeWXrgEsFGC1k5FuvVz3CaGfFr58IH6dnPXGQmNi7U1oTy5g7j?=
 =?us-ascii?Q?+vXAaoh+3t6DS6rahrzzmUSsdr/Rh30ksrTvIMWb+yzB4Rmw6y8lC0D2mDck?=
 =?us-ascii?Q?g/KNwOehJ+zASGEn4RGN6rufX1mwJWFkAO9weCSydt2zE2uETuMmx02iM3jS?=
 =?us-ascii?Q?EcQsk9X0nnUWzFLfEFrindE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8b85e6-907d-4069-2be5-08d9bfdc8816
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 15:06:54.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQAQqFcsdSemj8jmQX1995tiPB0awQwdohyPjBaWDZXRMkPLDqxGUye1swGyyh+ebN0PM1OLwlH4qWZYVlEJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150086
X-Proofpoint-ORIG-GUID: srMnC8DB3fT1rPpH3BFcrOYkoY12h0D2
X-Proofpoint-GUID: srMnC8DB3fT1rPpH3BFcrOYkoY12h0D2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now a global mutex (kernfs_open_file_mutex) protects list of
kernfs_open_file instances corresponding to a sysfs attribute, so even
if different tasks are opening or closing different sysfs files they
can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time. Since each list of kernfs_open_file belongs to a
kernfs_open_node instance which in turn corresponds to one kernfs_node,
move global kernfs_open_file_mutex within kernfs_node so that it does
not block access to kernfs_open_file lists corresponding to other
kernfs_node.

Also since kernfs_node->attr.open points to kernfs_open_node instance
corresponding to the kernfs_node, we can use a kernfs_node specific
spinlock in place of current global spinlock i.e kernfs_open_node_lock.
So make this spinlock local to kernfs_node instance as well.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
I have kept this patch as RFC, as I am not sure if I have overlooked any
scenario(s) where these global locks are needed.

 fs/kernfs/dir.c        |  2 ++
 fs/kernfs/file.c       | 48 +++++++++++++++---------------------------
 include/linux/kernfs.h |  2 ++
 3 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e6d9772ddb4c..cd68ac30f71b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -603,6 +603,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
+	spin_lock_init(&kn->kernfs_open_node_lock);
+	mutex_init(&kn->kernfs_open_file_mutex);
 
 	kn->name = name;
 	kn->mode = mode;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f..4114745d80d5 100644
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
@@ -526,8 +512,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	struct kernfs_open_node *on, *new_on = NULL;
 
  retry:
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
+	mutex_lock(&kn->kernfs_open_file_mutex);
+	spin_lock_irq(&kn->kernfs_open_node_lock);
 
 	if (!kn->attr.open && new_on) {
 		kn->attr.open = new_on;
@@ -540,8 +526,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &on->files);
 	}
 
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irq(&kn->kernfs_open_node_lock);
+	mutex_unlock(&kn->kernfs_open_file_mutex);
 
 	if (on) {
 		kfree(new_on);
@@ -577,8 +563,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	struct kernfs_open_node *on = kn->attr.open;
 	unsigned long flags;
 
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	mutex_lock(&kn->kernfs_open_file_mutex);
+	spin_lock_irqsave(&kn->kernfs_open_node_lock, flags);
 
 	if (of)
 		list_del(&of->list);
@@ -588,8 +574,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	else
 		on = NULL;
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irqrestore(&kn->kernfs_open_node_lock, flags);
+	mutex_unlock(&kn->kernfs_open_file_mutex);
 
 	kfree(on);
 }
@@ -733,7 +719,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(&kn->kernfs_open_file_mutex);
 
 	if (!of->released) {
 		/*
@@ -752,9 +738,9 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 	struct kernfs_open_file *of = kernfs_of(filp);
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		mutex_lock(&kn->kernfs_open_file_mutex);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(&kn->kernfs_open_file_mutex);
 	}
 
 	kernfs_put_open_node(kn, of);
@@ -773,15 +759,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
+	spin_lock_irq(&kn->kernfs_open_node_lock);
 	on = kn->attr.open;
 	if (on)
 		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(&kn->kernfs_open_node_lock);
 	if (!on)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex_lock(&kn->kernfs_open_file_mutex);
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -793,7 +779,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(&kn->kernfs_open_file_mutex);
 
 	kernfs_put_open_node(kn, NULL);
 }
@@ -922,13 +908,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	spin_lock_irqsave(&kn->kernfs_open_node_lock, flags);
 	on = kn->attr.open;
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(&kn->kernfs_open_node_lock, flags);
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9f650986a81b..22cd01477129 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -162,6 +162,8 @@ struct kernfs_node {
 	unsigned short		flags;
 	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
+	spinlock_t kernfs_open_node_lock;
+	struct mutex kernfs_open_file_mutex;
 };
 
 /*

base-commit: 0bafb8f3ebc84525d0ae0fcea22d12151b99312f
-- 
2.30.2

