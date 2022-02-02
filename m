Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3015A4A69AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiBBBl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:41:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45336 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243694AbiBBBl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:41:27 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120TLxB011400;
        Wed, 2 Feb 2022 01:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cGFZdGzsqdEDpSRfU3HL2M3zyg3g1JTSJxsTlOOf+Jc=;
 b=pXTiB8Pm0wMglpBvLfiMl4JlbkRYx2hqVDpvumbfJ4ELmqrlwOrnQRZPdXUMSbYgjtr+
 sRbdIxfmYEXnY1DtNRbzKyruXGogYa5f9GFFlM9HEXNmU0RLiD2Hzlrlfmja5qdRnmrw
 F2Q7jO4l1Qu0ntGGlRduDivLGWOEr6K4qbrM8f8PK2H72JvAGb3Wbmn7Vqu+y7T/SQ5m
 zmG5/nnQe2RAhvL0gwMo7vE7yVqAOvRry8CqTKDgfh98NSidT2632omMZKVGgBzrC0uX
 EOZLnPIBfoeVghXg6OCPbJ8jv91sE+tm2eKddrhIhybw34ExHvWeiDVBS1x3ZT53DiG3 cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvnx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:41:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2121VP6J145690;
        Wed, 2 Feb 2022 01:41:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3dvtq1hqe4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJm19MaYeVx8Ya08t8EU3ViQKX4a0BZS4DE5iqXZV/xL4NXY+5kuTIUQtoCY5QelGRKFnmScOX98Sm89NN26fAS2Pq51I1x5x9olZQBpxm7lXObzr6oG77Egzha7zvk9ICg3gREEzhwK3YoSKNIVYqs+bmygqENCth841/3ORd2EkQm+ChtksxNRTAYcyQNN6YBSzm2cLN9mX1p4U/pO4/vcC8/D59n1pB1oNgS/EGjcTvPzFQ71cW1fKbaX3WmEWZZFfuO35BYRiPy4xA4DwMFTTIMtySH3XUammJ8J8krjAcM6Ze2jjV0RJBi+aTe2VZGCIJw9WFgFx/BPiyJRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGFZdGzsqdEDpSRfU3HL2M3zyg3g1JTSJxsTlOOf+Jc=;
 b=LW7MhRYddDRHS48Qazh1adEp2tpSfhgOaymc6mE3QW8yRxjt/jq2cCmoVjFQh9Wl55RcIoJhERWGb/y9ZTlJGHvBNoIsCs98aAwBb08d5HYMt0IytSFRViXpwD+yGYKx85w2IRH2cdeNajX1gimzIiovbyN9PzjLPWIdQHsxUZc8QmlJAP2JySvJBLridnianM0h/0xWH0uHIe77NxRyn5dJzmWeZ1lC5r0nIzIFmzEc824cnAjzlKHoIKSCIr972/mKVW7M3EqXdxud9dS11kQDg2X2R27Br25p5F/lB0HKGdeWK2ayDamvGEZ8uQSX/gvq1q1PyO4SNz00YgPLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGFZdGzsqdEDpSRfU3HL2M3zyg3g1JTSJxsTlOOf+Jc=;
 b=M514ZVW5ad1C7KZ+r9SFnkYVUhlIT9fMiX6DcrFhx+zV5kS2pkKeP6N4zpKOZOe0Q/4cY0TOeloiSskyVGSXtPm0Ph7Ug0f8TqUPrzfi1LalVA2HTSuaGE4zhTppbmIIsJMpP42jzEBWx6qLrPzapLr+46XZh2IHLs9R0vvniLI=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM6PR10MB3433.namprd10.prod.outlook.com (2603:10b6:5:61::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 01:41:08 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4%8]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 01:41:08 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 3/3] userfaultfd/selftests: enable huegtlb remap and remove event testing
