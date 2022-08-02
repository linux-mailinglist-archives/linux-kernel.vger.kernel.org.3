Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE075874D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiHBAce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHBAca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:32:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1DC2A431
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUgCMgeD1gcS3iG9STWttOV1y7sCITVRuxzyvzELpyLr/rssGn2CrWvxHpuxiwV9uWxYdCI3tioHk6Rc0QxCesxOOcTkOZJZR3sFFsxt5y7WkZ1QqRbxko3U3wzgI3rnJWXVAE7+KyXrwu3utg/QhQIu6uMOjHIkZgdozu+KjQY6zIwt/J8BGsj/OufQZVB9K3k4tIyUuKe2+vER8XfjNL4Jt4kjpG3DVexrd1xwJy5q2Nq6jxYtL5n04vBrwByg5CKohU1LHxVH2c0xvEaJ8YGMI+DKtNx0hWNOfvnV/JqIoOy3XlL0ZkfVdRQ7DewyN9GnyYwA3zixKDle6IkL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Kxvy2pUupZR/DNME1A5VSs2QkwtfDOs3E4fSDZeJaQ=;
 b=gQFEx09E8SLI8DkeHQODGyMxkLs0fWBV+q5RrdK+KfhBz/wP5r+q0YN2OrRYTHo59HxJPJ6KTBz8pR2G/SWFQVwq54OW1LkA2vMt7iYJP8fXc+3NhZd59Y2SmtyZY4I89mpkXLNpdeimxyBTHj5MSzceQKiknA04b6QqPN8U0JXRiBf3VbJJn6eLIPa1wWzc/n3DtpV+1qROXWVmk+2sMtSHGbpgVnP9Gdx1Tcyw2o6F/5Qb/aPDl9R9IaHSfWsMg8+sxYFX2KAxDT04YleM3StnUbc3KyTGFsua40XmcQVYxkrGlcPCesQkHlyG7rL0iPX//Nx2R9qb8+Ipk8xN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Kxvy2pUupZR/DNME1A5VSs2QkwtfDOs3E4fSDZeJaQ=;
 b=lpsTXBfhdIuwsNpVe8yLnjuNDUg5IH0rBThcZmpq/RsLaalL8SpTPWURUw8I8nrtRnE1Z7Je3tUw2zEGcVau2wG2RkLkAXcK/QrPW5Z/09e0HPkcoq0myWQswjab+cLoM1qKpkb4CiUHHOSCO/TjDuCzxaEH3ohpvhkgkdDJ8cvKX9qdMlsctGIR8mobhgB+mCxboINPWw8hNw76YaZTfMmOGpCUaLj7VEtbqvYCLiD6UUtegsG/vw/89fVovZ50x0DKfS/ykhlAHFl1VS+EmHBnrojr0aT1HWSGlh7IJublfMfXA1Lw77V5V0AzGiwdKiEuXU6t2Tp9JyakC9S8zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 00:32:28 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 00:32:27 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org
