Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F2E4B4F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiBNMEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:04:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352413AbiBNMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:04:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE72ACB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:03:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EBFZAa003324;
        Mon, 14 Feb 2022 12:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=6ZbqituaPBbpmGQTIuBKBgUjl94uAwBM2fLOWqyDrQU=;
 b=XiHUkttW0Sx1NJtqa1IutiU/UkTzWD4IiKZ9NZ+dbSbmT/WqQPLd90+2tnEDIRH7hi+8
 zE/vBlcqpN8GeCDy9ZCUmjHhkk1YXTPyQcbAG3mVoDHKam0BfWSKf9YNID9l2GU4dauU
 TdUNEezdL4CPFXpwigmUVcQeBNNThL5d3xf8DPvtScE2o6RHBY1y2pWAahDMRlpCxAa6
 f0FFtfxWE5xmpx0iKB7ZJlPPt1TyWYEPXUlw8WctWLNXruDbmtf5Cblq5Qwe8cLtWjDY
 oboCGC8Hy6CGLes4JPzwBACJ7nUD+w2oZow7szVoYbHzoqOLnHRA8OEj/1cxaVm9SLkw Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63ad4872-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EBuRcg176470;
        Mon, 14 Feb 2022 12:03:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 3e62xd07mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4fPlk2qJBdY2mdBDm5h1TF0Jy5ZhEeEnHX9arB/Mg5DG67LkbRKOHLtiJ2YsztLKfPuNNeXt6ctW66zlcRPGw7NVmEldtGzgvw5VWpmLgLUCN1liR9macZtpapobpFrKJwQuDunVVZCRsLStTL4MSN5aEdH1t0+ZLHFH69OkzYRx7KfjLgvaDRlqsnOeMLGMDoC5+uKI39fbo2LrXQVy2ltXmz9ziwaDkaeCqHr/SsPNuK6LFqkZT3D9tZqmglDSRWstYv7kAKrq6zyL46uZ6u8UNMrzH1CI32Cq+yP/0R8hUH9lUZ3qlR7ZbCEEEjuV4thbKTz/sJDd3z18qN0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZbqituaPBbpmGQTIuBKBgUjl94uAwBM2fLOWqyDrQU=;
 b=YUmLFbt2TeicbAhPh4WqkTCdeJEmofU+TQDuzOO5Iqr7KAjAN4dVGKBqpgFnytJdDZky/Fonalbi/zOtdVC19rocw4pHMmt9Al4e+6zbS9JfDKFYEEuVyvMLfsot2FsrZLHun1G54eCWTH4XqHTJx/IjkIu4Oum3an+N7aiyUmZAizTp/IHmgLMI3rs/WJlkZYXZzG7yRg3JcB8A0Zgeudrp1GSdBrKXEphcsfVh+1oXRzzAunqFc9DP9LhTe9b/Niv96wt2u5ZhFwWRWBCt2lN9i0S2TKWwZ1X37dutqK10x3X5wF4Fdy2nCl0VdWVI6CUNsJ6Nt+BdqdO+j4BL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZbqituaPBbpmGQTIuBKBgUjl94uAwBM2fLOWqyDrQU=;
 b=V0uVd4X/s7yXJYpaHJWw1sN9fosbEA1YsAtVwfCiTQ4/ApRLCUJ+P1Xtf1JP54CDwy58GhKoSdmqjio6DO1O9LiPUJYS3zE9SmGaM13jNg/x/CAM7ewMQYwx8ySIbk2LKO7TaxczYMTiZjjJD5aI1PkorExNDovQst8t8GXPgN4=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 12:03:46 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:03:46 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/7] kernfs: Replace per-fs rwsem with hashed ones.
