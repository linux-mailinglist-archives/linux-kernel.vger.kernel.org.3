Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FAA522C28
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiEKGUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiEKGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:20:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848331ED2BA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:20:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id a191so944489pge.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBCTXkaBUfUOeTfxKhpY9jDR1ijlEmdERD1cfMUNmSA=;
        b=OGrTnYkDNUCJeelwKaqgYK2IzIhLtD2WG4QWzXdcIL1G2x24+914SHBAcrrGHg6+wj
         y3W5eWqbn+Si8zcWIPzbEA22upwORacffRy59qMHsWYQjbFfnXGQY8vmxqgS/E38sc4X
         Vov7vJB5+1fXRchhjlzu6UHd1oYOQK/sBXwse2tIz8mOkHeLfmaAW7r7+LqHUiHf47el
         MBJI/kogaNUebG1EfNQQOUKF4NRqWVxBHK2gf2Tl3bUZlorRCDvpzPxqgAxCm6XASS7H
         F5vOThJvh1mcUeDbjLLVEhwOqWpAXsa4GMAA/zqW86N6TR5L52eeND4CEqPFcGP2URa+
         g8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBCTXkaBUfUOeTfxKhpY9jDR1ijlEmdERD1cfMUNmSA=;
        b=GxD25437MiJiS6BZbEX511oHcTwYEDM0Qh7Ytl4PocFZp5EGx+3gTydlQaDiDhoX5N
         7v8TILxOFHwc5nkxGJddcshoqVzIKUDWQgUTqzhYOlvJgMBmYP8v0Wan7POYb/vi48UR
         ucw5ThCsIs8xl8pL5ywR0Hk0Vu3XmFCL2+WLqq4/DpDhQMHxL6lShzBGgIGb9UDMtaVY
         5OJTXctSpdf6aa8SJ7HQKdcnSAB2qT2c8+9rH991E3gO1Tl0aKZ8hgfWZBTyF0/G5AV5
         ybRLePl5HkyLNbaWDBSB6i/+x1zeEn4wWo9dW4TOIaVFSZDByfvHS1HqCHFF5SlbxYeF
         fj7g==
X-Gm-Message-State: AOAM5334p13hWUM8uas0puOawLfZMHhZID4WYTb1certohvRSyrblXxc
        6DFV7mMxeboOIbhlUAEkeyC636dQ+k9GKw==
X-Google-Smtp-Source: ABdhPJxoZdtoGcwCeoQXfgXydgTLFLm7LSjfdlvo1hIasxB0k3gl79CsDovlh8jZ6leJ+7mwqqmI2g==
X-Received: by 2002:a63:d1b:0:b0:3db:1faa:a473 with SMTP id c27-20020a630d1b000000b003db1faaa473mr1833277pgl.555.1652250010085;
        Tue, 10 May 2022 23:20:10 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id be12-20020a170902aa0c00b0015e8d4eb1e4sm771500plb.46.2022.05.10.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:20:09 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, jirislaby@kernel.org,
        akinobu.mita@gmail.com, vbabka@suse.cz, gregkh@linuxfoundation.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/2] mm: fix missing handler for __GFP_NOWARN
Date:   Wed, 11 May 2022 14:19:50 +0800
Message-Id: <20220511061951.1114-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expect no warnings to be issued when we specify __GFP_NOWARN, but
currently in paths like alloc_pages() and kmalloc(), there are still
some warnings printed, fix it.

