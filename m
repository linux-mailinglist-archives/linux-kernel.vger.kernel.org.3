Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98AE4D78BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 00:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiCMX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiCMX1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 19:27:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE4D8B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 16:25:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso12848463pjo.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WAKvHaxwkF54RfaaelAcwFZFObo76focrshoyvOHapk=;
        b=GjRCG7zfWbJT4fsFYqxKXWZHT3O3kiPi70JpCtjT0H8Sumx+BOJZtCQBNsqC88wrGJ
         7bQ0FDK5JLUgLdeSSzrY1AMB0OmGO5i5Hp7i6Mnh3u0Pba7VJCL0OGa5ljK8M6m4vTHZ
         HclFb4lp5en3oYwnz51vlviEkcqil0Y24X9Ssb5z9SLS4AXqBJGq3QKXAbxUi7uJD1e3
         lMtHw7hKnqEYx4f9G6IsCnxeBVtyibhcMVRjcx2tH5kKMdf9BZTtGL2nfPcQKj5/5xUZ
         bWRqW//aKDulyOdLwpqxBRC+SzKPl8tTjfYR4H42MsEMIs9B/OpDLB+ZjoG4UY14p0sk
         MkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WAKvHaxwkF54RfaaelAcwFZFObo76focrshoyvOHapk=;
        b=Mjiud4rhVYKGD877ZOBuzULdjlbdvk0CKBHn7laA8jmABoE9sUslnagllY5u3kpVG3
         qFMs34aiQIMRKVvaJRGB124U7g4GM012OodYjudJKam5uStqRTmET0nDQd/wNqes6/iA
         sRrHv1y7BIoGhLoNdPuXHjQHuEBrkyecj+ifO5k9HL6VC3xe2YqQi2A/GYKu2qblOyhe
         CprSn+Bmx1ZJMw4bZQ+GoIQm6qkNs5vsklKPiUeIFX12rL7IMLQfMgyfSrZviiFT7lmh
         nA5UKY1WGBB+i5qjYXTtLGIvs+E8hAIz5c4wN0WGf5NL3DRQGM3cmx4KoeXoyRxDb4gK
         oB+Q==
X-Gm-Message-State: AOAM532pgEQMhKrKLNCMK6kmHDSyT4wM3Jjlfx/d6GSLQGG3vQGx8G75
        VZcXkMKZDjiIs1/pVe9cj+Y=
X-Google-Smtp-Source: ABdhPJymcDVZQcoUrN0YqMtWtmK4QwpRlxQGxZlloC71h2nHXamfg0Aj2sdIqnv+kIXYU+PuxrNmPg==
X-Received: by 2002:a17:90a:1d05:b0:1bf:6a85:fbf5 with SMTP id c5-20020a17090a1d0500b001bf6a85fbf5mr22125124pjd.205.1647213956089;
        Sun, 13 Mar 2022 16:25:56 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:c921:4439:3ddf:5385])
        by smtp.gmail.com with ESMTPSA id t9-20020a655549000000b0036570f81245sm14475487pgr.84.2022.03.13.16.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 16:25:55 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/page_alloc: call check_pcp_refill() while zone spinlock is not held
Date:   Sun, 13 Mar 2022 16:25:47 -0700
Message-Id: <20220313232547.3843690-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

check_pcp_refill() is used from rmqueue_bulk() while zone spinlock
is held.

This used to be fine because check_pcp_refill() was testing only the
head page, while its 'struct page' was very hot in the cpu caches.

With ("mm/page_alloc: check high-order pages for corruption during PCP
operations") check_pcp_refill() will add latencies for high order pages.

We can defer the calls to check_pcp_refill() after the zone
spinlock has been released.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Wei Xu <weixugc@google.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/page_alloc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c9ebf0635d592c6f58df9793ce9fa213371a9a7f..5f0531c11ad668b1c4426ebddc17821aca824783 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3024,7 +3024,9 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	struct page *page, *tmp;
 	int i, allocated = 0;
+	int free_cma_pages = 0;
 
 	/*
 	 * local_lock_irq held so equivalent to spin_lock_irqsave for
@@ -3032,14 +3034,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 */
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
-		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+		page = __rmqueue(zone, order, migratetype, alloc_flags);
 		if (unlikely(page == NULL))
 			break;
 
-		if (unlikely(check_pcp_refill(page)))
-			continue;
-
 		/*
 		 * Split buddy pages returned by expand() are received here in
 		 * physical page order. The page is added to the tail of
@@ -3052,9 +3050,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 */
 		list_add_tail(&page->lru, list);
 		allocated++;
-		if (is_migrate_cma(get_pcppage_migratetype(page)))
-			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
-					      -(1 << order));
 	}
 
 	/*
@@ -3065,6 +3060,16 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
 	spin_unlock(&zone->lock);
+	list_for_each_entry_safe(page, tmp, list, lru) {
+		if (unlikely(check_pcp_refill(page))) {
+			list_del(&page->lru);
+			allocated--;
+		} else if (is_migrate_cma(get_pcppage_migratetype(page))) {
+			free_cma_pages++;
+		}
+	}
+	if (free_cma_pages)
+		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, -(free_cma_pages << order));
 	return allocated;
 }
 
-- 
2.35.1.723.g4982287a31-goog

