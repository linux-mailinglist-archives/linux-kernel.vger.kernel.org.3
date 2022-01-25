Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8008149A8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1321803AbiAYDTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:19:49 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:54178 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1318649AbiAYDGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:06:54 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 25 Jan 2022 11:36:47 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 25 Jan 2022 11:36:47 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com
Subject: [RFC 12/14] dept: Apply Dept to wait/event of PG_{locked,writeback}
Date:   Tue, 25 Jan 2022 11:36:42 +0900
Message-Id: <1643078204-12663-13-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
References: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by PG_{locked,writeback}. For
instance, (un)lock_page() generates that type of dependency.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept_page.h       | 71 +++++++++++++++++++++++++++++++++++++++++
 include/linux/page-flags.h      | 26 +++++++++++++--
 include/linux/pagemap.h         |  7 +++-
 init/main.c                     |  2 ++
 kernel/dependency/dept_object.h |  2 +-
 lib/Kconfig.debug               |  1 +
 mm/filemap.c                    | 62 +++++++++++++++++++++++++++++++++++
 mm/page_ext.c                   |  5 +++
 8 files changed, 172 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/dept_page.h

diff --git a/include/linux/dept_page.h b/include/linux/dept_page.h
new file mode 100644
index 0000000..3fa75d2
--- /dev/null
+++ b/include/linux/dept_page.h
@@ -0,0 +1,71 @@
+#ifndef __LINUX_DEPT_PAGE_H
+#define __LINUX_DEPT_PAGE_H
+
+#ifdef CONFIG_DEPT
+#include <linux/dept.h>
+
+extern struct page_ext_operations dept_pglocked_ops;
+extern struct page_ext_operations dept_pgwriteback_ops;
+extern struct dept_map_common pglocked_mc;
+extern struct dept_map_common pgwriteback_mc;
+
+extern void dept_page_init(void);
+extern struct dept_map_each *get_pglocked_me(struct page *page);
+extern struct dept_map_each *get_pgwriteback_me(struct page *page);
+
+#define dept_pglocked_wait(p)					\
+do {								\
+	struct dept_map_each *me = get_pglocked_me(p);		\
+	if (likely(me))						\
+		dept_wait_split_map(me, &pglocked_mc, _RET_IP_, \
+				    __func__, 0);		\
+} while (0)
+
+#define dept_pglocked_set_bit(p)				\
+do {								\
+	struct dept_map_each *me = get_pglocked_me(p);		\
+	if (likely(me))						\
+		dept_asked_event_split_map(me, &pglocked_mc);	\
+} while (0)
+
+#define dept_pglocked_event(p)					\
+do {								\
+	struct dept_map_each *me = get_pglocked_me(p);		\
+	if (likely(me))						\
+		dept_event_split_map(me, &pglocked_mc, _RET_IP_,\
+				     __func__);			\
+} while (0)
+
+#define dept_pgwriteback_wait(p)				\
+do {								\
+	struct dept_map_each *me = get_pgwriteback_me(p);	\
+	if (likely(me))						\
+		dept_wait_split_map(me, &pgwriteback_mc, _RET_IP_,\
+				    __func__, 0);		\
+} while (0)
+
+#define dept_pgwriteback_set_bit(p)				\
+do {								\
+	struct dept_map_each *me = get_pgwriteback_me(p);	\
+	if (likely(me))						\
+		dept_asked_event_split_map(me, &pgwriteback_mc);\
+} while (0)
+
+#define dept_pgwriteback_event(p)				\
+do {								\
+	struct dept_map_each *me = get_pgwriteback_me(p);	\
+	if (likely(me))						\
+		dept_event_split_map(me, &pgwriteback_mc, _RET_IP_,\
+				     __func__);			\
+} while (0)
+#else
+#define dept_page_init()		do { } while (0)
+#define dept_pglocked_wait(p)		do { } while (0)
+#define dept_pglocked_set_bit(p)	do { } while (0)
+#define dept_pglocked_event(p)		do { } while (0)
+#define dept_pgwriteback_wait(p)	do { } while (0)
+#define dept_pgwriteback_set_bit(p)	do { } while (0)
+#define dept_pgwriteback_event(p)	do { } while (0)
+#endif
+
+#endif /* __LINUX_DEPT_PAGE_H */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4f6ba93..4e79f4e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -326,7 +326,6 @@ static inline void page_init_poison(struct page *page, size_t size)
 #define TESTSCFLAG_FALSE(uname)						\
 	TESTSETFLAG_FALSE(uname) TESTCLEARFLAG_FALSE(uname)
 
