Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F248DD67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiAMSDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:03:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22246 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237391AbiAMSDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:03:43 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DHoEGl012528;
        Thu, 13 Jan 2022 18:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mxp/9bxZKhjLHpZmvaOK5kFmw0ZCKbnZu0Fj7vRGUgU=;
 b=W5tOI6tqrQmlWzka5Xrd+aSImCraaePYIbYXGDEhGEU57regF/Sq0t4+NbcAdHMOh4Cw
 0cpylPfyoSDtYE12GzSxC1XWxQG6Uc6lYmOjMFw/rs2ODEPRJeTxUzMpeqL37zcBdrkv
 Bz4xB2JtOeC6mTXobdSAvjpEV43zRbgDvuAFZV7/4d3OgRzgj9/CrTlaC5HPYkrvpY3R
 XNCuFpaT+DiPRQ5sF2sKYg+/gNBREr3ye4IPBVpGfdkSwrKtkFA8ZCq7bjoRAw/anSr6
 k79pUNtvS+SGAT5VB1dgh3qpgUi3h4F14YxUtSrIh8e1KxP6ORqlZaKh6sOHlwva3ihv 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djmhw0yus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:03:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DI27Rl000810;
        Thu, 13 Jan 2022 18:03:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 3df2e86pqy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:03:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEu8uZ42nng9YkBxlgEp0Rbl13eIlG6dROFHgo3apvRmj1vK8H8feycelBg/TGre5c6LdiS/YpY5EIdTXpzvIMVIM9kTy3tM0GSKVRVwIX0UpEBn+aQSo5Lyiuzlw9z9J88f3YohNFyFbHmmdBcsvVAMEPyXLi6KULjuZ4iAoPXpaKpIhbdgf6VwqbIbQu8F2AMI/0r3KWFBtH1wRIEYL7pkOrQPi4BmmWBt4z5QSaZXype7zUX6jDL15fa2PUQUbFNqcrPL0gGwUC7II1l2ToGw3Q9rHtH1PxelrIYl5ISVi0OxV7pXCf2U5kjjw/hXj5J02DYCYpbmMGq+WKXriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxp/9bxZKhjLHpZmvaOK5kFmw0ZCKbnZu0Fj7vRGUgU=;
 b=jsQ1vmBJm8cjnkj69nLxoCbIjt9kNqB65oUGTL0ZKa2UpzufE14QQE8RMdaboQJs6jJHfLYL0d54JLi+WFysogWSedQ2+xJcb57BeEi4Fz07xcvX3kmV6a18LKYvgaINQ76nG2+kdsqf6iujTeZVtbLQkR+8sRLz+TQ9fb48hhGjqu9HsYBLyIF1c0bVTXpake/ieIt8yAzDYe1PR/OE06trSUR1szLNTROh1dEwVVLTMVXO6o3JdryI6CqL1n7B3JviETiLeuMRkSOfJ+XqvntptideZlg6snWhsOtO37n7eYLDxmwB46MRUSO1f/4fLvHmDrroAUqUNrn05ffvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxp/9bxZKhjLHpZmvaOK5kFmw0ZCKbnZu0Fj7vRGUgU=;
 b=yjdhNuwr780FVsh6M8Hy+pt0YK9YeGyLm5V2g8kdHxnbrK/mr2VIr0st5fUYMGqs8EbQhl3dW+Sd3WKqeQpxvFs1RbtiUfOWLuglDLCiNDaiOHwMX+hqDE4vd+ZkvDIk5IrTR6oooEWfv8ZJBweJBdJSxqJBKAgrIC/zTV/LePE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 18:03:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 18:03:27 +0000
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
Subject: [RFC PATCH 3/3] userfaultfd/selftests: enable huegtlb remap and remove event testing
Date:   Thu, 13 Jan 2022 10:03:08 -0800
Message-Id: <20220113180308.15610-4-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 886a9459-0061-4e45-d4d5-08d9d6beff7c
X-MS-TrafficTypeDiagnostic: BLAPR10MB4865:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48659D1D194066BADA02CCD8E2539@BLAPR10MB4865.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZWAVXz74xuE7XuIjfS6obLbseRUG4Cri4wsDKOwSS4lysOTDc+sXXMypOOwP9Pqkj+MEYmgn+oi/BIVooH6cyE4xv/wG0/ptWTClcN2Zz2s7fdkSrqA59zHHN5S17OQ5ori+hUD5kHwq/yPRYCIxYsPQAkTi2MAaRtzXB0vYyrQ/xGCzd3k0Z6D4A05sbvgnuG28uGr/MilUf2PyJw4V2ooNevZr2nVHgT4LBTWMbstUSNzhw8Ej8myfeq8liH4Mpa/mqrnNrAcIpRKoMpZJa/qOYUq2AsyGTqNgbS4SpzP1l2XGCXzMyRa2XyDVqoflnvNy7JBXBRFZUbrwYziZYTP+EnwU7JKVpYeczw1zt23CY6CiaLjYfz0rouINz2KwtZlY92fxRnXuD162USCQF9nvxKANqus7PH73i1RBejt2CRKS/xMUP/G77WG6wQtLn8IpP/b6zLApjc9FtITpSxkcMkTjUh7PUUxHaITJkERsMtA10TSNFyjKHgD7LDdXawgunrALiO04NzBBN1fHWy6BXxRl68lfYsKYPsfN0ZHSzEwISJmp3EiAObAFUAoRf/w2qFyvexYxd5fHbjO6oVs43mJziQ/O95Sgm9Nt3SzwlFaP897AyqywRMJ0w4sb2+o9HID8e7w9h2t+5IdH+9flFQWPiLslBB2NQPo9yrdoK5jACCvcc+ZjQd24XRHaXscLisj1J8oSnRPuhUtVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(6506007)(36756003)(44832011)(2906002)(1076003)(6486002)(2616005)(107886003)(508600001)(26005)(83380400001)(7416002)(5660300002)(66476007)(52116002)(186003)(66946007)(8936002)(38350700002)(6512007)(316002)(6666004)(38100700002)(66556008)(54906003)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lR53dJkamQz0wtTyI4S5g0hv0nEpsIMRPskqflsMLXhO9opdeTeO4ySbdhby?=
 =?us-ascii?Q?Z1g9h5iGz9VYnf35s8FVlnjbv6FCmJnS1+kWDwkV7MZ7sGYC8+ehp3P67Yiy?=
 =?us-ascii?Q?tHNaEZVRZhA9UBVpquSCazYVIblX8BbGRUskpZCPIn+TvfUSoAQIPmaFtwSX?=
 =?us-ascii?Q?pTCbsHFqDaBSg6om7N95ihi7msTMSivXdM6a6UInT5jhP63cf0cmRI5z6DQR?=
 =?us-ascii?Q?Av0pc/T2G/nciFHhf4g2ju7Px49Fq/uZLp3VJNLYKHER0NABZQEmfq1lAu9b?=
 =?us-ascii?Q?w9DDZ1FLp1CssSuGSHmKt/4n2VmX6jp/yF3dPEPi7wZcOEsn2G7WS+UVeUVU?=
 =?us-ascii?Q?5zGkUBYKIBrzIinBU46u9ni7qDIfXlooRFS8P4tmSvuLNApKmMBZzcidGs7e?=
 =?us-ascii?Q?wJ95s9b3hy2eE+gQJNf2zkgNx27c1jlqjGvkDguS8t4teB1oMpHrYT7ePtOQ?=
 =?us-ascii?Q?Zemfxsq4Cw7tKryRa794xj8I1odDw9fy070FT6TL8Z79W4LKYBaLA4CbWoX+?=
 =?us-ascii?Q?T5g2QFUMGm4Ouo+wVLWuior0wM4B57O3WgyMTKwmKP4b+Sw88pCubQD24Ooa?=
 =?us-ascii?Q?rhcWkHhkUNBr02ysATdKexkssABn8yQVf/0rVRIpE0kb2Gnx+Q5SDhuJoKUL?=
 =?us-ascii?Q?hwzQpVa9OYaYm6iyL2jZSx9ruRKqA6lbrSBiK+MrD0jbY6tHNP0sCqPSrRIJ?=
 =?us-ascii?Q?mZFPquFQrDuUd6QnH/ZrlPTrx7sH768QmFoGd53ANtf2x0gcu348Y0FIOttn?=
 =?us-ascii?Q?iJAtw/Kup9MtLF4Le3tFoBgyV4obZL4TdIU2Srutfk7GTw1A6a26mX9QrhQu?=
 =?us-ascii?Q?Ebf2okquBObBtbwutucEsIAs2c8woa35+bolsiGUDv7uA2OiTKU9Cakv9dam?=
 =?us-ascii?Q?MyYtiCpbDNykmgC/bIOqW7spZ1Jp5/Z8GsiYaKA0jD8ycJMOy5o8gOnzjf2P?=
 =?us-ascii?Q?NiDpFYpUEGtwQzP6Q/00QM9R205oLY/Taa9b0A8I2kxokny910HanIwTrGyY?=
 =?us-ascii?Q?eFX64MBp4SNPgq8siRPIciwfr/1XnhsZrO7IPS1mMEH+3t8SBlTCsznlnAsg?=
 =?us-ascii?Q?PgRrqJR443Y2lEDaegCus3Z7nu7M5dSxCSMgUJfYcnFoykP7JguCId6Gmojn?=
 =?us-ascii?Q?VS0/7sfXEBlclIRQcY9iRL42wUrj46Jk19qztLoVe3BMaRRNpEDNtBBkqC3/?=
 =?us-ascii?Q?JrkvF5VnrhOXKsldt4EQh/oTonvUnHcJSkDWcfi4urGf6VIv9Pb7jnQzwP7+?=
 =?us-ascii?Q?asLXFh+7VtzhUaTwqTCVkwcsn5aQzb7UpqB204gFcBW5Vtpy3HdB4ovcaA0M?=
 =?us-ascii?Q?CwjJ+qstV/0JR+Fnm/UOVPwwnuoWjxxTmnrjww5HZIy7DUzGqsAR3eruEaYD?=
 =?us-ascii?Q?WXNCNL/JYAPrhcn0Qo5aeCI15l/CHORaBH2grMT0kYX+FXrvrV4DwQ7LMaC4?=
 =?us-ascii?Q?amBdK5eO2uhslzxEnsfSnTTijZuOn3CbSgRQhObFbddKqtLDD5PZh2XIlyIt?=
 =?us-ascii?Q?YjjmRly5h7abrv9LyKbBx003NucMiXoDLlSlrvBT3OEEfUz25OKWu5zTaqk0?=
 =?us-ascii?Q?YQl16V7GAYWx5qm0UxE1qoDhPTQWkMeBXJXDOPXuf6uRyxinVxbb4UY/c5pu?=
 =?us-ascii?Q?LBVe/FMySsX20euCNGHhvW4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886a9459-0061-4e45-d4d5-08d9d6beff7c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 18:03:27.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9cYHh0fmzZkvmsWRqMJtV14xcQ55NKvgP0URmHi3VzIb5x+cKb9D4IiIDaNWJl56/GRDL60WdkjrYbHvwPH2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130112
