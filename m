Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F5F57510F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbiGNOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGNOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:48:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35D4C607
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657810094; x=1689346094;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=aEQ9TQKBEZAJvnZaCHYvMD/w0XIhUbWB8CftNPiZ0Ng=;
  b=xAEbQCr2pKC1KIArorqEwRI9/CJAl9YiYeoHM4ysVmyUzCKVh8mmHXVy
   k/0S1xdaiX0fwbvvYRdcae0hg1fN957mYQH0J+fm+f1QajXur3Sgt+W9V
   BkspLu6m6lPlmk6hC+oxQq9E5dAN6nbWDGuqXxhDlUaGYZONXARURUPdJ
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jul 2022 07:48:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 07:48:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 07:48:13 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 07:48:08 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>, <mhocko@suse.com>,
        <vbabka@suse.cz>, <david@redhat.com>, <minchan@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm: fix use-after free of page_ext after race with memory-offline
Date:   Thu, 14 Jul 2022 20:17:43 +0530
Message-ID: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below is one path where race between page_ext and  offline of the
respective memory blocks will cause use-after-free on the access of
page_ext structure.

process1		              process2
---------                             ---------
a)doing /proc/page_owner           doing memory offline
			           through offline_pages.

b)PageBuddy check is failed
thus proceed to get the
page_owner information
through page_ext access.
page_ext = lookup_page_ext(page);

				    migrate_pages();
				    .................
				Since all pages are successfully
				migrated as part of the offline
				operation,send MEM_OFFLINE notification
				where for page_ext it calls:
				offline_page_ext()-->
				__free_page_ext()-->
				   free_page_ext()-->
				     vfree(ms->page_ext)
			           mem_section->page_ext = NULL

c) Check for the PAGE_EXT flags
in the page_ext->flags access
results into the use-after-free(leading
to the translation faults).

As mentioned above, there is really no synchronization between page_ext
access and its freeing in the memory_offline.

The memory offline steps(roughly) on a memory block is as below:
1) Isolate all the pages
2) while(1)
  try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
3) delete the pages from this buddy list.
4) Then free page_ext.(Note: The struct page is still alive as it is
freed only during hot remove of the memory which frees the memmap, which
steps the user might not perform).

This design leads to the state where struct page is alive but the struct
page_ext is freed, where the later is ideally part of the former which
just representing the page_flags. This seems to be a wrong design where
'struct page' as a whole is not accessible(Thanks to Minchan for
pointing this out).

The above mentioned race is just one example __but the problem persists
in the other paths too involving page_ext->flags access(eg:
page_is_idle())__. Since offline waits till the last reference on the
page goes down i.e. any path that took the refcount on the page can make
the memory offline operation to wait. Eg: In the migrate_pages()
operation, we do take the extra refcount on the pages that are under
migration and then we do copy page_owner by accessing page_ext. For

Fix those paths where offline races with page_ext access by maintaining
synchronization with rcu lock.

Thanks to David Hildenbrand for his views/suggestions on the initial
discussion[1].

[1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 include/linux/page_ext.h  | 19 +++++++++++++++++++
 include/linux/page_idle.h | 40 ++++++++++++++++++++++++++++++----------
 mm/page_ext.c             |  3 ++-
 mm/page_owner.c           | 18 +++++++++++++++---
 mm/page_table_check.c     | 10 +++++++---
 5 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index fabb2e1..df5d353 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -64,6 +64,25 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
 	return next;
 }
 
+static inline struct page_ext *get_page_ext(struct page *page)
+{
+	struct page_ext *page_ext;
+
+	rcu_read_lock();
+	page_ext = lookup_page_ext(page);
+	if (!page_ext) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	return page_ext;
+}
+
+static inline void put_page_ext(void)
+{
+	rcu_read_unlock();
+}
+
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
 
diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 4663dfe..0d80f78 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -13,65 +13,85 @@
  * If there is not enough space to store Idle and Young bits in page flags, use
  * page ext flags instead.
  */
-
 static inline bool folio_test_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
+	bool page_young;
 
+	page_ext = get_page_ext(&folio->page);
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_young = test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	put_page_ext();
+
+	return page_young;
 }
 
 static inline void folio_set_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
 
+	page_ext = get_page_ext(&folio->page);
 	if (unlikely(!page_ext))
 		return;
 
 	set_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	put_page_ext();
 }
 
 static inline bool folio_test_clear_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
