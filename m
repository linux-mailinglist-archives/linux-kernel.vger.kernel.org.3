Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68C155B532
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiF0CZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiF0CZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:25:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C43C2AD7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656296723; x=1687832723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Talc3qs8+aIEJrvLvRNy14H65O5Ln3+oQKwcRjbNGPk=;
  b=mBIDb8q1CBeslWVJmpt6xRErbebPIdxNoV0sJMTEafN8EcucUNJuDdaF
   wH2u5IRsWLEEA0ILbiA2KhotHzFKHt8psn7gz2HlEbJxE/QqwpoKvqQaU
   g2ZSpwdiQx2zToAGq4J/SAAp2FTXdIKjE+u6gi5wbFIOQ/seb1s2FsJIM
   AKNMPrqM4Ync8rwC5bvhH/xyJIUz8v+qeyMfYCWB96x1vGNhmxW3dPJz9
   qwlfbJS0v2DlVzAgPJQk1dh/sa2gWAkNWeeUjV/2BQGGv8B9aYxIlQAQT
   HC1jKdnUoy6Dca4aWwivBzk98olZgvOo8BluhmoF478PVAnDhMhjD5CDn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="345338471"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="345338471"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:25:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="916513102"
Received: from yhuang6-mobl1.sh.intel.com ([10.67.65.240])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:25:20 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shy828301@gmail.com, ziy@nvidia.com,
        Huang Ying <ying.huang@intel.com>
Subject: [PATCH 7/7] migrate_pages(): fix failure counting for retry
Date:   Mon, 27 Jun 2022 10:25:15 +0800
Message-Id: <20220627022515.1067946-1-ying.huang@intel.com>
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

After 10 retries, we will give up and the remaining pages will be
counted as failure in nr_failed and nr_thp_failed.  We should count
the failure in nr_failed_pages too.  This is done in this patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 70a0e1f34c03..e42bd409d3aa 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1344,6 +1344,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int thp_retry = 1;
 	int nr_failed = 0;
 	int nr_failed_pages = 0;
+	int nr_retry_pages = 0;
 	int nr_succeeded = 0;
 	int nr_thp_succeeded = 0;
 	int nr_thp_failed = 0;
@@ -1364,6 +1365,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
 		retry = 0;
 		thp_retry = 0;
+		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(page, page2, from, lru) {
 			/*
@@ -1449,12 +1451,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				nr_thp_failed += thp_retry;
 				if (!no_subpage_counting)
 					nr_failed += retry;
+				nr_failed_pages += nr_retry_pages;
 				goto out;
 			case -EAGAIN:
 				if (is_thp)
 					thp_retry++;
 				else
 					retry++;
+				nr_retry_pages += nr_subpages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
 				nr_succeeded += nr_subpages;
@@ -1481,6 +1485,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (!no_subpage_counting)
 		nr_failed += retry;
 	nr_thp_failed += thp_retry;
+	nr_failed_pages += nr_retry_pages;
 	/*
 	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
 	 * counting in this round, since all subpages of a THP is counted
-- 
2.30.2

