Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62504B5F01
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiBOAYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:24:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiBOAYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:24:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8471409DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:24:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ELiLbg014427;
        Tue, 15 Feb 2022 00:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uljJgiItuydJ5NO7xyNs9kjjHz9WeL/CxVdDnMHAyp8=;
 b=eYZvpEp1/aZcrK21N8qg0VTVdEu15+N8jteS6rAiQcn08Yn0AUrqRIzjjloTRJbr+APS
 HFzc8QQ3JYzwHM/YmdI7hJ4BuS32QKAo4428k9ZnRlXGBFHBrFRTOERw9DOKBNLQICqA
 UEMWv24kNrWNgUKL0upF7f6jVFeMnPg3iQIXgauf7JBIWOtf4k7bNJL3XeIyjXWwjPnJ
 sIAhd0MOQlsn1BLfm1qsnhT7H4S1xRtiOrNGiRHe4oxwZqqkrPcUwRNfw1JKbeWz1O/d
 rlxw0aegQtJ8LmstkWe2UPjX/IT88S5o1AdREolk4zpJRjocUN2/U4jQjOdX7DYEEhv8 lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbwy2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 00:24:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F0GPam044981;
        Tue, 15 Feb 2022 00:24:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3030.oracle.com with ESMTP id 3e62xdv8eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 00:24:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib3qjVd426Xz8MXEyM+rVarbiXFfIWAMOGk9JndgFPhjmfLTdJAkO491K1Ap3supblctmttuRVnbngG2z28V3tZ9HHXkdQgdtpryQ4aG5+4T/NMJW8Kkdu5ytv2LtLMjTAHYvsOl2wl9tNlcokzMjr3MQkCsGILtedbRxnoIDBcWhUv7aiL2HSFtEtjV4Qx/SrZDWH18KpG64RwKR/O6K5otmsUiI241AxfNn/SnAMCS0uU7Pc+UyQCtAFGg9c7pT4+uf/ok+uvrW4n6940Vu1nMNhnfu1mYxN6xLwnFG1/r0I6+llimcdgiyEGFvfSDmamGFhXzj234wHLD6wyEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uljJgiItuydJ5NO7xyNs9kjjHz9WeL/CxVdDnMHAyp8=;
 b=Me1xHvmwpUijwtR2pfJ0xvBw0ZiniGJcKndCrIAAsNs4IZ/ntZ6qBQQJQ8cv0V8aZI+XUEUQn56Y6wDeklIPA28Wn3Dh+XFXIrx56wzRgFn4XZ0q7IEXckU97KAtLnQcTTd6HsQ/pNJo5aCECgWvf+ek86apTBWM/zmoxcRIGiH4oPCN3DhFYVpqmttUqOesGZyllqTz79PDHUoOwTxvaBftLXiz4owkddfj7+N4FOIwGSvC31JWBakMuomCkECSjv7XmuRUgJ+Gu2j+1cGHhcaEno2M3k17/eb8Vwv79dWeMHQ3FGwBGcCU5U8RzK1TT1ptoo4ebY1rscs+btxlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uljJgiItuydJ5NO7xyNs9kjjHz9WeL/CxVdDnMHAyp8=;
 b=EQe9sl7t1S+NtshZ2kpLvqm5/IBuFa2soZMiFvktnnJD+YGJgpPGPZjvCvfWZp0Y+bqjH1rFSLR5BCB/JnaWWQcbB3zoKSOOTNcsyM3mUoTrh79DtiIArUKwQGyWvvyNVzuD51pJiZca8KrGamMleKUl9VXgX+T/ZRoAdSxcgTQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 00:23:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 00:23:59 +0000
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
Subject: [PATCH v3 0/3] Add hugetlb MADV_DONTNEED support
Date:   Mon, 14 Feb 2022 16:23:45 -0800
Message-Id: <20220215002348.128823-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e5e90f2-f171-41d4-7ea8-08d9f01975e6
X-MS-TrafficTypeDiagnostic: CO1PR10MB4516:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB451665592337CA0F5B4E25C6E2349@CO1PR10MB4516.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiHcku1CPCqO/owvRr6xGv+BbbFJw2aY+WFaPjal2KrZhUjJRYpBtxUnbaZGqmngvqn3uir8qfqws9ifT/TAD2/KvtSHALvrRgRkaRrWPoFN2iXcj0FeeTk4xZcmpWEP8HOyU8b/FvCk+gwlDxRMP9KtQJi2u4tAf+UakhBKhBGgrawC6J3zfGrueNlMpM+OWdCkfd+hE1fD0E/fZi9Tb/ELeJnS3Lr29KVaHLmArQ+q5e4Dxyw50EwKqWV36LrlmuW0hZNp5ceUH3AKHutTP0R3k11slueWmQB6E0oEvYnZjh6M11Yt7Ne1QdTZFk5/Jp0iINKA7ijK0m8rpqXykFfiH4HpSN7B8rDrFvuGrI2tKfBFDIeGZb3GlpVOkl7wmROsS4/ZlyAfzKIQdHlfM8UK1H76sbwEfrnBceqIEdU2fTJ7Yvia7hZ+BCuvy0QmLsLgH8BkVlKuuTxNbHpxRM+R2c4K9I8sDqh5q6oVJIlwmlg5v6g4mkQ/bRfE9vHmPfPGWl3MRfsYFhsxZvN1UpZjEmC8qVfjqNgUKRWTp3+mvRTWHxmG6SyceaLq1tKtcaXrHmMJvx16TVdAs65CzCA1R/2pgCe45VXS5cina6x7I9/YhT7PGsZ6YTyKq5q5leFOKRPHoqZKMB1vRKY736oKSSaDyeKR+9mWhkKaV9hIoBdp6Agup2P0GjbRsSvEpAlVMpIim24SlHH44VYcd99wJo/q4rlIB+IUaNPtsFx3/DFCap4zztkjmaLl+sr1DIP/wDEqzc6iyPFClRkzpb64s4UCVFkVxu6XyLB2iOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(8676002)(8936002)(66476007)(66556008)(6506007)(5660300002)(508600001)(316002)(52116002)(44832011)(7416002)(38350700002)(38100700002)(54906003)(36756003)(6486002)(6666004)(966005)(86362001)(186003)(107886003)(2616005)(6512007)(26005)(83380400001)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cHdGLWxcBx4WOZ/JNwtng64w0603PB32Enr5vC6/S9Ui0kxcRTY1oYqHLvZE?=
 =?us-ascii?Q?Yhv9LKABbE25mbwtw8P2wQbwhU3D0iFjy0pJcx3AYFwjsunjVJVHcmIT6l0H?=
 =?us-ascii?Q?oxk7QD4Mupq8X9zWLFSgw/OU7nEMjB/ztvOZ5ljhuFDNrCMU2nMgDCulNmu0?=
 =?us-ascii?Q?aktXzKYIzO3O5O8w+t3qIUojqqChcbwg30G9J5rcEgvBRU4XduT5gdt8obNP?=
 =?us-ascii?Q?K5YmxucI7zGn2q9sFR1RQNzHXQ5tI6B0vt6TnhXQogHOn6YWADBj6O47yCqB?=
 =?us-ascii?Q?RBuW8PhZh61+q/i0Haidar4z70tFjZPHK+cUIz/QvXVwhIvS9mCzITIm4vNY?=
 =?us-ascii?Q?IQ1lSPXdLd//CbUgUbrQYxS3kQbNhJKU62IcP0vZZQHoYlnmIpAne/ejgAgX?=
 =?us-ascii?Q?+VCMFXxaJVpD9XESWORcmZPgaTirenk+lD8KaiDMyFmOqfifxw7RGonim6hT?=
 =?us-ascii?Q?NvOeqpQw9CpJ3QFbltTcPLiG1HKEN5N6a3PORTl78nKlnC6EhyjlxpLXZAIx?=
 =?us-ascii?Q?YMT+y59ogDXC1WJlN8vOxMfdPruqSXQzFTMUTMODVRtf03WfNsxP+bbjRZLX?=
 =?us-ascii?Q?0sHUM7kFUHx2N79eEbyy5oag2QZXYmsPsmf7qsX9J7o1ofuJpq+kv0fbIx9r?=
 =?us-ascii?Q?+ESCn/pu0vNbttrwGDK6Ackwh8JiZZN9N9ocUgmfbmnBzHNCeQDKiGdQQkLv?=
 =?us-ascii?Q?pzRgwJ0AYEZky2xV7BVZkYE6bKqO1JS+KXW9IJWUZD4U7wWtsdXwwGsB6f7r?=
 =?us-ascii?Q?4Ie17bx/VDO94LoRjXM+XOVu6tNFw0eCvYSiiRmeT/OIq8x9WAUWi4FQ67/o?=
 =?us-ascii?Q?qFi1bfc3pd195e8rTywOZlgUSHMz8SjPzWL8s9GfI1i4rlwgfXW0GxokFHnZ?=
 =?us-ascii?Q?elFKde0i8qCU2ncVP45pxal6sWUHSJmdIJI5iDLNU39TkTUcLo/Yt1Ik7IVr?=
 =?us-ascii?Q?EgRgvKTL3TxdnrHEn3V347QbJlq7av+hK6y0YErXvE4xMTHp7WmXZaYmSF6l?=
 =?us-ascii?Q?xg53064uQjd+aJYX4ExMAhw+jgIwZw/02hU3d8LpoDboY82/RL7UT+t3rIgy?=
 =?us-ascii?Q?lSCwyfoaSfhBB6WJhtCHYo8DfM+TaKCKZ++UdV09Tccb3RYPLWwcV0Ko7u3U?=
 =?us-ascii?Q?L/nACZNu/8yl3TfKfSRtGxoTCSn0EOjQ7BtA9pzvtkpujtnCdxE+gNkKhito?=
 =?us-ascii?Q?SqpZPDdfM0tWJCoCjuD92eGwEpQmO3PpLZRHv+33bUYzJ9P7Fq+2aLDQhu0q?=
 =?us-ascii?Q?d+umWrhtUU/0o+4Yl9Tc3v7mEOm3AzgqnCV625f5OOgt0Go3CqixOCA19hTU?=
 =?us-ascii?Q?pCgCA71TPbZafSKPNUEagdwLZK1R9Uc6TeWGnT6tvhAYdjHfyjOW4vbnnUgl?=
 =?us-ascii?Q?/2KFomVCXfbwNr3fhXk+9CXRoohaDxQLgmHjeIF5o1FgGqPv34rnhvDILdzI?=
 =?us-ascii?Q?XcLQ3HGw/ooxQiBwLR1zdURNpbMEtYLYup2KYFmWKiEoD4GDbetOgLS9ww+/?=
 =?us-ascii?Q?rXJGk7BIMB3nx2sndUXSqNbVFFaVl+ftCyaGBGKitJWDfd6Wagv69nwOT2Ol?=
 =?us-ascii?Q?G/Z0jJNp9/VIBEOc5BkTjYD/nwu40TZB0NOSMCNoXv84SZusAkkVHvTUl07W?=
 =?us-ascii?Q?CScpdCsIS/OgzcHENCpCi98=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5e90f2-f171-41d4-7ea8-08d9f01975e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 00:23:59.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyX21GBymu7D6Aie52BU9Ifogy9Dd/n8O3xvYgBhZrRHC1vf/PddDBsWKO7rE3JD3qfvvoxBJEKPweJvcD4s4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150000