Cc:     jgg@nvidia.com, akpm@linux-foundation.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com, david@redhat.com,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2] mm/gup.c: Simplify and fix check_and_migrate_movable_pages() return codes
Date:   Tue,  2 Aug 2022 10:30:12 +1000
Message-Id: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:a03:114::39) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 337cbc66-8dde-464f-ed53-08da741e7a56
X-MS-TrafficTypeDiagnostic: DM6PR12MB4842:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyCmFWDNYddsDTjdtK57v6MU0qQaJlUj767Pr8zHgmH2FXnJm3Zr6i+xJM/w+fUDr+r24sHloFiLhdOFJVVc9zJT1VyEm4IGNsAWDOdAhhtCi/wAiDsMCq1ynBDPZuSXQy9RMdS3NquDvHGTqUy1c6QZdH3pEx2SIxXlkXi4uLUR4BiOMAn9f5eRFjPvdXbdF2cz0V2SFsb45bpWW85xh51YRkMTaisuPDyNQc+kwecTlp3EhfQjqvaFC7fL3udV1s/gGVVQfaBbFCRGJoJW1FzWhnrjXOJnZnWYT68OxAfNCRNze1vxN0+Fie0T6BMq+EkuRl7s6zD7uABLy84On7Imm7bjrPx6PnvT0r08ade1zEkKFp5iH6DNyv5lVVQdfDQ3d8dkDh0p+X2IXz43UZXFH8zlTxaelPNaL+4mbUl0BtijiONEWGX/zaVl2uD2dmlITaA1h472Qb5HNY+HZsObHDjX3ziYNySrY7Li+5w2nT8y8R3uFame3KZrsahPAVVj+dX5vAwo4JO9GG3iCqBUlCwiW3xA7omz4GuEkNPM+DoGkf3aZGtVYTby9SDZuUJDD3j8oC/0yJGyVrn6VAwL3jCqP31BwN16MCUDAyTM/u5I/MUL5xpTRXvXHM5eDDY2VmPAqnIhXOYSWioytId95g917STBwDTLabvk9dYv9A+rFT7NlrPjo/RZxDlJQJTkJ3KmLQxOyrr9rLNJfAe2XFZxalZJBww4S4cFzOMxFas96X8dTfgWv0wW1PYL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(6506007)(6512007)(4326008)(8676002)(66476007)(26005)(66556008)(2906002)(66946007)(38100700002)(41300700001)(6666004)(6486002)(83380400001)(5660300002)(478600001)(86362001)(8936002)(107886003)(316002)(2616005)(36756003)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGlScQB7HI/IZAc3cv11DWVMAW28hf3r6pkUKzHG8spTRt6u0fliJucXyVIh?=
 =?us-ascii?Q?hODQcE8HQExn7QRfqz75yZ1MIJU5H8FU/uE2kqEHnKsWuNSoa1jZKV+9FIMt?=
 =?us-ascii?Q?iN2wPuIxYANBela8JRo6jFIMwObwGdp9MNOAR3o+1EEHyMJoAFSzH1cX/jmv?=
 =?us-ascii?Q?6VEvi+ZB7O+n9uqqynn9swfppWN5BlDZD3ER+2tZY8BUKsgQIsN03R9F5K6u?=
 =?us-ascii?Q?cyyPyX3aph7kkjRt+tV40/zjGtNFeF9oTDy3PFDLUEirGjE9B4UQWJw4E44f?=
 =?us-ascii?Q?50J6VedFMlmpyUar6e0x2sIo+rRkqmOANyggo/mvKfb9cM5xWbJRjCy0son4?=
 =?us-ascii?Q?PbA+4UoF2HBaghnvYj1vfrT9lQuDPTnK7FBhcblEZ1Bk98Vpy9W+wZWo6T0s?=
 =?us-ascii?Q?dyZ/TzfxwJRpm4h3mIFaedLCYVwSJKH/djdrNWM11LhXaG6CxswdF+GiPZOx?=
 =?us-ascii?Q?6F7t83HlTT8qX+WEbWoxVLCj4iH6zzq3tsO3L0//1M6VVxYwd87m3cEaUqBV?=
 =?us-ascii?Q?iI33qL1YrE1jnRi8iCXQMPRkT0dGp6xQbXGeH5Ofp4LSVmK90nWd5Q8s0dc1?=
 =?us-ascii?Q?knsF5VdMSwXzUJvzLACTOexSh6KxdC1wADN4RwyMD2yrZAcENmvxQSBEDkb+?=
 =?us-ascii?Q?3bm6E4Ty2a+j049bbS5QztfIiwoa/hdnBeX7pHLHgXb3vVB8rL8ii05WKOeH?=
 =?us-ascii?Q?jjF+XRwiDDYl219zxKQ/XD7TWG8yzMHuY66M4ZwrS3yxHg49AhjCY94vKCWY?=
 =?us-ascii?Q?YCecZVMQh18KJ0vSCO/padPkhyuUEQM6p4j7oatdstZ8HmUylhl/wvedOT6H?=
 =?us-ascii?Q?/0d0Cx19zC30aB+VKkba4ryF5xuSLYZt9ZztVZEBBE4/9pXr2W/Hj3hkpX8c?=
 =?us-ascii?Q?FuDz8TbQQrY9dSDyQiswnKqRSvLL6AMh67WIjqa0j0fRC7oLHJX3FnffUp5P?=
 =?us-ascii?Q?FHMOnYcE1EBHmTRELW+AQBV7kmyVqytsrKDEYs02SPtge7oDdYvPC//bj5ag?=
 =?us-ascii?Q?aDxd6dXgVcKW8sQvnigL/iMYxQaMCcDCLatxhYf6qq6vz1Oaj9fvD2qYW7PB?=
 =?us-ascii?Q?dAatZxTzxP2QjybfDbFUIAd5cUj16aA5FhRPfAznW4xJJ8KQegzWcgB6Zi7b?=
 =?us-ascii?Q?pGVtkaZvn/G3xpdtHmamH4zzkxq8/Zsb7Ux6JlYEdKyS1Utu4axNZPAG6x2N?=
 =?us-ascii?Q?zMuFeITqiqRv3WgQ4787XKVPJL2PAugtt5DyvFHo7MgI0eL0m2bZqFj7eX9V?=
 =?us-ascii?Q?nDv9Ed9eKOG2SGB1ZRDdddrB8jdOhFbsI4jbqGJkbrnYwK55SoFe/HRx2D2p?=
 =?us-ascii?Q?8sMyqv1kongl48aEftAZUjpmu40Il/MF/z82GuDFS11lPSbqz0jGKW4N1QEM?=
 =?us-ascii?Q?8M326ulKwU38ZeGNCkkffM6YtK83VwM8r95Smt9btcfyRRcOsWnnxXm6JFo9?=
 =?us-ascii?Q?rHv3fE5ExpmBbbA+ZPYs4jSeAEfDg/4iRkzmvcg0hZA6oekshvpIZMNmUsWb?=
 =?us-ascii?Q?bCXDy6+V2V0rjc0/+tATblyQFF2prTCTlY3UjSc8ISKH1Pxn702Wk6oKAFbR?=
 =?us-ascii?Q?jOsPFF/iCAR2OCohlpLvZTa+AUSUIhpDH34sdRWp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337cbc66-8dde-464f-ed53-08da741e7a56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 00:32:27.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5u4rcs5FQLs6GjO6E90x8VkTeyx6+vfX8zeXpfXIPiZuu/fAdV6S7FKzA+W3uBgKv+8c4Zm6ykzKEam2f+sYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
