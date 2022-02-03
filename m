Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47E24A8182
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349729AbiBCJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:33:08 -0500
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:56864
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232183AbiBCJdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:33:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKYuqJ2Ftc3oz4i1nPdw2UMPwKi/qVnT14ff5dQb8IvyM9FGLjEGY750m4euFGEfVQA1TzCp/xR8P2jskbnEo7mfP8Nx61oOfvcE2qzg4zylVux/5rew/+ChwBmEYgrUS8PH71FmPM2DL2Wm2xPgntnd5TBdSRLIEKN0Dq3Lte9gJmr4wV2W4s7VoSjAr16dCzizhKhJ5jHhA/rQmMwm0u3eARfrhdajLgfd95E0bTd/JHZ8d9F6SLvRvQR4jvVnomsz4DXwereo3Myz2nW4p0uWB/vXeRzH6s+7Uo1M2IvOegQ/3wpF9duL0VjkHq3AB/OS7iOmz3pMabWOS1g4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88HPXi7oVGrTV2UcC+4qj7aDts0BOBT5CVbZa9sKizY=;
 b=d8dbi7IPUI1eAifCgpgMo6ty3gJAVnI5sOCP0PWOmI5jmIHZAxG5zIJvH0BM8ikOWaocdJFOILeV72nNA2GGOE5e/QGdL/wX8RJOidf4kdIL8usHfozyZ/SY5vYGH74c/7fJkBTbSvTVTm/+eb19c600uoQ4tXE7/vUhRGOoxwMuZRG3Gzp313olLHFNsYrix0reVBpsVRNhwGNYnX2E31uYPLN4X8DQryWO8RWkoBdRMHSzlygnUbGnstpqmAjASB6/unbcgcTXB9oa+l58dxnNzm+TJzHEgCWX+ZIBujwXzV2twyPGHo9oWRcB+Pb+0cTI3EN/Y6YXAey9Vy3AqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88HPXi7oVGrTV2UcC+4qj7aDts0BOBT5CVbZa9sKizY=;
 b=SMZzu0Zll+Pcs06ljHzY1i2WI1tGVQWID59CCpEfFgQElz+bCwfQzAQvUEQFTI2MxdcT5eUSKLg4baorzIO3W8AdoAqo6rdB7uLuYnoj65mf/dcqvTGY5bk6en03xNUugw1Gl4iqKWF23FrXCD9ggTwpmw4M9w92nv79RNscKxvvEb7LYdZEOx3LRBlr2O7siK1saYYKysmwpNamKu97nbs9zZR2BtxSHzggBvQCAkLwiKDxAOdtrMRVtud2DdnMVAG/yxpckpa6B0t4j4YanB4vL8BvKLML7kA0l0iDB0mdsrKqNBamLoKNpcytYPYrbu3mxBLDj03D89aO3UqvSQ==
Received: from DM6PR17CA0005.namprd17.prod.outlook.com (2603:10b6:5:1b3::18)
 by BL0PR12MB2385.namprd12.prod.outlook.com (2603:10b6:207:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 3 Feb
 2022 09:33:02 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::6c) by DM6PR17CA0005.outlook.office365.com
 (2603:10b6:5:1b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 09:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 09:33:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 3 Feb
 2022 09:33:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 01:33:00 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 01:33:00 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 2/4] mm/gup: clean up follow_pfn_pte() slightly
Date:   Thu, 3 Feb 2022 01:32:30 -0800
Message-ID: <20220203093232.572380-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203093232.572380-1-jhubbard@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a79b81bf-2afd-47bb-1aac-08d9e6f82c6c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2385:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB23855FFEE62D0AAD2D7895AFA8289@BL0PR12MB2385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lP3TGQ04xtPswJSl2EQnj9LnZaEBQr52PRAj3OQXnQaWrq8h6YK3hNhqAMPvPre+MXk8mWrpwyu26mWx9DbUKD06T5W8FNgJJL+ZW21AxV7MyHtSG00CexypCkEAIPoFk2FB7d29rrMGyBN8AU33lAbD5DhVxVsLkKsrxgpFeLfetpAcLG4cbDc4z+egFH1V4Y9klpIAkuEgVmh5al43pXhQTkDyJGZruECZNT7/ldKovg8j1NdOKakSylx+/px9TLCCF3g31AVAjnrQOiW6VP6vmNPD/V5Hh57JgOdzBvJyq4tp//V6RpeeUZZg8RV2fdoI/Hc0BJ3jNO2QxG6fk+ZB+ViUpAyg65tgFtYISslyrDoc9FIZttmZx0J7Q7PVLo1mfFgo64kCheqf/Dp8+tzu6Qaqx1Fq1Qhg2X8gFwYuJ2ISj8rxmw119Y+4OjB150DII/jV6wErKYO6GxQBXIA+ZnOYh1rp+xUFSmdz8L3OTclhoBSx2wE+fOiXVFJuw02TQQcIrHG3uUHyzVYZALP4QKT4npWqqnGKvn+VmwY48fyzpokEM7ojAiCEeDqFcAfYyd7InwUDNfc4AsmdaTYxeSmTn/15/vBsqYlFZuVKGnlZg2xKLL2V0NyO+sTruUlutArbaT2O0LHPnAqDg5S0Bnh6lgwR5mC9Xzz41PQdYPtF2t34uDmi/P9Q/noPQZMQAiMEAqVkjPgDY7oFwg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(54906003)(4326008)(8676002)(36860700001)(40460700003)(508600001)(47076005)(36756003)(83380400001)(26005)(70206006)(86362001)(110136005)(70586007)(426003)(107886003)(1076003)(2616005)(336012)(186003)(356005)(82310400004)(81166007)(316002)(7416002)(6666004)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 09:33:02.0102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79b81bf-2afd-47bb-1aac-08d9e6f82c6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2385
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of any FOLL_* flags, get_user_pages() and its variants should
handle PFN-only entries by stopping early, if the caller expected
**pages to be filled in.

This makes for a more reliable API, as compared to the previous approach
of skipping over such entries (and thus leaving them silently
unwritten).

Cc: Peter Xu <peterx@redhat.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 65575ae3602f..cad3f28492e3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -439,10 +439,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
-	/* No page to get reference */
-	if (flags & (FOLL_GET | FOLL_PIN))
-		return -EFAULT;
-
 	if (flags & FOLL_TOUCH) {
 		pte_t entry = *pte;
 
@@ -1180,8 +1176,13 @@ static long __get_user_pages(struct mm_struct *mm,
 		} else if (PTR_ERR(page) == -EEXIST) {
 			/*
 			 * Proper page table entry exists, but no corresponding
-			 * struct page.
+			 * struct page. If the caller expects **pages to be
+			 * filled in, bail out now, because that can't be done
+			 * for this page.
 			 */
+			if (pages)
+				goto out;
+
 			goto next_page;
 		} else if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
-- 
2.35.1

