Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5792956D8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiGKIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiGKIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:50:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8EBFE9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657529407; x=1689065407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvKkq5Wh9qU1+bVN3sbnuKnqAwdqqSdZhV8kZWnGHQU=;
  b=SuiiCefvW5wjcvIvtJWUw7hPJzekA/obkdRL/AiSQF3UEjDTmuxgWCet
   6gXLOEqpMLspB/NPbRkQqP6E11pJ50QNoULyswI5oToSQ9PNCaPUqLmfA
   MtyDuGf1F2fqx0iBaEkFwcayzcFscZSB8Roe0afo85pHNHMGHkpJ6qcKU
   V6zhs28wn7+hnjiS59KOedHACj3CWIR+RcEAG/2LWPAeitxKqu1wFf/Fd
   oUqVeCD3UpwzS5vUkIP20A6I0VaeReBuL0sLz2iakVO4S31AdfokZj0YO
   6kQmQ1btd5DQg7wpKpwIE0AcOb7HnMIYGBujGH5RntIA1C+CFk9yxlCZ9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284637839"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="284637839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="652374122"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.5.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:05 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V2 2/7] migrate_pages(): remove unnecessary list_safe_reset_next()
Date:   Mon, 11 Jul 2022 16:49:43 +0800
Message-Id: <20220711084948.274787-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711084948.274787-1-ying.huang@intel.com>
References: <20220711084948.274787-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 472335f0aaa3..794312072eb3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1301,16 +1301,13 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
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
@@ -1414,7 +1411,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/* THP migration is unsupported */
 				if (is_thp) {
 					nr_thp_failed++;
-					if (!try_split_thp(page, &page2, &thp_split_pages)) {
+					if (!try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
 						goto retry;
 					}
@@ -1433,7 +1430,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

