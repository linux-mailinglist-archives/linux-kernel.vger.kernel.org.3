Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396884A55A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiBADfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:35:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18192 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233146AbiBADfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:35:22 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2112SFcU028123;
        Tue, 1 Feb 2022 03:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=PwL8lJXei2akg7DvjpfE0QXTQc4AWVLQO2/xZuyM3Gc=;
 b=ORPNLdzW4d971h/qmnkiryf8aD21nU9x1AD68oT3H8SS58nBEp3Gw7g6MfC4teczcg0H
 EqIYILjJgMSdgxpsrEOA78KmF2MeZmxIyapYf/TT7JCX3AZ+FFutrllUnJZiogp6byeB
 h7TZKh0XuRVK5VRnRloso1VHPlYtMKAObHhtMDhI6rMSisueUoOYnR3DTmuP1jTaB40x
 mES6QdOmgf4naabTRpq3owlryNPWF2iRulEaP8Pdh5O/P0zJRL6oK0FrlAXKbec/gNLK
 xxRjsKNSdwqTCyq6I06QPsuY7vWWRVU1h65XGw0dsz7mMw6JTpeLv42tURfBjLnwi69B JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fsm63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 03:35:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2113VKca143534;
        Tue, 1 Feb 2022 03:35:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 3dvtpyb15m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 03:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFe8BomzIWmDEqW2KylXzwu3iNNvAsrTeBZ/w9nL9b5ok40b5282zjxEX6MR9Ews2pvxsGCwOeZdZ/yWw6kznHLI5/YSteeIDBKN36IEibSZcEbJI7NpW77q430DESyehh09vuNgmEUs1PnGPS54OqLkUVXl8BOKr+iRHjmYeO295ZWy1gZw4vtJhCuuv45mr+YAPSkTti+vpRHsVN+LpVddsE7efeKPS/cUQ3+fU39WH4jGFCimlr9gsVYVTCsNdS6FcVk4ZDJpToHRIRPos3ZgWH1mWLg3/348aNVHdqVWWkfVRI9KITnZlWJWQ3KQvK44tF83Wp6j42YF/R2sKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwL8lJXei2akg7DvjpfE0QXTQc4AWVLQO2/xZuyM3Gc=;
 b=oVUw3hCZrnrEdoYix0ehHw+tleWJvsCAMT1ofj8OdyeenmtsuqWAx4wvfDuF2arExQ2B9eNcmVm52+9f673gcTXGQAnj1R+tWSglqy2UO6ustWJyKvf6ArQ65h0Vxjx5NUKvXA7EA4k8UHsdUMXdSaKlkBCyKwfgmd/CUXuR5e3pXNfYigI5i6hheWVSc5UysNTGGA7gEWptaqWBi7TXrrwgtdVPVrFVFWsN8bpvhs+pjIvOKNR5e/gzbzTQzWoreltMZ1WbNfch/ZjW/sK4fyj+aY3x54wT4JBj2Qh6WogGQAotrxUJqRKSWPDOpgKZQfb56AzyvNPBaYr4BuTTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwL8lJXei2akg7DvjpfE0QXTQc4AWVLQO2/xZuyM3Gc=;
 b=XFIkA66hGnCmDLlTBQSWfd3l8JYnq1op4MDul6FVKGdAK9ugvcVjO1rd9PjiXhJ2J4WX4Obwt+eh8VlYavQeoTOosu21RKxgiCiFyAHkBvkzdNA5cpzFZxa9/y+Ejol/MfdaVC8KXg1ElkUqcPzU8ANrDgZ7+5Lil5BNLFurmG8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3840.namprd10.prod.outlook.com (2603:10b6:208:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 03:35:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 03:35:10 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mina Almasry <almasrymina@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] selftests/vm: cleanup hugetlb file after mremap test
