Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0775983B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbiHRNBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiHRNAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:00:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC766A57
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:00:45 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7lKY569pzlWJd;
        Thu, 18 Aug 2022 20:57:37 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 21:00:42 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/6] mm, hwpoison: kill procs if unmap fails
Date:   Thu, 18 Aug 2022 21:00:15 +0800
Message-ID: <20220818130016.45313-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220818130016.45313-1-linmiaohe@huawei.com>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If try_to_unmap() fails, the hwpoisoned page still resides in the address
space of some processes. We should kill these processes or the hwpoisoned
page might be consumed later. collect_procs() is always called to collect
relevant processes now so they can be killed later if unmap fails.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a2f4e8b00a26..5f9615a86296 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1396,7 +1396,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success;
-	int kill = 1, forcekill;
+	int forcekill;
 	bool mlocked = PageMlocked(hpage);
 
 	/*
@@ -1437,7 +1437,6 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		if (page_mkclean(hpage)) {
 			SetPageDirty(hpage);
 		} else {
-			kill = 0;
 			ttu |= TTU_IGNORE_HWPOISON;
 			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
 				pfn);
@@ -1452,8 +1451,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * Error handling: We ignore errors here because
 	 * there's nothing that can be done.
 	 */
-	if (kill)
-		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
+	collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
 	if (PageHuge(hpage) && !PageAnon(hpage)) {
 		/*
@@ -1495,7 +1493,8 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * use a more force-full uncatchable kill to prevent
 	 * any accesses to the poisoned memory.
 	 */
-	forcekill = PageDirty(hpage) || (flags & MF_MUST_KILL);
+	forcekill = PageDirty(hpage) || (flags & MF_MUST_KILL) ||
+		    !unmap_success;
 	kill_procs(&tokill, forcekill, !unmap_success, pfn, flags);
 
 	return unmap_success;
-- 
2.23.0

