Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880F24EFF26
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 08:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiDBGXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 02:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBGXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 02:23:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317FA176640
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 23:21:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KVn434fgqzdZSx;
        Sat,  2 Apr 2022 14:21:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 2 Apr
 2022 14:21:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <dhowells@redhat.com>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <kirill.shutemov@linux.intel.com>, <hannes@cmpxchg.org>,
        <agruenba@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] filemap: remove obsolete comment in lock_page
Date:   Sat, 2 Apr 2022 14:22:18 +0800
Message-ID: <20220402062218.30709-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lock_page needs the caller to have a reference on the page->mapping inode
due to sync_page. Also lock_page_nosync is introduced which does not do a
sync_page via commit db37648cd6ce ("[PATCH] mm: non syncing lock_page()").
But commit 7eaceaccab5f ("block: remove per-queue plugging") kills off the
old plugging along with aops->sync_page() and lock_page_nosync. So there
is no need to have a reference on the page->mapping inode when calling
lock_page anymore. Remove this obsolete and confusing comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/pagemap.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 993994cd943a..8dfe8e49c427 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -908,9 +908,6 @@ static inline void folio_lock(struct folio *folio)
 		__folio_lock(folio);
 }
 
-/*
- * lock_page may only be called if we have the page's inode pinned.
- */
 static inline void lock_page(struct page *page)
 {
 	struct folio *folio;
-- 
2.23.0

