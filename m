Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164D24C3D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiBYFWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiBYFWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:22:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F93AA55
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:21:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4nVbC028644;
        Fri, 25 Feb 2022 05:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PlWeK45XGS9t3zzcEE0vktnH7u79J5+oUzg3+TDy4fM=;
 b=avEylrDlnlhge/gnRJMVq3xucuB/H/Szh9p7OhAPGZmlkhfqyYRK1lrCfu3M+0BuExkf
 drG9f4Sr0aHVZOB1p4H6ugxSfGaVieWHPeuC8MW02TzcGqSc1rajUoRDv2WsLYH2ibjV
 /zSldVI9uzleZz2Nw2xXaLN2gVRJ3fsDbE15Ss3ZRlsM7Uxh1CV8x+6lywrH4e2dK8zF
 NBKX7/PkVwojOiiXO2Z4znk8a6hzUbLpLXDAa1BiREbZ6Y4fYaT6t1Mgzt0MHL54dpYm
 cVWIahjlHconfpLDz/YZMedd/1HqbdIMDWhV2uTsqXZneTUysxDic6TUln8P2KGpOb8G +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar8uhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5B7uK181664;
        Fri, 25 Feb 2022 05:21:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3eapkm8a5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj7tK+koA+rpMLveWgaSfc1bSllv1iJFcQuSCaX7Hiqkk1QKNc1KISUmqug4uXw3AlG53JuAw/Uw7gYJBfbIIa/LDWYr8kc+iP6P9zCa6VPQOouR+rbolAKpttWNpSJ5qQI5grT2c1j5wxZb8dR3LBQMifecP1x0PiFuiQk4UHEXGE7Ig1PCJQuq5M4UxfkX/kB3avmD2lokzqZiqwZqG5d+UZZfaWhaX3hfBWE/7DLz4qAfh3Oy/1PptiSs5oNs9LwEXkGWHYSjbmUox+2svytt5DUHOzCxgZ1in2jE8IE4DMdR93sbGmWetP1cvyFQmBvovVb6PpA3YfacskJ85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlWeK45XGS9t3zzcEE0vktnH7u79J5+oUzg3+TDy4fM=;
 b=MBtIiY7vwGL51yebQ/oorbcQwq+QnORGV5Hmoy95ilEFozl0cEySn3YuRJ3yaEvi4/nofgZtusbtbTfMfNxJ/NXJ+DiI7lwwxsrIxEg5AQoKDJr8VryHWT6fDAQNsdaTKOkYfBik0kXlLRZ8hJqXb5IPPFXoMkeN6oIkJQMd6Pc/1+uqPBz7VGRiVy/8aCkZqVPEHeA4I+aK8hDHNYKUqlAU6EPRlmRBaB88L5cunrw1wp8sjaeLo6oaSbwHVZxgaMzu+9WyhaPW7ek/rFNHBSBEqSC7YqTj4JSNTfLhcOJIjbX/FTMaLtbJqScmyC2siaXI+yNalPSE4mFgdGkRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlWeK45XGS9t3zzcEE0vktnH7u79J5+oUzg3+TDy4fM=;
 b=COveSxUyyLZF532djh8ZevyP+UBjCMoxS/ahDC2uWtSFjHGwJ9+dHUYuLifDXny5dmoFIJckI2n5TnUhM3z5gzvMPuUUApOnU3aiJCc6N/4Ve4tLuAR0Wu2tzO7Bfq+0ZGsggx8qro2PVWvvpdnXXwNiu87366+ujHiZ37/+qXI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1677.namprd10.prod.outlook.com (2603:10b6:301:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 05:21:37 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:21:37 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/8] kernfs: Introduce interface to access per-fs rwsem.
