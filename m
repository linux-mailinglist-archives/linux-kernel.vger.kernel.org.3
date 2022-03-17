Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342E4DC020
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiCQH2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiCQH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:27:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5236E1266
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3Rgg3030868;
        Thu, 17 Mar 2022 07:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BY8LCocKc1lJTuCSvV1cG3vOF5DxrJVlY7bCZOXl4xQ=;
 b=pFlTpVYNwTLK7ztQIR2ckYXWjNn/FQhkmjTGWyuKoWobkO7JAyVKugOdrY8IJwhUrqLX
 FZJSM3jOxxAlFsnMtjUKjkgn5HrNm9lrbpvZUIAV694kUdpY2eyPv8ah3cvU6HGmdHLR
 sXgekSlQwjw+3b3UbQSUtpDJnbx5alPuG/Zr9KZPoqhOFtRyViJ3GAwQ6YFCdXX6T34y
 0sZvc05vFWMzPA6vx4Ngn0W159JWXg5ls9rTXjT2er49Is0qVMVy9/o7GKBYJGMjoSmN
 n89ANe7daUfSNqwfCyJd71CEs2fKcX0oRXl/z/q91ZQ3zWXAqbgFcg/SrxxCiq+wTAfF DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6reud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7BtLh180978;
        Thu, 17 Mar 2022 07:26:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3et65q1va9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et4WlHJmJXkHd3U0rBRWLqpvNyypJUJIGxOOm3o3bcz2XBi7XI49g8+cPkIhLPBfxG2VttJMfIeVw2xJV7VYJDG7vJEjeLeuA75ononcXw7Tq3hNwoDcBfpkWBAFILYUnvUE0cRCH2FzFoVkdX3omthxdpyoassEd0O72SGQrYSAsfATl5xx90V37/ckOvrrrWz6HAW6aUpURfY5j1sCLi1irOrsV3k0VXaEk4wKCiYKl6rJtlsVxR9PYdW1Y40eAtlmEkvLxr6GVOiiMY5FfbjO6/7DYkq8c7oybb6tSg//WVJ6Edxmb9UWGXri2dfx3LDiXCtCoJsdoJ6H+kx9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY8LCocKc1lJTuCSvV1cG3vOF5DxrJVlY7bCZOXl4xQ=;
 b=e6pTtAveyyh5db7goHIja0c6roeMwTErlualjEJUkP86h6+YoN7CvAJ+hzpwbEpXi87oabtMawQlw5qoqzDpk8NAhETlkoXeN5gQhXbzL/MF09oYZGn1cSFtlcUOfbRIwI/U7n1iWNnmlxj5X+BklPf70u4F8xnKjG+xVD7L4oJHY3PmZdE6AEb5S+eHWU8HYmMCROtd0xoE9cex7zIRNK94yozLNzPkpJyDtQaCvM5T06xaxd8j/cxQC1lZGJ+0mkOhtVnpItQnyXXWl8maWSbl9fFZWJuTzlMd/Pv+mGqEKu7klSKISGySitZN4WnZzDgH0AuIAXFY9mlzVcgspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY8LCocKc1lJTuCSvV1cG3vOF5DxrJVlY7bCZOXl4xQ=;
 b=jedf1Lk8Sqhp47UVaS0nERLw/5Y8aPzbLc8P/anFpDZl4ZG6AVjw7DZDw0aBti6RzpEhsTtOrrEClYUBnnD/prHQ7GMCN+fbMAPuxNDTvubKKLfJ3Wb1I6MvHapDoI7/H5rBT8V20unJNXuVMIknHnewbUNa/w6c/dfFQ+IYnbo=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB3067.namprd10.prod.outlook.com (2603:10b6:5:6e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 07:26:34 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:34 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 5/8] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
