Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167624B4F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352422AbiBNMEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:04:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiBNMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:04:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9552126D9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:03:50 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EATJ9B021228;
        Mon, 14 Feb 2022 12:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=3/F1X8fgIatRPSR9zP22TRADXmiGAgrQjRh/YvEL8Zk=;
 b=mPQ60ZVszm7AOszwlFtibVBV3drMX3CTkFbx/n5RiTwrKSzwliKHmBwgqfsOaFdjF5Fd
 AuAG2ljd82bVRr7oyRounKqNanUo0ol0bSUb+8O3G8lJSSi584ucGYLwgzTwXPWskbgD
 m3+lFCZHeH9yVpFtG1yA7nKldKXVg4sLEKoJr9VimCjnn0DuK0yW/eap5rtB4bJ46VwW
 pCHn7qglSYQ2TB/Ou1zu0HQA0baAyWqW4R04lhaUcxYGPPlYwrQGE5JSvDpbDFx2L1t3
 tSyEEjpKRbJZLMYXD+UPS6iMnKOQmD2CEv7h9ccn4T9MGD4NAhFq1KTPZ3sZoXuId6s4 Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63p24b9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EBu1eT067149;
        Mon, 14 Feb 2022 12:03:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3e6qkwjh3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOc8IvMxgdiS20PLsIOmidsAXWy5u8TW8FSFDwONne1IrQJTJ2EHnp1VYUAEvl1mNi7m5Y1svHCdw3GwllZqkkToKPLo4LcXsagWV5f/ZJa67fJInd20BFZhWsFAlJmeV2M53SgRK9S50wqn5BeO9HcCBABdrFGwmhneTwnNjHebcCDdC8mlVeI7mMr0HNl8owMpXRy9cfdPcsYwnCokq+6MQTTpoV/qbXfEVDuSrF7Ig79r9Fg+yLIk6GDIb/lz1hXqKECSwrn1b78/knlm4Of5HTq6i3LPnrsdf9ukZllBr5QlPZHqtul4aRCzWXkrC+0QtgnyFzUQS1p2lJYsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/F1X8fgIatRPSR9zP22TRADXmiGAgrQjRh/YvEL8Zk=;
 b=Agxk7dES2lCFKe7zmib/1XJVQd+QV40vGgnFrV3xYv/Q0Erz3cqqQboiNFa0QadMXcvI8cxzgkA1wGudt/7Qxpl3Wl9bjuBin479QQCoUK/yVTYTPWgevI9KQyP0Wq077U9XwqS/bvW8Ry52Zfng5D5ZQ7FUjeau2ygtSlK77jMMAYI9aLKOw6Mwyt6AclC06VBl2GHKXf/q65qqiFl+C5RH7eyo7uIAks5H7tAtaKTGa3UUE0h72WROIGkw24WZcxZu7Ea8DG0BxWoPUleHPhjd583QArAIHhCHR/wH9d9f7sd2XbUY1YQpP2lqCbKPGx7WqDP/wZj7L39cbAOEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/F1X8fgIatRPSR9zP22TRADXmiGAgrQjRh/YvEL8Zk=;
 b=MdjkIWOcRtoOtNdct6RP2e2jy91A4gg5yf1hZ4PvuWa+nku4lRqAZgCsJ1T3e0LfEVAS0018QysUGjf0mK4kFRE4do9EVkIUAKpLiXXJCxNzH8ILaQlDML2yCEz8MtL3HA922YJ7CbXPQ60Gqv63bl+JtUHey+W15jvvHKFuV3I=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 12:03:43 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:03:43 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/7] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
