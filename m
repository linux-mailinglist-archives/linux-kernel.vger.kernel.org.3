Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F24E61C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349466AbiCXKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiCXKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:32:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F36D19C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:31:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22O98S4v009503;
        Thu, 24 Mar 2022 10:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=iI/GmeI6Eq19dSmju4TNY88oGpTTMjcASSUsBMQd4dI=;
 b=mHka2gt3Ji+lmVflJ6cD04Dsz8RsX1WsR+TPJy2rBZNEC1unK5+FJFKbmunvLaFqaftL
 f8J47iP1Ty4apIENGrns9bg4meXkeF4Sh9hISTLD9KEQb27HAS7/mXa1Dyluhq0i0FAx
 ksnOqAaXMNr+1nDkTo65OWTW16jlKaNEQRswYhkaONwm/YO/1m3xgs64e2aQWWAF+ji/
 s7px4sgXpDLiELJdv2UHo2CvsYZbDmqVNI6LpYUO6MBNgxWzyD8L32TrbGF9Ue2E0hlb
 sIm2+KcZ8peB0jvA+ccoqhFbNbgxPI9NBc/IGC0tHR9AwlOBCjshe3Wm4RJMyJda2l0Z KQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72akng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 10:30:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OAUvOl178201;
        Thu, 24 Mar 2022 10:30:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3ew701r594-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 10:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc1Q/VF/lW790ZzGJDHtUoBKRomMr1Y2bhviqScJT3wq97byoNKhWAWuESAMl5o2F4iSEPua62NYhjwdosph1FLWIHn/HZHlzCWYJBJyKxYbBH5B6HIrLyd8hmV7qAgotT9mGenNEbtLlBX71sTAdJzS9qet0kX4hOhb2Gx8UgUX/cZt8k86y6Gpm/hJAhEUh9CFuqpTiSdXHzEx8mGzqpDqzQuSWMJyqdd+CBh1nVnfIjFHcZkOKb4PjLDc9uqIe5S4Ma0E3TjuSaJeH7+bx/+g1OZNiyJ0+pW8i4mwN/4x60/aZPnhEn31rXTJQLBj0Knnud8EHlUNsTkivVCd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI/GmeI6Eq19dSmju4TNY88oGpTTMjcASSUsBMQd4dI=;
 b=Rbkk1mlvXWrMg/+ahTPHSLELNn4p9zc3RVUq6GPG/1xHtygsIBqfvo6JWdO/LZQ2ngqX3YPAoqcIDIlHcTanxG7NZRasfJur5CaMJYMCt7c6XJi4zZN+SvkX6YmkGzNULnzmBbvAfRGIBf6SMiWgKVLTroCRfKWDmmIks5lfs8azD5X7U4jIGYZuuoINH33XZGuM74Q500fylTqJarEYmtNG3jXGaJQgaosCUWI8PrLmytpJdshcNKtb6eA0ZfDO387CCDDN8kPh1ZHivFrN6IuB/rLo8tI/E0m66o0FfF4iWRuU6WEnAExW1l0ApKPH4MJcX3u5ICuZBJ93h25bJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI/GmeI6Eq19dSmju4TNY88oGpTTMjcASSUsBMQd4dI=;
 b=kSG6CCJx9y4IUG0eP8jfyo/2hP3aiOKAFVjm9oytyHbTaXaVn5litjEz187TjxXqFiu00qqR0/s+dVfn19M++2l1g+OWzdJrCJnsPkgWuXc3PiaTfbQ0yMSwcWqUJ9lpEtsMzMUTMrcuWXQ5CyObS8FCTmh44DY5Xymawum8rng=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3981.namprd10.prod.outlook.com (2603:10b6:208:183::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 10:30:56 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 10:30:55 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kernfs: Remove reference counting for kernfs_open_node.
Date:   Thu, 24 Mar 2022 21:30:39 +1100
Message-Id: <20220324103040.584491-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220324103040.584491-1-imran.f.khan@oracle.com>
References: <20220324103040.584491-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::7) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aba9efa6-ba0d-4d77-5fbf-08da0d816118
X-MS-TrafficTypeDiagnostic: MN2PR10MB3981:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB39818735E29EB47DADD2B4E1B0199@MN2PR10MB3981.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AvTPbioNXCdTiiNX4Oqgl7VRpPgzLUn0GPBJBARSEbzGf5To74Nbpp5Xb7DYiPBngmyKRkMvMmaRpi2TsO0WDSMuBqPgEc5yXhIZjP+JjXDy/oia1HbEttFZ8/nKCobiGi4n4daVF1MIkpG7U4rgWZhuZICTd63gwyxW5J/9fdfPqt5AgICBDQa4AzKxYhZwIgdDDSrkD9LxUNLhAhJWNisULKgJdtUlAwIC2HDaaLwUcR/I0AKS5/fwdJQICPyMvTMx5XxGRQxRAkpluyX1Ut9EOJvi8A4x9DiuXCkKabWnqN087ZTiz1LwCnR+t6dNJwKe5k69rp/RiPm4G5ZiXAT/H1n/9O0vs1LiuFrIya6Fnbo9pO4ZPIcPbAc7k5vQ3Hr44sz44Sn4bwJ4ND2Zcuo0lAxqSdkSLv1kHhZzQ+zWlw2dfmWlvk77zxyRYP1/PMubsUPC+3W+LTpgPzYgxU6VQbCS2OJSSvpQ2gZc6Ei6903/rI4wXCJc8EUWz3T3gc1k/GKDRsLJFQ1uZLngoXZl0uVqAaNo3ZRWnBD6uUapkvJhQCfLC93QhXHZxT1oBmls2hj2KAc8tnAECB+0SBKI8MWIjVOttqvi/hL9UrfUMI7fHhFAd2wGUKdTg1QmQsUD9Kqy7hy9TSPKh3PBH+7UW0x+nxA8T3YfOsIhcc3kc2Ws9VKJTvTPtY3/HOdwIIWW3wLClibqO3ZmaYbpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(1076003)(83380400001)(86362001)(38350700002)(508600001)(2616005)(186003)(2906002)(26005)(38100700002)(6666004)(5660300002)(6506007)(6512007)(8936002)(52116002)(4326008)(66946007)(66556008)(316002)(66476007)(103116003)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8ZPHnh9ayArgNZxPOvzORkipCv+a3c06QvSYwbTS5GXYdiZTrCNgwG/F8Jf?=
 =?us-ascii?Q?VV0NiZs/vLkrQ3Gxka1MZsSevy9cmHn6PzFwMvtpvUpGh0W+/qW44sLzLOUO?=
 =?us-ascii?Q?cb5yD+DZWBRhyJPpHZLFi2uILVcmdOZ71fqgA2Q0gqcgLCSTY3GHnK/vZed3?=
 =?us-ascii?Q?OeLTFKu1lFuhESD53t7gdS5dcl4RNYVWLfBfyfKuZe7NP4HSHnaLQPI9B0Ix?=
 =?us-ascii?Q?+moNqeMaDrdByQ2zfTSN+v9ZWxzPbBbrkYLHVsUZ7lLUm4cFu7ypYY0DltsI?=
 =?us-ascii?Q?KcwZgsdIOYXFgTRcft0wMhWFjSWK6hH24mQXDvfLiq4TulToY8iJyhXcilXB?=
 =?us-ascii?Q?U5uks8HiSsozNI/0E5ERvsZiY1zh9nKXii3XfjaIL1T3XS+zGFRwKMNhSK8L?=
 =?us-ascii?Q?8bktCB1TtBLaM8b3J+Llit+qwA/iDOVuA+ESWGxXL1kLSJIyYs8QxhhQViNc?=
 =?us-ascii?Q?xrbu+jhTrGViXcQHhS72WxZlRQ3VV/LlBAgFcEiawxykgMxq2MS3hxXubL21?=
 =?us-ascii?Q?TjdjzdmgsUbQcnBuMqHF5uKnkgDXKRpVDtaWu/yeB5wcOF+BmyYx/sGsjnBl?=
 =?us-ascii?Q?iullYfhD9gKdEIGUbaKRqbs16FtUVcrPiz/6g3+CKs+Bgh9YA+r7ETSlW9Fk?=
 =?us-ascii?Q?4Y7dvj4lS3jv+vTlK1cwwiZk/ap4Ha5GRKPnYl8YNJ+W9B/pbmEPoh/ErKSv?=
 =?us-ascii?Q?TdQv0J3YBxbEWunUUuoi/WvKIl8vuArDAEZ8OlFTU+6bR5k7/tCi7xLPYe4O?=
 =?us-ascii?Q?v8NUO+ag0L60EVolQ5l6X+Uj+x9PIQpenghLb74xiinPKw5Ikm/TN/n5qMt/?=
 =?us-ascii?Q?O7BJjpYj4+zJ0aqCckMRKU5suxOD7uUV+3xlx7GuH7Or2QeINuebjqWDYCI9?=
 =?us-ascii?Q?FD2TJykRdGhGGMriyer+H5Z8Hi66fKt5r/+vBlDkeQq4aKhiZpW0ugxyNf30?=
 =?us-ascii?Q?mvlxOAyU4Zlwo4LSboY7MlYGslbBTOHH1Lgx48meftmEoNlFG3J2ODdojQSH?=
 =?us-ascii?Q?50oQv4NhQBF8hE4N1zk3xJvAbLvGHmWBCDvm8hVspjjmbZ7c1MH8mK1Bh2JO?=
 =?us-ascii?Q?a9mAmmZ4czNVGElNAUiCpglikaH5n/StXhXbQPrdLeTeu7w5MgOjK7Ptczj3?=
 =?us-ascii?Q?OxYxZa6PTLWKP8QJu42GIhk1t5ZxsA0Jc9SSjVuqE3DXLR6+KDsPMkAuh8ET?=
 =?us-ascii?Q?EvUcHy8GkXtZ6XSgU0qqGG/4vxRjEgaK1OZUG1+2HXBeWEOrbG9OUTUDRuH4?=
 =?us-ascii?Q?c9+2jdg6BdtFErpF2HYZNKbrcr8FXR3Yx1bXh4MFjMc/iLCsZzZuAf1JQzFj?=
 =?us-ascii?Q?s1H0N3YLdHeNy/uYBGcBJ2evYTzyyosub5p1cv/SPS6Q/utamXp6BeQHfl2+?=
 =?us-ascii?Q?SjwW4yd0Y9WuY1n1rCXHK7eQ6KM8+Q/Ts1oKsP0qe1ypZduQ0MJGFNdwCUfF?=
 =?us-ascii?Q?tOjhAh595PT7In/bFtHnQq03HM5p/xbQOPgdOCJJ4+ddoxpr0Xw+5A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba9efa6-ba0d-4d77-5fbf-08da0d816118
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 10:30:55.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZhQfmXVgy/fxvB0oookNtlwJpnU1STA9gRwBxwDUs4To3zeHAShNLFbTCcTcwRXI+130ySxBRACmijhz5JcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240061
X-Proofpoint-GUID: QTaKTj7lUx-wcncK8X2j2zBjEoY_e2hO
X-Proofpoint-ORIG-GUID: QTaKTj7lUx-wcncK8X2j2zBjEoY_e2hO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decision to free kernfs_open_node object in kernfs_put_open_node can
be taken based on whether kernfs_open_node->files list is empty or not. As
far as kernfs_drain_open_files is concerned it can't overlap with
kernfs_fops_open and hence can check for ->attr.open optimistically
(if ->attr.open is NULL) or under kernfs_open_file_mutex (if it needs to
traverse the ->files list.) Thus kernfs_drain_open_files can work w/o ref
counting involved kernfs_open_node as well.
So remove ->refcnt and modify the above mentioned users accordingly.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 88423069407c..aea6968c979e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -33,7 +33,6 @@ static DEFINE_SPINLOCK(kernfs_open_node_lock);
 static DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