+	bool page_young;
 
+	page_ext = get_page_ext(&folio->page);
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_and_clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_young = test_and_clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	put_page_ext();
+
+	return page_young;
 }
 
 static inline bool folio_test_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
+	bool page_idle;
 
+	page_ext = get_page_ext(&folio->page);
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_idle =  test_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	put_page_ext();
+
+	return page_idle;
 }
 
 static inline void folio_set_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
 
+	page_ext = get_page_ext(&folio->page);
 	if (unlikely(!page_ext))
 		return;
 
 	set_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	put_page_ext();
 }
 
 static inline void folio_clear_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
 
+	page_ext = get_page_ext(&folio->page);
 	if (unlikely(!page_ext))
 		return;
 
 	clear_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	put_page_ext();
 }
 #endif /* !CONFIG_64BIT */
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3dc715d..5ccd3ee 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
 	if (!ms || !ms->page_ext)
 		return;
 	base = get_entry(ms->page_ext, pfn);
-	free_page_ext(base);
 	ms->page_ext = NULL;
+	synchronize_rcu();
+	free_page_ext(base);
 }
 
 static int __meminit online_page_ext(unsigned long start_pfn,
diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f..d4b9417 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -195,14 +195,16 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext;
 	struct page_owner *page_owner;
 
+	page_ext = get_page_ext(page);
 	if (unlikely(!page_ext))
 		return;
 
 	page_owner = get_page_owner(page_ext);
 	page_owner->last_migrate_reason = reason;
+	put_page_ext();
 }
 
 void __split_page_owner(struct page *page, unsigned int nr)
@@ -288,7 +290,10 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 
 		pageblock_mt = get_pageblock_migratetype(page);
 
+		rcu_read_lock();
 		for (; pfn < block_end_pfn; pfn++) {
+			if (need_resched())
+				cond_resched_rcu();
 			/* The pageblock is online, no need to recheck. */
 			page = pfn_to_page(pfn);
 
@@ -327,6 +332,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 			}
 			pfn += (1UL << page_owner->order) - 1;
 		}
+		rcu_read_unlock();
 	}
 
 	/* Print counts */
@@ -492,6 +498,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	struct page_ext *page_ext;
 	struct page_owner *page_owner;
 	depot_stack_handle_t handle;
+	ssize_t ret = 0;
 
 	if (!static_branch_unlikely(&page_owner_inited))
 		return -EINVAL;
@@ -506,7 +513,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	drain_all_pages(NULL);
 
 	/* Find an allocated page */
+	rcu_read_lock();
 	for (; pfn < max_pfn; pfn++) {
+		if (need_resched())
+			cond_resched_rcu();
 		/*
 		 * If the new page is in a new MAX_ORDER_NR_PAGES area,
 		 * validate the area as existing, skip it if not
@@ -563,11 +573,13 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		/* Record the next PFN to read in the file offset */
 		*ppos = (pfn - min_low_pfn) + 1;
 
-		return print_page_owner(buf, count, pfn, page,
+		ret = print_page_owner(buf, count, pfn, page,
 				page_owner, handle);
+		break;
 	}
+	rcu_read_unlock();
 
-	return 0;
+	return ret;
 }
 
 static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index e206274..66fd49a 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -68,7 +68,7 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	page = pfn_to_page(pfn);
-	page_ext = lookup_page_ext(page);
+	page_ext = get_page_ext(page);
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -83,6 +83,7 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 		}
 		page_ext = page_ext_next(page_ext);
 	}
+	put_page_ext();
 }
 
 /*
@@ -103,7 +104,7 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	page = pfn_to_page(pfn);
-	page_ext = lookup_page_ext(page);
+	page_ext = get_page_ext(page);
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -118,6 +119,7 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 		}
 		page_ext = page_ext_next(page_ext);
 	}
+	put_page_ext();
 }
 
 /*
@@ -126,9 +128,10 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
  */
 void __page_table_check_zero(struct page *page, unsigned int order)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext;
 	unsigned long i;
 
+	page_ext = get_page_ext(page);
 	BUG_ON(!page_ext);
 	for (i = 0; i < (1ul << order); i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
@@ -137,6 +140,7 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 		BUG_ON(atomic_read(&ptc->file_map_count));
 		page_ext = page_ext_next(page_ext);
 	}
+	put_page_ext();
 }
 
 void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
-- 
2.7.4

