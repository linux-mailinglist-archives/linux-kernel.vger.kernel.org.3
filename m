Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D440D591FFD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiHNOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbiHNOFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:05:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67532AC4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660485931; x=1692021931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f+m9CXEwHKsS7nRuQgkQAOqrv/EV6rFv31H9xUQcy40=;
  b=FEqfeULi/P0kQllH5INYEqxVHqS8lYSaj7ZSuat7C2dD33uL601mFAQ7
   ETtU+81UxtqUQOPeKiycRzkv9iT53C1eQBoPMRlPmanoQZQ2GTPicSgw4
   E19fetmE7VhZheXL2DjNbkzQ1o71AuZtcDj533QVeNX0HJUbPo1NXaprJ
   862kZeC7ufd8MaWrVrEU3L0RHVX2qomnWPCqwmn3L4DoEk6BqYRurJ/9+
   rsEPdfdP4aO2Q8/ZloP68/oo4ocm98zA2Vqx3KCt9c0f2fTcYnjydkQ24
   j8jnNtqWRFLCAY09p5fJb70lHvZCz+58vLcYr/+6KIAHdYVpIJ0V2h346
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="278784452"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="278784452"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 07:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="639385202"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2022 07:05:29 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v2 3/3] mm: handling Non-LRU pages returned by follow_page
Date:   Sun, 14 Aug 2022 22:05:34 +0800
Message-Id: <20220814140534.363348-4-haiyue.wang@intel.com>
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

Add the missed put_page handling for handling Non-LRU pages returned by
follow_page with FOLL_GET flag set.

This is the second patch for fixing the commit
3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 mm/huge_memory.c |  2 +-
 mm/ksm.c         | 10 ++++++++++
 mm/migrate.c     |  6 +++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2ee6d38a1426..b2ba17c3dcd7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2966,7 +2966,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (IS_ERR_OR_NULL(page))
 			continue;
 
-		if (!is_transparent_hugepage(page))
+		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
 			goto next;
 
 		total++;
diff --git a/mm/ksm.c b/mm/ksm.c
index fe3e0a39f73a..1360bb52ada6 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -477,6 +477,10 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
 		if (IS_ERR_OR_NULL(page))
 			break;
+		if (is_zone_device_page(page)) {
+			put_page(page);
+			break;
+		}
 		if (PageKsm(page))
 			ret = handle_mm_fault(vma, addr,
 					      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
@@ -562,10 +566,13 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
 	page = follow_page(vma, addr, FOLL_GET);
 	if (IS_ERR_OR_NULL(page))
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
@@ -2313,6 +2320,8 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 				cond_resched();
 				continue;
 			}
+			if (is_zone_device_page(*page))
+				goto next_page;
 			if (PageAnon(*page)) {
 				flush_anon_page(vma, *page, ksm_scan.address);
 				flush_dcache_page(*page);
@@ -2327,6 +2336,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
+next_page:
 			put_page(*page);
 			ksm_scan.address += PAGE_SIZE;
 			cond_resched();
diff --git a/mm/migrate.c b/mm/migrate.c
index 5d304de3950b..fee12cd2f294 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1675,6 +1675,9 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 	if (!page)
 		goto out;
 
+	if (is_zone_device_page(page))
+		goto out_putpage;
+
 	err = 0;
 	if (page_to_nid(page) == node)
 		goto out_putpage;
@@ -1869,7 +1872,8 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 			goto set_status;
 
 		if (page) {
-			err = page_to_nid(page);
+			err = !is_zone_device_page(page) ? page_to_nid(page)
+							 : -ENOENT;
 			if (foll_flags & FOLL_GET)
 				put_page(page);
 		} else {
-- 
2.37.2

