Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4960A574320
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiGNEaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiGNE3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:29:04 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161D028E3A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:24:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657772688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vci+a2j3p4dRTO4MvgjEzQFBNpUGagACvgxCOkke+7Y=;
        b=WJNZQLeeJiGf/RGk2CRNPv9wRnsekMjkGr8ZWSoOA6S/JQh1Q/oeu2H0YZMNJiIy53mOY/
        xcdUwC5oL30e0z9tHk+tr6hRIVpIW8J/eQUU0s/mcFZkQCySp+qGSEmeJyV2eRQIIlCSag
        jZqk3kJflYbLc496e8mA2+EEAK9P0N8=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable PATCH v7 4/8] mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
Date:   Thu, 14 Jul 2022 13:24:16 +0900
Message-Id: <20220714042420.1847125-5-naoya.horiguchi@linux.dev>
In-Reply-To: <20220714042420.1847125-1-naoya.horiguchi@linux.dev>
References: <20220714042420.1847125-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Raw error info list needs to be removed when hwpoisoned hugetlb is
unpoisoned.  And unpoison handler needs to know how many errors there
are in the target hugepage. So add them.

HPageVmemmapOptimized(hpage) and HPageRawHwpUnreliable(hpage)) sometimes
can't be unpoisoned, so skip them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
v6 -> v7:
- free_raw_hwp_pages() checks HPageVmemmapOptimized(hpage) only when
  move_flag is true so that unpoison works for HPageVmemmapOptimized pages.

v5 -> v6:
- set type of return value of hugetlb_clear_page_hwpoison() to void
- change type of return value of hugetlb_clear_page_hwpoison() to unsigned long

v4 -> v5:
- fix type of return value of free_raw_hwp_pages()
  (found by kernel test robot),
- prevent unpoison for HPageVmemmapOptimized and HPageRawHwpUnreliable.
---
 include/linux/swapops.h |  9 +++++++
 mm/memory-failure.c     | 52 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a01aeb3fcc0b..ddc98f96ad2c 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -498,6 +498,11 @@ static inline void num_poisoned_pages_dec(void)
 	atomic_long_dec(&num_poisoned_pages);
 }
 
+static inline void num_poisoned_pages_sub(long i)
+{
+	atomic_long_sub(i, &num_poisoned_pages);
+}
+
 #else
 
 static inline swp_entry_t make_hwpoison_entry(struct page *page)
@@ -518,6 +523,10 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
 static inline void num_poisoned_pages_inc(void)
 {
 }
+
+static inline void num_poisoned_pages_sub(long i)
+{
+}
 #endif
 
 static inline int non_swap_entry(swp_entry_t entry)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fa29849769ed..8b9c0d228549 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1680,19 +1680,23 @@ static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
 	return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
 }
 
-static void __free_raw_hwp_pages(struct page *hpage)
+static unsigned long __free_raw_hwp_pages(struct page *hpage, bool move_flag)
 {
 	struct llist_head *head;
 	struct llist_node *t, *tnode;
+	unsigned long count = 0;
 
 	head = raw_hwp_list_head(hpage);
 	llist_for_each_safe(tnode, t, head->first) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
-		SetPageHWPoison(p->page);
+		if (move_flag)
+			SetPageHWPoison(p->page);
 		kfree(p);
+		count++;
 	}
 	llist_del_all(head);
+	return count;
 }
 
 static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
@@ -1735,17 +1739,36 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
 		 * Once HPageRawHwpUnreliable is set, raw_hwp_page is not
 		 * used any more, so free it.
 		 */
-		__free_raw_hwp_pages(hpage);
+		__free_raw_hwp_pages(hpage, false);
 	}
 	return ret;
 }
 
+static unsigned long free_raw_hwp_pages(struct page *hpage, bool move_flag)
+{
+	/*
+	 * HPageVmemmapOptimized hugepages can't be freed because struct
+	 * pages for tail pages are required but they don't exist.
+	 */
+	if (move_flag && HPageVmemmapOptimized(hpage))
+		return 0;
+
+	/*
+	 * HPageRawHwpUnreliable hugepages shouldn't be unpoisoned by
+	 * definition.
+	 */
+	if (HPageRawHwpUnreliable(hpage))
+		return 0;
+
+	return __free_raw_hwp_pages(hpage, move_flag);
+}
+
 void hugetlb_clear_page_hwpoison(struct page *hpage)
 {
 	if (HPageRawHwpUnreliable(hpage))
 		return;
 	ClearPageHWPoison(hpage);
-	__free_raw_hwp_pages(hpage);
+	free_raw_hwp_pages(hpage, true);
 }
 
 /*
@@ -1889,6 +1912,10 @@ static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *
 	return 0;
 }
 
+static inline unsigned long free_raw_hwp_pages(struct page *hpage, bool flag)
+{
+	return 0;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
@@ -2294,6 +2321,7 @@ int unpoison_memory(unsigned long pfn)
 	struct page *p;
 	int ret = -EBUSY;
 	int freeit = 0;
+	unsigned long count = 1;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -2341,6 +2369,13 @@ int unpoison_memory(unsigned long pfn)
 
 	ret = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ret) {
+		if (PageHuge(p)) {
+			count = free_raw_hwp_pages(page, false);
+			if (count == 0) {
+				ret = -EBUSY;
+				goto unlock_mutex;
+			}
+		}
 		ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
 	} else if (ret < 0) {
 		if (ret == -EHWPOISON) {
@@ -2349,6 +2384,13 @@ int unpoison_memory(unsigned long pfn)
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
 	} else {
+		if (PageHuge(p)) {
+			count = free_raw_hwp_pages(page, false);
+			if (count == 0) {
+				ret = -EBUSY;
+				goto unlock_mutex;
+			}
+		}
 		freeit = !!TestClearPageHWPoison(p);
 
 		put_page(page);
@@ -2361,7 +2403,7 @@ int unpoison_memory(unsigned long pfn)
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
 	if (!ret || freeit) {
-		num_poisoned_pages_dec();
+		num_poisoned_pages_sub(count);
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 page_to_pfn(p), &unpoison_rs);
 	}
-- 
2.25.1

