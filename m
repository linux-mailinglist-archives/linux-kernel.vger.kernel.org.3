Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61044A3D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357753AbiAaFSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:18:15 -0500
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:51744
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357710AbiAaFSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:18:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOpzvs8yBaMidb/quJNuERyw/E2sH4FNu1cCmo0gafWqnZEmBC/rRFx6/kggLByhwABOSUCuzLLnEzDMQVMX8GBItylfWH3AkUw0XY9MpZICEBfBcmmKfplxjRbfnGLJaYzsvJ2OCbe2LlVzNxmOoTUvK/KxY0aC4sJdi3xIF5vKQ4bZ91K4gkWbBZ1CUsP6XH9Ob+oxZyKIYfe7iv0100N1Ws0KdLxkfixJAKKJbuFEXm48nvWjB9Qfwg/r0chutb8TE7n0P8HAllyxXOmLk+DHJo69dG8Nz91ECbXTNVdq8TncRi/Ud8VlinDJ30n3vSuChx+Ct2GYfy2g7mjC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7xQ7coTmXR1ejOtu/2zz56yYo0Rs9naSy458p5QBjU=;
 b=P/Byc2XoiAkmd5a94bdNpuAqksI1bTlakXWoBxe5Yuizb0e5FyTYVyAWawjMzcQmE4auy+IDB+ZhOuUNwvaxztuY+Orrxoe4NCo/ZF+2X0mo2m713qSBI+1xIc0zOaq7az/aB2PXWhQMo8PT5re3XUmkkgj6n2Hc8LZGiVMX2MTMyxvw6RwklwCWpIoBIwO4HM/+yDNACsK2FH2zOB21WkLlmZ1yAHNIGb/o8NbMW8PFZAQCwBS6yxBoQegK7A/oZpS7CPN/0HRraG7bH4y6X67IyStHsnpABGYlYlg0sR8sXoXY2tuHjnkuhQfpJ6nZ//meCgN8yeJLWkIpVLGIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7xQ7coTmXR1ejOtu/2zz56yYo0Rs9naSy458p5QBjU=;
 b=Y40rHM0ayuxmsyhoe3Cw+pyW7aV0KOW3rX0Xz+my7stDsqLsn5Kcq/nb0Bc2UIGHhyzj9OJImYyDjiTWxFFmQEYgY+ErM3yF3x0mK+TWcAhEjejtp/IIBvYFs4tsh1LR0dzOcUtb9vMVaM1+Y+OgB4WMeSdezqAtWW6GCSF2WRXr20vZ8+UiD1Rpd/wVILUAmbjhnv+XBwAM2KtljZHIBCvOPSfM4ThymnIVbWC7IaFmARWX414m2qd8wlTw3o74jM62dxkr2FvG1mM+6/jqfZkpyR4uzGfe+TRKCVlIzfaA6/5Q9ONLot3q1nueG7GMH9XlZW4IWmkp8cpv6d7Dhw==
Received: from BN6PR1401CA0023.namprd14.prod.outlook.com
 (2603:10b6:405:4b::33) by BN8PR12MB3537.namprd12.prod.outlook.com
 (2603:10b6:408:6d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 05:17:59 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::2f) by BN6PR1401CA0023.outlook.office365.com
 (2603:10b6:405:4b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Mon, 31 Jan 2022 05:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 05:17:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 31 Jan 2022 05:17:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sun, 30 Jan 2022 21:17:54 -0800
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 30 Jan 2022 21:17:54 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jan Kara <jack@suse.cz>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/4] mm/gup: clean up follow_pfn_pte() slightly
Date:   Sun, 30 Jan 2022 21:17:50 -0800
Message-ID: <20220131051752.447699-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220131051752.447699-1-jhubbard@nvidia.com>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41b0f511-fe5a-4557-0024-08d9e4790c1b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3537:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB35379AEEE547684CD9D7CB87A8259@BN8PR12MB3537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RBG7HNrhcYeEjPxUMsFwTImecF/ZMl603mDrx0F2PkNkAiBbX5A0E1DgtAFykPXQM370bvgzHD+n1vS5OoriONkonlmnp7pqBu9zsohe2t5Gz7BMTBQuGgp7BmVdMpe24gvpQEqJpYyu+QJx8ksB/xnedcgFl1WvJxC3rGxCAcWV5LSgb9ZVHli85van0dTfCa2OZfeQgfILZBYSbfQWyIyZyG9NC8lztOEeeonHY+X1qt9s5Y/MAjwRiYNXIO7lM5800qPVevP2xnbNnW18eo7efVJzESHWTvYmkw1sERPjkG/eC1XWnFS4x9+JVp8V0ma9dybR3mojUR8lmoTU3DnlSPuMN9bRcj+GPMAVAP3H9vApOIq+YXUQoi0GeUHhrQ2aA2YRW/24gn08AZs8DTgXygVfOxastqIW4sQ8b7D544SQtM2Z8gIIoys9Ak/sYOPIxjSeKsfirY02pTxhu1ZJHbYp+kBHjBZunHAxGy5KX1mVNtg59oS426KcKuLULTHzKrUWcceWaYuc9CbBwsFP2ijX/nLCBgIEjImXwz9MIJ5npNLCJfgutTWLtwtBw/DthGip3msLDpl0BzLju9U1hClmnRL2JnBKT6uykVqIywe0dpkmI1Md6LFwKowuCGHCGjhFcep/zqJQmND9ih4I97VWLa/7J7N9vXQeb4zmdlXTWPt0IeNdWW3tddhBqZXHEgHCQT3jLX7csNbdA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7416002)(5660300002)(1076003)(186003)(26005)(83380400001)(336012)(36860700001)(82310400004)(2616005)(2906002)(107886003)(426003)(47076005)(86362001)(316002)(40460700003)(110136005)(54906003)(508600001)(4326008)(356005)(6666004)(36756003)(70586007)(70206006)(81166007)(8936002)(8676002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 05:17:59.3189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b0f511-fe5a-4557-0024-08d9e4790c1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3537
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
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
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
2.35.0