Date:   Mon, 31 Jan 2022 19:34:59 -0800
Message-Id: <20220201033459.156944-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53a921a3-bf24-4726-b8de-08d9e533d97b
X-MS-TrafficTypeDiagnostic: MN2PR10MB3840:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3840ECDEAB29D72A639210BCE2269@MN2PR10MB3840.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhIWY8HVyjEtgfcjJoUTpePc2zbk0vpgdeEfB53ZeemoqvCAwPjCxnAC9rFfUkSPQ6PSOAU0dKrki28INZ0YC7haXCDtihrhHcOax5B9634+NiD8YJ2Q14lAtkC8RN9fOIJojtI/wdKw3URpEbG2k0yAtERJG8xvxyTynPI0MsVA5Wxoi8F845Rb+4r1lf22kDIjbIGKMqOi045ijlIR5Tpn8SS1hbkhCZlzrZIwR8fhsnQi6KIiqxQdjgxqJKpQevWt1X2ZFUgSOKPuGmgREpe3/y9Gayymau7eVXkUJucb67m6FZNi0ioFWnQoaF3k1Whon3mTvVM7dSCVgFWRiedVAyRcNlhQ7Vg2fXdAH1s9VcwVYlt7oGxQxt3yGx1rEFpVnkosYuDBRcCXSc5zssR82bXOrLZulPOiN6cm6Gmn8u1FuuFDBhLMWJUINaSK00oGk2mNzN9NkOJnJfx6/j6dAN2+RUEpwlpOClE5oieQP6EjWZqRt34wHmUrAK6cp4QRuaMjAlnv/TwQNECgeuGg+bjFiQveVwJtlDGm1yP5WGiLICNJxPPjUDGqhBqV/ktcqGwK8hAUPUjdpBVQ1vmZBw2e6aektfPwOnFw56JXYjJi2EOlKCv0Z0GTmQlpU1Z0g/EB0Tuayd8k8piH3/snYVaSDGILR9LoTTJ09o71xsspgASOCyYBxAkpNSkRrRClZunUn3mpy9NBBFYb3uaTW3SR3ImwdnurV04wX/hX85GvvoQGzCNPUXywNqLJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8936002)(66476007)(38350700002)(6486002)(316002)(86362001)(4326008)(66556008)(8676002)(66946007)(36756003)(6666004)(54906003)(508600001)(2616005)(52116002)(5660300002)(6506007)(186003)(1076003)(26005)(44832011)(107886003)(2906002)(83380400001)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXbv2ABiXXZyx+Z2Rf3GGzm8qWOg7+QNAH/5d8rh6xkmfwbs4V/XyQptp6SP?=
 =?us-ascii?Q?QNXCqKMhV5FAkA/ulKKajKJ50JUtJAjayMgf9t8sJmRJ0kZxpTEwv/YiXI8r?=
 =?us-ascii?Q?IdzOOVfHcWwyD6/tmLqqaJByHXV95AtUckBIxVo+psl+bOyJGRRemRUYYEtr?=
 =?us-ascii?Q?9dk6bWIFVfBtkcDnN9uK0U85w1dgrRLaqKPi88raluMgENuTVCnVv6Q9OWTd?=
 =?us-ascii?Q?dLh9ocq1nT4QKW3IpFapt8EtqGmK0+z1rZamfjfGJcnPC9yOUQE/ABsXskhy?=
 =?us-ascii?Q?KCHq/6LzSUXyS5BB93Jv4XuKHLExcu/s/k99CcOzLPACmxBZH/hp3e9OQApI?=
 =?us-ascii?Q?f7sedQX758c2OzcXnK8EraTVhfKxnDVkwUnsEqtEC+zk+yeXHfTqsHTE9s7h?=
 =?us-ascii?Q?0oP/wj0KsA0T//YBEvx2buxGoxQdvtNPlBT/sTrFxCl+xwbNNhCpILLf8S9g?=
 =?us-ascii?Q?Jhpd2XALcdCvEAvGFEt27r6o5Hml0vomP9mKcs2sa/9wWETrrZ8qiI++586N?=
 =?us-ascii?Q?cQnNl1Hmt8J/5Mvk4FRAraETe97h3Mxj40k7myDnUJ+fWCSQ2GaHNHrh1SZn?=
 =?us-ascii?Q?GrepcZX63hiZ01Iw9kKe5/3PWXycY0dAf6P+ecn9Q7ITWXvZx6Cnv7P4VPT+?=
 =?us-ascii?Q?odqqQ1azsgmah0+fww1ux1fKSTpxt08Cc8O1IVyPszcPkCE9arOu2g91vw+Z?=
 =?us-ascii?Q?03hKQQFF5PVWBu2Bm2QIMG2aOOQ6KCikpPAgcksto2yKXyam+2+xenV2Ym+z?=
 =?us-ascii?Q?6UWQYS1oblGi0hJ915TsMGTevhoRzKDaagpRPCjA2cbVEcUSy0MbOAhhKCKi?=
 =?us-ascii?Q?lgCDuQ8ub8O+oUV08CbmxFMZctdYS9Z8AqwqZux6bcuDBnvp5po+d59xFt27?=
 =?us-ascii?Q?EyHZ9g+VrpVLBOYiHbhP821RPhGfUcMtLEtwk3tnkTay7687l14MqC2RcYyj?=
 =?us-ascii?Q?iysqYD8sgHyxuKaywysgFkoKPeaf9izlW08im62dqK8p9AJF7khXohSHkPwX?=
 =?us-ascii?Q?T5AjV4gij4TWiSkjoXdzu0wdNKRpnMUdBA9/CKaE5jD48wx4o0Lz+VY0RcXJ?=
 =?us-ascii?Q?EPoccTvSlNe2qrV8EImHTF16StSQ5CR+Smveq6zNKJPHorbFXxT8w3+hDREW?=
 =?us-ascii?Q?ERf/jhYRhICT3h6A8rB9GaqB/+0j8utnsubPiktbYHYMeDVYZnAMJnrbPjme?=
 =?us-ascii?Q?zMoEOT8PXmtmIsjH6baosgSpSAZz2pu4QpDOSQNIRO2PXg7+OrP7NAqNBWEG?=
 =?us-ascii?Q?XND1QHboDpy4VaZSNdW9liZWA74rD/B7VBN4JJqgE59O7FBU0nLq4jpXyVsH?=
 =?us-ascii?Q?fg6Z7OdxvZEjFxfjMRIOh7+KvGoG6ClLuMUWNQ5/WV+RV/zP4zBAXzzzN5eQ?=
 =?us-ascii?Q?zYZpvtNMWBE886cQG8z7liyjisDhFHHtw94kaYqf+MBjjULT2n8Q6wncrQRU?=
 =?us-ascii?Q?A7PcUVY+QsXVWbzr85fJo2+GLNVeCUixYUHtscssUMuxdvAvHrUKkZUQ5MFQ?=
 =?us-ascii?Q?fBVa4AnXhw/tC2+Js/3o4eC5ilxpqT8rwVg/Gi+OTcyY+x1YlJELgdnlZMiv?=
 =?us-ascii?Q?6aa/2MSCaEaovILEyIgP+zF4EOXmA4DPynZvtfQjsgnwqirw6zbZKMYXoIU6?=
 =?us-ascii?Q?odM8IzaPe5V/3eoJ/LPB03I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a921a3-bf24-4726-b8de-08d9e533d97b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 03:35:10.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7c2zSQik2/G60hWevkMyNev9P8SCqHgDDiCq3+0rLEZKTTR8Fk+mQxhrwNdQr04602Lvhb7ztBJ16aDmRMccw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3840
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010020
X-Proofpoint-GUID: E6Jtolo-peZeJpWWKgvp3j6vvmWq52H2
X-Proofpoint-ORIG-GUID: E6Jtolo-peZeJpWWKgvp3j6vvmWq52H2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugepage-mremap test will create a file in a hugetlb filesystem.
In a default 'run_vmtests' run, the file will contain all the hugetlb
pages.  After the test, the file remains and there are no free hugetlb
pages for subsequent tests. This causes those hugetlb tests to fail.

