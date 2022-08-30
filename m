Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B295A637E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiH3Mgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiH3Mgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:36:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B378DAA0E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:36:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH6Dx4Y3VznTjS;
        Tue, 30 Aug 2022 20:34:09 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 20:36:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/6] mm, hwpoison: use num_poisoned_pages_sub() to decrease num_poisoned_pages
Date:   Tue, 30 Aug 2022 20:36:01 +0800
Message-ID: <20220830123604.25763-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220830123604.25763-1-linmiaohe@huawei.com>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Use num_poisoned_pages_sub() to combine multiple atomic ops into one. Also
num_poisoned_pages_dec() can be killed as there's no caller now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swapops.h | 5 -----
 mm/memory-failure.c     | 6 ++++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index dbf9df854124..86b95ccb81bb 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -602,11 +602,6 @@ static inline void num_poisoned_pages_inc(void)
 	atomic_long_inc(&num_poisoned_pages);
 }
 
-static inline void num_poisoned_pages_dec(void)
-{
-	atomic_long_dec(&num_poisoned_pages);
-}
-
 static inline void num_poisoned_pages_sub(long i)
 {
 	atomic_long_sub(i, &num_poisoned_pages);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3966fa6abe03..69c4d1b48ad6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2596,7 +2596,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 {
-	int i;
+	int i, total = 0;
 
 	/*
 	 * A further optimization is to have per section refcounted
@@ -2609,8 +2609,10 @@ void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 
 	for (i = 0; i < nr_pages; i++) {
 		if (PageHWPoison(&memmap[i])) {
-			num_poisoned_pages_dec();
+			total++;
 			ClearPageHWPoison(&memmap[i]);
 		}
 	}
+	if (total)
+		num_poisoned_pages_sub(total);
 }
-- 
2.23.0