-	atomic_t		refcnt;
 	atomic_t		event;
 	wait_queue_head_t	poll;
 	struct list_head	files; /* goes through kernfs_open_file.list */
@@ -530,10 +529,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	}
 
 	on = kn->attr.open;
-	if (on) {
-		atomic_inc(&on->refcnt);
+	if (on)
 		list_add_tail(&of->list, &on->files);
-	}
 
 	spin_unlock_irq(&kernfs_open_node_lock);
 	mutex_unlock(&kernfs_open_file_mutex);
@@ -548,7 +545,6 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	if (!new_on)
 		return -ENOMEM;
 
-	atomic_set(&new_on->refcnt, 0);
 	atomic_set(&new_on->event, 1);
 	init_waitqueue_head(&new_on->poll);
 	INIT_LIST_HEAD(&new_on->files);
@@ -557,11 +553,12 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 
 /**
  *	kernfs_put_open_node - put kernfs_open_node
- *	@kn: target kernfs_nodet
+ *	@kn: target kernfs_node
  *	@of: associated kernfs_open_file
  *
  *	Put @kn->attr.open and unlink @of from the files list.  If
- *	reference count reaches zero, disassociate and free it.
+ *	list of associated open files becomes empty, disassociate and
+ *	free kernfs_open_node.
  *
  *	LOCKING:
  *	None.
@@ -578,7 +575,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	if (of)
 		list_del(&of->list);
 
-	if (atomic_dec_and_test(&on->refcnt))
+	if (list_empty(&on->files))
 		kn->attr.open = NULL;
 	else
 		on = NULL;
@@ -768,15 +765,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
 	on = kn->attr.open;
-	if (on)
-		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
 	if (!on)
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
+	if (!kn->attr.open) {
+		mutex_unlock(&kernfs_open_file_mutex);
+		return;
+	}
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -789,8 +786,6 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	}
 
 	mutex_unlock(&kernfs_open_file_mutex);
-
-	kernfs_put_open_node(kn, NULL);
 }
 
 /*
-- 
2.30.2

