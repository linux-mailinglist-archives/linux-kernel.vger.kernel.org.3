Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5E4BFB29
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiBVOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiBVOvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CAF6DA861
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645541468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7v5oF1jmYEp4q4i26tu3+p6Rx6KOC1/aMDSCGwDgiSA=;
        b=CaAakIg4JiXVF0EZPZ4jV7+OgptjzThDhBCcqYK/k84+gipOep4THHE6hx0pO+rqi+7VvA
        Vl9TrjLxjhBqjjQUUhE1UKUrLh1R8/AtGJNAsgTQFtoFxqx06D2wDSdfZUtu46BxNuHzzw
        TYrj9xCck7qrdBQTMPx6ehvh0MM0ld4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-aCwnt6a3PwetfEnLMW3KQQ-1; Tue, 22 Feb 2022 09:51:05 -0500
X-MC-Unique: aCwnt6a3PwetfEnLMW3KQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B3E418766D0;
        Tue, 22 Feb 2022 14:51:03 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A6AB3481B;
        Tue, 22 Feb 2022 14:50:31 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 0B4904168B84; Tue, 22 Feb 2022 11:49:40 -0300 (-03)
Message-ID: <20220222144907.023121407@redhat.com>
User-Agent: quilt/0.66
Date:   Tue, 22 Feb 2022 11:47:07 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juril@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/2] mm: protect local lock sections with rcu_read_lock (on RT)
References: <20220222144706.937848439@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the per-CPU LRU page vectors, augment the local lock protected
code sections with rcu_read_lock.

This makes it possible to replace the queueing of work items on all 
CPUs by synchronize_rcu (which is necessary to run FIFO:1 applications
uninterrupted on isolated CPUs).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


