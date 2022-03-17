Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241824DC017
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiCQH17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiCQH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:27:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5C1C16CE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3BUbP006900;
        Thu, 17 Mar 2022 07:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Rn1R+m57vsxO+HybZdH268QV8XR21e8GYGjpc3ENDqo=;
 b=VuQxxT9KVBF6sKf1yg9xRCfKnSWy7chhN8P84agTPFGwyBeRFqOSJODRyqBpxkLk0/HS
 fmdN9Sw3ECb04ylxwjYPG6Gf8BZHPI/wXiK6pHPpnpZyiJhC6iqDJ9z/aXSWI7Plj2Qp
 6d4LV77BeZV2AOcI/dYTFi3XcZtvU83w8YpFmnkdODidIwrlcyEOfqzaY8bCdXs0CT3k
 lwr3J2iebWIwv7kUHQZRpazn9ZPcPtn/SEdQVODAJLOY3MuLUnC6GEGcAv10IUXeauao
 eIcfChvwqLNz1QtcpmUcmjDxt6MnlTuD5qjpqnuki8jmEaDDxKlZ2sJ7sH68akGPZGPW 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52q0dv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7AuHT137978;
        Thu, 17 Mar 2022 07:26:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3et659b1q4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je9pohHaEQTmQGc+mtRWMs+V5/Cv8sHPVzo9umNpYy8iB68dIN4s2WPSEdrVTtotun1KEhWaVhho73GEvtD+T/YAXp18gC/OkX98VyEw3nA7EewEu231YY3gph9+kY4t3bAaMdskzaTKJsqWJrKl37S5p43zFJH9BHLoL8AKUJVrnkCBA15tFJP8KxTPISvlyKnpud7GxHfAJPY68eA1KV60ZZvHFCu/VDuRDY+vghcz3cxLufDVvwnd64c/86z1oviLjilf+Djt8vGsKp2kKcM1ib64Q2yngD0jvVL43SZwbPy7wR9NQkp26mJc2WtzyW1mcW9jrmDQ8mEDSX7nWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn1R+m57vsxO+HybZdH268QV8XR21e8GYGjpc3ENDqo=;
 b=VHHsMRr7GcBPiSGViGXV93EwbmykoSdqhVGtDsbrQSNIZ3H7gXFI//Y4uuZCacDIiie1I16v+WVvl/GMSUUIlUH+4YhOXv0LkLxj0eXcxLZNSsikTKnWycL3g/aQMYJQNg9BAdDe8lDMNhsMpiffOa16Id9EXlzsL5H24z093hupODJ6Ozvng72P6BeuTxjlnF4rxtJI25Rg/AMg6MliRln4KFfEZYDLYezOJodm9A+3iPT1Nj4/gSHI8KkBvW3uoBm+slyib5cNGMpV1v4Mqo3kJPRcnfGEpDSWOWuK5Rc4fQ6UmMUmiMaP4JteUDn0LCr80EQz16YEKlGwyT6S/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn1R+m57vsxO+HybZdH268QV8XR21e8GYGjpc3ENDqo=;
 b=OwJmqqVl6w/fbeORyQ6LP4pd1USGsQqKpOF48sF8k9G2eRn/wH4rGmP1CJG4Gqa9MkqwGkb9uub71Lfjd/JPTnUvfeG72SQu+60qcZx3B3O54PshlA/IFPVumTBs0STUhxTVp7vQ/i78thqZzx/bjj/VRirL4qYiX1JngHXRI5A=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 07:26:26 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:26 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Thu, 17 Mar 2022 18:26:05 +1100
