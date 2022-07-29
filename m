Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C105849E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiG2Crk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG2Crh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:47:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE8683E5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYB2c3kEayXKlRozqmCpTi4rKmqWNTBxr0nuh98ykTFM/lvqSx813bvYFdaFOV9Joja98ct7aGMZASES1Y2bfdOCWmlQ+e0aWbuWhgwmETgYvPsa1eAEcK7UDG3ge31hKqVsY4av2FXl1CRFJab89c9iO/FmRy1rW6esRq3JhiZFCHHEDMwDR3WKVmiU7UTyCGnxc7mJWwsXkPJeHx3J2gkmZ4Pvarhjvxiv3KeI7DI7hJEwmWv3FlLRxsPayIDxbST0zBIpbcVl4Xqfid5de6XQxQfTef0rEqDtIEXDZQLzyCjKgfUm/CSjqPB7Izpaif9jW4atylYRE5s6Bmdtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W8hngUielgbbAbcYP2FDYL/b4/12jUv3FEeGe3dUDs=;
 b=edIEbzlbnZvBHyIFpcBkMccQShb5k18a2QbU1VowWl9sEpw4R59btELIALg2o0OAX25c5yqvZlNkDBW8v74uumaGv1zSYSVAUQcBAb9VN49rj+Y+ziP9vSXJw1U7EAriBRcO0/WoZQ598hZBs4hHtOHiqbRJh8iPBoI7VnrnarnYCahZ4ZYXw4gC151JZujSKvwxFzGZJJsUPwhbbTk1CaGoqO0s/lyoiUzWuxwLGJ5leRO2sOMgLEHYuM+uAAGy0Qqfwn5WTXflu503FGyt+Yue4/um4+Y8urOzD33TTVBl8CZ9cgugI1eFJAKNKrNmeGB01KcRatxDfgPYmIbxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W8hngUielgbbAbcYP2FDYL/b4/12jUv3FEeGe3dUDs=;
 b=VtX37LSCksofrqZmSyJJbazQPc4GRamYmJEkt8Q2OJgUsZQ+3GMAcXvmMc2fA+yqLcAg5pl3CqkDDYcxuX5k/dxjG1iy8Uj7tipG2wUve7UoYJzc90oXgEcA7GX8bqc36pF2VFiv0IWztINvcv9bcTDz8BpI8s20xCoGdZUyoF5zVL22Uyk0Yxr/E2nHcZKlHUb5PAAXxKKBuDLxmttznxqamT4ODUlrwsXNet3i/8TkM1G92s/7XR/A/NNrhmzwSkqAhLQgl8n+OP0WZ1JyVUR0DleZ9w8HQEI5yyfzGG4t4jQLxF74FTUjD57sYFY5vMsMT64aAOzn2i1NzniKVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN8PR12MB3570.namprd12.prod.outlook.com (2603:10b6:408:4a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 02:47:34 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 02:47:34 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org
Cc:     jgg@nvidia.com, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com, Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm/gup.c: Simplify and fix check_and_migrate_movable_pages() return codes
Date:   Fri, 29 Jul 2022 12:46:45 +1000
Message-Id: <20220729024645.764366-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b503b48-5e5b-4f3c-6fe5-08da710cb08d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3570:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKQ/BCZD4m+u6s1iKre4NuGsc6kgRodELIdGgGw58DHoxNIkuFM3c94R7yeqXS4W/IxtXN/xr9jxogr4PFUMb8zXktux2hhT24sacW7HaQP7nTrqdSil7cJJ8//iwBH33hTyV1ImIPCzFD+CK5nONvVECvHPplskk/BN2fd1UJeTGoXPveQx+N5PhBB3GiXKAiIKfejEAWPZRBGbuOpfNL0OAqSeEN2BX7c161VA8xh3f35SLWRyFkqucDcW8WyJRpE428xSjiHsLDVaMK6/KVM06sQrxmkL3Lq2MUcGKxIZiih4FzxOy8mqxnscNER/JxZjMZLy8rjULzoHDurwXcp0kHPyeIl/50O3YhTRTO7zQ4hj8f7R3HMnlJjxZrxJu5XxLrQ1RPj5yj2Eb/lJBv8S0n7JTgk0aP79DPiB/9hR/cdRvCf5YqR9YzNKxOvFbohNEchr7q2LbQVRhfZ4HiRpXRtBa80KR60bU1d6K3jXQLgn0toqCuP93kf/3GWYjRwQH/MOzOsA9Ww7QS8+NYEJty58AwH/In1PezZiQdtJpgVXs+VkrQfhpcRwqH3SClBPpWfnaQ5X+pHq2X2VtqOAYcHDMVKZCDwxlVEo74l6P0J+tNIw/fJJvo8H4g1wnn1mA5Wl3iyClu4dZpfMzoCNnCnWwBqt2Bnme+wxob5+r5ju3xLKAZeLW6XHXow21u/lTzmXBOZ36lBs7x6T7F/dHnm8Cyh3rLQv/XwQF+zLSgpbv3mNtRg+72YXqTKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(86362001)(38100700002)(83380400001)(66556008)(66946007)(8676002)(6916009)(4326008)(316002)(66476007)(2906002)(6506007)(26005)(8936002)(6512007)(6666004)(5660300002)(1076003)(2616005)(107886003)(6486002)(186003)(478600001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?InUoeboYsHJUUqZhvBjZzpSRGte1VOME28Rty5XF4tc5RRnLUpgP8gflHATR?=
 =?us-ascii?Q?Yp72Jit1+x5NLR81OnZG2SltYd/zVgvnD2fKLZGyuya0oS7jQac2mpg5PFEy?=
 =?us-ascii?Q?/AwvIJlvVeH0Pn6wNri0gZixOrf53toTtopVoOfepTyp8MoilqQMunffEVNr?=
 =?us-ascii?Q?3K/2cfQRyMQngQBr8gVhe57D/NFqqlqkdkLUpQXnW7uSmt/xghjOH/Xz3NQ1?=
 =?us-ascii?Q?JucLjR5c1cjydtPdrZ5lMpt4ku0+TwZL2t7AMLD/dvE9cQuAQuR80SnFrTYn?=
 =?us-ascii?Q?6bNSIOIh7YKdZfQqayu5soHjq2QuBaZa35lJKy37yMBOpWkdDBPyfRYQnfmo?=
 =?us-ascii?Q?Fs1wC6yz1f2w8pn734TAKC0f2A0+6cHuH/HvfnfngOzDkKi4GJsT41yyNY3C?=
 =?us-ascii?Q?FcMThO7RJRGs4LPsApkhEg4M3JdKz8FjrOuQ1TmuKjKdry19Pseloe/RkMlU?=
 =?us-ascii?Q?8CIxFlEZ04nZ7naRoI34fhkm9Yh4QTnixyfdjAguIRq8GqjeslZi2PFVr4vi?=
 =?us-ascii?Q?jZGfgS7pC+37Ck6hkHRT7BD6Xtt2fCer9s6pwB3ev9xkChtYsmnpn4Q1MXsZ?=
 =?us-ascii?Q?geAbE2u9fu1CoKjC60w4eiaR4oiAEC6uyx5e8zAETOR0w6h8IqNwcEc/Ccfs?=
 =?us-ascii?Q?RXhciL8okAv0E4qgMCW727N98x0IaUAtODOTfSjAf3+cN7gJXxAFBh63aZRB?=
 =?us-ascii?Q?oCamjYIFebw0DNPWLN0xDLsNYfhKW45pZiBqmrLgGQGl9aUNTQnAF7cR20bB?=
 =?us-ascii?Q?4p/JDQjBSgzPuIwzCtQYUSO0ExCJF3ZtbIHhQMdXkfGW3lalKHPCad8sG6wd?=
 =?us-ascii?Q?lLLhhVu0DtLUssc/auGXLpiDHyzyruRORNvBXC+C9HJ0hhzM0KE2yayAq6wb?=
 =?us-ascii?Q?CKAgooUv05o2Rj+PuSD2V7m7GAEkV+wyJPQ63fB5WWB5ZEKCTF8zhhvReEpy?=
 =?us-ascii?Q?+uriMVYZ5eVVbw+ZOifHK2jRPfJcaGvMBrg/fbko6ZMTxo5K0ppIWxfm+GNw?=
 =?us-ascii?Q?Qq78bXoohlTanv+Ruy+pSDfhkygQLHj92Fxg5Q64AQK7H5HRfgthNPxvYlv9?=
 =?us-ascii?Q?qmloK9IbiizRVUYSckFCiTkj0tayRaCPFk9Mjy7CR4zLsA9Am2ddtTyR9U0O?=
 =?us-ascii?Q?vs2VBi2fOMkSb6+mHLxRXDw8Ac9SP8lOPjRwzGAB0V7gXNfT3OFuPANJj+V8?=
 =?us-ascii?Q?HIXuyOh3TAVlXagfKima+cATUl1vonH49X8PicDJAaSR2dUub226iFjC6XAu?=
 =?us-ascii?Q?ooyJgj1a4vHKKEtrzVHD6Nj7w1AwBdzDqEIQFmzfVZrEgNGffMnT/gNUv42t?=
 =?us-ascii?Q?aKPKktfzZvTsGYvxYZ5OGvhWd7WpKgnuHmHcnG/bYYRkYqdHsqLHE8/M5FsU?=
 =?us-ascii?Q?vPSfH5CdYLI/NxHVFVRTNqspwu4enyfBGhJXUHMAa5nfLIGyw/w3g3pHbQcN?=
 =?us-ascii?Q?4RfxP+vy8Zgtqxgf1titP6oglP4dL8INHi2pCkJ4wzsPw/hy4j4uKjhQFagK?=
 =?us-ascii?Q?rVNGFQUEZUkC+xmem5yzj3/9fxXgz2BbEcan6ME0yCncn4neeqerZFMdKhdy?=
 =?us-ascii?Q?ouUby+Z5rHl7iU7x4K3HhXbQlhYJG+2VmDnnXOHX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b503b48-5e5b-4f3c-6fe5-08da710cb08d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 02:47:34.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0UZHKG96GZLaX2n7nyQggNOiYIFza6OBiXDVKUiXgwF0EkLZUZJXgLoEaVnbFSHVqT4Okw4+9QFMDeJN5wwyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3570
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/gup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 364b274a10c2..8b8ce8b7719c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1901,16 +1901,16 @@ struct page *get_dump_page(unsigned long addr)
 
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
 	bool drain_allow = true, coherent_pages = false;
@@ -1946,10 +1946,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 				unpin_user_page(&folio->page);
 			}
 
