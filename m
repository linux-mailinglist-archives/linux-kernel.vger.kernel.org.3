Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E888053B2D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiFBFHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiFBFHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:07:15 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC4DDED3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:07:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654146432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyOll928F39kd/7foHlO9PskbUXpYx8gLtnTg/AubRM=;
        b=to/byFHDEZZzBz+ilC/vfPbbmmbqN7PiQmd0smz+yne4xEr2XU2AH65Fg0Tnud3ecAlDJz
        FjXLi5/eDhzXNNo+JEGgffe+Rn968fx5TUGzR0HboszyNIpZpWYUz+FjleC//0o9bzQSIP
        hSnBYUPQDJT3hQmSwN79f6q6g1WQ1WY=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] mm, hwpoison: make __page_handle_poison returns int
Date:   Thu,  2 Jun 2022 14:06:29 +0900
Message-Id: <20220602050631.771414-4-naoya.horiguchi@linux.dev>
In-Reply-To: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
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

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

__page_handle_poison() returns bool that shows whether
take_page_off_buddy() has passed or not now.  But we will want to
distinguish another case of "dissolve has passed but taking off failed"
by its return value. So change the type of the return value.
No functional change.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fe6a7961dc66..f149a7864c81 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -68,7 +68,13 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
-static bool __page_handle_poison(struct page *page)
+/*
+ * Return values:
+ *   1:   the page is dissolved (if needed) and taken off from buddy,
+ *   0:   the page is dissolved (if needed) and not taken off from buddy,
+ *   < 0: failed to dissolve.
+ */
+static int __page_handle_poison(struct page *page)
 {
 	int ret;
 
@@ -78,7 +84,7 @@ static bool __page_handle_poison(struct page *page)
 		ret = take_page_off_buddy(page);
 	zone_pcp_enable(page_zone(page));
 
-	return ret > 0;
+	return ret;
 }
 
 static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
@@ -88,7 +94,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 		 * Doing this check for free pages is also fine since dissolve_free_huge_page
 		 * returns 0 for non-hugetlb pages as well.
 		 */
-		if (!__page_handle_poison(page))
+		if (__page_handle_poison(page) <= 0)
 			/*
 			 * We could fail to take off the target page from buddy
 			 * for example due to racy page allocation, but that's
@@ -1045,7 +1051,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		 * save healthy subpages.
 		 */
 		put_page(hpage);
-		if (__page_handle_poison(p)) {
+		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		}
@@ -1595,8 +1601,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 */
 	if (res == 0) {
 		unlock_page(head);
-		res = MF_FAILED;
-		if (__page_handle_poison(p)) {
+		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		}
-- 
2.25.1

