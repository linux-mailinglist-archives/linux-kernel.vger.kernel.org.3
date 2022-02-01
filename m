Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B904A59AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiBAKLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:11:31 -0500
Received: from mail-bn1nam07on2075.outbound.protection.outlook.com ([40.107.212.75]:23521
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236355AbiBAKLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:11:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGvDE4pprtXXtnvG5HtB5fg7s5V8Yp/AOEOwUgNgh6MPRwboLKbzolZSppyOniedocMG8kSz8tjtjx20pPYilSo94Vaxleptx30BSOZNuvB4rPkHHTRCpg4yVHftz1o7APBZn7BvAK0WjC/nuAlR6ek2zQyqF/Cm6WzVlvabZbEDTiYemVoRV+8o4HW/3hnGymrNGSg0YAZGKjSbSCHyIGq4zhUitMEBCBgJXxxexFLp1rNo82e2/4bcs8C9JwG+NvCm3WRW1BcLF04QNQ9ul/1l4yvwVffhBnoo2F7Kb1Nj+dHKy3XKnP/KpKwJFtSDgOI5iprU8U0wczStypM5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImU9JElfSTWSoTAyJBE5pMoIuGpDo/2NrB8B1A9HU6A=;
 b=MrJgt4zH06DhtFJvfFusNrai7bp3Q3dI555Cwsx+FJua3e9ZyynvaVfLKPUVaZGBUnh+ytQpigBTXoMEX5Uq38WBmxQW/5JNlwEDmRkxw9KuuJcr7WFmysv8xDhj6D72nCuqN2NIL2w5bkfSbXD1efgaB5gxDJ0dxar8alVhIXK2MpGCcDLfhkpAjDGhiTkLUhPhdjm4gvg2r1nNl16oB81D+HSotL4bVix7BBxw6LDxI7hUn5RqKt1FV9uV3FdCyyrXNk/t6R1IAM3s9KIl/MARQsFo8l71L/zudrAWHx7CwZo/q4XHeXoMCd9a56T0yEK1YRyJjPJEsRWYsRS/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImU9JElfSTWSoTAyJBE5pMoIuGpDo/2NrB8B1A9HU6A=;
 b=gdATogZbpHduYjNjUpe4nHgQc27DwfflDV1I/AADet0kpB/Ax5gJ/tiRlfXtCO9agQxnBQtmcmz5wNJkoZa9fUKhSlKkQweZ8eyZl2vwEaT7cNxAqfQdLEtOrpGKyLCBtHktuw36sow0Vc7JIc60UAo6n6czVbR6Be9Iu63i4sd2r6FtU3WGavmCys5WF5OVeiKsZgWJVXsPwHAaKKMcMcSclm4khp+iPWjYQxwit1mrHEadAeXAY7HzXiKU6Q/XQpvfEWzK6Sn4xrb95PRisWWm+an+MeaUIAA1QvmfRMfqxRAfxKZfd00hNnST79m0gJX2vpakZRO1QuAUFD4kYg==
Received: from DM5PR07CA0150.namprd07.prod.outlook.com (2603:10b6:3:ee::16) by
 PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.11; Tue, 1 Feb 2022 10:11:20 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::d0) by DM5PR07CA0150.outlook.office365.com
 (2603:10b6:3:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 10:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 10:11:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 10:11:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 02:11:11 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 02:11:11 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/4] mm/gup: clean up follow_pfn_pte() slightly
Date:   Tue, 1 Feb 2022 02:11:06 -0800
Message-ID: <20220201101108.306062-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220201101108.306062-1-jhubbard@nvidia.com>
References: <20220201101108.306062-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a0d12b9-23c4-492f-4609-08d9e56b30d1
X-MS-TrafficTypeDiagnostic: PH0PR12MB5465:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54653199EC4ECB8F0E1D51ADA8269@PH0PR12MB5465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5xyQ9AB0cFXcO1q4b9tkLRQe74Wai3d9giYgPkRiqMDJzPvQUiC6jtuBqSDMbitep8LvZXxqCcWg8FPfo1obBYK5sE+A2D49dQ4cP1glNo9qqwe1lCPgWZwzf6BHG18P275jLctq+xELk38Jm9ZdV4QmStSQWSLPv6HgEgu325iM+WDML59jqnmoEPZ7KdDeMgA+CKSHnqBKR5eY4t5WdIiy1r8PtlNMVXJFy9UFAm2wgo3dIXIVpsUC6gNQd/qnk0KFtQmuloXSgV63ovpQIKN6e3v97V8xrue2weqt2N2vv4O4xfjew0/aTav29hku6mxTUo7ZdMjw0hCPK0rnf4JNPa51kgFjD9+BQrBYW+pjQhd9/iKoLueRV1yfbvAaHzcv/3PVC458Q+P75XSOEAHpKhDk5F1AhNPlZTZb1DbzS5UzJgTkxMdouOkCzpoAcGeLHUMGnzaqcY+M3b+Fx7GI5nISZSjvIfmNS9a3ZvSlg0uPKanSN9xRHeFBGbG4Dxnb3VJlwNH8QgkxKQK9O73txPbJhO4mxhF4qJMCQQHq3Go2n5dyrOMPOw98iBJwyFD+RsLlTs3bj8tn5+kv9L58OcPlknI2WPHdk4q5QN3jUyaad+yyNhjJCtfHRoTK/gAY1YVPWLkWMeg3+iqt1WvyWWIrGsiStcDDYT9erNkUNP8ChEcHNuH+5eQpk+4uuwj1kQ0MR7OWKxiPKtoWA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(83380400001)(26005)(316002)(36756003)(110136005)(81166007)(186003)(1076003)(54906003)(7416002)(6666004)(107886003)(8936002)(5660300002)(2616005)(8676002)(2906002)(70586007)(70206006)(4326008)(47076005)(40460700003)(508600001)(336012)(426003)(36860700001)(86362001)(82310400004)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 10:11:19.1512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0d12b9-23c4-492f-4609-08d9e56b30d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 65575ae3602f..8633bca12eab 100644
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
 
@@ -1180,8 +1176,14 @@ static long __get_user_pages(struct mm_struct *mm,
 		} else if (PTR_ERR(page) == -EEXIST) {
 			/*
 			 * Proper page table entry exists, but no corresponding
-			 * struct page.
+			 * struct page. If the caller expects **pages to be
+			 * filled in, bail out now, because that can't be done
+			 * for this page.
 			 */
+			if (pages) {
+				page = ERR_PTR(-EFAULT);
+				goto out;
+			}
 			goto next_page;
 		} else if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
-- 
2.35.1

