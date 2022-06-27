Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6455B531
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiF0CZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiF0CZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:25:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169482AD0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656296708; x=1687832708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xrLa/qvK6z+0n+mfC12qZ9ZlrFmavRnbmmLZYXho3nE=;
  b=FwOMBQpis0DS6E9AzunYz1hFQKMvOYJ1o3OC2hWU4JRiBWgJxyiIm/o1
   1BmH4JEGvOX5UrZPYR8DIs0uju+4wd8pmA3f172kuoO4qi2ad3kM/sHsu
   43Mg1FpWjSlE61kPjDyDC2Nam/LCBE4P56P9dQWYKOau1br5dMds7KYLP
   LFjWjIpj62/pFmEYQdZ1SfQVRyGsdJ/JtBVFrfP7wR5m2wVBt45eBWyVR
   KSLLkTa/+8Q2C0ILvKA9rjVkczQbgdW8aQjZFeKOkgJiB+r5mBmFx0Tv4
   kXMWiya5AUpeTHurca2fa1ik9nKby8jVr36WBz1y+64ymg+zmMLmdJt7R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="343022749"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="343022749"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:25:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="835992361"
Received: from yhuang6-mobl1.sh.intel.com ([10.67.65.240])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:25:04 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shy828301@gmail.com, ziy@nvidia.com,
        Huang Ying <ying.huang@intel.com>
Subject: [PATCH 6/7] migrate_pages(): fix failure counting for THP splitting
Date:   Mon, 27 Jun 2022 10:24:50 +0800
Message-Id: <20220627022450.1067783-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624025309.1033400-1-ying.huang@intel.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 9d1883d5927f..70a0e1f34c03 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1305,6 +1305,8 @@ static inline int try_split_thp(struct page *page, struct list_head *split_pages
 	lock_page(page);
 	rc = split_huge_page_to_list(page, split_pages);
 	unlock_page(page);
+	if (!rc)
+		list_move_tail(&page->lru, split_pages);
 
 	return rc;
 }
@@ -1364,7 +1366,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		thp_retry = 0;
 
 		list_for_each_entry_safe(page, page2, from, lru) {
-retry:
 			/*
 			 * THP statistics is based on the source huge page.
 			 * Capture required information that might get lost
@@ -1411,7 +1412,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_thp_failed++;
 					if (!try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
-						goto retry;
+						break;
 					}
 				/* Hugetlb migration is unsupported */
 				} else if (!no_subpage_counting) {
@@ -1431,7 +1432,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

