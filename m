Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F303946AB3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356329AbhLFWNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbhLFWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:13:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D3C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:10:10 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so999434pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 14:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XeW+iihcOMuh5RO+7nkAKX72OjB9qqZAScpNNOK5XFQ=;
        b=DaAeK3F3p4ObcJUU0Lu0c1n5ZtmLnviTSDORy5/Yclc2+HRQTaAyp3ZUgASqfBSII8
         t+UVf7iuF1oNSutI88JHL3fjWJBibHyiMKHVdPN6kN28VZ43jwyAxB6C95O/QNOGCv/j
         QR35Qgh+o8O1/d/pFcDRupYuqbQq1YjcltmJMT0LinGjiyjQ1/bcSJlz7lc9kiZnF/9y
         9ItUzE8gp2XMUoPwaggVMOUnVdo/+O0IYtEV60PjLkxHA/OYkgEvO5zMl3fLBh9c3g+j
         N4P1kNlP2bXZ7sScpdEpok7dBXlkMXh14snfCNqi52aNROquwX3fyc3zlXZ4l/ZLdyYy
         Lr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XeW+iihcOMuh5RO+7nkAKX72OjB9qqZAScpNNOK5XFQ=;
        b=JzpbFrVOkxSb5HZrwGYvNa3Ws0uWAgVhV6JzKYtis1ZufFsDq5///EQuRg4U1hbBBd
         JEY/DzxZ2atzWKnLOepdkKmE+xOnUYmXwrvsBAmWnGCOaM97qMZUhOKQ65Ng3ntyLeoh
         84qWvFC1d90aI/UasJuIqgwkw5JNPo3bUnh1fDy7EbSj+JKjuS+9YTYKrCDa7LZbc6Q4
         GgE4uR2jwl2KpoHYGvGiI0cxra4kc0c42mG/WHVbghGhv0gwONPqQFC5CW2/C+vjaXFO
         3+PI6HEGS+ioHIHPoDXf/Shc8i6iLTFoEV6b3VQbyW2xz80LyjKoMYpgyHWVRn28POpI
         p7Yw==
X-Gm-Message-State: AOAM531TVDLFP9hEbuOzdSdKW3MUNjHe9GsFxsUlEkRraRA//PnDVvwA
        GCoxF6oM8JNSS/XrCXFfa/8=
X-Google-Smtp-Source: ABdhPJy6pEh177crGA06O8FipksFUDTyc6gNvckiyzAOXr1S4zymruNJ50y0JZXv0W6S7N16pUXH0g==
X-Received: by 2002:a17:903:186:b0:141:eda2:d5fa with SMTP id z6-20020a170903018600b00141eda2d5famr46312963plg.63.1638828609917;
        Mon, 06 Dec 2021 14:10:09 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:2d37:bc7d:9c01:7721])
        by smtp.gmail.com with ESMTPSA id s31sm11708832pfg.22.2021.12.06.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:10:09 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: don't call lru draining in the nested lru_cache_disable
Date:   Mon,  6 Dec 2021 14:10:06 -0800
Message-Id: <20211206221006.946661-1-minchan@kernel.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lru_cache_disable involves IPIs to drain pagevec of each core,
which sometimes takes quite long time to complete depending
on cpu's business, which makes allocation too slow up to
sveral hundredth milliseconds. Furthermore, the repeated draining
in the alloc_contig_range makes thing worse considering caller
of alloc_contig_range usually tries multiple times in the loop.

This patch makes the lru_cache_disable aware of the fact the
pagevec was already disabled. With that, user of alloc_contig_range
can disable the lru cache in advance in their context during the
repeated trial so they can avoid the multiple costly draining
in cma allocation.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/swap.h | 14 ++------------
 mm/cma.c             |  5 +++++
 mm/swap.c            | 20 ++++++++++++++++++--
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ba52f3a3478e..fe18e86a4f13 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -348,19 +348,9 @@ extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void mark_page_accessed(struct page *);
 
-extern atomic_t lru_disable_count;
-
-static inline bool lru_cache_disabled(void)
-{
-	return atomic_read(&lru_disable_count);
-}
-
-static inline void lru_cache_enable(void)
-{
-	atomic_dec(&lru_disable_count);
-}
-
+extern bool lru_cache_disabled(void);
 extern void lru_cache_disable(void);
+extern void lru_cache_enable(void);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
diff --git a/mm/cma.c b/mm/cma.c
index 995e15480937..60be555c5b95 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -30,6 +30,7 @@
 #include <linux/cma.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
+#include <linux/swap.h>
 #include <linux/kmemleak.h>
 #include <trace/events/cma.h>
 
@@ -453,6 +454,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (bitmap_count > bitmap_maxno)
 		goto out;
 
+	lru_cache_disable();
+
 	for (;;) {
 		spin_lock_irq(&cma->lock);
 		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
@@ -492,6 +495,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		start = bitmap_no + mask + 1;
 	}
 
+	lru_cache_enable();
+
 	trace_cma_alloc_finish(cma->name, pfn, page, count, align);
 
 	/*
diff --git a/mm/swap.c b/mm/swap.c
index af3cad4e5378..24bc909e84a9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -847,7 +847,17 @@ void lru_add_drain_all(void)
 }
 #endif /* CONFIG_SMP */
 
-atomic_t lru_disable_count = ATOMIC_INIT(0);
+static atomic_t lru_disable_count = ATOMIC_INIT(0);
+
+bool lru_cache_disabled(void)
+{
+	return atomic_read(&lru_disable_count) != 0;
+}
+
+void lru_cache_enable(void)
+{
+	atomic_dec(&lru_disable_count);
+}
 
 /*
  * lru_cache_disable() needs to be called before we start compiling
@@ -859,7 +869,12 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
  */
 void lru_cache_disable(void)
 {
-	atomic_inc(&lru_disable_count);
+	/*
+	 * If someone is already disabled lru_cache, just return with
+	 * increasing the lru_disable_count.
+	 */
+	if (atomic_inc_not_zero(&lru_disable_count))
+		return;
 #ifdef CONFIG_SMP
 	/*
 	 * lru_add_drain_all in the force mode will schedule draining on
@@ -873,6 +888,7 @@ void lru_cache_disable(void)
 #else
 	lru_add_and_bh_lrus_drain();
 #endif
+	atomic_inc(&lru_disable_count);
 }
 
 /**
-- 
2.34.1.400.ga245620fadb-goog