Message-Id: <20220317072612.163143-2-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38bb39e5-f3d2-4163-696a-08da07e77248
X-MS-TrafficTypeDiagnostic: DM6PR10MB4332:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4332CE95E52CE259E9631F96B0129@DM6PR10MB4332.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSvGzvkuzWWW9AgtSQf5G9qcEJG9tnEvZqBatl5bxyQVG4NqIioXoAyjBksJD/jk17mv+GkkQTKvRuFmPMJRAfz3N3eWWuSm9e9rdxKSeEXmDZk/GTn5U/MUP7EN4d14CRz7ZG+wA1Hx3pazRDjekyAj+du8iduw6PLw70Z7Cig8/cF8T9hsDsTlWwmMGufEBRb22A0jdN/3ZbQ222M4CyqhxS6CR5SP1jN+dmDNZPabLhnUmeXL/TcekGcybBXNs8zby3Mg1aFtdD/IsGIr+tr+nMqCS/aBNHwV6XWHeaEA063aOmnzKHJmABe/pfhdX5WHeyWA8CXiW+A9FLdwFfyO3zZ0y9jH95uD85M6t9rYl+7GcxgiLf7gt6pNlltF4OqNarNbg07MdSmmLdY2sGP6wz7TM42V3EvPNTnET+JbGhlg07NP6zXb7As+LExPcd2GfX9yc/r51FX5iZP+4IigQFEgQmwP9hZuuIBadVpXykuZueLmvVYq0NTK+x3slfuMC9LMQvILCPWNJ0tVYryQj9sEjUEZGYKyD4BFWV524P7m5mkkt7mi8m7MzQzQmzvFvIQrjl+UQR/YkBiIl7RLy9iEATh0wT3FmlohpIYL4b+yqeP4XsZ8XsrVlxW/lQ0/KYf6diPXLbmhHh2LzRVU8lbeyj1/BVVDLCyw4b93zSz9Q008/9dOOu6GXNLwT6tAcbxYeSZou3sneR61rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(8936002)(26005)(52116002)(36756003)(38100700002)(316002)(186003)(38350700002)(103116003)(6506007)(86362001)(6666004)(83380400001)(1076003)(5660300002)(4326008)(66946007)(6486002)(8676002)(66556008)(66476007)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/HmUVUJ6ORrlhQRC1/F3mMLtLdNdujbYQJM+PWG6ts/WnqXf9omh2/28xC/m?=
 =?us-ascii?Q?Ll/dOTcoV2Bu1bW+EAWGOQdKOar0C0MTSOJ6VCNEc+qHnnLNTg1zw4uSRhvL?=
 =?us-ascii?Q?/cuvM0OV8N8GQ3dPmQomH7sahEulKPvggT1UJc1V8d4zQ+wiC9Wzz7xwdVS2?=
 =?us-ascii?Q?K/YrNkxbNEzxaTl1FjoYhs2QL8JVgexIR6MABQUIgL34sxG0F44sre6AyCkh?=
 =?us-ascii?Q?lJpQtDjxjbWnCqLRnPODvFjuQjeOH0hyJsQ2g9x4CqP3S22RHqaqAZmnw1R7?=
 =?us-ascii?Q?9iZNfP3eb2L49hL+j/uMdB/MPohoUqRgRq4zSo3qiH9Cor2TWceRufh3yJj9?=
 =?us-ascii?Q?7oSDYUO+jBkjHUrqEEbxWZ2By6rGAdeVIhNkBc6kSAnTEAIZEh+UODtvuxr+?=
 =?us-ascii?Q?SeJ4tun2BrOrNtd47ihHvJNsDIfA21eXlzDArYfOxaYW+EEzz4yDqj5oSw2z?=
 =?us-ascii?Q?2oB4YQIHhS2t0rW/NAZgDLk5sfdkd+yaYhNAXMdQTolv94qWf7HSzzFVjBqN?=
 =?us-ascii?Q?7Ge/4KOjP46EkqUj7MgpK2Sm2iDm7mzFeXqWRsJKZFHARpNv1OStJoE5QQvw?=
 =?us-ascii?Q?+/QAlTpNOUQvvR/qjQ+gewwQcuiAQ8fIQKYQs/HTG3yC2ksYNpGcg8fFQcUN?=
 =?us-ascii?Q?P8SIZWCCUFlFX5ahjRv4JqHNJn3ratrGnphHpxzxRs5AgE9sQKZd6i1tXW/w?=
 =?us-ascii?Q?1XWMHB6oFUMQ/sm9wN8yPQrK2Sen6xuXOKFB2gL7yQ9ZFenIbBPIlANxWb/i?=
 =?us-ascii?Q?TZ16oHn4UcIMofVOnNmk5yEnkCYNRLq8iMwK2SUqfbylTNiz734SQXQ/PgfM?=
 =?us-ascii?Q?LE2uzE5ghyEUpgZcFm6kqDUMdkChK4saDYhEz4UqsdOmMH9gjUA+Ojgj/1xa?=
 =?us-ascii?Q?5X5DM13NlJu2qJMv66+HnnvYtjBhzO6SAJQB32+LlDh4fp9LTnPjDKGWUxkC?=
 =?us-ascii?Q?4yAjGLJwqwDi8dTk5WV/MNKagUy48n701d+657txldvRJsoK5P9AlzZcpyi8?=
 =?us-ascii?Q?NaFFToTiFzFd+ggbXex7Tp6ojTDWyOuMq4s4qF+yoMSg9W/IIBA8eRAn751m?=
 =?us-ascii?Q?iVpnW89AR9854m+25re0f7wgpKaCfwwm8yXvtOtzh1842S9zypraFHbicTKu?=
 =?us-ascii?Q?oZMCehNmO/wKmgdVc5Qph7Czb7cHqRnGo/HfDHReoKeuHvsBmP/Gc9XOsZDd?=
 =?us-ascii?Q?A2xo7E7QfCBrLQG2ZSDrZCzy9tOU3gBHMCMtsuSwa+5sgio6eVZ8UTLHkgHl?=
 =?us-ascii?Q?0KUhTJc5LC6N7Hdsa0P+IUVeyyaaOYvBC6WUnBYCd0kyHDnNrkczrXzZ9yU8?=
 =?us-ascii?Q?syYGjwLaKzgVpbH9m8rGyBRLWndRMaeuhkWrNHIbbZ049xM6sp95+q6sy/xu?=
 =?us-ascii?Q?D0KT1giaYw4dMEbC9ndqrE453RtzTigkZO7YvgVK0xcbUAIvIRptzoZ4twzA?=
 =?us-ascii?Q?hFjsreFVqTg9bm2RBFpFt0dHDPPar3uMT/8vZG6wBHSUchjKlDHBPw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bb39e5-f3d2-4163-696a-08da07e77248
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:26.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLhK8IFOAHnVJdYxCvnLoahmDwkYTdXWCDxNPgwailSIWed2tmVcRzeoYsZGDg0WrZWesZtcBHb/dHZ1hZs+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=972
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170042
X-Proofpoint-GUID: V1BTvk8l3aRyqykTlyQzM1OP2j0Peigz
X-Proofpoint-ORIG-GUID: V1BTvk8l3aRyqykTlyQzM1OP2j0Peigz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to change underlying mutex locking, without needing to change
the users of the lock. For example next patch modifies this interface to
use hashed mutexes in place of a single global kernfs_open_file_mutex.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            | 26 +++++++++++++++-----------
 fs/kernfs/kernfs-internal.h | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 7aefaca876a0..99793c32abc3 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -30,7 +30,7 @@
  * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
  */
 static DEFINE_SPINLOCK(kernfs_open_node_lock);
