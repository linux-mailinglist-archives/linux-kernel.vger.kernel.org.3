Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A2A4A922B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356573AbiBDCAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:00:25 -0500
Received: from mail-bn8nam08on2042.outbound.protection.outlook.com ([40.107.100.42]:39097
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352178AbiBDCAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:00:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo1E4zRyweH1vXjlCsHVuOg9VE6xAUD2dvxzqdCZzf1QrUWbqfrVT+N+niUdNLV66DhiWuI36Eo0dJ2cAqeEKdhtM5Bn6PTVfkS3yNpRXEyqS3aWGqThutywmcfFWaXSQGzdrCaZILvR0jHqnFkMtMjQo3rDp0PwbJNrzTd1bzoPXx865wjZ01Gg84IC+5ZgPzbj2IDIGE1tJ1Xh6TX3vFRa8Az99oFrC7TdnvYPZO9KUHTmX292DYBWBPxUaIlw10+kUpWc6T9UYUKU33XHLVBj07gKP3vkkKdK2rdawakatl7Pn8wugMVlddfPPtVoztFh8rc/OdA7lADyADWgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt9FML4BvPljKe8LmT7vBY3GhnKo58zxY3NZZD4vJkw=;
 b=h4U/Ds9k4jU22p72+WPatC0BP0g0EQ86nmCYzl8i4cBeCJ1CSm4Nc6PliXT67GyqN8QWfAFLb2HkXx9QWNUGnBTqsGMfuak2TF/GX5FIKa1NcI7wO/GJSFvcpA8Q34to9v4fFxkUFqpakpy+dA4y6Q6ExNSYQk4AW3dNiKhOR6E/Xooq6y2M3J9oZR1K+9Iyc2jfeE5oOqE4kH4UF1ePq3rMgXeXSck0C9Bah9BVwYOdpazrcIGIK5+K4JDrmhTZkKgXd6XrKWveBOPajfd3/UHEjBPfE8NCT/QX8hzWdQxRZD/l8fcCtONYiI2zewxhMbB5Qt9d/b3mO1IvHBVBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt9FML4BvPljKe8LmT7vBY3GhnKo58zxY3NZZD4vJkw=;
 b=JBO0tt0Ls9wnGBFx5uGnfL/ETVqPnq3eS/BicOxqZbW3oOAXXI0i6P5ihy955TF16TFgYaCWVkQDYHd3u65rrICY0iUcri2fU/0YBj/KV0jvEaH4kt+VjxupZKP3FeXfj23ueahnVw+xhvbdQ+FxJ1E7mCjoLBLIenFJTT/pdK3i0RLKe/byRt35mKUQFhH+lpkl6eg25I600f9Y4V2QmEj2qtFemmAjdwreg9k12QvsQSlMLLApqXMTf5n345c6lhMz3AV8dH8EAsVnYbVgSSrhHBs9v6/Qy8Q6S5P0dD/exmFR4RRYyfj+8b7VXaQrUzRcTS060Y1V3cTBAHZuwA==
Received: from MW4PR03CA0209.namprd03.prod.outlook.com (2603:10b6:303:b8::34)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 02:00:17 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::d) by MW4PR03CA0209.outlook.office365.com
 (2603:10b6:303:b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Fri, 4 Feb 2022 02:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 02:00:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 02:00:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 18:00:12 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 18:00:12 -0800
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 1/5] mm: Fix invalid page pointer returned with FOLL_PIN gups
Date:   Thu, 3 Feb 2022 18:00:06 -0800
Message-ID: <20220204020010.68930-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220204020010.68930-1-jhubbard@nvidia.com>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4df8db0e-5082-4d73-6c2b-08d9e7821765
X-MS-TrafficTypeDiagnostic: CH0PR12MB5027:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50278142D9C4741AA40CBE24A8299@CH0PR12MB5027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4EP6O26CM7HfDvyDQpMZw1da0aJSenmzqLv2EQYBQbSAg4SBgDZ6fdidmaSJ8KyvojrZGmx1/d+5eX29ehRCOAJRnYtCLtDe0RzGqTdFIs0Ja8qvHeyMG9MAHOZLNzSwzHQSAiqRsragbFmNXS25fMz812IwFt6Hs9Lxya7BEHXvqaxW3k41jeYNCilF7m6VzdBP+YH0vr2oSwzFQ8hMt7/r4wyMMZiCWEwJzlW6P0zPuwSXWeO9581pSXr2akOI3u+ZM46iVy1q6ydDRzMadshau7AcZRgP5ZYgP0Iawv8uHrBZ8HPmaVj3O6eaPv4N2i8NWm8WSMUokSr9YFwbCZVucTxdl3k4JC2cU88emwpB9hXSqUMAiZJxyl/ivb/JhQQYxbWBfjUrQqIp36GvJ+KKKWo7axHsC0AvjnPVi58CZOvx8y7LaFJYeXN40HZPKsY6mrcGX3elfY1ZsEs1MCgqt4kpdgdVN4e81pTBdpG6E/rGEULkPnUV8Kuh0Hx6I+JWFFYMfF6xjSi7pHSLPyxbI18K+8JKrl03vj8f7L37b1ceyCzYSIA0s4hmiSigouUql/PV6z5G8jhXkXHBVMmdtO5w27jnfiBA7HUCUYn/eHyfc/FhBPW40a0KoqgNTd2LV4pBAB5jsHWDeQt8f1aFnVnkapYxK95PQv2XobfLrkuysGYgiL3KbYz9CHJlDQC3uKZZN7INlbcaXCX2w==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(81166007)(5660300002)(356005)(6666004)(86362001)(82310400004)(2906002)(8936002)(4326008)(47076005)(40460700003)(110136005)(54906003)(336012)(426003)(83380400001)(186003)(26005)(1076003)(70206006)(8676002)(70586007)(36860700001)(107886003)(316002)(7416002)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 02:00:17.2829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df8db0e-5082-4d73-6c2b-08d9e7821765
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Alex reported invalid page pointer returned with pin_user_pages_remote() from
vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
pinning with struct vfio_batch").

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
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Debugged-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
[jhubbard: added some tags, removed a reference to an out of tree module.]
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index a9d4d724aef7..80229ecf0114 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -465,7 +465,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
 	/* No page to get reference */
-	if (flags & FOLL_GET)
+	if (flags & (FOLL_GET | FOLL_PIN))
 		return -EFAULT;
 
 	if (flags & FOLL_TOUCH) {
-- 
2.35.1

