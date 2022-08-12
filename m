Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA23590A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiHLCNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiHLCN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:13:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0646FA223D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qoo00HM81Tt62qNZCFhKiN8nFJZeiJguJAPJnz4OmAYuleV1ldQXkLAZvVP7bYd1hUxgmzMUu+jIgHb6ai8tG5RFiuh6Da+SRrUpqchx/d5kUoLu309zVNwglN2D31Lc9ZFxZfZONxjBnFRH43MyJU7v1V2eKnlRpItW+klHiW5T9Uaj7HteAu9GaNrVCxSCWEjiqXOlLwwIJCWbm6cWgWhgDkHBfxy172Pag3uWGS48vqNJbB8/QAA2lQjN3CnQqDk0F9TFTePokYZc/GnZXyzaCTeXgKd4trIzK1t6cAVLSxGkN6da+KGewyYSsMDBvz/CuhysLlzdClN4YyJziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uywkatlu6haO0ZfedAXLCgswbuKaHJeJe8KmaekdFg=;
 b=KiElcSoXLZ4kwyE9IVDiRiXZZNIjAuQBQ59ntKqdYqNlpaPXMU0Hw368EOdV0ppoSjQc9kKbJIhDD8lmXG8uuYbuwLeWBUJPq/yWaEBA1qwQcped3BXsdrjFKXmx2O1VEMLJRlHc7KmzZy0ceTZtJTWv7ctWbpd2GcU2ag8pw05W6PGelb8o2spak/n2kIbjlvHcHrmsDH+qi19gLiBSOIhyRVZzN5FuoaFhLRI/jvfr18MsPQbi0MQt1ag/zlvmLjasSissE6E2I3SsMC6nIPvl+6ATPOmkHfoXTG4nH5vAieW2YlpMc5J8Tqy6aDs8LFtektm+WaalpqvgXh90sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uywkatlu6haO0ZfedAXLCgswbuKaHJeJe8KmaekdFg=;
 b=cVhi1mRhssUzT+JC4oEimQdwSd+fun/h1IBe2yCrJKRI5OmspJLxvt6XzUu9NfFiNYiBGtj4DaeXKk8s0Z33I6UWZJOwPYqdoFxl51SG6TF0c/ZIw5F++zUtAEICACSPKYIu/4kldnj5epksQ1z92RtUgChVzfc8JYY7zFY8rBrowuztLG6aofAv+nmHKRWFpaIJHsO5voh75MqJhBtl58AGEq19GEVws7Zg/IlyRAELNEJLBuOVFrKjMKmhl0E6Fkf2nkO2eRUa3iCD8lKlJ11Fo3V4cLQjs+cOCfEE8OhQTGJezDpoAcJ7DGwMP+4mwB1eMhgpmqzMiicu3KF3wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Fri, 12 Aug
 2022 02:13:22 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 02:13:22 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v4 2/2] mm/gup.c: Refactor check_and_migrate_movable_pages()