But for some warnings that report usage problems, we don't deal with
them. If such warnings are printed, then we should fix the usage
problems. Such as the following case:

	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/fault-inject.h |  2 ++
 lib/fault-inject.c           |  3 +++
 mm/failslab.c                |  3 +++
 mm/internal.h                | 15 +++++++++++++++
 mm/page_alloc.c              | 18 ++++++++++--------
 5 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 2d04f6448cde..9f6e25467844 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -20,6 +20,7 @@ struct fault_attr {
 	atomic_t space;
 	unsigned long verbose;
 	bool task_filter;
+	bool no_warn;
 	unsigned long stacktrace_depth;
 	unsigned long require_start;
 	unsigned long require_end;
@@ -39,6 +40,7 @@ struct fault_attr {
 		.ratelimit_state = RATELIMIT_STATE_INIT_DISABLED,	\
 		.verbose = 2,						\
 		.dname = NULL,						\
+		.no_warn = false,					\
 	}
 
 #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index ce12621b4275..423784d9c058 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -41,6 +41,9 @@ EXPORT_SYMBOL_GPL(setup_fault_attr);
 
 static void fail_dump(struct fault_attr *attr)
 {
+	if (attr->no_warn)
+		return;
+
 	if (attr->verbose > 0 && __ratelimit(&attr->ratelimit_state)) {
 		printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure.\n"
 		       "name %pd, interval %lu, probability %lu, "
diff --git a/mm/failslab.c b/mm/failslab.c
index f92fed91ac23..58df9789f1d2 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -30,6 +30,9 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 	if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
 		return false;
 
+	if (gfpflags & __GFP_NOWARN)
+		failslab.attr.no_warn = true;
+
 	return should_fail(&failslab.attr, s->object_size);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index e3e50af20706..34fdedb9986f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -35,6 +35,21 @@ struct folio_batch;
 /* Do not use these with a slab allocator */
 #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
 
+/*
+ * Different from WARN_ON_ONCE(), no warning will be issued
+ * when we specify __GFP_NOWARN.
+ */
+#define WARN_ON_ONCE_GFP(cond, gfp)	({				\
+	static bool __section(".data.once") __warned;			\
+	int __ret_warn_once = !!(cond);					\
+									\
+	if (unlikely(!(gfp & __GFP_NOWARN) && __ret_warn_once && !__warned)) { \
+		__warned = true;					\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn_once);					\
+})
+
 void page_writeback_init(void);
 
 static inline void *folio_raw_mapping(struct folio *folio)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 65f892af1d4f..f9f329403d76 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3789,6 +3789,9 @@ static bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 			(gfp_mask & __GFP_DIRECT_RECLAIM))
 		return false;
 
+	if (gfp_mask & __GFP_NOWARN)
+		fail_page_alloc.attr.no_warn = true;
+
 	return should_fail(&fail_page_alloc.attr, 1 << order);
 }
 
@@ -4337,7 +4340,8 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	 */
 
 	/* Exhausted what can be done so it's blame time */
-	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
+	if (out_of_memory(&oc) ||
+	    WARN_ON_ONCE_GFP(gfp_mask & __GFP_NOFAIL, gfp_mask)) {
 		*did_some_progress = 1;
 
 		/*
@@ -5103,7 +5107,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * All existing users of the __GFP_NOFAIL are blockable, so warn
 		 * of any new users that actually require GFP_NOWAIT
 		 */
-		if (WARN_ON_ONCE(!can_direct_reclaim))
+		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
 			goto fail;
 
 		/*
@@ -5111,7 +5115,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * because we cannot reclaim anything and only can loop waiting
 		 * for somebody to do a work for us
 		 */
-		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
+		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
 
 		/*
 		 * non failing costly orders are a hard requirement which we
@@ -5119,7 +5123,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * so that we can identify them and convert them to something
 		 * else.
 		 */
-		WARN_ON_ONCE(order > PAGE_ALLOC_COSTLY_ORDER);
+		WARN_ON_ONCE_GFP(order > PAGE_ALLOC_COSTLY_ORDER, gfp_mask);
 
 		/*
 		 * Help non-failing allocations by giving them access to memory
@@ -5365,10 +5369,8 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.
 	 */
-	if (unlikely(order >= MAX_ORDER)) {
-		WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
+	if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))
 		return NULL;
-	}
 
 	gfp &= gfp_allowed_mask;
 	/*
@@ -9020,7 +9022,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 
 	lru_cache_enable();
 	if (ret < 0) {
-		if (ret == -EBUSY)
+		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
 			alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
 		return ret;
-- 
2.20.1

