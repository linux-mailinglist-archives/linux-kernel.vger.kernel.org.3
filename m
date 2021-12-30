Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D30481FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbhL3Tgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhL3Tgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:36:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25C8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:36:31 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i6so12847531pla.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTimrqJ0iSOeOCBeCp2dVOn4Z6+3smTXtkCg61LoSFk=;
        b=RLgfsULKZj57FJGDNmj159fZ3EbDc4x7rwseTpv7JrvO6Luy1T6WU3VFvUqy3dbqf6
         o52WcHWh36VzFIZxlcR6zu3PUUzDXqAGGOcNlkqdWJAXYIhRw2+K0qQgKtNeMYlSiB7/
         r1y4u/mY1hFLqO3iSrx/cvgrpUh8el/TVivAuQD+kqbteIC7xnJeeSBwvwi6HZ6Z/GN4
         50H9eNbiw8qqhCTWP95RdZVdHpTYovMTpPHu2mI4SgMthNpfC3pOTeX1fSuUmMduH/bZ
         lWiyGlfIcuFnd3vwprEr8Xe4hsEK9NUDLqrxjdRmPTswMXPej8zd2JEZ5vG1+tmkkWDT
         gGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nTimrqJ0iSOeOCBeCp2dVOn4Z6+3smTXtkCg61LoSFk=;
        b=tusTJm8kXrIHK4qfg1NDfp3jhApXhCUZS9jt+JmDmc6tezLdfdrn3ovMeCbQNAo+wO
         TiF8HoVB83ibqiSfzyBUAtfZ9A+W9T33Bh/XJReBZMUXG+R+Hidhd7DUu/y310MTTWM1
         rUwXgueIwtRb+P31aeiCCxFsxuNSBqqA+YMc2Hrp7b9WDzWJulMiC+8pxAmXExB1Ex7r
         IJid/Ev9WglAzdHqESjK9q5a4taWiKhPFT3lDt6mublf6aCller7ASsPhZYPXmHnb98U
         0x1akBz9qTmQ0hW5mFKZI3vpZml3Y93ApuOq/Np+DtBcMH+UWm3NESv+BDciuyCOc6U7
         yI2Q==
X-Gm-Message-State: AOAM533/BraQUTUI1cHiPzGVfFbOTQ5OG1OllkJAj1N8TjcmkezQ2pal
        j35+23yJlzQrPXbksojN1X8=
X-Google-Smtp-Source: ABdhPJw/TMaPAZQ1ZO220qQg8D8nNYpA+WRNckwrlfl6BdEn2IXDJxxvT1QX5TDjZmBVvbf5eqPeKQ==
X-Received: by 2002:a17:90a:bf18:: with SMTP id c24mr39155085pjs.52.1640892990993;
        Thu, 30 Dec 2021 11:36:30 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:d755:90e5:8d6a:e8eb])
        by smtp.gmail.com with ESMTPSA id t21sm23255266pgn.28.2021.12.30.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:36:30 -0800 (PST)
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
Subject: [RESEND][PATCH v2] mm: don't call lru draining in the nested lru_cache_disable
Date:   Thu, 30 Dec 2021 11:36:27 -0800
Message-Id: <20211230193627.495145-1-minchan@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
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
 * from v1 - https://lore.kernel.org/lkml/20211206221006.946661-1-minchan@kernel.org/
   * fix lru_cache_disable race - akpm

 include/linux/swap.h | 14 ++------------
 mm/cma.c             |  5 +++++
 mm/swap.c            | 30 ++++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 14 deletions(-)

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
index af3cad4e5378..5f89d7c9a54e 100644
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
@@ -859,7 +869,21 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
  */
 void lru_cache_disable(void)
 {
-	atomic_inc(&lru_disable_count);
+	static DEFINE_MUTEX(lock);
+
+	/*
+	 * The lock gaurantees lru_cache is drained when the function
+	 * returned.
+	 */
+	mutex_lock(&lock);
+	/*
+	 * If someone is already disabled lru_cache, just return with
+	 * increasing the lru_disable_count.
+	 */
+	if (atomic_inc_not_zero(&lru_disable_count)) {
+		mutex_unlock(&lock);
+		return;
+	}
 #ifdef CONFIG_SMP
 	/*
 	 * lru_add_drain_all in the force mode will schedule draining on
@@ -873,6 +897,8 @@ void lru_cache_disable(void)
 #else
 	lru_add_and_bh_lrus_drain();
 #endif
+	atomic_inc(&lru_disable_count);
+	mutex_unlock(&lock);
 }
 
 /**
-- 
2.34.1.448.ga2b2bfdf31-goog

