Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF334A69AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbiBBBlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:41:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39896 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243588AbiBBBlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:41:19 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120eEC5015797;
        Wed, 2 Feb 2022 01:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jVGr7kbb4b8I7D3F1GEGKphL7KrDxOhUmfUCCmuP9VY=;
 b=Ocah0/HVTEqfETjb74Xbm181D+IUI0Ctr/T1puUwIR5FlQ7OU0wf1L1vxA7o+jKwGpFM
 65tbywQrI0SnC8siVakn40n+uqBZO5PvlRuPx5xbrRKU8u4rG19GfoENfBgR0zBf6Rnb
 TlCkN1tnT00PRMMa5rapQe2FY0ACFeHdTvUhPA+CkCpzZj0A+lMpEirVreiGQASNO3AZ
 Zq1uHSkmwIqGnQwpowD/yi8TgyrODQVBDc6X9AZ0QV9SA4/BYMxz9fC8olEfOSImvDrX
 iMZ0uxkjRzW5GtE5WzJpzsBRXSAt3IIGT50gPcTp7OvkAHiA4wct0WoqI7Gr1qH0T+SN 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcje6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:41:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2121VgRD040597;
        Wed, 2 Feb 2022 01:41:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 3dvumgevr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpthKbXRtq+vVvjwFf0ASuUopcmiWWvTBz7VTmYsCN95rvDOBhHdUlqSy55eH4iEwgJt3FiElbPO90aLhAppX2Mjk/Wek88QnaSEI1fXPj0Kc4nB7e6jyA7tgZvmYbHyYuIVyrha+8QioAA8TfbfvUP947CZXjnkJiedEu1ud27/tjhLQi9BYON2SZEMAFRxmuzPDNaBTXDA2VJZNQ6ENcaIadix8tnD+PoYWm6956SZeirAPz87M5bLvynK0mVUJNYexNnX+WTtoCgSr6Jt7sUVZvxKCTDM1FtZcJ/DPLINdPVjxha2ihf4Z9DIdXzJxWVaV168zqFl+hSJYoZgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVGr7kbb4b8I7D3F1GEGKphL7KrDxOhUmfUCCmuP9VY=;
 b=eSzXcYeaPkrMfyCSneZ1sbybUwwsYU/nizDKEYjv9Nd49ZTOOX7cGUa65nzpWjQ6jCfpZzPiXyx0d4ZMferEDHnGTMyDlCoEk9ekm/89EzT6uVWmf7OPy/m4I01ofk5fYp2pBY0YrSShDDODTCZLmMWgFJwEVsYzlCmoJlEnPJxrgNi/ZQFC5FTFWEh1hcWQlEAz6DdoipKI3VHwz85LdMz0m5lSdvZeUxwhad1fm5Q8Cd3zKBnTx8UMdLEnTy3Ui9uuJWkbpOFJP3PMecOLuzZcIcO+7ToGkbE6pMdXeONYYUp8ECrgRakxuEauIJNI9vY/DzfRij9bBDTYb8f5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVGr7kbb4b8I7D3F1GEGKphL7KrDxOhUmfUCCmuP9VY=;
 b=cWnl4aMZUhBInaVAOYgji0fY9GS6/63uFAyKfnaLQJqELb6OQnpi+OQniq3+OrG1vUTpx5xEBAsMOy36vBz53jyBu6LJ7UbTQOazIzRZOKp+m5b+1kRPAhB2xBmpAqA9xYu89pytjIqfvx5MbdjhBwCIwaJbQcgv1cjNe88h1M8=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM6PR10MB3433.namprd10.prod.outlook.com (2603:10b6:5:61::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 01:41:00 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4%8]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 01:41:00 +0000
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
Subject: [PATCH v2 0/3] Add hugetlb MADV_DONTNEED support
Date:   Tue,  1 Feb 2022 17:40:31 -0800
Message-Id: <20220202014034.182008-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO2PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:104:1::11) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95cbedb8-c467-4538-a08d-08d9e5ed10fd
X-MS-TrafficTypeDiagnostic: DM6PR10MB3433:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3433CCC47D8F4B6DF4EC4E88E2279@DM6PR10MB3433.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdpBvUlnXsui4XcZfi58xEO0spQjbOaLqyXL0+r2u+k2sxNQrwPt/l0qS159DE/lLUN6q0EIk4Fk0ixbJmwolBpY8AnRi/euw0TaEUFphVRmBYdQW7O/X0tM8VI5nCbOJ3l37yuWFtHtEyKxPWonsrtQ57XK3ulkBVrAS1p+POoT+lU+7UXrXCWxHIjNt48swjIqvTllPUCP0CyKRUu1Z1Vdhd05oEyTlAQsNIu7sKq8pq7wuSMWkg6GkXyxcVJ/dOePv2LCFqkzagH1Xclrrb61RKonyVjFvRGrlGuv16tkCflx8moMASLWFZ+AFhr+EdCCa10mn8f0jucoT9V5vJE9QyWYKHg0rjVtSSPiNnCxi8hmPvxQGNiBsjgPfPWyhm1Zod7bpP+WfXZfr89NErk0C8DQwFKeqdeHkp5WwTKzq3M6weF3Etp3wAiNpDK8AtyaokiosEIoHsWpPC/nxkYS3PpgnTf+Zo27JcOwPkFjDwhTH2mxr6Pg1+HXqiSOE5jGrNpF4xF8sfaQ+6zV3nGEZyrsXmyskqYCfGp0illG/t50fZteaXIJCaaTA3BWm2IhmXoItWTUsvzZ1VaG4hIIuIs64BrKVpOnkY1U1akMzFSIlD6YqM+tS7UNSTlTUrKU2ND7LrTpqb8aOccLqSe3Q6lfOpKYz8VX/g2ibvXpU35FMBiPrEcVnKQnkNfh0kILRu4Q9Dtp4GsTXqSrC99MUfqlpFzDtw4dckrIA3m1+DeNk7HRDI9QO0q2Z7C9/85AW1P9mW21FYac21bj7z/dr9Z7gHl5m/a6gMaA4pg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(7416002)(54906003)(44832011)(5660300002)(86362001)(38100700002)(316002)(4326008)(8936002)(66946007)(66476007)(8676002)(66556008)(6486002)(508600001)(83380400001)(36756003)(52116002)(107886003)(2616005)(1076003)(6512007)(26005)(966005)(6666004)(186003)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fxVqI2cKU25TYKfgfZDVWq92Z6xwFBaYzX9MvOYFawymxW6bwHNASPKYzlBF?=
 =?us-ascii?Q?30QemkuGwzMI67z9/5NJcKlIXez30+aK5n9u3PNwLbXNmKB65rOjBwJyFIC1?=
 =?us-ascii?Q?+aHzxYqeOVb2G7fIIg6v8LuP4iZo9SY7eLPlMQ8843jO+4QWjmutVq6GjcY+?=
 =?us-ascii?Q?J6jy70K1mxebjc0DRyz1nLszuOgCzNC+gM547/uvqDQ/y83Rm7ECySicBekG?=
 =?us-ascii?Q?dJKT4Ap4W065unFFRcN5w4xLRay0BCcUTfIYeJ5a/5L2ExfLl7ZD+yTX3KdJ?=
 =?us-ascii?Q?buOAA9ePgF55vhPJ1Uita8MX+KpPpj6aj1p6IIPuJBtIU1+bx3yyfTXV7f6/?=
 =?us-ascii?Q?NUKeqC3KDB/xnJO/D2gmgZk/b6PT7REcWyS9Zuc5Cud8U7336Ftbpe3Y71Ux?=
 =?us-ascii?Q?eM4EZ/vSZbAAiflHiTI42QNGEGQLLzW+jRtCG82lpGIGP7icNAOwx9i/xKLu?=
 =?us-ascii?Q?HZxrtwhzSxSVxhI2Zz/W2YuMaP+Mj5yc2okkYg6QQl0sUMoMuWnPZF7NEimE?=
 =?us-ascii?Q?0p4omE3TuL4UjgdNqEM3y2NsppSABrxGwrLIDy3+P62W2uJ3Hj6Zi/FRp4xI?=
 =?us-ascii?Q?izBpfnEW3sR5k9lkv4joZCseJ5aziCWgczZVcDZOiH8GoQdof7fI55jQEs1C?=
 =?us-ascii?Q?MHPtMDc0TbUn7KTJKD9mjoAGBjIR/tSkkHVhCtl5j+ikmPeCQYmVuEGFwFFY?=
 =?us-ascii?Q?u6HYl2cUWQUgN+LCo5wITRogH6m5VAUqwBXdYPBYTjqQ4ADBhRVmXdmtgzeo?=
 =?us-ascii?Q?ttyFf0oYS88V40582shlQ5iubSwf5wTptEHM0ZvIcZobfytcXWH7GGF2NgA4?=
 =?us-ascii?Q?FrSfsS6UyoIG5RY9B5D7Ee84PgnGKIpl5gA3UG0s9xFyl8wnPQEEjRus043b?=
 =?us-ascii?Q?P0KMBh425/WbmB58Cdt77afnlp9fm4IIpPFWeq/WsDWgNWvApiKOdgdHQltJ?=
 =?us-ascii?Q?f+gLwdYIBJDEfoI/Kg6ZcTsPHjsHE/ACJU3+DdX058lRsNUuGHRy66+kwIGB?=
 =?us-ascii?Q?sddlPCz5HnH2JBBTwWnX/Qj4qSqbU2HTU5qfICroCz+L8/lIe8iVOt/y1APn?=
 =?us-ascii?Q?jSpjn9TsEqvMwsZ+zybHpEDLhtOlqgpuVW/my8LamrYzLO3vGzzJ0wMYtVNX?=
 =?us-ascii?Q?vd5aWV3+qo4UvFu5au0Jhgn8ZAiEXDfEC8pngizgT7yReQ5WmKprrhjSqq4W?=
 =?us-ascii?Q?zt2kBt1SBQ7mvuL//+eG7ba/0XLV2bbY4n6hRDu61nq/7UeTJf7T31CSAtNa?=
 =?us-ascii?Q?rhi4kd+7xOaSygcvxDGFviEWltlqYxyKOTICbR3UXwR00SMtkuVAskK8NfDU?=
 =?us-ascii?Q?zN0StPSk7dSyf2jjQzzHGNy6EOgnCGwTFHyOV8O3urVOFRsdW9IrZbX45waX?=
 =?us-ascii?Q?g7G2QTL28k/C3cTT+N/vt5gUwd66MWCmdwPJ0FIIq+j0sRh959820ayN9bte?=
 =?us-ascii?Q?B1npkPdqLpSK5LKhoKajyPmgXdg5DD6vHxvyodJNqOpTG5Hq2eH3gW7pkl8t?=
 =?us-ascii?Q?hTBjdTITo8gBW38+plMoh3n7wDeB/yheN7xQyydPA/ncm2iOaEFf1j1qgUZC?=
 =?us-ascii?Q?1rXOKilBw3phTBfS8vL8aKD1NGV4KE3Md7z4B1WaEq/cmRonU1AotypkUEss?=
 =?us-ascii?Q?WXWDO0vbXp/L8F7i7ZMPlss=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cbedb8-c467-4538-a08d-08d9e5ed10fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 01:41:00.7202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYqHo2ojlRQkj0LIBB/Gj5BvQCHoiecpSN8VlZLBW4UGiO0uCo6bAE/9U5+LwZ2qLoep0yHh9tf2aFuyM8vGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3433
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020004
X-Proofpoint-ORIG-GUID: uweGTIsWXcyN30-l9olQ5tXgeKbM77-p
X-Proofpoint-GUID: uweGTIsWXcyN30-l9olQ5tXgeKbM77-p
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
  userfaultfd/selftests: enable huegtlb remap and remove event testing

 mm/madvise.c                                 |  24 +-
 tools/testing/selftests/vm/.gitignore        |   1 +
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugetlb-madvise.c | 413 +++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh    |  15 +-
 tools/testing/selftests/vm/userfaultfd.c     |  69 ++--
 6 files changed, 485 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/vm/hugetlb-madvise.c

-- 
2.34.1

