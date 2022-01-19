Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC08493C02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355270AbiASOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355170AbiASOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:35:54 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3195C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:35:53 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s30so10181635lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9oiupD+98sSYT2szp0bLOwe4Lp388kc2c/Co3Zp20I=;
        b=DkBxkk35wBe59Gksv6JiqbrdxzGUwLOrGyTJhhy8vVZTCT5xTk25u+QwCD8Zc835cC
         A5DcJiMy9xFo99+1hA5oSRiGEboKjGKZIOZXBDxCr7b+IjjCzsdoK1x9cf7lHsZSo2Cp
         amV/ET45+C79+LvO7+T88ztmz+nBGat4of/DRX1qGD8hL8u6RET2eybE3ko/j+tFJxMQ
         pFL0fAfH/GtYiC/zcJlNxq3uNWC8NCEXXsXTV4Vb2Awyu35xssXPfb7d6LTqpWtT9pjH
         iKT9rySlIXxTw3OVrhqQ66IWHHQVnPV31vjBw6rgRtwmhQfRRzB42hOOwYkgwzest7wF
         QpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9oiupD+98sSYT2szp0bLOwe4Lp388kc2c/Co3Zp20I=;
        b=AU/i/vIKeyMQGExRaRKz30oovCLCVG3biqpXtrxl+dt1i/ze6VMS/YCS5HDA8DhWRJ
         Ism0EuApUuUpLfzMzkI4H28scdaIvEAZBpwPu6RSPgcFyo3b/L0fyoJN/qRj3xU+X7/i
         E3uqoO61VwcVHu6VuHtOfDxTxbQJs4EQ8BloznJoAP6ftPTpI/xN0w6uap75I4l50bwi
         7y6pUm+Ou9DT4wfO3GclijWw4CE0yFOQHVONJtjGnulfFgCna/x83d35M9/DFq8mWPNM
         ZQV/OzjrcOcmcQmXQonsG1JWHXeOtd5qLefAd2fn1SnUCTdJmZ+Ckr7WSTljJ5GoJOiZ
         myTA==
X-Gm-Message-State: AOAM530GxiTpEHSMUWvtbDFs4HUj4Efok4zFc07mvCfJes4doQ+k2DNT
        1CF4TT6GidYUgZTq+OU4HGg=
X-Google-Smtp-Source: ABdhPJziXjs/bTyN3grnU5EX0UYhEFJOpdfOQmpkVInGM8LY6uzrjQhrAVII7Ys9JfV4ARZEMRyGXQ==
X-Received: by 2002:ac2:5c41:: with SMTP id s1mr28901657lfp.440.1642602952277;
        Wed, 19 Jan 2022 06:35:52 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id z13sm179943lfr.183.2022.01.19.06.35.50
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
        Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 3/3] mm/vmalloc: Eliminate an extra orig_gfp_mask
Date:   Wed, 19 Jan 2022 15:35:40 +0100
Message-Id: <20220119143540.601149-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119143540.601149-1-urezki@gmail.com>
References: <20220119143540.601149-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That extra variable has been introduced just for keeping an original
passed gfp_mask because it is updated with __GFP_NOWARN on entry, thus
error handling messages were broken.

Instead we can keep an original gfp_mask without modifying it and add
an extra __GFP_NOWARN flag together with gfp_mask as a parameter to
the vm_area_alloc_pages() function. It will make it less confused.

Cc: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 52ee67107046..04edd32ba6bc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2953,7 +2953,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 int node)
 {
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
-	const gfp_t orig_gfp_mask = gfp_mask;
 	bool nofail = gfp_mask & __GFP_NOFAIL;
 	unsigned long addr = (unsigned long)area->addr;
 	unsigned long size = get_vm_area_size(area);
@@ -2967,7 +2966,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	max_small_pages = ALIGN(size, 1UL << page_shift) >> PAGE_SHIFT;
 
 	array_size = (unsigned long)max_small_pages * sizeof(struct page *);
-	gfp_mask |= __GFP_NOWARN;
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
 		gfp_mask |= __GFP_HIGHMEM;
 
@@ -2980,7 +2978,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	if (!area->pages) {
-		warn_alloc(orig_gfp_mask, NULL,
+		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to allocated page array size %lu",
 			nr_small_pages * PAGE_SIZE, array_size);
 		free_vm_area(area);
@@ -2990,8 +2988,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
 	page_order = vm_area_page_order(area);
 
-	area->nr_pages = vm_area_alloc_pages(gfp_mask, node,
-		page_order, nr_small_pages, area->pages);
+	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
+		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 	if (gfp_mask & __GFP_ACCOUNT) {
@@ -3007,7 +3005,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * allocation request, free them via __vfree() if any.
 	 */
 	if (area->nr_pages != nr_small_pages) {
-		warn_alloc(orig_gfp_mask, NULL,
+		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, page order %u, failed to allocate pages",
 			area->nr_pages * PAGE_SIZE, page_order);
 		goto fail;
@@ -3035,7 +3033,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		memalloc_noio_restore(flags);
 
 	if (ret < 0) {
-		warn_alloc(orig_gfp_mask, NULL,
+		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to map pages",
 			area->nr_pages * PAGE_SIZE);
 		goto fail;
-- 
2.30.2

