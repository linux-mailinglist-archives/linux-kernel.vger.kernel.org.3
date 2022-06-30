Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD4560F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiF3C2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiF3C2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:28:30 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C22B847
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:28:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656556108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDpDnstypIQpWsXVYFpb/N783eDSCsH7VG6URBxsz4o=;
        b=BZpb25Ii9LP1L3cmjCwGtoV4QvPq15QV8ccB3yPqjFwfSWGPDSgLmptrtTHGFI3OHNfSjx
        qkpXpGU76VRMnAvxjq3hATR+NxjGRNhZaLjBk8tt5c+cfIDCFuSpqc7CI4oaJtfJrc7YhC
        NSS6wUCAA7Tw2sXxbm4L84jgQk6P90E=
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
Subject: [PATCH v3 5/9] mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
Date:   Thu, 30 Jun 2022 11:27:51 +0900
Message-Id: <20220630022755.3362349-6-naoya.horiguchi@linux.dev>
In-Reply-To: <20220630022755.3362349-1-naoya.horiguchi@linux.dev>
References: <20220630022755.3362349-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 mm/memory-failure.c     | 32 ++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 9584c2e1c54a..ad62776ee99c 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -494,6 +494,11 @@ static inline void num_poisoned_pages_dec(void)
 	atomic_long_dec(&num_poisoned_pages);
 }
 
+static inline void num_poisoned_pages_sub(long i)
+{
+	atomic_long_sub(i, &num_poisoned_pages);
+}
+
 #else
 
 static inline swp_entry_t make_hwpoison_entry(struct page *page)
@@ -514,6 +519,10 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
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
index 71414eb90a7a..dc90bfadb1dd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1557,22 +1557,33 @@ static inline int hugetlb_set_page_hwpoison(struct page *hpage,
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
@@ -1714,6 +1725,10 @@ static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *
 {
 	return 0;
 }
+
+static inline void free_raw_hwp_pages(struct page *hpage, bool move_flag)
+{
+}
 #endif
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
@@ -2173,6 +2188,7 @@ int unpoison_memory(unsigned long pfn)
 	struct page *p;
 	int ret = -EBUSY;
 	int freeit = 0;
+	long count = 1;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -2220,6 +2236,8 @@ int unpoison_memory(unsigned long pfn)
 
 	ret = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ret) {
+		if (PageHuge(p))
+			count = free_raw_hwp_pages(page, false);
 		ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
 	} else if (ret < 0) {
 		if (ret == -EHWPOISON) {
@@ -2228,6 +2246,8 @@ int unpoison_memory(unsigned long pfn)
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
 	} else {
+		if (PageHuge(p))
+			count = free_raw_hwp_pages(page, false);
 		freeit = !!TestClearPageHWPoison(p);
 
 		put_page(page);
@@ -2240,7 +2260,7 @@ int unpoison_memory(unsigned long pfn)
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

