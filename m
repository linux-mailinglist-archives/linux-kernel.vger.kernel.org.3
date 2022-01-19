Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0199E493C01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355255AbiASOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355150AbiASOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:35:52 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FCAC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:35:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s30so10181249lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/VfafbxJ+vp6TLOD2d5aFbCUTwMb6Qu1uU6PUy6ZDY=;
        b=n4drYZuOGRVaLSjc8TCdkAEho4IJaYZ60oRRsBXU3CqKfIbodkO13DsVi9mKd75nEL
         h52jVxTTNYbXogL7r90cYBS0+S1KXGaHn4Akz7c3zMGhgX41CFjlZaz7pqiEvukt6Enn
         jKH0UKNqgSIxqEIvo6BYKPCJ2ro3lW6ACAwta68WfbVY9tbQDQ08s2yQ/kRuCqFLItPS
         N3sIu75MJeH83hoA30XnRH1YTbW44XuRWc3k5t9ogPfsmbkbCbFJctpZ/l1Gd84xZHx8
         k70WEJcOILSZ27+O7OC2el6tOUg6PqstDykMHzl26HULJigKqwq2FCLOPczdOAGwInQq
         dfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/VfafbxJ+vp6TLOD2d5aFbCUTwMb6Qu1uU6PUy6ZDY=;
        b=PcXjFPv5YS7wV5gWUxjUMOaBv6QegrfflSahWRxaqbRqnfZJE4hwicpCWAOpV/qQWo
         0UOUYz59gnGxCrxdskO1agWiajjdOop8UoqeNpxBfB12DL1ZbsjIlbrnmnV7u7oeHcy7
         v0cILZ2qIUlul+Deri6Byp0mT6JIShHLL1HStyclIPD8zAhRT7j2hq65a8gY/3F37wkh
         BHdFANdHSxXjIu1sCHDUA4OcFrOVHywFFwpmmpqju29i+ES77gULXvZBFeRtha432ofs
         049zAT1c2XwJ2U7GuDQBHArrkwurDoQQ8CFUQHbvjm+di+gdwUsLwTFTB2PDfHn3q4Tx
         qlxQ==
X-Gm-Message-State: AOAM532XExom/T6rYrs3e0Wu7s5fOCCNUyKCYYWbAMPJQMMNZU7M7tNo
        YaKTxLLd5ITcgbCjPg6cfvE=
X-Google-Smtp-Source: ABdhPJzM4vt8SBI2cvh6mvOuLZiZ9NRRzOvQ0dRdNvjMgpr1qMTGrZphWnTn9S8hUfj9Rxn72EwbnQ==
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr19706790ljp.458.1642602950546;
        Wed, 19 Jan 2022 06:35:50 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id z13sm179943lfr.183.2022.01.19.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:35:50 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: [PATCH 2/3] mm/vmalloc: Add adjust_search_size parameter
Date:   Wed, 19 Jan 2022 15:35:39 +0100
Message-Id: <20220119143540.601149-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119143540.601149-1-urezki@gmail.com>
References: <20220119143540.601149-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <uladzislau.rezki@sony.com>

Extend the find_vmap_lowest_match() function with one more
parameter. It is "adjust_search_size" boolean variable, so
it is possible to control an accuracy of search block if a
specific alignment is required.

With this patch, a search size is always adjusted, to serve
a request as fast as possible because of performance reason.

But there is one exception though, it is short ranges where
requested size corresponds to passed vstart/vend restriction
together with a specific alignment request. In such scenario
an adjustment wold not lead to success allocation.

Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ed0f9eaa61a9..52ee67107046 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1192,22 +1192,28 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
 /*
  * Find the first free block(lowest start address) in the tree,
  * that will accomplish the request corresponding to passing
- * parameters.
+ * parameters. Please note, with an alignment bigger than PAGE_SIZE,
+ * a search length is adjusted to account for worst case alignment
+ * overhead.
  */
 static __always_inline struct vmap_area *
-find_vmap_lowest_match(unsigned long size,
-	unsigned long align, unsigned long vstart)
+find_vmap_lowest_match(unsigned long size, unsigned long align,
+	unsigned long vstart, bool adjust_search_size)
 {
 	struct vmap_area *va;
 	struct rb_node *node;
+	unsigned long length;
 
 	/* Start from the root. */
 	node = free_vmap_area_root.rb_node;
 
+	/* Adjust the search size for alignment overhead. */
+	length = adjust_search_size ? size + align - 1 : size;
+
 	while (node) {
 		va = rb_entry(node, struct vmap_area, rb_node);
 
-		if (get_subtree_max_size(node->rb_left) >= size &&
+		if (get_subtree_max_size(node->rb_left) >= length &&
 				vstart < va->va_start) {
 			node = node->rb_left;
 		} else {
@@ -1217,9 +1223,9 @@ find_vmap_lowest_match(unsigned long size,
 			/*
 			 * Does not make sense to go deeper towards the right
 			 * sub-tree if it does not have a free block that is
-			 * equal or bigger to the requested search size.
+			 * equal or bigger to the requested search length.
 			 */
-			if (get_subtree_max_size(node->rb_right) >= size) {
+			if (get_subtree_max_size(node->rb_right) >= length) {
 				node = node->rb_right;
 				continue;
 			}
@@ -1235,7 +1241,7 @@ find_vmap_lowest_match(unsigned long size,
 				if (is_within_this_va(va, size, align, vstart))
 					return va;
 
-				if (get_subtree_max_size(node->rb_right) >= size &&
+				if (get_subtree_max_size(node->rb_right) >= length &&
 						vstart <= va->va_start) {
 					/*
 					 * Shift the vstart forward. Please note, we update it with
@@ -1283,7 +1289,7 @@ find_vmap_lowest_match_check(unsigned long size, unsigned long align)
 	get_random_bytes(&rnd, sizeof(rnd));
 	vstart = VMALLOC_START + rnd;
 
-	va_1 = find_vmap_lowest_match(size, align, vstart);
+	va_1 = find_vmap_lowest_match(size, align, vstart, false);
 	va_2 = find_vmap_lowest_linear_match(size, align, vstart);
 
 	if (va_1 != va_2)
@@ -1434,12 +1440,25 @@ static __always_inline unsigned long
 __alloc_vmap_area(unsigned long size, unsigned long align,
 	unsigned long vstart, unsigned long vend)
 {
+	bool adjust_search_size = true;
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
 	enum fit_type type;
 	int ret;
 
-	va = find_vmap_lowest_match(size, align, vstart);
+	/*
+	 * Do not adjust when:
+	 *   a) align <= PAGE_SIZE, because it does not make any sense.
+	 *      All blocks(their start addresses) are at least PAGE_SIZE
+	 *      aligned anyway;
+	 *   b) a short range where a requested size corresponds to exactly
+	 *      specified [vstart:vend] interval and an alignment > PAGE_SIZE.
+	 *      With adjusted search length an allocation would not succeed.
+	 */
+	if (align <= PAGE_SIZE || (align > PAGE_SIZE && (vend - vstart) == size))
+		adjust_search_size = false;
+
+	va = find_vmap_lowest_match(size, align, vstart, adjust_search_size);
 	if (unlikely(!va))
 		return vend;
 
-- 
2.30.2

