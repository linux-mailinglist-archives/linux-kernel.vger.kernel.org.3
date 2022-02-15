Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5D4B5F02
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiBOAYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:24:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiBOAYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:24:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506691409DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:24:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ELiLxS014426;
        Tue, 15 Feb 2022 00:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=wcVonqoRRzDl7+60qbP9NLHgvo5182H6pAtpB5P351s=;
 b=bOJnhH3c+TK+9F98/+RX0wzRPB3NxF1Axb2T+IJ07D9TAlhM7mZlbJ6plHc2895llRyB
 qt1hlVJ6d7c7a9nxIBTc5QlC/+dH/Y0c5EEkC8TQnODWwd30xYHRWkxQ+ImFwto+FcXp
 CFA9YkYTNBnWvgITXwZ/1Yobj3OSbBEltd5daaNXpnj6Qvleq03bMH+EBV/EhZrJ0a8A
 cVT6yJILP00Ac6ZAGz3OnmwclQK0lm075+XtdBEx+VjWufXSeMZnWILbB0lQlDOJOpwG
 ASQuABsHfbjG0WZYhXuUwKgmj+DGbGT2OqWB6aaQ2NTj2GLpb+T+yibxDA+WEJDA6Xng 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbwy2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 00:24:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F0GQax044989;
        Tue, 15 Feb 2022 00:24:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 3e62xdv8ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 00:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ93SYAs0smVYAjd4GmS+kI/5Q11XqxDDG6NnnUn7foDKOyXe/Ql+mSDJXPZNygkeb2pvvIRvSkXKL0v8B0MLhUIEnI+KXIKDw6MLKMmV8YoDXXHCod7GKTjNcYHDVg0BIe/HraeBxjSOoQAi4pJz7spT66go+TZNXrVW1P8epDX9t0MaOilim+neYpTbA2lsFNF+mGsIeM/4tgJsZJ56MHhNT3zIocVY7dri3AJNK6OnM8sSmk3eUljdVFYvAKbCNqxqIsH4WmYQDmDvHJZVrkBlnpPyjhs2zTtQPAP6y4y27EjdO5MOXRjXvCKoVbDoaGORcfOTL/TPn1XKnJD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcVonqoRRzDl7+60qbP9NLHgvo5182H6pAtpB5P351s=;
 b=O75tPBd87CugQEP4mDWTVCHDf2TLUovWqJ+Xa0tcOKR0T1k4+pIup5vefe4pu1UjMfRA16+mAlLtGuC7n7ISU6ScKhRIysHUOSLDj0YCFq3iFmaQcnfaX0nMQt/yeQKoni2hiRHQnw24i9Fhb/9XoP/D9DM6pbIePwcDLovBs/mIxuSzZ83WzYp/pDpknhuIgKBuFjw/03K+R7IIJUJaLXKTcW3fv4vFe6SlrdO7CoURvxtnSzqVx5mFypvfKWu6XRhqs6Xb0uBpECn6xhaIu6rDY+rlzPlqo+Oed34x6/3Vtp01Qrqkpn65OVuZLX+KjgFrAKApkichq6d2tmyseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcVonqoRRzDl7+60qbP9NLHgvo5182H6pAtpB5P351s=;
 b=ZAtFozS2LDQCsDPp6Q801yAUbSjvi7WIkmUMbHxs69CXK9dxYEXbBbN6DI2GxQ4oxhRH60A7IfSxBStEWBWYCB2MrRR5qs8Kp6mtg9dyIZ25ULtcWsbacoBQ2BakBsDFxjCtFIvy0EvH/VvokLUKkEKNrH/7x5eI/YDqNFbIaAg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 00:24:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 00:24:06 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 3/3] userfaultfd/selftests: enable hugetlb remap and remove event testing
