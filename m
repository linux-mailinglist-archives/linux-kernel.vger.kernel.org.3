Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F15646AE90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377450AbhLFXuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhLFXt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:49:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00088C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:46:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so520682pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 15:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i0F2FLnWLyXFIQOQxbg+dJ8oEFxhyhI4xZI+2RG9pJY=;
        b=YYZq8k4QD5vnldS1VtfoRsK8GdM2mrJTX3qTaxuk6UZiqzUqsgRWNj+SHjGAnINO60
         wOrUeUHbi/n27b5jlPR+vttREynShA2HjS6Vqm/w1Fw8Ix6vjaX2hr2l3UIadK6Ii6dR
         wWWgonelpWl/JEMrqcc+sHzmovsbM7nVC+h6NSKLIl0u95mii0pefNeXm+UqZmgwUm5O
         JHpepVe/nqh0OlPfNqmwY4ZsCRxewU5XYOa5aZcf2BRdEt88GIwbD5Jimv1DO1Ltl2aL
         1tLm5M8g90vuh85p2ook2+L62RoRrpHbJIHVXRCqDS7nt+FCwJx/dXnnGDIQ9cuUKYft
         1/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=i0F2FLnWLyXFIQOQxbg+dJ8oEFxhyhI4xZI+2RG9pJY=;
        b=pmhlKM3+Q8+EiWUXIiGJVI+nBpnGhIFCIzC0lUgwLQiBu6BO5DIphNp9xUodXv5TQO
         nYo73vAfbM/Q6rpp5PyeLiMYfXV71JonW7dFLSV4JagYXLoKv8mTqOQdEfylXI77fy66
         lBGKrfE8SWCQBIDPhPDjB+yxmSO23RqkNyIScSPmWKy4kQMO7pgxQOWpkfkBkIRqpxfq
         SUDAaY5LrcjXnNMAbU4hRaq/wBkLnOKUqBVpkWeXFvMJMGE6B1hp2NjwQg1Vr0MpwoB2
         TAJc1/AWXGb6tRUzBEETKDnJPC4lXKiqitKUb1Y3V9NzsxrRrrksEYDNd9Xyp4z3GblA
         5ieA==
X-Gm-Message-State: AOAM530+Ivb3s93zr2JOOAx66RJud40bkdea5FhizSGiWLjGScvUFeJu
        soQvYPT3a4DTL7JvcNmyhPc=
X-Google-Smtp-Source: ABdhPJwNd77TQHw+jVWvKgD6/APaHAP8GIgo3LnqFlBufLt1NOx4SogaZwa8PCrKuRxQCIVDj7WTVQ==
X-Received: by 2002:a17:90b:30c4:: with SMTP id hi4mr2257506pjb.12.1638834388484;
        Mon, 06 Dec 2021 15:46:28 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2d37:bc7d:9c01:7721])
        by smtp.gmail.com with ESMTPSA id s16sm13496069pfu.109.2021.12.06.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 15:46:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 6 Dec 2021 15:46:26 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <Ya6g0uXYlR/MRLDD@google.com>
References: <20211206221006.946661-1-minchan@kernel.org>
 <20211206150421.fc06972fac949a5f6bc8b725@linux-foundation.org>
 <Ya6d+zC/CsYAp0Gf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya6d+zC/CsYAp0Gf@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:34:19PM -0800, Minchan Kim wrote:
> On Mon, Dec 06, 2021 at 03:04:21PM -0800, Andrew Morton wrote:
> > On Mon,  6 Dec 2021 14:10:06 -0800 Minchan Kim <minchan@kernel.org> wrote:
> > 
> > > lru_cache_disable involves IPIs to drain pagevec of each core,
> > > which sometimes takes quite long time to complete depending
> > > on cpu's business, which makes allocation too slow up to
> > > sveral hundredth milliseconds. Furthermore, the repeated draining
> > > in the alloc_contig_range makes thing worse considering caller
> > > of alloc_contig_range usually tries multiple times in the loop.
> > > 
> > > This patch makes the lru_cache_disable aware of the fact the
> > > pagevec was already disabled. With that, user of alloc_contig_range
> > > can disable the lru cache in advance in their context during the
> > > repeated trial so they can avoid the multiple costly draining
> > > in cma allocation.
> > 
> > Isn't this racy?
> >  
> > > ...
> > >
> > > @@ -859,7 +869,12 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
> > >   */
> > >  void lru_cache_disable(void)
> > >  {
> > > -	atomic_inc(&lru_disable_count);
> > > +	/*
> > > +	 * If someone is already disabled lru_cache, just return with
> > > +	 * increasing the lru_disable_count.
> > > +	 */
> > > +	if (atomic_inc_not_zero(&lru_disable_count))
> > > +		return;
> > >  #ifdef CONFIG_SMP
> > >  	/*
> > >  	 * lru_add_drain_all in the force mode will schedule draining on
> > > @@ -873,6 +888,7 @@ void lru_cache_disable(void)
> > >  #else
> > >  	lru_add_and_bh_lrus_drain();
> > >  #endif
> > 
> > There's a window here where lru_disable_count==0 and new pages can get
> > added to lru?
> 
> Indeed. If __lru_add_drain_all in core A didn't run yet but increased
> the disable count already, lru_cache_disable in core B will not see
> those pages in the LRU. Need to be fixed it.
> 
> Thanks, Andrew.

From 0874e108b4708355d703927716a49670b989e960 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 6 Dec 2021 11:59:36 -0800
Subject: [PATCH v2] mm: don't call lru draining in the nested lru_cache_disable

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
 mm/swap.c            | 26 ++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 14 deletions(-)

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
index af3cad4e5378..edcfcd6cf38e 100644
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
@@ -859,7 +869,17 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
  */
 void lru_cache_disable(void)
 {
-	atomic_inc(&lru_disable_count);
+	static DEFINE_MUTEX(lock);
+
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
@@ -873,6 +893,8 @@ void lru_cache_disable(void)
 #else
 	lru_add_and_bh_lrus_drain();
 #endif
+	atomic_inc(&lru_disable_count);
+	mutex_unlock(&lock);
 }
 
 /**
-- 
2.34.1.400.ga245620fadb-goog