Date:   Fri, 25 Feb 2022 16:21:14 +1100
Message-Id: <20220225052116.1243150-7-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225052116.1243150-1-imran.f.khan@oracle.com>
References: <20220225052116.1243150-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0043.ausprd01.prod.outlook.com (2603:10c6:1:1::31)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84574453-6edf-4962-f6eb-08d9f81eb267
X-MS-TrafficTypeDiagnostic: MWHPR10MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16775390BAC39DD7B7DE2F57B03E9@MWHPR10MB1677.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMdqWCiLw9xW2S7Dq5H1qzCDpQgYf0uiypNMFT/pvudGymSkEF8GMxHqEX6ePXOlPKO1Fy3YI90A0IWoSpZuHt5dnSpLY1KKNa2BEWg8YhlnWR1kw19DshKCLt3uuMB4FC1A4TMoyPNvS4Dz836ngRGYCYsYwuC5MRCsyLSYWM+1fBdF+QCaX8xwccWxwbe8Nu469qeFOFsy2JfpQQ+vLshxYT+K5gxxn3WUlu1o4l4hInKhJ3Kswt/XNtf0mKYeF8QFpCwhUVN0xraXqn+HruUlfDrgr220224wboUf4kjJVhQm+7VudiEt7HWMlpFQtNNs4QzNmXpdbfjJwNvLMyNakR28yNh0/G6OoNod3x0J72KQCy4/8ptj5o1Q1+qL3k1jWzfuiBjrypB8ddT0bQGVAXxut/6RbnatFal+DxhiD7pxR5XSNhRaWH4ecMvMV+7KasYY97L52COyV6MQRHJl/YmxaI4hgAZo9KSVvZsjyi90M4R6vJgE3CNiVGRaYs+IvteEDMnRzcUKmrM2zrcVTJDV1FWuf2MZz+JDQpt5ZyzYCZOVxWechY3Pcx7qtbp1zMki7t19G3INOdOZAXfb1Uz2jS3hyj8/d81flvbjpvng+RKc7sr9xTfX4Ri/maqDeRa66vWTyRusyTtldEJVtwUnaruNgzrO67wMhB2JH1v+ldHOPRsT/wexJ6bfbRnIYtiUmWFbsbDUEx/xYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(38350700002)(6666004)(8936002)(38100700002)(83380400001)(1076003)(30864003)(6512007)(508600001)(86362001)(6486002)(6506007)(2906002)(52116002)(316002)(66946007)(36756003)(4326008)(5660300002)(8676002)(66476007)(103116003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2u7V/KfI/TLKzhwXBJr53eXFXgUr6H/8969xnQ9eH8mbqX5tZt2DCGe6xUqj?=
 =?us-ascii?Q?n31F1r9iBehMZUqF592EKjhwP92aVm6/Z7o+QNLLEGKRDu1I3R24VMD4Up3F?=
 =?us-ascii?Q?jXqJhmDjQcLUx2wnwagD585kgnc4ImDzrkvrDCxDEU/KHvbjMvDrTtaBNOgj?=
 =?us-ascii?Q?irMdmn0KcFe1kgvtQk+jihUdKU3No8cZ2Qh/e9F5bRXYBA/SoauUvvRe14bf?=
 =?us-ascii?Q?NcDeXiPSEDQJMx1RBja/yoZgv/xtsJZSBsFVvRon9CGML6ikEMv9n5AE8NJ3?=
 =?us-ascii?Q?Ax23XE7lZsj97gvYqkVsfOsN0b7jtqVia2ZmYWQnPfBptxkPOZpq3H/LQ4j/?=
 =?us-ascii?Q?tq0gSgXd9LQ1OglP4LvaX0BfcTNh9wkMnblVaQh+qOC49CZ+YKw7jVOHbcUm?=
 =?us-ascii?Q?zW8SnChn0XEGUMM0DSY7Ud8HHzuSCRGK+JaXOLf9xHBUcGyqxJTuKMkG1Ig5?=
 =?us-ascii?Q?pqgxu1qt1TB3VlaU8VwNRR/co+6H0onp9kmnswKynY/wtcOdEzwU83Jw8gn+?=
 =?us-ascii?Q?5dJtQKXzt5VD3kwZfjpNWc27SURYKTxVFY9Tgx7PlsSFz+NxLgrTI4I4fS4X?=
 =?us-ascii?Q?tifyLpFEP4c3t/m0BToE3TZiTygKyckBFFKnEhSplkYLxaCnFw7HeouIRwsw?=
 =?us-ascii?Q?pabu8gacEu6mTXTVDAtFvwwzFT4NhtM7O3kui9Vt53xtOfYCPtf8+Hp8J2bm?=
 =?us-ascii?Q?I+Z0dka9N07Xl7aRv0+sQGzPBM8ePth0r83++OdYDXeSacdxYGFVwnnN8fe5?=
 =?us-ascii?Q?lGFgtuFgTXjOnuVZqZPNY8Q1KuJOjNBRKEPWDAatHlAfmbyTBM+q3BiovH/9?=
 =?us-ascii?Q?V7g25rE2jx2Rpa66JAAdNz71pYdMMf4Y3Gb1mU2lev4Qc5FA5BP8FNaqXyP5?=
 =?us-ascii?Q?34yOb+firZZwfdeXjxDzmsW0C4O9gN2jp853isfjr3RETZV9dQOS87Vrj0n4?=
 =?us-ascii?Q?qpbnwMD8a+URq4zHdlZ18ooisp41iWusEIsPPP8DAxeX1MEXnOENmHwNN5ag?=
 =?us-ascii?Q?W7it96H3yjBf9eytbKG2zZeF3KamvwaLFvlYBbeH48SCKEuCVC31rcbBqjLi?=
 =?us-ascii?Q?Q08A69zUeO9wI8B8/QFxqjBXL8YZRegIDuoyXBuKaS5qKbij6nu2K02SAsCB?=
 =?us-ascii?Q?CsIXRvtllXm/1pIC80h0cFinTTpvI+r9OZgzgmTHzhkVvi1N5W34WZLbo44Y?=
 =?us-ascii?Q?2s5TpOAQuYxxJT3rj2L5bHKkfdvh26vXv5HjSfwGJsEyFIDzzevq2/4R0rDo?=
 =?us-ascii?Q?BQ+FQWkBYIJYJ6dE1rS5c0aTa2vFec42gV6qmyD5/PVdcPZpNvgbSe0oIMt1?=
 =?us-ascii?Q?SZFt3fL/j229d11xdqQhBcWjQCt90RWFr8UoUG5AD+QYRTv2OpOCA8iC0oiH?=
 =?us-ascii?Q?R3eiC64ONRrfVQBgq8h6QX3caGYtw7naz8e4fon+vIte5lPq/0jbxPgcR2K7?=
 =?us-ascii?Q?JRh2299gW1juIVRFe9X2wDRqKa4IHV0sEvbcUrSUzyzbjOuRmr2HFtme53wf?=
 =?us-ascii?Q?DdFynV6yyBeRD9a8Lx41cHAu5VAhpYF7QOidtUAP63kO1ebeKNJ/7TCDlPVm?=
 =?us-ascii?Q?0LD9lHdW5MkmrFORvEBjCvccex8SBIy3tCFsHJV1fZfs9baj5fJkL19cfiBC?=
 =?us-ascii?Q?YeFVoDmmsQBSpq0Fhdte5hs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84574453-6edf-4962-f6eb-08d9f81eb267
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:21:37.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS02jQ8YySebq8vCYzNNz2JSxLOohXSpQP8R7kOtFLRsmcdPyrrxMyisKPl9fszC+cZ+AfhFpoBDfRxMtIlypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250027
X-Proofpoint-GUID: KzkgXq0Hc0-38JVhnJ1SysCOHkb3qQtU
X-Proofpoint-ORIG-GUID: KzkgXq0Hc0-38JVhnJ1SysCOHkb3qQtU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

per-fs rwsem is used across kernfs for synchronization purposes.
Having an interface to access it not only avoids code duplication, it
can also help in changing the underlying locking mechanism without needing
to change the lock users. For example next patch modifies this interface
to make use of hashed rwsems in place of per-fs rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 114 ++++++++++++++++++------------------
 fs/kernfs/file.c            |   5 +-
 fs/kernfs/inode.c           |  26 ++++----
 fs/kernfs/kernfs-internal.h |  78 ++++++++++++++++++++++++
 fs/kernfs/mount.c           |   6 +-
 fs/kernfs/symlink.c         |   6 +-
 6 files changed, 156 insertions(+), 79 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index dc769301ac96b..8f22b2735755f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -25,7 +25,7 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(kn);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -461,10 +461,16 @@ static void kernfs_drain(struct kernfs_node *kn)
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held_write(&root->kernfs_rwsem);
+	/**
+	 * kn has the same root as its ancestor, so it can be used to get
+	 * per-fs rwsem.
+	 */
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	kernfs_rwsem_assert_held_write(kn);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -483,7 +489,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&root->kernfs_rwsem);
+	kernfs_down_write(kn);
 }
 
 /**
@@ -718,12 +724,12 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
+	struct rw_semaphore *rwsem;
 	bool has_ns;
 	int ret;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(parent);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -754,7 +760,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -768,7 +774,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -789,7 +795,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(parent);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -821,7 +827,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_read(parent);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -860,12 +866,12 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -885,12 +891,12 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -1046,7 +1052,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1062,13 +1068,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
-			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
+			rwsem = kernfs_down_read(parent);
 			if (kernfs_dir_changed(parent, dentry)) {
-				up_read(&root->kernfs_rwsem);
+				kernfs_up_read(rwsem);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 		} else
 			spin_unlock(&dentry->d_lock);
 
@@ -1079,8 +1084,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1099,10 +1103,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 1;
 out_bad:
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 0;
 }
 
@@ -1116,12 +1120,11 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1132,7 +1135,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		 * create a negative.
 		 */
 		if (!kernfs_active(kn)) {
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1147,7 +1150,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 */
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1270,7 +1273,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(root);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1305,9 +1308,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1321,14 +1324,14 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(kn);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
@@ -1398,11 +1401,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	__kernfs_remove(kn);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 /**
@@ -1488,9 +1491,9 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1518,9 +1521,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&root->kernfs_rwsem);
+			kernfs_up_write(rwsem);
 			schedule();
-			down_write(&root->kernfs_rwsem);
+			rwsem = kernfs_down_write(kn);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1533,7 +1536,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -1550,7 +1553,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1558,14 +1561,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	root = kernfs_root(parent);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(parent);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kn)
 		return 0;
@@ -1584,16 +1586,15 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
 {
 	struct kernfs_node *old_parent;
-	struct kernfs_root *root;
 	const char *old_name = NULL;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1647,7 +1648,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -1718,14 +1719,13 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
-	struct kernfs_root *root;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1742,12 +1742,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
+		kernfs_up_read(rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		rwsem = kernfs_down_read(parent);
 	}
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 07003d47343d7..f46c25fb789fb 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -838,6 +838,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 repeat:
 	/* pop one off the notify_list */
 	spin_lock_irq(&kernfs_notify_lock);
@@ -852,7 +853,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
@@ -892,7 +893,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 	up_write(&root->supers_rwsem);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5daa..efe5ae98abf46 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,11 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -112,14 +112,13 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +131,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -187,14 +186,14 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return 0;
 }