Date:   Mon, 14 Feb 2022 23:03:20 +1100
Message-Id: <20220214120322.2402628-6-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90fe73a0-bbb9-4833-75e6-08d9efb20bd4
X-MS-TrafficTypeDiagnostic: MN2PR10MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB41913B165265FF1428B0CB58B0339@MN2PR10MB4191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4ieElShc7y8ZAHr2CW2d/d6iN5+VrLr+7bcg1foFIHN3KLzbUBrODwzuoClOqoVcCKovihfSTfTIn0TwWPpg8IT9lTShFLdXnE3LpHkC/s6oVpcz93EC/3sLwHgnil0klQJBvy8siRZhVo35HnK8w9XJVcjY48BgGtuQWOa18htsSSeJ3ia8AIMhXItuj9TEixejdo9zjsKwX0saYotWr25HSgtBh4aUxYM6BEJxjj3hRFqN8WKwROCveiNeiCQ2vgf0ejQp1wxvd/D8Ng9rtnF0aLa/aJL3rKk7aKoTeYb9/6DkZwmxL8finsXbNjoWX/gQb4Lenp2+iabuvJqJSeQySoB1EuITwuxsyEi8w859luSa35tmuwEK8dFjcvuGCGhVD/4qVCuP7pMlkcSORLUNI/iKAz2/AZQble8KiN5sIuuQVhUG6g6wHL26iE8xn03DBE8DWTdh1SG7+sKUlnM3ZJ4OJxD8neQEGMAJlnb+ZEppClkBHU2CkVoWZ8O84mM7RCHNgckhQaFAUPl+ESQOKLgjQS52hQOVessFLDlJV4CHliN9Gd2RyaTROTR+dT0d7unx7dMAP5hMWhvlJs0iIqnf+BBgkTJeaxOpCNQgbxAI7nNB5k5TWw+wRzqrbLUqNS/ymWyLXYSUB4vPzJZ0n4qg0oBRvzX7dFb2UzKNqAV21IW4r+ya4Tudh4YUKIrexqGYvJoAXdQVCqqRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2616005)(103116003)(5660300002)(38350700002)(1076003)(26005)(186003)(6512007)(38100700002)(2906002)(6666004)(6506007)(8676002)(36756003)(66946007)(66556008)(66476007)(316002)(6486002)(83380400001)(8936002)(4326008)(52116002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yoa5lTx/sfdKBWNYfhsOnl4G98AtMNkS/18GonjXU6wbL/lvszbvqpzdivzF?=
 =?us-ascii?Q?11FQS7LkI2I8h59eYV4Box6KQFJQ2LE1VMJmBiOxHvww+iJwV1ilqLGG1l/w?=
 =?us-ascii?Q?zpUxecuarviEmu3oUyLW4xPU4MNyP6KEkYyuZcQkRS5ch+JxrqMktZRB2GTn?=
 =?us-ascii?Q?gRbDCmthoMN6i0jBMPw74M5TygY0qZtd7dpO6rgfgWUmHylxNUWTniF42409?=
 =?us-ascii?Q?Ax1Xz8w0XZM0e08IxvS5CL3zpGDVhKrxOEd5pXmHq+vx70km+SEEOb0Hui54?=
 =?us-ascii?Q?ipGTS6QmunOsGjB/dLW+XD4kDJ6dB+x+0HcCLKuMsEroFFfMJ+1GGJpAWAYW?=
 =?us-ascii?Q?ag29xYYbLu0sR0HxkvPr+ms3l+6GfYuHlX7f3utjetqWaSUN8DbYHj4x1Vas?=
 =?us-ascii?Q?Nz+wyfvOqwfPrJNdx/vUzZU1+Q17ek42zeY5bOGnu+UIJd9JSBmE+Mv9fH0E?=
 =?us-ascii?Q?9S3dl/ChChS80X4J8dXsVQ7Ii0oprCXmcykx2UOT/NPGDAUSGdNoaQ79q3Qq?=
 =?us-ascii?Q?++W8TDIx2J9TeZKFvfAPc/BKwYq6jxm+QLp0HWG1uF0G83ZuucgxoLavenUj?=
 =?us-ascii?Q?3jJyMi6p0KDtebD5BoSQ+39hz0VdT4i82DNsXLxy43yuRSUlmsxccvSOlJaO?=
 =?us-ascii?Q?ed55z9OEbytowHzGCaxEigrMYOeYtEYPeSpnFxjQxMIeL2E2VqvsHp7X1r3j?=
 =?us-ascii?Q?wLwCjFnTWfTbw28ySaTftuE5+XfQkFruQKxXefYmlcfRDC1fxMxLEnEvwOWa?=
 =?us-ascii?Q?eU/S6p2hunczCJjWrib/oK4ZuuwY7kLQExwSFZdm7IV6dlwiR0p31N1H+qMn?=
 =?us-ascii?Q?N3iisZ7ZMMOVjsvd9VQRWZTPORzl5aNYI4XgRsKrQvwuOMOPAu7IYj7N78zi?=
 =?us-ascii?Q?nc23edagPnoYy49eKIas0Wb+b5/GxChobKAHCdqS98OMzZGwkaFVwwBSlQ1D?=
 =?us-ascii?Q?H/p636Dfp7i13ByIZUkezfeJIFOWWoShAQSFsP4119TD7hQ68d8gvo9juyjQ?=
 =?us-ascii?Q?CtyC/OhQdvB4oZddGFgsDE6bROnrYcj7IdC/1/4TJyr/i7PsMRJyrkAV7wRq?=
 =?us-ascii?Q?RrzaNr27IhOeWyOmlhu9IjRqy9bc8bRSzZKO+/4Gvl/g+gox0m7Lon7bqTK3?=
 =?us-ascii?Q?AcFV9CVw8C4AugOF4fx1aAm5On1sjK87AO0StiNqMfz6E4yHqluJ9cqjnl5F?=
 =?us-ascii?Q?CDbYCAjO1fGKqGtxyKkGrLwOfj/WsEve0Qw7lhqvrXzk+QWK+mv7QZc6wptf?=
 =?us-ascii?Q?+8YCd1ZJlQ1tUhDQEhDABqkZ+3w40n2xiFWR6LFC+MOBLUV1dVR/F+A2DzlF?=
 =?us-ascii?Q?4b2UCqCBpgE3ms3hzodkJYcD4SkTWFOhV/e9emJUb3y1EsfoePOixi18Ok/A?=
 =?us-ascii?Q?N1SQuBhGEXsH4wlikyR3q1VNbN2nbCsaTew3XFMCy1356I9pj+mKnXoO+K0/?=
 =?us-ascii?Q?BzkN450tuE41gIT+Ci5mALxnW2aQxyq5ZdEF3MR9M3Ns/kKxCzINS/JQsEDp?=
 =?us-ascii?Q?qNDu2KCO3evqBXPLfkIbQmInmianJx67qeKUzgoK2m4Zy0tnvfU/RwUVuL/v?=
 =?us-ascii?Q?xjSdEE3yl89B+Y60rXP8fwXwQE4dmcEoN/TLf9dfBB8WL0agMgTmddpHZi5u?=
 =?us-ascii?Q?WonjKfANmlJHH+pC6iKlOWM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fe73a0-bbb9-4833-75e6-08d9efb20bd4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:03:43.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/NC50f+nSY553S+aifsRb9NaZupoRJbUrdABQ5FNMY3jdrFW8QkoAcRFI36gwqCGp4habd9McJxYaZpnhjOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140073
X-Proofpoint-ORIG-GUID: dOLXksAU45Ceh0F1ieJLGK5upFKiwjVd
X-Proofpoint-GUID: dOLXksAU45Ceh0F1ieJLGK5upFKiwjVd
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
 fs/kernfs/dir.c        | 1 +
 fs/kernfs/file.c       | 2 ++
 fs/kernfs/mount.c      | 8 ++++----
 include/linux/kernfs.h | 1 +
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e6d9772ddb4ca..dc769301ac96b 100644
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
index f3ecc6fe8aedc..af2046bc63aa1 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -859,6 +859,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
 
+	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -894,6 +895,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 		iput(inode);
 	}
+	up_write(&root->supers_rwsem);
 
 	up_write(&root->kernfs_rwsem);
 	kernfs_put(kn);
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 809b738739b18..d35142226c340 100644
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
index 7ee0595b315a2..84653c609a5c0 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -265,6 +265,7 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct rw_semaphore	supers_rwsem;
 };
 
 struct kernfs_open_file {
-- 
2.30.2

