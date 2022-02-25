Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9C4C3D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiBYFWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiBYFWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:22:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF03B022
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:21:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4k3tv019955;
        Fri, 25 Feb 2022 05:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=aZa/TrkKtTNqKT9QgLUCzdbxF8gSva5/VMgR85ZGRIQ=;
 b=1Mj1w8dJ0SKZRgxrs06aPQ0VYd4OgIy7cYoiUbbxkR6CpytZBRATY+TE/iu+GEcLCV/E
 65wWUhYWtvYf8Lv4JMuj/vKQYrNwak7zOmJAOwOejR4Cc7F21creazRlIElOvEA7BHhh
 UNci0+2ZMXdAojTsqumx0x8GILlqAWcwUfxsQomLbnmrG5JSD40FF006w5HcHyrzQxxK
 7cyjm6U1/8ydKfwuNLn5kJZAjE/Rglj1y7GyQROLiI7GnBIiQwNMX9oIa/jFm+qD/d6M
 3rLF7hDKelBgXJoT4W25OQPmipn7caCKwDMEDwR7bNeCTdonEDDAtsB2R8kmLjrtDcdV 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3cs1xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5AnHw169721;
        Fri, 25 Feb 2022 05:21:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3eb484e7gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jnc5Rzntykcnzx5jijmpQVFMEkjIgO7hJZn4aX0fiYYs0jsD1j8VvyrtnpPbq4TAf6cb0Cv1/2qRe98BD5oQXpSula2CRpah0WZRZTYcz/WJ/gPRb7anCtTmfBLZAJ76GEzSmzFlsYCWCfFJyaZyx0XW22z8sMvt//5krxMeasH9noeEibnQ24BnoTVNqRU81kFhZQ+rQsMdSSntZI8ToqmJRhdXuTbTtD2QRC23UTjCJQhMydWb2qiUMXgMU9SJYlwvIEIrwdxYfqjSoZiqLmpqqFzbPWXMyMvV7oBIpWZC8ryJn0Emwy2SDyARl8Qb5uXtrvmi/nPldB19k+fWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZa/TrkKtTNqKT9QgLUCzdbxF8gSva5/VMgR85ZGRIQ=;
 b=Apd1RLQ2zLG/SEAR5HtWIJFH3Lc84ffJym1cvMHbbd5Mz4Cl5w1PnA//YlVjLJQv+3++WMnUqc/6a28hTnxPGbhK616DC9jwoU+TWhJhm9DM+2FRNMCRNBiW19h6TXNK3+jqwrQQMtEoMYlDXi4F3+nvIASgpJQNO1YlDXczRdqMz5X8XfD2HNOkiPR8wSRuWuNn7ksaDGVnxD3+yHaX3eFkI6vLw1e6dbId123u5WCGksIfLJmZ8lw6MOrqfQKGXqCENm8i00R/zi1t6EGFYBS6KRTr9vbamA5fiufT3p/KiRqEhruV5+dEmppyl6NzZ/P2QxwyV4sxkaC1Qw8zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZa/TrkKtTNqKT9QgLUCzdbxF8gSva5/VMgR85ZGRIQ=;
 b=mvGES3DrPBsFwAg64k+paKTB50IxHaAdMJ4sGtlZE4bl1odDOM64LRc0eRvXoeIPQyWpKh5xrpSbsfw0dVnFTk4K0O3g5p38FJWpVpBXhs4FRjsqoK1ohAmo3ox9xtPN4ERmm/FHQxiWAbTlnO84e9lkeCjMNBArr45kAs+hro0=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1677.namprd10.prod.outlook.com (2603:10b6:301:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 05:21:36 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:21:36 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/8] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
