Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50F44A3D37
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357701AbiAaFR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:17:59 -0500
Received: from mail-bn1nam07on2073.outbound.protection.outlook.com ([40.107.212.73]:22825
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230185AbiAaFR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:17:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+OciI1BuSx5XasxyycErc2LreWYx2BwZ8JNvNCUv7KCcEYxMyBm6pSyWqDy5smtYHey8FNq4raFu+Y95P5iJPtrD34gDDo7DKWMWkco2Nj0NXBb+mknmny8o5K9kZYdoxwvfMvvCGEQmS+vUNs3ov5nk08pZEYj4yVSa6hjhvN7ingBcreMbU5NqTIu/UD7GwZIZP2nA4hF5BrgOjwwHnQT6T3IJoqzAy8jTIx4m6AzMbdtp5QbDPHzF0vjwUufGJFoQwG5UL3WCpaD6ZgFjsbhXTFhnl/rWGKhxBmPPulkfN05JyMudTAAx/L4S4+WYP+EtYEmZUT1WH6o/BtzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9byx9sl0k994OaiaZa3X5PdM5tM/l2ZQYd7CkJD4zo=;
 b=XavBqYYAERrpXk+HaOQZFQAUdl204QJsTGYkDO5mgthTOaSVVkbzqvGqlkGWUsm8nlI57TrjekrIcAp2/tLDcE+MQQ0VKHHZAtQPWQe8xvvFyIgvC4UrsQhK7nOjEFU6iLmR4037KqR1/sH0NZZ2FVSygX656XEqqoslv+cOQzI3I7Fy4UliyF3WZ6SD8qpxocEgKdOghBXo2sZfphSAh2k8QDBdAsxGgrB6Q4UdAgHMF+ojawL2+FqABzOOOVe28jWxTgBSeBc84yYE0r6Eh/+nGLao/3VoEKQNWYMPDVQEvmi64jzrROXezbl6j9UulsZDp6Oh91YQgNP2iV61wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9byx9sl0k994OaiaZa3X5PdM5tM/l2ZQYd7CkJD4zo=;
 b=NbwnEqdXzZDo2SMPXCD2jsu2Jkv875iVhR7MNdIJbUUJknbSKH46+tPtWSkiwYKXrwqF1KBPImbe88Qy5JctDnfjxibrww1ar8YuEBSYPqc36mdzdvg5/Ytp+Qm+oYsXnlAaavK8TVz61BLyKwzkxvDRwScc2trPGCK09geC3dVg8t3n/5J9Fh4YEpDhdLfQ6SLMbAeuNGWYl6u8BIm9NwggReIn+SXF/I00UHVBLiYoVPJgWXGfgxICfGiXEsoPj5IFOGxDv+B7XnTJO/OikflxAfWk0D5veVuU5dZ45L/Bp5NmOJF/n+TN6nJ96hAyEqghs60K6n3LrO9rDkUEyg==
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 DM5PR12MB1609.namprd12.prod.outlook.com (2603:10b6:4:10::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.21; Mon, 31 Jan 2022 05:17:55 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::a7) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Mon, 31 Jan 2022 05:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 05:17:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 31 Jan 2022 05:17:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sun, 30 Jan 2022 21:17:53 -0800
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 30 Jan 2022 21:17:53 -0800
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
Subject: [PATCH 1/4] mm: Fix invalid page pointer returned with FOLL_PIN gups
Date:   Sun, 30 Jan 2022 21:17:49 -0800
Message-ID: <20220131051752.447699-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220131051752.447699-1-jhubbard@nvidia.com>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d31aa22-28cd-4fcf-8285-08d9e47909a8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1609:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1609F484C82A9488DEE01923A8259@DM5PR12MB1609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Oul+W9OedlhtS31kz09qqhDURaiqMBieCoygRcZTBy5++bMbAXuI9+twG9Ac/WH6VLrxyZMfJobiyNVrrXExrjBXJN/vAiUs4etnKK+vPe9YDoxob3AsEnt0hOX9m5IIM2v9x1fZy6i/xid5NIqZ95Zjv8ao8mf0C4V4l7EUfBrts071kZdO++A1lCK0IEqEsfC9EbgTzq074HuGCFEcmUbCPnDnGl1M6kGkh+DwyMSRvd5AekjhwH0RPKXHXTB1fS6SwJeLbq7JR0O/szjEJ0pPHEadN8N1IpbIGFHiHMnWu7Dj+CsTu8MIb3Mnyjy0PKL5WyUdvcniM6VMz+8tUDGZY5K3J/xT4kozASjzRR7IDfvQML1gFZcXfRzT1n6IBvxNe7udNPM5j7Vaifqf7uNOhO0gNeI3uaseE6rHXowMUgQEyIg+66n/ESQDs5M2xVCUujdSoO/fzodpSJvNVsUtqP2oIpC1KQG5L22ycV49tQGM430BmWHdnNTqAGNrb1a8lPcmxlFMwo2iwSGdjitVJvbZp0blVw74RpBSLj1j7HBGC84LMt2ee0q1+0fJapTGGEyQ6p1QiSPte3ga9BQ8lfqc0evKecnVEiHaINMU24wdnlmLNn/tS4U66e6dGE3zj6ABzeUJLSkJoHzsX1zk93HNEPcyG3/ldrsFXgXkBkTe4LY8uu/zEjoqDyRR6KFQgEWQqtr/9lAK4UiNw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(40460700003)(356005)(66574015)(6666004)(508600001)(2616005)(2906002)(1076003)(107886003)(7416002)(186003)(70586007)(86362001)(316002)(8936002)(4326008)(70206006)(336012)(83380400001)(36860700001)(81166007)(36756003)(110136005)(82310400004)(26005)(54906003)(8676002)(5660300002)(426003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 05:17:55.2443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d31aa22-28cd-4fcf-8285-08d9e47909a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1609
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
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Debugged-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
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
2.35.0

