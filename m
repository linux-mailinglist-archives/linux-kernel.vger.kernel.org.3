Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA54248DD66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiAMSDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:03:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22798 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237394AbiAMSDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:03:43 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DHoWEx001477;
        Thu, 13 Jan 2022 18:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YQ3Su0di5h0cNeLw+/WUi8BsF5y++YGdc+VsNgBESgo=;
 b=wXDMhuZaHTaoH6UtaibFAJEiT6cHBGeHO1MnGOFGcZ3pwgf1z49tvbrxH0kfkHXfcwV7
 LGLfLp+Emb7Hz/2a8SPgbxj4HicBMVCz6ulR1V3F30GiOSZKnegMLW270lJ6r7YPG3k9
 PAmU+pR0jGKkmmvdhEzZBS1nL9DwobfPRxzv8ndvZsjrvc+AGtLEBLbwA83iFY43Ks5u
 QwPfIj3LgCdcCQzU5qbQr4GlhnnDiWPqGcEjMW1UWLu/9nmt+sRq7fYP60mgAjXeg/dn
 iIboic9a8hy1xyd5UGi0fZagIU7d7hZZ8xWRoa/xCEAtDkaRZWb7VBjpqlNw9Yib8oN8 gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djkwj90hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:03:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DI27Rk000810;
        Thu, 13 Jan 2022 18:03:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 3df2e86pqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYtpfFZRDSSU5HlUYysMGsNOpKr/yj0DFPF7Xo4C6ZH8XDsByKkEj/TIZjdCm1AAAgK6MspYuccIrYkcQRhrU2JU2i/2tlaXugRhLuEfhqLNWBxWdz4a0Avy2mvOmnd8YZ1izCxid+oKwGBe4h5DkCsGCdHUm4id2xRTkD9Ek4Xkvq8pCm5kX2u0ezjKRWohxCtMgKdvsnLctsIJEjo16/2J9dRbdR4Aw8HLFoOn4q+MQzUki4zxTkIawktZMxmauVA/oJjBcX5/rloY1k1yXrlsuGPOfzDgLQaEd8nGp3UJCHUM8yONCHZU90p546uzqdmnwJ1rdkH6jCujGH6aqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ3Su0di5h0cNeLw+/WUi8BsF5y++YGdc+VsNgBESgo=;
 b=FwHL4dICbOF5wWgsAUeBR3g4aRcEgN33txwsJxA7Esp4HqBeVlMHBwQ7y1aRRQca1Qq/JSjGGGUyHVbVXdLWipNpiJH1rtoxYsWQYBazUuhUJ8P0tDCD5kvXG5ROrJG/qFKVYGGgurRQmcw10hT+izxPHvc88+GvMqAw4xFT2b4+SruOXqoecsU/lQKseeIab53cNLNkvZnQ3xEejGqbFMBjMdU69VbkKUiwWDbaPIL8Cs1KwZW1eHvi6PMw/8ROzXRm93ySWgGvkVpgrT57p7Cuuq8+ovFTdWeCUGJ3pVn3CaPYhnAFe2xfknRpVoXsy+DlONTYcwLhg+6KnuOQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ3Su0di5h0cNeLw+/WUi8BsF5y++YGdc+VsNgBESgo=;
 b=BdIvRUCVJvUUnjtP63gUsaD6ArCDaDjZCIaP0DGzSd+cgkeENVq/Mh+P3VCpirWsXeDj2rTzX33jzqqKYFFjrkGiPUkXgVI21GplJBJvwDXWYyOYqOXXUI/zuZfHJ0MgAn9Mtmnc/3fAG54knrCNBYIrF/ifHDknMjgFl0m+N0U=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 18:03:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 18:03:25 +0000
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
Subject: [RFC PATCH 2/3] selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test
Date:   Thu, 13 Jan 2022 10:03:07 -0800
Message-Id: <20220113180308.15610-3-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: fcd06160-aa68-4129-f369-08d9d6befe46
X-MS-TrafficTypeDiagnostic: BLAPR10MB4865:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48657B9D97270F7599061030E2539@BLAPR10MB4865.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xWHcLZ4FwNQhVAs+Em+XPMrFSw4ho/BZgh2bGp1JckHF5JfGmNwaqxUwW8/5eml/G0HMVklSUFBQTpjjesAXo4FP3A95vvFTdIGOYZ1qYS6U9roZDut4QAi8oGiNnSSkXtgB9k2+tgGnynz4zyXJJtuguiMHPbuVTMkxM4vGIfK7SthljBDG0fwbjp/yXj3CF6SdxELiUmr/5sVdXCgtceP145xeCKlE+A4D+K+BaWoLw+cfvAP7LAxG6rSsma0dIKbuNysr0ZAtii58ARALr0vOpQN8749TCyxcJDqsEEH8F8d0ktJ4nMt+RsEEmqogxlJSryCi3rXxB3fyNCJTvPzKwwYY/vQxO5+r2mNdyNNBHLEnu2gKtJuo1Jg5FLIuUcmu1uylPjgVoE4693wMaNxkOa1sL3wZ39YFnzMoAP+nRvZG56zFVvwg3IzvsL/Fumk4cnVcz/rx6b1Bgssvh5zN2Eb+JZE7VwDvfXC1QgriIkWgSXcOUVhDHWQSSypb+bDFvYYC/ZwQnLWmHigWrzK2ndYgPNxSFmXt1pYERxQqIw/XL5lfDOllQiPO+hY0q3eFX8KDQyFCulM8gD64izyAQT9hbumAgTsjuGHVNxbrH8Cex/g8/22Zeit8QKbGrPXkIWc6vQ9hGwwZ8+D85HvMOLVdkZueQPMAwli9bNWmuOQlzwYEna86QNAelmgiQ/8/d62hlt4kqIFNgCCwDAhMDMeOFfpSSsWiU2IPiNuuF1LmWsxohRo24XnYiUd0TtqacIq4/ZtUeA4qxPg/sFa2I9HAldRv9GCBcBGnZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(966005)(6506007)(36756003)(44832011)(2906002)(1076003)(6486002)(2616005)(107886003)(508600001)(26005)(83380400001)(7416002)(5660300002)(66476007)(52116002)(186003)(66946007)(8936002)(38350700002)(6512007)(316002)(6666004)(38100700002)(66556008)(54906003)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knK9X1Y94Nxwk2bnz3V7wakl6FAc1nkR3ZbfS38EIbqghZXJMWNoPFoeDvpB?=
 =?us-ascii?Q?Y626vrJnQ/p96hyd3N533tAx/yv6NiH1xoA0eSYMTpUC9xjjNBfudxafEg0W?=
 =?us-ascii?Q?ETETFi4BmgkyupN6hr700nmJI0H1+qiHabTQC5Db+r3Ltw4nAfQh273WVfz3?=
 =?us-ascii?Q?SOg+9E0mKm+UTksldmyOHTNY5JWqSfipjdD6JWJ2Y+CIF+GseGzBHYo+m+iC?=
 =?us-ascii?Q?wTYpqN7Ka9+TJTe1052qTytgxysul0kQRxmg+/h8l+L1Fatd2D7eoPSuMnij?=
 =?us-ascii?Q?UPHgZVzY2lYkSY0uObxhj34wiZIoHkQO9QDuD6f+WKGrLv+uaI0bHfxoSdgx?=
 =?us-ascii?Q?W8EYF0iUrp5ZTTt3WOWPlgCn9ZOBcdoXhMYReEmzeyORkxZ++och8X7pTykf?=
 =?us-ascii?Q?+O9j2X6LSd51TiSzhpPAbY6AYAHBF40bgTcTPyJLFoNNzogW1bDFioH2YqlL?=
 =?us-ascii?Q?J9xbGekbs2Ay73NO6bk7R2oft4ZDmGBT7BTovyyJk1jSwtWkmV/ZRCTVpz5/?=
 =?us-ascii?Q?SkY5UlqU6uvA8hM36lebLsB08jhpu+iYCVM9d611fpHZSPrO7jDQB13Kib4a?=
 =?us-ascii?Q?X15FwSMkXUBAfIG6hZUYFZ9w1OdFRt9Txh6+b7itjh4hhvzMhcoU2Uyjk7Jm?=
 =?us-ascii?Q?dtBj8VXMOAp8WTp4fx7EnE384xWvSGyrCn9FykJQnIP4TN27exF/PdYW1NrH?=
 =?us-ascii?Q?g73D6I5VKKN4KEkUEVuPuOwJYfSUGjoK6IwoEWhKmxpSNoUVqtg43uywBHYN?=
 =?us-ascii?Q?MFdOGu1BxiS2ArsfxRTohhBKPgwn1crN1h1xTAN7Rge3cza6bL14sJ6pvG4V?=
 =?us-ascii?Q?rNdvkiqAqjZNm58GPVxFvsXyigcivpQ4mffY1tHTOca6oPNK9vvpmGkhm1io?=
 =?us-ascii?Q?N/zns2xpkW2jgCM51xwK4iXfzkjnzs8sDbe8et1M/tfc3aP0M45GJxp6JFn3?=
 =?us-ascii?Q?e9gjRrQYXeZh3cRbLnN1furdIL/lJNq9SkkZJNI/Stj50iaC+vi00X05A61Q?=
 =?us-ascii?Q?YYse26D7/j/pLgV59o+wVPhfPc4BuPwIeC8OiGzuwULFv3AFt1QtTpA5UHLh?=
 =?us-ascii?Q?Uf9umPTMHU/tDurUuvFaaUUwue1WkigH7OyApbUAUmtYS4ZgdXEukbhDMGjy?=
 =?us-ascii?Q?l9rJoWr8kVupvxlPrKNLsT/Wcz/4vbCcIYIiRhk4VWSBrVZAEX06wE0UjIpD?=
 =?us-ascii?Q?UKZkuxTZCRCsGPlvqS8OdDJ361ICSALbD3pi5bRXy/2g6RuCdAVg0eLCgL2I?=
 =?us-ascii?Q?L2wDkfnSqyWSqemKMYf41uOtYwAu3dE+Rq8Aq+GTPjoZVHY3Tbb9r/ev+DnS?=
 =?us-ascii?Q?BWMKQ9Baf7M8gbNvSvYdb/nJJuD0z70gl6UXMA73zzoKx9YpWM5uGb9oRuM5?=
 =?us-ascii?Q?JaHSj80wWlrz/Wck+UDSAHbkhplOsLQkmzdXN+wRRXI2Hs7IIPMPjJOAE60r?=
 =?us-ascii?Q?LUpB/1WfhGTMt7HUnCGofksYGhs2n0/qe6Mlskx9Jf4JYGVxbjjJO2nb0g6e?=
 =?us-ascii?Q?Falk3ejHOE2Uwc13ZNf5Mc5jPge1iP7j+K1HRb9nBxr5w5jwprcAuU8TgMrC?=
 =?us-ascii?Q?7eIhCw+PDqXLjI2e7+kpCOIo52lj4wYaZ6wgtVRoffToB3scnayfrr8vPaf1?=
 =?us-ascii?Q?YV6Snwb7SxVMfYeAIFClzjo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd06160-aa68-4129-f369-08d9d6befe46
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 18:03:25.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hV/J4nLf9tzuX7P2TzSnPJe4WzWVXubzmiZqmsX4bjoqMOQao7rLWyg4mxzsIMOgtphd4tiV9gkhfNEIDTLlSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130112
X-Proofpoint-ORIG-GUID: PtHBPcDrbntrrTSgbnyH4bD9ezXTWk1e
X-Proofpoint-GUID: PtHBPcDrbntrrTSgbnyH4bD9ezXTWk1e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that MADV_DONTNEED support for hugetlb is enabled, add corresponding
tests.  MADV_REMOVE has been enabled for some time, but no tests exist
so add them as well.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugetlb-madvise.c | 315 +++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh    |  12 +
 3 files changed, 328 insertions(+)
 create mode 100644 tools/testing/selftests/vm/hugetlb-madvise.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 1607322a112c..f60cf43bbf61 100644
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
index 000000000000..de6f2088ad40
--- /dev/null
+++ b/tools/testing/selftests/vm/hugetlb-madvise.c
@@ -0,0 +1,315 @@
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
+	 * Test MADV_DONTNEED on anonymous private mapping
+	 */
+	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	write_fault_pages(addr, 10);
+	validate_free_pages(free_hugepages - 10);
+
+	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+
+	/* should free all pages in mapping */
+	validate_free_pages(free_hugepages);
+
+	(void)munmap(addr, 10 * huge_page_size);
+
+	/*
+	 * Test MADV_DONTNEED on private mapping of hugetlb file
+	 */
+	if (fallocate(fd, 0, 0, 10 * huge_page_size)) {
+		perror("fallocate");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - 10);
+
+	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE, fd, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* read should not consume any pages */
+	read_fault_pages(addr, 10);
+	validate_free_pages(free_hugepages - 10);
+
+	/* madvise should not free any pages */
+	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - 10);
+
+	/* writes should allocate private pages */
+	write_fault_pages(addr, 10);
+	validate_free_pages(free_hugepages - 20);
+
+	/* madvise should free private pages */
+	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - 10);
+
+	/* writes should allocate private pages */
+	write_fault_pages(addr, 10);
+	validate_free_pages(free_hugepages - 20);
+
+	/*
+	 * The fallocate below certainly should free the pages associated
+	 * with the file.  However, pages in the private mapping are also
+	 * freed.  This is not the 'correct' behavior, but is expected
+	 * because this is how it has worked since the initial hugetlb
+	 * implementation.
+	 */
+	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+						0, 10 * huge_page_size)) {
+		perror("fallocate");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages);
+
+	(void)munmap(addr, 10 * huge_page_size);
+
+	/*
+	 * Test MADV_DONTNEED on shared mapping of hugetlb file
+	 */
+	if (fallocate(fd, 0, 0, 10 * huge_page_size)) {
+		perror("fallocate");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - 10);
+
+	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* write should not consume any pages */
+	write_fault_pages(addr, 10);
+	validate_free_pages(free_hugepages - 10);
+
+	/* madvise should not free any pages */
+	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - 10);
+
+	/*
+	 * Test MADV_REMOVE on shared mapping of hugetlb file
+	 *
+	 * madvise is same as hole punch and should free all pages.
+	 */
+	if (madvise(addr, 10 * huge_page_size, MADV_REMOVE)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages);
+	(void)munmap(addr, 10 * huge_page_size);
+
+	/*
+	 * Test MADV_REMOVE on shared and private mapping of hugetlb file
+	 */
+	if (fallocate(fd, 0, 0, 10 * huge_page_size)) {
+		perror("fallocate");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - 10);
+
+	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* shared write should not consume any additional pages */
+	write_fault_pages(addr, 10);
+	validate_free_pages(free_hugepages - 10);
+
+	addr2 = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE, fd, 0);
+	if (addr2 == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* private read should not consume any pages */
+	read_fault_pages(addr2, 10);
+	validate_free_pages(free_hugepages - 10);
+
+	/* private write should consume additional pages */
+	write_fault_pages(addr2, 10);
+	validate_free_pages(free_hugepages - 20);
+
+	/* madvise of shared mapping should not free any pages */
+	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - 20);
+
+	/* madvise of private mapping should free private pages */
+	if (madvise(addr2, 10 * huge_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages - 10);
+
+	/* private write should consume additional pages again */
+	write_fault_pages(addr2, 10);
+	validate_free_pages(free_hugepages - 20);
+
+	/*
+	 * madvise should free both file and private pages although this is
+	 * not correct.  private pages should not be freed, but this is
+	 * expected.  See comment associated with FALLOC_FL_PUNCH_HOLE call.
+	 */
+	if (madvise(addr, 10 * huge_page_size, MADV_REMOVE)) {
+		perror("madvise");
+		exit(1);
+	}
+	validate_free_pages(free_hugepages);
+
+	(void)munmap(addr, 10 * huge_page_size);
+	(void)munmap(addr2, 10 * huge_page_size);
+
+	close(fd);
+	unlink(argv[1]);
+	return 0;
+}
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index a24d30af3094..f46988c5db35 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -119,6 +119,18 @@ else
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

