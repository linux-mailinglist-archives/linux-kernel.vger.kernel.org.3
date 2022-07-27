Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25022582859
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiG0OQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiG0OQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:16:11 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2231154
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658931361; x=1690467361;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ZeSLk703Kk/EL2qDpzKtwfyofFx4c9jGD+TuLOL030I=;
  b=bwaWEDvKkeN1RdRnV+ISeE0lVoaZkX2GzZcAA/EiFgsn2tfqjRcBYnOo
   JdQZnHN9VExPC2ZknlNymeDhAx0/zNRRq8wZjRskK8SUBvi87+dWmss/Y
   ct2p0ZwY/rJFpQ/n9wt9ViJF5pN6f2cZ8gUpy/mnzdRGk8sw9u4nRD0V4
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jul 2022 07:16:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 07:16:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 07:16:00 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 07:15:55 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hocko@suse.com>, <david@redhat.com>,
        <quic_pkondeti@quicinc.com>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>,
        <liuting.0x7c00@bytedance.com>, <minchan@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V2] mm: fix use-after free of page_ext after race with memory-offline
Date:   Wed, 27 Jul 2022 19:45:03 +0530
Message-ID: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
just representing the page_flags.

The above mentioned race is just one example __but the problem persists
in the other paths too involving page_ext->flags access(eg:
page_is_idle())__. Since offline waits till the last reference on the
page goes down i.e. any path that took the refcount on the page can make
the memory offline operation to wait. Eg: In the migrate_pages()
operation, we do take the extra refcount on the pages that are under
migration and then we do copy page_owner by accessing page_ext. For

Fix those paths where offline races with page_ext access by maintaining
synchronization with rcu lock and is achieved in 3 steps:
1) Invalidate all the page_ext's of the sections of a memory block by
storing a flag in the LSB of mem_section->page_ext.

2) Wait till all the existing readers to finish working with the
->page_ext's with synchronize_rcu(). Any parallel process that starts
after this call will not get page_ext, through lookup_page_ext(), for
the block parallel offline operation is being performed.

3) Now safely free all sections ->page_ext's of the block on which
offline operation is being performed.

Thanks to David Hildenbrand for his views/suggestions on the initial
discussion[1] and Pavan kondeti for various inputs on this patch.

FAQ's:
Q) Should page_ext_[get|put]() needs to be used for every page_ext
access?
A) NO, the synchronization is really not needed in all the paths of
accessing page_ext. One case is where extra refcount is taken on a
page for which memory block, this pages falls into, offline operation is
being performed. This extra refcount makes the offline operation not to
succeed hence the freeing of page_ext.  Another case is where the page
is already being freed and we do reset its page_owner.

Some examples where the rcu_lock is not taken while accessing the
page_ext are:
1) In migration (where we also migrate the page_owner information), we
take the extra refcount on the source and destination pages and then
start the migration. This extra refcount makes the test_pages_isolated()
function to fail thus retry the offline operation.

2) In free_pages_prepare(), we do reset the page_owner(through page_ext)
which again doesn't need the protection to access because the page is
already freeing (through only one path).

So, users need not to use page_ext_[get|put]() when they are sure that
extra refcount is taken on a page preventing the offline operation.

Q) Why can't the page_ext is freed in the hot_remove path, where memmap
is also freed ?

A) As per David's answers, there are many reasons and a few are:
1) Discussions had happened in the past to eventually also use rcu
protection for handling pfn_to_online_page(). So doing it cleanly here
is certainly an improvement.

2) It's not good having to scatter section online checks all over the
place in page ext code. Once there is a difference between active vs.
stale page ext data things get a bit messy and error prone. This is
already ugly enough in our generic memmap handling code.

3) Having on-demand allocations, such as KASAN or page ext from the
memory online notifier is at least currently cleaner, because we don't
have to handle each and every subsystem that hooks into that during the
core memory hotadd/remove phase, which primarily only setups the
vmemmap, direct map and memory block devices.