X-Proofpoint-ORIG-GUID: WAhHB0GkEBvnPReH659UkpcjuLgUU9OB
X-Proofpoint-GUID: WAhHB0GkEBvnPReH659UkpcjuLgUU9OB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MADV_DONTNEED support added to hugetlb mappings, mremap testing
can also be enabled for hugetlb.

Modify the tests to use madvise MADV_DONTNEED and MADV_REMOVE instead of
fallocate hole puch for releasing hugetlb pages.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 67 ++++++++++++------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 0b543a9a42b2..226f385158df 100644
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
@@ -124,9 +123,9 @@ const char *examples =
     "./userfaultfd anon 100 99999\n\n"
     "# Run share memory test on 1GiB region with 99 bounces:\n"
     "./userfaultfd shmem 1000 99\n\n"
-    "# Run hugetlb memory test on 256MiB region with 50 bounces (using /dev/hugepages/hugefile):\n"
+    "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
     "./userfaultfd hugetlb 256 50 /dev/hugepages/hugefile\n\n"
-    "# Run the same hugetlb test but using shmem:\n"
+    "# Run the same hugetlb test but using shared file:\n"
     "./userfaultfd hugetlb_shared 256 50 /dev/hugepages/hugefile\n\n"
     "# 10MiB-~6GiB 999 bounces anonymous test, "
     "continue forever unless an error triggers\n"