Index: linux-rt-devel/mm/swap.c
===================================================================
--- linux-rt-devel.orig/mm/swap.c
+++ linux-rt-devel/mm/swap.c
@@ -73,6 +73,48 @@ static DEFINE_PER_CPU(struct lru_pvecs,
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 
+#ifdef CONFIG_PREEMPT_RT
+
+#define lru_local_lock(lock)		\
+	do {				\
+		rcu_read_lock();	\
+		local_lock(lock);	\
+	} while (0)
+
+#define lru_local_unlock(lock)		\
+	do {				\
+		local_unlock(lock);	\
+		rcu_read_unlock();	\
+	} while (0)
+
+#define lru_local_lock_irqsave(lock, flags)		\
+	do {						\
+		rcu_read_lock();			\
+		local_lock_irqsave(lock, flags);	\
+	} while (0)
+
+#define lru_local_unlock_irqrestore(lock, flags)		\
+	do {							\
+		local_unlock_irqrestore(lock, flags);		\
+		rcu_read_unlock();				\
+	} while (0)
+
+#else
+
+#define lru_local_lock(lock)		\
+	local_lock(lock)
+
+#define lru_local_unlock(lock)		\
+	local_unlock(lock)
+
+#define lru_local_lock_irqsave(lock, flag)		\
+	local_lock_irqsave(lock, flags)
+
+#define lru_local_unlock_irqrestore(lock, flags)	\
+	local_unlock_irqrestore(lock, flags)
+
+#endif
+
 /*
  * This path almost never happens for VM activity - pages are normally
  * freed via pagevecs.  But it gets used by networking.
@@ -255,11 +297,11 @@ void folio_rotate_reclaimable(struct fol
 		unsigned long flags;
 
 		folio_get(folio);
-		local_lock_irqsave(&lru_rotate.lock, flags);
+		lru_local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
 		if (pagevec_add_and_need_flush(pvec, &folio->page))
 			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
-		local_unlock_irqrestore(&lru_rotate.lock, flags);
+		lru_local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 }
 
@@ -351,11 +393,11 @@ static void folio_activate(struct folio
 		struct pagevec *pvec;
 
 		folio_get(folio);
-		local_lock(&lru_pvecs.lock);
+		lru_local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		if (pagevec_add_and_need_flush(pvec, &folio->page))
 			pagevec_lru_move_fn(pvec, __activate_page);
-		local_unlock(&lru_pvecs.lock);
+		lru_local_unlock(&lru_pvecs.lock);
 	}
 }
 
@@ -382,7 +424,7 @@ static void __lru_cache_activate_folio(s
 	struct pagevec *pvec;
 	int i;
 
-	local_lock(&lru_pvecs.lock);
+	lru_local_lock(&lru_pvecs.lock);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
 
 	/*
@@ -404,7 +446,7 @@ static void __lru_cache_activate_folio(s
 		}
 	}
 
-	local_unlock(&lru_pvecs.lock);
+	lru_local_unlock(&lru_pvecs.lock);
 }
 
 /*
@@ -463,11 +505,11 @@ void folio_add_lru(struct folio *folio)
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
 	folio_get(folio);
-	local_lock(&lru_pvecs.lock);
+	lru_local_lock(&lru_pvecs.lock);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
 	if (pagevec_add_and_need_flush(pvec, &folio->page))
 		__pagevec_lru_add(pvec);
-	local_unlock(&lru_pvecs.lock);
+	lru_local_unlock(&lru_pvecs.lock);
 }
 EXPORT_SYMBOL(folio_add_lru);
 
@@ -618,9 +660,9 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
-		local_lock_irqsave(&lru_rotate.lock, flags);
+		lru_local_lock_irqsave(&lru_rotate.lock, flags);
 		pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
-		local_unlock_irqrestore(&lru_rotate.lock, flags);
+		lru_local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 
 	pvec = &per_cpu(lru_pvecs.lru_deactivate_file, cpu);
@@ -658,12 +700,12 @@ void deactivate_file_page(struct page *p
 	if (likely(get_page_unless_zero(page))) {
 		struct pagevec *pvec;
 
-		local_lock(&lru_pvecs.lock);
+		lru_local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
 		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
-		local_unlock(&lru_pvecs.lock);
+		lru_local_unlock(&lru_pvecs.lock);
 	}
 }
 
@@ -680,12 +722,12 @@ void deactivate_page(struct page *page)
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		struct pagevec *pvec;
 
-		local_lock(&lru_pvecs.lock);
+		lru_local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
 		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
-		local_unlock(&lru_pvecs.lock);
+		lru_local_unlock(&lru_pvecs.lock);
 	}
 }
 
@@ -702,20 +744,20 @@ void mark_page_lazyfree(struct page *pag
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		struct pagevec *pvec;
 
-		local_lock(&lru_pvecs.lock);
+		lru_local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
 		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
-		local_unlock(&lru_pvecs.lock);
+		lru_local_unlock(&lru_pvecs.lock);
 	}
 }
 
 void lru_add_drain(void)
 {
-	local_lock(&lru_pvecs.lock);
+	lru_local_lock(&lru_pvecs.lock);
 	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&lru_pvecs.lock);
+	lru_local_unlock(&lru_pvecs.lock);
 }
 
 /*
@@ -726,18 +768,18 @@ void lru_add_drain(void)
  */
 static void lru_add_and_bh_lrus_drain(void)
 {
-	local_lock(&lru_pvecs.lock);
+	lru_local_lock(&lru_pvecs.lock);
 	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&lru_pvecs.lock);
+	lru_local_unlock(&lru_pvecs.lock);
 	invalidate_bh_lrus_cpu();
 }
 
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
-	local_lock(&lru_pvecs.lock);
+	lru_local_lock(&lru_pvecs.lock);
 	lru_add_drain_cpu(smp_processor_id());
 	drain_local_pages(zone);
-	local_unlock(&lru_pvecs.lock);
+	lru_local_unlock(&lru_pvecs.lock);
 }
 
 #ifdef CONFIG_SMP


