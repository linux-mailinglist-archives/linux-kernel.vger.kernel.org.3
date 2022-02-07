Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4064AB504
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348359AbiBGGgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbiBGGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:22:37 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1940C043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:22:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dP9KxJMqfJhsx3J/YlU+Y+hb2KH3WUExWVKfGi/EK7DP9D03yZVPUSu9vnLHUc9qgKlcN4/wl/O188h+j4wMov3BNq9cwhEWarBEVdFVho1mNlfV64dtNxjpacHour7ondkMpVMCSR/5nMLZ0oNa3rZuV8BG1ONPp8ZIgPSfyM73UJg50GPhjLOsv5URDFSUrdqIiaYTl0ROvwe7PQwWbZcUPBfS1LHN1OS4TXr1kp1LmyZPVKkXK4AXgpE7zJkF/VfNWlrAn9lPXbsgWMISKPMDZ4u9bm+Skl+o9y9lEpX/7W8y2cQgL9oidTqMcNuDYnCM0nWoCV0x3tpFXZ8mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fyvjXSGsf7r6O7bQli9gyuzn1Mg9QRkvlBMVFHTNH4=;
 b=KMKMp/9oPutzcFyI+iYLaDNI1MYoMFoek5sdVpj7ByZ3KM5ZSrcNLZQ0iISn/VrKa2bKWHZhfHJp59CVT5SH0CWVn2yglg5kbDsdrjko4gfrUvM3Zx/UJuMtnCOI3pOwD+sjCDqh1ZvIwVAoFJ1DoocIea9daq6+/N0k9woHMTrgPBQYmP4rMbBTx4JL14ZnB2/8Ff8I9qOgxR7Hkimas6CUQB0fgnN7y4O2jN4ZWDRzFMEVjJB1tTkUh4rtd1CmHDTlTYJQKmgxbv01GIMIYVYJ7Xo4TlYpp7YYApcvQ9VGydUxqmPXAjh4fPwFTC4vxdxOtePWnVkYBGFTrZGTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fyvjXSGsf7r6O7bQli9gyuzn1Mg9QRkvlBMVFHTNH4=;
 b=ceZK/HX+QT1jRMU7fNU71rXWhKPMZb0mfoxHiO9MYcC0cnTj/mHFRNcoxxkwMxB6vKOpMbirmO7+gTeHLUKl/oBmnyru4VDY4z4Gx66YF5Mgy7mOy8KT4WULEGsDoZ59lujwbGVw5er8KaC9qAzi0pWk7FntHxm5S1FNxpF2igLXEW76XoY1+wEKgw/IDC/YtIY9ZDxdmPlnX/rLGFNGK+QslknpVFyyg0uoGZdhNZm8K5R3AMv002tr2keCPkBQg2vGy4JtdeKBZ8ORYyWWkyJxpCHKDsm7hHfVthWS7FAj0JhOUqFs+aYUFQEsnLn+r37YbnNpG2yD3aPeOr94Jw==
Received: from DS7PR03CA0173.namprd03.prod.outlook.com (2603:10b6:5:3b2::28)
 by MN2PR12MB3167.namprd12.prod.outlook.com (2603:10b6:208:a9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 06:22:35 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::f5) by DS7PR03CA0173.outlook.office365.com
 (2603:10b6:5:3b2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 06:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 06:22:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 06:22:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sun, 6 Feb 2022
 22:22:33 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 6 Feb 2022 22:22:33 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 2/5] mm/gup: follow_pfn_pte(): -EEXIST cleanup
