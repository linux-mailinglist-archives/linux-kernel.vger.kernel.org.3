Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480BC53B2DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiFBFH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiFBFHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:07:08 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A30ABC8A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:07:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654146423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvjgKpSpd6vLLDTvBjr5eSnjiZxFu3lgcpJpXhpnkYU=;
        b=huhz5I1gFAwH66TksJg8V8xQm8U25z83Rs/uca4PVrJXeak9ugEQpvHMJZUIbkZ5K9kKaZ
        TcQ6mseCkGfF5IlXQbeAHprjP7LCR5gnbRs0PQ5uqZxjRiVMVW0upMK5hCgytyLGy/v7Wx
        +ugdNGgrtZZI+PRpMWhGGbrbyJIB6Bw=
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
Subject: [PATCH v1 1/5] mm, hwpoison, hugetlb: introduce SUBPAGE_INDEX_HWPOISON to save raw error page
Date:   Thu,  2 Jun 2022 14:06:27 +0900
Message-Id: <20220602050631.771414-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
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

When handling memory error on a hugetlb page, the error handler tries to
dissolve and turn it into 4kB pages.  If it's successfully dissolved,
PageHWPoison flag is moved to the raw error page, so that's all right.
However, dissolve sometimes fails, then the error page is left as
hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
healthy pages, but that's not possible now because the information about
where the raw error page is lost.

Use the private field of a tail page to keep that information.  The code
path of shrinking hugepage pool used this info to try delayed dissolve.
This only keeps one hwpoison page for now, which might be OK because it's
simple and multiple hwpoison pages in a hugepage can be rare. But it can
be extended in the future.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog since previous post on 4/27:
- fixed typo in patch description (by Miaohe)
- fixed config value in #ifdef statement (by Miaohe)
- added sentences about "multiple hwpoison pages" scenario in patch
  description
---
 include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
 mm/hugetlb.c            |  9 +++++++++
 mm/memory-failure.c     |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ac2a1d758a80..a5341a3a0d4b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -42,6 +42,9 @@ enum {
 	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
 	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
 	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
+#endif
+#ifdef CONFIG_MEMORY_FAILURE
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
index 66edaa7e5092..056dbb2050f8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1534,6 +1534,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 		goto out;
 	}
 
+	hugetlb_set_page_hwpoison(head, page);
+
 	return ret;
 out:
 	if (count_increased)
-- 
2.25.1