Date:   Fri, 12 Aug 2022 12:13:09 +1000
Message-Id: <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6511df7-69b2-466a-2d37-08da7c083b78
X-MS-TrafficTypeDiagnostic: PH0PR12MB7080:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfRRDniyi5iaIkc7HMuCGxFkSu6S/eDCV9xsNT0EGKICyh/3FWKfvqfqSfrLoKENmB4AyhXdxT29WFktMn6XPM6gRF3t4ux/TygTH53oTrDTnhFWDwLDHwZ724lDHfjjJK7hQsuXGD/6WcDpkKgQpMIitSXyzCFqUxbBsFVvyjwQN9Hq4K7f71KJ8uPTe+nfnps+67uCgwoQphB/NPTc1yqcITJQBAngWTzoGyj76DINIf2e28l9mI6YrP+8hHPOGjDkyEAvJ6H2m2i+r2Xv5S3F9UZGgMNkQk+0AafQCLinmrCZOSZzZoUKr/KK+gfDlDGFS0hJKdBKYeeoOgq+emUFKHZ3lWdCrqHbv2uTtDKYIq1+7WAU5PTv12g37B6knFdnGArCTXt2vZ1vkL9h8gJNVw5cIYInZTbO6y0CzHtY5FBUMiel3kczd28l+9NTb23DG0fQHazVCAypwihN0dm1RGdDnWl0RLuaNF9oB0cK53m3sEikdivqZLQvstmcsQhu/CpasOIRjDI+kq8dpYHPZ5lIdY46WqyRDIdoQbOjkHeOWYAKNGKpD31nn53yIaeO94Gd1SvcPRzLQcsHsQbREqYkT7pZO/Ba5H4hdommTF5JJ2VxAV0AMZ9gWFxd2DTcRd3SWU+G/3CX4m9HQMnyk1K1fH6rGqIksve2vxobXIhnmx+a4u1+B16jZqT1uYK4NJ9S+PjbH3DAVeNYuTHqbdvPF8a5WQfzTDpNWAObSM5Wa3cMvS4VkjmLDPz3s5ybUeJI1ocfhylZZHaw7irpd1o6gb2wnPOmU3ctbQ54t0DigQXSNvG6HV1ataENdbXnhfz3KNMRB7VgSj/stA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(186003)(86362001)(6666004)(107886003)(6512007)(26005)(38100700002)(6506007)(2906002)(36756003)(83380400001)(478600001)(6486002)(7416002)(66946007)(8936002)(66476007)(66556008)(316002)(4326008)(2616005)(8676002)(5660300002)(54906003)(966005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wy+pDM36H/lzlZPF5czAQK59LuQIp8FFZ4GBU7gnJldTY9f5mzP2W9pVSKE0?=
 =?us-ascii?Q?l1s8Jdbk3IvTHpJ9uN5dny3HcV1ynkX0eRrtQE3W4UFmob/dM13zP1dOFb0d?=
 =?us-ascii?Q?zuBKJ/ne9NV6dmHJ/vla2/ZmXdGmpUUpg/tyUmSTP0b9qWjceOsRciPtkXfh?=
 =?us-ascii?Q?JpcAmSNd4gkANLd8f5uE73Y2A5WlP5q7+jio2M2zqDdzfYhhQah6p/Z/uffZ?=
 =?us-ascii?Q?drmwD6FeIvw1wcLY0p530VWK9FyqAgM0dwAvgCQQdPFNVvXIgh5Oae5m5nNl?=
 =?us-ascii?Q?t2yTR2anfeqLbUVRtsW7ESuB6yhf5xcc0FwFayuH+baHUP4hxQ4t91U91Wd2?=
 =?us-ascii?Q?Fi/FZ4UeqrOlbL7FuOL6E7TfBnDFJeI+iGtyoXgmbe9OKx8qEAFwlny8jPN4?=
 =?us-ascii?Q?NQia0oUGxFnyo1mpmZ6AeWwwR3mrB1v0vTcW2tO6DR6Wa/a3+ODG3zcOP3hN?=
 =?us-ascii?Q?KxFVBIAqRuMU/A3GR+soNxB1I/YPwSLpQQ2/7tB1TT+KFwlT2hTYroK+P9Id?=
 =?us-ascii?Q?5JHFNSrnJpSjx+XBQ7uJFSZALaRKhUi2Vyq8LMFQMwI/4mGWa/RFlvJ7VrPe?=
 =?us-ascii?Q?0eEMTEqWfIH3S1QhrhRta2SRdpVHadP059MWzrMHnaZfdjWe6gD36IDXu6ut?=
 =?us-ascii?Q?OydG5Bvic/ZkFta6xK00c+sL0joA+NzXpA4djLQoChXn11yc5yioO2xGKYPK?=
 =?us-ascii?Q?qeeZEaHU3OLs1Yt9tuVQG85BXE+iL98qHJNoMTj4gjCNaJCwUasPw8cibUTK?=
 =?us-ascii?Q?tQmflDFLAlln3tFPn3DR5RDhtVeWNdHaFN0Ix4osQOAkdM5kgzwvr8BfrPXl?=
 =?us-ascii?Q?iUrwxCeLznzuhFN4neN4U4IhVnJASX4w6d7+gos8v1YoGceglxVVFJBIOntG?=
 =?us-ascii?Q?DYC0H3rhm5sh5PJjLa0Q7hD5lEN/XtH7Su3JmnCa4q3qDS6ImXUp6xOqUFk1?=
 =?us-ascii?Q?3oBm629q86PNNqzoocFUSaxwg7NfEXilevPS4psSCxNRbzE8SdBcLVn890b7?=
 =?us-ascii?Q?AUZCTNy2SeRWvaBFQNEYd9KKmRZyCfswodz4ivw4qhmTdARu2Ke9D6Ru/X2a?=
 =?us-ascii?Q?1scT2z9hlJUVUFxnidX4A7DG97876LInaFaXJyKPapz2oYB9/q7NZscMbNq2?=
 =?us-ascii?Q?kezz+buXgANtQcqK4Dl/7HhGM8sfcbC6NzHXLaE/y+M6rxuhPj/Jg3EYg2+H?=
 =?us-ascii?Q?f6KAIrLGHpuhWxMg2virwrWuNYre/JPjRi2RtwSj/OrJ4+JlGJcdQGNbpi1Z?=
 =?us-ascii?Q?bviNu2sSObs9xuIfqup2B023vqVwilgsWRB3oBL4Fh8AX6cG4QFoM//AuR9a?=
 =?us-ascii?Q?BfZNLHf8vmDo6eOZv/Yj1D0XDTI3gGNxa9w0GhU5hSYU2oog8JBfx0ybgNxQ?=
 =?us-ascii?Q?WhBdKcRrqHW9PYNNSAxBKTH1b1ymbPCPO/fO4WaI4U0wbzJ02iJ03M4lGIp2?=
 =?us-ascii?Q?4NSdUSSNwqnjaTgjN8jId2X5HBKQom+HzfrI77G+U2A6E2CK61jviLFB+sAZ?=
 =?us-ascii?Q?E4V3bp7AfsSfuVoy8a2gJz5OZsNKWGuWK6yNecSvecxfXOqfMJjeIiO02JrT?=
 =?us-ascii?Q?JH0IiAWdqDOc17M88BTFfcB5IE/WZ7uoo9HN7p2C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6511df7-69b2-466a-2d37-08da7c083b78
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 02:13:22.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ke/lAbdBfnHDjG3XN0H48w0DlZcQwJlyGurdg6ZiQmjWkQT7U8jykUs5hqESoK7hYSJGhYPe8hNxPNF6iZTpFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
is called to migrate pages out of zones which should not contain any
longterm pinned pages.

When migration succeeds all pages will have been unpinned so pinning
needs to be retried. Migration can also fail, in which case the pages
will also have been unpinned but the operation should not be retried. If
all pages are in the correct zone nothing will be unpinned and no retry
is required.

The logic in check_and_migrate_movable_pages() tracks unnecessary state
and the return codes for each case are difficult to follow. Refactor the
code to clean this up. No behaviour change is intended.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v4:

 - Use folio directly instead of page based functions and folio->page.

Changes for v3:

 - Improved comments (thanks John).
 - Fix up inconsistent int/long/unsigned long.
 - Rename (migrate|collect)_unpinnable_pages
   to (migrate|collect)_longterm_unpinnable_pages() as suggested by David.

Changes for v2:

 - Split into different functions as suggested by John.
 - Made error handling more conventional as requested by Jason.

Originally posted as "mm/gup.c: Simplify and fix
check_and_migrate_movable_pages() return codes"[1].

Changes from that version:

 - Restore the original isolation failure behaviour and don't fail the
   pup. Instead retry indefinitely.
 - Unpin all pages on retry or failure rather than just failure.

[1] https://lore.kernel.org/linux-mm/814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com/
---
 mm/gup.c | 166 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 97 insertions(+), 69 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a2baa8b..b181d97 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1901,19 +1901,16 @@ struct page *get_dump_page(unsigned long addr)
 
 #ifdef CONFIG_MIGRATION
 /*
- * Check whether all pages are pinnable, if so return number of pages.  If some
- * pages are not pinnable, migrate them, and unpin all pages. Return zero if
- * pages were migrated, or if some pages were not successfully isolated.
- * Return negative error if migration fails.
+ * Returns the number of collected pages. Return value is always >= 0.
  */
-static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages)
+static unsigned long collect_longterm_unpinnable_pages(
+					struct list_head *movable_page_list,
+					unsigned long nr_pages,
+					struct page **pages)
 {
-	unsigned long isolation_error_count = 0, i;
+	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
-	LIST_HEAD(movable_page_list);
-	bool drain_allow = true, coherent_pages = false;
-	int ret = 0;
+	bool drain_allow = true;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1922,43 +1919,16 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			continue;
 		prev_folio = folio;
 
-		/*
-		 * Device coherent pages are managed by a driver and should not
-		 * be pinned indefinitely as it prevents the driver moving the
-		 * page. So when trying to pin with FOLL_LONGTERM instead try
-		 * to migrate the page out of device memory.
-		 */
-		if (folio_is_device_coherent(folio)) {
-			/*
-			 * We always want a new GUP lookup with device coherent
-			 * pages.
-			 */
-			pages[i] = 0;
-			coherent_pages = true;
-
-			/*
-			 * Migration will fail if the page is pinned, so convert
-			 * the pin on the source page to a normal reference.
-			 */
-			get_page(&folio->page);
-			unpin_user_page(&folio->page);
+		if (folio_is_longterm_pinnable(folio))
+			continue;
 
-			ret = migrate_device_coherent_page(&folio->page);
-			if (ret)
-				goto unpin_pages;
+		collected++;
 
+		if (folio_is_device_coherent(folio))
 			continue;
-		}
 
-		if (folio_is_longterm_pinnable(folio))
-			continue;
-		/*
-		 * Try to move out any movable page before pinning the range.
-		 */
 		if (folio_test_hugetlb(folio)) {
-			if (isolate_hugetlb(&folio->page,
-						&movable_page_list))
-				isolation_error_count++;
+			isolate_hugetlb(&folio->page, movable_page_list);
 			continue;
 		}
 
@@ -1967,59 +1937,117 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			drain_allow = false;
 		}
 
