Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C85927A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiHOB7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiHOB7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:59:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF412AD7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660528741; x=1692064741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3RyMMTN/AHHSqtfx+jaKLw7DbxnmzdBDsCyu34bLAqQ=;
  b=NxmT7ZpyKnKhSc9llwsKGHijl029lLql0wvmcCzpQFC1k3vCcBGCqrgo
   IGP8/GRHIa+witpcJPSf9jxaGjwa7DdxVnVSwTqcE67xgU3jlhDu72iof
   p0C5MvKbNOhw/uNQwwrKvU5OspqyYpj+J7dVIP7yf0r7EBDnr9pnR/7Sq
   ndoMonx+VIvIKvo8d9m1QllBbvPp0Pu6Z1ayGtVb67t5lEjCbd0cJiVMz
   X0aSM9qTQyMJAi1pLXVntnpwMSVcDnfujWy3UOxZVXa+hYgzW4gHHzhUQ
   s2EO2ziMrGkoc3j1ZrufFyAYKCIV4ZQLi0kzDLetHQ+GeR2nacdfq9PDQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="292667577"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="292667577"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="557132038"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2022 18:58:58 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Haiyue Wang <haiyue.wang@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH v4 2/2] mm: fix the handling Non-LRU pages returned by follow_page
Date:   Mon, 15 Aug 2022 09:59:09 +0800
Message-Id: <20220815015909.439623-3-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815015909.439623-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815015909.439623-1-haiyue.wang@intel.com>
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

The handling Non-LRU pages returned by follow_page() jumps directly, it
doesn't call put_page() to handle the reference count, since 'FOLL_GET'
flag for follow_page() has get_page() called. Fix the zone device page
check by handling the page reference count correctly before returning.

And as David reviewed, "device pages are never PageKsm pages". Drop this
zone device page check for break_ksm().

Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 mm/huge_memory.c |  4 ++--
 mm/ksm.c         | 12 +++++++++---
 mm/migrate.c     | 10 +++++++---
 3 files changed, 18 insertions(+), 8 deletions(-)

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
index 581dfaad9257..fee12cd2f294 100644
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
@@ -1868,8 +1871,9 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 		if (IS_ERR(page))
 			goto set_status;
 
-		if (page && !is_zone_device_page(page)) {
-			err = page_to_nid(page);
+		if (page) {
+			err = !is_zone_device_page(page) ? page_to_nid(page)
+							 : -ENOENT;
 			if (foll_flags & FOLL_GET)
 				put_page(page);
 		} else {
-- 
2.37.2

