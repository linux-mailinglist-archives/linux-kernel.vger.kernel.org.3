Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F085A59F2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiHXFKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiHXFKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:10:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96A26AE0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/Xm4Z727iUBwu+URoe757kznKsPa0dMXWw29sG3rx1V40zoFZTAOn7c5ySMHIOqU+8Ro1vnH4IOU3otwl5psrNcuVJZ/WXQHAc0iDY1/wcKoww0ynt1Vfx1gi+EJVByOOtoM1gzvt0jEBWoj4+cSsM0gEFPz6ns5kyuuOhOORe509y24iw7AnsWED9r0iRvZTIqe2lTaFWiO4ge/PVWB3FB9yfNSFE2ArR/W7Ee8rxpqlwr7dHw/0Sf+cyGay9eht68ZN9Fv/IYo9n2kmcSqlz0tU96Zk+3tFLwq8OnyNLIW5Gkt0msOyaLwaGjRNJSCDK6vz42FVJ0Ghmqa5R/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stNgsKqwSAxwr4ssBO+/hhNanzgCKmpZULAcOkObjSI=;
 b=Vf0JC1MLBERNHjJ/XodhCoXZ1dDbn1uaoiSNcbNh9qwio8pEiQdbo5PWgoDfNV7vfdyOIev4OZ++pj3yZ7I9Kb/F5QuFJWTDNVd2nru9+XlQSIv2r8bqa1Ppi6/lFZ/zPRu+yI1wmNd4uadxJ/P6H3akdlIXwrllK/0k4PqROy2HrQAtpiHie7t89gVfHzJ0SBy19/F4tjZjW8edaT397ZaRgLqgQk5FvLOlcj3rXEBvMTbHoAM5bbGW+oT+5A8jGRXMhvuhYs/ic9bUfOUOV1f+Jgw0bVtTMOcOazFqVKp8jTkYOoSgf3QajAq9bgcQsgGVfSgDMPc87d5WYC1PPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stNgsKqwSAxwr4ssBO+/hhNanzgCKmpZULAcOkObjSI=;
 b=gE0z9fQhuTxX0VjGw9MVmkcaOLfcQwuVtbmD7vSMcsWxUFoEIgjXiZDLeYUjx/Ae6nhGUxdiM+8S6cdcuxx5EWIqmYqtUpILN0psP+otF1hMPUpf1EvWkNtXSjRbSakN473JYU3AqIDknimE4QVSdzasn5QOh9LNsPeuEauPYDpYVxSKpsfqICyg9HEBb9M+JaVY8Pv0Hn9kDdbXkks5rHBJSRK42Dr2L/UvmKTHEphSQcs3inaD0qP5MLYokBuIg7MnRzswnxIfxf831A+cchpRmULtXpyVLd5tdvGgeJeA45y+RuEvtk1pSoa7mzX/NWy2XKktERbZuJAlloFL0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL0PR12MB4657.namprd12.prod.outlook.com (2603:10b6:207:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 24 Aug
 2022 05:10:14 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c%7]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 05:10:14 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
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
        Alistair Popple <apopple@nvidia.com>,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH v6 2/2] mm/gup.c: Refactor check_and_migrate_movable_pages()