Change hugepage-mremap to take the name of the hugetlb file as an
argument.  Unlink the file within the test, and just to be sure remove
the file in the run_vmtests script.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 26 ++++++++++++++------
 tools/testing/selftests/vm/run_vmtests.sh    |  3 ++-
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index 2a7c33631a29..1d689084a54b 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -3,9 +3,10 @@
  * hugepage-mremap:
  *
  * Example of remapping huge page memory in a user application using the
- * mremap system call.  Code assumes a hugetlbfs filesystem is mounted
- * at './huge'.  The amount of memory used by this test is decided by a command
- * line argument in MBs. If missing, the default amount is 10MB.
+ * mremap system call.  The path to a file in a hugetlbfs filesystem must
+ * be passed as the last argument to this test.  The amount of memory used
+ * by this test in MBs can optionally be passed as an argument.  If no memory
+ * amount is passed, the default amount is 10MB.
  *
  * To make sure the test triggers pmd sharing and goes through the 'unshare'
  * path in the mremap code use 1GB (1024) or more.
@@ -25,7 +26,6 @@
 #define DEFAULT_LENGTH_MB 10UL
 #define MB_TO_BYTES(x) (x * 1024 * 1024)
 
-#define FILE_NAME "huge/hugepagefile"
 #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
 #define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
 
@@ -107,17 +107,26 @@ static void register_region_with_uffd(char *addr, size_t len)
 
 int main(int argc, char *argv[])
 {
+	size_t length;
+
+	if (argc != 2 && argc != 3) {
+		printf("Usage: %s [length_in_MB] <hugetlb_file>\n", argv[0]);
+		exit(1);
+	}
+
 	/* Read memory length as the first arg if valid, otherwise fallback to
-	 * the default length. Any additional args are ignored.
+	 * the default length.
 	 */
-	size_t length = argc > 1 ? (size_t)atoi(argv[1]) : 0UL;
+	if (argc == 3)
+		length = argc > 2 ? (size_t)atoi(argv[1]) : 0UL;
 
 	length = length > 0 ? length : DEFAULT_LENGTH_MB;
 	length = MB_TO_BYTES(length);
 
 	int ret = 0;
 
-	int fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
+	/* last arg is the hugetlb file name */
+	int fd = open(argv[argc-1], O_CREAT | O_RDWR, 0755);
 
 	if (fd < 0) {
 		perror("Open failed");
@@ -169,5 +178,8 @@ int main(int argc, char *argv[])
 
 	munmap(addr, length);
 
+	close(fd);
+	unlink(argv[argc-1]);
+
 	return ret;
 }
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e09040a3dc08..e10d50e0b8e8 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -111,13 +111,14 @@ fi
 echo "-----------------------"
 echo "running hugepage-mremap"
 echo "-----------------------"
-./hugepage-mremap 256
+./hugepage-mremap $mnt/huge_mremap
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
 else
 	echo "[PASS]"
 fi
+rm -f $mnt/huge_mremap
 
 echo "------------------------"
 echo "running hugepage-vmemmap"
-- 
2.34.1