-			ret = migrate_device_coherent_page(&folio->page);
-			if (ret)
-				goto unpin_pages;
-
+			if (migrate_device_coherent_page(&folio->page)) {
+				ret = -EBUSY;
+				break;
+			}
 			continue;
 		}
 
@@ -1961,7 +1961,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		if (folio_test_hugetlb(folio)) {
 			if (isolate_hugetlb(&folio->page,
 						&movable_page_list))
-				isolation_error_count++;
+				ret = -EBUSY;
 			continue;
 		}
 
@@ -1971,7 +1971,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		}
 
 		if (folio_isolate_lru(folio)) {
-			isolation_error_count++;
+			ret = -EBUSY;
 			continue;
 		}
 		list_add_tail(&folio->lru, &movable_page_list);
@@ -1980,19 +1980,18 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 				    folio_nr_pages(folio));
 	}
 
-	if (!list_empty(&movable_page_list) || isolation_error_count
-		|| coherent_pages)
-		goto unpin_pages;
-
 	/*
 	 * If list is empty, and no isolation errors, means that all pages are
-	 * in the correct zone.
+	 * in the correct zone. If there were device coherent pages some pages
+	 * have been unpinned.
 	 */
-	return nr_pages;
+	if (list_empty(&movable_page_list) && !ret && !coherent_pages)
+		return 0;
 
-unpin_pages:
 	/*
-	 * pages[i] might be NULL if any device coherent pages were found.
+	 * Unpin all pages. If device coherent pages were found
+	 * migrate_deivce_coherent_page() will have dropped the pin and set
+	 * pages[i] == NULL.
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		if (!pages[i])
@@ -2019,14 +2018,15 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 
 	if (ret && !list_empty(&movable_page_list))
 		putback_movable_pages(&movable_page_list);
-	return ret;
+
+	return ret ? ret : -EAGAIN;
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
 					    unsigned int gup_flags)
 {
-	return nr_pages;
+	return 0;
 }
 #endif /* CONFIG_MIGRATION */
 
@@ -2054,10 +2054,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
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
-- 
2.35.1