Date:   Wed, 24 Aug 2022 15:09:52 +1000
Message-Id: <19583d1df07fdcb99cfa05c265588a3fa58d1902.1661317396.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <d611c65a9008ff55887307df457c6c2220ad6163.1661317396.git-series.apopple@nvidia.com>
References: <d611c65a9008ff55887307df457c6c2220ad6163.1661317396.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:a03:60::21) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccef529e-4887-4138-8328-08da858eed8c
X-MS-TrafficTypeDiagnostic: BL0PR12MB4657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DekAH3UTLVQVt9NWN6utoGj/xnS7Xp7DbTPB0p24QyitVXmaPbJCQd7PU5jQQ6zff5sEzGptmuu2kETUyxYkqsgNVMaAHTuxPsUxR7WrUbIeCl2SXtzEWLFFNdVZpjSY/XadafX3YBbIgJg2yeRdYHrau1WTQ7tw5ttHyySQ4bYcNsu6JHvlAhq8aHf8nLvP7tYV3np1WzUXirCOXtZVhnLR0ZQ8205Il8Pmf0mstld/gJAjCY0nvihcJKrRGG14GHb750RG8C9+4AarCZ7uxo3tBWb2PmwyqE+kFTh3vXNW5HWz3WyhH2ENUzYwk0PbkCug6NjQOzyjGOn5eUD5GnUgHxGYHmKpyGBzdKOKkbq6t2bty15Z4GepDlXRk2nb1/I+IzRkSHqp4RwRu3VRKuKxh4RBwbGYyC3YVUYzKrJzcZczsSiL1lW9qWp80W+SQ6+sjkz5gWtWhHARrsvFpJmpO2V3sLhR42ivWUXoOw65UVymUppP1SmIe44/dLQvqVii+UE0pjnv1WtN2q6ttsW0SSC4fGd3LsDUEzcqwT2x7BvqWktQNV2Yvy20ZY3dhutyuzdsh7dl69KKF4MM1UXhHQRaYjOJQvri5bTohdFm8J70AwSYfs3+4caoY7zH+0CVewUsTOOA9v2BY5DwC5uOZSM+XvzMte6lNObNfJ2d/7VKXDI5lGiouIXCD+YUMeE+RJIB+Vwf6NJEUDv+8uNngDbByx/iwNiTfIJFBsrGGQ0Vhv8mOcLg2QUjUY0QwoWY8ksPZeNezsN1Errs16+VuPKiiYNKa9TP3/YsRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(2616005)(6506007)(6512007)(26005)(38100700002)(8676002)(7416002)(83380400001)(4326008)(5660300002)(186003)(66946007)(66556008)(8936002)(6486002)(966005)(6666004)(66476007)(41300700001)(2906002)(54906003)(86362001)(316002)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIZYqXHEYaoCst02wXjuBRYdfGFgVAqJ9N73ESHmNXXYuRwOcvJHWk5ygGn8?=
 =?us-ascii?Q?LnG+VJ7n/vQAB5iadXsmdnbYCHF+d+yLrrT0oo/OZeOasvfAn7KlJOPfxYwL?=
 =?us-ascii?Q?MDEfLqX1n9Bw5LE1z0h53HEFI9I2MqP9uNgNhHHvQ1Ya3iIQFx8pXFyNC4yc?=
 =?us-ascii?Q?PwDHWpz8d7d6hxCgn+6OMJ90g04QSwLxQhCwXcgL56xvZvy9q4HSDEeFdYdN?=
 =?us-ascii?Q?JZD8NdEzs4aoUnHWIUZlQPXN4d5jswIm0K4k1IPnoW9PgOCUNX0p1eaM27FV?=
 =?us-ascii?Q?221KF8WqlkYWifOx5sp4jqCXhRGHNW5uvqe8S+OQhKP75YbtI7moXe0ahEfj?=
 =?us-ascii?Q?okAMf7WJ4ymPzJNxHGe3Lb9PiBAL+5IH9VCC5N5BwQyhvdhatZqdfmxFN9co?=
 =?us-ascii?Q?8ECHMK/wvwgydFPL1O75I/Uls6IU2P7vt/OIZSuz9Zn1lbjmzzHM5PxyMlmL?=
 =?us-ascii?Q?hTA5/f6o+dQBd128iWZgMPCke/RVvpKYh4DHaybwEjz8tlNNuYMeCMk8RD+P?=
 =?us-ascii?Q?O5dBOkr37fVdvpjWm4N30hBmgu1BfyEJWbFZuDX+tvR4rPmyM+dRAks9e2Im?=
 =?us-ascii?Q?QACA0ESvgODBxFJW4pEOj3sR7KGuTWwr3FreMMRPFYOWqdUYn/+Xf69Y8HGB?=
 =?us-ascii?Q?QbqSbo6zL1FgTuL6WeAJ04HGJH0XIOWyCHyy7++Aaf2Km1TqDmSbUI4VKkC6?=
 =?us-ascii?Q?RaAx75uVrdmSIeGPBv0FDQHZ927zbwcr9wEiGAaUDE5w6NWDcWlSo/rAN0xd?=
 =?us-ascii?Q?fnHIUCZIRmsoMvZSf1ymgEeUAIbB0+/xaR38gsR6Pahm/IquU1/GUMjYqs9E?=
 =?us-ascii?Q?hx8HUUJ/x01F4hB0AVZecNpt0p9P+saBLTbmZ/fsbaLgNTfBbtiRZGv+FfPd?=
 =?us-ascii?Q?nwytgPelXKA/gWACld+K9J9XeN4OosZI+a22Zs6f8LgRJ2oWAxuyCVJ9mTbE?=
 =?us-ascii?Q?I6uXEpo5Zk2zucGG+GYjgpLbCi/teZjUa1alxasAuS3ATTUNHcJeze60Zja4?=
 =?us-ascii?Q?PDopbnQvInSZ4WXhZ4I/e4xijRVh3QRk/cJjQ4J6fPC0x8vZNSmA5NO6rFGe?=
 =?us-ascii?Q?TAEesTKk1/3y6FqgeLRBE9SPou7s2NxjhPuyDaTDCTskobwFXCgtQEGTEtMY?=
 =?us-ascii?Q?wpQWNwEfjpNEjfpAHNO4KATAOfIW0GGrbT41DI5us4dsnmCF4u3x5QfU4fsu?=
 =?us-ascii?Q?xdM3tyGYgJU6Jh6TwxpRQe/IMv5yCUsAbZwZfb/rOEsAlIz3BbHR6PcFkmf6?=
 =?us-ascii?Q?n16aoZSitooY9JKRPLjZGgV7w2kPMRLR4o09lU7OCgL60PzvJiQ4MBpjD5IE?=
 =?us-ascii?Q?OEEAIPIomLOttBSOpKxhUVtZHTX1J5js7vbDUqPNvyuYWQqi8KId22xuAKiX?=
 =?us-ascii?Q?QCktWHsAjQOXtJxxQd+ixrOnplP25gRj2uldgTaV2yelsQ8f4YaUr2NBU/sJ?=
 =?us-ascii?Q?ORGHvXkuQqJxADUkqr0hToHV6lSbgwyNDonYLtB2vcMWZT+zKcXcnKvzMJYz?=
 =?us-ascii?Q?FKTJ3ipfjrH3HjZM2RN6Tt0+YbTZKgVja9z3atJzmP38nX71K2UcmuAV37d6?=
 =?us-ascii?Q?LV5PbHaWpWHrRIV5nw3F4SPQV2NtSS47/cUQ1XWm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccef529e-4887-4138-8328-08da858eed8c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 05:10:14.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDYCRxSlLZkvizsDkTwuDP+VmoeQgGiH+/6tI5PdI762C/aQT+MqLOF8fWoCIsrkFkMzeAM2CtCnx90k2K+mYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>

