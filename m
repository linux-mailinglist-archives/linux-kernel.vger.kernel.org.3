Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5A4A9230
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356577AbiBDCBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:01:20 -0500
Received: from mail-mw2nam08on2048.outbound.protection.outlook.com ([40.107.101.48]:64129
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356541AbiBDCBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:01:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7e3aLjCYZz1sM6w7n5rkLUhV/F3NVZ7sEPFVIKZI4tPBAKsNBLuRnCF7P+EVX4pZFMENNPilMuBjZM93aQi7DyKBlc9ZWgVIHVcnhd7J0bGIYryPTeEaDtrrBgh4xXST7sBXj/z3T5pj+sH3Vbuh2PAvhDGwr/jwN4/u2sdBkYLllyg2OyibsLXi+uFcy2BDyBtynv36/sDjQoWe45cxsoOZYebHSX0pzOysgN35xIG5MAFl++dEwHhoft/nQGr0Q5qdCl8Qe00tLO4+7AdjjZ1C/+wjZpEXe7U+8Act3AIUuizrpiw+bfbJxNWpuC/tMJKLNp0jWlhrTP6eCakhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqmeqmDK9WNONzndgAGAbct149ZFM+Hb4kqc64wfHqs=;
 b=FTtOevJf0mjsrHl07iJzTP6+cw310bhLL33//UyXpOvfKSFWrknePPxfbUqt7rM963RLHQlkN1YTKXussOpJqRibFZtw63IKtrRmHYk9tCJBblClaBYg9mfEUGV1VUuvSv86r+dq3DHSpA/BpKe78zx92J0Fyio4QQgbL7TAs+lwQH0PCnTyTCOK8EVzhVj+b4xujMeWhED32YGoBWQafkWJVAiH+dTYzCxEeA+fSRlCWbE54GOvQBywfgD5Pkzd3ztJlBmd1/zIfFwwbzI2Te8bzO1OMgnXnFQwe8dlk4+r60NCYf1ofW1/4rm4df6jIo94uA2FqEx6bmVTN7M7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqmeqmDK9WNONzndgAGAbct149ZFM+Hb4kqc64wfHqs=;
 b=FEC0DWBUEaDQ4ETWMVC+5IP52b91ni3TEWDir3PX9qqr3YwuGMd58gkl24pY91fukPEf5gVp+zCvuudsP1PZyEGQmsiXF2RlPaLM6mrYNu7w6u9AOEKDQKaQ68eArVQwEOaA88Ehk4JtHmEucs5ngBGyZMFKDWhahmtfDwojKvmsHxDD1Jp4ME5YRr2vgwtpkraacfzZrHUPA3GnaWpBNUEBGOVOInshRbxp2pyfmCVU6EwCIUd7r5KKpmnT3z6sVm8csz0jwjOWobRr6egPKnBLmZ0qrdWXZh3FDSII/P3RwLx5ldSG1sBNE9Z/3IUoJsrjdTdf49FOAgfCHD0wZw==
Received: from DM6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:5:190::29)
 by DM6PR12MB5533.namprd12.prod.outlook.com (2603:10b6:5:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 02:01:15 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::a6) by DM6PR11CA0016.outlook.office365.com
 (2603:10b6:5:190::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Fri, 4 Feb 2022 02:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 02:01:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 02:00:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 18:00:13 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 18:00:13 -0800
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
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 3/5] mm/gup: remove unused pin_user_pages_locked()
Date:   Thu, 3 Feb 2022 18:00:08 -0800
Message-ID: <20220204020010.68930-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220204020010.68930-1-jhubbard@nvidia.com>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bb76ccd-d28c-4df6-32fc-08d9e78239b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB5533:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55333F3DA76BF6610FCA424CA8299@DM6PR12MB5533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXDOabUPRlexvCwUphlvhxd/3X3Xp2/mgMR8M7scX/FVAP41rfVVbrrTKU6hLkns7yTGR/JfXuxehgP0ma4DtwaInYxcmSboWWHI1HXi21MjCD1CSWWciGZgps4DuBzOt+2cJ48dOA2FwpiG1nkkamhK+MIKLOUkpGckhXKDpLD7kfUEP3FaejXye20v+gANtjEwP5RqmUi7U98zI8N7MPiLOxC/qjaCX1tY5RPngjn1p4q2ySdYxt4eJdaxaJhPCaYD9ypqhvD632e7JeUD4zT0mb7M/nZks5D0UlCaS0zS8HXPhyeEql5gO4U+KZ/8tbNrtrqekxRNUnxCIRm2SHsvqeREHIGiTC738S5dDFNCVywpt8SCeF4a6YWiSfTC0SgxU/ERhDxK+9zstP1HrPd4V4slaf+un5wUoy+jRc7drwJSba1CZEeZoJ48HjIBl8T1IeIHnqE6+9QC5LzoUUopJ3WNC2yYHTOE5k6M3PpjCRbXcHl9T/GU8bvS+z7i34sxeyNafZ7Cj5JeIxfdutCYQdQZrgGPsZAPsE5lsKwv89KQCXJSR1J768ie/sYct1B38SvX+Aij0Xy5Vglp0Hv6glO7VYozgs2/fdKtVRwy8yuxggVyIzLWaoBn0R8z6kQf53KABLuHsU3invTXa3HuDbS6c66CBOOadqe2dJ2Ge4AEWSFkmAuQsBu6zRLtigWs1WOsJhs2NIwVAwhuOg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(316002)(54906003)(110136005)(83380400001)(8676002)(2616005)(70586007)(7416002)(70206006)(4326008)(508600001)(2906002)(36756003)(5660300002)(6666004)(1076003)(186003)(26005)(47076005)(81166007)(356005)(86362001)(82310400004)(40460700003)(426003)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 02:01:14.8327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb76ccd-d28c-4df6-32fc-08d9e78239b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5533
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine was used for a short while, but then the calling code was
refactored and the only caller was removed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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
index 2df0d0103c43..6664dfa7a38f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3146,32 +3146,3 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
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

