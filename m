Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48409483A84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiADCRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:17:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30268 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbiADCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:17:51 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2041hvXS008973;
        Tue, 4 Jan 2022 02:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JGNNd2ijywNMmx+4VoHo5/9EsxA/Vlz/5vWDns9XoF4=;
 b=WV4BpuBvxzL0Ppl5pBiN+dfDQXeiPBrOxdSckfP2bL4IuAoYUPb74Fym3L0ZWE1OX3YE
 tq8v4pgec5mQ9mPb8rC53eosnc6029xqbJ56nvE/dzqG12Bn++wylfyssgsfYbvDTxik
 M777o70fuptSv8DF66KmxBfSHe7TgAXFAq1+MUmMxKa5wWZg/mdvaUhrraNc0/fWseXl
 0iQ2tGNtU6Qql9IUUk0HbwU0XueSvnxG5j45Iuu2dlgBq9GIaikLz+2+gyq3r/1UxsVU
 IBuJ8AlqFBknQ93zOwWxB7Nz4w048GXg3T+xmnYFFoniJJotxtJ+0A3G6U9Tq6VLdMEn VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc40fh29u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 02:17:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2042FYve043404;
        Tue, 4 Jan 2022 02:17:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 3daes31qt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 02:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEJwjs06GlifGiFsLkgXBli1ereymAyijekRo+iRZHPUsSaWZ+drfpvafPPy/ypfpNNWRSm6C6emCfAs2zrQnA+8vtVc/i2pcuaD2euaTOW07HAgG2/kaMEk5TqvpWdOB5Df+Yg2Dsz73X1S353Md1mazTKtPZSqkfzOXeKxyJVFA9Q1iMNqe1YI6YOjVqnRKfCnyefcMqAPAUdEXbiE9yRTr44kt/pVtBfxIPAfEms3zCfY5jyqIBrA9sAPgl5wcuV5v7GoqDZbuJai8xdjN0iuTqHMAEEf+6R59dNm8COAyWHdqzSguB6ePaZeQTXRAyQI7AhWJxiJvmItV3k5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGNNd2ijywNMmx+4VoHo5/9EsxA/Vlz/5vWDns9XoF4=;
 b=MhLEX1g8OiQ8SEHKGQUT8cA/GP8PMTtxURz2HIyerv8CJAT7pUBxLUd7UoOev/o4U/QkmOYmNViv5LeCXD0NEeUxXW5Ytp1mIIOcbGgn/0YXosbBkZpvklfu1P5kziJ4PdQFHU6QX4vuULLjnUEkHHi9YmPVzacPBnJ34TttnXmnd5sbHQD+uavcp+WwS3mSaS46dULxIAURzubkd7Tch8P5v6ay0XwbWE5dFjiIGmmXqIIjXsxV0FSJdUmXh+324bRgC39peRECJN9Gmp68mCFlEvBd9WfGXlycxoORN1sL0fYvyHMhyYzl7jURdH//d4jb/XRhqVqFtnkXLdswEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGNNd2ijywNMmx+4VoHo5/9EsxA/Vlz/5vWDns9XoF4=;
 b=Dht+Mb7kW+N/16iQPPn8NrQlKoE0wPtxqxisOPcd13iLMZeZudeAj1Hkhz/GcvfdP0k+N+psYHM7PJR2broKMlWG/TkXANm0fS/7N4L06yN1ekeIPHIjZ+BcxWcq/hJ/PN//Edu1Wp+JvepYHLzxZPZeB7LO9ezqUKmT/dOIJJw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3495.namprd10.prod.outlook.com (2603:10b6:a03:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 02:17:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d0a:ae15:7255:722c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d0a:ae15:7255:722c%9]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 02:17:41 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] userfaultfd/selftests: clean up hugetlb allocation code
