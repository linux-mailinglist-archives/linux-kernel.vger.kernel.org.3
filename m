Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75769493BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355210AbiASOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiASOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:34:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F15C06161C;
        Wed, 19 Jan 2022 06:34:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m3so10415867lfu.0;
        Wed, 19 Jan 2022 06:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9oiupD+98sSYT2szp0bLOwe4Lp388kc2c/Co3Zp20I=;
        b=BqIimrRZwmOvFgyx9cgzcBJ/EblWz477Ctm8bBNPsnGN9/8bwRPd9sXHUAvAsUFhic
         qzYX5IzN2AlbVcGY7yf9K4FmRJczFYFGjA/zlQ9oVc94iZm/eRlCxoLyRd1YZ2I8Exyj
         /IGK6EYBVTo9Vj0j7WNdz47Reb65G+0A6qXyKlkoeKBYBtpBds1DD0jQfJbaVsj5z1B2
         jo6+3p3JN93iFtvgRMIK72klJOwn8ncFmICDMbY+/yffT1Y1xYiVpDH8lTGPwmTFgCfV
         BJ4Cf9JuzHBnjNabCXD6zYao/5fzFzoFAqZbIv/uqJ2hyHCAs+MtqiBK0d6U/XlDHW+1
         xzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9oiupD+98sSYT2szp0bLOwe4Lp388kc2c/Co3Zp20I=;
        b=PtNZ4alEO/pJGuOmcumsoIgQ6cQ4WZjQcrm6xdIe9LMXCxFC8bW43cHwYzhjkSv6Ib
         4lu5ZnN0ChQbEJ0Sual0BKA1xVXEPw03d38p1MlC0ZPnp0b2WxOkP66cAiUN81ep6ayw
         4E15Rq9Y9rJ1e4M9z8vzhx8ivWt7OBdypkAYcEFOyGK0Fsf4HgWTKFn+IA5rksuxmu5E
         tGZnhx0TjSd0xyjOD0m/YfeyPJfKk5L+gDi905gxY8d2+3w1pOhaRwNDb2ZvNvVs5UqO
         SkRs5wT/Mrnb1cOU2FCS1mLuBrySn6+B/1svW1iO/kyaPf6kpJgU1nhnGYunoS/RwpLV
         JIpA==
X-Gm-Message-State: AOAM530f3MdK4sJm/zL5hGP39j8hBKOX6bUYkrPS/QBwMxL2h9Kwu6SC
        YjudbAWsy0veMerpsiWKVsZ92j1ZNCBUuQ==
X-Google-Smtp-Source: ABdhPJze4R1mTMf13f6kPCl8W3juFpZNbCCHquzQQtr0pRw0f1EZguXPvQjzTYEjbEidx87nOeWJpg==
X-Received: by 2002:a05:6512:3e5:: with SMTP id n5mr27231331lfq.146.1642602886707;
        Wed, 19 Jan 2022 06:34:46 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id br14sm546234lfb.14.2022.01.19.06.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:34:46 -0800 (PST)
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
        Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 3/3] mm/vmalloc: Eliminate an extra orig_gfp_mask
Date:   Wed, 19 Jan 2022 15:34:34 +0100
Message-Id: <20220119143434.601059-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119143434.601059-1-urezki@gmail.com>
References: <20220119143434.601059-1-urezki@gmail.com>
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

