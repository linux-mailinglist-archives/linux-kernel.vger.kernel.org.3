Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7900C4A69AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiBBBlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:41:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11066 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243588AbiBBBl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:41:28 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120ULKM005139;
        Wed, 2 Feb 2022 01:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=h0p0PZ3Y/RzfSf5WE5jDyGoaG1Y9Rm5gpFiIyoOQhHQ=;
 b=CqDU8vk34cVf/c/xgui3bLGnbxXfnD6Qz+LhITJ3cYvpj0Q2IphSHFPJVo/sSXvkW+vi
 GQxkUddCMyFUbHOpHOsHV/RlThGzC8+8Mh8jagECRzOjr1TEpVngGE8dwef1ibprho82
 mvfGEUWkHfWyYcH6+qGh2VTvJqBYcdO8Poqddns9T3jmbsfZCanBHrUJZCoN5+DSdRno
 1mkcdrJxMsvMVEBk1mfpmmkxBCdBcbdxXEHljm+/HQiBDM2A24S+G7JiDbB4Sbi2ap3c
 VTBB6gOxS3QPWVxSPhyRS9QqmEG7Qgba8GXR4NOCksl27H8Y6PSIbp9tnjlKKPZ/J9Vz Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4mne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:41:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2121VP6I145690;
        Wed, 2 Feb 2022 01:41:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3dvtq1hqe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+MPl8bP2R5PLzKZW0IFZlBPKSy8Jx6sL/8bp+VvxbNA0Mnae1GisdL14eiNunKAM5sbXA6EsTj/W1e2FPut/4ckAAVRtjVZ5tTy3CYcivdilKTRRjF4n7/xDLgaGbRJSPMhOndbcZYOwsbxVEf8HOw8YWRzEpYjEKb+Zytgph61OXWZ3hyzmoEI1PY9tBvkwq2y7DtMcu8rw6PzC4ZgWzxwPwjM3cVmFTNuJYo5GMUNoU7iMuQ4pNKeIkrREX6JojeF608e6GPeITpmt8bMCPWjeS6Iwh6JD0jskZOjVwbUNlx/U3fhAnlqc1/pNkAXYhzHThvMAP9736hd6wuQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0p0PZ3Y/RzfSf5WE5jDyGoaG1Y9Rm5gpFiIyoOQhHQ=;
 b=j3/FOGtG8RiUvCiIIVvbUAazPoLRkN+BCHnH9kz2E2J9vCqtvH9lxUQqiqVuwPJHWyVTFV3HpTMgg89ZZOW8jLguZyJqbnAajuhTRuXCr0H/lQSXWRyFeeroQY+vOKPl6exguYt43qd7ZiaiJ2mx9WaQDVzRqVJVfwwAmIUnXamQwDr2K5SGDUax6RPUSEo910pME882RKS52SDH2WSRpg12WTVFmUyloSLzvxfASv/oU9XzeYpwNGYkAHtYaD3+0MSLLv0q5povhnWVEwuIW/3+rPEv3DAnEE9QpJLu/QzFR+OCpYsrigDAYkY4cIP7zoA3KONYPL5rH37rayE+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0p0PZ3Y/RzfSf5WE5jDyGoaG1Y9Rm5gpFiIyoOQhHQ=;
 b=mI69zKy3tFPF6UXpF74Kyj/3yQH6Zp38WmpaApxpm6VP/IGu9DX/atPDtwR9TMHSQ8KzFuBMQ4yb37YOqOl8C7K0J2JPEXJ7JqQsmd6iHOO84unAJFd0en0tozf3pqc802rijWGMCyS1kqUBZ9x7cC/B4EzmWkFgmKQk2l9OPbI=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM6PR10MB3433.namprd10.prod.outlook.com (2603:10b6:5:61::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 01:41:06 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4%8]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 01:41:06 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 2/3] selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test