Date:   Mon,  3 Jan 2022 18:17:29 -0800
Message-Id: <20220104021729.111006-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR21CA0033.namprd21.prod.outlook.com
 (2603:10b6:300:129::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe9e85b4-85d8-40de-f8fc-08d9cf2862ae
X-MS-TrafficTypeDiagnostic: BYAPR10MB3495:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB349597779BF5C24D240D5652E24A9@BYAPR10MB3495.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kitoehgYw3ZJMldyP6T3xPihJYCSgm8kH+44eWZKu+INqyjc0guAWLIbu8tn1g+kQ0yDKPmd6Pkr/2MXVl5+YK87PXNeJhPGY1diO8VK6QAXuPIf1Pg0X2wL7iLMgHwpMV/zJ/FfoKXQQ0vC76YrXOKbYC2oa+fu72Dl5OVV52xvcJ9fYiVUUGA/JY2UHvQZKV8Jh3sslhCY9ici6l7sI0MDiBxJyE2HuQO6O5WCLI/BTgPuYcLpR7c936LvfOU2abyeb30QciExWbCadJC5OVu+Lk3h2ZFEOuKT7EMPI/PPM5P984lPRqw8/gw4Mw+aCBeoAEkuiL242jqTOUaIlk3TYaZVFpccuM4TcS0oxWTvh9gwUXRWGwr7whQUuQuz2lqaUiJKKME/65M/CB65mAlv4lnxm3QAsGbEtZ0iawVLEaEFptIeHgaO/Ay5EUiWT79jmLliWq8ldPkxBzM+EUVId7/ylYPzURUmIuc6UgPA3JB+6TEzLcxVImraZuVn3hDwA1hARjLMTTFJH1/IToYEvlH2SPT9oipXX553k0cS2t6ljlAkORBm3tdcZvdT4TfNXW9rR6PkjlSSrmmJbjR0omZWtGWT8NNjIfW0mOv2HKhteF5gcmGjOmOlq2ATnQ5syGB3Q3QeDVI6gO2LGPHwn0g/Hdxk+j2jmoXOMqRFO1UsoM0d2tzZQ+KHg7XX1Sa7e25fbjbofiJzOWaYyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(36756003)(6666004)(6512007)(107886003)(316002)(66946007)(186003)(44832011)(26005)(4326008)(508600001)(83380400001)(38100700002)(2616005)(2906002)(38350700002)(8936002)(6506007)(66556008)(8676002)(66476007)(86362001)(6486002)(52116002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJHkPB+uIXoa3RhyQ9ryrcSwCFpw/5MdQjMAXYAK4k3QORbpWUcC4p43rIs6?=
 =?us-ascii?Q?3/04ds9owqDoeZw8VxKD5BADI2xiRJ3wBuqfy6NW8hcRMCIVCN5axS3vU7uI?=
 =?us-ascii?Q?q3NmpFGjL+P0oEypbegsN6rF9mNy1SVNelb6IRBjH3vW0ulEK+eBoIPKicFj?=
 =?us-ascii?Q?8vFKrDXhrOMTA+4Va8n723SYEnBQSMg3hNkc9w6/36OcKo/UXkpr49Ck0ty1?=
 =?us-ascii?Q?QVl5TnlMvs4xOl7znLa9kOCVOlvuIuu+V0NpcDmkYCtS3F85TLhsg2xSAkcH?=
 =?us-ascii?Q?BNnI6H0C3asshf7OQBlzJIL6esH/Z9KwiJayyYHJM2dD1AwN5m2RAdL7Ngvj?=
 =?us-ascii?Q?cTooHOE9Amdyvj7gj5UdlzGu0Gn1MEpKYP5emrjcG/dWQInBKZTjgY/2Niuz?=
 =?us-ascii?Q?vIcjSbqimOivXuIN4Fb9tMSir2AzzrKaRRgbWmoT7l1hFlt2tbpn1NysZaaa?=
 =?us-ascii?Q?0FbLFrS1sT9jJ0T/A++z+UgABEuaa/sR+Q95XBjZvfmBcK58sL+MKAlxT4Ev?=
 =?us-ascii?Q?vbh0NpEcDCrVyah/KTdesQm9ay8iqQi5gaqYHz0xZn5Xy7B0/nUFQ1RQwTE2?=
 =?us-ascii?Q?IGZw8MoheDDueY5y2I870Xt5L41mWhiS2GoUrNsrDhwJb+o2lFQWqiZc+IPC?=
 =?us-ascii?Q?0Micayk8hiiOrnVm+gDI77K/7jHuBLbe5CmtmfZayBrBNb5WVyBMKGS5KR5k?=
 =?us-ascii?Q?WC5LUtCeLIxxL//a0XArEkjQPc7hhwSCcL9xmF0+b2KZ1yw+9oBygum+vRb0?=
 =?us-ascii?Q?QRbPb0vdBjQ3rjd7MqoQaJtiIeqFx8unaVwT9Y+JwcTXxF2V8DWJi3TUNiYx?=
 =?us-ascii?Q?kNuc6++T52W+gpSjhi+zr2A5G9P72o/1Dq0LDcyObMVq9ac5JEaAmo5e2fL1?=
 =?us-ascii?Q?7GzwmIrvFgEjpoa4jP28P3KmwYzh/fy9LrNTsLDKOBsH5HyTPIcmWKwECE3c?=
 =?us-ascii?Q?08N/T4f5gLAsCrxYPsr7MhdWb/RWoN+NEk+roHRGlRI4zGjuGPZ3qpk1OHiE?=
 =?us-ascii?Q?q+lwj2PIM65q9PCpal2hCudXuwOwqaJDiB/reuxq7ubUhxQVu0YittKay2SV?=
 =?us-ascii?Q?hnqNs12lt+8uBdPkPyi2lzZdPuZKk3JQJCBQoU6WBpe59jJzq7AActtN5Wzl?=
 =?us-ascii?Q?qyA/xxHpuYtnrE/dT9vkb3o60Jo4RRd4rPSFqoOks7s4Hpac48mZIDzXdsrA?=
 =?us-ascii?Q?r1yV5pUokhz5BktTN/58PjDxRKv8VQjiQ881s9780QUtsxmna6dnnAWFUFlf?=
 =?us-ascii?Q?5PUkGR8VzYYqsNUnMpMxjAKqRCuIL0yIOeWdfmtoXmrIDuTFz9IeSklm9Znb?=
 =?us-ascii?Q?gwTVML4tE/hH3my4+rT/1GY2Kxi3CqPXLns/Bh0AVEjh7QQnkva/3VLck7pA?=
 =?us-ascii?Q?erglAxFl2n1iQY+sHC3ejOKGlyxMEmM1v+I68nha6bCC+rCeOqP8CVyvq/d4?=
 =?us-ascii?Q?Kx7NqugSZqeEqXPqRfah3HLrVccUgh9IuOyh3yHDKNt4LBkdHPCIaRiiOQZy?=
 =?us-ascii?Q?816ZsCovOC/NjukwOE9iSZFgfrTdI7yi/Shk9a5JAbhfyGvVVt61g3U4hpHP?=
 =?us-ascii?Q?wRziX0P9NTYguTLgfotbR4raAXEL05Hx4UMi01VYIFLq+lAe06+gXdLqTzdL?=
 =?us-ascii?Q?EJuobgWMPaVx31sIua4Eoh4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9e85b4-85d8-40de-f8fc-08d9cf2862ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 02:17:41.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJcNXff7TnrDiitohItbFOd/zn97FiT44ZCupvVPc1izEFTkJ+LfdQ0K8kCR4r8tL0cHdKgXavk8vLbIDTworQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3495
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040013
X-Proofpoint-ORIG-GUID: rJQYRKXPtzA6QIq6inSLpNSE04Hmy8JI
X-Proofpoint-GUID: rJQYRKXPtzA6QIq6inSLpNSE04Hmy8JI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The message for commit f5c73297181c ("userfaultfd/selftests: fix hugetlb
area allocations") says there is no need to create a hugetlb file in the
non-shared testing case.  However, the commit did not actually change
the code to prevent creation of the file.

While it is technically true that there is no need to create and use a
hugetlb file in the case of non-shared-testing, it is useful.  This is
because 'hole punching' of a hugetlb file has the potentially incorrect
side effect of also removing pages from private mappings.  The
userfaultfd test relies on this side effect for removing pages from the
destination buffer during rounds of stress testing.

Remove the incomplete code that was added to deal with no hugetlb file.
Just keep the code that prevents reserves from being created for the
destination area.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 9354a5e0321c..0b543a9a42b2 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -87,7 +87,7 @@ static bool test_uffdio_minor = false;
 
 static bool map_shared;
 static int shm_fd;
-static int huge_fd = -1;	/* only used for hugetlb_shared test */
+static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
 static int uffd = -1;
@@ -223,9 +223,6 @@ static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 
 static void hugetlb_release_pages(char *rel_area)
 {
-	if (huge_fd == -1)
-		return;
-
 	if (fallocate(huge_fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 		      rel_area == huge_fd_off0 ? 0 : nr_pages * page_size,
 		      nr_pages * page_size))
@@ -238,17 +235,17 @@ static void hugetlb_allocate_area(void **alloc_area)
 	char **alloc_area_alias;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   map_shared ? MAP_SHARED :
-			   MAP_PRIVATE | MAP_HUGETLB |
+			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
+			   MAP_HUGETLB |
 			   (*alloc_area == area_src ? 0 : MAP_NORESERVE),
-			   huge_fd,
-			   *alloc_area == area_src ? 0 : nr_pages * page_size);
+			   huge_fd, *alloc_area == area_src ? 0 :
+			   nr_pages * page_size);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of hugetlbfs file failed");
 
 	if (map_shared) {
 		area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-				  MAP_SHARED,
+				  MAP_SHARED | MAP_HUGETLB,
 				  huge_fd, *alloc_area == area_src ? 0 :
 				  nr_pages * page_size);
 		if (area_alias == MAP_FAILED)
-- 
2.33.1