Date:   Tue,  1 Feb 2022 17:40:34 -0800
Message-Id: <20220202014034.182008-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202014034.182008-1-mike.kravetz@oracle.com>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO2PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:104:1::11) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 620abd26-a53f-49dd-77f7-08d9e5ed15ba
X-MS-TrafficTypeDiagnostic: DM6PR10MB3433:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3433AB2FD1381BE179133D10E2279@DM6PR10MB3433.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3z1tbA/3Ab6LtQBLkQP62rB6cOgBSkj0H/1d2FHWc+Y7elKe8FAP+ROvMAUloR8bJidcu+Yo3hHjP+f1LIk8/FW00iIG+pfgqdpjR8/Nd2dyUZUkw/QfQffw+fUxOBpw0LMnA5UtG5mq62aQeDMpU8ZbuFp6YBrjF8HE69UNZrk4B2XX87XABrS1Nd7pBw5RLg893Yx0ro9Z8COjHNPSiTKwjao7ri/bad1wwb6d954WfunVapE80i+LKhp+703yAgyq8Yk+bkZttPfLJH2Gj3Gd7mtw83RU6ylptwsVcw8BWapQFdSdnl/0xpjwmNNcXRRlRqv5O5Yds7nJRVgNYC6oUEetnRDiTjgzdgNzz18uYGZViSU6UzKpb/Y6K9Wjo5lrGsF9H2lNq+sZWljpS1TXTK5KHsHpM9vSCkO8c3XFCdWQxyaufXmKegYfwGgKTKXh6mTeciIpwy/byn/u0lasa/1yr0D42vf8pXlLseagtLJyUPOXiGKLOoME3q2SEW5udglugIu3tb20PDBgbWBeU5oDximLbQPiZRlSlkIl8UJxdTrud7wCVNYUKCxbbaBHw0YVTdheVPLaiFbvTOIlPCvyfz9qB9ZXHW9yZKYF2XDnptz3hDV1ba1JDQtESSaAAMv6dhJcKMItj2SFLPB10yOVEk8miTN0KBb56a6vBk7NFxDYqhjEAE8yvoZlx9vzr5P5qn0f0pPmYRmvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(7416002)(54906003)(44832011)(5660300002)(86362001)(38100700002)(316002)(4326008)(8936002)(66946007)(66476007)(8676002)(66556008)(6486002)(508600001)(83380400001)(36756003)(52116002)(107886003)(2616005)(1076003)(6512007)(26005)(6666004)(186003)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OY0BkT3VM2UJYWL7YXtfUNeUDiRXztlgiWmZwHGwUPwiN4Mqf8gJhOTvNH8e?=
 =?us-ascii?Q?gy75PjtjLPncqbnykWyYJhcV5ICTUXHy7SsUCZPC5oT1zunoIS7M7g27jeRg?=
 =?us-ascii?Q?mrppHzqCBp+xTN69Dg8i8FGECq8GFgZu3bwZNvnCPYNb8SvYmUEI756gUs6J?=
 =?us-ascii?Q?oSOPklI8hu1DEKc6yQrzBbBfkkN5Zdj7bLQViYcqX86U1dVXpU0XvjWmD3zk?=
 =?us-ascii?Q?4hMzkSTziOP1tHS9B59zuOIZudlSIRYk/09LUUKhrRstUOJ/hO6yhKqbTYOR?=
 =?us-ascii?Q?SEq1PfcH+PlHSRCrGa6QP+9PqWGtp0zzb67hdl6nAdTDVCqYZNJ/AqQhOs3P?=
 =?us-ascii?Q?U4l851VL+26u+uvhlrkIyae9+u6IobKrBHaJHRHiDMupE4jQdHxbtw5Lmman?=
 =?us-ascii?Q?RRR/r1rI3IJpRUsV+MoIXO/kAkdg0s4t18WxPS32EhgGDqCWE0T0+YaYmoIE?=
 =?us-ascii?Q?ThhnxxIHe4czJ7Dt+N2lbKv6x/RrBz+Mfy7WUy6NV7Od9EO0P0NDo27xXbCi?=
 =?us-ascii?Q?qDN/Tk5ISyWhgxOKT3gf8SXR5pNq7CVm+0PrqASiTGwMo0+Ks/BzhQWGSkAA?=
 =?us-ascii?Q?B3LL4H4p0lmjyFPNcbIzuu2CLVG6l3y4Mm/r7A7+oSU455FGeExlkuPXh+tr?=
 =?us-ascii?Q?ybdCUuMY+Rz7jYaB8MeBuZw2I1voNYUnUO7hK9/JMopVUm/PaHZE6Jxgo16C?=
 =?us-ascii?Q?UaaXryWlU5jd13hFDhKMddtiJKsFhgO+Fjqcj8IVLsZ3pVFak4DcXXTwgRfW?=
 =?us-ascii?Q?x1Fi92B6CNAwU2/49pQwoW5axq5WxQrOlW/hlg2OGoqmnLrAWYjyqWzDUHLf?=
 =?us-ascii?Q?fSruTg5i8vY3GutkoSNVV4RUe5LPaBQmaNmu1y67Me+lM/GjDY9ornMJ/mWK?=
 =?us-ascii?Q?GfhdWBshBo8bLTwJf9JPQQ6TfkimzWBA6I+WdO/XspfWqxCmWh92awG+Pqgi?=
 =?us-ascii?Q?bBI2YuloZ3iWkEJns+igXuGjeMcodOP67gFITCEtjTZQ7tilkPn2kT8eSrAG?=
 =?us-ascii?Q?SJBSVaIthYutuuXHMnPbwC5Sc6nZE5CmL1SFRBUI6I+dQ10JCBJIz0+3dw1P?=
 =?us-ascii?Q?NNVU1TyuWERKywU05etjFnRmjkwWv1hvzp6zq+DAlknLmdmcLzkrVK6+6xY/?=
 =?us-ascii?Q?n93uKGYgyvGq0kjx75yCbVrROuJU3XCe5vXnCkgTBCpXRQXaJwL+pycpqiRL?=
 =?us-ascii?Q?HJN2wVXcnXNV9J52w+3nPsvXwH9lzcOFY9tl0Dxxt7rg+flcEYQUpWcZt+tK?=
 =?us-ascii?Q?mFaCAT61rP7TnGQJmvvcp2oXhqzQ28zdbzss5XKFtvi/j7EFBYuIm/KfQrx/?=
 =?us-ascii?Q?3at8/MbEoYbpqUEDkQv+Ug0+oiJnZRsw3vl0wfKt2oVN5iHFz+TcGD4DmlrQ?=
 =?us-ascii?Q?f+7XL0sbYwEerZI2TNXhsKRl9b2mTVbQXTlfWxQmbS1gIpSouh+3C0NRCI56?=
 =?us-ascii?Q?H3Krqpvf494dQmbZs5kT8xLk/shhp0Nwio9H1k7ZXzOSG6azGwoHUIDVhktK?=
 =?us-ascii?Q?yhWbCcAfPSu8JK/pOg+EUKTJv7Y095ZC9xM63pYy783Jc435Zu6QwNkdlCs8?=
 =?us-ascii?Q?CAhSZnDfWVjXufqNLkMIQLZsZVMxS4ThlIfIlWhx+Hy41Fd1aal5kDg9djwU?=
 =?us-ascii?Q?E2tfQUPu0qp7/pbLQY3QH4s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620abd26-a53f-49dd-77f7-08d9e5ed15ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 01:41:08.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDtNlXJK2b8A54DNifFlkMlb03RT6PN4wjlKUtq92oEIe7x249uXyB4qMKFS9o823eSpSj2f5MYWxTlhU0ljgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3433
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020004
X-Proofpoint-GUID: HRrO9eVvk-ZWJymK3uhB09aSQj6ZImU_
X-Proofpoint-ORIG-GUID: HRrO9eVvk-ZWJymK3uhB09aSQj6ZImU_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MADV_DONTNEED support added to hugetlb mappings, mremap testing
can also be enabled for hugetlb.