Date:   Mon, 14 Feb 2022 16:23:48 -0800
Message-Id: <20220215002348.128823-4-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a9f4479-b54d-4b16-598c-08d9f01979e3
X-MS-TrafficTypeDiagnostic: CO1PR10MB4516:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45160260AB8CBBE8C1AB46B3E2349@CO1PR10MB4516.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGIYeS+ceSui208jVq9rWj8vVIZ9lD3TclnM6/KMhuoRk6tvEMxOzCId5Q0N8uWkPaGd3E2ALCpUUXdQRb9WQ8G98JG7ozRcJijbiDZDKcB2mHXFzkdnS/lC7EE7uTT7ysy0+Ro7r81nBhMIAJQYjRuvzXhMQJR5MtkDPXKqr87HCcfjehFSQDcfqFPM2wM3t52RTOTpK6GTPt6pS28CLC5jsiZrZnSxpiZPRtNj4DSUmWXTT//5d2Trj2GjI2FIHldiFXfd1Ve1J4Q1yBdorAjwXV4qxtrGFD7CnCbMYmK/DKDTybYQ1dEljuIwMtmrR3evnIZltZV5I1OtHG+EV5rhcr10N/LXLyHg/ZgaB4rLtmxsAksafZagXZ8hhqYWhtqzqJyaV77HF0cUmen6AV4oA6MWNecmSyLQvzO38tO+vOb0j8bp453MjC0AWnm3UosZQ7lAIIEI/K2WJxTxUE1uHePbx33a8j4+k0Bf5syPVBkfspae+GJay+WCjggaHmH729/pmeLyZYICNqHCSeIhnoptlBW4ZXuiLZObRBcOCAZ0IeMFjCw04qCP55nfjMgE5ZWyFg5SjvyNqDE9uBRziwlXsxaMm87t4BkC39oXQfiM8hewu7lyEtZtRCDRgx8BgQ2CS2LeOHbK81ZgJgQJGDlo1HfCGsEftfMgYioPVXZxnWZ06kZuSOGT6PcZY8Lx9nEapalZ/4TZpjl3EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(8676002)(8936002)(66476007)(66556008)(6506007)(5660300002)(508600001)(316002)(52116002)(44832011)(7416002)(38350700002)(38100700002)(54906003)(36756003)(6486002)(6666004)(86362001)(186003)(107886003)(2616005)(6512007)(26005)(83380400001)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6f7n71GiZyThxVfmjFwwSpNPr+cTQ4ozWJRPCgrHITXhY/p8Zq2FPJx6933N?=
 =?us-ascii?Q?qxsxWDqbD1MT9RwxrwMw2wCIzxs4LdGVjr8912KiLiuPmUgo8k64fHgIqDO6?=
 =?us-ascii?Q?Gl8K6x4ghdgcE5cNc/bpr+LXM1/N7ekmr/ie0/YWIWV6qp33DohJNRFiDBru?=
 =?us-ascii?Q?aa210eu2vl5IoZIPMeG5XovP3EwyKgR5+zjNz/1EBvvBZpIzUt4FgRaPclTv?=
 =?us-ascii?Q?YoCCufokutt+hMnzvB6oD3ewoyFOyW7FFuxX8UeRDxI3d0L5lKv5eGrxktLM?=
 =?us-ascii?Q?jTd57zFI7ulWWfjQMjxUy7rKrFCKYY68YNGjS6VJ8bKWVhsSGOf1VuRbCvIR?=
 =?us-ascii?Q?jS5jLQ5H2HZrzcmOZRMdq04/slAVM3rKVCUYHQGMIiuTeN0yjxCRmAkdv6kt?=
 =?us-ascii?Q?tZK5N4H7z1IzzYMjyr0CvolFM7WsV+ZL8OqeHL8DkJLJY2p5fqVqPU/wuIMN?=
 =?us-ascii?Q?MRUzX1IKV5CLgSNBqV6BeoscxdYKsw6JTH4wZvLp1j9Bbbv5byQvYtu6Hojd?=
 =?us-ascii?Q?Csw4EVXSa25Y3NgJzhLJANSntJZ2bEK8hSOLGiu70oj4tacYYS/YeKq6/IcT?=
 =?us-ascii?Q?0yKYX3aR+ODfheT+VaK07VsxafiasfBSQJhhAvz4H2Gxv2MSP2dDf+DFf8Su?=
 =?us-ascii?Q?iWVjNlSuWi4+qCtYb9FWOyXIbREzoRKarOI04aOxlj+iGOwPacYsqQxCFDeu?=
 =?us-ascii?Q?SpeGz80VUmE0Nw6LdpK6CA9MdkxJbfxwHFb6h/7/zmiBBJF41+vzD5kC7JeE?=
 =?us-ascii?Q?GUoxCFVAAOzA4i64M9uIbqcyHy7+ybHwu+CKK/Z6QvZWV8ksFMrWxGJ7bWe3?=
 =?us-ascii?Q?crpKNN9jSlXyUgH8o/LTQGgJNIjP0hXTkBQLUDoHzpqCoWqL3Z6pkr3wkFTM?=
 =?us-ascii?Q?hJkpASQofZgzbAyk4wm1G4mro7OrYQxfolnrUrUgjtT+EZMj+6gCwaB+gRne?=
 =?us-ascii?Q?b0Vm94xPaCxF7cmaH/ricd0jRO37qGf5YUpa5YLkZCwep9K01bJLlw+JssSu?=
 =?us-ascii?Q?9oXxSfo98kIujAMnHl+awBJj/+rMqPvxLjbtNE3Q2IXxK8TzoLS70llMSOXd?=
 =?us-ascii?Q?ObEUg4ZGqAjzbxjkd5Sfw1Se0pJ0IC3SZ0KyXky9TYmLSVGQRTv0pflbBZP3?=
 =?us-ascii?Q?FUsHUBGgqGdKXly3Ko3u1+fd9c0SfDkgAavYMnUw9KxKk9MnniYZh0AOcKfM?=
 =?us-ascii?Q?tPypnv//DEzbw+RWFcCKlwuwhfPIT1yWIzZ+wJPnbNj+dcovKwPWjZLPPxV5?=
 =?us-ascii?Q?OhDyk104dZM2f7X9I/A4Iu5kxa1UIw+4cNAtNgQAExWKGJTjgS+SClinWUgA?=
 =?us-ascii?Q?8njhjBHb4oJcpRcxQCUNNQz9AbzoAwwRQVPwSWlp+XprGF0dF3e+Eemv9+OW?=
 =?us-ascii?Q?aPDoPfO36dO8tS2fFMvxgAayKx+ZyTlw6DFjCYfB4qDmxqJRt/JSQLoh17bY?=
 =?us-ascii?Q?NtSIAxC5VPXQ/tbIo7SPOmVJ2AqtqzQatYXSW4Aqwzno0LSDufeLKmzlmQSn?=
 =?us-ascii?Q?weQtlRZ4kjD0YirF6dKheOdu+W+q5qECkba3ikLXYpT3Ld1y3J6ZZdiG9+Lx?=
 =?us-ascii?Q?xuUZbO2hquoPVjuwll9LSEYfubCX9jEGmMdLydLIPY+CJFcAPJ/hqqVoh1M3?=
 =?us-ascii?Q?jypMr32fl4Q5xu9e2PBfcks=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9f4479-b54d-4b16-598c-08d9f01979e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 00:24:06.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qcGZP56lVBMGTyf7GIv5N/USyz3VU6+tsAYEFEwb5Z3MjOneu0O0lNLtTkmHJykFrqFCi4vbhLkZ+QrrH6kDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150000
X-Proofpoint-GUID: vQwl1quEW_KxOEBt8h2H44-512yv3mhh
X-Proofpoint-ORIG-GUID: vQwl1quEW_KxOEBt8h2H44-512yv3mhh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 1948098f431d..3b265f140c25 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -208,14 +208,13 @@ echo "running userfaultfd_hugetlb"
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
index 50476ec6c070..388bf4fc9dc6 100644
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
@@ -1675,7 +1676,7 @@ int main(int argc, char **argv)
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_HUGETLB) {
+	if (test_type == TEST_HUGETLB && map_shared) {
 		if (argc < 5)
 			usage();
 		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
-- 
2.34.1

