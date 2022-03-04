Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620004CCB7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiCDCAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiCDCAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:00:32 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6D123433
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:59:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so5569226pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 17:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNg4kYdxlqLlNjGIaXFPv1B8vrhqGS0uOksmeWZwteY=;
        b=Yn0FTrDQatEF8PVLYqXopPVgnNKeu9lW4Zw8fNZ5BHwT69cz0rxT2QHh2/ntvLX/zK
         bMgZI3k/5CagA9npMGZnDnn5uaAaTEzMR441qWmN9efL5NC59ZJnQ106kviOBjGgSA9w
         O0ZM1E5SwNwKwX1yMlJG/6dtOwOk9iHwHZsZ7Tz4bv26+1+gI4LiFR4UX373TwWVg2nz
         qu9CII6nKmUfew9ROh8F9KQNmMKusTg0d+aQbO61HsHklNlbdxVyaatQ2xGFPnIE9nkh
         bFWVMwHajfUOYRjHttDpu7EAEplD1wWoHcRB8GE1DH1Lr3ZWgkAib2pyEyEN/fJL+6vk
         9Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNg4kYdxlqLlNjGIaXFPv1B8vrhqGS0uOksmeWZwteY=;
        b=eUqetk/TM/mGv7S/0YCI3+AQn/qXs5HKjbVlFVNePU9UR7WqJw3C5DouoP18uxn2Q8
         SY5LRF9sx/d4vkPGFdRBl1E5mD+mpyYB+LKINuDLsE8ZgxLb3tXiDkMO24LpCTUvo9n4
         V3BBHCPaHmn97ScOap8FMgdvPruDrnypTYtE7uB6vJni4qVgEFWE+DTIqRICZ+6CaRqR
         4wyGWBOhwS/LLhMsj55+eKJ3aaV1zLWw3Ln19gPKeQB7G1vAlJZSC6pT4RnU05/Emgmb
         H7/mBRNa20CuduoJX8LrDuRHwE8RwSpxYnlt5K83ks5f6q4DQ4EWZCaWDdxb2B9YaU55
         /SQQ==
X-Gm-Message-State: AOAM532bOA5WCbvYvhzF8/2S3iTrBJ9tIFmRVcuNdxuSPuVy2Cp4b7nI
        kSUHCXMUEhcQg6woeltVQlxl5Vhe16A=
X-Google-Smtp-Source: ABdhPJwgnJJcohamGBceHBePfAkZJZnry0WsByYaX3qChlXOBgHodh4y3rKqkzAB9D27cneAm4Sx6Q==
X-Received: by 2002:a17:902:aa84:b0:150:8d6:bdec with SMTP id d4-20020a170902aa8400b0015008d6bdecmr38486225plr.118.1646359185389;
        Thu, 03 Mar 2022 17:59:45 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:5388:c313:5e37:a261])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00248500b004f6b5ddcc65sm296707pfv.199.2022.03.03.17.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 17:59:44 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH] mm/page_alloc: call check_new_pages() while zone spinlock is not held
Date:   Thu,  3 Mar 2022 17:59:41 -0800
Message-Id: <20220304015941.1704249-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
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

For high order pages not using pcp, rmqueue() is currently calling
the costly check_new_pages() while zone spinlock is held.

This is not needed, we can release the spinlock sooner to reduce
zone spinlock contention.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: David Rientjes <rientjes@google.com>
---
 mm/page_alloc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31928f850ebe5a4015ddc40e0469f3..0890a65f8cc2259e82bc1f5ba95a592fb30f9fb8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3685,7 +3685,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 			gfp_t gfp_flags, unsigned int alloc_flags,
 			int migratetype)
 {
-	unsigned long flags;
 	struct page *page;
 
 	if (likely(pcp_allowed_order(order))) {
@@ -3706,10 +3705,12 @@ struct page *rmqueue(struct zone *preferred_zone,
 	 * allocate greater than order-1 page units with __GFP_NOFAIL.
 	 */
 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
-	spin_lock_irqsave(&zone->lock, flags);
 
 	do {
+		unsigned long flags;
+
 		page = NULL;
+		spin_lock_irqsave(&zone->lock, flags);
 		/*
 		 * order-0 request can reach here when the pcplist is skipped
 		 * due to non-CMA allocation context. HIGHATOMIC area is
@@ -3723,13 +3724,13 @@ struct page *rmqueue(struct zone *preferred_zone,
 		}
 		if (!page)
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
-	} while (page && check_new_pages(page, order));
-	if (!page)
-		goto failed;
+		spin_unlock_irqrestore(&zone->lock, flags);
+		if (!page)
+			return NULL;
+	} while (check_new_pages(page, order));
 
 	__mod_zone_freepage_state(zone, -(1 << order),
 				  get_pcppage_migratetype(page));
-	spin_unlock_irqrestore(&zone->lock, flags);
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
 	zone_statistics(preferred_zone, zone, 1);
@@ -3743,10 +3744,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
 	return page;
-
-failed:
-	spin_unlock_irqrestore(&zone->lock, flags);
-	return NULL;
 }
 
 #ifdef CONFIG_FAIL_PAGE_ALLOC
-- 
2.35.1.616.g0bdcbb4464-goog

