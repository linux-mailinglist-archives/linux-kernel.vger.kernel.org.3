Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14454F7E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbiDGLfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244810AbiDGLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:35:15 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD51226FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 04:33:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649331192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3Mxsn683Q+P8Nu5Td0dAYWZemeujB8UjXyT9REwn34Y=;
        b=E7eHa2L08AHRD6sMG4IRj4VmpSgziYHsh+2hqdaZl+nIgNmeYIOxuCMUQ3HeW+3AJlGe7v
        m77eJ08meSjlFQV52aUvzldPePasEbKciuw6sfxFKOtTPiQnXlmWoqY5BFxMHCCjryj/g5
        ydqHvK8eiK7DxL5EDGH10SFj89+SwXk=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7] mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()
Date:   Thu,  7 Apr 2022 20:29:29 +0900
Message-Id: <20220407112929.1344748-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

There is a race condition between memory_failure_hugetlb() and hugetlb
free/demotion, which causes setting PageHWPoison flag on the wrong page.
The one simple result is that wrong processes can be killed, but another
(more serious) one is that the actual error is left unhandled, so no one
prevents later access to it, and that might lead to more serious results
like consuming corrupted data.

Think about the below race window:

  CPU 1                                   CPU 2
  memory_failure_hugetlb
  struct page *head = compound_head(p);
                                          hugetlb page might be freed to
                                          buddy, or even changed to another
                                          compound page.

  get_hwpoison_page -- page is not what we want now...

The current code first does prechecks roughly and then reconfirms
after taking refcount, but it's found that it makes code overly
complicated, so move the prechecks in a single hugetlb_lock range.

A newly introduced function, try_memory_failure_hugetlb(), always
takes hugetlb_lock (even for non-hugetlb pages).  That can be
improved, but memory_failure() is rare in principle, so should
not be a big problem.

Fixes: 761ad8d7c7b5 ("mm: hwpoison: introduce memory_failure_hugetlb()")
Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: stable@vger.kernel.org
---
ChangeLog v6 -> v7:
- Move lock_page() to try_memory_failure_hugetlb()
  (based on bug report from Dan Carpenter)
- Add Fixes: tag and CC to stable.

