Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389CD56D8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiGKIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiGKIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:50:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C462124E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657529415; x=1689065415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bnF/J3cdzcNa2nvmNTqNXDVKtTT8seBOtgR5lAaUQZU=;
  b=jLm6Ro24GzWBrayzUN9EITK3HSWWeXLPsukGTlgEVC5nEpb1AH03Jr3J
   BUepMGMU3QAp0rNo+QnZJIrK0RZU+Uec74vRWKV5O2QMu0TSzmMLb00Yf
   ncYx1Kmi2sjZOFR8dJI+bo93XtGGnUCx0mQpAJa6jA6OOsyjfFiIaPoI3
   X6TwdqMrCbEpLCB5/jGWtDNdXJjmCQipMRaWYAdYXrOEzvek5ZWjVyq0w
   VrafskkyA6sh15Zy8V61+5PBttlsKA+2ijgLWCu7OZm2Ev8PA2QafpK6p
   lL3tt4IK8gnAvrf8rK/hUfoouH1GUZF8IjKdqBtsgH5MGzDcZtZ8yNu63
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284637859"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="284637859"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="652374174"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.5.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:13 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V2 6/7] migrate_pages(): fix failure counting for THP splitting
Date:   Mon, 11 Jul 2022 16:49:47 +0800
Message-Id: <20220711084948.274787-7-ying.huang@intel.com>
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

If THP is failed to be migrated, it may be split and retry.  But after
splitting, the head page will be left in "from" list, although THP
migration failure has been counted already.  If the head page is
failed to be migrated too, the failure will be counted twice
incorrectly.  So this is fixed in this patch via moving the head page
of THP after splitting to "thp_split_pages" too.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8cce73b7c046..557708ce13a1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1306,6 +1306,8 @@ static inline int try_split_thp(struct page *page, struct list_head *split_pages
 	lock_page(page);
 	rc = split_huge_page_to_list(page, split_pages);
 	unlock_page(page);
+	if (!rc)
+		list_move_tail(&page->lru, split_pages);
 
 	return rc;
 }
@@ -1365,7 +1367,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		thp_retry = 0;
 
 		list_for_each_entry_safe(page, page2, from, lru) {
-retry:
 			/*
 			 * THP statistics is based on the source huge page.
 			 * Capture required information that might get lost
@@ -1412,7 +1413,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_thp_failed++;
 					if (!try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
-						goto retry;
+						break;
 					}
 				/* Hugetlb migration is unsupported */
 				} else if (!no_subpage_counting) {
@@ -1432,7 +1433,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