---

Changes for v6:

 - Return -EAGAIN instead of 0 from migrate_longterm_unpinnable_pages()
   when all pages successfully migrated.
 - Rebased on top of mm-unstable to incorporate a fix from Shigeru
   Yoshida.

Changes for v5:

 - Minor formatting fixes.
 - Improved comments from John.
 - Cleaned up return code logic in check_and_migrate_movable_pages()

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
 mm/gup.c | 180 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 112 insertions(+), 68 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8d66ee2..19c7926 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1928,19 +1928,16 @@ struct page *get_dump_page(unsigned long addr)
 
 #ifdef CONFIG_MIGRATION
 /*
- * Check whether all pages are pinnable. If some pages are not pinnable migrate
- * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
- * if all pages are pinnable and in the right zone. Other errors indicate
- * migration failure.
+ * Returns the number of collected pages. Return value is always >= 0.
  */
-static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages)
+static unsigned long collect_longterm_unpinnable_pages(
+					struct list_head *movable_page_list,
+					unsigned long nr_pages,
+					struct page **pages)
 {
-	unsigned long i;
+	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
-	LIST_HEAD(movable_page_list);
-	bool drain_allow = true, coherent_pages = false;
-	int ret = 0;
+	bool drain_allow = true;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1949,43 +1946,16 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
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
+		if (folio_is_longterm_pinnable(folio))
+			continue;
 
-			/*
-			 * Migration will fail if the page is pinned, so convert
-			 * the pin on the source page to a normal reference.
-			 */
-			get_page(&folio->page);
-			unpin_user_page(&folio->page);
+		collected++;
 
-			if (migrate_device_coherent_page(&folio->page)) {
-				ret = -EBUSY;
-				break;
-			}
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
-				ret = -EBUSY;
+			isolate_hugetlb(&folio->page, movable_page_list);
 			continue;
 		}
 
