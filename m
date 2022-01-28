Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284394A03A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351683AbiA1W0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:26:55 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24118 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230083AbiA1W0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:26:50 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SMClLO025308;
        Fri, 28 Jan 2022 22:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=yqpG1+R0S7YWx/GMZU+Cz0Xpv0yKbr+4G04dykhKLrE=;
 b=KNc9sqPIF0QqAF91IjE7C19qBoR+vfv4viO7wR9EYSuCtynooSi/VZ0McZehfM/6GZte
 fjuRy/Eupa7K6E0YM+TaIEjmuVGUu46aLZZSp8Kjp7kRmBhFQ9J840i9+L6jIbOqfqLP
 Vp/wLDr58Q/xm6ulawtWv1DnIRqSq4EE/T6OSqnBoAaJaakOwJ0zzPuEobBr9EH3eONk
 XFgcAGEUgHJNKX0QIMszQdgCL6spxwl2O4fRlC1oFE6Er/xrThTPZcye1PkvNrAU+p51
 QuCd72iVPmBamEg7f+WVgkHgeoqZCeIlA36JpKex7GOX5N755z0FjE6WxP7KboMsucCO Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwrxmmj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 22:26:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SMFiJ3102183;
        Fri, 28 Jan 2022 22:26:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3dr7ypma8r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 22:26:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymk5EerJNYWnljgjCV7FDkh51DkBqJePwPPd5X4w9sUn2rHe1istCc0HGoLP7bKcVO+eNvoWj8BzjoAT4lly52yFJZtu+EuCU2mO9sDAt3D+mbSo5oCZYHGdtc3YLUyEagK3K1fu9ZIq3uMKy8MVFFIalDshRmFTnor/QdWVpkQL1tXcqzh3NpFmX96n7fBtswomSq2wGgdof38AhN8AirH7Nf8OQXGZ2hYSaaGprJMMHBwSVAPnZI/zBwL9UCphMObTLPzyRLpvQz0sUAfhJJFtYHg3Qsmlp4IvxcRGA36/q2/HalKwEKZ5OFAacoMoZyl4F04yY/pG60JnPGWebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqpG1+R0S7YWx/GMZU+Cz0Xpv0yKbr+4G04dykhKLrE=;
 b=RaWJmzzWUncBQEArN+pvJ+gSE4gFPgMBrW4BZuMkFOARbGWxydCs/1mYHEWW6e2v8oD4Gls9sL6N24MhfOYJTpgUwOF/J4T5e6l3BD2aMoJ4P5XEyMOrtq+A1ZpRBRB1kS4WMXfG1i9OXOj5wuct5ELSijDWHUMzU/1WVJyMLhkR/2zOHVnfbHk9HsNS/XcbPUBHlztJDtn6m7UMbxmkuEO5r8koZMwQjHa59zTXuqOZrEOwk1c20EppBZLD3MBzXuBsO4Ry/Q6HKK9I2cCSTqgTqGQlviFpa/Oo5aQVQY1cmw0Jn2n4d5naCWjpdyWxAQqANuncDdoUQ6Ep4oCRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqpG1+R0S7YWx/GMZU+Cz0Xpv0yKbr+4G04dykhKLrE=;
 b=R5Fudtp6YUmO5uRj22+GP6zbUY2TV/Xv89zNsLO1giBrEr25s1NGkER2WPGYUiCtvcConc4i0fWGYDIFyp0LdT2Q392pEPnCdMR0nS0xZ+HIZiA/AIjBqiaO7nwL+TPK4X65cjIDR9CUfCedQ2gsQuZ7wJg1a6F7tHEt/GCrdOY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2587.namprd10.prod.outlook.com (2603:10b6:5:b1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 22:26:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 22:26:27 +0000
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
Subject: [PATCH 3/3] userfaultfd/selftests: enable huegtlb remap and remove event testing
Date:   Fri, 28 Jan 2022 14:26:05 -0800
Message-Id: <20220128222605.66828-4-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: dffc2cdc-efb5-4d58-5ccc-08d9e2ad399c
X-MS-TrafficTypeDiagnostic: DM6PR10MB2587:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB25876158E1547E9309E6184EE2229@DM6PR10MB2587.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTpHd0c9N+dGjGsR4lpf5MEIneq5Puy0aJZPqZA5NGR4ZN77jGYRZVP+5jFfPOa5x8ejAmm3JlUJdH8SlAyozYmjRhR0FuI+06nb32hj4K9JeXYkm98s26eZGeEaIwbp5lUWh/w/EFqGYAeh687tqQSxBTRIJoHcirw3zmK/YPpE+ohHye7MZ9/BsZDJODTDe8g+FPJCZIq+4aAyEqtdkeiou6T7gmeEACQtB2VCO/Ui7n0iiwBi/TTBhObO684Iv4rnu928jIm2QJjwiwf6pXgLvm1UZNOF9SWyjf2G68rCK+qWPLt7mPTouA/oqr4vmEu5zJNPIFLlHqd/UILR+KZQaVVtcEr7pPaF63/6o53GYABhlN+BD7k8j9o+uItSGmHAnNSFQ7QGK3O2+lkUzlRTRn38dD3kAzym3MOD8SZNZyh/fszPgfaWOk+S0KYkx2hNmKzyihSFzngl652QZw2gzAVPfEtq9025EroY4rxL+AWYbKG5Yb/ILYx/a9Q6WVEHU0qcXiNI82nq1wJxw2LFLeXpsx3bdiOU8gEceCj9eopyliIpeszd/tUNIzqoQmQyR4XkDNSmha4dWC30Gd+kt2i2P8PQaw0HgN3QL5uEQFUTUhH4bjh2mNUrKHM/SkpU6aTRFVnH7vcsK0spvnmDyxro5ZejXSyfjGv10dQl6zrKIZXPwOiqWyhl+ppiMuKLlYzAOrls6zsAConAtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(7416002)(66556008)(66476007)(8936002)(36756003)(66946007)(44832011)(38100700002)(38350700002)(54906003)(316002)(4326008)(5660300002)(6506007)(6512007)(6666004)(52116002)(107886003)(2906002)(83380400001)(508600001)(86362001)(6486002)(2616005)(1076003)(186003)(26005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9IkqiqXdBZgGmP9NUiGDpl8S+NC/VPLb44ikN6FhSZ8lPlw+p2Gjhm7Jm+uH?=
 =?us-ascii?Q?GE2wk/04a6yYoTepHXnn8xX06iZxqiqU/YcQOktrDTwx1fX6DfBeP9c6AIeU?=
 =?us-ascii?Q?0VKkv22PIf/Oha2ZPOq2nSS+qm//OrfuTzSY3d4ipzkbHWVyZIzyl4wDMhUj?=
 =?us-ascii?Q?UpSAx/vxStqFf1AITa3GxtwQf7n4pqyC5kKjWmtfrNz35Dfc40fI99PCE6HD?=
 =?us-ascii?Q?SztDuWdrlIveb0ECzYSdeSEje4IibZ/LI29RS7IxRNlobgSM1qhstIyywnby?=
 =?us-ascii?Q?g0EPmzrY5dqLPuisGQMinGOGh2c60PQKva2n0Apl/vXOZrBPQ2upDIf2sew2?=
 =?us-ascii?Q?KAYDTl8WgpjXJhKxdv4qxT3q4jzBdCz6oBSAlq8Hrsz+aObBgPeXyzGtntTX?=
 =?us-ascii?Q?QvpQA7wZKNjQXo5OAPXMgsOnmIFJLEEBmV717elZ1NQHnJh7E/o2oStrqlgQ?=
 =?us-ascii?Q?hrIrJIDIQTW96CVxM0pLwArdyhhu73+4W095aI9HeJhXpWbipia1gmIB/k/P?=
 =?us-ascii?Q?fQBh4AGFBOOm87tQ0B90Fubo3aS6dpg0xsArV+zJX1S9OkuYn2F354CO8eGM?=
 =?us-ascii?Q?gDkt3XPJE/2mkCvoUsLsCqyKhilDfv23Ddc3tORBGhr0Fqag+gK+y7qW1NbS?=
 =?us-ascii?Q?itFsixVK1QGY/QFVvoIxg80oUf/tg8hSmZjzI8eLy2mevXCws47OVnlFZ+tL?=
 =?us-ascii?Q?QxLRxFWb7uj4nHQjSS6wsGl11rymqdcwyve5aKE7EViT+LbC5E01LGfgAEm5?=
 =?us-ascii?Q?+dyW5q6TMxY/RKaZPcG71nbV4Wg7IpAEbqVG4DzDtJmDBlM+kbfiS97tfxpr?=
 =?us-ascii?Q?9oRIav84/oU6cy5czsjHazk5gK/iCkQSkT9nMC2OAA7kpOnshrY4mNZyBd+O?=
 =?us-ascii?Q?TPaNF+icGXGplpTBlu7iUPqAjk74MXrctETYbSC2wW6GcWfXZKzeoYcjHLMM?=
 =?us-ascii?Q?i/q4xjZzPbPFjNmutzE07d/Wjxnh+G93JBeKruTFfj8Pl+TKWNLHYJ/XApHi?=
 =?us-ascii?Q?uUzsIhFj/0byOCodNz4O/80153uWhVAWw3I2yYq4OJm5liEg6hbLM5NzdqQt?=
 =?us-ascii?Q?832SgY1ZSYrh3npaOm3U8NDm0VfYWjmOd51xteff7Q9/MINYgI98FOUMH7mO?=
 =?us-ascii?Q?aN99JWz8LNOqXuIsOTncZ2DQs/+/AYDKbqL9EIyFQR622HUuPlBD9OmrdzwA?=
 =?us-ascii?Q?wHJ1hm3UlXFCSLYACTxMcTalRnyT7fhW7kpyJh3o7INKyC5dpNFpyo826JQk?=
 =?us-ascii?Q?rwJCDxtCBxsV8IxCZ041v4w6iO4jYZmLCuibUE/2aOATgoSNDxTxUmjN5fXj?=
 =?us-ascii?Q?g1NyoGiAPuIer9lDG1Dq9tW6ojAv+6fOIX6zdiVtqw7065ZR8mjbUZ+b3OwA?=
 =?us-ascii?Q?xhWJI7EDe7Cb1ZRasnYS4Xmv7pPTiov0AHP9TIPPaepQx2D5NjfFvY3Wy9FO?=
 =?us-ascii?Q?cZrtfVS1Z+8RqGdelNJ5re29YrDb6+rdVUcenIrqS1nJ834LKpafWM4vk0Mp?=
 =?us-ascii?Q?GUKq6PEB9cWfHn12bQRKySIOQ+d5wuCVD9emItdJnogj7odZ3BLJrbYi5nPi?=
 =?us-ascii?Q?yjP5On56v8vo8vbJwlTVXlp0u8jYwkr4W4AnlRFxE2mnytOwZqyQSh3vEp51?=
 =?us-ascii?Q?IoRQGxCFQn1XX0LAavN5cpU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffc2cdc-efb5-4d58-5ccc-08d9e2ad399c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 22:26:27.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YYOGcYIZO4JBVAP357LgA9gXG22HXj4nEdOz7FmJB8AgTKBnVii6ZI7JplWAw29dZ/79EaslUm8uyL34uJquw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2587
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280125
X-Proofpoint-GUID: p0VjFWuNcIM0NxSGoJp-e9OMb4gzw-_a
X-Proofpoint-ORIG-GUID: p0VjFWuNcIM0NxSGoJp-e9OMb4gzw-_a
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
index d3fd24f9fae8..f5578ef85560 100644
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
@@ -922,10 +929,7 @@ static int faulting_process(int signal_test)
 	struct sigaction act;
 	unsigned long signalled = 0;
 
-	if (test_type != TEST_HUGETLB)
-		split_nr_pages = (nr_pages + 1) / 2;
-	else
-		split_nr_pages = nr_pages;
+	split_nr_pages = (nr_pages + 1) / 2;
 
 	if (signal_test) {
 		sigbuf = &jbuf;
@@ -982,9 +986,6 @@ static int faulting_process(int signal_test)
 	if (signal_test)
 		return signalled != split_nr_pages;
 
-	if (test_type == TEST_HUGETLB)
-		return 0;
-
 	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
 			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
 	if (area_dst == MAP_FAILED)
@@ -1667,7 +1668,7 @@ int main(int argc, char **argv)
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_HUGETLB) {
+	if (test_type == TEST_HUGETLB && map_shared) {
 		if (argc < 5)
 			usage();
 		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
-- 
2.34.1

