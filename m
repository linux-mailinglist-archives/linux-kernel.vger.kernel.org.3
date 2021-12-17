Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC34792D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhLQR3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:29:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16184 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhLQR3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:29:46 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHGXpB1022569;
        Fri, 17 Dec 2021 17:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gESLgna2LCdL/HoaB06DYh7DhHnFnee3wwYZIkH3id4=;
 b=oCjjjm4GoE9mVbOMPbbtdiv8YPuV9vQbXAI+V8qCpukw6OXqWMhIYGkO5Yj97vBhBOgH
 CxdihtTB/undeVOLmMNlwnro5UGmDtRe2jpc5nv4wO6SB1+/J65bEM0HXkyotgs4P4K/
 YvlYR0CUVviXFQFMtBO/Lds+x4/HPuNk6Baum4dC4nSOLP0AanCFX6FZdqWYdyvj9JLC
 YbE95+BRXwvDvnCbL2J5k0ogmhnG79IrL8MOo2NlEglj2hG/fZcGKlNbMfWuJHqk3cZd
 dj6VZl8Q7mDTpC+O4jsUXGJSMc5+ub0BGxpSVmZVUZ43TZpUnH8qA4mNDNl+L75Z2idQ Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmcp7q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 17:29:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHHAkKq010187;
        Fri, 17 Dec 2021 17:29:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3cvh4426gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 17:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6GYz3h911dKNwLEtFiy6yDXVqdGOtJYMdHXdyaYQnZNWoxepuvzuwv3m696AbwOwx7c6AML3zh6+uGVwikOnoeYVXNBkHaSL0ftXEeULm+iabvr+pt1dI6R+E8G5TXh7/cYBT+BIrTdrOJkKb1ql5cwzXcXyE5YKYK8+kH4f1PVuPEvYdZ+SBSCqreqzMX4YV03gEbBgcn/dcAIHeXDmORh6kR47l4tcKjgKqkrmLpemDb6FZhcskFBfUzQLSKK2HW7UCmiFKAyDG6Ll7tmVicqpaxP7NEB1g0KxzWifAuHplueMyHoAJl9CxIpUfgnNQ5qmVp4UQ0VzX+hC2UMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gESLgna2LCdL/HoaB06DYh7DhHnFnee3wwYZIkH3id4=;
 b=Gf4Fbm7wEBIkiPuEPKSGcX4YFZE2mxWtYnk5/y1CSDeieUGd8+z2HIjEgcs6RUo0t9sIrQMIIqLo2iao37nchwuGh9peDpQH6QkuaX4Vwpm2Zjp1DF2zfAKE5zR00lEeBuCOSLE2xgINomFU62WMwmpoA64IuMnul7zmQbG3e0B5dWwjlWAFo5W8PaCQFeD+skQ4ovtZw7CUorqcKuwxZVdsSK8Z4tPPpfDPK0+6GoWI1HVmH+CljCKZfrnCfGosVXa+YaKyLJ/2+5XYwYkZU8+RTCibY3s3n75CBE+k18PoVfRdwtU4LLIXbQasMfV9OpSeVx/iMyun/SuWKdYc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gESLgna2LCdL/HoaB06DYh7DhHnFnee3wwYZIkH3id4=;
 b=pa1Aq3Zy6chWHcH+b/w87+PuYTyqyTORvyc3DkCcpu8M6B8You2zXAVz8DwvkvnIOfsm/miL9Ioi3Y5YKkB851IfFHguq3CtyykSBjmHrQIalZ/z/w1/mr3ceWpacnvpnNUcqzC4qm09+/mCW3YeexoSGZ2Bj3+0FMj+h2+DdtA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2743.namprd10.prod.outlook.com (2603:10b6:a02:ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 17 Dec
 2021 17:29:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d0a:ae15:7255:722c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d0a:ae15:7255:722c%6]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 17:29:28 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] userfaultfd/selftests: fix hugetlb area allocations
