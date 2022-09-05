Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2217C5ACA73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiIEGW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiIEGWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:22:21 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC17A2B261
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:22:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662358939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BbMhqxmYuU5COA45Jj7QmdMCnLs62eTq+39BWVy6eY=;
        b=IjFxF5qczN8wu+FeEj3Qhjhq/1V0oaMQc25LmtpYuj1uUY4VP8dD5LVY9YyQZ9mNfHuVzH
        UspenGcv02ijkXrI63eUFKBY422C5EGcmiv4obWhAk/rglpi/RPOUFdvNnL6gZFRCcvtmk
        +PZG4ZxxnvmSjxm3py1cyS6xQ+czEPc=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] mm/hwpoison: pass pfn to num_poisoned_pages_*()
Date:   Mon,  5 Sep 2022 15:21:36 +0900
Message-Id: <20220905062137.1455537-4-naoya.horiguchi@linux.dev>
In-Reply-To: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
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

No functional change.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 arch/parisc/kernel/pdt.c |  2 +-
 include/linux/mm.h       |  2 +-
 mm/memory-failure.c      | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index fdc880e2575a..80943a00e245 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -231,7 +231,7 @@ void __init pdc_pdt_init(void)
 
 		/* mark memory page bad */
 		memblock_reserve(pdt_entry[i] & PAGE_MASK, PAGE_SIZE);
-		num_poisoned_pages_inc();
+		num_poisoned_pages_inc(addr >> PAGE_SHIFT);
 	}
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b81dd600e51a..6316973afd1d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3203,7 +3203,7 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 	return 0;
 }
 
-static inline void num_poisoned_pages_inc()
+static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 }
 #endif
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b6236c721f54..7dd4e403e634 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -74,17 +74,17 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
-static inline void num_poisoned_pages_inc(void)
+static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 	atomic_long_inc(&num_poisoned_pages);
 }
 
-static inline void num_poisoned_pages_dec(void)
+static inline void num_poisoned_pages_dec(unsigned long pfn)
 {
 	atomic_long_dec(&num_poisoned_pages);
 }
 
-static inline void num_poisoned_pages_sub(long i)
+static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 	atomic_long_sub(i, &num_poisoned_pages);
 }
@@ -130,7 +130,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 	if (release)
 		put_page(page);
 	page_ref_inc(page);
-	num_poisoned_pages_inc();
+	num_poisoned_pages_inc(page_to_pfn(page));
 
 	return true;
 }
@@ -1196,7 +1196,7 @@ static void action_result(unsigned long pfn, enum mf_action_page_type type,
 {
 	trace_memory_failure_event(pfn, type, result);
 
-	num_poisoned_pages_inc();
+	num_poisoned_pages_inc(pfn);
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
 }
@@ -1743,7 +1743,7 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
 		llist_add(&raw_hwp->node, head);
 		/* the first error event will be counted in action_result(). */
 		if (ret)
-			num_poisoned_pages_inc();
+			num_poisoned_pages_inc(page_to_pfn(page));
 	} else {
 		/*
 		 * Failed to save raw error info.  We no longer trace all
@@ -2408,7 +2408,7 @@ int unpoison_memory(unsigned long pfn)
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
 	if (!ret || freeit) {
-		num_poisoned_pages_sub(count);
+		num_poisoned_pages_sub(pfn, count);
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 page_to_pfn(p), &unpoison_rs);
 	}
@@ -2625,7 +2625,7 @@ void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 
 	for (i = 0; i < nr_pages; i++) {
 		if (PageHWPoison(&memmap[i])) {
-			num_poisoned_pages_dec();
+			num_poisoned_pages_dec(page_to_pfn(&memmap[i]));
 			ClearPageHWPoison(&memmap[i]);
 		}
 	}
-- 
2.25.1

