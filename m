Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D2521408
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiEJLm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbiEJLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:42:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B431E2504
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:38:43 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x12so14409894pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNlY8WkQxosiDZoDlklmubpls2PsalAORRWxYgT6bec=;
        b=0zvsz6KLTSBegmPoUHebKUfBQrcIOfRCv4H+tzjrwHUniWEZ4rpdqpEcSXU2x9regd
         uNmuIIGjZBCwALLywwLF54cySGhiF20MGapv4OEBfq2AC6Vkp0tVwI0fUq9tl8lxdHg9
         RUUeI7caEP7DpKBzVlMJcJlhHNddUYrEY31vXUNgjG3kw995BeCecZNNRtHYF6MXrKRt
         DQkvhOXAppdqujUKwHPsYEHYCshMYaRtwoohBidW3lyTZgHYalycRe8WbQclukBoS/Ns
         71I2m4jy86sL+RMVSS06jxNVLAamEMD3W2VdPd/W3ZRrAA8gMrkmp8GsmHhG4l4/zhpa
         3ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNlY8WkQxosiDZoDlklmubpls2PsalAORRWxYgT6bec=;
        b=4fQ1Gc3G9Z9kV5p4DbkDhgkeVSaesfPQ5Nnvo1TKYovz0v1YZvKfmxwRSdKSw0T9iv
         eth3P6k7UT5yPpzsFgf/1VlgawMaD+2C1uccT3OgCVvl07dIy4r1sMi3mgh6faxxumDQ
         h7U1MnX1Tbuaa1AwR1sccLCJBLw8eE1vzddZJx/Tjh5WnuAo82cV4Mjwgw0eehla8WvS
         YNDDeoqCkGzVvEhZs7uul3Pk6YKvkxLLxOwVvW6LaPorG3p60NKepQdtDYmPY5zLzXpO
         U7uTdYHteZtF0TsBCApDVRX2U1C9rfdBe2KnoHO3i+6m37mx0osISHUH4+z4w3XYFGGe
         Anvg==
X-Gm-Message-State: AOAM531kn5byXMIPzfjUR710mRUvW8GmSZxVj9j1kxcmOj7SP4EbI34B
        yN6QfybCEUER6TwLAW1DMNzLKQ==
X-Google-Smtp-Source: ABdhPJwKxNzXKGFAX8K6EQTcdh5UExtVeQxDPYC/vGaXe9dniRG50dOLEj10a4THOHQ7Kvb4Wtz7mQ==
X-Received: by 2002:a63:89c7:0:b0:3da:ee16:c84 with SMTP id v190-20020a6389c7000000b003daee160c84mr2066328pgd.320.1652182722547;
        Tue, 10 May 2022 04:38:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id bj7-20020a170902850700b0015e8d4eb20bsm1800645plb.85.2022.05.10.04.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:38:41 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akinobu.mita@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/2] mm: fix missing handler for __GFP_NOWARN
Date:   Tue, 10 May 2022 19:38:08 +0800
Message-Id: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
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

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/fault-inject.h |  2 ++
 lib/fault-inject.c           |  3 +++
 mm/failslab.c                |  3 +++
 mm/internal.h                | 11 +++++++++++
 mm/page_alloc.c              | 22 ++++++++++++----------
 5 files changed, 31 insertions(+), 10 deletions(-)

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
index cf16280ce132..7a268fac6559 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -35,6 +35,17 @@ struct folio_batch;
 /* Do not use these with a slab allocator */
 #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
 
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
index 0e42038382c1..2bf4ce4d0e2f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3722,7 +3722,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	 * We most definitely don't want callers attempting to
 	 * allocate greater than order-1 page units with __GFP_NOFAIL.
 	 */
-	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
+	WARN_ON_ONCE_GFP((gfp_flags & __GFP_NOFAIL) && (order > 1), gfp_flags);
 
 	do {
 		page = NULL;
@@ -3799,6 +3799,9 @@ static bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 			(gfp_mask & __GFP_DIRECT_RECLAIM))
 		return false;
 
+	if (gfp_mask & __GFP_NOWARN)
+		fail_page_alloc.attr.no_warn = true;
+
 	return should_fail(&fail_page_alloc.attr, 1 << order);
 }
 
@@ -4346,7 +4349,8 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	 */
 
 	/* Exhausted what can be done so it's blame time */
-	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
+	if (out_of_memory(&oc) ||
+	    WARN_ON_ONCE_GFP(gfp_mask & __GFP_NOFAIL, gfp_mask)) {
 		*did_some_progress = 1;
 
 		/*
@@ -4902,8 +4906,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * We also sanity check to catch abuse of atomic reserves being used by
 	 * callers that are not in atomic context.
 	 */
-	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
-				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
+	if (WARN_ON_ONCE_GFP((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
+				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM), gfp_mask))
 		gfp_mask &= ~__GFP_ATOMIC;
 
 retry_cpuset:
@@ -5117,7 +5121,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * All existing users of the __GFP_NOFAIL are blockable, so warn
 		 * of any new users that actually require GFP_NOWAIT
 		 */
-		if (WARN_ON_ONCE(!can_direct_reclaim))
+		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
 			goto fail;
 
 		/*
@@ -5125,7 +5129,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * because we cannot reclaim anything and only can loop waiting
 		 * for somebody to do a work for us
 		 */
-		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
+		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
 
 		/*
 		 * non failing costly orders are a hard requirement which we
@@ -5133,7 +5137,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * so that we can identify them and convert them to something
 		 * else.
 		 */
-		WARN_ON_ONCE(order > PAGE_ALLOC_COSTLY_ORDER);
+		WARN_ON_ONCE_GFP(order > PAGE_ALLOC_COSTLY_ORDER, gfp_mask);
 
 		/*
 		 * Help non-failing allocations by giving them access to memory
@@ -5379,10 +5383,8 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
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
-- 
2.20.1