Date:   Mon, 14 Feb 2022 23:03:22 +1100
Message-Id: <20220214120322.2402628-8-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11ef8a10-83a4-45e1-08c1-08d9efb20dc7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4191E52D82BDC4A677843782B0339@MN2PR10MB4191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IwbQQnAY+jKVUSC1ZmxoSw9P2arF/IiON6vD/q+GGujLqj0seToLriFQ1cYqUGciD4PFtJPgrNwnzVWcl5L3wvKCR75ZcVWQEbv1Ri3AyrH7GV0wEMu+689gxuQ/eGPC+8RLjc8Z4Poc+Z/L0rH2WgnAqAa+MHGiAqJZnxFR09L7E1sXvBTx+7dPSjAeyj/XyJZrge7qz7UVREBLPk2Qi1fNjnikhhkDbcXo+G0tRWDIbhvU5cYBPPI6F9u9jxLlVgP0ekstFB8MxfZ5uFPYMdSJs/Ept2RYtZ3aYAh5kWhMCH2D6GDsNMHrYYID4UTaxr0Eq2ddUk47YuLmQmd5joKI8NeuzMqv5uwN2AqS/R6g4KUMtPXIxJLpqaJWBBnwMAaaqfFGagU4BfHZP95PPJUK2aglmpbEJEjuMKtoUXgRuR6hqT/ZfWo7XBb/nmRP/ysi2Q8A064dr6ewxS4Im24kdHY/sWyJPTR2QYua85VcCD9MAAIrgBnr40fp0Molo5pRVhNaDopyoq1J/dRXaPnTBu1tRzPshl32DBhQS+n3vwgXn8tfP21qOu1n0blH7mGlgEsegFeJPBxsN0FSntoPdl3hTbT//DfwvX8lJGVB+IPqQeT4LBa/2cwUaEAuQQkxYmGwCCHu0XTOELXqrkQp20nh4CbvHM+8Fay4Cic1JnW03H8ksP2msZjFKy8MRt/utD2MWgpgGxHNSd18w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2616005)(103116003)(5660300002)(38350700002)(1076003)(26005)(186003)(6512007)(38100700002)(2906002)(6666004)(6506007)(8676002)(36756003)(66946007)(30864003)(66556008)(66476007)(316002)(6486002)(83380400001)(8936002)(4326008)(52116002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VpqSr8n04e44g0FnQRe4Vc42hvHVAaCgSpWCcp+T2hoUOGkPPLfIHVFY0hGh?=
 =?us-ascii?Q?hijJRpOPCNRclSs3v0sH+Rc8GYPc4UPixYxSEhtA7aocD0K/g6xeFogpHQGj?=
 =?us-ascii?Q?Zt/LmdXJiEbPkpQ6oaPn5onF42FCQ8sW6N5pmx2ZoKvUcGh8FAnjVPivteI6?=
 =?us-ascii?Q?2F/YIrO4mw8lJU4QOCrs6IlYS6SY2p/PFUpksOfdmACVYVTx9LZBiV4j5bUp?=
 =?us-ascii?Q?/YlZR5Xg3/D3xWNgYQUvu0uXN8vVAtcpYOI11xZlg2QWty7Xdl+dtH7aqyZK?=
 =?us-ascii?Q?UISpwUz8OI0wljqrBmN6MTppQ+bmVErvJ+6ye9BMMsrP2sFbZKlfR/QsCOMa?=
 =?us-ascii?Q?HfqgFZ2QjJpFyCX5m/SOnPzXxbyi8PxRXeLv/pdx65IWFuNY8tMeWLPbaroD?=
 =?us-ascii?Q?ZjOXgIBohoCQJzubMXlnAOjA8SGhfKy+FnEMQ75UqS8BWSbJfF8zRhTd6v2z?=
 =?us-ascii?Q?miq0M/D/AaGRYFKVF7jjUhUYf2oFmUVEmsZ55bFL41k76XmMqwL1JX93n36e?=
 =?us-ascii?Q?Z7bB1Dkchy45rmZ2JF7pzaQH5IihC5qWYIkTvVSfneUrLS4HA14Sny2mGL/Q?=
 =?us-ascii?Q?uiylonXnfVLJPX7q9TIXpQBtsKtyf8Kxp0/MpXw9OcL0UQFOYHXcXwTfep1l?=
 =?us-ascii?Q?kPxrlvlILGJTHFdkL6MB4gfJO+usVvf3/Rh2jO1fJaXLSjqJ6aKa37vxY+ei?=
 =?us-ascii?Q?DYeyDSDKY27cMW5Ltx9kNfnozXM3PV78YgaBgIe4uGaYsteFxorgqM9if0aU?=
 =?us-ascii?Q?lKZ1jD85wP2vdOfQjvXNTWF3+pB5kz+FN471m2OjBp9aeAZND8Bg6BXlNUx0?=
 =?us-ascii?Q?lrUuxW5aFb7iwSfK0Gicr/nUtauYfjuCErRpay1DSboJbPKKSl2yrUF1PNZg?=
 =?us-ascii?Q?zPzOxreOoaL/6r1d4UqGEen9dThyJ1Vp46QLBI9+yTUCWolnplXFS3TTQwac?=
 =?us-ascii?Q?gTQmJrdjqYDdccgmdSlq0XAgLO3/3Hpnf2oXEhs6pG2YdVCTpVvDXzGXOtRg?=
 =?us-ascii?Q?UbgUhCXoEv9LSeCe5DoXH2nAiWBS3pKmnxaaGUnhOpLNO4kKG3MbZolifZ33?=
 =?us-ascii?Q?qkhs2frX2VMpuezWpS+8K8jvyspEoNRp5Zf8hz3/ZC2qtryc7WhsO3oZH8/R?=
 =?us-ascii?Q?r2lkU5UlcyAM4mRVC1nJfqscvylcwXs20h2WqpMD321KUqAXwO0jdYripQvG?=
 =?us-ascii?Q?IFjUUO2+5Pa7+cBM2S/9eWF4EjPbo6ONxmqmv1URE1FjZhvN4JneCHKu+LVi?=
 =?us-ascii?Q?wkofqMQBjxEXbQVe8LTYueg25slijswlv01K1I8Kx+9CK75HLz8Xef+M6uon?=
 =?us-ascii?Q?XJSj9VVwtaVEM1CvPrJNizQNoE9prn0SZORiNB/YnIS9dl2EvCOuLKcZvHyu?=
 =?us-ascii?Q?SFaVZW4QiJujCtkCP/RdEzNUliiTITfeX1ErDjP7zZXtcp70htor8YBB/dQM?=
 =?us-ascii?Q?uohs+XNIr0cv7tz752I80sQ/PbxfL/REUVSBtv8dU1jSD/y6HXPTEHANq1JB?=
 =?us-ascii?Q?Vg1Kz3ZSO+VSNQp7RAaaY3/3vj4NwXRwGrBT/Q8i9Gq80de2IjDtQFCjf0qV?=
 =?us-ascii?Q?2jXakVmIQPRDRBrCjm9bk7icL6o8DWGIXpcNBjU9VPZGTchWteuK7pV5m1ue?=
 =?us-ascii?Q?PasgA7WRfCfzQBzf+R9CPlw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ef8a10-83a4-45e1-08c1-08d9efb20dc7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:03:46.6968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/Bl0OZPMR5iQ6z/FWrLjNLE892gOr9KGPKVbOyfKd9WTRvBA6m/VH7d3MoCL1m5grTknMgPH87GK4FO/jbvvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140073
