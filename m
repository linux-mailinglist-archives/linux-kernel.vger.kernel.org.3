Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D464DD420
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiCRFRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiCRFRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:17:45 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A918D281
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 22:16:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647580583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l+axAZXdLVFkX805+58UNfp6Wl2brqbrEYbO4yXNixk=;
        b=eJaWu39EeE0Qwtn4ajIJ3bUXsi7+QT+VnW5PqtBy4ap0rGmYU6R/xkBLXYMzIZoBeGQCRI
        MXqHWE9SeOS0JeKfeZEsCOXIuF6UJFziZs//wI0DhVPQ9eViig6Os/a4x5uvTUFngOUiCj
        h2tspKw1jYwqNhL8QyH87zlFkBi0VEg=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()
Date:   Fri, 18 Mar 2022 14:16:12 +0900
Message-Id: <20220318051612.271802-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

The compound_head is called outside hugetlb_lock, so the head is not
reliable.

So set PageHWPoison flag after passing prechecks. And to detect
potential violation, this patch also introduces a new action type
MF_MSG_DIFFERENT_PAGE_SIZE.

Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
---
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
 mm/hugetlb.c        |  8 +++--
 mm/memory-failure.c | 75 +++++++++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fbf598bbc4e3..d8ef67c049e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6777,14 +6777,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 {
+	struct page *head;
 	int ret = 0;
 
 	*hugetlb = false;
 	spin_lock_irq(&hugetlb_lock);
-	if (PageHeadHuge(page)) {
+	head = compound_head(page);
+	if (PageHeadHuge(head)) {
 		*hugetlb = true;
-		if (HPageFreed(page) || HPageMigratable(page))
-			ret = get_page_unless_zero(page);
+		if (HPageFreed(head) || HPageMigratable(head))
+			ret = get_page_unless_zero(head);
 		else
 			ret = -EBUSY;
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e939719c0765..9323a5653dec 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1194,7 +1194,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(page, &hugetlb);
 	if (hugetlb)
 		return ret;
 
@@ -1281,11 +1281,10 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 static int __get_unpoison_page(struct page *page)
 {
-	struct page *head = compound_head(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(page, &hugetlb);
 	if (hugetlb)
 		return ret;
 
@@ -1504,39 +1503,38 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	struct page *head = compound_head(p);
 	int res;
 	unsigned long page_flags;
-
-	if (TestSetPageHWPoison(head)) {
-		pr_err("Memory failure: %#lx: already hardware poisoned\n",
-		       pfn);
-		res = -EHWPOISON;
-		if (flags & MF_ACTION_REQUIRED)
-			res = kill_accessing_process(current, page_to_pfn(head), flags);
-		return res;
-	}
-
-	num_poisoned_pages_inc();
+	bool put = false;
+	unsigned long already_hwpoisoned = 0;
 
 	if (!(flags & MF_COUNT_INCREASED)) {
 		res = get_hwpoison_page(p, flags);
 		if (!res) {
 			lock_page(head);
 			if (hwpoison_filter(p)) {
-				if (TestClearPageHWPoison(head))
-					num_poisoned_pages_dec();
 				unlock_page(head);
 				return -EOPNOTSUPP;
 			}
 			unlock_page(head);
-			res = MF_FAILED;
-			if (__page_handle_poison(p)) {
-				page_ref_inc(p);
+			if (page_handle_poison(p, true, false)) {
 				res = MF_RECOVERED;
+			} else {
+				if (TestSetPageHWPoison(head))
+					already_hwpoisoned = page_to_pfn(head);
+				else
+					num_poisoned_pages_inc();
+				res = MF_FAILED;
 			}
 			action_result(pfn, MF_MSG_FREE_HUGE, res);
-			return res == MF_RECOVERED ? 0 : -EBUSY;
+			res = res == MF_RECOVERED ? 0 : -EBUSY;
+			goto out;
 		} else if (res < 0) {
+			if (TestSetPageHWPoison(p))
+				already_hwpoisoned = pfn;
+			else
+				num_poisoned_pages_inc();
 			action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-			return -EBUSY;
+			res = -EBUSY;
+			goto out;
 		}
 	}
 
@@ -1547,21 +1545,31 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	 * If this happens just bail out.
 	 */
 	if (!PageHuge(p) || compound_head(p) != head) {
+		if (TestSetPageHWPoison(p))
+			already_hwpoisoned = pfn;
+		else
+			num_poisoned_pages_inc();
 		action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
 		res = -EBUSY;
-		goto out;
+		goto unlock_page;
 	}
 
 	page_flags = head->flags;
 
 	if (hwpoison_filter(p)) {
-		if (TestClearPageHWPoison(head))
-			num_poisoned_pages_dec();
-		put_page(p);
+		put = true;
 		res = -EOPNOTSUPP;
-		goto out;
+		goto unlock_page;
+	}
+
+	if (TestSetPageHWPoison(head)) {
+		put = true;
+		already_hwpoisoned = page_to_pfn(head);
+		goto unlock_page;
 	}
 
+	num_poisoned_pages_inc();
+
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1574,18 +1582,27 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (huge_page_size(page_hstate(head)) > PMD_SIZE) {
 		action_result(pfn, MF_MSG_NON_PMD_HUGE, MF_IGNORED);
 		res = -EBUSY;
-		goto out;
+		goto unlock_page;
 	}
 
 	if (!hwpoison_user_mappings(p, pfn, flags, head)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
-		goto out;
+		goto unlock_page;
 	}
 
 	return identify_page_state(pfn, p, page_flags);
-out:
+unlock_page:
 	unlock_page(head);
+out:
+	if (put)
+		put_page(p);
+	if (already_hwpoisoned) {
+		pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
+		res = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, already_hwpoisoned, flags);
+	}
 	return res;
 }
 
-- 
2.25.1

