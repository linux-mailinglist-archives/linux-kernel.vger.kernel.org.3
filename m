Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B1511027
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357677AbiD0Ec2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357694AbiD0EcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:32:22 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB159156E03
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:29:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651033745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7e1Yfv3+WJ1fxThypP2QZLDZeirFxR4HqHmaF3bZjlA=;
        b=aUCORwS68E5McyVQBtJuE1xfpGbKspsKYsA73An8M7dgGg2jXwmKaxOfBHK+vTh+Ybuqhm
        RbYaDMhrg8Ct30WsJQL40gpZQwRucwVZpbA7tc/YJM5KcxB8RJas6h7m2r4YWw5haVrxkp
        PhWnKc6fmlZthsdkoh80jU3Mjzcbvys=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/4] mm, hwpoison: add parameter unpoison to get_hwpoison_huge_page()
Date:   Wed, 27 Apr 2022 13:28:40 +0900
Message-Id: <20220427042841.678351-4-naoya.horiguchi@linux.dev>
In-Reply-To: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now hwpoisoned hugepage is expected to be !HPageMigratable, so grabbing
hugepage for unpoison should negate the check from that for poisoning.
This patch implements it by logical XOR.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/hugetlb.h | 5 +++--
 mm/hugetlb.c            | 4 ++--
 mm/memory-failure.c     | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 689e69cb556b..99b7ded651f6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -171,7 +171,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool isolate_huge_page(struct page *page, struct list_head *list);
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
+int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 void putback_active_hugepage(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
@@ -377,7 +377,8 @@ static inline bool isolate_huge_page(struct page *page, struct list_head *list)
 	return false;
 }
 
-static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
+static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb,
+					bool unpoison)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95b1db852ca9..0fbdfa753b54 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6788,7 +6788,7 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
+int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
 {
 	int ret = 0;
 
@@ -6798,7 +6798,7 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 		*hugetlb = true;
 		if (HPageFreed(page))
 			ret = 0;
-		else if (HPageMigratable(page))
+		else if (!unpoison != !HPageMigratable(page))
 			ret = get_page_unless_zero(page);
 		else
 			ret = -EBUSY;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4a2e22bf0983..b5ee3cbc7fbc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1190,7 +1190,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(head, &hugetlb, false);
 	if (hugetlb)
 		return ret;
 
@@ -1283,7 +1283,7 @@ static int __get_unpoison_page(struct page *page)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(head, &hugetlb, true);
 	if (hugetlb)
 		return ret;
 
-- 
2.25.1

