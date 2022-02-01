Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A44A59AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiBAKLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:11:24 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:49472
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236321AbiBAKLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:11:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OahcomE6jhL9fbEQ3QRtJxiMBaTGaraJyw2EZQ3eC703yAjjN6nQrZNjO001iQBL1d7BYmNA3uCS8Dgr3ZmyxvH/eRHBSWXNb0pQQTXs5gXb1YJmlw10g/PtPAfcGFBDMC5y9qUYrWpbGmEAngRcL7iZIU2lhFaMnk2B32j72tDX2VFQ9HiHS31VTh0ihlfj/LzoP802Ep+celFp5KxIs2O+5TB1Kmfv3tuyewQu20MraWMYE75GYS1wRC8yUgcwkU4hu7Ov2WVbVsM99ALnGE+avKsUFzRcS3d4tHuvxdvI58PKQY1HMpGWIYwYV8WdLrpCMqdMXEvjWnL9dpyhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyMU6TmMl5wkPP3kDvsxlk2/mNsd6Nh//tpGH/3US8s=;
 b=Jw7DhTbHHPLEoRzc0qzHZqVoHbJ40WgW4hk2q1yxeutd5rS2d2HSpxbkSDZk6tmSf8BW5zX7h85a7EJXB4PpcwlyKRdMNzgs4nf8pe5rmwfegE/czc8VBdTZUz+PaTw5k7vR4zj2cC6lGR2jpXdcvKXI6XIdhJhSO9LPGZuz2Ppd+BtBAn+95vRaTxUk/PGRBLRouMRadZGpoHEUEYZKoXCbnT3mcblly3cJmvxe1dGNRmCzVHClVeLWPR47YPX1D4pR+JPxP4/XmXZJIg9SvweN/8VLQSDy2o4y64mn6dXaYHNsz+uQs100/8f6uibXheuPM6dd3JycMtL6CuT6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyMU6TmMl5wkPP3kDvsxlk2/mNsd6Nh//tpGH/3US8s=;
 b=plccGIfPQRa+v2hy6IQh1Oe+PnNCINzKql1DTJoZRYeWfkRYdHtZj26AQP+8GaNswJEsjEGM1LpdeLA7xQMd3sXmNYvy7nK4FKau5NIyxmAQpPYDyR+cWBv6cTyYYNpxfrxuOJm3VKfH3vDlmD5fTjdajL5QcjARp8IviuKSOFLHXGSTAxnzayda41cdeA33LAxwd6W//F0QbHQ8+A4fQBjeKkF9l52wPMyEQPkEYAzH90D0uQfs6Hp3PHrR19K5JR74Yx8oNP/f4nLlvy7uwfq2a9zL2DKZDvczrV5z/aWQxdMp0NStO9AjugR+LzXi8IBXNyS5J1MbPBfqlhpQkQ==
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by DM5PR12MB1803.namprd12.prod.outlook.com (2603:10b6:3:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Tue, 1 Feb
 2022 10:11:13 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::21) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Tue, 1 Feb 2022 10:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 10:11:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 10:11:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 02:11:10 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 02:11:10 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/4] mm: Fix invalid page pointer returned with FOLL_PIN gups
Date:   Tue, 1 Feb 2022 02:11:05 -0800
Message-ID: <20220201101108.306062-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220201101108.306062-1-jhubbard@nvidia.com>
References: <20220201101108.306062-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a7d000-7709-425d-5290-08d9e56b2d25
X-MS-TrafficTypeDiagnostic: DM5PR12MB1803:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1803C02FF333ADC29E631164A8269@DM5PR12MB1803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QbbfltBK0JFcjnciCnUmsT3OFeRAmP3ozB8AetX8iEVI4K7qUfMZaTcRRDuUS7Pyq6NsVkKIfDuY3o+eL7KQy18q80lH8gLmyuiCp8lO9vFB9cZQHg4q6UDkmd28CSiJvQL56JWqwsWTI9im0OlQYandOcXQh2EUdG0JM0hqcMpn+MqqHgKkEni2ymRofXG7F2cdrzm1n5BPffz6jcSXzNo9cj1ZFsJiQYOBTZSE1zvBr5s1rqOIYllseAGP96Uqg3GeFN8iFEznTqZBWoiUZ8bH4hdeI2eGlVA0VLqc2dlixi5xdDSa31jX7VSYmKrn3U3TmZBAFcxeA2bw4HHs3ZtQSvZgpJx0YyZUjOG59ANm+/55AI92s+5gFTg2k71u2ULzqWwTUaujrOqYb5UnhiWmp4fcRihWrQKn6OqhwOyYAIyBVzxYUmOJC3HYfhFocESnzg8PnGqm/teTQ9EQBwfIXWdLYkwQHEMEYalb6GgoUUC8jahaMPMgfmU8PTOPXZLzJoqc15wUUnlQqMCmTdN9PnW+X1Pio9ebYSNWu5XER9BuUv6Hu2cRFEggYhB9iaNK4b5A5uIuDB3hC4sO5Sd6cPIsWZ3DxDGaothzx1jV3u6r8wGsVdmkjgBdIQEgn6QuBWixtEatJe/idfpbtDf535LZRwVXSpm7z3VqtmfxRmmzVN2mBaw3hzFoDl3Q0ok/F9eKop8fuYRNm2SZA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(54906003)(83380400001)(426003)(2616005)(82310400004)(110136005)(2906002)(186003)(1076003)(26005)(336012)(316002)(8676002)(107886003)(8936002)(5660300002)(36860700001)(40460700003)(6666004)(36756003)(7416002)(508600001)(86362001)(81166007)(70206006)(356005)(70586007)(47076005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 10:11:13.0067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a7d000-7709-425d-5290-08d9e56b2d25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1803
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Alex reported invalid page pointer returned with pin_user_pages_remote() from
vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
pinning with struct vfio_batch").  This problem breaks NVIDIA vfio mdev.

It turns out that it's not the fault of the vfio commit; however after vfio
switches to a full page buffer to store the page pointers it starts to expose
the problem easier.

The problem is for VM_PFNMAP vmas we should normally fail with an -EFAULT then
vfio will carry on to handle the MMIO regions.  However when the bug triggered,
follow_page_mask() returned -EEXIST for such a page, which will jump over the
current page, leaving that entry in **pages untouched.  However the caller is
not aware of it, hence the caller will reference the page as usual even if the
pointer data can be anything.

We had that -EEXIST logic since commit 1027e4436b6a ("mm: make GUP handle pfn
mapping unless FOLL_GET is requested") which seems very reasonable.  It could
be that when we reworked GUP with FOLL_PIN we could have overlooked that
special path in commit 3faa52c03f44 ("mm/gup: track FOLL_PIN pages"), even if
that commit rightfully touched up follow_devmap_pud() on checking FOLL_PIN when
it needs to return an -EEXIST.

Attaching the Fixes to the FOLL_PIN rework commit, as it happened later than
1027e4436b6a.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Debugged-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..65575ae3602f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
 	/* No page to get reference */
-	if (flags & FOLL_GET)
+	if (flags & (FOLL_GET | FOLL_PIN))
 		return -EFAULT;
 
 	if (flags & FOLL_TOUCH) {
-- 
2.35.1

