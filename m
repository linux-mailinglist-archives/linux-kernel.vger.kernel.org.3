Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3593852D2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiESMug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiESMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:50:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD6ABA9A8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:50:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3qSR2zhkzhZCQ;
        Thu, 19 May 2022 20:49:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 20:50:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <rcampbell@nvidia.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v4 5/5] mm: filter out swapin error entry in shmem mapping
Date:   Thu, 19 May 2022 20:50:30 +0800
Message-ID: <20220519125030.21486-6-linmiaohe@huawei.com>
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

There might be swapin error entries in shmem mapping. Filter them out to
avoid "Bad swap file entry" complaint.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/madvise.c    | 5 ++++-
 mm/swap_state.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index a42165bc4735..31582b6ff551 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -248,10 +248,13 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 
 		if (!xa_is_value(page))
 			continue;
+		swap = radix_to_swp_entry(page);
+		/* There might be swapin error entries in shmem mapping. */
+		if (non_swap_entry(swap))
+			continue;
 		xas_pause(&xas);
 		rcu_read_unlock();
 
-		swap = radix_to_swp_entry(page);
 		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
 					     NULL, 0, false, &splug);
 		if (page)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b9e4ed2e90bf..778d57d2d92d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -410,6 +410,9 @@ struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index)
 		return NULL;
 
 	swp = radix_to_swp_entry(page);
+	/* There might be swapin error entries in shmem mapping. */
+	if (non_swap_entry(swp))
+		return NULL;
 	/* Prevent swapoff from happening to us */
 	si = get_swap_device(swp);
 	if (!si)
-- 
2.23.0