Modify the tests to use madvise MADV_DONTNEED and MADV_REMOVE instead of
fallocate hole puch for releasing hugetlb pages.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh |  3 +-
 tools/testing/selftests/vm/userfaultfd.c  | 69 ++++++++++++-----------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index ff901ee66838..7178d6fa8c92 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -207,14 +207,13 @@ echo "running userfaultfd_hugetlb"
 echo "---------------------------"
 # Test requires source and destination huge pages.  Size of source
 # (half_ufd_size_MB) is passed as argument to test.
-./userfaultfd hugetlb $half_ufd_size_MB 32 $mnt/ufd_test_file
+./userfaultfd hugetlb $half_ufd_size_MB 32
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
 else
 	echo "[PASS]"
 fi
-rm -f $mnt/ufd_test_file
 
 echo "-------------------------"
 echo "running userfaultfd_shmem"
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index d2480ab93037..c18beebc0dd6 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -88,7 +88,6 @@ static bool test_uffdio_minor = false;
 static bool map_shared;
 static int shm_fd;
 static int huge_fd;
-static char *huge_fd_off0;
 static unsigned long long *count_verify;
 static int uffd = -1;
 static int uffd_flags, finished, *pipefd;
@@ -127,9 +126,9 @@ const char *examples =
     "./userfaultfd anon 100 99999\n\n"
     "# Run share memory test on 1GiB region with 99 bounces:\n"
     "./userfaultfd shmem 1000 99\n\n"