Date:   Fri, 17 Dec 2021 09:29:19 -0800
Message-Id: <20211217172919.7861-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a832f1f9-ba2a-4e54-56d7-08d9c182c749
X-MS-TrafficTypeDiagnostic: BYAPR10MB2743:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB27434AE909CC6C10A5644F72E2789@BYAPR10MB2743.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJTZkVMN6VFAIRtG5hZ3BwKUohvkL3cSGezWz8o2hJfmAv2p1aN4uXvnb/NMYEjHdAflHbyVU0u2yHYyxn08kOvEA+bD3HKGtd1a8kxEd7O9XNiybvHkHcrAZWg0kcwEmh4IocSM5WdTKjBiwEwqVBvuQmYDInSf2v9lojD4C5WyfZlociYdjq9rOzRuj1ktXKCCzzO1OTm2Tk4K5JgTWTGaqVGHg6ujAacRDFzEcoj+BmYyhJ8VquoW7RX5gd+l6oPOlkidm9HRbjEUPIxSDLTYieAmfX2HvQdFJJgsmCLoItU59DzjBGXI0RFjWxjJY7zxfF5LzA2nxuG8/qkkxLLohU+EXpS7RgJmtptePehcehRDFCTDC/XAOVDwWXbLTPTik9pIlXH4GPTjAa79L/rzHM+qWrv2EZ4gDeAFHhomnaAZznhMpkd6ytHsT1OGAOHfx2MG6K+6jwTmh4CV2D3b7hGrUDoaQ0Z1QlDTHIzwNtzd7e2ZTLfHL+DcUsZhMcltLPQQcYzJUvbYTzoGZYDsz+nIyLP1bXiL1p9nwXShWb7PyOLo5CL6ANWPyI/r4oMJyLREWogZxAzHR5kpdYZDlkP84vq2jV7Gt75H/turXGgdLC5Vo5k8C1EBrwUhzJ8dudLLvhCMTJazV3sUT65cCHSEENVrni8JK7ozTMyLvFzdh5TsITq7iCh4oKuJ2mWLbc6zOJjt8cpQ7arqHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(66476007)(86362001)(83380400001)(54906003)(4326008)(66556008)(107886003)(38350700002)(6506007)(6512007)(6486002)(36756003)(1076003)(26005)(186003)(5660300002)(2906002)(8676002)(2616005)(8936002)(316002)(508600001)(52116002)(6666004)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34xlCJjqQ4zP9SyEZ/+SS5XWiIrPjXuDGY2iaarfR7mfClGedaM0fBG6leqN?=
 =?us-ascii?Q?1edmm0nG+V2AmcPRk11u1kkUSPqy5y6l/ldzVUOWvKn9RtWgoo1DY9hiY2H5?=
 =?us-ascii?Q?RHZNd841GYMcKjJkc7xEzimPSet+9oDMop9/o9+NniOxYf3B8GIw1zPWuAal?=
 =?us-ascii?Q?HAW8tGw3JB7ecGe8wbDW9HaTHFVw504tP3kA26/VS5gA7/MGEg55EQY4D6Ea?=
 =?us-ascii?Q?pPkEtKVRvysQ0Red1fdrcpZDupDfwq0NUrpbuUGubgvqelBYRTVC/aS8tzTc?=
 =?us-ascii?Q?t0GNMeFU1pmwSx1NSlfyvGsNzQDxN4f9pzb0iENkyKQPB3LRKqFEXUAn5yMO?=
 =?us-ascii?Q?FKTgLuasiV2Mrz1Vjju6oF6EdR7piSuaeAXFPIlD9XJ1vvgaxSzjy0krS7R1?=
 =?us-ascii?Q?ggBBOvDutWlRvli8rybN3/upS8QoJTk/vL6IQBTqbKjg8iKYMOKa4rB98Tzv?=
 =?us-ascii?Q?Kl8doiF0Luv8nOl/KbPjgHkDdoLpyhhhHplO5+o5TKmX1hwTsvSokStABfT8?=
 =?us-ascii?Q?uSEVY4y80vXQmJM+g4uSIOXgWcKuzqyS7xtpgsk2dtdG5s7KGc9UmYU78Pjf?=
 =?us-ascii?Q?3LDb78MvIZse+m+HXIAiTTAHfbVeRJxGZef6jMXzb/Xc1w9n9Sz+V8dv+DIc?=
 =?us-ascii?Q?okNQhN8XPGQk9vBSvzAyWff615V8/EZPXlarDNLjhFPAU5Ba0RlBwTbFohEx?=
 =?us-ascii?Q?GTdzZo0ICN2gsLKynoJFpTd/A7Xu7BWOz+s4+R9vEWO6CT9326qlw4bB3EcF?=
 =?us-ascii?Q?X/iYf4FZc7cMOPo4V8cnXavLOMRxTUiWv3xpZb8S9lk2/ckQ8sYQYA3OU9dB?=
 =?us-ascii?Q?q5ciGbJMQPg5fnKcLm9vFoTT2oBvP4vpq3VuFidNYJRCuAsDEg/7zTGg8w4m?=
 =?us-ascii?Q?D7hYJrYpywwH53/lELTEgol9AYJWm9yJdEENlqJuU7JE9XCSNTrGAQQOgzvl?=
 =?us-ascii?Q?RC0zjCTnTy9wlDpssCAgOiTvpn35Pal252jQAgONsbwMKzevgpG9ZGmqg+/T?=
 =?us-ascii?Q?noL4YnhdvdmBz3KxFiR9sGo0Nbzh4C5/A/Yk/2c5+EB8cTbyxh4Oa4UR1GJQ?=
 =?us-ascii?Q?wT8ObWMoNrXS742K+TCbAjvlNSUjoMPWwjdun0CZ2Obhnj1CNRztvDGSmlxl?=
 =?us-ascii?Q?h6jB9oy1nSa40saoud3OhXF5N5vhanuIs5VxDqi/ZmGFjJtLWgrhJOvPIjct?=
 =?us-ascii?Q?WUx7mxTi3CrjRWrJaDzLogmgXt1biWGBxXKsjgfnHcgxEO45M4kaPB0PuPs5?=
 =?us-ascii?Q?nlomOoVZztBpk4pTYPzDGOmgoY6fuVOV66X284PEXQA/4QsEGLMws8e5ggPt?=
 =?us-ascii?Q?zIzvy489wEpgS65ozdw4GvKXod4QKYR1K0Lq0Uf5s2oFs7Sj87yqPYzPaAT2?=
 =?us-ascii?Q?Lld519UeXQ4opIJHxyb+rxG6NzZ9k7JLCz/5bzkt1ZX+4KVeR6XRpgcHsh3F?=
 =?us-ascii?Q?KL8rTZObKK3njWTmf19MBq3TJqlVNZ9/ruqsSAQq/mOToheNYdl5V3cH8xlr?=
 =?us-ascii?Q?8ImY45Gj67x6VwPXV2S34KRVlGZbGhS8na+uX4V31T2+CTjNcwYDDsDaPSYz?=
 =?us-ascii?Q?vKYC67qbF57Ep/hhLfJQr3zakfEheDenkkQua+PzDX60io0EGaYiFTduXWTW?=
 =?us-ascii?Q?H6doQq7mklvJhw9e3n+pGno=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a832f1f9-ba2a-4e54-56d7-08d9c182c749
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 17:29:28.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrsoHooQ2z6AZbElw41d0o9+BbjCbNy2mDXYEX1XkC7/Lo3QHLrk+YT9bqTZkobfuNro/+Ahc8uqO++QcZ4iYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2743
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170099
X-Proofpoint-ORIG-GUID: GioqXOPkBL5YOQp2PkqVH-IgHbXB5kbl
X-Proofpoint-GUID: GioqXOPkBL5YOQp2PkqVH-IgHbXB5kbl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, userfaultfd selftest for hugetlb as run from run_vmtests.sh
or any environment where there are 'just enough' hugetlb pages will
always fail with:

