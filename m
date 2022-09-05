Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9D5ACA77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiIEGWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiIEGWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:22:18 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5AD2CE22
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:22:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662358935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJKmQBcrfqjRJ7vJe0VgHKDJG/ZTJxuNlianmOytPC4=;
        b=GqjZ2HY6ixn3Q6PsBSb1oIPpXpTKNnhcPJ+LjiO6VJRmjy3qgnpcVjTqKzisan0dnC7an0
        dRzhW9LH3rrXfBUpKvST7f/WeZiCwGcoeqr8heKUJFQvtmLc+gWnP/0xKbbZ0GIxmgywpb
        tw5sxGPxHjKhNTRggiM5Mpdcbdi/7cU=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c
Date:   Mon,  5 Sep 2022 15:21:35 +0900
Message-Id: <20220905062137.1455537-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

These interfaces will be used by drivers/base/core.c by later patch, so as a
preparatory work move them to more common header file visible to the file.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 arch/parisc/kernel/pdt.c |  3 +--
 include/linux/mm.h       |  4 ++++
 include/linux/swapops.h  | 25 -------------------------
 mm/memory-failure.c      | 15 +++++++++++++++
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index e391b175f5ec..fdc880e2575a 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -18,8 +18,7 @@
 #include <linux/kthread.h>
 #include <linux/initrd.h>
 #include <linux/pgtable.h>
-#include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/mm.h>
 
 #include <asm/pdc.h>
 #include <asm/pdcpat.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21f8b27bd9fd..b81dd600e51a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3202,6 +3202,10 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
 	return 0;
 }
+
+static inline void num_poisoned_pages_inc()
+{
+}
 #endif
 
 #ifndef arch_memory_failure
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index ddc98f96ad2c..55afc2aaba6b 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -459,8 +459,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 
 #ifdef CONFIG_MEMORY_FAILURE
 
-extern atomic_long_t num_poisoned_pages __read_mostly;
-
 /*
  * Support for hardware poisoned pages
  */
@@ -488,21 +486,6 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
 	return p;
 }
 
-static inline void num_poisoned_pages_inc(void)
-{
-	atomic_long_inc(&num_poisoned_pages);
-}
-
-static inline void num_poisoned_pages_dec(void)
-{
-	atomic_long_dec(&num_poisoned_pages);
-}
-
-static inline void num_poisoned_pages_sub(long i)
-{
-	atomic_long_sub(i, &num_poisoned_pages);
-}
-
 #else
 
 static inline swp_entry_t make_hwpoison_entry(struct page *page)
@@ -519,14 +502,6 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
 {
 	return NULL;
 }
-
-static inline void num_poisoned_pages_inc(void)
-{
-}
-
-static inline void num_poisoned_pages_sub(long i)
-{
-}
 #endif
 
 static inline int non_swap_entry(swp_entry_t entry)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7b077da568ff..b6236c721f54 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -74,6 +74,21 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
+static inline void num_poisoned_pages_inc(void)
+{
+	atomic_long_inc(&num_poisoned_pages);
+}
+
+static inline void num_poisoned_pages_dec(void)
+{
+	atomic_long_dec(&num_poisoned_pages);
+}
+
+static inline void num_poisoned_pages_sub(long i)
+{
+	atomic_long_sub(i, &num_poisoned_pages);
+}
+
 /*
  * Return values:
  *   1:   the page is dissolved (if needed) and taken off from buddy,
-- 
2.25.1

