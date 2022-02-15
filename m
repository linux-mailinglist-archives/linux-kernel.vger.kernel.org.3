Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557004B5F00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiBOAYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:24:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiBOAYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:24:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B51409DA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:24:24 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ELiUfH015640;
        Tue, 15 Feb 2022 00:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=iAdSXEr3/fKvsA1MmwjjfMm1+K7ln7ewfbUUVyWmSzs=;
 b=cWvOtXf56Nxvskcqp091q33ejv91lw1PmH2P2seFpt2J+vSMBTYSpuB+2VUfCgYgGb1t
 81dCOBKNThrswCLyL6zNIS3lTkQ/q7MaQ2FUU3DykYXv6guFRZn9JnAskeqlh2r8Ja9z
 wF2+zpAcHp4bcud2SY3NZb/RCRKtVw7EpHWU9lHmVDbrlFoUoFd/OXm7jcg4gWMHEzRT
 oc6wGqohuew0hdcFjVMfGmeylE2d4SHLrawGYhh1urzY1FRFk2JnV/VVtdXonu7kudJ9
 WJDjSUOcoGl9wZdwZdppIOIAo2FTxSCvYs6pi8HPFGjU55P3W6XOrwmVJcuXBWqaSkIx FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g1675m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 00:24:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F0G2si188425;
        Tue, 15 Feb 2022 00:24:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 3e6qkxer1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 00:24:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2m23/xJcuGoJL6GCTsZrSI/DzpO0TVVnEwdLsqr8108I54aQNU2D13GiIBcMy9TT+wwFCiBT48phEdPXnA23PfMS9allbaQ5BxP5AEAPcrnduOA2PDzXlefySvVW3r2FQhCG/Q7N8grGw9pIC9KhZUa3pVGYEMKMaHFYhh2fXO5ceQ4vrzsi1JWQXeo6hxG6J/9FKGP48iaxz90hyct1FyjYcPqqSS0sqgzupG4MHfodZGE8TvQ9C6R60zDW7sHwxQV8P5bxbNm2iDXC6MCKIuBWWb/Lpb9vkitMfMI+2eKvULl5hcYitA4fB757NmBc4psWFzThvXqYkLbUTrevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAdSXEr3/fKvsA1MmwjjfMm1+K7ln7ewfbUUVyWmSzs=;
 b=hVWDxTPVEZ4hJoVKcZsuwowHgogdCS59ruXwlbKSctanVMEL6gf/g6AjUh6GciwGDs0Oqt4px//ncuZGDS2eS9eLgizBCtdZaJtIBLffZ6IOcB3NEWPB44vS1cgJYercuf7/rOXlQ4OWWR6pciE/Q7CHnu6/7R9gpZqZilFyBHNnpo+JoN66aTj5cGL200cWffFfvNyuORnGxwk+De+S3p8q1gDyLn+kG1ChPw/qaw3KSBE8bZ7ODUk2ZWZWkpjtTgrESwvglUqssXDYtX2J04CziQEnrJbG8SQ95mXVbX7okrWNyF0L6E47C9C1p41FNfQc0QLiyu7sCm3w7b8XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAdSXEr3/fKvsA1MmwjjfMm1+K7ln7ewfbUUVyWmSzs=;
 b=crEq6fq+ABKCz40L93TnNn0lGRRXtlv+8jezqWNyYwGJ8nggsarWd6DUtjk6CC2427q/RPO6Lyl8iauqaw7rK3WeHG4YLUNefWzCFb9ktKAKho+ISLEGVNUjjIeZD0NjoAbwUQ22kEZ//Oi7zFI9tRB0bY+9FdTPJQ6EPhAlZR8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 00:24:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 00:24:03 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 2/3] selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test
