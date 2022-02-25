Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5004C3D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiBYFWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiBYFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:22:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EEC39B81
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:21:41 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4dJ25030077;
        Fri, 25 Feb 2022 05:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=SYuIxv/RqoNVWUmbbv+At0lYarOex6TIOn08Yr8eGkk=;
 b=shn1/wBI0gImsDq9LsFPndd5A560tyYsR+7U1LpRPMUbwo0pYSo13vHTTiHF3uAB6p/Q
 TfhT5cSxNQ0zvKq+NxXFolNTSqDKfgUVVcVVeF2ZuER02Zq09VpFQi+64IxbmBpKwbpc
 o7HaBg3HeGu9WYmCh+2JHc1Oj2AEskOvcYngsdGPhz5aGp8vfO9URuFcB5PuQSBsseIp
 kg/fP5/rtF9aiYFH7c0L/btAEzPmLAyOoZQLM/9bc/Io2OfQ3KTEws0WcHeLPBuOCWEv
 KlTaGmmhJG+cNoJGErdjv1xizBJ4whJpFk3YgSf4KsIAg0Hfaf4qxDV06U9VJjY2BQRk AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7as9aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5AxFM181362;
        Fri, 25 Feb 2022 05:21:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 3eapkm8a3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnTaQIxNEx/xFBgYWc/D8WbnDx4mrJC/U+iH3dCpCtkql3zZ8MXXuqhP/J3zfyBmzXvtoUntcMtCPbMRaUgh2Va+QjjUhP3wsyHkiyQ9DpTngKS5t1T3EKcUQQpxhLAgLpMIQ6B7DVUr1c5tI8jSUC9lZqrynp4arg37+ekEGaA+ZhmJ+xu673QOl49x0SyTVjOQ2WR3XJGNzaP3wCkTMpFZwzoSA1GCk5NimD0yafk63E9bth3X8y+S40he3rQBa+DpJmajnUF8xWDAH4Tlio0fLrtzBKMmUGWkpA9J5rnizaBvpQ0A8L8YYzqugoZOddSAaluKIe1iJtRMN5Wwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYuIxv/RqoNVWUmbbv+At0lYarOex6TIOn08Yr8eGkk=;
 b=c7mmm5UbNBtvBROo9mOdMIvp1+XzWFiGwGK4SqJY4w43oIxcJR5Ppsy8i64DBiqkvVWLnva/hRx+OXVRrRBJM5FNaA1r9pf8JlyzxdPtVAnulDkEF+5gapAUECqjPmjx3/ctxpkMe0m4+TTFopiAVe9uf8aVMLYxDrpr6xrEyzbSUHmN10bHUBAlt5r48qU8zaOggUgHDvLV11VHECIbLw62q92+nC7zHRcAgFN2ExvH/+l8fzf1+TiiXZsu9oJWsFcX0VLWVkVtjNTfaStxTPrFuHWu3jMkm32fDmL0l+V40p+Yws4ow8LhBPAWQkyzZMOiq8EFXg1uEDeJboGG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYuIxv/RqoNVWUmbbv+At0lYarOex6TIOn08Yr8eGkk=;
 b=uzVgo4VIgVqz+2cobhr5sDDAbbqJ5+TRjiXGvpVnPX20gW02BZJUIGxopXlYi9sGmmdkJS5TPfVmY9ruGyt6nhR9fE+hd4iUL0r+fCef8EDxZCw3Zobp5zHWZwcVUkTHYl87xPJ8EbVkpc/b3id+J1hmdGrmmxnhZlKMFkhVcaI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1677.namprd10.prod.outlook.com (2603:10b6:301:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 05:21:32 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:21:32 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/8] kernfs: Introduce interface to access kernfs_open_node_lock.