-static DEFINE_MUTEX(kernfs_open_file_mutex);
+DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
 	atomic_t		refcnt;
@@ -519,9 +519,10 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
  retry:
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	spin_lock_irq(&kernfs_open_node_lock);
 
 	if (!kn->attr.open && new_on) {
@@ -536,7 +537,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	}
 
 	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	if (on) {
 		kfree(new_on);
@@ -570,9 +571,10 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on = kn->attr.open;
+	struct mutex *mutex = NULL;
 	unsigned long flags;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	spin_lock_irqsave(&kernfs_open_node_lock, flags);
 
 	if (of)
@@ -584,7 +586,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 		on = NULL;
 
 	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	kfree(on);
 }
@@ -724,11 +726,11 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	/*
 	 * @of is guaranteed to have no other file operations in flight and
 	 * we just want to synchronize release and drain paths.
-	 * @kernfs_open_file_mutex is enough.  @of->mutex can't be used
+	 * @open_file_mutex is enough.  @of->mutex can't be used
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -745,11 +747,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	struct mutex *lock = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		lock = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(lock);
 	}
 
 	kernfs_put_open_node(kn, of);
@@ -764,6 +767,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -776,7 +780,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!on)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -788,7 +792,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	kernfs_put_open_node(kn, NULL);
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index eeaa779b929c..df00a5f5a367 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -164,4 +164,22 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+extern struct mutex kernfs_open_file_mutex;
+
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_open_file_mutex;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct mutex *lock;
+
+	lock = kernfs_open_file_mutex_ptr(kn);
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
-- 
2.30.2