is called to migrate pages out of zones which should not contain any
longterm pinned pages.

When migration succeeds all pages will have been unpinned so pinning
needs to be retried. This is indicated by returning zero. When all pages
are in the correct zone the number of pinned pages is returned.

However migration can also fail, in which case pages are unpinned and
-ENOMEM is returned. However if the failure was due to not being unable
to isolate a page zero is returned. This leads to indefinite looping in
__gup_longterm_locked().

Fix this by simplifying the return codes such that zero indicates all
pages were successfully pinned in the correct zone while errors indicate
either pages were migrated and pinning should be retried or that
migration has failed and therefore the pinning operation should fail.

This fixes the indefinite looping on page isolation failure by failing
the pin operation instead of retrying indefinitely.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v2:
 - Changed error handling to be move conventional using goto as
   suggested by Jason.
 - Removed coherent_pages check as it isn't necessary.
---
 mm/gup.c | 81 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 364b274..5707c56 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1901,20 +1901,24 @@ struct page *get_dump_page(unsigned long addr)
 
 #ifdef CONFIG_MIGRATION
 /*
- * Check whether all pages are pinnable, if so return number of pages.  If some
- * pages are not pinnable, migrate them, and unpin all pages. Return zero if
- * pages were migrated, or if some pages were not successfully isolated.
- * Return negative error if migration fails.
+ * Check whether all pages are pinnable. If some pages are not pinnable migrate
+ * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
+ * if all pages are pinnable and in the right zone. Other errors indicate
+ * migration failure.
  */
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
 					    unsigned int gup_flags)
 {
-	unsigned long isolation_error_count = 0, i;
+	unsigned long i;
 	struct folio *prev_folio = NULL;
 	LIST_HEAD(movable_page_list);
-	bool drain_allow = true, coherent_pages = false;
-	int ret = 0;
+	bool drain_allow = true;
+	int ret = -EAGAIN;
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
+	};
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1935,7 +1939,6 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			 * pages.
 			 */
 			pages[i] = 0;
