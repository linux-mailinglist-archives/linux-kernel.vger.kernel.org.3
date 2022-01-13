Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8C48DD64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiAMSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:03:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53924 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbiAMSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:03:42 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DHnBlD022208;
        Thu, 13 Jan 2022 18:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=XkA1nwfoP0Sp8QHd9U6BJ7gVnL28cHhiQKcW+WuhdVg=;
 b=xnu5T8xTO74O2SMo4/raLf00VcWvbvbR35nEfpouXy+3Q5YuI04CnbD4ruM/ue2BOvqq
 abUzh+VPNghEDhAjDjzG3e4jXc+jqvYI76kZ3M7DlUh4SWGPrsmcmW4mtnYpKpzpK9kb
 4FJtmpxxkj6i0E7jBto9MUOGCCHSqCCKfyWDvt6yX4fBSjQUbyQJLkO/ybXGEhv6CufH
 X1wyFjlbKHaWJckKjXaBaBu3INZ+R9XQoUz1bC358wAPQeShBKnyVT36QLBsII3O4KYB
 CSjyvyU5mTz/W/DpbsQ3ECV7GO1Y74ff9k9R5s3ZDeGz9uqZS9ShKjKnBuiZxsM5ycxJ Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djjm0h4ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:03:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DI0JxH174179;
        Thu, 13 Jan 2022 18:03:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3deyr265nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:03:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObyCLs9RmUbVopTZWkWpPWZDLoVLglLVP0MKlJERl0ECmZSPs60qt/On7Na+ejpIgH6fW+9oOe6AFaX3Xk3+bhGlfy8TeX0CUR41J5MvQjV46UCVXCjUHukH+2hni8EPukfa+40lsIVBUSU5foyE6yeL53bJ3RygUmGWTdPPgSJysBdvESPna3v4apUdQxNdCweNj7wumH3wtdZrTDnSPswSNs9dhcbJ+Vm69pX1mtbzv3V7OUT3+9CL0di9vwX6VheGnF44QHNDdVmttiTPP+61gKmxOrPLVWHJfmcqLZ6NNeMxgpilTMWPiJhxCVmzlipdu10C5M/duSHkKU/2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkA1nwfoP0Sp8QHd9U6BJ7gVnL28cHhiQKcW+WuhdVg=;
 b=JOZAag0VDEDyHrPgOvXY8/Hab7nHUYHmTR3ETZNjIHzjxEDyjqeiyn6ISrypvu/pxpjmtx3BhVfiGqQqowOs6X53WiodQKW+gJcSwR3TVJdxoTSBPQ3dFgq8gaAsXGStBZ4uvr5E9eQ9A0Rs8F3O6tX0IcfNdfgXWusfVofXbrjtGQiFB/ce1ZU31e3Dbqifg4t54KTi3dSvJj4BPm/lo96H8NpUwHqXZkqLd02nJltrWEY6EAISw3IhrY+tO6VSIXfqXANpn1dFSeQSIybGitD+CaKx+uB4Jum2MqJp221KMX8sPiyuLuwjT9Vx0QeiSC7c2+QZ9MKXUcFoPSvezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkA1nwfoP0Sp8QHd9U6BJ7gVnL28cHhiQKcW+WuhdVg=;
 b=ynBpiulRivawsqmZI7cAymt5xzhn855VgrYnWtNzaR8Mau6kqPy5MzJIlKvkuzve9FPHwD0SRZu+44Hhd/NcZhi4gNrQLrPunVWezl3eJC8fHvOJ6fDsaR02P6Ea/DSNYoSO0i7JXmqK6CkZHUBBmBa+GEfS+40OvUAvZHaIICs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1540.namprd10.prod.outlook.com (2603:10b6:404:47::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 18:03:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 18:03:22 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Date:   Thu, 13 Jan 2022 10:03:06 -0800
Message-Id: <20220113180308.15610-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113180308.15610-1-mike.kravetz@oracle.com>
References: <20220113180308.15610-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d285895-75d4-445b-5f96-08d9d6befce3
X-MS-TrafficTypeDiagnostic: BN6PR10MB1540:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1540C91C17E8B838245F0472E2539@BN6PR10MB1540.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCe2MSO1lM4TrIA12Gtn8QJiKJOqapbL8/+1aG3UA6Zky8sKba30ACwo9i/xVRA1CsY3nvwbvqecvcN8q75SYxY9Xb9Z7BajyfppJBZmXGv/6SMQ2BMr7IZQmFWl86QIjrsYA877Vx1S1iECE1KDjuDFZCutOkUmFwpDdE929ekZJYnCTlwe6U4CMPobdn3LhMwphD+U73MUKzew4oY1vsVaNF9YvtAIoOrR1y+b3aD2GjohTy9ptErQqajANqZMjIh2S8prgxWNZWuSKzWQRXancLIxaGSjLTovRCcz5kv/jEZYOZVvQgjdOqknGj2V/1A7F0kA0bp5QSZfRv9Cv/Vo3XVbYtD2ulmfJuR9rm9ZlbYPY0z/pMGyU4Bf7dcvHbrVPA7na0KlIxxKU8k5CIsZeK3Y+x7pWCM4YX36y0oPc5VLFCdo5zmTeQXa7e2Vw/hg1MyNSGYV6s4CtmG+BWij+bwPqqN0d6GeG5vcsxoXEpLXAQuLq6EaiVlsoroQAbVplO0y2CQRQboK5JfgBs7txNTd8bLZe8EjdLv/snVWCrpL40doC57N3R7J4MnKbRhzK1wdUD+Y1oeUB8jxyC8Eoyy70iFFnBlFYhC1TxxzXvpcYfjH4QycUww7HD4ENA39km3BhCGik7ZwxXhixRatiHObxZ5i6T69HqtEENdXgaVrciqkP0OKbonUJwxgf0vGwLLmt64KCxSEdeXeSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(4326008)(2906002)(6506007)(316002)(52116002)(8936002)(38350700002)(66476007)(38100700002)(508600001)(54906003)(66946007)(107886003)(8676002)(66556008)(6666004)(26005)(7416002)(2616005)(1076003)(44832011)(5660300002)(86362001)(36756003)(83380400001)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+b18qfQvDpbeV2n6Sdac0RBsdRFaIYF1uf4tilum5ui2pOO+kknUgfB70uBM?=
 =?us-ascii?Q?ryKP6PUHCviLAKKkgbgzFGGpGr72Bx5ggFwipRBe1tO3sfI9oVZVFQDK9Y4J?=
 =?us-ascii?Q?QE9Jhvj8E+5Rrca46Np9K8W/8U1w9bttQKynqP1bvdDQDNIUh9wjV7PnLQEz?=
 =?us-ascii?Q?2aHK0JLPEK74uIO6JhIAbQMaAU1mScQWKsGHM6dI/Cuk7yi0ey5kCbC2VBo4?=
 =?us-ascii?Q?PzWoUFs/D/t0VwcYEErB33yqr2MWE9jQgU/Fi/inr+eCfBhRS+B8BjgK5+A/?=
 =?us-ascii?Q?eSVR9ssrTcoEGNwneiwfzDaO0vpTTWQqVyVQcqS7Vn7HDXZOFcfXguBJ2JY5?=
 =?us-ascii?Q?5XtoQq92PUbm6LIak/MFaKkmP1CS/RCzgt9WGYtY0yjyZcNuwVHfYCmkf9ol?=
 =?us-ascii?Q?Yu2sKVnPQnJbbLpV/Bcdz7bZHJdSKF9UxZJlBdVJfjDVvmklLh9dTls/XYGx?=
 =?us-ascii?Q?VnIO6+x5bkVUk+PQnTvvv4ZLCeX6F3lebFAKljCD95tzeUui8V1ScS27xDiF?=
 =?us-ascii?Q?R8j+d1c0visjOfiVcAxJpvq9o/S7YVdObIrkZ0EBOyq32Yf2cHQPveWCBvdd?=
 =?us-ascii?Q?WMxSgfVyuTVk8QZPvR4UdGimcWDLpMa4TG4Uf/SNWfjbDwDuK4FEvNY4E3hk?=
 =?us-ascii?Q?HezOJO75NT6pDdRAWXP9lLOGVXFlkEWQ820pO0K8pDtQksYNqiewt4unwIq5?=
 =?us-ascii?Q?XEEP9FOuJfQQ/gNU/LDMbYuh/VUHHsvQ8b/CzfXsCyGr9D7b/jvWSXl6f6uT?=
 =?us-ascii?Q?UHJJKZpag10Oa5ME6nfUFG2jtB2yiMH1IgYJM63moJ3l5GTFjBMFktY+Cj8c?=
 =?us-ascii?Q?0fyMZnFbLV3IUejsB/G0tx9QS58qdZhpgCyKOHSSaHFDLhmsvzBRObLkRBDv?=
 =?us-ascii?Q?mW2VA4UCV8t5Ww7Y4jYDupEW9EpxsMazjZzwdBDirNHJEnHfwgK+jZ4aFw/4?=
 =?us-ascii?Q?HtD7FOZgIK3UJPDBsKmcN327J26mO/gya0L3YmAKjVb7cZ+Z5SMs/nUD1TWs?=
 =?us-ascii?Q?LYr0H7dJwGoZ3YCu7Qqb7SSJKwaEqHreX9z5mE6fL1Mxr0nAQ3O9OXv/XrmH?=
 =?us-ascii?Q?yLcYeaviA6eYSZj/M8bePBrXBiDbsoSH4w8aml5b02/13eOj2z54dtrzBKe1?=
 =?us-ascii?Q?eQxcE3uM41AoqB4HCeNYbFBDskeHjsB7KhYusCsfr5cl8Di+mDyzNFe/VOiO?=
 =?us-ascii?Q?Kbcaj7k2mO9fhev+Ibz+/2k6QBoHi3uzNhcvSHR9x+PFjA8KAo2iegPumoO/?=
 =?us-ascii?Q?0Cv9mChpnHpVLPk2FbvlMapNBwtSNV0B2fkyJADJ9VWkKaGpR/8XjjrF8cgh?=
 =?us-ascii?Q?4Pz8BNYpPkafVz31FosTvrqtopluWdDi665yCBfOu4/og4NQ4zs6OPEVprdV?=
 =?us-ascii?Q?/YzyjNF8Wl77EuDgK5dKCENk9CjurkPaT/cWjM837Gfq+niAE/6EWqWi81ba?=
 =?us-ascii?Q?z3ca0wmBrp0fmti1tDXm7YsdypM3spq8KfF8VyUALLmyMTsarsL41ts+xcC4?=
 =?us-ascii?Q?v/vv9YeYrwu0apLr2HoeymOB9YP9p+HUlLrFZCjr5XgR7tzcfitoNyTejdH+?=
 =?us-ascii?Q?01Zg/dkXcd0cvGOO/GDNP35wxN10HyO2fK/3RidWkXysWnAoBGfG23nSZ4P+?=
 =?us-ascii?Q?BDmNSJ/+4NcCBhWNoDFSlZU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d285895-75d4-445b-5f96-08d9d6befce3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 18:03:22.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCX3ALypmHhvnQDXeTs6DuvHeKadXgf08cEJtrU4fPBOspgJCSkNkV4pgHcw4Mx172+Fje7oWkClpWI+ONP+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1540
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=809 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130112
X-Proofpoint-GUID: 8mZ1G5AT_4PGwVt_mJz81B9JQlJFMBBz
X-Proofpoint-ORIG-GUID: 8mZ1G5AT_4PGwVt_mJz81B9JQlJFMBBz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_DONTNEED is currently disabled for hugetlb mappings.  This
certainly makes sense in shared file mappings as the pagecache maintains
a reference to the page and it will never be freed.  However, it could
be useful to unmap and free pages in private mappings.

The only thing preventing MADV_DONTNEED (and MADV_FREE) from working on
hugetlb mappings is a check in can_madv_lru_vma().  To allow support for
hugetlb mappings create and use a new routine madvise_dontneed_valid_vma()
that will allow hugetlb mappings.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/madvise.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8c927202bbe6..fc8992f4ae40 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -766,6 +766,11 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 	return 0;
 }
 
+static bool madvise_dontneed_valid_vma(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & VM_HUGETLB) || can_madv_lru_vma(vma);
+}
+
 static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long end,
@@ -774,7 +779,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = vma;
-	if (!can_madv_lru_vma(vma))
+	if (!madvise_dontneed_valid_vma(vma))
 		return -EINVAL;
 
 	if (!userfaultfd_remove(vma, start, end)) {
@@ -796,7 +801,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			return -ENOMEM;
 		}
-		if (!can_madv_lru_vma(vma))
+		if (!madvise_dontneed_valid_vma(vma))
 			return -EINVAL;
 		if (end > vma->vm_end) {
 			/*
-- 
2.34.1