X-Proofpoint-GUID: 2iCrymktlswEzhwZCsBOMFUsulxt9iBh
X-Proofpoint-ORIG-GUID: 2iCrymktlswEzhwZCsBOMFUsulxt9iBh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove per-fs rwsem, using hashed rwsem and corresponding interface
introduced in previous patch. Also as we are removing use of per-fs
rwsem, we no longer need lockdep checkings under kernfs_active.
Wherever needed lockdep checkings can be made on a per-node basis using
interfaces provided in previous patch.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 130 ++++++++++++++++++------------------
 fs/kernfs/file.c            |   4 +-
 fs/kernfs/inode.c           |  22 +++---
 fs/kernfs/kernfs-internal.h |   1 -
 fs/kernfs/mount.c           |   5 +-
 fs/kernfs/symlink.c         |   5 +-
 6 files changed, 80 insertions(+), 87 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 0dac58f8091c9..42404f8bc6acd 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -449,21 +449,22 @@ void kernfs_put_active(struct kernfs_node *kn)
 /**
  * kernfs_drain - drain kernfs_node
  * @kn: kernfs_node to drain
+ * @anc: ancestor of kernfs_node to drain
  *
  * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
-static void kernfs_drain(struct kernfs_node *kn)
-	__releases(&kernfs_root(kn)->kernfs_rwsem)
-	__acquires(&kernfs_root(kn)->kernfs_rwsem)
+static void kernfs_drain(struct kernfs_node *kn, struct kernfs_node *anc)
+	__releases(kernfs_rwsem_ptr(anc))
+	__acquires(kernfs_rwsem_ptr(anc))
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held_write(&root->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(anc);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(anc);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -482,7 +483,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(anc, KERNFS_RWSEM_LOCK_SELF);
 }
 
 /**
@@ -717,12 +718,16 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
 	bool has_ns;
 	int ret;
 
-	down_write(&root->kernfs_rwsem);
+	/**
+	 * The node being added is not active at this point of time and may
+	 * be activated later depending on CREATE_DEACTIVATED flag. So at
+	 * this point of time just locking the parent is enough.
+	 */
+	down_write_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -753,7 +758,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(parent);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -767,7 +772,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(parent);
 	return ret;
 }
 