-__PAGEFLAG(Locked, locked, PF_NO_TAIL)
 PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
 PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
 PAGEFLAG(Referenced, referenced, PF_HEAD)
@@ -374,7 +373,6 @@ static inline void page_init_poison(struct page *page, size_t size)
  * risky: they bypass page accounting.
  */
 TESTPAGEFLAG(Writeback, writeback, PF_NO_TAIL)
-	TESTSCFLAG(Writeback, writeback, PF_NO_TAIL)
 PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
@@ -444,6 +442,30 @@ static __always_inline int PageSwapCache(struct page *page)
 PAGEFLAG(Idle, idle, PF_ANY)
 #endif
 
+#ifdef CONFIG_DEPT
+TESTPAGEFLAG(Locked, locked, PF_NO_TAIL)
+__CLEARPAGEFLAG(Locked, locked, PF_NO_TAIL)
+TESTCLEARFLAG(Writeback, writeback, PF_NO_TAIL)
+
+#include <linux/dept_page.h>
+static __always_inline void __SetPageLocked(struct page *page)
+{
+	dept_pglocked_set_bit(page);
+	__set_bit(PG_locked, &PF_NO_TAIL(page, 1)->flags);
+}
+
+static __always_inline int TestSetPageWriteback(struct page *page)
+{
+	int ret = test_and_set_bit(PG_writeback, &PF_NO_TAIL(page, 1)->flags);
+	if (!ret)
+		dept_pgwriteback_set_bit(page);
+	return ret;
+}
+#else
+__PAGEFLAG(Locked, locked, PF_NO_TAIL)
+TESTSCFLAG(Writeback, writeback, PF_NO_TAIL)
+#endif
+
 /*
  * PageReported() is used to track reported free pages within the Buddy
  * allocator. We can use the non-atomic version of the test and set
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d5570de..475a880 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/hardirq.h> /* for in_interrupt() */
 #include <linux/hugetlb_inline.h>
+#include <linux/dept_page.h>
 
 struct pagevec;
 
@@ -597,8 +598,12 @@ extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
  */
 static inline int trylock_page(struct page *page)
 {
+	int ret;
 	page = compound_head(page);
-	return (likely(!test_and_set_bit_lock(PG_locked, &page->flags)));
+	ret = test_and_set_bit_lock(PG_locked, &page->flags);
+	if (likely(!ret))
+		dept_pglocked_set_bit(page);
+	return likely(!ret);
 }
 
 /*
diff --git a/init/main.c b/init/main.c
index 1818a90..5a6f474 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
+#include <linux/pagemap.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -993,6 +994,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 
 	lockdep_init();
 	dept_init();
+	dept_page_init();
 
 	/*
 	 * Need to run this when irqs are enabled, because it wants
diff --git a/kernel/dependency/dept_object.h b/kernel/dependency/dept_object.h
index 3e8ba81..2c4f5f0 100644
--- a/kernel/dependency/dept_object.h
+++ b/kernel/dependency/dept_object.h
@@ -5,7 +5,7 @@
  * nr: # of the object that should be kept in the pool.
  */
 
-OBJECT(dep	,1024 * 8)
+OBJECT(dep	,1024 * 16)
 OBJECT(class	,1024 * 4)
 OBJECT(stack	,1024 * 32)
 OBJECT(ecxt	,1024 * 4)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 51cb690..fd88c3f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1153,6 +1153,7 @@ config DEPT
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
+	select PAGE_EXTENSION
 	select TRACE_IRQFLAGS
 	select STACKTRACE
 	select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86