[1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
Changes in V2:
   o Use only get/put_page_ext() to get the page_ext in the 
     required paths. Add proper comments for them.
   o Use synchronize_rcu() only once instead of calling it for
     every mem_section::page_ext of a memory block.
   o Free'd page_ext in 3 steps of invalidate, wait till all the
     users are finished using and then finally free page_ext.

Changes in V1:
   o Used the RCU lock while accessing the page_ext in the paths that
     can race with the memory offline operation.
   o Introduced (get|put)_page_ext() function to get the page_ext of page.
   o https://lore.kernel.org/all/1657810063-28938-1-git-send-email-quic_charante@quicinc.com/

 include/linux/page_ext.h  | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/page_idle.h | 40 ++++++++++++++++++++++++++---------
 mm/page_ext.c             | 41 ++++++++++++++++++++++++++++++++----
 mm/page_owner.c           | 35 +++++++++++++++++++++++--------
 mm/page_table_check.c     | 10 ++++++---
 5 files changed, 153 insertions(+), 26 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index fabb2e1..3a35c95 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/stacktrace.h>
 #include <linux/stackdepot.h>
+#include <linux/rcupdate.h>
 
 struct pglist_data;
 struct page_ext_operations {
@@ -36,6 +37,8 @@ struct page_ext {
 	unsigned long flags;
 };
 
+#define PAGE_EXT_INVALID       (0x1)
+
 extern unsigned long page_ext_size;
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
 
@@ -57,6 +60,11 @@ static inline void page_ext_init(void)
 
 struct page_ext *lookup_page_ext(const struct page *page);
 
+static inline bool page_ext_invalid(struct page_ext *page_ext)
+{
+	return !page_ext || (((unsigned long)page_ext & PAGE_EXT_INVALID) == 1);
+}
+
 static inline struct page_ext *page_ext_next(struct page_ext *curr)
 {
 	void *next = curr;
@@ -64,6 +72,37 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
 	return next;
 }
 
+/*
+ * This function gives proper page_ext of a memory section
+ * during race with the offline operation on a memory block
+ * this section falls into. Not using this function to get
+ * page_ext of a page, in code paths where extra refcount
+ * is not taken on that page eg: pfn walking, can lead to
+ * use-after-free access of page_ext.
+ */
+static inline struct page_ext *page_ext_get(struct page *page)
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
+/*
+ * Must be called after work is done with the page_ext received
+ * with page_ext_get().
+ */
+static inline void page_ext_put(void)
+{
+	rcu_read_unlock();
+}
+
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
 
@@ -87,5 +126,19 @@ static inline void page_ext_init_flatmem_late(void)
 static inline void page_ext_init_flatmem(void)
 {
 }
+
+static inline struct page_ext *page_ext_get(struct page *page)
+{
+	return NULL;
+}
+
+static inline bool page_ext_invalid(struct page_ext *page_ext)
+{
+	return true;
+}
+
+static inline void page_ext_put(void)
+{
+}
 #endif /* CONFIG_PAGE_EXTENSION */
 #endif /* __LINUX_PAGE_EXT_H */
diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 4663dfe..3dd3718 100644
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
 
+	page_ext = page_ext_get(&folio->page);
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_young = test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_ext_put();
+
+	return page_young;
 }
 
 static inline void folio_set_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
 
+	page_ext = page_ext_get(&folio->page);
 	if (unlikely(!page_ext))
 		return;
 
 	set_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_ext_put();
 }
 
 static inline bool folio_test_clear_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
+	bool page_young;
 
+	page_ext = page_ext_get(&folio->page);
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_and_clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_young = test_and_clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_ext_put();
+
+	return page_young;
 }
 
 static inline bool folio_test_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
+	bool page_idle;
 
+	page_ext = page_ext_get(&folio->page);
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_idle =  test_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_ext_put();
+
+	return page_idle;
 }
 
 static inline void folio_set_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
 
+	page_ext = page_ext_get(&folio->page);
 	if (unlikely(!page_ext))
 		return;
 
 	set_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_ext_put();
 }
 
 static inline void folio_clear_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext;
 
+	page_ext = page_ext_get(&folio->page);
 	if (unlikely(!page_ext))
 		return;
 
 	clear_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_ext_put();
 }
 #endif /* !CONFIG_64BIT */
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3dc715d..404a2eb 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -211,15 +211,17 @@ struct page_ext *lookup_page_ext(const struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	struct mem_section *section = __pfn_to_section(pfn);
+	struct page_ext *page_ext = READ_ONCE(section->page_ext);
+
 	/*
 	 * The sanity checks the page allocator does upon freeing a
 	 * page can reach here before the page_ext arrays are
 	 * allocated when feeding a range of pages to the allocator
 	 * for the first time during bootup or memory hotplug.
 	 */
-	if (!section->page_ext)
+	if (page_ext_invalid(page_ext))
 		return NULL;
-	return get_entry(section->page_ext, pfn);
+	return get_entry(page_ext, pfn);
 }
 
 static void *__meminit alloc_page_ext(size_t size, int nid)
@@ -298,9 +300,26 @@ static void __free_page_ext(unsigned long pfn)
 	ms = __pfn_to_section(pfn);
 	if (!ms || !ms->page_ext)
 		return;
-	base = get_entry(ms->page_ext, pfn);
+
+	base = READ_ONCE(ms->page_ext);
+	if (page_ext_invalid(base))
+		base = (void *)base - PAGE_EXT_INVALID;
+	WRITE_ONCE(ms->page_ext, NULL);
+
+	base = get_entry(base, pfn);
 	free_page_ext(base);