-			coherent_pages = true;
 
 			/*
 			 * Migration will fail if the page is pinned, so convert
@@ -1946,10 +1949,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 				unpin_user_page(&folio->page);
 			}
 
-			ret = migrate_device_coherent_page(&folio->page);
-			if (ret)
-				goto unpin_pages;
-
+			if (migrate_device_coherent_page(&folio->page)) {
+				ret = -EBUSY;
+				goto error;
+			}
 			continue;
 		}
 
@@ -1960,8 +1963,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		 */
 		if (folio_test_hugetlb(folio)) {
 			if (isolate_hugetlb(&folio->page,
-						&movable_page_list))
-				isolation_error_count++;
+						&movable_page_list)) {
+				ret = -EBUSY;
+				goto error;
+			}
 			continue;
 		}
 
@@ -1971,28 +1976,26 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		}
 
 		if (folio_isolate_lru(folio)) {
-			isolation_error_count++;
-			continue;
+			ret = -EBUSY;
+			goto error;
 		}
+
 		list_add_tail(&folio->lru, &movable_page_list);
 		node_stat_mod_folio(folio,
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
 
-	if (!list_empty(&movable_page_list) || isolation_error_count
-		|| coherent_pages)
-		goto unpin_pages;
-
 	/*
-	 * If list is empty, and no isolation errors, means that all pages are
-	 * in the correct zone.
+	 * All pages are in the correct zone.
 	 */
-	return nr_pages;
+	if (list_empty(&movable_page_list))
+		return 0;
 
-unpin_pages:
 	/*
-	 * pages[i] might be NULL if any device coherent pages were found.
+	 * Unpin all pages. If device coherent pages were found
+	 * migrate_deivce_coherent_page() will have already dropped the pin and
+	 * set pages[i] == NULL.
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		if (!pages[i])
@@ -2004,21 +2007,19 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			put_page(pages[i]);
 	}
 
-	if (!list_empty(&movable_page_list)) {
-		struct migration_target_control mtc = {
-			.nid = NUMA_NO_NODE,
-			.gfp_mask = GFP_USER | __GFP_NOWARN,
-		};
-
-		ret = migrate_pages(&movable_page_list, alloc_migration_target,
-				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN, NULL);
-		if (ret > 0) /* number of pages not migrated */
-			ret = -ENOMEM;
+	if (migrate_pages(&movable_page_list, alloc_migration_target,
+				NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				MR_LONGTERM_PIN, NULL)) {
+		ret = -ENOMEM;
+		goto error;
 	}
 
-	if (ret && !list_empty(&movable_page_list))
+	return -EAGAIN;
+
+error:
+	if (!list_empty(&movable_page_list))
 		putback_movable_pages(&movable_page_list);
+
 	return ret;
 }
 #else
@@ -2026,7 +2027,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
 					    unsigned int gup_flags)
 {
-	return nr_pages;
+	return 0;
 }
 #endif /* CONFIG_MIGRATION */
 
@@ -2054,10 +2055,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 		if (rc <= 0)
 			break;
 		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
-	} while (!rc);
+	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 
-	return rc;
+	return rc ? rc : nr_pages;
 }
 
 static bool is_valid_gup_flags(unsigned int gup_flags)

base-commit: 187e7c41445a0f202bb551f08ca7f8158fea1cd7
-- 
git-series 0.9.1