testing events (fork, remap, remove):
		ERROR: UFFDIO_COPY error: -12 (errno=12, line=616)

The ENOMEM error code implies there are not enough hugetlb pages.
However, there are free hugetlb pages but they are all reserved.  There
is a basic problem with the way the test allocates hugetlb pages which
has existed since the test was originally written.  Due to the way
'cleanup' was done between different phases of the test, this issue was
masked until recently.  The issue was uncovered by commit 8ba6e8640844
("userfaultfd/selftests: reinitialize test context in each test").

For the hugetlb test, src and dst areas are allocated as PRIVATE mappings
of a hugetlb file.  This means that at mmap time, pages are reserved for
the src and dst areas.  At the start of event testing (and other tests)
the src area is populated which results in allocation of huge pages to
fill the area and consumption of reserves associated with the area.
Then, a child is forked to fault in the dst area.  Note that the dst
area was allocated in the parent and hence the parent owns the reserves
associated with the mapping.  The child has normal access to the dst area,
but can not use the reserves created/owned by the parent.  Thus, if there
are no other huge pages available allocation of a page for the dst by
the child will fail.

Fix by not creating reserves for the dst area.  In this way the child
can use free (non-reserved) pages.

Also, MAP_PRIVATE of a file only makes sense if you are interested in
the contents of the file before making a COW copy.  The test does not do
this.  So, just use MAP_ANONYMOUS | MAP_HUGETLB to create an anonymous
hugetlb mapping.  There is no need to create a hugetlb file in the
non-shared case.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 8a09057d2f22..9354a5e0321c 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -87,7 +87,7 @@ static bool test_uffdio_minor = false;
 
 static bool map_shared;
 static int shm_fd;
-static int huge_fd;
+static int huge_fd = -1;	/* only used for hugetlb_shared test */
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
 static int uffd = -1;
@@ -223,6 +223,9 @@ static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 
 static void hugetlb_release_pages(char *rel_area)
 {
+	if (huge_fd == -1)
+		return;
+
 	if (fallocate(huge_fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 		      rel_area == huge_fd_off0 ? 0 : nr_pages * page_size,
 		      nr_pages * page_size))
@@ -235,16 +238,17 @@ static void hugetlb_allocate_area(void **alloc_area)
 	char **alloc_area_alias;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
-			   MAP_HUGETLB,
-			   huge_fd, *alloc_area == area_src ? 0 :
-			   nr_pages * page_size);
+			   map_shared ? MAP_SHARED :
+			   MAP_PRIVATE | MAP_HUGETLB |
+			   (*alloc_area == area_src ? 0 : MAP_NORESERVE),
+			   huge_fd,
+			   *alloc_area == area_src ? 0 : nr_pages * page_size);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of hugetlbfs file failed");
 
 	if (map_shared) {
 		area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-				  MAP_SHARED | MAP_HUGETLB,
+				  MAP_SHARED,
 				  huge_fd, *alloc_area == area_src ? 0 :
 				  nr_pages * page_size);
 		if (area_alias == MAP_FAILED)
-- 
2.33.1