-	ms->page_ext = NULL;
+}
+
+static void __invalidate_page_ext(unsigned long pfn)
+{
+	struct mem_section *ms;
+	void *val;
+
+	ms = __pfn_to_section(pfn);
+	if (!ms || !ms->page_ext)
+		return;
+	val = (void *)ms->page_ext + PAGE_EXT_INVALID;
+	WRITE_ONCE(ms->page_ext, val);
 }
 
 static int __meminit online_page_ext(unsigned long start_pfn,
@@ -343,6 +362,20 @@ static int __meminit offline_page_ext(unsigned long start_pfn,
 	start = SECTION_ALIGN_DOWN(start_pfn);
 	end = SECTION_ALIGN_UP(start_pfn + nr_pages);
 
+	/*
+	 * Freeing of page_ext is done in 3 steps to avoid
+	 * use-after-free of it:
+	 * 1) Traverse all the sections and mark their page_ext
+	 *    as invalid.
+	 * 2) Wait for all the existing users of page_ext who
+	 *    started before invalidation to finish.
+	 * 3) Free the page_ext.
+	 */
+	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
+		__invalidate_page_ext(pfn);
+
+	synchronize_rcu();
+
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
 		__free_page_ext(pfn);
 	return 0;
diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f..0520dda 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -195,14 +195,16 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext;
 	struct page_owner *page_owner;
 
+	page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
 		return;
 
 	page_owner = get_page_owner(page_ext);
 	page_owner->last_migrate_reason = reason;
+	page_ext_put();
 }
 
 void __split_page_owner(struct page *page, unsigned int nr)
@@ -307,12 +309,12 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 			if (PageReserved(page))
 				continue;
 
-			page_ext = lookup_page_ext(page);
+			page_ext = page_ext_get(page);
 			if (unlikely(!page_ext))
 				continue;
 
 			if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
-				continue;
+				goto loop;
 
 			page_owner = get_page_owner(page_ext);
 			page_mt = gfp_migratetype(page_owner->gfp_mask);
@@ -323,9 +325,12 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					count[pageblock_mt]++;
 
 				pfn = block_end_pfn;
+				page_ext_put();
 				break;
 			}
 			pfn += (1UL << page_owner->order) - 1;
+loop:
+			page_ext_put();
 		}
 	}
 
@@ -508,6 +513,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	/* Find an allocated page */
 	for (; pfn < max_pfn; pfn++) {
 		/*
+		 * This temporary page_owner is required so
+		 * that we can avoid the context switches while holding
+		 * the rcu lock and copying the page owner information to
+		 * user through copy_to_user() or GFP_KERNEL allocations.
+		 */
+		struct page_owner page_owner_tmp = {0};
+
+		/*
 		 * If the new page is in a new MAX_ORDER_NR_PAGES area,
 		 * validate the area as existing, skip it if not
 		 */
@@ -525,7 +538,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			continue;
 		}
 
-		page_ext = lookup_page_ext(page);
+		page_ext = page_ext_get(page);
 		if (unlikely(!page_ext))
 			continue;
 
@@ -534,14 +547,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * because we don't hold the zone lock.
 		 */
 		if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
-			continue;
+			goto loop;
 
 		/*
 		 * Although we do have the info about past allocation of free
 		 * pages, it's not relevant for current memory usage.
 		 */
 		if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
-			continue;
+			goto loop;
 
 		page_owner = get_page_owner(page_ext);
 
@@ -550,7 +563,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * would inflate the stats.
 		 */
 		if (!IS_ALIGNED(pfn, 1 << page_owner->order))
-			continue;
+			goto loop;
 
 		/*
 		 * Access to page_ext->handle isn't synchronous so we should
@@ -558,13 +571,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 */
 		handle = READ_ONCE(page_owner->handle);
 		if (!handle)
-			continue;
+			goto loop;
 
 		/* Record the next PFN to read in the file offset */
 		*ppos = (pfn - min_low_pfn) + 1;
 
+		memcpy(&page_owner_tmp, page_owner, sizeof(struct page_owner));
+		page_ext_put();
 		return print_page_owner(buf, count, pfn, page,
-				page_owner, handle);
+				&page_owner_tmp, handle);
+loop:
+		page_ext_put();
 	}
 
 	return 0;
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index e206274..ec371b9 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -68,7 +68,7 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	page = pfn_to_page(pfn);
-	page_ext = lookup_page_ext(page);
+	page_ext = page_ext_get(page);
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -83,6 +83,7 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 		}
 		page_ext = page_ext_next(page_ext);
 	}
+	page_ext_put();
 }
 
 /*
@@ -103,7 +104,7 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	page = pfn_to_page(pfn);
-	page_ext = lookup_page_ext(page);
+	page_ext = page_ext_get(page);
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -118,6 +119,7 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 		}
 		page_ext = page_ext_next(page_ext);
 	}
+	page_ext_put();
 }
 
 /*
@@ -126,9 +128,10 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
  */
 void __page_table_check_zero(struct page *page, unsigned int order)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext;
 	unsigned long i;
 
+	page_ext = page_ext_get(page);
 	BUG_ON(!page_ext);
 	for (i = 0; i < (1ul << order); i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
@@ -137,6 +140,7 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 		BUG_ON(atomic_read(&ptc->file_map_count));
 		page_ext = page_ext_next(page_ext);
 	}
+	page_ext_put();
 }
 
 void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
-- 
2.7.4

