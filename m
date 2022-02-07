Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D94AB4E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiBGGgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbiBGGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:22:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8AC043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:22:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E76WsFBEEIL8txT0I1sLAzVRfKUdInjRvcdUpzLTfFhml4ncZ6fAsPGNqIMVq74SK8Al4ug/8fGYBPP1xcUWySm93ciGYLVEquCLkGk8ZmrjH/f/E/xWow2KtQdqw8/ZpFrZU2NuK01VoTAyWKjWTFeu9Rvd45rjKD3FNZySx+98aYCW5mkfY7pxSM0jM01PWaiKmtkWS4oEwcejPul/2vKEEczfGOllEwxr2HRczMRTmKqHRgdVa4BWrUCUWlEjucHgi4OWkGF1vmsYXzil8easBAfGSI5aWpzkQH/M60bPrru3+Mao2uYdmhqR3YLwE2d79JQyYdq7SNDpeOkzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVfQ2qQS1xhMrtvuuVVoTMGpOrrX1QlZzQGiscYU/s0=;
 b=aVoTTPmfKbaXrC/ziRhycwomMEiSnBlrswT3m+f7c6pOeSa69TFvKzaLKCAjJoM0/dICjWSH+gPSMHDQP5C4S+o+yndilV9ybn1X1TwnAojOCeejEQaUZQD1wP2PdKcqZLji5fAPxqi84TwKWLu5ZVTQRqcuzAbKdrBXbQxDzq71PXiTkXDotnCIYbzhicgNpNtMt05OTLNJiDSWVHcAfk9RV/vTAsLXoGP+JqOhnOKT2bxClvzgU7YOTumleS6bXe4KB5jJOep8FYC5zY4xbuw6UHe+icv74O2BGD1sXbcpnYgvA7jTYJ6va7YsD5WJHgG4y2//0p8bZjxwYfsZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVfQ2qQS1xhMrtvuuVVoTMGpOrrX1QlZzQGiscYU/s0=;
 b=gfSOlSuRFHOOsB6IKI4OxbxFhAP7iFkUVO5OZNVBXUJyPLfDByWDOyii6ll9dpyW16rdPnI47IawNkTLDGr8s7QCAemAPv7X22maYuUMPsS0dIBae3cXUuXR3R3IhRs4HGs2NXNNhOagbSw9FjtIUdxLhCsLcp/37kx6WglABRPqV7D761OoLcvigA90v00RX+fsoSwzHGLs/zZ3BonUrxrXnPyGO/M9SWA3gD0efmBaPdIKbAWPDEakBIo5dOo1A3pCnswlWvAfOAoUE5FfsIysGFARz6oOxdmakpj8tLImcy9cbQbGgNJ/xcLu9nVSZ9pcaT9vKzlU5f+RIB1Zzw==
