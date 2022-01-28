Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4482D4A039B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348788AbiA1W0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:26:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50592 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235706AbiA1W0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:26:40 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SMCtG1026831;
        Fri, 28 Jan 2022 22:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=IyGFvMgZRc4OkC4fwbRQpZz7cSALeDUuu6FeJv83v6k=;
 b=AuHOX36uziXV6Nl1Lqqw+n9b0konr58LueLzB2KQRXYGHrJmY0sdnH2tco64YngCFPeS
 hE773okP7xxqt7L+GjLKH7Zur7XhFMLobE0GCsuu/920gKTxiie4P6PbJ4oXJIN6Xn+a
 /778cThqPv/SjCGB1liyIuVOLcZaX9T3Qg4m049FGMokY0iXtRkal7Hlkz+HtV7ahceQ
 jJ2NjMapYKgKD/iK2gHUCkX3d685V12vgXiXUdkSXHsUom4GsA4pbFVdUnGKs/SpgIgu
 2E5Mwt83Dd62LkdNSNIl/AQmranaA9qxL47JI3ae8EMS2DFcA/QZHC4OM7BdiRnZxY/D QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwub4g2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 22:26:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SMFiJ1102183;
        Fri, 28 Jan 2022 22:26:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3dr7ypma8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 22:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISA5tksYvz7oPcCxHmvqnshdfTycgbJzMgT8XJa++4c0t82H12jI4X1wUlFeGkUf9RgSb+Ubj3cwe6+vykwQVXOaFLmQ7bJg338+dEXgIYf+dfQnsKo+x/2BY8chWLSPvhhBJMMdPeHP6hnA6/e/qanLhorvZh2jP6qkhk3VqWlbCOQF30tixR9wO0y5zO2hGt1Tt/QIwAvX/7P5y2Uj/C2aMTxdLXkMXaMgQ041sErOvK9pJ4Jmosn7CiS0Nm3uMH3anMkOShjByAIDMw4eM/GY9eoqA8d1G+XuuKPjE5r+6FIhFnDs1H+ZqmCfaYSg8mPi/NTLUiJNPpsILJHTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyGFvMgZRc4OkC4fwbRQpZz7cSALeDUuu6FeJv83v6k=;
 b=Md1iLYuZIk/32Af0wD0KT72w8z2Ia418iKdLKWEpwjjkge75M8R2DgLiywm/EFzwdsNhvepRJaOty7ij4wYSNNnJL3lokNRK+CwX4ZUnMFq7eVpwSX+zJjI8wdDUVqhqdK/BbKF1qN8BiRXTiCTJvZs/7yDjHBUjaInAzUGQuJDpyNYxLzOUs0/zRUzzoaStk7BRrGyRGPwfWxe4EyNStnwdXUkau4DE+yV5Idp6QLTPaKdBLH02kIqmqIkC+2iMTLlC4cXclQsVyoQ2QhRcKVpIyIm4kHZ+AYyroGcdlAmqD3lyeR40EcMH58+MiSPiQgyFmHxdVz5jxa9XYTBSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyGFvMgZRc4OkC4fwbRQpZz7cSALeDUuu6FeJv83v6k=;
 b=uUeBvngv1qT8CYxKlYm1rQ9EdFhzlFz3qjiLUkjwNUPlInB6UeXVUO0tKaozrU7RibiU6br54ZQJjRjhvo/KkmOEqyQvuC/Rpvm4l9NFPtF87aAgDLv454sw20vabZMj3D3m1V62gTrn7KEM+LnUIS6lWiL8MjGlE8anWuZ1xpE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2587.namprd10.prod.outlook.com (2603:10b6:5:b1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 22:26:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 22:26:25 +0000
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
Subject: [PATCH 2/3] selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test
Date:   Fri, 28 Jan 2022 14:26:04 -0800
Message-Id: <20220128222605.66828-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128222605.66828-1-mike.kravetz@oracle.com>
References: <20220128222605.66828-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:300:116::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd2e40a-9162-47dc-8689-08d9e2ad3842
X-MS-TrafficTypeDiagnostic: DM6PR10MB2587:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2587D621A416E6B44D001829E2229@DM6PR10MB2587.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+qujmYDJ2V3f0fNvkGlBkHByNbv+vf12UrA10M99No1KzreajG17m31GInDl0wSnTxebczY6gg1XaoKLmGpJWLevmlXk1UjaDKcqpjDfEdEc6RuIIEFCE9g9BWZGj+32lDYCoW6xCgPOIHCdkrq0XBDP+gwUhzJgJV7EAjs8/ImDOCF6SbncOugLjSeQmEVQSqoZhTdG5qMzzGu+QwTjSqZTh7oenuxFWHwPFZ5mhjsJYLNVKJ3bFUsjUTQ7Wxj3z5RKHCqpzj1rJfdElzSC8fLShYI8j8F/MXBj+6i9v29VR7ENpMIGMLXrDDyQLQI0G4FqQ+nTpSqwm8yiYKnlQtSo4YPKfdNm0ja4XncR8Qdw8jtW28H4OWqYKddk2JVcRfRLsTk0aqwxN0nrxUBRyHeffxi7KFWbpZ9OBesq6jHuVPg1R+bInWibB6B+v1caXJ22eOzhcihLmr/1g5cqP9tzYJpTt94Q5fRdyhfO/kv9eZVy1VrEyTZeh/pzcg64VDEm0VXpIt5HqrZel8D4j2bAYPTmAwSvA9Kme4PeBDk/b6inJY7V1EP4J1q5CwRMLTybUEYAvUuIcHkgLaLtnLY8d7O4NltAvkZpO6+KQ0HWoeWe7agtGf/hO+07tShokn7d7ZKSmqEIKvsPSm+5ryaNEs6KCVKgeZ/rv23WYhdrIf4xe1SFjuIZApuZdM3YYloEmzzW5huX0wTW5FFQFv7dDw9xf7JgRVglX/pmWh4X78NDSH31AsGLmIfk3Sv9DTEYzNrIGyYubLehc9kRjvA7foGCguWXuoZUiWmJlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(8676002)(7416002)(66556008)(66476007)(8936002)(36756003)(66946007)(44832011)(38100700002)(38350700002)(54906003)(316002)(4326008)(5660300002)(6506007)(6512007)(6666004)(52116002)(107886003)(2906002)(83380400001)(508600001)(86362001)(966005)(6486002)(2616005)(1076003)(186003)(26005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yM+fsScygWHXP1zDUPrZ83MAV3msiEInyS5CbCdfLLXz426V8v+jSGE59QIQ?=
 =?us-ascii?Q?qNqNmRoFHwaD0MVD8fNiYMJs/qHMmNCM5An9L6ZBt+e+9w3Ri69ANjvpTywc?=
 =?us-ascii?Q?Z8fVJh+gHSm2DBIuM/vxqHSNbKNHuHdHTmUG15zEDNp3jQPC/H3NshgSLOxx?=
 =?us-ascii?Q?UPe6qFh5mFcakanOQVIUvqML6F9Mrdh5z2pQ/j//vnxkPYBu8OvQsWSXJojj?=
 =?us-ascii?Q?59n882llFCesavLc30JyeZXw3qpy2hE7cAlWGTJnlG97m4+q9KWxO5qHsADO?=
 =?us-ascii?Q?wEU+rNpL2GNfJmhhRW3NhZvmdBAaeAVb5r2dBBLtnn0DxhKNL6DVt1chBx3B?=
 =?us-ascii?Q?MsP4RzD0VcOJD6LallZZTG/w7kBOv6Gdg+Yq1qUfUmFH95nP7CW1GsuLIkwi?=
 =?us-ascii?Q?oHN+2EY+iPIYp3lt9Fkdpgx3TNAulBpIykl3fn0OfUBBuEOE40aD4l1gSCeF?=
 =?us-ascii?Q?gZZrCX6p14RJr8GswfMT4ZFLj6105XySrDpBmabVNwxWfrKdW1gHmprn+MG2?=
 =?us-ascii?Q?zqqzDTb+9i2t3tiTetpa6TXW9XEV0wPLmmbdKB+TZTPrppz+BbY1T16497ca?=
 =?us-ascii?Q?T9DeJ3nolpHO5mS2SwyJmcgrpq2le6B1AhM/h+SKpYgxdpW3nq5CAGRCUYQD?=
 =?us-ascii?Q?UAYTavi2iyo2f5CUB9d4WVWkoRzr4ZKAzmJPI3RclfvxOU6WlXfY7Zq8Rt3v?=
 =?us-ascii?Q?kZMYyprjiLvrtC/zkJi5b4jvHIHsdjXoRc2Ap3T24jVWIvYvFjrbT7PkaXnn?=
 =?us-ascii?Q?s189cJdrOeXh/riK0+aXjZ1cYMKM38gdXkSmWgdoA/zkpcPj1ljhRwhtQgWr?=
 =?us-ascii?Q?WmOGJOKFpQ1afix72EEvD8qRrfQtmtmz+V0hQrHWIrx3Xb86joGJCkpzmPP8?=
 =?us-ascii?Q?HpTVtkkptEbn1qpn5wPDXSSqeG1V+TbSDF3fxHcCiUNkuXFxJqaonsIn5+8e?=
 =?us-ascii?Q?dzcqn61tO5eBVHq4GJgKxKsi/pl1At8FhaWt/FRx4N43H1fSS9sUBLPxL0Bc?=
 =?us-ascii?Q?bPu0j1XYmwAuD5WrZIX8abAqPX0HAbNNu/MavBgCPilzz9HC3vT2ZZEjMVWi?=
 =?us-ascii?Q?CXsqgvmen7uXD85JBDSFBX1gT10FQo+xOkYrY8qkOR4bulKmPIhY48myKSGn?=
 =?us-ascii?Q?0IQTcNxWzIOcv8BSUiOXlmmT7JgiHEA/UWlHKB6NjwheZbfm9MK5IPMtrLdt?=
 =?us-ascii?Q?pXCGOwGCRPoMHE5jC8SytYdt6vS/4zJxKLrKnGVXCKT7bCUCFGqrtcfPHR3A?=
 =?us-ascii?Q?YYFVzXo5tZBuTpkWsD3qrf055s2x8cYo7rIQ5c+OhiWUv7HzU7ozzvMiBIcK?=
 =?us-ascii?Q?XdGR9yDBpuvJPFFg2V4pJ3iFpmJj16fPg7x2Z91T3SqGJXIoYWcZTHCU0/kG?=
 =?us-ascii?Q?S5+lF+80CAKvlOZGtpiPrnWSOtvb7KkRPTzk+dZvbm/T80lD6jImV8p6ICXT?=
 =?us-ascii?Q?nKUKar/aMGeuIbCH6EBbtIUqDAX21eiu0hPEq5oZnk1sMsJHusaBJl1BBDzw?=
 =?us-ascii?Q?zrmhvYjcuHa1uD/bK0Q2W6xaXF6Mrj7IW4L32klMrs7sUE9MFqVy2lmqlmaP?=
 =?us-ascii?Q?ZRz4iVIjay53I9Ww3gSE7YmfiQCSsy3ytHagrl3gKO7R8S90FTNj1wvNMFW9?=
 =?us-ascii?Q?Kjgxf4LlOxGaJoDH5bHs7yM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd2e40a-9162-47dc-8689-08d9e2ad3842
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 22:26:25.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QycZUBtA/OQpxIUmXZFPlprHmZw0WG0KvTKV4n3cvG8Z/KGY9C2MtBdMDUsytscKV2k1DonHgGZlw5Pj3dv0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2587
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280125
X-Proofpoint-GUID: K6bUSamWaAFSlX5aQ51vEEVwDXDtqqgB
X-Proofpoint-ORIG-GUID: K6bUSamWaAFSlX5aQ51vEEVwDXDtqqgB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that MADV_DONTNEED support for hugetlb is enabled, add corresponding
tests.  MADV_REMOVE has been enabled for some time, but no tests exist
so add them as well.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugetlb-madvise.c | 401 +++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh    |  12 +
 3 files changed, 414 insertions(+)
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
index 000000000000..31c302528f2c
--- /dev/null
+++ b/tools/testing/selftests/vm/hugetlb-madvise.c
@@ -0,0 +1,401 @@
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
+	 * Test validity of MADV_DONTNEED addr and length arguments
+	 */
+	addr = mmap(NULL, 12 * huge_page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	/* unmap first and last page so we know nothing is mapped there */
+	if (munmap(addr, huge_page_size) ||
+			munmap(addr + 11 * huge_page_size, huge_page_size)) {
+		perror("munmap");
+		exit(1);
+	}
+	addr = addr + huge_page_size;
+
+	write_fault_pages(addr, 10);
+	validate_free_pages(free_hugepages - 10);
+
+	/* addr before mapping should fail */
+	ret = madvise(addr - base_page_size, 10 * huge_page_size,
+		MADV_DONTNEED);
+	if (!ret) {
+		printf("Unexpected success of madvise call with invalid addr line %d\n",
+				__LINE__);
+			exit(1);
+	}
+
+	/* addr + length after mapping should fail */
+	ret = madvise(addr, (10 * huge_page_size) + base_page_size,
+		MADV_DONTNEED);
+	if (!ret) {
+		printf("Unexpected success of madvise call with invalid length line %d\n",
+				__LINE__);
+			exit(1);
+	}
+
+	(void)munmap(addr, 10 * huge_page_size);
+
+	/*
+	 * Test alignment of MADV_DONTNEED addr and length arguments
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
+	/* addr should be aligned down to huge page size */
+	if (madvise(addr + base_page_size,
+			10 * huge_page_size - base_page_size, MADV_DONTNEED)) {
+		perror("madvise");
+		exit(1);
+	}
+
+	/* should free all pages in mapping */
+	validate_free_pages(free_hugepages);
+
+	write_fault_pages(addr, 10);
+	validate_free_pages(free_hugepages - 10);
+
+	/* addr + length should be aligned up to huge page size */
+	if (madvise(addr, (10 * huge_page_size) - base_page_size,
+			MADV_DONTNEED)) {
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
index 75d401741394..e0daf9ff0cbe 100755
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