-    "# Run hugetlb memory test on 256MiB region with 50 bounces (using /dev/hugepages/hugefile):\n"
-    "./userfaultfd hugetlb 256 50 /dev/hugepages/hugefile\n\n"
-    "# Run the same hugetlb test but using shmem:\n"
+    "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
+    "./userfaultfd hugetlb 256 50\n\n"
+    "# Run the same hugetlb test but using shared file:\n"
     "./userfaultfd hugetlb_shared 256 50 /dev/hugepages/hugefile\n\n"
     "# 10MiB-~6GiB 999 bounces anonymous test, "
     "continue forever unless an error triggers\n"
@@ -226,10 +225,13 @@ static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 
 static void hugetlb_release_pages(char *rel_area)
 {
-	if (fallocate(huge_fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-		      rel_area == huge_fd_off0 ? 0 : nr_pages * page_size,
-		      nr_pages * page_size))
-		err("fallocate() failed");
+	if (!map_shared) {
+		if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
+			err("madvise(MADV_DONTNEED) failed");
+	} else {
+		if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
+			err("madvise(MADV_REMOVE) failed");
+	}
 }
 
 static void hugetlb_allocate_area(void **alloc_area)
@@ -237,26 +239,37 @@ static void hugetlb_allocate_area(void **alloc_area)
 	void *area_alias = NULL;
 	char **alloc_area_alias;
 
-	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
-			   MAP_HUGETLB |
-			   (*alloc_area == area_src ? 0 : MAP_NORESERVE),
-			   huge_fd, *alloc_area == area_src ? 0 :
-			   nr_pages * page_size);
+	if (!map_shared)
+		*alloc_area = mmap(NULL,
+			nr_pages * page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB |
+				(*alloc_area == area_src ? 0 : MAP_NORESERVE),
+			-1,
+			0);
+	else
+		*alloc_area = mmap(NULL,
+			nr_pages * page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED |
+				(*alloc_area == area_src ? 0 : MAP_NORESERVE),
+			huge_fd,
+			*alloc_area == area_src ? 0 : nr_pages * page_size);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of hugetlbfs file failed");
 
 	if (map_shared) {
-		area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-				  MAP_SHARED | MAP_HUGETLB,
-				  huge_fd, *alloc_area == area_src ? 0 :
-				  nr_pages * page_size);
+		area_alias = mmap(NULL,
+			nr_pages * page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED,
+			huge_fd,
+			*alloc_area == area_src ? 0 : nr_pages * page_size);
 		if (area_alias == MAP_FAILED)
 			err("mmap of hugetlb file alias failed");
 	}
 
 	if (*alloc_area == area_src) {
-		huge_fd_off0 = *alloc_area;
 		alloc_area_alias = &area_src_alias;
 	} else {
 		alloc_area_alias = &area_dst_alias;
@@ -269,12 +282,7 @@ static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset
 {
 	if (!map_shared)
 		return;
-	/*
-	 * We can't zap just the pagetable with hugetlbfs because
-	 * MADV_DONTEED won't work. So exercise -EEXIST on a alias
-	 * mapping where the pagetables are not established initially,
-	 * this way we'll exercise the -EEXEC at the fs level.
-	 */
+
 	*start = (unsigned long) area_dst_alias + offset;
 }
 
@@ -427,7 +435,6 @@ static void uffd_test_ctx_clear(void)
 		uffd = -1;
 	}
 
-	huge_fd_off0 = NULL;
 	munmap_area((void **)&area_src);
 	munmap_area((void **)&area_src_alias);
 	munmap_area((void **)&area_dst);
@@ -925,10 +932,7 @@ static int faulting_process(int signal_test)
 	struct sigaction act;
 	unsigned long signalled = 0;
 
-	if (test_type != TEST_HUGETLB)
-		split_nr_pages = (nr_pages + 1) / 2;
-	else
-		split_nr_pages = nr_pages;
+	split_nr_pages = (nr_pages + 1) / 2;
 
 	if (signal_test) {
 		sigbuf = &jbuf;
@@ -985,9 +989,6 @@ static int faulting_process(int signal_test)
 	if (signal_test)
 		return signalled != split_nr_pages;
 
-	if (test_type == TEST_HUGETLB)
-		return 0;
-
 	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
 			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
 	if (area_dst == MAP_FAILED)
@@ -1670,7 +1671,7 @@ int main(int argc, char **argv)
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_HUGETLB) {
+	if (test_type == TEST_HUGETLB && map_shared) {
 		if (argc < 5)
 			usage();
 		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
-- 
2.34.1