-		if (folio_isolate_lru(folio)) {
-			isolation_error_count++;
+		if (!folio_isolate_lru(folio))
 			continue;
-		}
-		list_add_tail(&folio->lru, &movable_page_list);
+
+		list_add_tail(&folio->lru, movable_page_list);
 		node_stat_mod_folio(folio,
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
 
-	if (!list_empty(&movable_page_list) || isolation_error_count ||
-	    coherent_pages)
-		goto unpin_pages;
+	return collected;
+}
 
-	/*
-	 * If list is empty, and no isolation errors, means that all pages are
-	 * in the correct zone.
-	 */
-	return nr_pages;
+/*
+ * Unpins all pages and migrates device coherent pages and movable_page_list.
+ * Returns zero if all pages were successfully migrated or -errno for failure
+ * (or partial success).
+ */
+static int migrate_longterm_unpinnable_pages(
+					struct list_head *movable_page_list,
+					unsigned long nr_pages,
+					struct page **pages)
+{
+	int ret;
+	unsigned long i;
 
-unpin_pages:
-	/*
-	 * pages[i] might be NULL if any device coherent pages were found.
-	 */
 	for (i = 0; i < nr_pages; i++) {
-		if (!pages[i])
+		struct folio *folio = page_folio(pages[i]);
+
+		if (folio_is_device_coherent(folio)) {
+			/*
+			 * Migration will fail if the page is pinned, so convert
+			 * the pin on the source page to a normal reference.
+			 */
+			pages[i] = NULL;
+			folio_get(folio);
+			gup_put_folio(folio, 1, FOLL_PIN);
+
+			if (migrate_device_coherent_page(&folio->page)) {
+				ret = -EBUSY;
+				goto err;
+			}
+
 			continue;
+		}
 
+		/*
+		 * We can't migrate pages with unexpected references, so drop
+		 * the reference obtained by __get_user_pages_locked().
+		 * Migrating pages have been added to movable_page_list after
+		 * calling folio_isolate_lru() which takes a reference so the
+		 * page won't be freed if it's migrating.
+		 */
 		unpin_user_page(pages[i]);
+		pages[i] = NULL;
 	}
 
-	if (!list_empty(&movable_page_list)) {
+	if (!list_empty(movable_page_list)) {
 		struct migration_target_control mtc = {
 			.nid = NUMA_NO_NODE,
 			.gfp_mask = GFP_USER | __GFP_NOWARN,
 		};
 
-		ret = migrate_pages(&movable_page_list, alloc_migration_target,
-				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN, NULL);
-		if (ret > 0) /* number of pages not migrated */
+		if (migrate_pages(movable_page_list, alloc_migration_target,
+				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				  MR_LONGTERM_PIN, NULL)) {
 			ret = -ENOMEM;
+			goto err;
+		}
 	}
 
-	if (ret && !list_empty(&movable_page_list))
-		putback_movable_pages(&movable_page_list);
+	putback_movable_pages(movable_page_list);
+
+	return 0;
+
+err:
+	for (i = 0; i < nr_pages; i++)
+		if (pages[i])
+			unpin_user_page(pages[i]);
+	putback_movable_pages(movable_page_list);
+
 	return ret;
 }
+
+/*
+ * Check whether all pages are pinnable. If some pages are not pinnable migrate
+ * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
+ * if all pages are pinnable and in the right zone. Other errors indicate
+ * migration failure.
+ */
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
+					    struct page **pages)
+{
+	int ret;
+	unsigned long collected;
+	LIST_HEAD(movable_page_list);
+
+	collected = collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
+	if (!collected)
+		return 0;
+
+	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
+	if (!ret)
+		return -EAGAIN;
+	else
+		return ret;
+}
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
-	return nr_pages;
+	return 0;
 }
 #endif /* CONFIG_MIGRATION */
 
@@ -2051,10 +2079,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 			break;
 
 		rc = check_and_migrate_movable_pages(rc, pages);
-	} while (!rc);
+	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 
-	return rc;
+	return rc ? rc : nr_pages;
 }
 
 static bool is_valid_gup_flags(unsigned int gup_flags)
-- 
git-series 0.9.1
