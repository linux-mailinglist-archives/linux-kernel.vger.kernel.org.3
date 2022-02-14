Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92E64B4F92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352377AbiBNMET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:04:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352250AbiBNMDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:03:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6ABE3D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:03:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EBeNu5031188;
        Mon, 14 Feb 2022 12:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mqUfa01y43OuC0nj75CxH9QN9ownWcUaB3x8mkvcYTQ=;
 b=qACH3jcVRxToCC9DLvCWs2Cad2t7RyDc78qj9igCpoW+zJy4Co0AoHeJaqf2DHTPL81d
 cFAvJV0FXimN4z+CuIMNs8fojGeBXO77uMbuBjP9PWrqp1ATg/SEqgKukINopRNFkD7o
 IwYAgvYBVgQaAtjz9mZ/6ZrxMAErUmXsrlTC/u+eTkpv41e/StfmUl91j+734N43KdHN
 lXpXYVeqp1FDGVu3AAu16NPpgVKRgy2OCIGB+1r/P/dPF3z2wWtq5fve/C3t/2Qxp9TY
 7VOtLZeGvvI6dYaLWDNTmPIf/vGZ9zuCs6rItv3/VFj4Vf6eh8CFbelA9gUc0H8++4VP xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbv32b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EBuM0E184636;
        Mon, 14 Feb 2022 12:03:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3e620vusue-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h34lCqLgVGT2aq3UQlFUA72vZNJYLxgVeztlY5y3e3Y/5WLREtxZXzjTo0PR6TlJ0ODjU2PHqbEXCKe2VT54B56f00Kcdtr+VLOQy88AwU5emGsYwLK/W9lWFbqe7I7iCd2NXO0noyzm7sNAnWU4sKCGbCgPyB7EbmPm4jMktWO+Ho+4RP0XEyqQ82AXAnKk1ZgsMUhxa8zgd0+20tGprekkTwXe2VzveKhkjLBvg3Bq1TYQE4zgj/QK969a8f/UUfZN+1vD25ECk5E3NANa+H+BHvYi+u4c0tDr1/n8ziQvb5KSbcH95JvyFuelbE1ce2B+mckdRgtSy+VTSisPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqUfa01y43OuC0nj75CxH9QN9ownWcUaB3x8mkvcYTQ=;
 b=n4XRNtjx7qJxFgvQpyjmomoft0/Wnf5jhGvRCT4zeMsfuZv3Gfid7yf6IzHEU2Zwt0nG/OKiH1IFD0nc5Q74MigpiZy0EOnvZ2WS8A7+qyDUQEanWcl+RWfvFjgKs6/NPWXuly05ih7tI4twAt12bvJMdYeztgfOJfowrMHBy92Ys/w7+KCzTsBmc8motkEdtQMJV6v9PhEyprPj9G3lC3FWZrymwYWapDnz0LMuSHkaM+1P5wnhVdUlcxs6PETU3ccJ1F+aD1Mj0J+sAmE6vHh5qWNiC26D8qt/25oitT/L8b2y9hJHYtVLk/thAppxs1CDUZIW61enKsHvBsq9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqUfa01y43OuC0nj75CxH9QN9ownWcUaB3x8mkvcYTQ=;
 b=ZRT9E18TUUMfBg1WcT8pXW9TCh58Yhmq1q+7ou/49UC2QEAoPwDDNb5G6dqpiuNIlH+fW4VHB2t/qx1t7KaVRGCcfZgi01AOq5VVNOeos34HCEA3yj4/Iq7zH2mMiKt2yVr5vhFlEtWUonpwgl9gtVRFcy0aok83tEirYG5PvI8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN8PR10MB3538.namprd10.prod.outlook.com (2603:10b6:408:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 12:03:41 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:03:41 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/7] kernfs: Replace global kernfs_open_node_lock with hashed spinlocks.