Date:   Mon, 14 Feb 2022 16:23:47 -0800
Message-Id: <20220215002348.128823-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215002348.128823-1-mike.kravetz@oracle.com>
References: <20220215002348.128823-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8681ec99-8ac6-44a4-bb07-08d9f019788b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4516:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45164F6D66501C7A10CE8C92E2349@CO1PR10MB4516.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Y/fJFzUOKpxrOHiBkWuJszqHHj54trJ+SsOMc2drMFxoYU442iJQm7Z1gGgYb7UnwHnICBjVskfkSKNPiumSw6/27im/4/pP24i4WJGjheQnAMTD5h1E4kkHHC59awkfPgO2w5WyoR6KgNkuSpxrfKjfHc1xD2YuQbgIsysPbUF2XK64H0t701KrCi0xrRWZbn0z8Wkb6GbErZ8qJbbkx29460frH14+Jr0ueMwKDL5oVM6vW2C/PhIR2Gu9fn2LVE+rF91OtG1H2ipqV/iqwFo9kZ5yzcz5BeUPOAzV1OVG4N6ajm35ItUvo02Q1iewJziZ/12vS4OF7oqyKnExyMuy3R0WyBgCFlYEVfHNBIHE7jL+YtcXwXQBmuKzaG0ntg4chH3xY7KD+bd5w7TZHdMPsXY2Jg6Bs5OZuV7FzFivAqshFflEwoDwK9nbtU/df6uU4/pkjlNx27ddqsbTeUdzkezM6wjGJX4bDh70ah8dLI/oXoKEJP11l7UqikH0MpfY5cVbmqtUBwSQ9wlY3snVldNcvfVg0Q865nwiLbq6ZCwUbehhakLPCskwElCGzT3f78TlSuE6bOymBwD9k2sziPEzehw1keY5FRSr/LzdhBAs3zuF+44e5gAtRRz10ykZpKEOhyoHfktxB3lMH4p9HNH6aD2x+04OE+6IJCr7usoAubIot1FvLH/6D2guj8Kf8mJv0VuVh3jXX7BatpWKbcLp4weRVYGzEqt34sFTpWCzXR39oz5swZmzgXsqy8itT/rBfgWiTDlT8KRlwmrJrf7UGJ1uWN3xGy9JPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(8676002)(8936002)(66476007)(66556008)(6506007)(5660300002)(508600001)(316002)(30864003)(52116002)(44832011)(7416002)(38350700002)(38100700002)(54906003)(36756003)(6486002)(6666004)(966005)(86362001)(186003)(2616005)(6512007)(26005)(83380400001)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eN7eDXwHKTdVfLTArsmE2DVCT1/a+tbHT1gW8y/ORM5bvRlEJYsLfcnzDsWJ?=
 =?us-ascii?Q?zAFB5zILeRvK9HQjQNn6ww21meqUmyWhfkDfXrNElMisyt7uHIf2jqwwBmM+?=
 =?us-ascii?Q?PyZ3DKcZiBrKclZGB38PrICNEndjQC40FT5qDKVErV1rwn+TLK8Y2fZpyDSP?=
 =?us-ascii?Q?0yvOx5H/7CYiGxpdrOAB8JFjBsJEs1UIZrgspZgtaBAG5K51GC3KYRAxdNzM?=
 =?us-ascii?Q?eWLNS9hShRCRcQ+bu8rvYDdBMIUR1Y6UFHe2euaQZokQbTedGbbJpXU8N0+Z?=
 =?us-ascii?Q?hatWyVBMu2HAob+lVEsEyw7WnIEKgoPvGqqK6JabLzgWqos6vErkm1iphef+?=
 =?us-ascii?Q?CAWNP5Lr+Onh5NVLkG50TKfSrzfxmVBlWrhhMjC3AXBu8yloDyoCOtSN5nlS?=
 =?us-ascii?Q?a5s/5Ds6PISwweV+GPxzgwCiVHSKgv+wGrbIlJP37D3EOa4zqryk46uRkvqU?=
 =?us-ascii?Q?IcBv3Dz0Nx9yopMsPvyQKTtTAv5dUnXf2Ybydsg7RAuzcf+mTM/1kZnbWq7J?=
 =?us-ascii?Q?6lQMiII67spmWAeNbWWZl0Re0B5swhqRzHVk46H5sU2QX6r+PjZqCJcdAXuJ?=
 =?us-ascii?Q?8ll0jjV2nQp5a2BLNe6UhKrF5D7B7TH1xw2K/gjEF36nYr42UWe74cZve6gc?=
 =?us-ascii?Q?r/dUnauMjTkNKJ5VhMBHe2C6BIp2ouWu2+gmQTbjTKbgs5fkYRkamUVlj17V?=
 =?us-ascii?Q?1yGJuE69Ha6oyI5ZuaEXlKum7KFgFO6roMX+gyA8qNg/m0Sp89B7hdt1OzGX?=
 =?us-ascii?Q?DvmNJYYLktk+rrqB3htQ4FX6P50D7xTzUzP1AqeWTa4m2K7qb4BUcId73PLp?=
 =?us-ascii?Q?JpdJnRIxUFggadeBQ+poKBvv0z59kThQ4VK1m2x8FVhWlYi45ZkulvRmF9n7?=
 =?us-ascii?Q?IrgoggbtLxaXqK7mM3q9zKgMbJdc5PcbykJKRrwKJXMHZKyET8qh+hFy1oEx?=
 =?us-ascii?Q?NTe5ETBypmaOMmyL4HnaD1MlapYbEyaf7ygp9p5pYrF4YrbGPELyJUWiT7GN?=
 =?us-ascii?Q?31lEDkITxD3s3P6Ke3QDEO4Sr9aA8dl1wYrWnnZ/22xW2TBHgC966kB7/e6s?=
 =?us-ascii?Q?OGSt9dW/bDACIqiF+C80SWYKKPAPb1lBrMf4tylI/BvFzo5/VMYVpvwI3A1V?=
 =?us-ascii?Q?qwUDp9lMvN3I85I7OG6Ug81QMBDCTbd5o6NN8ES7tRbG82yGd0QKF7KwUOHV?=
 =?us-ascii?Q?BFF2tAa1BmLSJ4NkcpB8eSHZhcGn7KhuWqxCn/L+9y0X1G2kHPZSRH7VZdfU?=
 =?us-ascii?Q?sKmA0pNbeMQBeaWBicaqI2kKRNPnqkg4PgO8jc7ZCSzFIryjR3ZN4nhR9zlt?=
 =?us-ascii?Q?Lh0L0CtmoQuPhL0+UvSpcxc7H36Cfn59Qf/L6JAqrMAW7dS3yVwvBioRmF7y?=
 =?us-ascii?Q?OHVTFnhc+QJ6S+oYYVWKT+Qp7sAzP9jgigYx8VRvwtZ3eat/azRHv4hIlhUx?=
 =?us-ascii?Q?9ts8V0CToQL5fk1A/0gZ4BeJfmDeMvNyviRQ2Kh/rNGMuPLh3VUMqoellvhL?=
 =?us-ascii?Q?3DX2uu0h8nfSsA5cs24LdTVsFeyffksbnpza8fd/h1VHF5e1wiaNj2dz19GW?=
 =?us-ascii?Q?7HWmyKFH7Mzlnljr92Kb2K3ohLu5IC/LQRWfJ4tnfW46GmsC8PbBp2sCxB97?=
 =?us-ascii?Q?lYHeVFu/Hei7I8SW0vUoXug=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8681ec99-8ac6-44a4-bb07-08d9f019788b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 00:24:03.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sbAJqy5z1OOw45/Pe3wdF8LKC8AWksg/0+fTqVWbzWaSG/qkxyUwcmz9D0DEDD+/fcPRJo73lFaMtSE0jgMTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150000
X-Proofpoint-GUID: TqcyySQ7UMUcAQA42H7v3AwE5v_enwEl
X-Proofpoint-ORIG-GUID: TqcyySQ7UMUcAQA42H7v3AwE5v_enwEl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 tools/testing/selftests/vm/hugetlb-madvise.c | 410 +++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh    |  12 +
 4 files changed, 424 insertions(+)
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
index 000000000000..6c6af40f5747
--- /dev/null
+++ b/tools/testing/selftests/vm/hugetlb-madvise.c
@@ -0,0 +1,410 @@
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
+#define NR_HUGE_PAGES	10	/* common number of pages to map/allocate */
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
+	/* addr is not huge page size aligned and should fail */
+	ret = madvise(addr + base_page_size,
+			NR_HUGE_PAGES * huge_page_size - base_page_size,
+			MADV_DONTNEED);
+	if (!ret) {
+		printf("Unexpected success of madvise call with unaligned start address %d\n",
+				__LINE__);
+			exit(1);
+	}
+
+	/* addr + length should be aligned up to huge page size */
+	if (madvise(addr,
+			((NR_HUGE_PAGES - 1) * huge_page_size) + base_page_size,
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
index e10d50e0b8e8..1948098f431d 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -131,6 +131,18 @@ else
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