Received: from CO2PR07CA0076.namprd07.prod.outlook.com (2603:10b6:100::44) by
 BY5PR12MB4801.namprd12.prod.outlook.com (2603:10b6:a03:1b1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 06:22:37 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::4f) by CO2PR07CA0076.outlook.office365.com
 (2603:10b6:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 06:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 06:22:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 06:22:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sun, 6 Feb 2022
 22:22:36 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 6 Feb 2022 22:22:35 -0800
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
Subject: [PATCH v5 5/5] mm/gup: remove unused get_user_pages_locked()
Date:   Sun, 6 Feb 2022 22:22:13 -0800
Message-ID: <20220207062213.235127-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207062213.235127-1-jhubbard@nvidia.com>
References: <20220207062213.235127-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af287de7-34a7-49fb-7553-08d9ea023c8d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4801:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4801A6A9CD97A39F4DC872C1A82C9@BY5PR12MB4801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZU4mGKQgLeIvV6Lt8rxEPU0Ld0m7/fDXqezMbqZmugt8rWyNpTrJvSoNXO+lzjemgLlW56ZXJD/1SjI060Jcb4KWNPBlAhRmFfbwBOMVTIgfGpe3gjLPBJLSS1P63tLFtYV+jj12QW+UNbX6SZ6gXDn3XB+7LqIw6LARZZk07X1+RJDzZBBGjhOYsAsH5+LGxSOroxhyiC4ajAs7NS7Ah3lv4Pi2LwQfhyUU/De/f7zdBUrow6NksQfPIFJVdStfvScePq+/aIjWgWmZACJI2sObNPXhf+OODaEEZHWZe+Xa714s+D9kFqYCXdQQNoEjezB3hg1yTFhhYRbN/H4YmjCDP6FiR8p7NVQdK25KCGqeNUP9DPvIIFzTyBHQMvauHqe5mXZ1uOp9smCBz16JKbDBLtWAAr64Woc6Kx03wTlwzA8lulIwkFeb7UlI+wezGr6aFy2aYw69SIhZLfVlLAVyUAOjMZW65dAB8tNEWY8V2nAtGrVWvMFdPlGjzfalpsZSQ82D9ZozHUQubSXX+ATdDsa0BWeOcPmSb1DkR8SKay/JSBHJBTJ+Dcp2Ecit5ZD5eF+UCuImp3FI+lgagLL02DU/WBysoqwe+IUZlGeqX8MMaKZaVDI3T6/pPjCqWlx8KATWySreXk7mCHA8eLu0q6hv6C8EWwZ5k9Iq5VjMlfITAaoFsKfShztZwrrOK27hvY97QieTaX5ad9Y9w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(336012)(26005)(7416002)(2906002)(5660300002)(47076005)(36756003)(6666004)(40460700003)(83380400001)(186003)(426003)(1076003)(2616005)(82310400004)(4326008)(54906003)(356005)(8936002)(8676002)(508600001)(316002)(81166007)(86362001)(110136005)(70586007)(70206006)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:22:37.5279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af287de7-34a7-49fb-7553-08d9ea023c8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4801
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the last caller of get_user_pages_locked() is gone, remove it.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 --
 mm/gup.c           | 59 ----------------------------------------------
 2 files changed, 61 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80c540c17d83..528ef1cb4f3a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1916,8 +1916,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
 		    struct vm_area_struct **vmas);
-long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-		    unsigned int gup_flags, struct page **pages, int *locked);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    struct page **pages, unsigned int gup_flags);
 long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 6664dfa7a38f..7337520afa49 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2145,65 +2145,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(get_user_pages);
 
-/**
- * get_user_pages_locked() - variant of get_user_pages()
- *
- * @start:      starting user address
- * @nr_pages:   number of pages from start to pin
- * @gup_flags:  flags modifying lookup behaviour
- * @pages:      array that receives pointers to the pages pinned.
- *              Should be at least nr_pages long. Or NULL, if caller
- *              only intends to ensure the pages are faulted in.
- * @locked:     pointer to lock flag indicating whether lock is held and
- *              subsequently whether VM_FAULT_RETRY functionality can be
- *              utilised. Lock must initially be held.
- *
- * It is suitable to replace the form:
- *
- *      mmap_read_lock(mm);
- *      do_something()
- *      get_user_pages(mm, ..., pages, NULL);
- *      mmap_read_unlock(mm);
- *
- *  to:
- *
- *      int locked = 1;
- *      mmap_read_lock(mm);
- *      do_something()
- *      get_user_pages_locked(mm, ..., pages, &locked);
- *      if (locked)
- *          mmap_read_unlock(mm);
- *
- * We can leverage the VM_FAULT_RETRY functionality in the page fault
- * paths better by using either get_user_pages_locked() or
- * get_user_pages_unlocked().
- *
- */
-long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
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
-	/*
-	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
-	 * never directly by the caller, so enforce that:
-	 */
-	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
-		return -EINVAL;
-
-	return __get_user_pages_locked(current->mm, start, nr_pages,
-				       pages, NULL, locked,
-				       gup_flags | FOLL_TOUCH);
-}
-EXPORT_SYMBOL(get_user_pages_locked);
-
 /*
  * get_user_pages_unlocked() is suitable to replace the form:
  *
-- 
2.35.1

