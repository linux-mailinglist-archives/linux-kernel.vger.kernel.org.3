Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D753F9E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbiFGJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiFGJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F4E64DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:35:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c2so7960911lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5rMhy7+1gkAH7mug47fF5ZHhc0+p0pd9emNDGCWCkpQ=;
        b=W+JslE4xHQ3jMlYH2KXGmvWlZnLm/+4nJq/39GMb+2a3O8zXVrnEwptgEjNTBXWLXy
         Vb7PId2j2ByR/FNZXN71Tz4LMaIxEVrtf+tkuQeW14h/R//OWPOG1o23t5kIfL7Us8IS
         yrT6QyUs0taloEBjoqzxVjvZ0ToYoXS5o+8lY4SVo5Ei3kPEGMgP5oDcVg66Gwq8EyDo
         Spmc/f8XAkvXhwByc0/wn0IdYpFXvvfL2RWJ/2re53TVpVT3+CiuuX6hVLYF8y7uthwh
         yIt47aSh4oS9+eT/7zmQ8Auy1cd3HRfsNEhgTrUb4d+dUpmrp+gM1o6cds4HBcW/r32y
         Us6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rMhy7+1gkAH7mug47fF5ZHhc0+p0pd9emNDGCWCkpQ=;
        b=FV218/PzsvQFhTw37zsJ38qMFHDeu37pZ+0HRlbur9mXvf8ZyOoC/mnJAVpPgAJ3GU
         hQ1UkIq8SWcfwV9HsygcCCTf/SGlJHlNHuwBPz78mgD4XkVakaDZ19XK1ZTLb5M9Wfj8
         Uc22jASwvkSNmbpBIHjwzVgMsy/M1NFx8la0oFKdcZFqTnHtEHVTbbG4i38hwMjVgbAQ
         LVCZc1Xuyv5RMFD+AZtfV/FtcH8quEikgBNoXQuKOEZpkC/7gfsZaP+ba9Z7iV8CtJoH
         K8d3pTf+GOYij2OuTS28xE3GbvR0nSum9k7n3eFblK1ZC0M35KsAAREyx3vkuVtP1Ptq
         p1aw==
X-Gm-Message-State: AOAM532C5hAQ4JDwlHRvhz2N7wb00NalU4RWvpG1WucPzcvFddGCVVlo
        0zRgWAquatu3gDFwweFnmYg=
X-Google-Smtp-Source: ABdhPJzoedISnY2HZsN02qxifFxKqIIvrfom4dgYI59hEBCxocGEgX5giTqS91rcUcFjlqDshWY4jA==
X-Received: by 2002:a05:6512:3f0a:b0:477:b1f8:1a40 with SMTP id y10-20020a0565123f0a00b00477b1f81a40mr66936199lfa.343.1654594501675;
        Tue, 07 Jun 2022 02:35:01 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r27-20020a2e575b000000b002554a4ebf5fsm2748043ljd.74.2022.06.07.02.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:35:01 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/5] mm/vmalloc: Extend __alloc_vmap_area() with extra arguments
Date:   Tue,  7 Jun 2022 11:34:46 +0200
Message-Id: <20220607093449.3100-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607093449.3100-1-urezki@gmail.com>
References: <20220607093449.3100-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It implies that __alloc_vmap_area() allocates only from the
global vmap space, therefore a list-head and rb-tree, which
represent a free vmap space, are not passed as parameters to
this function and are accessed directly from this function.

Extend the __alloc_vmap_area() and other dependent functions
to have a possibility to allocate from different trees making
an interface common and not specific.

There is no functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0102d6d5fcdf..745e89eb6ca1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1234,15 +1234,15 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
  * overhead.
  */
 static __always_inline struct vmap_area *
-find_vmap_lowest_match(unsigned long size, unsigned long align,
-	unsigned long vstart, bool adjust_search_size)
+find_vmap_lowest_match(struct rb_root *root, unsigned long size,
+	unsigned long align, unsigned long vstart, bool adjust_search_size)
 {
 	struct vmap_area *va;
 	struct rb_node *node;
 	unsigned long length;
 
 	/* Start from the root. */
-	node = free_vmap_area_root.rb_node;
+	node = root->rb_node;
 
 	/* Adjust the search size for alignment overhead. */
 	length = adjust_search_size ? size + align - 1 : size;
@@ -1370,9 +1370,9 @@ classify_va_fit_type(struct vmap_area *va,
 }
 
 static __always_inline int
-adjust_va_to_fit_type(struct vmap_area *va,
-	unsigned long nva_start_addr, unsigned long size,
-	enum fit_type type)
+adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
+	struct vmap_area *va, unsigned long nva_start_addr,
+	unsigned long size, enum fit_type type)
 {
 	struct vmap_area *lva = NULL;
 
@@ -1384,7 +1384,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
 		 * V      NVA      V
 		 * |---------------|
 		 */
-		unlink_va_augment(va, &free_vmap_area_root);
+		unlink_va_augment(va, root);
 		kmem_cache_free(vmap_area_cachep, va);
 	} else if (type == LE_FIT_TYPE) {
 		/*
@@ -1462,8 +1462,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
 		augment_tree_propagate_from(va);
 
 		if (lva)	/* type == NE_FIT_TYPE */
-			insert_vmap_area_augment(lva, &va->rb_node,
-				&free_vmap_area_root, &free_vmap_area_list);
+			insert_vmap_area_augment(lva, &va->rb_node, root, head);
 	}
 
 	return 0;
@@ -1474,7 +1473,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
  * Otherwise a vend is returned that indicates failure.
  */
 static __always_inline unsigned long
-__alloc_vmap_area(unsigned long size, unsigned long align,
+__alloc_vmap_area(struct rb_root *root, struct list_head *head,
+	unsigned long size, unsigned long align,
 	unsigned long vstart, unsigned long vend)
 {
 	bool adjust_search_size = true;
@@ -1495,7 +1495,7 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 	if (align <= PAGE_SIZE || (align > PAGE_SIZE && (vend - vstart) == size))
 		adjust_search_size = false;
 
-	va = find_vmap_lowest_match(size, align, vstart, adjust_search_size);
+	va = find_vmap_lowest_match(root, size, align, vstart, adjust_search_size);
 	if (unlikely(!va))
 		return vend;
 
@@ -1514,7 +1514,7 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 		return vend;
 
 	/* Update the free vmap_area. */
-	ret = adjust_va_to_fit_type(va, nva_start_addr, size, type);
+	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size, type);
 	if (ret)
 		return vend;
 
@@ -1605,7 +1605,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 retry:
 	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
-	addr = __alloc_vmap_area(size, align, vstart, vend);
+	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
+		size, align, vstart, vend);
 	spin_unlock(&free_vmap_area_lock);
 
 	/*
@@ -3886,7 +3887,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
 
-		ret = adjust_va_to_fit_type(va, start, size, type);
+		ret = adjust_va_to_fit_type(&free_vmap_area_root,
+				&free_vmap_area_list, va, start, size, type);
 		if (unlikely(ret))
 			goto recovery;
 
-- 
2.30.2

