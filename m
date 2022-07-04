Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DE4564B30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiGDBdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiGDBdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:33:47 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85618FF2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:33:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656898425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c53xJY5QAxTG48EN3l+VCLDr5GeKFcglkHzWuOKhYL0=;
        b=LVkfQK7TP20FdAXxwrCEQ/qn/NIIMGsYJ2y6Yo78cU7uWNBr0+fMpVD3Rd36gpqVUY1MN7
        xRM1YMSgVgKONPP9/HZ+981vjWqgmZ9AMvDav6i5sjwQDyvb6vapcL0Hu7zAlpwF4LfHve
        LrtdgjLn7o+lPMvfaG4NywfEz8qrOkQ=
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
Subject: [mm-unstable PATCH v4 5/9] mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
Date:   Mon,  4 Jul 2022 10:33:08 +0900
Message-Id: <20220704013312.2415700-6-naoya.horiguchi@linux.dev>
In-Reply-To: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
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

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/swapops.h |  9 +++++++++
 mm/memory-failure.c     | 31 +++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

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
index 53bf7486a245..6af2096d8ea0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1722,22 +1722,33 @@ static inline int hugetlb_set_page_hwpoison(struct page *hpage,
 	return ret;
 }
 
-inline int hugetlb_clear_page_hwpoison(struct page *hpage)
+static inline long free_raw_hwp_pages(struct page *hpage, bool move_flag)
 {
 	struct llist_head *head;
 	struct llist_node *t, *tnode;
+	long count = 0;
 
-	if (!HPageRawHwpUnreliable(hpage))
-		ClearPageHWPoison(hpage);
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
-	return 0;
+	return count;
+}
+
+inline int hugetlb_clear_page_hwpoison(struct page *hpage)
+{
+	int ret = -EBUSY;
+
+	if (!HPageRawHwpUnreliable(hpage))
+		ret = !TestClearPageHWPoison(hpage);
+	free_raw_hwp_pages(hpage, true);
+	return ret;
 }
 
 /*
@@ -1882,6 +1893,9 @@ static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *
 	return 0;
 }
 
+static inline void free_raw_hwp_pages(struct page *hpage, bool move_flag)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
@@ -2287,6 +2301,7 @@ int unpoison_memory(unsigned long pfn)
 	struct page *p;
 	int ret = -EBUSY;
 	int freeit = 0;
+	long count = 1;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -2334,6 +2349,8 @@ int unpoison_memory(unsigned long pfn)
 
 	ret = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ret) {
+		if (PageHuge(p))
+			count = free_raw_hwp_pages(page, false);
 		ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
 	} else if (ret < 0) {
 		if (ret == -EHWPOISON) {
@@ -2342,6 +2359,8 @@ int unpoison_memory(unsigned long pfn)
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
 	} else {
+		if (PageHuge(p))
+			count = free_raw_hwp_pages(page, false);
 		freeit = !!TestClearPageHWPoison(p);
 
 		put_page(page);
@@ -2354,7 +2373,7 @@ int unpoison_memory(unsigned long pfn)
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

