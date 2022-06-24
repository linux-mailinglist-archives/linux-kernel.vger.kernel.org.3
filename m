Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41645558D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiFXCxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiFXCxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:53:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B35325593
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656039215; x=1687575215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pJRtHCA5XeINaIi9YAR839UhUEC+OvL+5N+hlZMyJMg=;
  b=PjtTQqRO56bmT1csJxdz6j3UuvzfBlvHGOQ0LlC7x7YysvpoMnlS5vFd
   /xVI6pJbO+fOWHKfvkupP5dqe7N2B0RZVB3/WOoggXTXZhzGdT+ft1Ntj
   AUImTwrgWsVtNxfXFAfLM+5oZR3R+MLQGSXbWj/HSo9am4u6N2nEfUQAf
   1MJX6/8OCVIQaRVxvlzhu0FeMkjcq7jXR2k3QfN3G3oBNhQ9zdtCXT5sQ
   6NTl7fZkEathUV9bwGHnKJc2S3qHc4ImGAxTBHla3VyJEhmXXoXM6FpBQ
   1Gn/duuKtvlYb0r+t2EYfkwWjxFXw43qoqbC6hIp51FyaT9YYSesLR/22
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="279672720"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="279672720"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="593018075"
Received: from yxia2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.214.143])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:33 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH 2/7] migrate_pages(): remove unnecessary list_safe_reset_next()
Date:   Fri, 24 Jun 2022 10:53:04 +0800
Message-Id: <20220624025309.1033400-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624025309.1033400-1-ying.huang@intel.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit b5bade978e9b ("mm: migrate: fix the return value of
migrate_pages()"), the tail pages of THP will be put in the "from"
list directly.  So one of the loop cursors (page2) needs to be reset,
as is done in try_split_thp() via list_safe_reset_next().  But after
the commit, the tail pages of THP will be put in a dedicated
list (thp_split_pages).  That is, the "from" list will not be changed
during splitting.  So, it's unnecessary to call list_safe_reset_next()
anymore.

This is a code cleanup, no functionality changes are expected.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a271554be7a1..82444e7df9f1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1300,16 +1300,13 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	return rc;
 }
 
-static inline int try_split_thp(struct page *page, struct page **page2,
-				struct list_head *from)
+static inline int try_split_thp(struct page *page, struct list_head *split_pages)
 {
-	int rc = 0;
+	int rc;
 
 	lock_page(page);
-	rc = split_huge_page_to_list(page, from);
+	rc = split_huge_page_to_list(page, split_pages);
 	unlock_page(page);
-	if (!rc)
-		list_safe_reset_next(page, *page2, lru);
 
 	return rc;
 }
@@ -1413,7 +1410,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/* THP migration is unsupported */
 				if (is_thp) {
 					nr_thp_failed++;
-					if (!try_split_thp(page, &page2, &thp_split_pages)) {
+					if (!try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
 						goto retry;
 					}
@@ -1432,7 +1429,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_thp && !nosplit) {
 					nr_thp_failed++;
-					if (!try_split_thp(page, &page2, &thp_split_pages)) {
+					if (!try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
 						goto retry;
 					}
-- 
2.30.2

