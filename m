Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D92950A137
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387673AbiDUNx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384863AbiDUNxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:53:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F7D13FAC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:51:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kkf7z4hZmzhXbZ;
        Thu, 21 Apr 2022 21:50:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 21:51:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/memory_hotplug: avoid consuming corrupted data when offline pages
Date:   Thu, 21 Apr 2022 21:51:28 +0800
Message-ID: <20220421135129.19767-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to offline pages, HWPoisoned hugepage is migrated without
checking PageHWPoison first. So corrupted data could be consumed. Fix
it by deferring isolate_huge_page until PageHWPoison is handled.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory_hotplug.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4c6065e5d274..093f85ec5c5c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1600,11 +1600,9 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		folio = page_folio(page);
 		head = &folio->page;
 
-		if (PageHuge(page)) {
+		if (PageHuge(page))
 			pfn = page_to_pfn(head) + compound_nr(head) - 1;
-			isolate_huge_page(head, &source);
-			continue;
-		} else if (PageTransHuge(page))
+		else if (PageTransHuge(page))
 			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
 
 		/*
@@ -1622,6 +1620,11 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			continue;
 		}
 
+		if (PageHuge(page)) {
+			isolate_huge_page(head, &source);
+			continue;
+		}
+
 		if (!get_page_unless_zero(page))
 			continue;
 		/*
-- 
2.23.0

