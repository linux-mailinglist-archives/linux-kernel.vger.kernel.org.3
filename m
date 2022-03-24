Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0444E61C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349519AbiCXKcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245081AbiCXKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:32:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62F76D3B2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:31:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22O90vJ0021119;
        Thu, 24 Mar 2022 10:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dOoJh0YsGRjjb5lGMfeRKrevBBhZFgS+Ck35thsaEEk=;
 b=mfpDNWWskjJgs94nKnLZ4stV9k1Nbf3NvAxCLrgXRhBLsSnSDl5Tdx4zbvyj04KMnS0z
 X0SwZ2ncV7UYNcW63pHG0V9XOQpM74C0L37LPJYPGIGwwIhGCQcEE3E7fNKzh/RMWx9k
 5UOOA23MyMSA6MMDPe5WsxOxglRGddz/c138Z/LblbEwserjpA40ADavnyYKLM19RbKa
 sXTaMMwHg8WjKFHcJ81mENUYwpXB0phEVhy9Tpu5e/xJMwTQ+RgE6++4WtNddCyRlIvB
 Pi38i31jPqlciYINfOYiCB9ylaLWOatavNt2PvMaTuWIYbGhuagK0NiHLzYChcaFobn3 EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qtc53q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 10:31:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OAUZFD178022;
        Thu, 24 Mar 2022 10:30:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3ew701r595-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 10:30:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nREYCTUdKfPF37AbX9ukHRyLF/ppGRjXRqpud+1i9r4TuZcM3VZ1AxiNyeqhCuGfB3/Y6Y4aKAoqMTWWRufnpcILgCtWZr1GagcoAUkEY2ox6EDy2FT2gT0sSdyuuaCaLdjnbeI45Ez+6oTnKp7/ZwOyj7HydZgC8wODHt7DcfaycyC4mNplC9Uv5BE3dCqsJMQA/phzBigtKACnhne/tb90PGKcWq/2duED8ik5R6YqK/hPYqldVZGVqqK89XVmC6n3YxSCwIZJJ1rHqM26FKukvpvYyoxnC+MsDoN6th+jWFHwkxWUhaHuJmjzo2F49IwWHpmMZ1wdGdabAw3b+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOoJh0YsGRjjb5lGMfeRKrevBBhZFgS+Ck35thsaEEk=;
 b=f0X3j43VE4US1eJAhH/BlX70jjxTOBkA3Xf/HEI7INncXLeoFm9V60MqI9uz6cfx3YogCNvGvP9vPcQ3yELHak3d6DT8OumoVOE5RTUkOV133jI0Rtu+/4A/rFlcSnllcJhs4crhTkCQEK0ta1ohzizn2azdXVRfFSBZ1V9rVfFg8eAAlvVxs6SysOJMzM/R06/bkXSJ1HogJbJ8Kv1y52mkukR22HtzKIPEreIezm6MzISiZsC1wWSuLYh6JwNvorUNkOJC5dq9+43K7UyWEUkQfirq8Cp3id0UmITyybeIuX5maKS8uucM9vnoByKFriGS7/iqzfPcYg8BnAybkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOoJh0YsGRjjb5lGMfeRKrevBBhZFgS+Ck35thsaEEk=;
 b=SWQyzqnEm4vYBLr/XxjPCiSBcHcIpiq+Ye1Fjn842foO2Y70D5NJxP1CE3zIlahRXxHVXvQN4a7bG4T/XX0V9fBopfzR/VOAYfu8Eu5T6az7a5a6Ai4yl8B0vyo6vVsqefE8wLRimYZKD0rIPm8y6zYC5gKRMgyVvBbcGi5WQWs=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3981.namprd10.prod.outlook.com (2603:10b6:208:183::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 10:30:57 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 10:30:57 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kernfs: make ->attr.open RCU protected.
Date:   Thu, 24 Mar 2022 21:30:40 +1100
Message-Id: <20220324103040.584491-3-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ef1d45e-b555-4b13-61cf-08da0d816221
X-MS-TrafficTypeDiagnostic: MN2PR10MB3981:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB398124734FCA27C164364F97B0199@MN2PR10MB3981.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1v9l9ZqVZGIDoyZtJ+hy1Ay/qx1dK81x62fX/E4t3Dm2joBrMzywqwDdY3pLDC0FHcnTlFy5iwkZamhYWvEPtTLzI90WZTHsbk/0yF0RFbyNrVWaZkaXJByYsHjfpWz1XgEipckO/BF24wKWKiaPECm0ZfOeu7vKgt8TdbBXJg9fryXJRkDbHWg2Fzuv/LOCXNExQdCmZ7oCwkxgPK6mqOHO3lyZSh2NmNaJppAIZRhTdOdSwVsqROHmWyJZ4GkchCH8tO+/KlUL2gAATTsSxslEtWYCzqqoJpSXQdX0/IaHm74Z4tnE3Rq6hzXX1acrGAK9NbhUMCRnqMEq8NLQP2Db46kAdEf0ul886fXUnEBc979D7MDtntZ+9XFnx6GVlg2YpQ8Kjc+1LOSVNCMnDm6ZpCW+7FhxOp6s5+c2QC9ysgsKq+jTZymXd8aSPtU8nWTW2+c/lfVoFWpsb6oWzhAR4m7Y96p2JNh0hNcN414Fw/pfSMgvvjNvVtLV6n3YGhWj+fcwugxY6JBDXn/+y/dltyBSIowRPsDAkDatAnqrKAtYZVx6RfJuf06VZnVhTbZQbNKkmyTFqfoLVOg8ehNR3+HNtybLZTMndY3tHlJYF4etZYOzufQw+mG3YFaos3aH9JzrLhm4FpyuKw50X3FMSzzwYLLfpbsHVJ5JzY/+0xhn/0evQKrXvvDk4vyUMDCBg1g5Qf3JsP4NKscxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(1076003)(83380400001)(86362001)(38350700002)(508600001)(2616005)(186003)(2906002)(26005)(38100700002)(6666004)(5660300002)(6506007)(6512007)(8936002)(52116002)(4326008)(66946007)(66556008)(316002)(66476007)(103116003)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?azdborCaPtbPImmx8exJ7654MDRUN+NatEZqixFF/zVxFVXV2NNV/0KzGHXC?=
 =?us-ascii?Q?aRT2sXozASJo1hNX5C7FUJM5So+I25oKoOpmL3KJRHu1dqJaSmFplBv3AmGz?=
 =?us-ascii?Q?+bRI99irR0+aZK71JBqsTzLVLhJuptuuG8Wxy6xdTx+/GDEnmEg9Pi95ZI8C?=
 =?us-ascii?Q?ae+BjXbSmLtdxNVUq9Stm5ADUjNk6H8Y3i09GfIgm3MB8aJMvXQEPRljtMSJ?=
 =?us-ascii?Q?TLALQEEDyZBs+uxU+D6Vxje5DuKrU32voV8nZsMHM3oUn0h7fem10T6Y4yZ0?=
 =?us-ascii?Q?OtuWNuTy3ocp7aBPGditgX6pcGVPa/ZaWU9+84Xvx0aYCEECBnlXJ0Z8CXSB?=
 =?us-ascii?Q?MgtLAUbYtP/TTBujeaDCCODrjUjvqI7sr9dOwfHZc9sgwzeu84TB5FduR2SJ?=
 =?us-ascii?Q?eDeFeJH2ZK2bTy3z6IngQiWIQtzbj1mQ6WWWhYJpTMpN5F1v6M755WobmGC8?=
 =?us-ascii?Q?Yt/NlyIubclbvpVa2GST6jvjb8iTenw8WSaJchMVY7baQdVwmzGqfWAQksNN?=
 =?us-ascii?Q?jkBc+LVSpkhVb0KRX4oUt0wC5UWguAViCDukIbt3ZNWECJ7IJ2Ous7Tmn6zt?=
 =?us-ascii?Q?LtH1GhlKX/P9S/zCCmB5k+ArZrajZaZc1PDD7ShDu1V4oX/MoMce+0G+wFT+?=
 =?us-ascii?Q?m9TxrofFb+mohkjQxPCZuTfabyZw0fHfgGkYykolEHoubP8/giDvPUil1VgV?=
 =?us-ascii?Q?AJ1lTqoowKCu/ojuNqpQiOWMjJ1umXeni/TdAdHlULtqWK7SMp2eKaXINfiD?=
 =?us-ascii?Q?pzbo1mi1dDSPXZ9O41uZXM06aSZrjFHk9SQnL29Cx9EnHcmvrquz8R2rTDdG?=
 =?us-ascii?Q?zrHVD+vuUudZzoY9c/NIsOWu2XCLeOrjI3Zrtw6GDp3qdstwZ1WP0TUXvq+u?=
 =?us-ascii?Q?ebxszmmO/JxwVCqUBnT/yTnm3kWUo40ems1Ug1uEV837Ebb+5/7E0687EDLr?=
 =?us-ascii?Q?xNuXeBLc2+xWFEwPxHxEMd4DO3hKHCM2Ogt8owmwiWZRANJC8CCumDX41hB6?=
 =?us-ascii?Q?DfVcHODR/SsoP1jOsV7WRdleObrGihjA0ImZoLwZ8iAATmBpCMheq1HvEfW6?=
 =?us-ascii?Q?w3oCEQeTA0wK2ISDipT7L7rlqzBjMPVWAxrRk4N0YoZjpcioz9HIFWiJIJ7a?=
 =?us-ascii?Q?6BaG4/u3pqngW/76ujuXJT9V0/6a2AbW221yMIabuhUGNTWcP/bGU7q9Lkxl?=
 =?us-ascii?Q?CV0N0UMyCueS4vA0CRz6IsVqjzqcmSD1Tr8UEtJ2kSjv8YRfaqTr9Tml9b/k?=
 =?us-ascii?Q?1C0EYO6vVZe96n+OyT3bwFIBvlC/hn0BToRPGRjEzLHibKCQ+5ChTxB3l53K?=
 =?us-ascii?Q?SkbAwqoMIkF0W3syjqHISV2VL/2HPB+CcDjVHC6zj0h2BIMFSd/oIQJd8Iz8?=
 =?us-ascii?Q?DPo5ULSnh6I1kwckSfd1Aa5iv0VJsoNE3ulKYanAtUjqON05RYYagkn/Iaf4?=
 =?us-ascii?Q?MK7zFoGGQZp+Cb6xTyAhBigp5+uUj3GzXnZBcalE3OaZMEumBbt9Gg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef1d45e-b555-4b13-61cf-08da0d816221
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 10:30:57.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Op7tyfuPjyMLdP11zZiiosryj/HzeEOtLpE5ItG1oqcW/daysLkbxgB9/TvTaFDZogZbWjJJG8KFLLXMxAsfrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240061
X-Proofpoint-GUID: QI0sN9q_z6d51QamsaRU39T92WZ9azT7
X-Proofpoint-ORIG-GUID: QI0sN9q_z6d51QamsaRU39T92WZ9azT7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of kernfs_open_node->refcnt in the previous patch,
kernfs_open_node_lock can be removed as well by making ->attr.open
RCU protected. kernfs_put_open_node can delegate freeing to ->attr.open
to RCU and other readers of ->attr.open can do so under rcu_read_(un)lock.

So make ->attr.open RCU protected and remove global kernfs_open_node_lock.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c       | 77 ++++++++++++++++++------------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index aea6968c979e..b6d50769171b 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -23,16 +23,16 @@
  * for each kernfs_node with one or more open files.
  *
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
+ * RCU protected.
  *
  * filp->private_data points to seq_file whose ->private points to
  * kernfs_open_file.  kernfs_open_files are chained at
  * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
  */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
 static DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
+	struct rcu_head         rcu_head;
 	atomic_t		event;
 	wait_queue_head_t	poll;
 	struct list_head	files; /* goes through kernfs_open_file.list */
@@ -519,36 +519,32 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on, *new_on = NULL;
 
- retry:
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
-
-	if (!kn->attr.open && new_on) {
-		kn->attr.open = new_on;
-		new_on = NULL;
-	}
-
-	on = kn->attr.open;
-	if (on)
-		list_add_tail(&of->list, &on->files);
-
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
 
+	rcu_read_lock();
+	on = rcu_dereference(kn->attr.open);
 	if (on) {
-		kfree(new_on);
+		list_add_tail(&of->list, &on->files);
+		rcu_read_unlock();
+		mutex_unlock(&kernfs_open_file_mutex);
 		return 0;
+	} else {
+		rcu_read_unlock();
+		/* not there, initialize a new one and retry */
+		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
+		if (!new_on) {
+			mutex_unlock(&kernfs_open_file_mutex);
+			return -ENOMEM;
+		}
+		atomic_set(&new_on->event, 1);
+		init_waitqueue_head(&new_on->poll);
+		INIT_LIST_HEAD(&new_on->files);
+		list_add_tail(&of->list, &new_on->files);
+		rcu_assign_pointer(kn->attr.open, new_on);
 	}
+	mutex_unlock(&kernfs_open_file_mutex);
 
-	/* not there, initialize a new one and retry */
-	new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
-	if (!new_on)
-		return -ENOMEM;
-
-	atomic_set(&new_on->event, 1);
-	init_waitqueue_head(&new_on->poll);
-	INIT_LIST_HEAD(&new_on->files);
-	goto retry;
+	return 0;
 }
 
 /**
@@ -566,24 +562,18 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on = kn->attr.open;
-	unsigned long flags;
+	struct kernfs_open_node *on = rcu_dereference_raw(kn->attr.open);
 
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
 
 	if (of)
 		list_del(&of->list);
 
-	if (list_empty(&on->files))
-		kn->attr.open = NULL;
-	else
-		on = NULL;
-
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	if (list_empty(&on->files)) {
+		rcu_assign_pointer(kn->attr.open, NULL);
+		kfree_rcu(on, rcu_head);
+	}
 	mutex_unlock(&kernfs_open_file_mutex);
-
-	kfree(on);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -765,12 +755,12 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	on = kn->attr.open;
+	on = rcu_dereference_raw(kn->attr.open);
 	if (!on)
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	if (!kn->attr.open) {
+	if (!rcu_dereference_raw(kn->attr.open)) {
 		mutex_unlock(&kernfs_open_file_mutex);
 		return;
 	}
@@ -805,7 +795,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	struct kernfs_open_node *on = rcu_dereference_raw(kn->attr.open);
 
 	poll_wait(of->file, &on->poll, wait);
 
@@ -912,14 +902,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
-	on = kn->attr.open;
+	rcu_read_lock();
+	on = rcu_dereference(kn->attr.open);
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-
+	rcu_read_unlock();
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
 	if (!kn->attr.notify_next) {
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index e2ae15a6225e..13f54f078a52 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -114,7 +114,7 @@ struct kernfs_elem_symlink {
 
 struct kernfs_elem_attr {
 	const struct kernfs_ops	*ops;
-	struct kernfs_open_node	*open;
+	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
 };
-- 
2.30.2