Date:   Mon, 14 Feb 2022 23:03:19 +1100
Message-Id: <20220214120322.2402628-5-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45f865e2-51c3-44cf-b134-08d9efb20aea
X-MS-TrafficTypeDiagnostic: BN8PR10MB3538:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB35385DB31C08E8F158CEA068B0339@BN8PR10MB3538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OHqDIaw9kTd/qOi3ZhA93gPIJpCxfcCsrb8a67prMc0bnhG6K/Av+OrLMNCXbuIgAPUA/bGQwnjF96vGwmESy6Wp8yXtK+QQwxFzfdgbZt+Vcpns7y+DDioOrhZopyJPYcKj5TiTSq8ldkVLyBd8i92r3b65hhLwVoNlwyl0RXPoPrPGjjrZrC7mfHQh4ztJypNUGU5HbYVyyaUCBuC+kH6i2QUwM2iSTiZauQ8B0fx/YR99Su36vcJzZyvlPe1zIDKd2vAd6d+kK6duBMiQUGlO8r528/0Fs5WG7OnnaLHkUtgUILQ6tb5BRFflpELsS7dIYF+tQZYviXUU3S/GpL70KzX/SR51w33GU5DG2y9oR0IfF3nHIL+mqqNKk9zXMA/xox9i0v2A1OYChqfKJYufSjVKFtEJxZZztr27aXLFQWLyI1/432kfWeGrkQsAo7MFqijszKH+Ss49Vlawd6PpNV3XT59H6xGNFQ/N86/pa8A6jhJ42WgCRBzUq/lo5gKMdW3zy78y+fPffk3x7bI1vNfEgE9fsC702fKakum7zZb+tS64Sa6DOc8l9dGY8QFzuTXCOlf2I5n7nkXxZJHnYNcxP+7m+y5QIdEcfJp2mR4tZegTBTBiwfSkyBy7rLb48UYNNVQJbQ39rnOecEkJKkddL7SjbmANRBfVXMMIhR27gmXlvhmvlB9Cf3ri4azSfGUSgvO6609OrWFKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(66946007)(316002)(38100700002)(2616005)(36756003)(6486002)(66556008)(4326008)(66476007)(103116003)(186003)(1076003)(26005)(6666004)(6512007)(2906002)(86362001)(508600001)(52116002)(83380400001)(5660300002)(8936002)(6506007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ELYyL6QeAMkTnWWj/pRJLd7cgRkzVxus9bUGAD0a+7Ah/6KpYFTyvPx2XOil?=
 =?us-ascii?Q?k1G9J8wb4Nxx+aO05p8H17XEif1IIEqBSr4RekeOqnviTqJRkZa0+ufVuRTo?=
 =?us-ascii?Q?X7fZRcmjVqWFV5nbUL97aX8kvZnB5nf9kxHVBvJdkUvkRr9FIfhgheqCoFKz?=
 =?us-ascii?Q?NNJhR8h5NYjQ8altC368iOLI9lePhAjii9ueFTa1xN49Y7bh4pzruwqS0StE?=
 =?us-ascii?Q?gsA7tScea7/jWOSd7reP6WUv7f0BDuJDvT3cBIl/hw7dbRSPpS+x4IiaHsCr?=
 =?us-ascii?Q?DfIr7Z6pXWWXAqH3yTfGRpwgIiCMDUv6ieMHS5WC1M4mLoX+HKIbQDiKezvt?=
 =?us-ascii?Q?EFls7yFp3854DCMtsETKF81FSLWu/ECm2anJPKenzfwYLxIP1pBd1tTkUxNV?=
 =?us-ascii?Q?n/n3LCSrbx7S/mLBdJRQgD8YpksMGjBO2AbGqKdWmtRGfJZ9uJ6fR3PUiDKi?=
 =?us-ascii?Q?yk1vaPW1ywHAfYpuNpTlgdTbPomABlm2M64uS5FTcklL5V4EHUT+laYuBB6D?=
 =?us-ascii?Q?UWoFfcIG/9Y3Vz5iKLc1c8kEVhPEEqhsoPrvbHSKjsv+ymJs3E8TgScQZ707?=
 =?us-ascii?Q?e4sAFmm+DYFyngEcreaK+RCiCdP/ZNgbqE0S8Ms39aj6dNp37/WLXHQYLXLS?=
 =?us-ascii?Q?+qII+3aStxGER28WXnKOsUH7FmNkiX7wfSvcKZEvLI1wr6uvf0YGrEw/PbI/?=
 =?us-ascii?Q?wZixB6MLEDMSm1TbcpRmIacvc595eqHdKr59HO7KlUBOwvPTTvrnQTjoK3Hi?=
 =?us-ascii?Q?RIKrRNABXLPRHv1jX7WWP/wOptC022gKVxjDhBWhLi9YroNr9DrOnMJK86Cr?=
 =?us-ascii?Q?cUm7qlKkQ8YvFNZNmKw4pj7YvBvy84il9UUxOz0a2r3tgj5orQly2nHzU48F?=
 =?us-ascii?Q?vJ0YFNoTe7Uq7VO1FcDhQOxBomtBuG5ndjTmgm53+WW1HAUom+fl89OZmuqL?=
 =?us-ascii?Q?3sPsT2ZeAOjbHQFUsDJ77aTU3kpN5IYzBLSdkDXDecsNcX1Q2E7I/ACFQtU2?=
 =?us-ascii?Q?a1fxZGs7nGgETZJmsfLTY6OErhbaYqwCJ4c3VW0zrReI0o1qDjjh4woBZrl4?=
 =?us-ascii?Q?8JbKzVnUef/rQKKBJG5r/oDt0BS2pZujKmFnd03qvPOyBDO1JMENc1nHGR+v?=
 =?us-ascii?Q?vR9qKzCvL0sMUYsA/hZDY88qNhUH7ks3y36c4/70Og4LcMwopjkAOEgLKqx8?=
 =?us-ascii?Q?yyAQShKg5KsuPAjH/55n07XR52C8VJL6oEVeGFlEiaP3GRge348Xho+o6rjE?=
 =?us-ascii?Q?DTQZUmS3wwDiQI6kU7KzqxdgporUQBibuiA8Dxf6oxQVmUzlFLcv2HgNY2YP?=
 =?us-ascii?Q?vW2xQGu6Em/zJaGXWzRIHjNsNfkvS+QgSdamy3hURnblAXrRTToZqEC69Q1s?=
 =?us-ascii?Q?2cRyHIHhaL3+iNdwiXiEC0KetsHWg/QPIC3vZM3g7Cc9KCgmbpMD7BCaVG6b?=
 =?us-ascii?Q?RBs3S4hfu93kDFFcOmnMXBgOpYEbmCv9u3wU3k+5NvSYp38Df5kJcq2DWvKI?=
 =?us-ascii?Q?vVFDXI33zDYrzP57eu0rL7x6Va9EI15l2rqs8LqzzbtsB2f/RM/Mw06QS9aM?=
 =?us-ascii?Q?fXcF0x4X3vybA7B7sOWw4FmwLVuD0pEr0yeCkntdPDcuLx/Fvx9LxrtonjGL?=
 =?us-ascii?Q?HXEPpYdUABSsdsaW7+Z642c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f865e2-51c3-44cf-b134-08d9efb20aea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:03:41.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pRXZhOFK4M5NSyYK8SaRtArOmMsG8caRqZTK+bWoqcgnfmQc4dp+kwapzCBUIObGyEd0UX12d8J5NqL6G5FxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3538
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140073
X-Proofpoint-GUID: 10eXItNUOJtT8Jj75PrWVY-7fxTOoTlV
X-Proofpoint-ORIG-GUID: 10eXItNUOJtT8Jj75PrWVY-7fxTOoTlV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove global kernfs_open_node_lock, using hashed spinlock and
corresponding interface introduced in previous patch.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 295fe67950346..f3ecc6fe8aedc 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -18,15 +18,6 @@
 
 #include "kernfs-internal.h"
 
-/*
- * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
- *
- * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.
- */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
-
 struct kernfs_open_node {
 	atomic_t		refcnt;
 	atomic_t		event;
@@ -520,10 +511,11 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
@@ -536,7 +528,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &on->files);
 	}
 
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(lock);
 	mutex_unlock(mutex);
 
 	if (on) {
@@ -572,10 +564,13 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
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
@@ -585,7 +580,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	else
 		on = NULL;
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(lock, flags);
 	mutex_unlock(mutex);
 
 	kfree(on);
@@ -768,15 +763,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
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
 
@@ -921,13 +917,13 @@ void kernfs_notify(struct kernfs_node *kn)
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
-- 
2.30.2

