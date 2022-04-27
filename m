Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F041511026
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357685AbiD0EcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357674AbiD0EcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:32:13 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C94BB95
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:29:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651033741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aX7odo5pcxf80dhjL+1ki2q7oMjNnbh5/VzkH5pVqg=;
        b=EKimL9Toxeqt4HnHJHW5pRSliyYwJNFr9WPy84AXTdu3zPV6CCK1gzxtzJ+LCRxxYt2BYh
        gBkQNKGYCvwoIb+XERgEhAUCTZaC2S9/q/TpjM5aTQQhpyvlef1g3TGgjrTU99sAcs+N71
        F52kfL5TtQhvSQrQwaNLhxnNHymIzlA=
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
Subject: [RFC PATCH v1 2/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
Date:   Wed, 27 Apr 2022 13:28:39 +0900
Message-Id: <20220427042841.678351-3-naoya.horiguchi@linux.dev>
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

HWPoisoned page is not supposed to prevent memory hotremove, but
currently this does not properly work for hwpoisoned hugepages and the
kernel tries to migrate them, which could cause consuming corrupted
data.

Move dissolve_free_huge_pages() before scan_movable_pages(). This is
because the result of the movable check depends on the result of the
dissolve.  Now delayed dissolve is available, so hwpoisoned hugepages
can be turned into 4kB hwpoison page which memory hotplug can handle.

And clear HPageMigratable pseudo flag for hwpoisoned hugepages. This is
also important because dissolve_free_huge_page() can fail.  So it's
still necessary to prevent do_migrate_pages() from trying to migrate
hwpoison hugepages.

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/hugetlb.c        | 11 +++++++++++
 mm/memory-failure.c |  2 ++
 mm/memory_hotplug.c | 23 +++++++++++------------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6867ea8345d1..95b1db852ca9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2159,6 +2159,17 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
 		page = pfn_to_page(pfn);
+
+		if (PageHuge(page) && PageHWPoison(page)) {
+			/*
+			 * Release the last refcount from hwpoison to turn into
+			 * a free hugepage.
+			 */
+			if (page_count(page) == 1)
+				put_page(page);
+			page = hugetlb_page_hwpoison(page);
+		}
+
 		rc = dissolve_free_huge_page(page);
 		if (rc)
 			break;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 73948a00ad4a..4a2e22bf0983 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1607,6 +1607,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		return res == MF_RECOVERED ? 0 : -EBUSY;
 	}
 
+	ClearHPageMigratable(head);
+
 	page_flags = head->flags;
 
 	/*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 416b38ca8def..4bc0590f4334 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1864,6 +1864,17 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 			cond_resched();
 
+			/*
+			 * Dissolve free hugepages in the memory block before doing
+			 * offlining actually in order to make hugetlbfs's object
+			 * counting consistent.
+			 */
+			ret = dissolve_free_huge_pages(start_pfn, end_pfn);
+			if (ret) {
+				reason = "failure to dissolve huge pages";
+				goto failed_removal_isolated;
+			}
+
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
 			if (!ret) {
 				/*
@@ -1879,19 +1890,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			goto failed_removal_isolated;
 		}
 
-		/*
-		 * Dissolve free hugepages in the memory block before doing
-		 * offlining actually in order to make hugetlbfs's object
-		 * counting consistent.
-		 */
-		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
-		if (ret) {
-			reason = "failure to dissolve huge pages";
-			goto failed_removal_isolated;
-		}
-
 		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
-
 	} while (ret);
 
 	/* Mark all sections offline and remove free pages from the buddy. */
-- 
2.25.1

