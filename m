Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA694D794C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiCNCPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiCNCPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:15:02 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38741FB4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:13:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647224030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HmZJDaJz/YW+RAaAgW5cxomg9hhNVz7JL5wG+y4Nka8=;
        b=ayYPlc5reDvT7sBTmPkxVknC1FpX8Xt/V7RonQorERM1EvaMK011KX0bY/jQamw+IMsDvc
        MGZJDRsodrOYsoa+JAqDsWrMjo79CJBT+yL6Vrr7+dT0CPmyfl6BmdpfwCWXyIk6zkg/fb
        x4a3JXbZ5biE33XQqHO+QR/ROXm2270=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock in memory_failure_hugetlb()
Date:   Mon, 14 Mar 2022 11:13:37 +0900
Message-Id: <20220314021337.333781-1-naoya.horiguchi@linux.dev>
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
free/demotion, which causes setting PageHWPoison flag on the wrong page
(which was a hugetlb when memory_failure() was called, but was removed
or demoted when memory_failure_hugetlb() is called).  This results in
killing wrong processes.  So set PageHWPoison flag with holding page lock,

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
ChangeLog v1 -> v2:
- pass subpage to get_hwpoison_huge_page() instead of head page.
- call compound_head() in hugetlb_lock to avoid race with hugetlb
  demotion/free.
---
 mm/hugetlb.c        |  8 +++++---
 mm/memory-failure.c | 33 +++++++++++++++------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

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
index a9bfd04d2a3c..c40c00c3a261 100644
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
 
@@ -1503,24 +1502,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	int res;
 	unsigned long page_flags;
 
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
-
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
@@ -1553,13 +1539,16 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	page_flags = head->flags;
 
 	if (hwpoison_filter(p)) {
-		if (TestClearPageHWPoison(head))
-			num_poisoned_pages_dec();
 		put_page(p);
 		res = -EOPNOTSUPP;
 		goto out;
 	}
 
+	if (TestSetPageHWPoison(head))
+		goto already_hwpoisoned;
+
+	num_poisoned_pages_inc();
+
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1585,6 +1574,14 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 out:
 	unlock_page(head);
 	return res;
+already_hwpoisoned:
+	put_page(p);
+	unlock_page(head);
+	pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
+	res = -EHWPOISON;
+	if (flags & MF_ACTION_REQUIRED)
+		res = kill_accessing_process(current, page_to_pfn(head), flags);
+	return res;
 }
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
-- 
2.25.1

