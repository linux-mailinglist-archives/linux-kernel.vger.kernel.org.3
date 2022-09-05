Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763755ACA7D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiIEGWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiIEGWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:22:13 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E92CE22
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:22:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662358931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucAIXNnH5R2gOfgMvHbR1y7ug9n/ezUmfveCIJw4IxY=;
        b=ASM6HcWZzDLxIDXs3ez6SRtQhvGY3pPYeVjp5UhQSb4qv3mL+xT5hh7Qb0N6USjo4XDIWS
        JIO6ZYdRQqpOMgdLzA+JiCmflMW8UrAFrA3yqYD3NyoawZpIBB1E6LRtznziKUchM2IOm4
        6GyjKk9KlgbmHYdoU+2LrbRLBKQ9gpY=
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
Subject: [PATCH v2 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
Date:   Mon,  5 Sep 2022 15:21:34 +0900
Message-Id: <20220905062137.1455537-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

HWPoisoned page is not supposed to be accessed once marked, but currently
such accesses can happen during memory hotremove because do_migrate_range()
can be called before dissolve_free_huge_pages() is called.

Move dissolve_free_huge_pages() before scan_movable_pages(). Recently
delayed dissolve has been implemented, so the dissolving can turn
a hwpoisoned hugepage into 4kB hwpoison page, which memory hotplug can
handle safely.

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory_hotplug.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fad6d1f2262a..c24735d63b25 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1880,6 +1880,17 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
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
@@ -1895,17 +1906,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
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
 
 	} while (ret);
-- 
2.25.1