Date:   Tue,  1 Feb 2022 17:40:33 -0800
Message-Id: <20220202014034.182008-3-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 385ce3a5-4c02-482f-6493-08d9e5ed1465
X-MS-TrafficTypeDiagnostic: DM6PR10MB3433:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB34332662B9D9C7CE34D62755E2279@DM6PR10MB3433.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCiMJsgSJvUgJe62V91Y2FgfVqLZ+JmapV+NFI8WkylSSftcvtrCRvYW4o9jqwtF0/HARQ9qtreM3h17YnNSzWeB8icEN4VmBZI12uMGdZsI2LV0qqoxzOgc8clsckZga/YjB6RSLV6Znb2sv8E2Ht3Y51MBMKCcz7H8Mk5s+ciHl3vkN0t/EgQopOZOMQ4TosP+/Mu7ZE9VHr63684c2MtxV5BypM5EhUUT4iN1l3DUhdxOKkOYDw/L4N1YNb6zk7LBe7jhgsw8C00NI4ECykfSB215QV2uB97umZGOgtT3E0++o8rhmrbC4zcMQgb5h2mFmNw7zlp9wLwjF9Axx6mk/gUYHWozpWhbEhbMVG4PLHXnHko+MaWKL59SBjsPbYOna0nmX4QA5udvk611yxOb0hZHnNyKqGCB+gHXBuX5svKBJU4zt3QYi1WZh4AjAXIuuswdPk1NZtYCy4dQCedoli+sFjVlxnUkZnPJNPJOkH40udq92l5+lHIOer8HkEWSG9i/A3rpIRgLd3ofl3ILVVHwEu4fEx3O1rN8WtUDCwG86BFEcYooaFxUhhCEIZ6DV+pma/WAN2EVH3EyrYacKteZ3RFMQR2Ael1OYS+Rciqc6svf30AkUcoMN/7p/FOVhzTAN6hlYjMe2beoHlSl08nsq9rO7nqzhsbjMxSBChm41OGLXe5PR59cTkZFHfqlfsilOk5PqwaQVMFMOPFppJHHuV4fnKAe9M2mCdFgqzwXA5b7ZGoFmS3DKnGz2DXr33D0uKvD0H19s0M+tz2UZ6iTsJpX2KJTlm0oPPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(7416002)(30864003)(54906003)(44832011)(5660300002)(86362001)(38100700002)(316002)(4326008)(8936002)(66946007)(66476007)(8676002)(66556008)(6486002)(508600001)(83380400001)(36756003)(52116002)(2616005)(1076003)(6512007)(26005)(966005)(6666004)(186003)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cB+MA3I6WsrfRBqlgLwXglh9rddEDo/XK5n1NxjcndOG0tXYbT1NU0xmyHTY?=
 =?us-ascii?Q?5h9AtHhB6dGVq0vUeVDJFw/DmOiXY/rP+SqCzfAdg+A766p6XCYN8vkL8Jod?=
 =?us-ascii?Q?O+LiSKIHmZ+qp4gIRPgcJ7jdk16VH0XFMAQZblk3yFSn0p+2ik5UrXNf+HrQ?=
 =?us-ascii?Q?SPPCiotVz9nAy3jIwZSU2D2RYTJWOVABZRM0UJ1nqCp8Mg8cchTwrGRBKEXh?=
 =?us-ascii?Q?ehB4pFSV9RWyLoeygK39bwy9aFT2kDXiCrpsLX9GRcKZ7zJ6AR13hmEh0fx7?=
 =?us-ascii?Q?qt+JkR3gceHtiiLMuZpy1qbum2HhSj48pPCd3StuNyTAmMK3EenhBXCpI7o2?=
 =?us-ascii?Q?waWkgHb31SHsZwok/iN5+0/iA/9uhjTcDBsT4pTbFvWd7Eek5yWvRHes8Zba?=
 =?us-ascii?Q?KDN0ESyocLKpRGWnbJUZVVDPJLdjus+kdqMSg5im0PrFHg2XCs8xFhQ2HR5k?=
 =?us-ascii?Q?bktMdbJ8QDM5DgaJZJPYp+9b0DZiHVgk62jrPZNhwa2C6NnMXHwgYNRdreVC?=
 =?us-ascii?Q?ow1VNPNGXQrVo5TBiiSPq9gW4pH8EMihpz31Du7b4AIgYouZxOt5rZXkNitO?=
 =?us-ascii?Q?inh5IVzmBlSKxMLQTslSWq3Aq6ynXsdrTH8li6qldzJcgryv1MNYQ2F65vjj?=
 =?us-ascii?Q?YBBdGSgeDmdAfnzn9FHYDNO6GeEdCy3yB15mzGxW0NiwWbuJ2IaPrR5CpD3q?=
 =?us-ascii?Q?c1i6WHwjv5aHuHIn/CmKpTfdeqZujIusWloCqCaxmzTLOF6Ars5SfvzJFhk+?=
 =?us-ascii?Q?dImShF+N0PkWXKyiSA5wDp2a313n6vkYiMJMT0UEodcd1T92ry8Ajq8qynZA?=
 =?us-ascii?Q?eQkWv5mCWW8U5joWwaBoEa+NMj+Omv3FjGmhl1dc7eJ5tspz2ieBJv3aKqC5?=
 =?us-ascii?Q?ZIUVMZ310r4lJU66KBBUje40erM2OMIJlcbbg0qSWJT9Sq0Nhoz8slOyd/yx?=
 =?us-ascii?Q?ntZdIfJm25tzT138vv0iyMWcbPcOM5dXy5oXlNrguPuvowkIvb4g2YsmcmD3?=
 =?us-ascii?Q?yZw2vj9vjebAFITFGiRjRzILq53O32zlfkNdSCOwwnuOw8PvIvLkBQHeZLyQ?=
 =?us-ascii?Q?2UrMHDn4LJa13zoqP28fwbgmCZz2Wr5s8jIEu5K6lDKeFsdwmS3lLt6Hn1jE?=
 =?us-ascii?Q?DpQNy5fwSmneuucyy6IP0g1L5qmBfVK+b9jjEDiYYCB2VDR7t3LAkfhudaQL?=
 =?us-ascii?Q?X0mPyJ6qmsoYO+AY4PJLAZGMlEIYCi2vzcAnSnoCPb90URWXZaBWZs8LVZmo?=
 =?us-ascii?Q?ySMhsY2nePt9aPz1ZgSlptBLEKjBbur+gFomLPgA5uCvz2NllU18Lyo6yoVp?=
 =?us-ascii?Q?KUyMoHYJDKN7RwJaNiq1XI7+Oycan44sVpuviRhaUGl+R7kxx3/wzEqzhdKq?=
 =?us-ascii?Q?zZMqjo0sduN0QGrucuVKjJxqdWR+crDpATwtsa9FZNksMkn1e3YzrseIvLly?=
 =?us-ascii?Q?9Vr1rx5jmOIKrlX0RMIXA5pTaM42b8IvDC+LKuwgkGSzVa7Vc4kPnxmiXrWO?=
 =?us-ascii?Q?+KpLxVMlh5arMgiWZtv+4zVWIAXvHltNiM0A0Iu4uSpI4LXYFzqSYF2MQfu8?=
 =?us-ascii?Q?CXiFTBCLPxKeoTY756BNSlRY6bTpZgaqYXHb+RDTR0ffaCQmuHQmO9Pg1pCV?=
 =?us-ascii?Q?S21cYD5burSCZOuMbkqvBkY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385ce3a5-4c02-482f-6493-08d9e5ed1465
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 01:41:06.3240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtBhbYPeifVIxjD53za37O39J1szLARlXXg2Y60w03OKU/a0193bydAEwgSo3xJEukBD4RTMQ0s8m/pMjYm6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3433
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020004
X-Proofpoint-GUID: BYvuFr8kuWpegXby86yDn2Dsgn-m0pVb
X-Proofpoint-ORIG-GUID: BYvuFr8kuWpegXby86yDn2Dsgn-m0pVb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that MADV_DONTNEED support for hugetlb is enabled, add corresponding
tests.  MADV_REMOVE has been enabled for some time, but no tests exist
so add them as well.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/vm/.gitignore        |   1 +
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugetlb-madvise.c | 413 +++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh    |  12 +
 4 files changed, 427 insertions(+)
 create mode 100644 tools/testing/selftests/vm/hugetlb-madvise.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 3b5faec3c04f..d7507f3c7c76 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -3,6 +3,7 @@ hugepage-mmap
 hugepage-mremap
 hugepage-shm
 hugepage-vmemmap
