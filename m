Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7058D149
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiHIAQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244658AbiHIAQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:16:46 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6DFA459
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 17:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh8bX6lYf3b+Cpa0EduRNMkkaX+Cj+N8wowiDuwe9/6kMNJsMxOAPsJTJLHGTiY2G+C4LniiJANayweLoYf0V5WHmDvVgjbQ3Jl2xznRWSdGp/8WSFAavd1v7LBDWojYtZxZXNbaA7m86nSptwPSzkfU149uvjW3e6EEh2lBoJB8l3trT/JqKQxK36UtS08QNj5fCVTCxpR9f1eR8CFEUy8Xf71mFlpsG6iEPCkdLc6jbo7tZ8b6jVVYo/HTRWx5mL2RFAxWHZx4qiHDXVyVwEDp2zwgwPyjKhwwAYJshVNcIRlC5czpeqEXulU13PrXl8zGiYO6KKR90PAqpBiJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTwQo9p0DCLnl+bgcvFx7aSteGqz+/r2OVr92otCPdE=;
 b=FgUrjNMUYnkUuY1DDGi7vzo1fS6t9xWWto1fKxa6gHFrcBSymiMxVaN8VC8k3Rh8zGU32EE+rZ4mU0UXm3ciyESvQnVOI8NAQnpcNYE1FyBKDmbygjyLd0pyRv7Ep7aQLG4oW53DyOr4qsACDKW710RGS/7Qk5PyI7NcyH7puR34XRnrnL6feeMKXqiXdW5pBnOnsJFolyL1wGW+3URcBmhKINwu4KUH2f8kUlCyUFozZZOcCG7DG6Ch/qohUQzD+hMY3iOL0+/ShJtsQ1H6KKzh3MrszWBO2t0WNv4op6uL9xxocRgdzmpdaQmWk79lDccNSTJ1lYejkxlz2I7XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTwQo9p0DCLnl+bgcvFx7aSteGqz+/r2OVr92otCPdE=;
 b=AI1ALI0lGcXwJJg8jmLxkTsiGL9B1yODBMjmNlV91TloohGhxlc1BRUNcrO9ILcEEgTUp0lPxmEnV5D5Mn5WwmQqz0bc6gNfT6dxbxRWApy1aIPUC0ntgYL2WdL8Klpld6PAE6eeWESBLkNC5KCYzupY5feSYkhy8CkeGrGat8b5aO3EGs3b15VzJWStmOhrHMSZa42QWe7DsiR1ezsQhv02LaxTg++LMl7exvrSR/+as5XsAJch28zQCMArVtWp1Z/eevSItV68z3GUDIu5k2c57Go7i3AMTJssNLqwbAJYsq226Tey92NsbwiaVNE+vX7fXxZShocUjn5Hj3sfBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 00:16:43 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 00:16:43 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
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
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v3 2/2] mm/gup.c: Refactor check_and_migrate_movable_pages()
Date:   Tue,  9 Aug 2022 10:16:26 +1000
Message-Id: <9e3761292315c9edb14bd812c9c587e792b32aa4.1660003800.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660003800.git-series.apopple@nvidia.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660003800.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 275b261e-0d23-4858-03f5-08da799c7003
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thBjcw7FfftN6inq/yHG2QHKdCdPuPKl5YpeKLwi46hmBbZQC5FqPRtcNmiqYvinEYssD7u7EkyGaQDeAEhvSA4o9m6GQcAGciBESZE78eaQzDY6yddKsIBR5ZVjifrZv/Vz236HG8x7Tkij1AE5b1Atpyx0S1IISaVVeXAMMscr31jTK4MGB7xyDxgyxeLupfbqVuFXDhxRVDuPN1aVKmbqw9GpteWjJ124za7GVRmYExNFKlE1CkEMzMJushsX2avvjzP0VYU4i+SRPHg8VGke/fYnlCtcrTlx5CRcmo6X64RJ8AbCvKjh9iy6K30n9q2GWDHT48BMDCjdNOYWhiTFG4PK4r0cbWXCzQfbd3vokQMvDjt8JjluE3AW81WRU7y8ZCrgvzcqLD3/GvlrzKrGQ0OiyIgnqJCXN0+suA2PmkaJ2Worf8mXuj5fLaYY++FozVhWL6PGqrUPH37GRWb6tPIQiZ0FUxFovK3xhFvUE4zGZAzy8F7Qn9moYcAjjc6PpvXf/+Q2ZLJwSNgWyMI06EoCTFFv3p5E/6T2VxOBErAT+sLT2EvEqTMnp3R3AaxglxT79WSaNt5XumOPHGOCXkd5bR4Xvb4j38eqkuh3Jx8Eby37/9RnklYRUuRn+D0YguZ4Re2XnfeN8AHL4w/EUyeTN8vGXa+wAB8qNm8n6Iz6/qhSOWX856HseyX33gj7ATYDq+QNbP+kcywY3DPZnBkg4vcKpItqs/N6MCM/MjAAW93Q9AW3aogXekdoy/ERh+aDyl5LInl8pA42gOb0pJZphYl9WtCn1JeNagBF7jajrG7t6NSyILre6AUlaFugCCYJRl8zPquJeqJNfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(38100700002)(478600001)(2616005)(86362001)(5660300002)(186003)(6486002)(8936002)(107886003)(8676002)(966005)(83380400001)(7416002)(54906003)(4326008)(66556008)(66476007)(6916009)(36756003)(66946007)(316002)(41300700001)(6666004)(2906002)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dtYR4k+y/OIhTdnG4Uigq9Kjkgbp/Eik7N7h6+JnEDkwWpuFobzTW8oW/JIg?=
 =?us-ascii?Q?4E7tUgCUSZ1Yo8d0o+UINeAEMPQWNWhTT5uwa5FIB0nAJ1lLNzoV0XXQKlCj?=
 =?us-ascii?Q?6n3t0+80BHKE4U4Vvq1QLeMul0CYvTHFFgDw1calxZEpmxs0hOgoOJvVIGT+?=
 =?us-ascii?Q?+G1IwKnD47Dtn19TRP88pO2vsLmblCbRbiBTbeUClbpx3/s4p0ESr4gX5/Ky?=
 =?us-ascii?Q?R/GrPJu6q3BbbYXLQBkU9nRh0dKgIwmKdBk7KODrgZHKs4DLJAYULh6QUnMU?=
 =?us-ascii?Q?PCSDx7d2TPpyweqolfVcGL2aGu58/zmrK2+sqOtAbRK7b88rhEzn2+9BEc+k?=
 =?us-ascii?Q?l0EzVQSCZgZJ+PoreGEOiSU1jGrUkHfRTz4eJunwL3gCT397ze3XxEoAKwMl?=
 =?us-ascii?Q?iLDpW9lgruEv8HY3ymbLVkg82escjxrMvYqdtWlwuGkswUvN7U7Pf+Ur/GHa?=
 =?us-ascii?Q?cpvcj+g1L/JcWZGSbedFXxSe2IftoDpLtoTHGzJV3akVcDNPZKyyyTdt/IXL?=
 =?us-ascii?Q?l4T0IhZ1XODuMN2erdSDU3XLaZIQclq82bA65vEGmDZricSUiiQoFgzAb9Xi?=
 =?us-ascii?Q?mCXwSAmjDNh39YPf5lvdnjOu73ODF9I3j/W45SmfH2To0gfW0lNW4+BVrQOZ?=
 =?us-ascii?Q?StkiDTRvWLtHfhWvRwXR4ZwNcR1pqOVIEgbL6P6agL1qNwOsO0TGNI70Ab3N?=
 =?us-ascii?Q?QGc/QI9EWh1vnFGua2CNcj+BnKm0/8DkuCW+cV5yuz3mv5iwpEBOGHxDtGqh?=
 =?us-ascii?Q?0ZVNmclHthcxJAYYUh5yfsRvwMsgWffS63NTi+gwK+yL4/qNuNNoPkCLfkK1?=
 =?us-ascii?Q?9YmglF4tRzUy8hneNfdKBGwailDauEZmC5bltMwhnhXZK7OPBLMuWwWcBZyn?=
 =?us-ascii?Q?EOSJ0Jdef8AH5GydgOO69Qf2NVVKGZTWSe6rePeGZc1ddfJSw8E/hz9Xqxps?=
 =?us-ascii?Q?x52HrNiEgM8edjMiCFCIm+ZZv2Zfdxsmv9h6t38+aU2afhhdS+bJ6HQn9lbE?=
 =?us-ascii?Q?sUCqbnbmo+VATLbPTnl3Awb6+T4gua/4Qsaw2mUhDasswtLbZNDFbvoXlfVo?=
 =?us-ascii?Q?hHjqmyLUZK1/aF3T1b8Lg+e9KUKFSOYMK8MSGdBb7azOuMTFYtak7LSiT0dP?=
 =?us-ascii?Q?gYvhT6VicNvD2unHIdZb631CzKOXbXQawyW8gzG/l9AOwKNm4e1Vx/vNcXXm?=
 =?us-ascii?Q?IilKZCzMG1tEL+s0u1XZFXr/NQmzhbCXoNGSmBuZcoDqV1lmQkv2JdIvE0k/?=
 =?us-ascii?Q?TkfIc70SkgaPvSZBq+I0VJOZoG9UyZb9f46xD0bm0P4TbMa1W4JXCWURvXUi?=
 =?us-ascii?Q?6Gc7bJHeHfZ3FHIRl2wgSdQ2pxenLXM2cgP8V4lRU5seC3Xq6TxAf6f2YQQ0?=
 =?us-ascii?Q?tLrKVswJK/D0dMXUDpzDev7EFybwXVq1TiFHQVaRVox0EbWYgM0Mb8iQE2cz?=
 =?us-ascii?Q?oOwkMWM0tsPT0oqVyp1Kst31UFH4w/qn0Z6Qeg49wE46vLeajlKTGEeavUDk?=
 =?us-ascii?Q?RuqMthVgUOXzxOeB6NTd74QZI4xkykUEW+jvg/EI02S+NGBR2lTIOPpr+CX+?=
 =?us-ascii?Q?qPhP0/I3bcbSJJG0SUr6h7eoqRJLYF9IQBj6Eq0f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275b261e-0d23-4858-03f5-08da799c7003
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 00:16:42.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVaxmUh3dhZ8l5X8uNS07rF/GbYCC2HF5mIyz85WTFp5OhhoweKsmFwD7B/7xmJdHQNcWNGF/W9QVzCu2CmR8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
index a2baa8b..d7ca706 100644
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
+			get_page(&folio->page);
+			unpin_user_page(&folio->page);
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
