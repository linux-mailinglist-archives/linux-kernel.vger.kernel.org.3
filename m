Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6917D596B32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiHQIOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiHQIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6117E606A2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724066; x=1692260066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkZ/4tTRl3ObNiVYse3xCB7TE9jVqTapi3ezPGjzMTg=;
  b=jHkldJeZtLteuqjkLbEPalDkKbvqxevCJG3C3CQO6rWzrr0dDAqCEfM1
   XKuw7yHG9zBF4LrgeQaQ26F9l/qHwyCyM0nD4j/huQqvUB/hHjxc4R8i4
   4VjQYLnzQTSXDNftxJMKZMLLpYzPShs2sYpQMmtqbsCz+jztGl6Sis7wm
   RoOjWbO7vVr+KyattpugkcntFgaJx8GHNZsalbwCZbQ7FI32b8XlPdwr5
   M4qn1GNUN31Sw3AXkMZ4bWce18I5gRQpRPhNmpwnG3Ie/iWl08R4GAIG0
   wemzangG20RZlpxShlpMyz8qH1t6z8VEtyIVujj7QJE173ljmOLYS37Li
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293228795"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293228795"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583668087"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:23 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V3 2/8] migrate_pages(): remove unnecessary list_safe_reset_next()
Date:   Wed, 17 Aug 2022 16:14:02 +0800
Message-Id: <20220817081408.513338-3-ying.huang@intel.com>
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1758fd215c0a..19a9b26af7e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1369,16 +1369,13 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
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
@@ -1482,7 +1479,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/* THP migration is unsupported */
 				if (is_thp) {
 					nr_thp_failed++;
-					if (!try_split_thp(page, &page2, &thp_split_pages)) {
+					if (!try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
 						goto retry;
 					}
@@ -1501,7 +1498,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