+hugetlb-madvise
 khugepaged
 map_hugetlb
 map_populate
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 96714d2d49dc..5e43f072f5b7 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -28,6 +28,7 @@ LDLIBS = -lrt -lpthread
 TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
+TEST_GEN_FILES += hugetlb-madvise
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
new file mode 100644
index 000000000000..77af0ffff01d
--- /dev/null
+++ b/tools/testing/selftests/vm/hugetlb-madvise.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hugepage-madvise:
+ *
+ * Basic functional testing of madvise MADV_DONTNEED and MADV_REMOVE
+ * on hugetlb mappings.
+ *
+ * Before running this test, make sure the administrator has pre-allocated
+ * at least MIN_FREE_PAGES hugetlb pages and they are free.  In addition,
+ * the test takes an argument that is the path to a file in a hugetlbfs
+ * filesystem.  Therefore, a hugetlbfs filesystem must be mounted on some
+ * directory.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#define __USE_GNU
+#include <fcntl.h>
+
+#define USAGE	"USAGE: %s <hugepagefile_name>\n"
+#define MIN_FREE_PAGES	20
+#define NR_HUGE_PAGES	10	/* common map/allocation value */
+
+#define validate_free_pages(exp_free)					\
+	do {								\
+		int fhp = get_free_hugepages();				\
+		if (fhp != (exp_free)) {				\
+			printf("Unexpected number of free huge "	\
+				"pages line %d\n", __LINE__);		\
+			exit(1);					\
+		}							\
+	} while (0)
+
+unsigned long huge_page_size;
+unsigned long base_page_size;
+
+/*
+ * default_huge_page_size copied from mlock2-tests.c
+ */
+unsigned long default_huge_page_size(void)
+{
+	unsigned long hps = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return 0;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
+			hps <<= 10;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	return hps;
+}
+
+unsigned long get_free_hugepages(void)
+{
+	unsigned long fhp = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return fhp;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "HugePages_Free:      %lu", &fhp) == 1)
+			break;
+	}
+
+	free(line);
+	fclose(f);
+	return fhp;
+}
+
+void write_fault_pages(void *addr, unsigned long nr_pages)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++)
+		*((unsigned long *)(addr + (i * huge_page_size))) = i;
+}
+
+void read_fault_pages(void *addr, unsigned long nr_pages)
+{
+	unsigned long i, tmp;
+
+	for (i = 0; i < nr_pages; i++)
+		tmp += *((unsigned long *)(addr + (i * huge_page_size)));
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long free_hugepages;
+	void *addr, *addr2;
+	int fd;
+	int ret;
+
+	if (argc != 2) {
+		printf(USAGE, argv[0]);
+		exit(1);
+	}
+
+	huge_page_size = default_huge_page_size();
+	if (!huge_page_size) {
+		printf("Unable to determine huge page size, exiting!\n");
+		exit(1);
+	}
+	base_page_size = sysconf(_SC_PAGE_SIZE);
+	if (!huge_page_size) {
+		printf("Unable to determine base page size, exiting!\n");
+		exit(1);
+	}
+
+	free_hugepages = get_free_hugepages();
+	if (free_hugepages < MIN_FREE_PAGES) {
+		printf("Not enough free huge pages to test, exiting!\n");
+		exit(1);
+	}
+
+	fd = open(argv[1], O_CREAT | O_RDWR, 0755);
+	if (fd < 0) {
+		perror("Open failed");
+		exit(1);
+	}
+
+	/*
+	 * Test validity of MADV_DONTNEED addr and length arguments.  mmap
+	 * size is NR_HUGE_PAGES + 2.  One page at the beginning and end of
+	 * the mapping will be unmapped so we KNOW there is nothing mapped
+	 * there.
+	 */
+	addr = mmap(NULL, (NR_HUGE_PAGES + 2) * huge_page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	if (munmap(addr, huge_page_size) ||
+			munmap(addr + (NR_HUGE_PAGES + 1) * huge_page_size,
+				huge_page_size)) {
+		perror("munmap");
+		exit(1);
+	}
+	addr = addr + huge_page_size;
+
+	write_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* addr before mapping should fail */
+	ret = madvise(addr - base_page_size, NR_HUGE_PAGES * huge_page_size,
+		MADV_DONTNEED);
+	if (!ret) {
+		printf("Unexpected success of madvise call with invalid addr line %d\n",
+				__LINE__);
+			exit(1);
+	}
+
+	/* addr + length after mapping should fail */
+	ret = madvise(addr, (NR_HUGE_PAGES * huge_page_size) + base_page_size,
+		MADV_DONTNEED);
+	if (!ret) {
+		printf("Unexpected success of madvise call with invalid length line %d\n",
+				__LINE__);
+			exit(1);
+	}
+
+	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
+
+	/*
+	 * Test alignment of MADV_DONTNEED addr and length arguments
+	 */
+	addr = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	write_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* addr should be aligned down to huge page size */
+	if (madvise(addr + base_page_size,
+			NR_HUGE_PAGES * huge_page_size - base_page_size,
+			MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+
+	/* should free all pages in mapping */
+	validate_free_pages(free_hugepages);
+
+	write_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* addr + length should be aligned up to huge page size */
+	if (madvise(addr, (NR_HUGE_PAGES * huge_page_size) - base_page_size,
+			MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+
+	/* should free all pages in mapping */
+	validate_free_pages(free_hugepages);
+
+	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
+
+	/*
+	 * Test MADV_DONTNEED on anonymous private mapping
+	 */
+	addr = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	write_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+
+	/* should free all pages in mapping */
+	validate_free_pages(free_hugepages);
+
+	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
+
+	/*
+	 * Test MADV_DONTNEED on private mapping of hugetlb file
+	 */
+	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size)) {
+		perror("fallocate");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	addr = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE, fd, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* read should not consume any pages */
+	read_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* madvise should not free any pages */
+	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* writes should allocate private pages */
+	write_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - (2 * NR_HUGE_PAGES));
+
+	/* madvise should free private pages */
+	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* writes should allocate private pages */
+	write_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - (2 * NR_HUGE_PAGES));
+
+	/*
+	 * The fallocate below certainly should free the pages associated
+	 * with the file.  However, pages in the private mapping are also
+	 * freed.  This is not the 'correct' behavior, but is expected
+	 * because this is how it has worked since the initial hugetlb
+	 * implementation.
+	 */
+	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+					0, NR_HUGE_PAGES * huge_page_size)) {
+		perror("fallocate");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages);
+
+	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
+
+	/*
+	 * Test MADV_DONTNEED on shared mapping of hugetlb file
+	 */
+	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size)) {
+		perror("fallocate");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	addr = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* write should not consume any pages */
+	write_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* madvise should not free any pages */
+	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/*
+	 * Test MADV_REMOVE on shared mapping of hugetlb file
+	 *
+	 * madvise is same as hole punch and should free all pages.
+	 */
+	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_REMOVE)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages);
+	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
+
+	/*
+	 * Test MADV_REMOVE on shared and private mapping of hugetlb file
+	 */
+	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size)) {
+		perror("fallocate");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	addr = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* shared write should not consume any additional pages */
+	write_fault_pages(addr, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	addr2 = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE, fd, 0);
+	if (addr2 == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* private read should not consume any pages */
+	read_fault_pages(addr2, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* private write should consume additional pages */
+	write_fault_pages(addr2, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - (2 * NR_HUGE_PAGES));
+
+	/* madvise of shared mapping should not free any pages */
+	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - (2 * NR_HUGE_PAGES));
+
+	/* madvise of private mapping should free private pages */
+	if (madvise(addr2, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
+
+	/* private write should consume additional pages again */
+	write_fault_pages(addr2, NR_HUGE_PAGES);
+	validate_free_pages(free_hugepages - (2 * NR_HUGE_PAGES));
+
+	/*
+	 * madvise should free both file and private pages although this is
+	 * not correct.  private pages should not be freed, but this is
+	 * expected.  See comment associated with FALLOC_FL_PUNCH_HOLE call.
+	 */
+	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_REMOVE)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages);
+
+	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
+	(void)munmap(addr2, NR_HUGE_PAGES * huge_page_size);
+
+	close(fd);
+	unlink(argv[1]);
+	return 0;
+}
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e09040a3dc08..ff901ee66838 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -130,6 +130,18 @@ else
 	echo "[PASS]"
 fi
 
+echo "-----------------------"
+echo "running hugetlb-madvise"
+echo "-----------------------"
+./hugetlb-madvise $mnt/madvise-test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+rm -f $mnt/madvise-test
+
 echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
 echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
 echo "      hugetlb regression testing."
-- 
2.34.1