@@ -788,7 +793,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(parent);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -820,7 +825,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_read(parent);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -859,12 +864,11 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 
 	return kn;
 }
@@ -884,12 +888,11 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 
 	return kn;
 }
@@ -914,7 +917,6 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		return ERR_PTR(-ENOMEM);
 
 	idr_init(&root->ino_idr);
-	init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 	init_rwsem(&root->supers_rwsem);
 
@@ -1045,7 +1047,6 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1061,13 +1062,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
-			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
+			down_read_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 			if (kernfs_dir_changed(parent, dentry)) {
-				up_read(&root->kernfs_rwsem);
+				up_read_kernfs_rwsem(parent);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
+			up_read_kernfs_rwsem(parent);
 		} else
 			spin_unlock(&dentry->d_lock);
 
@@ -1078,8 +1078,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1098,10 +1097,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(kn);
 	return 1;
 out_bad:
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(kn);
 	return 0;
 }
 
@@ -1115,28 +1114,29 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
+	up_read_kernfs_rwsem(parent);
 	/* attach dentry and inode */
 	if (kn) {
 		/* Inactive nodes are invisible to the VFS so don't
 		 * create a negative.
 		 */
+		down_read_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 		if (!kernfs_active(kn)) {
-			up_read(&root->kernfs_rwsem);
+			up_read_kernfs_rwsem(kn);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
+		up_read_kernfs_rwsem(kn);
 	}
 	/*
 	 * Needed for negative dentry validation.
@@ -1144,9 +1144,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 * or transforms from positive dentry in dentry_unlink_inode()
 	 * called from vfs_rmdir().
 	 */
+	down_read_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1269,7 +1270,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(root);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1304,9 +1305,8 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1320,15 +1320,13 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
-
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
 	 * This is for kernfs_remove_self() which plays with active ref
@@ -1341,12 +1339,16 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 	/* prevent any new usage under @kn by deactivating all nodes */
 	pos = NULL;
+
+	down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 	while ((pos = kernfs_next_descendant_post(pos, kn)))
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
+	up_write_kernfs_rwsem(kn);
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
+		down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
@@ -1364,10 +1366,15 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 * error paths without worrying about draining.
 		 */
 		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
+			kernfs_drain(pos, kn);
 		else
 			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
 
+		up_write_kernfs_rwsem(kn);
+
+		if (pos->parent)
+			down_write_kernfs_rwsem(pos->parent, KERNFS_RWSEM_LOCK_SELF);
+
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
 		 * to decide who's responsible for cleanups.
@@ -1385,6 +1392,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			kernfs_put(pos);
 		}
 
