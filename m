Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9952D2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbiESMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiESMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:50:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFEBBC6E6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:50:21 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3qSQ4xc6zhZBq;
        Thu, 19 May 2022 20:49:42 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 20:50:18 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <rcampbell@nvidia.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem error at swapoff time
Date:   Thu, 19 May 2022 20:50:29 +0800
Message-ID: <20220519125030.21486-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220519125030.21486-1-linmiaohe@huawei.com>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

When swap in shmem error at swapoff time, there would be a infinite loop
in the while loop in shmem_unuse_inode(). It's because swapin error is
deliberately ignored now and thus info->swapped will never reach 0. So
we can't escape the loop in shmem_unuse().

In order to fix the issue, swapin_error entry is stored in the mapping
when swapin error occurs. So the swapcache page can be freed and the
user won't end up with a permanently mounted swap because a sector is
bad. If the page is accessed later, the user process will be killed
so that corrupted data is never consumed. On the other hand, if the
page is never accessed, the user won't even notice it.

Reported-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index d3c7970e0179..d55dd972023a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1175,6 +1175,10 @@ static int shmem_find_swap_entries(struct address_space *mapping,
 			continue;
 
 		entry = radix_to_swp_entry(folio);
+		/*
+		 * swapin error entries can be found in the mapping. But they're
+		 * deliberately ignored here as we've done everything we can do.
+		 */
 		if (swp_type(entry) != type)
 			continue;
 
@@ -1672,6 +1676,36 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 	return error;
 }
 
+static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
+					 struct folio *folio, swp_entry_t swap)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	swp_entry_t swapin_error;
+	void *old;
+
+	swapin_error = make_swapin_error_entry(&folio->page);
+	old = xa_cmpxchg_irq(&mapping->i_pages, index,
+			     swp_to_radix_entry(swap),
+			     swp_to_radix_entry(swapin_error), 0);
+	if (old != swp_to_radix_entry(swap))
+		return;
+
+	folio_wait_writeback(folio);
+	delete_from_swap_cache(&folio->page);
+	spin_lock_irq(&info->lock);
+	/*
+	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks won't
+	 * be 0 when inode is released and thus trigger WARN_ON(inode->i_blocks) in
+	 * shmem_evict_inode.
+	 */
+	info->alloced--;
+	info->swapped--;
+	shmem_recalc_inode(inode);
+	spin_unlock_irq(&info->lock);
+	swap_free(swap);
+}
+
 /*
  * Swap in the page pointed to by *pagep.
  * Caller has to make sure that *pagep contains a valid swapped page.
@@ -1695,6 +1729,9 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	swap = radix_to_swp_entry(*foliop);
 	*foliop = NULL;
 
+	if (is_swapin_error_entry(swap))
+		return -EIO;
+
 	/* Look it up and read it in.. */
 	page = lookup_swap_cache(swap, NULL, 0);
 	if (!page) {
@@ -1762,6 +1799,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 failed:
 	if (!shmem_confirm_swap(mapping, index, swap))
 		error = -EEXIST;
+	if (error == -EIO)
+		shmem_set_folio_swapin_error(inode, index, folio, swap);
 unlock:
 	if (folio) {
 		folio_unlock(folio);
-- 
2.23.0