Date:   Thu, 17 Mar 2022 18:26:09 +1100
Message-Id: <20220317072612.163143-6-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90972759-7b9a-41d3-9896-08da07e776ec
X-MS-TrafficTypeDiagnostic: DM6PR10MB3067:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB30675EB4D2990787804E9965B0129@DM6PR10MB3067.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07XR1ckCCVy+zs8Sq3udXBW3vF9WmXQjmSGL0ImdouOHKTApNentSpYnzSSTkxCpx6m5zbU3zqJgUaSWqKPAsiLacdDAyi2ehfiuYA2g8t4ChUgFDt3LkuXvXLQUcr6xwe/U8ECTsZONl3ml/fYhz0ZrYyTHAPFk9mraY6vBYSQ2Zhedfqu5Hev7tswyTG2XkNvwiryLjvhg/eVS91mWVslrf15nguReQSaT2ye3EspiYBHs1p0I8N1NpX0CNpbWqPS2A2yOffsolBNJPUsvJL/n/+wLqdn+SlZj11qjBMuhiCLvubpfPZ1hjbGv+LcMtY3iKsfrQrZg8xiE5hZpFdu53kj81xLCJo5l058whqJxcmLK2SINq+H4iBvdn66t06qQIJleGf19oYaq5ZYhm+eQRTTXxmucWFXeok1kMYZmx+BnAw0ZZpZTV3FfcY4f9EsTWAV20A+nbBFb2fSm5Mf8Db4qRnfhhAOVSbvgE7XWWBs/5HNCtTPtQ6gcqkDZNA1Syhn24UR/R4vO5UybEK0MnSjCJwwivzxsSyehpdXtQnDYSXweF6c02cns4I710bQpLWwNvSvvJVZhei8JvpCdWJEWdD9eAHTaeyBgshW8L4Nu06eB7yLRef3h2NJQzJujkclFfs8zNZEe6irXSdKhcXVeMkIrp8YGzmjKrVGo0teHJQh2Th2WOkiBnN/eFR/jKvj6FRvV//qPGPobRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(2616005)(26005)(186003)(6506007)(6512007)(6666004)(52116002)(2906002)(83380400001)(5660300002)(8936002)(508600001)(6486002)(66476007)(66946007)(66556008)(4326008)(8676002)(316002)(38350700002)(38100700002)(103116003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qhN5PC4ud7KKpG4kbCGinVDkUL44hvyUtqE80wkYbeU/rak++3nPdjmRvmei?=
 =?us-ascii?Q?s+i5E5GEmpFaC6lqKlwuFcozLjm5qfGQxCW7SyWzIUDTKN3BGOjRIPOSH923?=
 =?us-ascii?Q?9IoOGtkkITA/+V0VCbNxk9CzQQSC9fg/I3m3RhmYloJXHkb19p1SCsiR6pJX?=
 =?us-ascii?Q?xewk09xKi/tJVi33YGgP3Z1ao+XnygenXTNwaBpi1n8wUshlvSFJSKny8Leb?=
 =?us-ascii?Q?lUTJXHE9lr/7OdlKXd3mi2GKpfxzXhAc5pNDZr8RAHJQln+leqlubj6gQRQ2?=
 =?us-ascii?Q?w2x/QZA8xMouzocjClXntfELv3jCYlQ5IhAUWnHUlufxuP7+th60gHEK2n/I?=
 =?us-ascii?Q?dUjI5BKPXsmK/ovQ5uB/hObE77au3nDCMJpFQMxi8u9YkOtHkQqYcQSecpW0?=
 =?us-ascii?Q?f/tIxm15a7iNCYg+qMTME+11hTpjeAgy96sUrvHQanpWMJHLdeBekSy/lbRD?=
 =?us-ascii?Q?b1eaNrMZRe8tQKFSyX/1VXvhrEgPs9oCmb5qoZqE3SXkEdbcPB+cHLuhtccB?=
 =?us-ascii?Q?eYe6hDTrR51ryl+nvWFKvLfJlNL+KE1YUt8DfsMnwq8onlCizQ0V3iX4GPB1?=
 =?us-ascii?Q?7LtglFYiN6kjC0ogoUc5GIRK/SOenx0GGikkwtsg3FHXFQEjXwngw2Y8xFgS?=
 =?us-ascii?Q?gWppkabS9wOOa1WMsBXai4kIb6AuSpnc4SnYva42fvUffQussJUcMf5mod5h?=
 =?us-ascii?Q?RnoXTv1LTT/Dr+swa2Rmp1wet59H2aVAk2Vetag00WaJgYUHwNs7hmFtUV5N?=
 =?us-ascii?Q?IQly4EHjNeHbUZndNSaE4xNgdedENFgpgCXG/OfRO7tjf+i8dCYDA3H2P9vH?=
 =?us-ascii?Q?4anef04vRYVE++2jubsFsfy/S4ftvnRzbQ2mF+u6eYroFYJwU8Vvkh1rjqJm?=
 =?us-ascii?Q?1QfNNWjJczLlZMDpuzYh2GXTsxiRpTunLL+y/2kTcz8Ur7b8PXp+kG+R9d/m?=
 =?us-ascii?Q?p1bmgWp10qBm3ir9W1CDI05mxx0J+cMAZh35Ju9n+IKGXltjOpjUqCys64GJ?=
 =?us-ascii?Q?EoEAQZ9shHfzaOxMjmnXzVY2Vsw6w6i90NEixIGuUwhJrthzGVB4yOvhrMDq?=
 =?us-ascii?Q?2YUIZmb3PwCkjdlR/EuqTNFlFV7mTtDuTJ4/61kNkrjKUzHfxMWtARl0KZTr?=
 =?us-ascii?Q?szaDdC0Zf9g1rK/vl7T9FzyHMIS3CuraznxK6Vyu0h2Ve1pyuaV8AJVAkXp1?=
 =?us-ascii?Q?E0a1vIIWdo4iFz8pI62seb5cbNquhkQiWRVRdIkEoDqU6wD1h0BLE/lerMmT?=
 =?us-ascii?Q?efjKy8aVz9breVqMXjUBmYyuUChTkfNVuo6ZuzHQa1A6zM3MIZzO+gseVUKB?=
 =?us-ascii?Q?uc03bo4IncWdentXcKqXf3IoM0/ptYkfBuT3B2Gk1FX4p6N73ffQ3+hFNj+G?=
 =?us-ascii?Q?7jrRaApikxINppcCbTBRfMZRj9/+AqnqaVW+YGSpUTreEJ4XmGoeqnANizXz?=
 =?us-ascii?Q?PsZoyPaBAGO5S989/klkouNM/Zislp//s2djdrJHa90PiXMtYI79tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90972759-7b9a-41d3-9896-08da07e776ec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:34.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cikg3ytatxaaj9wx9eLmjE4WSDpjqhTiaX6a2wdPuMAqOmzGE9tGVjjyYzE56umdgSiT66nwwhwF2hIvVFSQKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3067
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170042
X-Proofpoint-GUID: 1xu4gxu9_iuBgM3bgUZO7bTY6qQ33CQ5
X-Proofpoint-ORIG-GUID: 1xu4gxu9_iuBgM3bgUZO7bTY6qQ33CQ5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now per-fs kernfs_rwsem protects list of kernfs_super_info instances
for a kernfs_root. Since kernfs_rwsem is used to synchronize several other
operations across kernfs and since most of these operations don't impact
kernfs_super_info, we can use a separate per-fs rwsem to synchronize access
to list of kernfs_super_info.
This helps in reducing contention around kernfs_rwsem and also allows
operations that change/access list of kernfs_super_info to proceed without
contending for kernfs_rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 1 +
 fs/kernfs/file.c            | 2 ++
 fs/kernfs/kernfs-internal.h | 1 +
 fs/kernfs/mount.c           | 8 ++++----
 include/linux/kernfs.h      | 1 +
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 61a8edc4ba8b..17b438498c0b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -917,6 +917,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	idr_init(&root->ino_idr);
 	init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