Date:   Fri, 25 Feb 2022 16:21:13 +1100
Message-Id: <20220225052116.1243150-6-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225052116.1243150-1-imran.f.khan@oracle.com>
References: <20220225052116.1243150-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0043.ausprd01.prod.outlook.com (2603:10c6:1:1::31)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b41d8613-a0a7-4385-7ded-08d9f81eb16d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16778B292F06D3D91186AF63B03E9@MWHPR10MB1677.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98EcE3xQo3cPYJDj68+lXwnE/jNFCYdD7Pgu6IaJ6llRW7d/f+NVdNA0Y950KK2nqZ2Wktr+Oqyv3bT3WI5mxrcp6kKMHJ+Y8ghryS8y1ydiZRSRpdK1wm/n60rvTGS+J1s8lptLHNNLs9GGS/GPvK1+MWx18VTY24GV6jw9T+Spxv887RkamcyxvTwjutqZa/k4R9i739pF7Q7Cnmu0qfZEmrkWwOvdDuABzR4fYE8U4lGyQ/++jFNEbp0+AqhbUnOEWae6pM10wfMpTExIk0/EKI0e1cGib4in+0n5eFEwtYe+eE8xgs943uCpg7DerNLiswkuTUSS2HUB7MJCdlUu5KspxgJFJpBIWoFm0NzhCJyLT4hHgUeVnfTGKaZuimEFDOcjspDrTtdW0wlU+OerVUZZ8AAdkHZGdGWcGyElYAW5xBrP6is/+48xb+mOeusWlS1VUX/+bpLN0KYujd4FbsHv2Z8Migv4YRPfDFd3cVE4Rr/3FKwf5s9/IiDfuK8L52NmzSQEHD3yHk9jzM3t7rp9kABCj37LOgTRfT3R2rPT1p1Apvb1/S96PoQjkGxo0d6pK7RG56pRhgw2pAkRhpraWKTuwrG3oTKPTBSXNrDgmAsg0B0WcGj33mL+6ppPf+b8HlhcpcpNcojbf/2e6YyWFlSKVYCraQJyDSuKWDKMOy+yA1eWZTca8b0tlMrxuFnATUI1juWFz9ly+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(38350700002)(6666004)(8936002)(38100700002)(83380400001)(1076003)(6512007)(508600001)(86362001)(6486002)(6506007)(2906002)(52116002)(316002)(66946007)(36756003)(4326008)(5660300002)(8676002)(66476007)(103116003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ws9AqELYUI65NfQ2S2h1g5n5ln37WUQFDsuUAnMPGzj9+2BG33H4CxdzTBZb?=
 =?us-ascii?Q?XeWj9Fg0c6PgxXG3cA3D3HufYGUGWGbqtowQ3A8lcwa6A3E6go+O8m5/picO?=
 =?us-ascii?Q?56+q/yZiOQzA8lwh4wsyADxEdaX19GaWqhRYSP5WV9XdKIyfcj2pzzc14E2b?=
 =?us-ascii?Q?zq6W0+EcteX5ZywpdzOeerd3M59T8IW4p3UpJYCp3uXeTXoWUs/kMw3dXoqk?=
 =?us-ascii?Q?uNFzG1GC2tttiwjQgtR6yFRqeKa3/8bmONKO0+7RF/EVUa4V8xoToz+aaAlp?=
 =?us-ascii?Q?DSFAAQE6aAbajXAGGv7AhWjDsCMCOE2qqSMENu8GAV3EUmCi+4f6c3sSG1Z0?=
 =?us-ascii?Q?NYa4tyRf6mY7twUqZhAyzstQ7sqGrW9grUHXmLhQv8JH3mKRs3yir8fk+o9o?=
 =?us-ascii?Q?3u7uHuKguI/aeGNSQUGU5gUttJA8sQS0SEEyntJ9VzowqGhMNNwWeQ5Q7ufg?=
 =?us-ascii?Q?Go/09bG2GBhafstIo0Icp7Yog8p2Vf8P52nz0KrV0aCmq/zrTyRiFoLEmIzD?=
 =?us-ascii?Q?i6VOd1zycM1HnfmkeK1AOn/wp0j+OW+ekSIW1w7A1LOT/9zRgr92RicQd3Wf?=
 =?us-ascii?Q?L/yZC8tAvzkEwC9VJOHyiTl4u9oIv458nIDaL79jSxQsGf/KFyPj6hQhZcWV?=
 =?us-ascii?Q?AHDBgB7z8/owpc5C0DRD/0tUKLJ7n/RtaevQ6p3Ryj3Y7UBhMeiochQytxc3?=
 =?us-ascii?Q?FUUn89zYhQmBcURrI9zDXpd+xV1fexeQHYrFN5te4rTCLyZR1DrCbqrpD5co?=
 =?us-ascii?Q?Ul9HD3tdz24F/rFFuU+3kY5JD7CT78VXjnnMsPJQsdbcaNzs+rbf1EcmRmm6?=
 =?us-ascii?Q?FeNKMiX6PTMqJd/BHpiUfMw1Z3W9tQTXqqn6YSNecxH2Nz/3P30qtmSZjVYh?=
 =?us-ascii?Q?KPJzKYqJPYItvFwoj0rc+BAea/n41tkUxAYzHtA8nJvnaK+RaCaLWgYWJB8G?=
 =?us-ascii?Q?2IWbe9q+mwOjiL+HqoRwXF+LwPbnmwpa36sw+X+Peu87s91reVyAnSInl6Mx?=
 =?us-ascii?Q?fsanAHL6GyNbOAPBzpGSrzz3LrPNqu4bvF7YIVx9NFVYcOuBAxvXWY81MpcU?=
 =?us-ascii?Q?LjmdR91S8m7Z0oDpp7XpbHH3ZqGL+Iv7kh/8XuhrX/HXg4P0tZ/CojiS0vFV?=
 =?us-ascii?Q?QfcmaFBnrEX6z6YWTj6i34catukVGcdKOXbqsi2MMC3tsUA0LOrgwTUXGZgH?=
 =?us-ascii?Q?oLUtKI+k160TrtMA9oIzL3qrj1K+tV/IQ+k6cGnVbDgUaGfBQ3JodGpiWzsJ?=
 =?us-ascii?Q?Aq65EMW4plLmyksIYCj71gHWqbBdI4WwbERXkJblU8fkohGP+KX8Q7+MTzW2?=
 =?us-ascii?Q?/zd9vYfRu6iFzys6kg0mHyV3j+4Ay4+WBJ+ssRlF52o/2ZbjEicqUEPXx5o9?=
 =?us-ascii?Q?mYM0+e3y3nqQY16ytJ13reMiN7cPlEq1ZW/Q0MLjLkmK6xOzJV9Wx0rE8kRR?=
 =?us-ascii?Q?+8H/O/fImC1IXDNXj7PnSvgDX0x3geuTIhJem9FaXiVeD0c4oRTxkWwRlF3V?=
 =?us-ascii?Q?WPHAiGea4vgpsTSJTrf00ABeRdJU0IN2DZ1AYzBw9MjTYJv6GKyLlpcH1JKw?=
 =?us-ascii?Q?yO32+qa4UYkjygypXyGpP7j9lVidkUlxoqp+yCDEIH+P3/R4Lf904wljevd5?=
 =?us-ascii?Q?Bwk+DRqx4aVrjkjg5xGfCRE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d8613-a0a7-4385-7ded-08d9f81eb16d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:21:36.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lrca/P1zQbccTR5ud/Xh/HllnzxugQ6xovUKhaN4qO6HAiBhE8J8WUUSqb7c/WzJBtvFmWuRkm4ZZu7O8cLOYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250027
X-Proofpoint-ORIG-GUID: G6fG2hia_kE-hCAz4TjXZIFO3oxQIKj7
X-Proofpoint-GUID: G6fG2hia_kE-hCAz4TjXZIFO3oxQIKj7
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
index 95426df9f0304..07003d47343d7 100644
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
index e50528c45bcd4..3f7f39b92c8b0 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -266,6 +266,7 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct rw_semaphore	supers_rwsem;
 };
 
 struct kernfs_open_file {
-- 
2.30.2

