Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191534E6C35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiCYBrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357619AbiCYBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:47:26 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D609A991;
        Thu, 24 Mar 2022 18:44:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V87ClCa_1648172657;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V87ClCa_1648172657)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 09:44:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] kernel/power: Fix some kernel-doc comments
Date:   Fri, 25 Mar 2022 09:44:15 +0800
Message-Id: <20220325014415.110740-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parameter description in alloc_rtree_node()  kernel-doc
comment and fix several inconsistent function name descriptions.

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

kernel/power/snapshot.c:438: warning: Function parameter or member
'gfp_mask' not described in 'alloc_rtree_node'
kernel/power/snapshot.c:438: warning: Function parameter or member
'safe_needed' not described in 'alloc_rtree_node'
kernel/power/snapshot.c:438: warning: Function parameter or member 'ca'
not described in 'alloc_rtree_node'
kernel/power/snapshot.c:438: warning: Function parameter or member
'list' not described in 'alloc_rtree_node'
kernel/power/snapshot.c:916: warning: expecting prototype for
memory_bm_rtree_next_pfn(). Prototype was for memory_bm_next_pfn()
instead
kernel/power/snapshot.c:1947: warning: expecting prototype for
alloc_highmem_image_pages(). Prototype was for alloc_highmem_pages()
instead
kernel/power/snapshot.c:2230: warning: expecting prototype for load
header(). Prototype was for load_header() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/power/snapshot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 330d49937692..89c8f9df9fdc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -427,6 +427,12 @@ struct memory_bitmap {
 
 /**
  * alloc_rtree_node - Allocate a new node and add it to the radix tree.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages that were not used before hibernation
+ *		 (restore only)
+ * @ca: used for allocating small objects out of a linked list of pages
+ *	called 'the chain'.
+ * @list: the inner node or leave of Radix Tree to add.
  *
  * This function is used to allocate inner nodes as well as the
  * leave nodes of the radix tree. It also adds the node to the
@@ -902,7 +908,7 @@ static bool rtree_next_node(struct memory_bitmap *bm)
 }
 
 /**
- * memory_bm_rtree_next_pfn - Find the next set bit in a memory bitmap.
+ * memory_bm_next_pfn - Find the next set bit in a memory bitmap.
  * @bm: Memory bitmap.
  *
  * Starting from the last returned position this function searches for the next
@@ -1937,7 +1943,7 @@ static inline int get_highmem_buffer(int safe_needed)
 }
 
 /**
- * alloc_highmem_image_pages - Allocate some highmem pages for the image.
+ * alloc_highmem_pages - Allocate some highmem pages for the image.
  *
  * Try to allocate as many pages as needed, but if the number of free highmem
  * pages is less than that, allocate them all.
@@ -2224,7 +2230,7 @@ static int check_header(struct swsusp_info *info)
 }
 
 /**
- * load header - Check the image header and copy the data from it.
+ * load_header - Check the image header and copy the data from it.
  */
 static int load_header(struct swsusp_info *info)
 {
-- 
2.20.1.7.g153144c

