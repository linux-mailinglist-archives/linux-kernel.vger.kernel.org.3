Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16C04A922A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356335AbiBDCAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:00:21 -0500
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:21248
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229775AbiBDCAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:00:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKynv1996B8ZGO1jjheDhCHexBKthfQfca0P8f/Vs+lHUk98RTVs/Otb9bvYgXDDnKz33Vq6Rkzj7V5n3CkiOoB8D5JRQ4rAri7w18LCQS6oR2cQmmc3Lp6TQOVzuxrbHIZPi1ddaCVL0s4qya41H4B+qzmvqap4Tphm+PzNAUyJNI8B+8dfVtwUxqE10oAqjlKP9Yp+G8Ao9eFrSqQduyhzbfnKnUVtjqYdXa8Dh3yEZ0fX5vEcUTzyYigvB7MJzbaNnzF0Et9WukXvHSeknrXVigOFsetWS6YudllHzLuLt+FU0PyK+dUia5UIuc+zeoMtn7lqgeNGtFB1NqG9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sjp5WIXah4qEy4VPRd2JPXIcOGxf/jEUN8Mk8w5H/TQ=;
 b=dS8Hlekmr3DJKRu4b+0jShOPWBfdhRNViUB7sA6rncM6A707mnBKaVEclR2+gaO8deneP6uSYOkSXxMhEBCtuWat5xUcrFQWWsSWRMg7Uo61bZDiMXgxbmM7mYEyw+93MoxAgprCPyAKfxxQwSwScaNaj9UMR/kTMcRghrln3GoSnQN9dRWwB3jG9nWds0mj+VtYhHtzyOUGTKnmlpLFGuUsxmDI97w+KZgVVBJghWynwDdWP2e5/4WdZ7272/jVn9CEMb/GQn7k4y3VwJawNWk0qf6xORrOJlxZFubsA9NVu8YxR8vD/wzQn3xsqKtJnJSdiEU+4C2isvo/6WEkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sjp5WIXah4qEy4VPRd2JPXIcOGxf/jEUN8Mk8w5H/TQ=;
 b=IpUiPSRIxcDbUDIF3Y/AplxldU0zmKksYU4u8bxoOyti2TC0XkE0amYtupEils8AKRv9tC8xes7m1g9G+w4CS6x0SeZxgD7Ir8G7PaekKF3T7eTBJFyjTfKYXoNlyaR4jXR7kLXnDvJIpXFFQlXvDkGbTL+HYREBSSHx9YNE3yx3TfS4nH1kyuBfHIutRC9a96ILc6LIaJ4y5T9Ar8kTkvXbUe2QoOo+OSkqz6tE+Kce/Mdz/8HscntrMemQZwh0gIGd479WcOtZRfCXfRhRIzWBQNQKgBNhj9Lt66HcH4pU3L6H/zDae5AJnMWbh6cTPC2CfkX+uxRDTYa/eLoyoA==
Received: from BN8PR15CA0040.namprd15.prod.outlook.com (2603:10b6:408:80::17)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 02:00:17 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::68) by BN8PR15CA0040.outlook.office365.com
 (2603:10b6:408:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Fri, 4 Feb 2022 02:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 02:00:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 02:00:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 18:00:15 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 18:00:15 -0800
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 5/5] mm/gup: remove unused get_user_pages_locked()
Date:   Thu, 3 Feb 2022 18:00:10 -0800
Message-ID: <20220204020010.68930-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220204020010.68930-1-jhubbard@nvidia.com>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6115e15d-34c6-4185-ee38-08d9e7821744
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5320D5BD097D9F873DC4575AA8299@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ok1+ImFdUQJHLZFhblAeXRDmO/8uAEDdpqPr2BKYOVe7eIB4B9tOHVVyk82ZV0mcd5qdJWK9nY8BsMW76eoBy9QUgliyVsJ4+c6SJCh0CzAArtRjh3Mz7nBRmvbFVhOJ3zy/1TRsifYGBU6/XakZTZGLV+1LrC69qR2f9VJziie7B2v5qcmSSDuGIkMbdcb1s54RJswzZoz1mvbdsyXqgA8WBLZHvlUAY9MvGEqWT9LdOGq1o19yqdjWHxoCFVvMfDvKSlN4emha4pjywyioxfGsITTMmEnxe4TWh4VqQgX+RCog0tjHk1bY52OkoVx5zFg8UnvfsUFe3kagGluSsDS4XCX3kcESU+rsW8n5Bx106lvJeYPSsqZusKeL2e2rXcdrl6eD4U+g7OGPgbMswDpp9qxcpf8Sz3zu3JI+lL8CFCub/hWTV9ik1KLQSRRakJ2xU9MmNMLRHuWT2rsqcNzqa2+jjR2k6SHRYz/9pNV76XLq52PRwx68E3Xv3fO7LUpidEqFwQbw4DIyZOJ4xqZgHPU7PjoQ0oESzxqqjw9xCkWM3PoBEZRkYdkEZhd5dFcEAS51aytZa8uNG6wMAXZ1c2wAslLrVdh3aBCpwKq+0HU7B6qb3uwQ33YMve7HdJY15dZ0oaDGXbL2krZ2n8Ubszelzv+Rnb3Y7NHrV8P9TWZJuftKh9r1NQdIrYWVTvKLo7oyZZyD3SCOmWkdw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(6666004)(316002)(26005)(70586007)(70206006)(4326008)(82310400004)(426003)(8676002)(508600001)(356005)(336012)(81166007)(2616005)(47076005)(83380400001)(54906003)(8936002)(2906002)(36860700001)(40460700003)(7416002)(5660300002)(110136005)(86362001)(107886003)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 02:00:16.9919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6115e15d-34c6-4185-ee38-08d9e7821744
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the last caller of get_user_pages_locked() is gone, remove it.

Cc: Christoph Hellwig <hch@infradead.org>
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

