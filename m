Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4FF596B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiHQIPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiHQIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F286B175
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724076; x=1692260076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLXpcVQ48bukYRKZHdLPgeEwQ0PlwBGDjboqajk5r+E=;
  b=HID/2V1EIYGF7Uh+e2/sgeBU/jbL5iqqLgvP6uuE1YLsaMyy0dJbiVgV
   40obBbPaPLqiy9+u85RZ43YhYNnS6Y8Z06y6LhuzrNDLmRSdeU7VnptvC
   CkiFEh4IYY7dzH6kdzsTv6GyrdIHn/17QmrIgChVSCDh/JodN+GQQYaeV
   sbZQZYuVdEfG+e8yXasXPnLMwymbybx5JuN/vVKAT2MDA3QwcLa7bGWWl
   VSe6VLN2FCHiVugyW2MzsT/SEWTC0gqlLaW+rclwAuNLeiyEr4Hw0+Gbo
   FhowMdZPBekkUFbY4abq2mxkCxXX7YevyrHJZJYaG+P62EFstK+62SfZe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293228842"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293228842"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583668137"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:32 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V3 6/8] migrate_pages(): fix failure counting for THP splitting
Date:   Wed, 17 Aug 2022 16:14:06 +0800
Message-Id: <20220817081408.513338-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817081408.513338-1-ying.huang@intel.com>
References: <20220817081408.513338-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If THP is failed to be migrated, it may be split and retry.  But after
splitting, the head page will be left in "from" list, although THP
migration failure has been counted already.  If the head page is
failed to be migrated too, the failure will be counted twice
incorrectly.  So this is fixed in this patch via moving the head page
of THP after splitting to "thp_split_pages" too.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0223673e42d1..81daa4dd3bb6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1374,6 +1374,8 @@ static inline int try_split_thp(struct page *page, struct list_head *split_pages
 	lock_page(page);
 	rc = split_huge_page_to_list(page, split_pages);
 	unlock_page(page);
+	if (!rc)
+		list_move_tail(&page->lru, split_pages);
 
 	return rc;
 }
@@ -1433,7 +1435,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		thp_retry = 0;
 
 		list_for_each_entry_safe(page, page2, from, lru) {
-retry:
 			/*
 			 * THP statistics is based on the source huge page.
 			 * Capture required information that might get lost
@@ -1469,10 +1470,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 * retry on the same page with the THP split
 			 * to base pages.
 			 *
-			 * Head page is retried immediately and tail
-			 * pages are added to the tail of the list so
-			 * we encounter them after the rest of the list
-			 * is processed.
+			 * Sub-pages are put in thp_split_pages, and
+			 * we will migrate them after the rest of the
+			 * list is processed.
 			 */
 			case -ENOSYS:
 				/* THP migration is unsupported */
@@ -1480,7 +1480,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_thp_failed++;
 					if (!try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
-						goto retry;
+						break;
 					}
 				/* Hugetlb migration is unsupported */
 				} else if (!no_subpage_counting) {
@@ -1500,7 +1500,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					/* THP NUMA faulting doesn't split THP to retry. */
 					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
-						goto retry;
+						break;
 					}
 				} else if (!no_subpage_counting) {
 					nr_failed++;
-- 
2.30.2

