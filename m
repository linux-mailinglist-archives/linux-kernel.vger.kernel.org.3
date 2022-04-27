Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497BF51102A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357690AbiD0Ece (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357704AbiD0Ec0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:32:26 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D421594B9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:29:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651033749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eItuMRrHX4Os0FsD9ZvtHrWEjjS1bDgCgiQWK4LzGH8=;
        b=Q/L/bZLR2KByUYsk0eKAUGr4PH3NUZja3XUO0pphORYpe2Rj7I0j0E8fs/cZgyDX/WahYp
        09fcfU+W8FupvA87f9W0dG+wtisEPzXqeStjOqyflUdvzWcdv0AuLrYisdZAoSasUl0Jor
        l4AoypbWmeThkIg4PlM2aCefocljWNw=
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
Subject: [RFC PATCH v1 4/4] mm, memory_hotplug: fix inconsistent num_poisoned_pages on memory hotremove
Date:   Wed, 27 Apr 2022 13:28:41 +0900
Message-Id: <20220427042841.678351-5-naoya.horiguchi@linux.dev>
In-Reply-To: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

When offlining memory section with hwpoisoned pages, the hwpoisons are
canceled. But num_poisoned_pages is not updated for that event, so the
counter becomes inconsistent.

Add num_poisoned_pages_dec() in __offline_isolated_pages(). PageHWPoison
can be set on a tail page of some high order buddy page, so we need check
PageHWPoison on each subpage.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/page_alloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6e5b4488a0c5..dcd962855617 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9487,12 +9487,15 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 	zone = page_zone(pfn_to_page(pfn));
 	spin_lock_irqsave(&zone->lock, flags);
 	while (pfn < end_pfn) {
+		int i;
+
 		page = pfn_to_page(pfn);
 		/*
 		 * The HWPoisoned page may be not in buddy system, and
 		 * page_count() is not 0.
 		 */
 		if (unlikely(!PageBuddy(page) && PageHWPoison(page))) {
+			num_poisoned_pages_dec();
 			pfn++;
 			continue;
 		}
@@ -9510,6 +9513,9 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		BUG_ON(page_count(page));
 		BUG_ON(!PageBuddy(page));
 		order = buddy_order(page);
+		for (i = 0; i < 1 << order; i++)
+			if (PageHWPoison(page + i))
+				num_poisoned_pages_dec();
 		del_page_from_free_list(page, zone, order);
 		pfn += (1 << order);
 	}
-- 
2.25.1