ChangeLog v5 -> v6:
- Moved racy precheck operations into hugetlb_lock (based on
  Mike's comment).
- rebased onto v5.18-rc1.
- dropped CC to stable.

ChangeLog v4 -> v5:
- call TestSetPageHWPoison() when page_handle_poison() fails.
- call TestSetPageHWPoison() for unhandlable cases (MF_MSG_UNKNOWN and
  MF_MSG_DIFFERENT_PAGE_SIZE).
- Set PageHWPoison on the head page only when the error page is surely
  a hugepage, otherwise set the flag on the raw page.
- rebased onto v5.17-rc8-mmotm-2022-03-16-17-42

ChangeLog v3 -> v4:
- squash with "mm/memory-failure.c: fix race with changing page
  compound again".
- update patch subject and description based on it.

ChangeLog v2 -> v3:
- rename the patch because page lock is not the primary factor to
  solve the reported issue.
- updated description in the same manner.
- call page_handle_poison() instead of __page_handle_poison() for
  free hugepage case.
- reorder put_page and unlock_page (thanks to Miaohe Lin)

ChangeLog v1 -> v2:
- pass subpage to get_hwpoison_huge_page() instead of head page.
- call compound_head() in hugetlb_lock to avoid race with hugetlb
  demotion/free.
---
 include/linux/hugetlb.h |   6 ++
 include/linux/mm.h      |   8 +++
 mm/hugetlb.c            |  10 +++
 mm/memory-failure.c     | 142 +++++++++++++++++++++++++++++-----------
 4 files changed, 126 insertions(+), 40 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53c1b6082a4c..ac2a1d758a80 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -169,6 +169,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool isolate_huge_page(struct page *page, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
+int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 void putback_active_hugepage(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
@@ -378,6 +379,11 @@ static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 	return 0;
 }
 
+static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+{
+	return 0;
+}
+
 static inline void putback_active_hugepage(struct page *page)
 {
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e34edb775334..9f44254af8ce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3197,6 +3197,14 @@ extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
+#ifdef CONFIG_MEMORY_FAILURE
+extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
+#else
+static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+{
+	return 0;
+}
+#endif
 
 #ifndef arch_memory_failure
 static inline int arch_memory_failure(unsigned long pfn, int flags)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b34f50156f7e..c4f19e1a0807 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6782,6 +6782,16 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 	return ret;
 }
 
+int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+{
+	int ret;
+
+	spin_lock_irq(&hugetlb_lock);
+	ret = __get_huge_page_for_hwpoison(pfn, flags);
+	spin_unlock_irq(&hugetlb_lock);
+	return ret;
+}
+
 void putback_active_hugepage(struct page *page)
 {
 	spin_lock_irq(&hugetlb_lock);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index dcb6bb9cf731..3606800d3488 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1498,48 +1498,112 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
 	return 0;
 }
 
-static int memory_failure_hugetlb(unsigned long pfn, int flags)
+/*
+ * Called from hugetlb code with hugetlb_lock held.
+ *
+ * Return values:
+ *   0             - free hugepage
+ *   1             - in-use hugepage
+ *   2             - not a hugepage
+ *   -EBUSY        - the hugepage is busy (try to retry)
+ *   -EOPNOTSUPP   - error handling is cancelled due to hwpoison_filter()
+ *   -EHWPOISON    - the hugepage is already hwpoisoned
+ */
+int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+{
+	struct page *page = pfn_to_page(pfn);
+	struct page *head = compound_head(page);
+	int ret = 2;	/* fallback to normal page handling */
+	bool count_increased = false;
+
+	if (!PageHeadHuge(head))
+		goto out;
+
+	if (flags & MF_COUNT_INCREASED) {
+		ret = 1;
+		count_increased = true;
+	} else if (HPageFreed(head) || HPageMigratable(head)) {
+		ret = get_page_unless_zero(head);
+		if (ret)
+			count_increased = true;
+	} else {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (hwpoison_filter(page)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (TestSetPageHWPoison(head)) {
+		ret = -EHWPOISON;
+		goto out;
+	}
+
+	return ret;
+out:
+	if (count_increased)
+		put_page(head);
+	return ret;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+/*
+ * Taking refcount of hugetlb pages needs extra care about race conditions
+ * with basic operations like hugepage allocation/free/demotion.
+ * So all necessary prechecks for hwpoison (like pinning, testing/setting
+ * PageHWPoison, and hwpoison_filter) are done in single hugetlb_lock range.
+ */
+static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
 {
-	struct page *p = pfn_to_page(pfn);
-	struct page *head = compound_head(p);
 	int res;
+	struct page *p = pfn_to_page(pfn);
+	struct page *head;
 	unsigned long page_flags;
+	bool retry = true;
 
-	if (TestSetPageHWPoison(head)) {
-		pr_err("Memory failure: %#lx: already hardware poisoned\n",
-		       pfn);
-		res = -EHWPOISON;
-		if (flags & MF_ACTION_REQUIRED)
+	*hugetlb = 1;
+retry:
+	res = get_huge_page_for_hwpoison(pfn, flags);
+	if (res == 2) { /* fallback to normal page handling */
+		*hugetlb = 0;
+		return 0;
+	} else if (res == -EOPNOTSUPP) {
+		return res;
+	} else if (res == -EHWPOISON) {
+		pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
+		if (flags & MF_ACTION_REQUIRED) {
+			head = compound_head(p);
 			res = kill_accessing_process(current, page_to_pfn(head), flags);
+		}
+		return res;
+	} else if (res == -EBUSY) {
+		if (retry) {
+			retry = false;
+			goto retry;
+		}
+		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
 		return res;
 	}
 
 	num_poisoned_pages_inc();
 
-	if (!(flags & MF_COUNT_INCREASED)) {
-		res = get_hwpoison_page(p, flags);
-		if (!res) {
-			lock_page(head);
-			if (hwpoison_filter(p)) {
-				if (TestClearPageHWPoison(head))
-					num_poisoned_pages_dec();
-				unlock_page(head);
-				return -EOPNOTSUPP;
-			}
-			unlock_page(head);
-			res = MF_FAILED;
-			if (__page_handle_poison(p)) {
-				page_ref_inc(p);
-				res = MF_RECOVERED;
-			}
-			action_result(pfn, MF_MSG_FREE_HUGE, res);
-			return res == MF_RECOVERED ? 0 : -EBUSY;
-		} else if (res < 0) {
-			action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-			return -EBUSY;
+	/*
+	 * Handling free hugepage.  The possible race with hugepage allocation
+	 * or demotion can be prevented by PageHWPoison flag.
+	 */
+	if (res == 0) {
+		res = MF_FAILED;
+		if (__page_handle_poison(p)) {
+			page_ref_inc(p);
+			res = MF_RECOVERED;
 		}
+		action_result(pfn, MF_MSG_FREE_HUGE, res);
+		return res == MF_RECOVERED ? 0 : -EBUSY;
 	}
 
+	head = compound_head(p);
 	lock_page(head);
 
 	/*
@@ -1554,14 +1618,6 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	page_flags = head->flags;
 
-	if (hwpoison_filter(p)) {
-		if (TestClearPageHWPoison(head))
-			num_poisoned_pages_dec();
-		put_page(p);
-		res = -EOPNOTSUPP;
-		goto out;
-	}
-
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1588,6 +1644,12 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	unlock_page(head);
 	return res;
 }
+#else
+static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
+{
+	return 0;
+}
+#endif
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
@@ -1712,6 +1774,7 @@ int memory_failure(unsigned long pfn, int flags)
 	int res = 0;
 	unsigned long page_flags;
 	bool retry = true;
+	int hugetlb = 0;
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -1739,10 +1802,9 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 try_again:
-	if (PageHuge(p)) {
-		res = memory_failure_hugetlb(pfn, flags);
+	res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
+	if (hugetlb)
 		goto unlock_mutex;
-	}
 
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
-- 
2.25.1

