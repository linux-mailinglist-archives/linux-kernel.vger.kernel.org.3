Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C186595335
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiHPG66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiHPG55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:57:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88840E9931
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660616453; x=1692152453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azMMIEPUBKNPjDvLiZ7ETAmaGJRsnErQLDZfHSszH5s=;
  b=YaKUqAJamw45Rb1wbEfXdmLP26RT9bKegjuzulLnbmQ+JmX4fgU25e53
   9jxu7pQwJwoFDqyAdNioFvd+G/lFMlBhTHVwFJUZflsmZZTeNhIY9oLNF
   txIl0+HxBR3lC6pyT7xF8DbmYMhsq0v/GLqOXrWxuzxHtMGaCZt3eH5B2
   x1n4EKFrT0NOgcVap6YBTKNaR0NWBHr9jvtjzXqm9DzQs5qJB34MsnT5R
   bPOgBaIZvVDmIOIRwsXw8Av1GWQdV3iSMaYrGuqxB/rO0JfXxK1wY9n48
   93G8SEnSUEk1lLaONxDz7EnQJGoOohgSqKv/6GxJV/2uucYKHiC9tndCP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378396220"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="378396220"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934706666"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2022 19:20:50 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, Haiyue Wang <haiyue.wang@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH v6 2/2] mm: fix the handling Non-LRU pages returned by follow_page
Date:   Tue, 16 Aug 2022 10:21:01 +0800
Message-Id: <20220816022102.582865-3-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220816022102.582865-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling Non-LRU pages returned by follow_page() jumps directly, it
doesn't call put_page() to handle the reference count, since 'FOLL_GET'
flag for follow_page() has get_page() called. Fix the zone device page
check by handling the page reference count correctly before returning.

And as David reviewed, "device pages are never PageKsm pages". Drop this
zone device page check for break_ksm().

Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 mm/huge_memory.c |  4 ++--
 mm/ksm.c         | 12 +++++++++---
 mm/migrate.c     | 19 ++++++++++++-------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8a7c1b344abe..b2ba17c3dcd7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		/* FOLL_DUMP to ignore special (like zero) pages */
 		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
 
-		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
+		if (IS_ERR_OR_NULL(page))
 			continue;
 
-		if (!is_transparent_hugepage(page))
+		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
 			goto next;
 
 		total++;
diff --git a/mm/ksm.c b/mm/ksm.c
index 42ab153335a2..e26f57fc1f0e 100644
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
@@ -560,12 +560,15 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
 		goto out;
 
 	page = follow_page(vma, addr, FOLL_GET);
-	if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
+	if (IS_ERR_OR_NULL(page))
 		goto out;
+	if (is_zone_device_page(page))
+		goto out_putpage;
 	if (PageAnon(page)) {
 		flush_anon_page(vma, page, addr);
 		flush_dcache_page(page);
 	} else {
+out_putpage:
 		put_page(page);
 out:
 		page = NULL;
@@ -2308,11 +2311,13 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 			if (ksm_test_exit(mm))
 				break;
 			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
-			if (IS_ERR_OR_NULL(*page) || is_zone_device_page(*page)) {
+			if (IS_ERR_OR_NULL(*page)) {
 				ksm_scan.address += PAGE_SIZE;
 				cond_resched();
 				continue;
 			}
+			if (is_zone_device_page(*page))
+				goto next_page;
 			if (PageAnon(*page)) {
 				flush_anon_page(vma, *page, ksm_scan.address);
 				flush_dcache_page(*page);
@@ -2327,6 +2332,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
+next_page:
 			put_page(*page);
 			ksm_scan.address += PAGE_SIZE;
 			cond_resched();
diff --git a/mm/migrate.c b/mm/migrate.c
index 581dfaad9257..44e05ce41d49 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1672,9 +1672,12 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		goto out;
 
 	err = -ENOENT;
-	if (!page || is_zone_device_page(page))
+	if (!page)
 		goto out;
 
+	if (is_zone_device_page(page))
+		goto out_putpage;
+
 	err = 0;
 	if (page_to_nid(page) == node)
 		goto out_putpage;
@@ -1868,13 +1871,15 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 		if (IS_ERR(page))
 			goto set_status;
 
-		if (page && !is_zone_device_page(page)) {
+		err = -ENOENT;
+		if (!page)
+			goto set_status;
+
+		if (!is_zone_device_page(page))
 			err = page_to_nid(page);
-			if (foll_flags & FOLL_GET)
-				put_page(page);
-		} else {
-			err = -ENOENT;
-		}
+
+		if (foll_flags & FOLL_GET)
+			put_page(page);
 set_status:
 		*status = err;
 
-- 
2.37.2