@@ -1994,53 +1964,119 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			drain_allow = false;
 		}
 
-		if (folio_isolate_lru(folio)) {
-			ret = -EBUSY;
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
 
-	/*
-	 * If list is empty, and no isolation errors, means that all pages are
-	 * in the correct zone. If there were device coherent pages some pages
-	 * have been unpinned.
-	 */
-	if (list_empty(&movable_page_list) && !ret && !coherent_pages)
-		return 0;
+	return collected;
+}
+
+/*
+ * Unpins all pages and migrates device coherent pages and movable_page_list.
+ * Returns -EAGAIN if all pages were successfully migrated or -errno for failure
+ * (or partial success).
+ */
+static int migrate_longterm_unpinnable_pages(
+					struct list_head *movable_page_list,
+					unsigned long nr_pages,
+					struct page **pages)
+{
+	int ret;
+	unsigned long i;
 
-	/*
-	 * Unpin all pages. If device coherent pages were found
-	 * migrate_device_coherent_page() will have dropped the pin and set
-	 * pages[i] == NULL.
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
+	return -EAGAIN;
+
+err:
+	for (i = 0; i < nr_pages; i++)
+		if (pages[i])
+			unpin_user_page(pages[i]);
+	putback_movable_pages(movable_page_list);
 
-	return ret ? ret : -EAGAIN;
+	return ret;
+}
+
+/*
+ * Check whether all pages are *allowed* to be pinned. Rather confusingly, all
+ * pages in the range are required to be pinned via FOLL_PIN, before calling
+ * this routine.
+ *
+ * If any pages in the range are not allowed to be pinned, then this routine
+ * will migrate those pages away, unpin all the pages in the range and return
+ * -EAGAIN. The caller should re-pin the entire range with FOLL_PIN and then
+ * call this routine again.
+ *
+ * If an error other than -EAGAIN occurs, this indicates a migration failure.
+ * The caller should give up, and propagate the error back up the call stack.
+ *
+ * If everything is OK and all pages in the range are allowed to be pinned, then
+ * this routine leaves all pages pinned and returns zero for success.
+ */
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
+					    struct page **pages)
+{
+	int ret;
+	unsigned long collected;
+	LIST_HEAD(movable_page_list);
+
+	collected = collect_longterm_unpinnable_pages(&movable_page_list,
+						nr_pages, pages);
+	if (!collected)
+		return 0;
+
+	return migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
+						pages);
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
@@ -2067,7 +2103,15 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	if (!(gup_flags & FOLL_LONGTERM))
 		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 					       NULL, gup_flags);
-	/* check_and_migrate_movable_pages() assumes pages have been pinned. */
+
+	/*
+	 * If we get to this point then FOLL_LONGTERM is set, and FOLL_LONGTERM
+	 * implies FOLL_PIN (although the reverse is not true). Therefore it is
+	 * correct to unconditionally call check_and_migrate_movable_pages()
+	 * which assumes pages have been pinned via FOLL_PIN.
+	 *
+	 * Enforce the above reasoning by asserting that FOLL_PIN is set.
+	 */
 	if (WARN_ON(!(gup_flags & FOLL_PIN)))
 		return -EINVAL;
 	flags = memalloc_pin_save();
-- 
git-series 0.9.1
