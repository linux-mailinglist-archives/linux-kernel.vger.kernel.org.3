Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7E5242E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiELCxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243697AbiELCxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:53:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9361CC990
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:53:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv2so3913332pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrgF71qNNcYD8nMa0N2Q78v1uFUFa9LGIhiMObVxexI=;
        b=MC7TNUG4QWAakfYQhS5QSM5SxEsCYVGXnkyUwHwXKvplZ7MABo+4i4g7EAumDk/IRK
         B/VKo4UUmnm0M/qTCiamuZh7YCX948h8rzLdv8+lnO5rORzPD8JKJcYht2q/0fuD48JN
         zB56ucdFuOstRW34Cfa/XsT0/gKAIYX7rToPeRXjPJtxovndrRjgak2/ROloBqi92rQw
         eOaweOM8ilNP4E4+F5hkh69jRUVjneiqzlljaBPBsp7bRbeVxwYrqX4qSzBOHfn+x1YH
         LYfBvIQImecH4tqm76Sge0c3Y7EoSdKlVNerS6yPCL7WzLz7trGFCZasWe/Qq9b/oV28
         P+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrgF71qNNcYD8nMa0N2Q78v1uFUFa9LGIhiMObVxexI=;
        b=lobESlCTYHoBjY4SCdX6wmtM+rzKtIbaqwy0lUzMxqMbpCexUfAmycwgdu1zuBVcdW
         t7+m0F8RodPsR8At0NkFiHeTIgORDWjm6KJFIcY7r2DRFskbUG1rnHU84GGPEUzENoRk
         g9OUAP0KCAftpAp6HVkzRkw6F0WCTLqJuMTVIkqEUxSgPtwd7XT5DrJ3dyoLRLXrdaYb
         By9eoTZpE7IchpXfLKTxmx12dvladMTmK1Qrll7Haw8z8ib7CBviSEIzfz7A10X8rTVD
         b1BpgXynUrszCdB1bpdmzW8CxghELiK6Ji5tLOm9CVTkjo6OUasAzejYuyCWSa1vCCU3
         gWoQ==
X-Gm-Message-State: AOAM531yMPUC32+z1Ub52MDmwVLyLaJr1G1AZM1oJlp/xICde/L1nRqz
        a2a3eDgscVb4eimUi8CVdis=
X-Google-Smtp-Source: ABdhPJxiQGyU27UIahq15uZJlZcn2NmrIUajfvr44Ukcf4v/Ucl9xoUNLKWjatK0SYMOaj15aAgLrA==
X-Received: by 2002:a17:90b:606:b0:1d9:5dd5:1489 with SMTP id gb6-20020a17090b060600b001d95dd51489mr8518187pjb.171.1652323993950;
        Wed, 11 May 2022 19:53:13 -0700 (PDT)
Received: from localhost.localdomain ([125.131.156.123])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b0015e8d4eb21fsm2603639pln.105.2022.05.11.19.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 19:53:13 -0700 (PDT)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wonhyuk Yang <vvghjk1234@gmail.com>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [Patch v2] [PATCH] mm/page_alloc: Fix tracepoint mm_page_alloc_zone_locked()
Date:   Thu, 12 May 2022 11:53:07 +0900
Message-Id: <20220512025307.57924-1-vvghjk1234@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, trace point mm_page_alloc_zone_locked() doesn't show
correct information.

First, when alloc_flag has ALLOC_HARDER/ALLOC_CMA, page can
be allocated from MIGRATE_HIGHATOMIC/MIGRATE_CMA. Nevertheless,
tracepoint use requested migration type not MIGRATE_HIGHATOMIC and
MIGRATE_CMA.

Second, after Commit 44042b4498728 ("mm/page_alloc: allow high-order
pages to be stored on the per-cpu lists") percpu-list can store
high order pages. But trace point determine whether it is a refiil
of percpu-list by comparing requested order and 0.

To handle these problems, make mm_page_alloc_zone_locked() only be
called by __rmqueue_smallest with correct migration type. With a
new argument called percpu_refill, it can show roughly whether it
is a refill of percpu-list.

Cc: Baik Song An <bsahn@etri.re.kr>
Cc: Hong Yeon Kim <kimhy@etri.re.kr>
Cc: Taeung Song <taeung@reallinux.co.kr>
Cc: linuxgeek@linuxgeek.io
Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
---
v1 -> v2: Simplify determining percpu-refill suggested by Mel Gorman

 include/trace/events/kmem.h | 14 +++++++++-----
 mm/page_alloc.c             | 13 +++++--------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index ddc8c944f417..f89fb3afcd46 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -229,20 +229,23 @@ TRACE_EVENT(mm_page_alloc,
 
 DECLARE_EVENT_CLASS(mm_page,
 
-	TP_PROTO(struct page *page, unsigned int order, int migratetype),
+	TP_PROTO(struct page *page, unsigned int order, int migratetype,
+		 int percpu_refill),
 
-	TP_ARGS(page, order, migratetype),
+	TP_ARGS(page, order, migratetype, percpu_refill),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	pfn		)
 		__field(	unsigned int,	order		)
 		__field(	int,		migratetype	)
+		__field(	int,		percpu_refill	)
 	),
 
 	TP_fast_assign(
 		__entry->pfn		= page ? page_to_pfn(page) : -1UL;
 		__entry->order		= order;
 		__entry->migratetype	= migratetype;
+		__entry->percpu_refill	= percpu_refill;
 	),
 
 	TP_printk("page=%p pfn=0x%lx order=%u migratetype=%d percpu_refill=%d",
@@ -250,14 +253,15 @@ DECLARE_EVENT_CLASS(mm_page,
 		__entry->pfn != -1UL ? __entry->pfn : 0,
 		__entry->order,
 		__entry->migratetype,
-		__entry->order == 0)
+		__entry->percpu_refill)
 );
 
 DEFINE_EVENT(mm_page, mm_page_alloc_zone_locked,
 
-	TP_PROTO(struct page *page, unsigned int order, int migratetype),
+	TP_PROTO(struct page *page, unsigned int order, int migratetype,
+		 int percpu_refill),
 
-	TP_ARGS(page, order, migratetype)
+	TP_ARGS(page, order, migratetype, percpu_refill)
 );
 
 TRACE_EVENT(mm_page_pcpu_drain,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e42038382c1..e906ac274586 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2476,6 +2476,9 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		del_page_from_free_list(page, zone, current_order);
 		expand(zone, page, order, current_order, migratetype);
 		set_pcppage_migratetype(page, migratetype);
+		trace_mm_page_alloc_zone_locked(page, order, migratetype, 
+				pcp_allowed_order(order) &&
+				migratetype < MIGRATE_PCPTYPES);
 		return page;
 	}
 
@@ -2999,7 +3002,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
 			page = __rmqueue_cma_fallback(zone, order);
 			if (page)
-				goto out;
+				return page;
 		}
 	}
 retry:
@@ -3012,9 +3015,6 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 								alloc_flags))
 			goto retry;
 	}
-out:
-	if (page)
-		trace_mm_page_alloc_zone_locked(page, order, migratetype);
 	return page;
 }
 
@@ -3733,11 +3733,8 @@ struct page *rmqueue(struct zone *preferred_zone,
 		 * reserved for high-order atomic allocation, so order-0
 		 * request should skip it.
 		 */
-		if (order > 0 && alloc_flags & ALLOC_HARDER) {
+		if (order > 0 && alloc_flags & ALLOC_HARDER)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
-			if (page)
-				trace_mm_page_alloc_zone_locked(page, order, migratetype);
-		}
 		if (!page) {
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
 			if (!page)
-- 
2.30.2

