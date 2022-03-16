Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ACB4DA77B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352994AbiCPBrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbiCPBrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:47:12 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D8B49CB4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:45:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647395156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kbgkznVqkhRyygm7Wkhn7gkfWhlLOzowLT6FpBrIY1s=;
        b=eX7SR30C2NmI4aPID3qK1Mvzqy8unCbuIzYtdt+26/cI3XKvXQXdiW/5su8oQw5zULX+Mc
        T/ZjoffML9tTl1IkGMM2xp4URRr/O7hP07Ds1LOxGU7ZWJoDpmleGoirxYNJmqxE/vjCNL
        3dpAe+cdTfl3tByLBcgbWoVPtOqzUKU=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/hwpoison: set PageHWPoison after passing prechecks in memory_failure_hugetlb()
Date:   Wed, 16 Mar 2022 10:45:34 +0900
Message-Id: <20220316014534.224447-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

There is a race condition between memory_failure_hugetlb() and hugetlb
free/demotion, which causes setting PageHWPoison flag on the wrong page
(which was a hugetlb when memory_failure() was called, but was removed
or demoted when memory_failure_hugetlb() is called).  This results in
killing wrong processes.  So set PageHWPoison flag after passing prechecks.

The actual user-visible effect might be obscure because even if
memory_failure() works as expected, some random process could be killed.
Even worse, the actual error is left unhandled, so no one prevents later
access to it, which might lead to more serious results like consuming
corrupted data.

This patch depends on Miaohe's patch titled "mm/memory-failure.c: fix
race with changing page compound again".

Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: <stable@vger.kernel.org>
---
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
 mm/hugetlb.c        |  8 +++++---
 mm/memory-failure.c | 43 +++++++++++++++++++++----------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f294db835f4b..345fed90842e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6761,14 +6761,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 
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
index a9bfd04d2a3c..c66d75b45864 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1193,7 +1193,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(page, &hugetlb);
 	if (hugetlb)
 		return ret;
 
@@ -1280,11 +1280,10 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 static int __get_unpoison_page(struct page *page)
 {
-	struct page *head = compound_head(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(page, &hugetlb);
 	if (hugetlb)
 		return ret;
 
@@ -1502,34 +1501,21 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
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
+	bool already_hwpoisoned = false;
 
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
 			res = MF_FAILED;
-			if (__page_handle_poison(p)) {
-				page_ref_inc(p);
+			if (page_handle_poison(p, true, false))
 				res = MF_RECOVERED;
-			}
 			action_result(pfn, MF_MSG_FREE_HUGE, res);
 			return res == MF_RECOVERED ? 0 : -EBUSY;
 		} else if (res < 0) {
@@ -1553,13 +1539,18 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	page_flags = head->flags;
 
 	if (hwpoison_filter(p)) {
-		if (TestClearPageHWPoison(head))
-			num_poisoned_pages_dec();
-		put_page(p);
+		put = true;
 		res = -EOPNOTSUPP;
 		goto out;
 	}
 
+	if (TestSetPageHWPoison(head)) {
+		put = already_hwpoisoned = true;
+		goto out;
+	}
+
+	num_poisoned_pages_inc();
+
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1584,6 +1575,14 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	return identify_page_state(pfn, p, page_flags);
 out:
 	unlock_page(head);
+	if (put)
+		put_page(p);
+	if (already_hwpoisoned) {
+		pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
+		res = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, page_to_pfn(head), flags);
+	}
 	return res;
 }
 
-- 
2.25.1

