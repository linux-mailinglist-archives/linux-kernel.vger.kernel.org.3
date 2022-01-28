Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D594A039D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351420AbiA1W0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:26:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16634 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350536AbiA1W0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:26:45 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SMCr2E026412;
        Fri, 28 Jan 2022 22:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VDi15XLVCeiRhTyOpC/WFBPISzs3GfCeTu7QsYH+8hQ=;
 b=Y1BXfBGcEHw/5avWTZiRhx6Pax52LeRgfjgQqdTSh8dy2vfmbW326I/9ftRRrunnEkeo
 7WWYunYBwvrX6jehvTqt15ENI+PdJxJh0lsWL5QFhsHolprW73P5m4yAxdzKN/SfC+Mg
 Hdm+Te1vth/S8WJ7GNQjrgYKX+ioN4/hrSGfXjI+Jlo0B7ORv0SRMLcIqcJG/r49x1lC
 7yGj6A0F8O3t7XyL7LVcxo++I2s3POYaeo4677gSUYjejgEspwC67EUjn9C/5N/ZGpD1
 TinKOYssxMvFuu5loabT9VK+8cBK0S3iVBr+pgQoNK97GNX9/CvP+PUYIqyJ+BOw7DOp gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp44v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 22:26:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SMHCvB084116;
        Fri, 28 Jan 2022 22:26:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 3dtaxd8nf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 22:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oULSmRZ3j/RrwiKpbiNwt18u63TSMboKfd4YCZWRQeeGQOwrDEPSX9d28T1HXghQHJHY8PZwn7440QATf5lPlk/xIlo+wI5x2+Rb7suTARTMpQj3R20BJLSLAECLcd0Ktnwr8u8pMFBrknjKNX3emgf2xzcyRPiXXmCmD2CM7wSFprbsFDobnpnCna5v7RN8tIdcRC4kLwSFUHRcA9oD6T1y3FHwDRdPHOsn2GA6r1TXd9xgJLCT7EtYd3gJpwjQvoqTZplMel0qNCJZ/FDudydosZCfkDV44+WJ36xuRkMarG5dsMIh2XUHyxGnjFuYta6+OmHMjX3t2z1nUexyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDi15XLVCeiRhTyOpC/WFBPISzs3GfCeTu7QsYH+8hQ=;
 b=b31w8kDmbmxrQyX3OyLERmS72jDEyqxhXCZsO1ogH9xmQW0tPKF0FP/z14gQo+9RpDvWvJtIiORE+7FQf3BnW0PlPuYwrCBkqrUqsVeinalde4n8YJGmQdNqwZDlJYHMmBe7dRcj9Ry6w+ZjCcb4PI/STdpKyAytMt8YYtmHeTAode8XbtTh+4e9KUg6sIiuLYCNvP6rVmG6F29L/JVyabeo5rora1QWfVaHoG5ZBqCM1SrWItyiJNpe4MYVg4k+IKlZ+GNlxp0o0sHkHGBYkdn4B6xiM473EE6EqJQl9+oBq7WDZNdUTSbGMNp8iU8tbrc6/aMiwTZFYxudWT2LBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDi15XLVCeiRhTyOpC/WFBPISzs3GfCeTu7QsYH+8hQ=;
 b=o3V4iyCkBzdI2qe4PpvEHW6jfQujiHNudPTEXQ4sN9PgobSegh+G+sHC0xcYS4UJHsCbEIJrHegS/6C/kBxbOjdSZ4WJiCC0vzVTmd+KrFLjMesn0VxxCZLjYNFOODzP62YeZo3PVYU2yvGcDUvQF8MvWIhp/0tqBpFZYF75NRA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2587.namprd10.prod.outlook.com (2603:10b6:5:b1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 22:26:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 22:26:21 +0000
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
Subject: [PATCH 0/3] Add hugetlb MADV_DONTNEED support
Date:   Fri, 28 Jan 2022 14:26:02 -0800
Message-Id: <20220128222605.66828-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:300:116::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93d7a860-474c-4eb6-b2c3-08d9e2ad35d8
X-MS-TrafficTypeDiagnostic: DM6PR10MB2587:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB25878F51E767D60577C33015E2229@DM6PR10MB2587.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnvGj8aI8K/Dqmgv5mUuyxOg8+CErdLPf20TtFqsChqqFy7n1XqS3f0B+9/tL9wCoIN+eKFsX6Ph0b45oM1Uoss5zBRDgoi/Uo2n/wOQKeuf60x/t/W/5UjxA1JyWBuUZUyR6u0BFy3AbGqtk0idomFh0NcQkgLSA7GCm9DDj4T7o3RnBw+r3f7VxKmglb5If8CV5ThGuQIoXQi39OoYNgPvIlkfG3ilYZNl1R+o05W47KGp0LPX2u1TwhAyn1hv/pvIH+UhLEcNUAsAoB2IHBmwSvZoxcMhlhgIAH/eaIZxOAXt+vOR8hCRfhQtzYj/KdvZD8kJlqc6KLJaTlY0+on/qoXeRobeCXgDPzL+2StWZoNLLUgHGakiRTpZMfpoge2SLRM4bQEUxZ5B+hV/da095uZjs8y6xOqjcEX7CWxyIhpoVWEA4hFg8xCCJq8GQXk3YIHFBnHm5OhYIqD83qy0pgNee0UlX5a+7QILqF64oYPH8TnbUeiZPvSkdcX97pn/LRyPg7+aKNceK2A1eHISS+iBWOav3fpALpcSwIsrqqAuqKDNmd7dDLVUOWYb5Ad3uiO7snMPB/rFMItlllBWtxuE7yMR1Ll6w57DL7SdeMBQU7SUKa7pTzFAG+3RqucFzyQW5d4siZAyN7BjID8MzGv79WPlexqkGmRG1VhatkAtfiwtNBkse8+MLjA7SOShIgnQFKIw0x2j0KNfwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(7416002)(66556008)(66476007)(8936002)(36756003)(66946007)(44832011)(38100700002)(38350700002)(54906003)(316002)(4326008)(5660300002)(6506007)(6512007)(6666004)(52116002)(107886003)(2906002)(83380400001)(508600001)(86362001)(6486002)(2616005)(1076003)(186003)(26005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9kcLp7yIP7DM1FQToj9Qso8ejTzC2QI9OJjkT7X7psgZRy2rYZMF6abnct0?=
 =?us-ascii?Q?l+3SDItdDKteGCqt0jN8sOXKd5Q2MlqF1Akv4Cjy1it7FUfOFfgav1HZNknd?=
 =?us-ascii?Q?UkTXp079Z/OI4u7NqRQLRv/pEmjjjPmDUkmVaOnFSkp+lKfTVXs6BpV3kfPu?=
 =?us-ascii?Q?/nQLBbx/AQ1QbWlrI4VLFK7YgbR90Cs30mQkCx6gqlBdbapqohubOQAmOl7a?=
 =?us-ascii?Q?xdhrtoc5wYWaqe7dexuP+hACMSq8NXBGQCT5fF3zHRH//jiX0YtgHee1qpt+?=
 =?us-ascii?Q?f1yE+rmIvCHwdkZ3sC5GxF+ytE3DSH3TZfhscAEwRhx3uPMfWkfO82p308Ln?=
 =?us-ascii?Q?3wDjYxU4+orxJ1zxaJFw9GIdf+e1ZfEcuLJ0woty6/+G4d5wbQQJgnV8SwIG?=
 =?us-ascii?Q?1i0FHrRt+nAf8dl3ImHVoX8BDrwx2ASZO+lrf3oR9zihlIBeVjj4+LJwwHID?=
 =?us-ascii?Q?pNj+G+8kzmOWDJ7FMG+h4SubgnvK9qevooeHtGk3dq7C30KRs8k5Hvt5BIiE?=
 =?us-ascii?Q?n/A1u4yEo4ASFV1LDC20VlMxqPP9NDaN0V5u6Y8pSkGWeM1/BP7ZVCWcgFEE?=
 =?us-ascii?Q?JgMQJ6EIRM7e97YW019O6H7QuPhP6UVvB2vSL7zLbpCXV26ddcF04jjtaBJC?=
 =?us-ascii?Q?rnHKU5/SjmA2hmLczp835ZH8LAwbvFL8tStYcUxgCI09gtaTrI8LzYlCnZuC?=
 =?us-ascii?Q?hZQfyFyZikwaxo5rZpP37CKQqF4wCTb1RtFkIR9GWESrBk/kn7+uHYga9yCT?=
 =?us-ascii?Q?YhQ0/5vtQESqHpPk9ZxOP5+DtpARlpcGf8pKk5XaLxuIrg0s6XEs1Pa1fMGm?=
 =?us-ascii?Q?sV/0klzmMUWtr/XVl1Ti2dyx7wkGxvNDw5O6XOpXRO3faygDYpTMpRx8/pNr?=
 =?us-ascii?Q?KsfPt2/gNW9OcRR66xU44gj8jtN1hAyT4M1bAD6Q9ZXxUlj9thNlPXdNb2se?=
 =?us-ascii?Q?e77XnGaQyUS14dXEUusqdQYJq02+hFuYLa4uGlD+WtYo6kw3zALQU2S0h5/O?=
 =?us-ascii?Q?KvY2l8o7cGaT0YJc81Jr+STD0cY0ieoZalyo1YO5qVKO8KL/O8cVNvlOL2VM?=
 =?us-ascii?Q?ypjogJfY8llb1vOGIivMPTKFzGt5zxNNMNT0PX4D5uHUzHSlAYvtl6LyaO1o?=
 =?us-ascii?Q?7WjCneugV+mUYt3GC0SFHZ99uUKanlNrWnY83Z2gS1bG31IqZMIsTzOHMaWt?=
 =?us-ascii?Q?x1lp25JaDcAo4KstdOWmi4e4zMfLkiTRlf6ELgYqqstarttdZ687jp2KeyYJ?=
 =?us-ascii?Q?lzhdbaCPv7OYZrP3SqCEC40HFmd4bxaqzRGJb+OMccWIn4RbV+JQt7nEW/wh?=
 =?us-ascii?Q?yuSeIsDJV8zZEdgbqeCzeVQSaYqz9SpLImxDtlquur7ls+I2kX4NED2qDFlP?=
 =?us-ascii?Q?xJTm/WwdK9hsL6f9vqaf3L8Rs15A29LLTGDiqp13xGnXXnHkSMlMw0uA9Oem?=
 =?us-ascii?Q?7NY/Tv+tk39JjTXdF/vqNNrHlJjQQEt/LI2/gtcTJKdrpxHnObFlXQRDm/bc?=
 =?us-ascii?Q?iI+0YaJxxKsH9eYliVpvSqKv0WcLWVm7mYiqgJKVxOdCUpI4nf/bLMN3CzKW?=
 =?us-ascii?Q?g9e4LI0De2esd15l0f722tW1fzPeqnBiOB0XJYUVbIjv5S9N2MFzeCbW6wHZ?=
 =?us-ascii?Q?PZUxJjSUISWEn9/joW3kOJo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d7a860-474c-4eb6-b2c3-08d9e2ad35d8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 22:26:21.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAu4j8+3FDYY6AymbL0YuQuWdZCYO9lE5G5k+VI9vhbBe4NIdBmyRy0E33UskUx3nu1YRQphjIQR5rSLs1mHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2587
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=912 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280125
X-Proofpoint-GUID: qnx91tcKPX_5EnMr8YOqOckQbSb_phUt
X-Proofpoint-ORIG-GUID: qnx91tcKPX_5EnMr8YOqOckQbSb_phUt
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

RFC -> v1
- Fixed alignment issues when calling zap_page_range.  Naoya
- Added checks for invalid arguments and misalignment to selftest.

Mike Kravetz (3):
  mm: enable MADV_DONTNEED for hugetlb mappings
  selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test
  userfaultfd/selftests: enable huegtlb remap and remove event testing

 mm/madvise.c                                 |  24 +-
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugetlb-madvise.c | 401 +++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh    |  12 +
 tools/testing/selftests/vm/userfaultfd.c     |  67 ++--
 5 files changed, 470 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/vm/hugetlb-madvise.c

-- 
2.34.1