@@ -223,10 +222,13 @@ static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 
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
@@ -234,26 +236,37 @@ static void hugetlb_allocate_area(void **alloc_area)
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
@@ -266,12 +279,7 @@ static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset
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
 
@@ -424,7 +432,6 @@ static void uffd_test_ctx_clear(void)
 		uffd = -1;
 	}
 
-	huge_fd_off0 = NULL;
 	munmap_area((void **)&area_src);
 	munmap_area((void **)&area_src_alias);
 	munmap_area((void **)&area_dst);
@@ -919,10 +926,7 @@ static int faulting_process(int signal_test)
 	struct sigaction act;
 	unsigned long signalled = 0;
 
-	if (test_type != TEST_HUGETLB)
-		split_nr_pages = (nr_pages + 1) / 2;
-	else
-		split_nr_pages = nr_pages;
+	split_nr_pages = (nr_pages + 1) / 2;
 
 	if (signal_test) {
 		sigbuf = &jbuf;
@@ -979,9 +983,6 @@ static int faulting_process(int signal_test)
 	if (signal_test)
 		return signalled != split_nr_pages;
 
-	if (test_type == TEST_HUGETLB)
-		return 0;
-
 	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
 			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
 	if (area_dst == MAP_FAILED)
@@ -1669,7 +1670,7 @@ int main(int argc, char **argv)
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_HUGETLB) {
+	if (test_type == TEST_HUGETLB && map_shared) {
 		if (argc < 5)
 			usage();
 		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
-- 
2.34.1