+		if (pos->parent)
+			up_write_kernfs_rwsem(pos->parent);
+
 		kernfs_put(pos);
 	} while (pos != kn);
 }
@@ -1397,11 +1407,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
-
-	down_write(&root->kernfs_rwsem);
 	__kernfs_remove(kn);
-	up_write(&root->kernfs_rwsem);
 }
 
 /**
@@ -1487,9 +1493,8 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1503,9 +1508,11 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	if (!(kn->flags & KERNFS_SUICIDAL)) {
 		kn->flags |= KERNFS_SUICIDAL;
+		up_write_kernfs_rwsem(kn);
 		__kernfs_remove(kn);
 		kn->flags |= KERNFS_SUICIDED;
 		ret = true;
+		down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 	} else {
 		wait_queue_head_t *waitq = &kernfs_root(kn)->deactivate_waitq;
 		DEFINE_WAIT(wait);
@@ -1517,9 +1524,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&root->kernfs_rwsem);
+			up_write_kernfs_rwsem(kn);
 			schedule();
-			down_write(&root->kernfs_rwsem);
+			down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF_AND_PARENT);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1532,7 +1539,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	return ret;
 }
 
@@ -1549,7 +1556,6 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1557,15 +1563,15 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	root = kernfs_root(parent);
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 
 	kn = kernfs_find_ns(parent, name, ns);
+
+	up_write_kernfs_rwsem(parent);
+
 	if (kn)
 		__kernfs_remove(kn);
 
-	up_write(&root->kernfs_rwsem);
-
 	if (kn)
 		return 0;
 	else
@@ -1583,7 +1589,6 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
 {
 	struct kernfs_node *old_parent;
-	struct kernfs_root *root;
 	const char *old_name = NULL;
 	int error;
 
@@ -1591,8 +1596,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	if (!kn->parent)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem_rename_ns(kn, kn->parent, new_parent);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1646,7 +1650,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem_rename_ns(kn, new_parent, old_parent);
 	return error;
 }
 
@@ -1717,14 +1721,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
-	struct kernfs_root *root;
 	const void *ns = NULL;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1741,12 +1743,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
+		up_read_kernfs_rwsem(parent);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		down_read_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 	}
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index af2046bc63aa1..03d8f0d087cb8 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -857,7 +857,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 
 	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
@@ -897,7 +897,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 	up_write(&root->supers_rwsem);
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5daa..4de65f9c21d85 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,10 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	return ret;
 }
 
@@ -112,14 +111,12 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +129,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	return error;
 }
 
@@ -187,14 +184,13 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(kn);
 
 	return 0;
 }
@@ -278,21 +274,19 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
-	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(kn, KERNFS_RWSEM_LOCK_SELF);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(kn);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index ba89de378f240..f19b180557559 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -133,7 +133,6 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 /*
  * dir.c
  */
-extern struct rw_semaphore kernfs_rwsem;
 extern const struct dentry_operations kernfs_dops;
 extern const struct file_operations kernfs_dir_fops;
 extern const struct inode_operations kernfs_dir_iops;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d28f8a3eeb215..2816750f798e2 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -237,7 +237,6 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct kernfs_root *kf_root = kfc->root;
 	struct inode *inode;
 	struct dentry *root;
 
@@ -257,9 +256,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
+	down_read_kernfs_rwsem(info->root->kn, KERNFS_RWSEM_LOCK_SELF);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
+	up_read_kernfs_rwsem(info->root->kn);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f7..24d0f64460bda 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,11 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct kernfs_root *root = kernfs_root(parent);
 	int error;
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, KERNFS_RWSEM_LOCK_SELF);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 
 	return error;
 }
-- 
2.30.2

