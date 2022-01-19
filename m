Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D9C493BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbiASOeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355162AbiASOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:34:48 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A4C061574;
        Wed, 19 Jan 2022 06:34:47 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m3so10415638lfu.0;
        Wed, 19 Jan 2022 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/VfafbxJ+vp6TLOD2d5aFbCUTwMb6Qu1uU6PUy6ZDY=;
        b=oNXoJ+Yv0sle8worfjKc44vP5FvZrKiUcMTeRgMq7lirjt+9TSX4YftgspWmiE3Kl3
         nEj+EqKkE7a3KRCgPX35Ol9hwoe2iT6e554tNAodQVhAF6P/jwQrnyDYSfJHFamMj35N
         bK0NbOi4QT8IDzyDvPQ0a2wcaUlfK4Hzm+lxbB45kkALrM7wn/MAS0Kj/MBGC4/CI3Ai
         Ik75wfsNFA4vU0CR9aG32y4x59COEiWR5rlyboyyLEk987xHjDb3TGGZXmVHGEjnnt5i
         2EaMNCufb1TCMSS/jXlr5jWPgNB4AlzxNB4lxCOS7UPVGAZWNtJKx0S+PhZvUfn5/TFr
         HmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/VfafbxJ+vp6TLOD2d5aFbCUTwMb6Qu1uU6PUy6ZDY=;
        b=exTj26OQRB748G/QGdq8aMjSERyTMM9iI0mTGB7HwH8Jxy/qmrz4H7olennLyf7FCD
         UyLY9k7I9cKRhi5BbfJQypnbxZJj7quC/BZA5UcVVgFetI8cNF5zshaLQxyDKTytL7QY
         yKqyC4rdQj3mykUMjmvSaT3vDMSbh9fQwI6yN+O5A6GYqs+1sRhEvWQRkZeuvRnOkaR4
         Ruc9SUJLUTST0jocc7YgoSB4inCHNvzRBJ1nm0ntA7qGr0knDvFBkTJbsNDdQFfLUaAg
         UVU9bv/OUtP//SPkd9KV/ZP87AZ2+Fc7ew/rqeUBjqInqvvz+pgnUOorxWGIZrJKGqXG
         t8pA==
X-Gm-Message-State: AOAM533d0N44qcxFf4STH5Wd7ZXm+8mhSMuAiM8beSEjbOIb9vlm4jcD
        QTULLJdv1efBTAYvp5/FhV9eM71BGonn9g==
X-Google-Smtp-Source: ABdhPJwBfzg0BB0tGZWDoMLrdTRTgPnva3KzMm8FVWCJ+49+WSbcyau6ZMa7sqksUnk6BTzBLSWEtA==
X-Received: by 2002:a05:6512:3186:: with SMTP id i6mr25441091lfe.286.1642602885430;
        Wed, 19 Jan 2022 06:34:45 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id br14sm546234lfb.14.2022.01.19.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:34:44 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: [PATCH 2/3] mm/vmalloc: Add adjust_search_size parameter
Date:   Wed, 19 Jan 2022 15:34:33 +0100
Message-Id: <20220119143434.601059-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119143434.601059-1-urezki@gmail.com>
References: <20220119143434.601059-1-urezki@gmail.com>
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

