Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780BD4DAF58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355574AbiCPMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348457AbiCPMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:08:35 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2444742
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:07:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647432436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RbK8wcRXS/gbIGdf1HMCtYrNLHf43xPBtDhVLjeuoDw=;
        b=Lqng1x2wfSMhut0upKUETUGk8HQ+hRnN3A5ogy3T15qtdkbZ4p1ODnZ5LkwabLNKIr7Yuh
        uSz5X9b5zw0kdTF1q39KD9eblQW/r/EzP+HgTewJ3jceP1zxUzNdm+XtlXY9eRZ9Ijzc4z
        Ww5Aa20SGK/fw8fYJEtaPmakIOk1mR8=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()
Date:   Wed, 16 Mar 2022 21:07:01 +0900
Message-Id: <20220316120701.394061-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

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
 include/linux/mm.h      |  1 +
 include/ras/ras_event.h |  1 +
 mm/hugetlb.c            |  8 +++---
 mm/memory-failure.c     | 55 ++++++++++++++++++++++++-----------------
 4 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5744a3fc4716..68c101b399b7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3244,6 +3244,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
+	MF_MSG_DIFFERENT_PAGE_SIZE,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index d0337a41141c..1e694fd239b9 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -374,6 +374,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
+	EM ( MF_MSG_DIFFERENT_PAGE_SIZE, "different page size" )	\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
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
index 59d0de9beb60..5842aaadcc99 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -732,6 +732,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
+	[MF_MSG_DIFFERENT_PAGE_SIZE]	= "different page size",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1192,7 +1193,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(page, &hugetlb);
 	if (hugetlb)
 		return ret;
 
@@ -1279,11 +1280,10 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 static int __get_unpoison_page(struct page *page)
 {
-	struct page *head = compound_head(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(page, &hugetlb);
 	if (hugetlb)
 		return ret;
 
@@ -1501,34 +1501,21 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
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
@@ -1538,16 +1525,32 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	}
 
 	lock_page(head);
+
+	/*
+	 * The page could have changed compound pages due to race window.
+	 * If this happens just bail out.
+	 */
+	if (!PageHuge(p) || compound_head(p) != head) {
+		action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
+		res = -EBUSY;
+		goto out;
+	}
+
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
@@ -1572,6 +1575,14 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
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