diff --git a/mm/filemap.c b/mm/filemap.c
index 0b2067b..20cbdc4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1100,6 +1100,11 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	unsigned long flags;
 	wait_queue_entry_t bookmark;
 
+	if (bit_nr == PG_locked)
+		dept_pglocked_event(page);
+	else if (bit_nr == PG_writeback)
+		dept_pgwriteback_event(page);
+
 	key.page = page;
 	key.bit_nr = bit_nr;
 	key.page_match = 0;
@@ -1179,6 +1184,10 @@ static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
 		if (test_and_set_bit(bit_nr, &page->flags))
 			return false;
+		else if (bit_nr == PG_locked)
+			dept_pglocked_set_bit(page);
+		else if (bit_nr == PG_writeback)
+			dept_pgwriteback_set_bit(page);
 	} else if (test_bit(bit_nr, &page->flags))
 		return false;
 
@@ -1199,6 +1208,11 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	bool delayacct = false;
 	unsigned long pflags;
 
+	if (bit_nr == PG_locked)
+		dept_pglocked_wait(page);
+	else if (bit_nr == PG_writeback)
+		dept_pgwriteback_wait(page);
+
 	if (bit_nr == PG_locked &&
 	    !PageUptodate(page) && PageWorkingset(page)) {
 		if (!PageSwapBacked(page)) {
@@ -1291,6 +1305,11 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 		if (unlikely(test_and_set_bit(bit_nr, &page->flags)))
 			goto repeat;
 
+		if (bit_nr == PG_locked)
+			dept_pglocked_set_bit(page);
+		else if (bit_nr == PG_writeback)
+			dept_pgwriteback_set_bit(page);
+
 		wait->flags |= WQ_FLAG_DONE;
 		break;
 	}
@@ -3527,3 +3546,46 @@ int try_to_release_page(struct page *page, gfp_t gfp_mask)
 }
 
 EXPORT_SYMBOL(try_to_release_page);
+
+#ifdef CONFIG_DEPT
+static bool need_dept_pglocked(void)
+{
+	return true;
+}
+
+struct page_ext_operations dept_pglocked_ops = {
+	.size = sizeof(struct dept_map_each),
+	.need = need_dept_pglocked,
+};
+
+struct dept_map_each *get_pglocked_me(struct page *p)
+{
+	struct page_ext *e = lookup_page_ext(p);
+	return e ? (void *)e + dept_pglocked_ops.offset : NULL;
+}
+
+static bool need_dept_pgwriteback(void)
+{
+	return true;
+}
+
+struct page_ext_operations dept_pgwriteback_ops = {
+	.size = sizeof(struct dept_map_each),
+	.need = need_dept_pgwriteback,
+};
+
+struct dept_map_each *get_pgwriteback_me(struct page *p)
+{
+	struct page_ext *e = lookup_page_ext(p);
+	return e ? (void *)e + dept_pgwriteback_ops.offset : NULL;
+}
+
+struct dept_map_common pglocked_mc;
+struct dept_map_common pgwriteback_mc;
+
+void dept_page_init(void)
+{
+	dept_split_map_common_init(&pglocked_mc, NULL, "pglocked");
+	dept_split_map_common_init(&pgwriteback_mc, NULL, "pgwriteback");
+}
+#endif
diff --git a/mm/page_ext.c b/mm/page_ext.c
index a3616f7..0126931 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -8,6 +8,7 @@
 #include <linux/kmemleak.h>
 #include <linux/page_owner.h>
 #include <linux/page_idle.h>
+#include <linux/dept_page.h>
 
 /*
  * struct page extension
@@ -65,6 +66,10 @@
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
 #endif
+#ifdef CONFIG_DEPT
+	&dept_pglocked_ops,
+	&dept_pgwriteback_ops,
+#endif
 };
 
 unsigned long page_ext_size = sizeof(struct page_ext);
-- 
1.9.1

