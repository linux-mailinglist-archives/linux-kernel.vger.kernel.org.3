Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3170591FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiHNOFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:05:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692526DB
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660485926; x=1692021926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zhvtJYb4P/ZP4YvSDNGhpQBQKTQTa0qMRAb90jH3p+0=;
  b=Rj26qlLnn9pjbsf3T6ZXtMcb6jpxbxYNDp2Ab6jdxrtRp6rvrZNY2jfL
   aohn/4AiG78ADqtNc1cNYYp4yrlknQF4MIczrhY/0op3BFuPLDMVXSX9l
   5PbWojBMoPF14bPbea+IeSnTWzJ82T1nPJeV2D9R1iv2aWugOpOtRl69+
   1I8odrVEOYWVr1vU7SjPf4vleuD4fXSEwGr/lTNxeubfrsXCvgKqjnE+x
   1xqqIodtyY+PuxtFWUKagAOULAsqFAxezcJnIwsNYWc+Pt/eZdhsHU42N
   3WiTjVcdzecsDALn8SlkS9B+YvEaULjQ8ztabLjj/jIEW9PH90a7GpI6V
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="278784437"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="278784437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 07:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="639385167"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2022 07:05:23 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v2 1/3] mm: revert handling Non-LRU pages returned by follow_page
Date:   Sun, 14 Aug 2022 22:05:32 +0800
Message-Id: <20220814140534.363348-2-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220814140534.363348-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220814140534.363348-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit
3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
doesn't handle the follow_page with flag FOLL_GET correctly, this will
do get_page on page, it shouldn't just return directly without put_page.

So revert the related fix to prepare for clean patch to handle Non-LRU
pages returned by follow_page.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 mm/huge_memory.c | 2 +-
 mm/ksm.c         | 6 +++---
 mm/migrate.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8a7c1b344abe..2ee6d38a1426 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2963,7 +2963,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		/* FOLL_DUMP to ignore special (like zero) pages */
 		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
 
-		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
+		if (IS_ERR_OR_NULL(page))
 			continue;
 
 		if (!is_transparent_hugepage(page))
diff --git a/mm/ksm.c b/mm/ksm.c
index 42ab153335a2..fe3e0a39f73a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -475,7 +475,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 		cond_resched();
 		page = follow_page(vma, addr,
 				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
-		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
+		if (IS_ERR_OR_NULL(page))
 			break;
 		if (PageKsm(page))
 			ret = handle_mm_fault(vma, addr,
@@ -560,7 +560,7 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
 		goto out;
 
 	page = follow_page(vma, addr, FOLL_GET);
-	if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
+	if (IS_ERR_OR_NULL(page))
 		goto out;
 	if (PageAnon(page)) {
 		flush_anon_page(vma, page, addr);
@@ -2308,7 +2308,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 			if (ksm_test_exit(mm))
 				break;
 			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
-			if (IS_ERR_OR_NULL(*page) || is_zone_device_page(*page)) {
+			if (IS_ERR_OR_NULL(*page)) {
 				ksm_scan.address += PAGE_SIZE;
 				cond_resched();
 				continue;
diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..3d5f0262ab60 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1672,7 +1672,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		goto out;
 
 	err = -ENOENT;
-	if (!page || is_zone_device_page(page))
+	if (!page)
 		goto out;
 
 	err = 0;
@@ -1863,7 +1863,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 		if (IS_ERR(page))
 			goto set_status;
 
-		if (page && !is_zone_device_page(page)) {
+		if (page) {
 			err = page_to_nid(page);
 			put_page(page);
 		} else {
-- 
2.37.2

