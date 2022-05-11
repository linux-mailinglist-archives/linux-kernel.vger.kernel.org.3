Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF9522DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbiEKIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiEKIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:12:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D61F3135C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:12:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so1146996plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cqJR2AA+wNKWbyVIetsUsVHvhXM2cLpfd5b5B8Xn3tg=;
        b=jFlZHXvADIRkCRlklvNg7gh4pcEQYsdUWPiarBS4j4Xq6JltD0PiSGyqh5Vl+xq54U
         bFbwlaGBKNGqmGUR9BAiKyjE3GAERMDhpJU2EbAKPidHXgPHmh5+kT28J/ou05ShmjRP
         eR9l9we6/YnhjzicYiGOYzTfnj1c4Tl6uKDaUf/OprDbU2Aj4vbv6zJwRtJZZ9bs6m+S
         VCcR4KInrRuphEK/qmSbOZ/OKPPsUis6flBysYoPwZOaZowlGPafw+HjYvnVZcT/AtN7
         F0vISpDdaZdrfge/HN0XEaG9bnC89q0ZV11LE8Fi8S3e9TtlizKJbTXWSFnsYllSyYil
         d7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cqJR2AA+wNKWbyVIetsUsVHvhXM2cLpfd5b5B8Xn3tg=;
        b=m9jgugQVk3OW9v9yCzThYb8CBIM48IROV1/fTXA0WT13GO3/6+6pgkPBAVFQak2XtA
         tpvXkzdZjOH5YIKh4UZV9A8Fmym9mCahW9I5Ku/sxK5vuW+o1qtNSo7bFJeIiu1816aX
         Ur4Pvh5wY8/GVqxJODGSAglsU3MZhS/0RwiQb0v4zQzhUl1IfDaDWbmlGgt5NECUT9qM
         sEXXsucRWRpfrTnEtYCcOBx+w73Yy7TkT9SONBu6AZFkf4CKMUUqsUKUDiP2fjbsEQQc
         MO7BJBRLNDlbeE20mb/NTOMP23EjooinbCYTqGQxMaUyFHkWql9uD3aaxitCZBSqz6sL
         30Hg==
X-Gm-Message-State: AOAM531qmKkoHVBXgpfxfeuehnr1J/nKEvdgJLSS3c9t5YLlmMOLrY0j
        M9RO/kb5AaHjsQGDMxFHXYM=
X-Google-Smtp-Source: ABdhPJzOpnwc+Ic2DdJylptmY/bldO6LmURa5sfn+gm7gn+nyabdPinrJUTlGA11hWuAbdSA4Y4NJQ==
X-Received: by 2002:a17:90a:f30d:b0:1dc:b437:4ab with SMTP id ca13-20020a17090af30d00b001dcb43704abmr4067693pjb.23.1652256735731;
        Wed, 11 May 2022 01:12:15 -0700 (PDT)
Received: from localhost.localdomain ([125.131.156.123])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090ad80400b001d8ace370cbsm3294259pjv.54.2022.05.11.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:12:14 -0700 (PDT)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wonhyuk Yang <vvghjk1234@gmail.com>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/page_alloc: Fix tracepoint mm_page_alloc_zone_locked()
Date:   Wed, 11 May 2022 17:12:07 +0900
Message-Id: <20220511081207.132034-1-vvghjk1234@gmail.com>
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

To handle these problems, use cached migration type by
get_pcppage_migratetype() instead of requested migration type.
Then, make mm_page_alloc_zone_locked() be called only two contexts
(rmqueue_bulk, rmqueue). With a new argument called percpu_refill,
it can show whether it is a refill of percpu-list correctly.

Cc: Baik Song An <bsahn@etri.re.kr>
Cc: Hong Yeon Kim <kimhy@etri.re.kr>
Cc: Taeung Song <taeung@reallinux.co.kr>
Cc: linuxgeek@linuxgeek.io
Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
---
 include/trace/events/kmem.h | 14 +++++++++-----
 mm/page_alloc.c             | 18 +++++++++---------
 2 files changed, 18 insertions(+), 14 deletions(-)

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
index 0e42038382c1..0351808322ba 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2999,7 +2999,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
 			page = __rmqueue_cma_fallback(zone, order);
 			if (page)
-				goto out;
+				return page;
 		}
 	}
 retry:
@@ -3012,9 +3012,6 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 								alloc_flags))
 			goto retry;
 	}
-out:
-	if (page)
-		trace_mm_page_alloc_zone_locked(page, order, migratetype);
 	return page;
 }
 
@@ -3028,6 +3025,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			int migratetype, unsigned int alloc_flags)
 {
 	int i, allocated = 0;
+	int mt;
 
 	/*
 	 * local_lock_irq held so equivalent to spin_lock_irqsave for
@@ -3055,7 +3053,9 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 */
 		list_add_tail(&page->lru, list);
 		allocated++;
-		if (is_migrate_cma(get_pcppage_migratetype(page)))
+		mt = get_pcppage_migratetype(page);
+		trace_mm_page_alloc_zone_locked(page, order, mt, true);
+		if (is_migrate_cma(mt))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
 	}
@@ -3704,6 +3704,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 {
 	unsigned long flags;
 	struct page *page;
+	int mt;
 
 	if (likely(pcp_allowed_order(order))) {
 		/*
@@ -3735,16 +3736,15 @@ struct page *rmqueue(struct zone *preferred_zone,
 		 */
 		if (order > 0 && alloc_flags & ALLOC_HARDER) {
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
-			if (page)
-				trace_mm_page_alloc_zone_locked(page, order, migratetype);
 		}
 		if (!page) {
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
 			if (!page)
 				goto failed;
 		}
-		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pcppage_migratetype(page));
+		mt = get_pcppage_migratetype(page);
+		trace_mm_page_alloc_zone_locked(page, order, mt, false);
+		__mod_zone_freepage_state(zone, -(1 << order), mt);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
-- 
2.30.2

