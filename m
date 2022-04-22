Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B550AFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiDVGE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiDVGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D24FC59
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c12so8617441plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bp+6Mtl+9X8bx0bqhBqFKs5a4ePa+PXv90jlJdkj1lk=;
        b=UtxoZ1JdqW3fcX9auDfKm8675JgAGikYBukOpzndjrb/5obHXJuS5bajo3sXY8v1h1
         jdIy74NZnl4V+AALme7MfYZzkEitt4clzC8B/aHb21JiWCLOlJr1MzyFujlbhcolMOB0
         /f+Y40z4gYEgNUq1xabve/eP3xOjbArMQKNZBgAqpe1U7exem/8jWVnWdr/PhuzIQya8
         sdSKOx8UN1uFZ+SSbw7OxmJng07BsR9qWbPp43X0d9pm+Zy1O9P2pwpermzw8oT88QjE
         5CX6sbVq/kvJ8U3nftnAXr207zwiWHZhZE4P88DijAZJ+8WpRGH4Y+OOdbEMYUp7KGKX
         tlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bp+6Mtl+9X8bx0bqhBqFKs5a4ePa+PXv90jlJdkj1lk=;
        b=FIr4K9ZVOf7W2OS3K7VZR0HPfy6R0PkXhTuG3etM0JReEfdAY/7rJyO44Z9pzohzV2
         WdwXTaSTCLwcTNvxTbL/QXCQQeWkQ2E36ZLIbvPDKgJrEns5zvWbmdzublJgSq6ukeze
         f1UV21yiQnJhWz2CLMn85ykxe8Svu2KhmBrvvo+MnoNw8vcxpmCYOTP0+70TqNQVKGio
         5PrOsMy2AvZf+3jALZmZYYff88z+wloOl0Omnyvp7L97fGxnY7gH7++ZSc3i+UwhFbT9
         HFR1nzrCszP/eUgBHaNsQ7FE1FDR7QbcMggdzUe+e8bZdvTeMt2cWTJiEbeTVBFe4Nqa
         61Jw==
X-Gm-Message-State: AOAM530HZNUjUvENzbH+HbGwiY7Cq33q1JYJwd3sYXgndRnavW4cfc3A
        y4ikaddPq241UpJ/Oro4eTc=
X-Google-Smtp-Source: ABdhPJyE7r4GoOePw5giA255Y5FX9aOWvsph11ITy41jRBpWLTDZLqaV65pwzE9oS2A13aEn9VlUjw==
X-Received: by 2002:a17:90a:4e08:b0:1cb:a3ac:938b with SMTP id n8-20020a17090a4e0800b001cba3ac938bmr14264027pjh.112.1650607283621;
        Thu, 21 Apr 2022 23:01:23 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id y16-20020a637d10000000b00381268f2c6fsm998607pgc.4.2022.04.21.23.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 23:01:23 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] mm/vmalloc: huge vmalloc backing pages should be split rather than compound
Date:   Fri, 22 Apr 2022 16:01:05 +1000
Message-Id: <20220422060107.781512-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422060107.781512-1-npiggin@gmail.com>
References: <20220422060107.781512-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge vmalloc higher-order backing pages were allocated with __GFP_COMP
in order to allow the sub-pages to be refcounted by callers such as
"remap_vmalloc_page [sic]" (remap_vmalloc_range).

However a similar problem exists for other struct page fields callers
use, for example fb_deferred_io_fault() takes a vmalloc'ed page and
not only refcounts it but uses ->lru, ->mapping, ->index. This is not
compatible with compound sub-pages.

The correct approach is to use split high-order pages for the huge
vmalloc backing. These allow callers to treat them in exactly the same
way as individually-allocated order-0 pages.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 07da85ae825b..cadfbb5155ea 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2653,15 +2653,18 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	vm_remove_mappings(area, deallocate_pages);
 
 	if (deallocate_pages) {
-		unsigned int page_order = vm_area_page_order(area);
-		int i, step = 1U << page_order;
+		int i;
 
-		for (i = 0; i < area->nr_pages; i += step) {
+		for (i = 0; i < area->nr_pages; i++) {
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
-			mod_memcg_page_state(page, MEMCG_VMALLOC, -step);
-			__free_pages(page, page_order);
+			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+			/*
+			 * High-order allocs for huge vmallocs are split, so
+			 * can be freed as an array of order-0 allocations
+			 */
+			__free_pages(page, 0);
 			cond_resched();
 		}
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
@@ -2914,12 +2917,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
-	} else
-		/*
-		 * Compound pages required for remap_vmalloc_page if
-		 * high-order pages.
-		 */
-		gfp |= __GFP_COMP;
+	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
 
@@ -2933,6 +2931,15 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			page = alloc_pages_node(nid, gfp, order);
 		if (unlikely(!page))
 			break;
+		/*
+		 * Higher order allocations must be able to be treated as
+		 * indepdenent small pages by callers (as they can with
+		 * small-page vmallocs). Some drivers do their own refcounting
+		 * on vmalloc_to_page() pages, some use page->mapping,
+		 * page->lru, etc.
+		 */
+		if (order)
+			split_page(page, order);
 
 		/*
 		 * Careful, we allocate and map page-order pages, but
@@ -2992,11 +2999,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 	if (gfp_mask & __GFP_ACCOUNT) {
-		int i, step = 1U << page_order;
+		int i;
 
-		for (i = 0; i < area->nr_pages; i += step)
-			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC,
-					     step);
+		for (i = 0; i < area->nr_pages; i++)
+			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
 	}
 
 	/*
-- 
2.35.1