@@ -277,22 +276,21 @@ void kernfs_evict_inode(struct inode *inode)
 int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
+	struct rw_semaphore *rwsem;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
-	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 64e9cca66d436..bb934949d5eb5 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -188,4 +188,82 @@ static inline spinlock_t *kernfs_open_node_spinlock(struct kernfs_node *kn)
 	return lock;
 }
 
+static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	return &root->kernfs_rwsem;
+}
+
+static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
+{
+	lockdep_assert_held(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_write(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_read(struct kernfs_node *kn)
+{
+	lockdep_assert_held_read(kernfs_rwsem_ptr(kn));
+}
+
+/**
+ * kernfs_down_write() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_write(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_write(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_write - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_write(struct rw_semaphore *rwsem)
+{
+	up_write(rwsem);
+}
+
+/**
+ * kernfs_down_read() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_read(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_read(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_read - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_read(struct rw_semaphore *rwsem)
+{
+	up_read(rwsem);
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d35142226c340..f88dc4e26ffb5 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -237,9 +237,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct kernfs_root *kf_root = kfc->root;
 	struct inode *inode;
 	struct dentry *root;
+	struct rw_semaphore *rwsem;
 
 	info->sb = sb;
 	/* Userspace would break if executables or devices appear on sysfs */
@@ -257,9 +257,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
+	rwsem = kernfs_down_read(info->root->kn);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f7..9d41036025547 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,12 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 	int error;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return error;
 }
-- 
2.30.2

