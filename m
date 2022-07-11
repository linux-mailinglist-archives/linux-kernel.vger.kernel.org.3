Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6BF56D8D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGKIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiGKIu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:50:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB221E00
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657529418; x=1689065418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYmlZTWW8T052yrvDTxhlle8aydW1U/tmRbuqMhTmdg=;
  b=U7NBQ0XAg6UAFeQvINvPB9l5hIC1GyHseVbtq69PiUL4tSDBxabGJ5yK
   xEd59igNbDrmToEN8AKC8Lz1UMFfqYvbUJDkJNbPMwn02HNu1TvWMDavv
   ppUOjsctli2bDoQebriLBIgb65Pbo9nYYII3BnH1+LZXyrZAgR2anWgk2
   jrdszTYZHaPdJrlv6Eu6gLLnIHq671VN2uAWRmKi/ZZwySgIyzAkJoKXu
   +RPT7zjioFCLKk1ZC5MhgrFctoI8TsRjain6BkbkOdMwdrvtQxz+T9bwC
   V5eYG57mixgRFTN1ksEvAgWcNlL7+6zRNd5ndB/550JObsieS8TSKRfax
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284637866"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="284637866"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="652374188"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.5.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:16 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V2 7/7] migrate_pages(): fix failure counting for retry
Date:   Mon, 11 Jul 2022 16:49:48 +0800
Message-Id: <20220711084948.274787-8-ying.huang@intel.com>
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

After 10 retries, we will give up and the remaining pages will be
counted as failure in nr_failed and nr_thp_failed.  We should count
the failure in nr_failed_pages too.  This is done in this patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 557708ce13a1..cee6fc5a2d31 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1345,6 +1345,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int thp_retry = 1;
 	int nr_failed = 0;
 	int nr_failed_pages = 0;
+	int nr_retry_pages = 0;
 	int nr_succeeded = 0;
 	int nr_thp_succeeded = 0;
 	int nr_thp_failed = 0;
@@ -1365,6 +1366,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
 		retry = 0;
 		thp_retry = 0;
+		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(page, page2, from, lru) {
 			/*
@@ -1439,7 +1441,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_subpages;
+				nr_failed_pages += nr_subpages + nr_retry_pages;
 				/*
 				 * There might be some subpages of fail-to-migrate THPs
 				 * left in thp_split_pages list. Move them back to migration
@@ -1455,6 +1457,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					thp_retry++;
 				else
 					retry++;
+				nr_retry_pages += nr_subpages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
 				nr_succeeded += nr_subpages;
@@ -1481,6 +1484,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (!no_subpage_counting)
 		nr_failed += retry;
 	nr_thp_failed += thp_retry;
+	nr_failed_pages += nr_retry_pages;
 	/*
 	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
 	 * counting in this round, since all subpages of a THP is counted
-- 
2.30.2

