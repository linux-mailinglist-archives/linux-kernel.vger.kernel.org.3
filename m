Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E99351FDD3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiEINT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiEINSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901B82A76AE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:16 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KxhSp0hK8zhZ3Q;
        Mon,  9 May 2022 21:13:46 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:14:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 15/15] mm/swap: fix comment about swap extent
Date:   Mon, 9 May 2022 21:14:16 +0800
Message-ID: <20220509131416.17553-16-linmiaohe@huawei.com>
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

Since commit 4efaceb1c5f8 ("mm, swap: use rbtree for swap_extent"), rbtree
is used for swap extent. Also curr_swap_extent is removed at that time.
Update the corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h |  4 ++--
 mm/swapfile.c        | 15 ++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8772132d21dc..e1f3201dec6f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -173,8 +173,8 @@ struct zone;
 
 /*
  * A swap extent maps a range of a swapfile's PAGE_SIZE pages onto a range of
- * disk blocks.  A list of swap extents maps the entire swapfile.  (Where the
- * term `swapfile' refers to either a blockdevice or an IS_REG file.  Apart
+ * disk blocks.  A rbtree of swap extents maps the entire swapfile (Where the
+ * term `swapfile' refers to either a blockdevice or an IS_REG file). Apart
  * from setup, they're handled identically.
  *
  * We always assume that blocks are of size PAGE_SIZE.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7ead5fb96d9d..b3f977d9c83e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2225,8 +2225,8 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
 
 /*
  * A `swap extent' is a simple thing which maps a contiguous range of pages
- * onto a contiguous range of disk blocks.  An ordered list of swap extents
- * is built at swapon time and is then used at swap_writepage/swap_readpage
+ * onto a contiguous range of disk blocks.  A rbtree of swap extents is
+ * built at swapon time and is then used at swap_writepage/swap_readpage
  * time for locating where on disk a page belongs.
  *
  * If the swapfile is an S_ISBLK block device, a single extent is installed.
@@ -2234,12 +2234,12 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
  * swap files identically.
  *
  * Whether the swapdev is an S_ISREG file or an S_ISBLK blockdev, the swap
- * extent list operates in PAGE_SIZE disk blocks.  Both S_ISREG and S_ISBLK
+ * extent rbtree operates in PAGE_SIZE disk blocks.  Both S_ISREG and S_ISBLK
  * swapfiles are handled *identically* after swapon time.
  *
  * For S_ISREG swapfiles, setup_swap_extents() will walk all the file's blocks
- * and will parse them into an ordered extent list, in PAGE_SIZE chunks.  If
- * some stray blocks are found which do not fall within the PAGE_SIZE alignment
+ * and will parse them into a rbtree, in PAGE_SIZE chunks.  If some stray
+ * blocks are found which do not fall within the PAGE_SIZE alignment
  * requirements, they are simply tossed out - we will never use those blocks
  * for swapping.
  *
@@ -2248,10 +2248,7 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
  *
  * The amount of disk space which a single swap extent represents varies.
  * Typically it is in the 1-4 megabyte range.  So we can have hundreds of
- * extents in the list.  To avoid much list walking, we cache the previous
- * search location in `curr_swap_extent', and start new searches from there.
- * This is extremely effective.  The average number of iterations in
- * map_swap_page() has been measured at about 0.3 per page.  - akpm.
+ * extents in the rbtree. - akpm.
  */
 static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 {
-- 
2.23.0