Date:   Fri, 25 Feb 2022 16:21:11 +1100
Message-Id: <20220225052116.1243150-4-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225052116.1243150-1-imran.f.khan@oracle.com>
References: <20220225052116.1243150-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0043.ausprd01.prod.outlook.com (2603:10c6:1:1::31)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc7a619e-7d9f-4749-cb8e-08d9f81eaf59
X-MS-TrafficTypeDiagnostic: MWHPR10MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16770251A95AC22C36AD3A2AB03E9@MWHPR10MB1677.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5us2CGb1Z19EpRTMlueXeNqxTnffwTZoLPRhUjUuVWCwWAqq3dd0MN8QJ+7v8xvJtZkfB9ZsrWgeQN8elU0Oc9A3rMsdtcHCy0NDTHJD/3qY+DLL1mFx5VQ3sgm6whSiXMAl3ffaRJUEt/IBKwgvueuSrAnfRlJ/TGpJhkxXV3meD+k4MqjhDEsQ4q18HQQO5jehyne5pUfPxSrovr6nGWMqy7S/mQZ+flk6GZA32l/8DfhHWy2JPfA/ryFr4WVrh5YNPTX9i27ljlltFWDRVNRHeuwrdsaOsBFmXwFvKfJiv5pGJl1DpWkT83c32LNZUQ2+77QPG2fVpj4mb3JI/vpZC8iZTbswqKQERHr2e4KWNWHRsojaswfoqWCJkoChywXFE3RiHezglZTQO9q2qtsYRP9wgMygehB3DLYH5i4OHtcGFI69z3cNSkSAq8jiqHj4RL9413USwlEH2F4WZftijEhnPXlCI/n1gF4OuNYiPJaPJITMFtwozZ0EBRXiH9LslFkkDbTYSmXKZgahkFNyoYDoj1SblK0g8r7LYXunEeokTWE+VN8/PUKjJKLtLAF6vsZFo4YEteygbNDezwdRzhICvb2aY+XN3ctDlUohH+pU+vf57AibQpOvcRfX5wA9MantHkIAaGYDrFaCJmlY/tkiwi+rAUTNPkTv70a6Ifo4VqvyvCpn69BiYlwbqFxrSx4l8OCQde/aLdx4Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(38350700002)(6666004)(8936002)(38100700002)(83380400001)(1076003)(6512007)(508600001)(86362001)(6486002)(6506007)(2906002)(52116002)(316002)(66946007)(36756003)(4326008)(5660300002)(8676002)(66476007)(103116003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARRnQsWlZeG8hDwPx26Lp2/AYR5EhdpbmqbrgYYEOCzSeXApXuwPW17oAvAx?=
 =?us-ascii?Q?UiGcpY0gkIXZlqoxtBNsRLvy57lli7K2p8e7DzGRaxl8m2TYQVjpFeMvKc4Z?=
 =?us-ascii?Q?NkuuIDse2/rY/vInx/wb2z02rH5QRtVKtogE699WhG3P2bKX3kxC2sz8WdNp?=
 =?us-ascii?Q?pyAjUrB/MiLHOd++a1s6SHcyyWVjzKpYKnOAC8YNiM5BComyn9bGnpcTkqCL?=
 =?us-ascii?Q?nu+ZmQwLkdLFhK+o92njpPd7njasax827wCWhbwZjQ5CRzMiVjfePTOzbXIg?=
 =?us-ascii?Q?4VrYA8Mg9E+sI5Y6oUCoSCXGPUyeKe3cqtCu5Um1OzMMoAh88SouQP6rozEl?=
 =?us-ascii?Q?jgEtYMXteUyfLtwCDGTengQwGK0L5GE0Br7zHbqQ7bVwmghybbG+XWum0n7x?=
 =?us-ascii?Q?OvvcgYwTvdnUk5Dzc0l/NylbqfHVTk4uI7/Gq9w4fUjem9rQJkKLhRU8bqp/?=
 =?us-ascii?Q?/vOf+Ti16iFQuRac6NNp4jQLoZ9ULal744Sxf+A0n48ogP8/6GzA5SwVoiAL?=
 =?us-ascii?Q?gRZfgxpx7hWQlHLgQMY5X5pm43kRCb11eeOMGEtonIu6/Vc8hvhUljggrCs0?=
 =?us-ascii?Q?osKEnAUu3seyMcv3Kql/6aY/no61J/nRjwM0uiA4Hyq5+EMe/Ech91QYMeCz?=
 =?us-ascii?Q?kXIe/C21oX0rElhBVZVOxkgkIjxsrKeG+OkiANBYarFfge+HqHrtNxMFpzRf?=
 =?us-ascii?Q?kH3PKIECMyNNfeahf1OcgImZqR+vk9loss+dPOyoYXbXUcWFCTREi8FE+yZ1?=
 =?us-ascii?Q?vSidGsyW1K0gqLzJlw4IJzAeDI+4mxwfGrCaEEiTcz+KmQS46D7PnGCYG+iy?=
 =?us-ascii?Q?QwDMb28fdyCAdZx22/ij8/JED4zU/nVAbcq1Ub/9tYiAYFX322cOexxvxdRB?=
 =?us-ascii?Q?OF4SSTfTVP5REf9ktf4f2ucxbxXT6MalnNbSfYT9WalwmSJY3X7Wq3Jlx17a?=
 =?us-ascii?Q?GHTV+qrK1PUSrDyq/DxCddkkwTtpcYanf+wyt0U+/RJ/ktZ9w93CmPya2pNF?=
 =?us-ascii?Q?Jn4XwUua3CJYefKLF1kc+nl/0kp/Xv5BzCyu6RmVQrK9nnDgARTI/UOKnJ9T?=
 =?us-ascii?Q?+KTIBVqCQpP0J6cZdh54T6xw1BohY+38yuM12fNnmG3JWZ8ElS9CLzGFy7Tb?=
 =?us-ascii?Q?KzNKZtz5DtRVE253r8iX0r3a2OIi/j5TtuXMNO+bKSD+W2iD9q2DMrsUQCoV?=
 =?us-ascii?Q?Ykj/0T3ql2EcAcaHwOIC2qimZzqdVJfMrkhMZjwNP8FlrkmcSE/iH3vs5HE0?=
 =?us-ascii?Q?xP5g4cZyNYrb2EQ41vjqLY0G9SI1blbyI/IBaBdjh5sluAsq4glkcwsvs14L?=
 =?us-ascii?Q?+eEIgoPpwjqptRtkoUhJk/kT9BufTga2WnB19SG9VHMAxGhPqsM/SO6rEsGq?=
 =?us-ascii?Q?LD00atvtDwU2VIDZs54hFWKMMYevS09rkWqMajAaQx9t0PSmuqyNFMH/heyJ?=
 =?us-ascii?Q?4tjrKG9Upo4xGi3e5R98ev7senH9nvxHmN8FezsNFjBEboXw3dKl/djwZ53Q?=
 =?us-ascii?Q?3ZiZNOg3tSXFTBb6BPmtp9maEFqLTnUpP8BH6zZ4sa4PnvlGY+REp/revMVv?=
 =?us-ascii?Q?wo7IZDlb21CFEVmSY2JilSHQDJpZwxaCJhIVoVdRAu81lyoOxgy9M2mXjrsb?=
 =?us-ascii?Q?A2OP5T3z1cflTcGAilJ+zZY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7a619e-7d9f-4749-cb8e-08d9f81eaf59
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:21:32.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /irrbPyDets1HF+27Nd7ggrKMVW9JdzJ2ibe7K4/kdAkZ35xoecKQimZ3XOh4c6JrOZQTNaFNG7ArKeSfD0BZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250027
X-Proofpoint-GUID: 2ywVi-D39Ir_gM4I27GcVYzbcssRoOld
X-Proofpoint-ORIG-GUID: 2ywVi-D39Ir_gM4I27GcVYzbcssRoOld
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having an interface allows to change the underlying locking mechanism
without needing to change the user of the lock. For example next patch
modifies this interface to make use of hashed spinlocks in place of global
kernfs_open_node_lock.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            | 23 ++++++++++++++---------
 fs/kernfs/kernfs-internal.h | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8996b00568c38..1658bfa048df3 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -25,7 +25,7 @@
  * filp->private_data points to seq_file whose ->private points to
  * kernfs_open_file.
  */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
+DEFINE_SPINLOCK(kernfs_open_node_lock);
 
 struct kernfs_open_node {
 	atomic_t		refcnt;
@@ -515,10 +515,11 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on, *new_on = NULL;
 	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 
  retry:
 	mutex = kernfs_open_file_mutex_lock(kn);
-	spin_lock_irq(&kernfs_open_node_lock);
+	lock = kernfs_open_node_spinlock(kn);
 
 	if (!kn->attr.open && new_on) {
 		kn->attr.open = new_on;
@@ -531,7 +532,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &on->files);
 	}
 
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(lock);
 	mutex_unlock(mutex);
 
 	if (on) {
@@ -567,10 +568,13 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on = kn->attr.open;
 	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 	unsigned long flags;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	lock = kernfs_open_node_spinlock_ptr(kn);
+
+	spin_lock_irqsave(lock, flags);
 
 	if (of)
 		list_del(&of->list);
@@ -580,7 +584,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	else
 		on = NULL;
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(lock, flags);
 	mutex_unlock(mutex);
 
 	kfree(on);
@@ -763,15 +767,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
 	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
+	lock = kernfs_open_node_spinlock(kn);
 	on = kn->attr.open;
 	if (on)
 		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(lock);
 	if (!on)
 		return;
 
@@ -916,13 +921,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	spin_lock_irqsave(kernfs_open_node_spinlock_ptr(kn), flags);
 	on = kn->attr.open;
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(kernfs_open_node_spinlock_ptr(kn), flags);
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 03e983953eda4..ef5b04d43ef1b 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -152,6 +152,8 @@ extern const struct inode_operations kernfs_symlink_iops;
  */
 extern struct kernfs_global_locks *kernfs_locks;
 
+extern spinlock_t kernfs_open_node_lock;
+
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
 	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
@@ -170,4 +172,20 @@ static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
 	return lock;
 }
 
+static inline spinlock_t *kernfs_open_node_spinlock_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_open_node_lock;
+}
+
+static inline spinlock_t *kernfs_open_node_spinlock(struct kernfs_node *kn)
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
-- 
2.30.2

