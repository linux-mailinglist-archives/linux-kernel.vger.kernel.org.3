Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F24A59AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiBAKLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:11:22 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:12385
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236310AbiBAKLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:11:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVnnAb/Zcz8tdIPHy4ue5t10WGFIzSZNpJ4azCET/hZcumXAklLRwYZQqgZp+TyUm5IkyVckBMiSvLNJRpH/+2ir/ISGq6wdtX8QIt8DCLjMMyaKCtB6v4WYlHOvcdZa2GME7VpOtSx/GveCNo/S+rJZl2+lf1xs13UELrW5HfWZhmsaO0EXqD4hTe+2Xq0QCkIolEYYvHhX2lncBZux/FIrDNVQb5pUFQf3fSG0dbrInEArL8IFMI/XM5+DjrEz6DhDwj87yRzMCr3WwmpHa3oM2Wyh5jJjQ4wHp7gN4OYIObRLzRx90GXHEYSjU9MVwddxyh/RHzESG1UDi0+sdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e7PiNZFM2eNqSK1J9SWg52wP/aW6SD39jEPyP8maQo=;
 b=Nfuz2UU6vJP3lG8jtxALjoYsMUah0fflGJVtLBt+4cPSLnvTp8ZbT4dN4QCTpVfpLMpqEXwaVW1MLqjT0SyxfDIJO0Vte/qvjYd181CAWBpQr1R7xkM8GUf79SerA06KEWws1VtfMx08ODKutLFWUgVpXhLqNQDfo/lR/3Y3/cz5iV4/E74RXYS7+M/zPtQ2VIgV28BBQdf7v9JDNJfELqOThaAwp7XV7ei0h0kc+GJol8Z0/9DNl6ODgq4ZiEmYoRLA+206mJfKcg+dItxQQfabZFqKwM+F5x3+0I5FppqCb0SMG5sCaQbFCU1d6XxJxdWz6+UAd+v06RDp+HDgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e7PiNZFM2eNqSK1J9SWg52wP/aW6SD39jEPyP8maQo=;
 b=YFrOdSSTRF9XIAkhTbNBdKjQRG0Ld2FdH+15gj+6oCAiuAjdj5CtQDMjdpP9sGfJxpVe4ZiT0H4Vw25Co56itseXWes3x5wwrTG5ztAz1X12Kt/7PqQZYpn+umDSQDkIGe0Kngtz34D1f22n0JQFIoXutGfyA1VOrgti0UoptKgpjvTfXEJb5/ehiccs00hs2THpX8wK1E1/2oAexCezyn8mVNDBd4I1ARVnbx5nnQQYa9fLN0FQgQzNYDu4BCc922Oooi5/ZEEr4k9ibFB/g5SRHbYdfcul118zq4EdUHy7FUeC1LBcKurZHW6Mroj8iMsGOwqTRQIIlf9ftzbvQg==
Received: from BN0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:e7::13)
 by DM5PR12MB1561.namprd12.prod.outlook.com (2603:10b6:4:b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Tue, 1 Feb 2022 10:11:14 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::77) by BN0PR03CA0038.outlook.office365.com
 (2603:10b6:408:e7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Tue, 1 Feb 2022 10:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 10:11:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 10:11:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 02:11:12 -0800
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
Subject: [PATCH v2 3/4] mm/gup: remove unused pin_user_pages_locked()
Date:   Tue, 1 Feb 2022 02:11:07 -0800
Message-ID: <20220201101108.306062-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220201101108.306062-1-jhubbard@nvidia.com>
References: <20220201101108.306062-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 334b0d05-58a3-4e55-feeb-08d9e56b2d8b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1561:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB156118C32F49F87DE7FBEC98A8269@DM5PR12MB1561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOaZ4K3fNRr6duDz9p8I5dHX3GmZoZoV2oFdaDy7xfrkBccTKMuk+0pxocc82j9ThPJYd77j9XoTAXyjniqLFsm+lKfb/apUJ6PZXbFG5YCT2iusuuTC2uK7hkWvJLS5t2rVw8mXcFSyXBs8N3sAQx6cJjCq4U4jbECBaR5ugPfWsjRkrxkfKRdXnokiXobMAoT5KecLPStOzMSQ9IJmvqLf226FiasfIWrJkIAZDnmwUV55dd9EwsfMpQecFMB/KsVq4SiqmLKs85x22DlSZYSSFFWvg2u5B8/CgGC1Q3PVw+3XYTXTPlU1d6Yov28i94q/eHp4+uJL+tK4+EF7Qs5LVOJ6j260xym0gyKmoYirSm2iEojU/I87u3GL9UmxArpqzTTezPVBvgwDwnImXNHxM6e1F0j83r/aYjhJJ0zciX6xKEMg3I1kBkrSgEkZiP+lXZSV31boL/qa9UMD2rpciuVVxx9bOM1vJWx/abN2rgagOaNCM3rrM7+9XU16VLLDiJqkBH+5K8ZVpkUzzz/2Tr5txPcx8Na7jDeNSYi8Z/3JWg5zgZ9dFrueToPYfO0dC5eruj/wn5EpnFvpGMGw9eUQFPby9VnHCx2C2SwRO+DCF3FUtJq3ITIMb7PvgurGk64yrfIMrXYMlrYo6OAvRX14iI1Vt0eIg4IDBbzQ//NqFQfczFczFsTdb3QrHSkbdcoOqMsZoQ01zt5e1A==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(508600001)(86362001)(2906002)(83380400001)(110136005)(7416002)(82310400004)(5660300002)(70586007)(70206006)(47076005)(36756003)(36860700001)(26005)(1076003)(186003)(8936002)(4326008)(8676002)(6666004)(40460700003)(336012)(2616005)(426003)(107886003)(81166007)(316002)(356005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 10:11:13.6484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334b0d05-58a3-4e55-feeb-08d9e56b2d8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1561
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine was used for a short while, but then the calling code was
refactored and the only caller was removed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 --
 mm/gup.c           | 29 -----------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..80c540c17d83 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1918,8 +1918,6 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    struct vm_area_struct **vmas);
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages, int *locked);
-long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
-		    unsigned int gup_flags, struct page **pages, int *locked);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    struct page **pages, unsigned int gup_flags);
 long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 8633bca12eab..58d01a96ab30 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3120,32 +3120,3 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
 }
 EXPORT_SYMBOL(pin_user_pages_unlocked);
-
-/*
- * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locked().
- * Behavior is the same, except that this one sets FOLL_PIN and rejects
- * FOLL_GET.
- */
-long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
-			   unsigned int gup_flags, struct page **pages,
-			   int *locked)
-{
-	/*
-	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
-	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
-	 * vmas.  As there are no users of this flag in this call we simply
-	 * disallow this option for now.
-	 */
-	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
-		return -EINVAL;
-
-	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
-	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
-		return -EINVAL;
-
-	gup_flags |= FOLL_PIN;
-	return __get_user_pages_locked(current->mm, start, nr_pages,
-				       pages, NULL, locked,
-				       gup_flags | FOLL_TOUCH);
-}
-EXPORT_SYMBOL(pin_user_pages_locked);
-- 
2.35.1

