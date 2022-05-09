Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E481651FDCC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiEINSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiEINSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494812A8046
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxhSS6NWBzhZ3g;
        Mon,  9 May 2022 21:13:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:14:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 04/15] mm/swap: remove unneeded return value of free_swap_slot
Date:   Mon, 9 May 2022 21:14:05 +0800
Message-ID: <20220509131416.17553-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220509131416.17553-1-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
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

The return value of free_swap_slot is always 0 and also ignored now.
Remove it to clean up the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap_slots.h | 2 +-
 mm/swap_slots.c            | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index 347f1a304190..15adfb8c813a 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -24,7 +24,7 @@ struct swap_slots_cache {
 void disable_swap_slots_cache_lock(void);
 void reenable_swap_slots_cache_unlock(void);
 void enable_swap_slots_cache(void);
-int free_swap_slot(swp_entry_t entry);
+void free_swap_slot(swp_entry_t entry);
 
 extern bool swap_slot_cache_enabled;
 
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0218ec1cd24c..2f877e6f87d7 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -269,7 +269,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 	return cache->nr;
 }
 
-int free_swap_slot(swp_entry_t entry)
+void free_swap_slot(swp_entry_t entry)
 {
 	struct swap_slots_cache *cache;
 
@@ -297,8 +297,6 @@ int free_swap_slot(swp_entry_t entry)
 direct_free:
 		swapcache_free_entries(&entry, 1);
 	}
-
-	return 0;
 }
 
 swp_entry_t folio_alloc_swap(struct folio *folio)
-- 
2.23.0

