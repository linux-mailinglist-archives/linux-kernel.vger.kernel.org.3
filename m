Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB90511028
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357671AbiD0EcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357666AbiD0EcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:32:09 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31094A901
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:28:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651033737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhFv468URMziQMW888ZYB3zUqaYOfFeInA7ZUvxhWkc=;
        b=FIkAxocmKdaKVf5IxSOBZWld4OyWK+kxFY3MwdXcu6ZQBpNw203KwgWMbt+dNNyuZSUFkx
        fZ6F9Iu6x7FM54n99F6JvN0fC8yTDgxwtGGhEV1XNgxY77wfRgdSMRbaIIPisBRPaGfuFf
        z0TkMtNqa1+2tjPtjsnsUwno22b75aY=
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
Subject: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce SUBPAGE_INDEX_HWPOISON to save raw error page
Date:   Wed, 27 Apr 2022 13:28:38 +0900
Message-Id: <20220427042841.678351-2-naoya.horiguchi@linux.dev>
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

When handling memory error on a hugetlb page, the error handler tries to
dissolve and turn it into 4kB pages.  If it's successfully dissolved,
PageHWPoison flag is moved to the raw error page, so but that's all
right.  However, dissolve sometimes fails, then the error page is left
as hwpoisoned hugepage. It's useful if we can retry to dissolve it to
save healthy pages, but that's not possible now because the information
about where the raw error page is lost.

Use the private field of a tail page to keep that information.  The code
path of shrinking hugepage pool used this info to try delayed dissolve.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
 mm/hugetlb.c            |  9 +++++++++
 mm/memory-failure.c     |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ac2a1d758a80..689e69cb556b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -42,6 +42,9 @@ enum {
 	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
 	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
 	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
+#endif
+#ifdef CONFIG_CGROUP_HUGETLB
+	SUBPAGE_INDEX_HWPOISON,
 #endif
 	__NR_USED_SUBPAGE,
 };
@@ -784,6 +787,27 @@ extern int dissolve_free_huge_page(struct page *page);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
 
+#ifdef CONFIG_MEMORY_FAILURE
+/*
+ * pointer to raw error page is located in hpage[SUBPAGE_INDEX_HWPOISON].private
+ */
+static inline struct page *hugetlb_page_hwpoison(struct page *hpage)
+{
+	return (void *)page_private(hpage + SUBPAGE_INDEX_HWPOISON);
+}
+
+static inline void hugetlb_set_page_hwpoison(struct page *hpage,
+					struct page *page)
+{
+	set_page_private(hpage + SUBPAGE_INDEX_HWPOISON, (unsigned long)page);
+}
+#else
+static inline struct page *hugetlb_page_hwpoison(struct page *hpage)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 #ifndef arch_hugetlb_migration_supported
 static inline bool arch_hugetlb_migration_supported(struct hstate *h)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f8e048b939c7..6867ea8345d1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1547,6 +1547,15 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		return;
 	}
 
+	if (unlikely(PageHWPoison(page))) {
+		struct page *raw_error = hugetlb_page_hwpoison(page);
+
+		if (raw_error && raw_error != page) {
+			SetPageHWPoison(raw_error);
+			ClearPageHWPoison(page);
+		}
+	}
+
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3e36fc19c4d1..73948a00ad4a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1535,6 +1535,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 		goto out;
 	}
 
+	hugetlb_set_page_hwpoison(head, page);
+
 	return ret;
 out:
 	if (count_increased)
-- 
2.25.1

