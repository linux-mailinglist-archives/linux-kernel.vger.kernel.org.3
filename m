Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712F248DD65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiAMSDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:03:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58640 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237392AbiAMSDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:03:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DHnAqp002556;
        Thu, 13 Jan 2022 18:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=XDv7D4hJeN27xMCuPmsT0IC8yZkwj5c+OZ21G5wTyNo=;
 b=gVyFMVGs4/BV9gzer5qy4w7t/ArPmwBOxsmnpT4ALUQaEu+ZqFqtWMBnJJIWcl0kiHaz
 oxefVYdmfwc4IeZCj4/KYvz8ZeX6CaCWa6dbmznTTyAcfN6J9o+E5g3+Fsp9CKcJNoog
 jDsZMxfXqtOaxM+Sy9rzhbNQFoVy8bQkpz57xOKvNNMTJ0fMtuOFsbjINyXn010ym6aC
 5A4oxC/pOSFvSuegfEwIjvTsrU55dU8AF7OEDWP1N7mib4ABNVSt44CTNnhEPNs6zh7w
 81p3ykJNXEBf3pZmLxUlyFBWadF7LoedsUItk/O8fhAOw0j8ql3S0lP3+c//Z1MLo0EZ GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djgv69f4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:03:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DI27Sm000821;
        Thu, 13 Jan 2022 18:03:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3df2e86pje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyV0esWaFTKGS++wbjbK3yKKMFOMAaacciXQLsWxWD1ytRLttO9yyQsM/+e9x59bJm/DPiDabQd82YpHVNn87a57bM7YDfYHsFvKGRLyTiP6Kfqm+Jyj1AjLJk+tDBs2wAxJJyNLRbzhA4WbE1eGOEqZqTvwyiYIjjjne/1e8wRRtl/UaRa7EmS26Kwjy4rI8D49y3aeF09Ahf5vP5btgZn0WeGQ0dmVTnthRiBuzgghV824U2i93BQlVKZEM6NFqMWQ3/X5H+cee93j4uoGDR68wU3EiXirdBrIwY/TO02YGWWk4TeyalVunviXctFueiAeZTUcTRjrGf+sIEj19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDv7D4hJeN27xMCuPmsT0IC8yZkwj5c+OZ21G5wTyNo=;
 b=mCPhVo7hVpLA2qnv1QkcqQdxrDGyMyxA2c09lAmXod1xq0d2MXUl3K0X6oVL4NKp/sTzUqlyyUg7inEg3Nv0f4ufwOByX3VgZnyTqKmnpAFZ5T8oDH+NyXuumswIjm0ZPGaTRnDcvtP2hjsmtgjUDPhFG0nUOPGkuiLhAAI1G0P5fMV52Fv2gpSvktzSkrUDn8Mouc7mYJfPfnBjbILwjtB0UZT5Tq/Kz5EP1EOiS+dWwjZZkYe7riw8kJcyAGyJ2VahDxZtrWwB0jxoaJT6CVMJE+xH3kGZ6aPLnDa200C3j3OUZwJN8cpBwgypuTrf5K4mXyPXKR3bkkeez9Yq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDv7D4hJeN27xMCuPmsT0IC8yZkwj5c+OZ21G5wTyNo=;
 b=UY4akMCluMUcAhl90aFT0jWMMwcAqWgVoP5ZUqcZeb6GF2cNFzjJUSaETOYsiXGLFYNdRCQKj9thkl4bH+vyZ+NSghgslBM+nPJ9IbGFG3HNbQ6ORmEX2O4+5HlBTj7yErnkQ+ubTdSDdsNCCkXmL9P0pgxkEw4dFyyy2ALmd/Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1540.namprd10.prod.outlook.com (2603:10b6:404:47::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 18:03:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 18:03:19 +0000
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
Subject: [RFC PATCH 0/3] Add hugetlb MADV_DONTNEED support
Date:   Thu, 13 Jan 2022 10:03:05 -0800
Message-Id: <20220113180308.15610-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c53a1709-2bd0-4811-02a5-08d9d6befab3
X-MS-TrafficTypeDiagnostic: BN6PR10MB1540:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB15404518B92CC3A8551470F2E2539@BN6PR10MB1540.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IW6cOnSfLwjyAoqFmdZr0JeIrV/oTrOpkkH3IEenC8QgcPWeimTCQRTvSTn8ppBE4RE3gkfxYeV4pUgF0HcQKddSZkUtBkL3n502iMiyNJkTKStayozNLl54gtDgQdI3u47J1CKs4itb5C97g/DCI5ND2Fy4G+d41wpk+V26hfFeRf3YSirMCGecBV3X0+pMkjs/i/vJuMeAESLWgMId7sD4F/HPurictVBMoObnqfxPzAuXWRUdOVjyEMOfdY3S071Id7TV7t23b5qN4KwVlDpvu40CWDCRSNl+r65aIXKdyupFeFoOYDNm5f3daR0MhYfK45jiQrTVWjWJXDVqy+/vjuj4zM7vmHcLGU+pELNgHVRZ0wLMpW2zbwU3sPz3RKXAOkg9hTVI09KzaZ3NtPJ9pNycc4SIjouVoftjsrTOvS+9d0LFys6OYUVa7UajGZk3o2RJMIc9LY6CWKlV6ujG9cF4+pcabCo7SHez8KHh7Wg9L4GcwwITfKQDna2+bO7CaTqYJy+qjqrAe2+3Jls7Pqj5qEUVrhmjHKXNPPPyhhtxmxzQd1isnE7CgMmeQ8jsx/d8HKfL8qwfJquIpBFBUNgXc0KoBPod/5yEcw7Lo5fdUTyA+p0Kd9rQwEtDkkXiljO0pE4XKIMWRsYRKOnSX3KNxZEEYP9VcUQBGXQZTZ+nC5Kob1OiAe+ZXy+3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(4326008)(2906002)(6506007)(316002)(52116002)(8936002)(38350700002)(66476007)(38100700002)(508600001)(54906003)(66946007)(107886003)(8676002)(66556008)(6666004)(26005)(7416002)(2616005)(1076003)(44832011)(5660300002)(86362001)(36756003)(83380400001)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rakrL/+sn9no9CLIr2Aedwv7jkv364/ryDbuyHL3RfHV4VXmfMLCpjBL07PD?=
 =?us-ascii?Q?mcpseLgnSwe8qmX01/SxXZ0omaXT8Q4zvEe/HANHg5+TL4Mj2T5W7jbTjXpw?=
 =?us-ascii?Q?NpqXi70D8L4TLfZslG/e57eX+GHkoR3PD/wjzHbdZB7V4Wwv9Htw2ilL4bMM?=
 =?us-ascii?Q?vbz3U97cacGOB3dbfc1ri+CJ2CyAN/ab8zPenXGvsLtVA6wkoS2OTNQcv+bU?=
 =?us-ascii?Q?TYD3l8UralDFcABzkR4dS1GYrewqt0crdwXR8Sf3Y+4U5wMAOLsAXtfcz4xm?=
 =?us-ascii?Q?1YN9LlCjw7u/G/3FLr7KisaydJLKs4hUsc2HGsaDtwsxKfZTQwyW7xV1d9ri?=
 =?us-ascii?Q?/QVg4+pRrwXaeSfAsuBB7384DLU3S9a54RL+DQwKIfl0ChDlcx6XfZXey41B?=
 =?us-ascii?Q?205QRiKjOAbF01oYhcapfwn7LtSHPSK1Pl/llBgJy2uzFD5aTxL+pjdfnBJk?=
 =?us-ascii?Q?dUyAGjEmlDonwUpDmXRy/7AhuBUjqtnVM1o69mnz3TKL8G26D5HUwVT464nk?=
 =?us-ascii?Q?fQp+vZWG2VsaxT8yfL+vAoese4UxwhMLkvtJwl6qeLg3jic+/MzznWio6qgI?=
 =?us-ascii?Q?F3l23ech0OMnT4XHbt/esrHQdiTEE78RVhYoPDIO30Plo1XvflMzRsuWl1VZ?=
 =?us-ascii?Q?f59O2fazwx9vVtWCnkOI3CvIuljl0JKKsO0HDthOf1Qino2+1CzgtmLDdNtH?=
 =?us-ascii?Q?TbDcIazA3b9BqKQ5Hwu9Lft/y6XbFLLgfMbyosHAPEdYiDDJu1NEwJpmOY+p?=
 =?us-ascii?Q?1INHIl1PK6Y17mZ6QDFteo+qkIAMFkVNah7KH0NrP1k1aSa52JWAe2OWc39E?=
 =?us-ascii?Q?efsoWKFgdxfauo2w30KimjEa+CDfZNuLkx7mPFCa7kG8mKCcnnQSAV5tyGi9?=
 =?us-ascii?Q?f6Xv/f/pij3R40hirpItlak/SHerYzFFiZD38elIf8YrsT8p9a49wOgdONaX?=
 =?us-ascii?Q?4eh3N9qoTD8tUyk39+uEqoYd+qcBcj788TJCW71gpTt2ScHxypJZ0KfbHiAE?=
 =?us-ascii?Q?2fda3zA34ssm/aLCPvyJGLD/v03D+oJp35JWUfkGNO/WqoNSH9dlCHfM1q+V?=
 =?us-ascii?Q?SA7XdeKgETmzVjPDerYOLvYjJ4PS8oX4PVTK6UGuS7YouJzozzKK8yaZHpqt?=
 =?us-ascii?Q?/sJ5ARumDEca4tKif/h7EL0UOz/+wtMqV8fTasErl5tH3rFmAZ5SzYVk02wc?=
 =?us-ascii?Q?MQLB7F6eLyzDHrdUj4KQUd/qslzl/vSM5TMjKnikEFHbB7KurdNeQNTofnAY?=
 =?us-ascii?Q?o3bbrhuH75Qs7xKtCcqXQvKJfLf15RcOfvDVmTl5UJ3PcOEQMcc5a6drArA7?=
 =?us-ascii?Q?iQs082n9XsvZQ9s+zvs6xYErjnOAJZ9Dshu2Q8lguhRo40cHCGExyBRmM6x1?=
 =?us-ascii?Q?rIlKHUGMlSST7LqjcVHUvQwYxJLrSZn/W6iqftvfop+tisoq0yWtaVgd84sx?=
 =?us-ascii?Q?byjSSzwIDQgDSg0Fj9FtHMjNaaJhfK2CKRbLwDKynhHA3LJVmrpHmQyFOoKT?=
 =?us-ascii?Q?EXvuKxPGdAPDZRZLcT247c4ljO1/5pOl+R4tORTdY9jWA9mffR+mYvqygWdC?=
 =?us-ascii?Q?fhJ6m7TkQ2dylONmVutbbv2ePGRS3DL7WEf2yTk/rgpncADlrRzqPCceuuI7?=
 =?us-ascii?Q?DjMtc4v/lg1YrbCtHmBraRY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53a1709-2bd0-4811-02a5-08d9d6befab3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 18:03:19.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4y6tkCRykWGISyFGIXTS8oEuNuq9nZ3fONKOVcBzpvad0lWa81uwNv+sIKBKgXGgf3tMllD1gNlwvViLkv9fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1540
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=883 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130112
X-Proofpoint-ORIG-GUID: zweTD1IjkfUlZLobC5Z0NUkzJf2ey_nR
X-Proofpoint-GUID: zweTD1IjkfUlZLobC5Z0NUkzJf2ey_nR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd selftests for hugetlb does not perform UFFD_EVENT_REMAP
testing.  However, mremap support was recently added in commit
550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed
vma").  While attempting to enable mremap support in the test, it was
discovered that the mremap test indirectly depends on MADV_DONTNEED.

hugetlb does not support MADV_DONTNEED.  However, the only thing
preventing support is a check in can_madv_lru_vma().  Simply removing
the check will enable support.

This is sent as a RFC because there is no existing use case calling
for hugetlb MADV_DONTNEED support except possibly the userfaultfd test.
However, adding support makes sense as it is fairly trivial and brings
hugetlb functionality more in line with 'normal' memory.

After enabling support, add selftest for MADV_DONTNEED as well as
MADV_REMOVE.  Then update userfaultfd selftest.

Once support is added, the madvise man page will need to be updated.

Mike Kravetz (3):
  mm: enable MADV_DONTNEED for hugetlb mappings
  selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test
  userfaultfd/selftests: enable huegtlb remap and remove event testing

 mm/madvise.c                                 |   9 +-
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugetlb-madvise.c | 315 +++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh    |  12 +
 tools/testing/selftests/vm/userfaultfd.c     |  67 ++--
 5 files changed, 369 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/vm/hugetlb-madvise.c

-- 
2.34.1

