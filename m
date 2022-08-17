Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86418596B23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiHQIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiHQIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472426DFB5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724078; x=1692260078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3FCN6Jt3Sb1+/b+KmRNGXeRqM8oFvsuaOTMG3DWs02g=;
  b=JT61dFbc6R4+8Lr+EZto86WHHZh2sQqrgYz+NjgLTfmJ6Evi4QvDtcMu
   atCFXNEd2EK7fF/M+b2ieqE0evvhCHeAS6USmSIYaD/Mm3ZEfgvImHxFJ
   Za6l3bxlVuoPRzYlKO4cWVfOshmNJlFO6lbLhpss2Encul3sxe3oVsTyL
   8hW2C42GpbZP1boI5XuFqEh08yDX8MQy+2Euq0zg+DpbeJoZUuj2A36Hc
   oTfTgcTcthUaBL1aUdsr8RpywffAOxNv8RWPuHUTkqYb0ss0m8O+yUEDF
   y5O5Qgi97g14MW2KsYWRjtDNcWKuQmYrQVU1Ivsk7UooH6I51YwMg7gO+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293228852"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293228852"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583668141"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:34 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V3 7/8] migrate_pages(): fix failure counting for retry
Date:   Wed, 17 Aug 2022 16:14:07 +0800
Message-Id: <20220817081408.513338-8-ying.huang@intel.com>
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

After 10 retries, we will give up and the remaining pages will be
counted as failure in nr_failed and nr_thp_failed.  We should count
the failure in nr_failed_pages too.  This is done in this patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 81daa4dd3bb6..55fbf9669431 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1413,6 +1413,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int thp_retry = 1;
 	int nr_failed = 0;
 	int nr_failed_pages = 0;
+	int nr_retry_pages = 0;
 	int nr_succeeded = 0;
 	int nr_thp_succeeded = 0;
 	int nr_thp_failed = 0;
@@ -1433,6 +1434,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
 		retry = 0;
 		thp_retry = 0;
+		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(page, page2, from, lru) {
 			/*
@@ -1506,7 +1508,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_subpages;
+				nr_failed_pages += nr_subpages + nr_retry_pages;
 				/*
 				 * There might be some subpages of fail-to-migrate THPs
 				 * left in thp_split_pages list. Move them back to migration
@@ -1522,6 +1524,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					thp_retry++;
 				else
 					retry++;
+				nr_retry_pages += nr_subpages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
 				nr_succeeded += nr_subpages;
@@ -1548,6 +1551,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (!no_subpage_counting)
 		nr_failed += retry;
 	nr_thp_failed += thp_retry;
+	nr_failed_pages += nr_retry_pages;
 	/*
 	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
 	 * counting in this round, since all subpages of a THP is counted
-- 
2.30.2