Date:   Sun, 6 Feb 2022 22:22:10 -0800
Message-ID: <20220207062213.235127-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207062213.235127-1-jhubbard@nvidia.com>
References: <20220207062213.235127-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1f2101-2dcf-4f28-02f6-08d9ea023ae1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3167:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3167D6508B1E547BCFF7620CA82C9@MN2PR12MB3167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj13Xrj8Pb7067NwzsEMzD6MEtlJp7KcwI613pjefclB8gXZM/PmrF96KHrUm3XSwKFDZ7YPioCzye4L+ZR8A2mtukfbYoZOCTkXOkYZPBl1EQLizH/+glJTFATHb3Vtn9r4A2A8p3XAM3SojbMjJlaKOVaTVRYGJpNODt6P/z+B3BQlQIBPGgl0EjASndOxcVTlCggKNz8mp9zLOKo/MlQGEZ6Mt1ALIz/an+dgQjVMfpxv0f6D06fgfa229D7+UiMFJVezSsaU1rY4NM+wF8u+IhnuV1IxZ0wSYL75q2evrDAsimIP2u9e1kwXxUMtmf9zLW8l4979to3yBV7VqH1mX4Gms4lC5hp9HWTMOpNhpltG0JXCPwXpUovUwG4xyEvswVKOxxLDZWvXLgexSIhIHz0lwoAun0Wc8cJNMRWg3s5Sxh/rS/xNxCHWg6SaI3lGxKO1X0f2vs7sA1qRLhT5UKRQiU/EHNlIzIiZvEOMNuatVZlUM+pHE44Nc7JU/zIzL+N2CV+UEOaFRDrpsmrwa8nRgRdOZNK4sV58shZwnUJJiLUbVJDx5dplGIZ8Fjw5gg47P0JCrOJrghB5iCOy6YF+OOMOGnMf5DFcf+BMU8b3fYiW2dRIC1MW5HvbL13z1tI05gm9ci168B+tmf0OAc/vM6Z93PJcetj5CVvBfLvO6aDGi/qRa5Ws1k1YCyU/Y3V4tK9N5HXbBNN8gw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(86362001)(2906002)(70586007)(82310400004)(8936002)(70206006)(356005)(4326008)(81166007)(7416002)(508600001)(107886003)(1076003)(2616005)(83380400001)(6666004)(110136005)(36756003)(26005)(186003)(54906003)(316002)(40460700003)(426003)(36860700001)(336012)(47076005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:22:34.7044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1f2101-2dcf-4f28-02f6-08d9ea023ae1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3167
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a quirky special case from follow_pfn_pte(), and adjust its
callers to match. Caller changes include:

__get_user_pages(): Regardless of any FOLL_* flags, get_user_pages() and
its variants should handle PFN-only entries by stopping early, if the
caller expected **pages to be filled in. This makes for a more reliable
API, as compared to the previous approach of skipping over such entries
(and thus leaving them silently unwritten).

move_pages(): squash the -EEXIST error return from follow_page() into
-EFAULT, because -EFAULT is listed in the man page, whereas -EEXIST is
not.

Cc: Peter Xu <peterx@redhat.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c     | 13 ++++++++-----
 mm/migrate.c |  7 +++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 80229ecf0114..2df0d0103c43 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -464,10 +464,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
-	/* No page to get reference */
-	if (flags & (FOLL_GET | FOLL_PIN))
-		return -EFAULT;
-
 	if (flags & FOLL_TOUCH) {
 		pte_t entry = *pte;
 
@@ -1205,8 +1201,15 @@ static long __get_user_pages(struct mm_struct *mm,
 		} else if (PTR_ERR(page) == -EEXIST) {
 			/*
 			 * Proper page table entry exists, but no corresponding
-			 * struct page.
+			 * struct page. If the caller expects **pages to be
+			 * filled in, bail out now, because that can't be done
+			 * for this page.
 			 */
+			if (pages) {
+				ret = PTR_ERR(page);
+				goto out;
+			}
+
 			goto next_page;
 		} else if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..be0d5ae36dc1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1761,6 +1761,13 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			continue;
 		}
 
+		/*
+		 * The move_pages() man page does not have an -EEXIST choice, so
+		 * use -EFAULT instead.
+		 */
+		if (err == -EEXIST)
+			err = -EFAULT;
+
 		/*
 		 * If the page is already on the target node (!err), store the
 		 * node, otherwise, store the err.
-- 
2.35.1