X-Proofpoint-GUID: _F3LutxtGvi_x89oO73Pfb27kav0axfq
X-Proofpoint-ORIG-GUID: _F3LutxtGvi_x89oO73Pfb27kav0axfq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd selftests for hugetlb does not perform UFFD_EVENT_REMAP
testing.  However, mremap support was recently added in commit
550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed
vma").  While attempting to enable mremap support in the test, it was
discovered that the mremap test indirectly depends on MADV_DONTNEED.

madvise does not allow MADV_DONTNEED for hugetlb mappings.  However,
that is primarily due to the check in can_madv_lru_vma().  By simply
removing the check and adding huge page alignment, MADV_DONTNEED can
be made to work for hugetlb mappings.

Do note that there is no compelling use case for adding this support.
This was discussed in the RFC [1].  However, adding support makes sense
as it is fairly trivial and brings hugetlb functionality more in line
with 'normal' memory.

After enabling support, add selftest for MADV_DONTNEED as well as
MADV_REMOVE.  Then update userfaultfd selftest.

If new functionality is accepted, then madvise man page will be updated
to indicate hugetlb is supported.  It will also be updated to clarify
what happens to the passed length argument.

v2 -> v3
- Force start huge page alignment, extend length to huge page size. David
- Added more selftests to verify alignment.
- Remove double check for hugetlb vma. Peter

v1 -> v2
- Use is_vm_hugetlb_page() instead of open coding vma hugetlb check.
- Add new test to .gitignore and use meaningful symbolic names (#define)
  for constants used in test.  Shuah
- Updated help text in userfaultfd test and modified run_vmtests to not
  pass in a file for userfaultfd hugetlb test.  Axel
- Added Reviewed-by for selftest patches.

RFC -> v1
- Fixed alignment issues when calling zap_page_range.  Naoya
- Added checks for invalid arguments and misalignment to selftest.

[1] https://lore.kernel.org/linux-mm/20220113180308.15610-1-mike.kravetz@oracle.com/

Mike Kravetz (3):
  mm: enable MADV_DONTNEED for hugetlb mappings
  selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test
  userfaultfd/selftests: enable hugetlb remap and remove event testing

 mm/madvise.c                                 |  33 +-
 tools/testing/selftests/vm/.gitignore        |   1 +
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugetlb-madvise.c | 410 +++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh    |  15 +-
 tools/testing/selftests/vm/userfaultfd.c     |  69 ++--
 6 files changed, 490 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/vm/hugetlb-madvise.c

-- 
2.34.1