+	init_rwsem(&root->supers_rwsem);
 
 	/*
 	 * On 64bit ino setups, id is ino.  On 32bit, low 32bits are ino.
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 95426df9f030..07003d47343d 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -854,6 +854,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
 
+	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -889,6 +890,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 		iput(inode);
 	}
+	up_write(&root->supers_rwsem);
 
 	up_write(&root->kernfs_rwsem);
 	kernfs_put(kn);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 25c3329bd60e..6e6398a72578 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -47,6 +47,7 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct rw_semaphore     supers_rwsem;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 809b738739b1..d35142226c34 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -347,9 +347,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		down_write(&root->kernfs_rwsem);
+		down_write(&root->supers_rwsem);
 		list_add(&info->node, &info->root->supers);
-		up_write(&root->kernfs_rwsem);
+		up_write(&root->supers_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -376,9 +376,9 @@ void kernfs_kill_sb(struct super_block *sb)
 	struct kernfs_super_info *info = kernfs_info(sb);
 	struct kernfs_root *root = info->root;
 
-	down_write(&root->kernfs_rwsem);
+	down_write(&root->supers_rwsem);
 	list_del(&info->node);
-	up_write(&root->kernfs_rwsem);
+	up_write(&root->supers_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index e82e57c007e9..9f0926f553fc 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -267,6 +267,7 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct rw_semaphore	supers_rwsem;
 };
 #endif
 
-- 
2.30.2

