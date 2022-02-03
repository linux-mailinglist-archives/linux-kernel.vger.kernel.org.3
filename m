Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8724A8189
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349743AbiBCJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:33:13 -0500
Received: from mail-mw2nam08on2081.outbound.protection.outlook.com ([40.107.101.81]:1953
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349723AbiBCJdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:33:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPjUADvL5qUdWvu1Pv6h5JKe16lxPFXv0xaGAS9aopaKc7CfzaAektbgFYP0fxGoHX/KWH1kJsfrbTDbX8AQu/KnBGBMBC9OovsIgNDm69G9KBPVHFsMkxvBs7N+coxF2yKT5WVUuP06aRohTMV8SokO65Z7zzvqkXukdhPSPhVxjgY2GJyHRAMTDQ6bAaIi3mJ2Tv9HA7AsG9dnZhna1bv76qyZ3Wj4xN72tZcZBzBmLcUrYkcEeC/02agekeHPUzQ59dl0OWiUH+0MDwPGk9FyJNxmO0Twsoxi56J9T4PQtzuLYHFQuGsADLyllUZTDerzxr1xMO2lHjF1kWce/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyMU6TmMl5wkPP3kDvsxlk2/mNsd6Nh//tpGH/3US8s=;
 b=VxIszikueq3ULkbIYCFg6gwbCrnUmbBfALpzMm3x0GaTPEN8dsD4a3gZFH/yt8e9TyKuRgtKu+BSvrvsF3uDWy0+9r7e7fPdB7WELQuKn4WQU1jWOaYgOKczPjoC3DxAsc2cVZONP5cAMImjo8TN4HTTcUBH6MW6SR18LgmBslAA0Z6LFtSSOCtyrr7yJHaJTcm39AuPbhlI5ev4hingzEcuc3ebYKLi/B1wbd86aH82LlTWRfJcMRA12vdNrlBCsFGxAaT0Bd6C0/ErwsNUURMAWCwscOKgMpvkWf+kUt27lWPeWXW/yOXK5xgdR1NjK9YRsN+X02UGnGOIYR/5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyMU6TmMl5wkPP3kDvsxlk2/mNsd6Nh//tpGH/3US8s=;
 b=hEAyOSxSRzunJyR7iHLjJsctksAZPqRW2sCdQobeERYuJ41OkbcGX/1znH24fC5t3oZ8gXJBAcdMV/DJ8nLlpZXOhQhnZhx5RnBeEhgJMubNg01ot9/bGizsHIrcAM85Y3lGGlmGuLgwW90VOTj8hSvJFmyBHl7RN31w/F61stAqTFhJWXFlwxw4Culn3m/krZV06vWnK+ZhMvUPOZFNY1HzJy7j2PfGOm+uqIup43c2tiV1KjCRELUA+RBVxoa+Z9fvJxEIPlOpAmufh7sDVeQRzs8q+ByOiSlqYcyx5lv7ZP5ces+apXRW60Twuh4ko7VytkefEcemm3rpo40sHA==
Received: from DM6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:5:1b3::16)
 by MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 09:33:01 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::3d) by DM6PR17CA0003.outlook.office365.com
 (2603:10b6:5:1b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 09:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 09:33:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 3 Feb
 2022 09:33:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 01:32:59 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 01:32:59 -0800
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 1/4] mm: Fix invalid page pointer returned with FOLL_PIN gups
Date:   Thu, 3 Feb 2022 01:32:29 -0800
Message-ID: <20220203093232.572380-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203093232.572380-1-jhubbard@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ab1d80-9787-4556-fd71-08d9e6f82bc9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3376:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3376461CBA36BACE79385ECFA8289@MN2PR12MB3376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzCauIr0ABToq4YvJl6Q5PisKRQMjeOQm6zU0NXx3xYS1k6LCMvoMe+bZUIQuioaFtTeF/5fOWxklom7iF1w8qkaZ4WpvpcD/Qk3Kr7heohClVE2C2Ka17O8+Zpefp+H9XAqmz5Sq1pv70+BHW7IMhRzOAq+zknYk9TjMZ/Ysaq2WNW2uc/f0bEZ9IB2soTYejKyvHGOXFr9NSIpuXN1DGCTxZuXjB9gtmqSPmt8DojPREVIqnAvaYfXNJKFuBZGtf9BO9fnpeYpA/tftlTDXTgkzlzuwYoTcA+09I1+U34z+p3LxkzGgWqxE8RFGdXs1jawndpeXq1m56DaczeeqR153g9jgxxru6UVnpSiXh2SYGSONj68RLxmJuw+iu3OX0K+0u2EHEclPWaqL4QhlcT249YxiQLA8uJ7uxbT9RhuUXUHfUUYYxiI/D5CQwnuaO5QZAaf3HNz210C4uoD5KsAz6zxIGXqpn7k//JpBnJeKxkG4MP78u0XiA3e7d8PXKrO6QxmXFnWN90KuTCofXyvSuhSKC6unfFYOoyFMvqSGMa5+tECsLk2ZEhNpmbQQNNqpCCmDQ33rGXUtCdC+DRE1Ore9fGjUdy3LwUTp12svOG/aJi9fX7Ggd+B1LsII3eA5N6BE9aiqH3tGEWejUv7XBvBZezn09+L7/m6FvIwyGS9A1UApW6VUf8OlnWBm/zp4NCjzufKBrKRdU4wiQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(508600001)(426003)(336012)(36860700001)(86362001)(110136005)(316002)(47076005)(40460700003)(36756003)(5660300002)(8936002)(8676002)(6666004)(26005)(70206006)(70586007)(83380400001)(1076003)(186003)(82310400004)(2616005)(2906002)(7416002)(4326008)(81166007)(356005)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 09:33:00.9321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ab1d80-9787-4556-fd71-08d9e6f82bc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3376
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

