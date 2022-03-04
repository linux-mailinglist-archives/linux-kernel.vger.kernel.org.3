Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB87C4CD99E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiCDRDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiCDRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:03:08 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE11C6645
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:02:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d17so8139523pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 09:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m9DN8GZLnqfgQbJETPdoOENIKXarw30wjGXDiTZV/WI=;
        b=cXF7pznqQ+nkIi0dJDdpaB4BbNgUDe53v7wcZZhFbbLznD3OsURa5kfTqQ+T3G7yG5
         gjcjozJuDDA7oAJRnhV7tiRyNMEn2JlaG1pRvk4dIp/On6jkSiSS2yoL29SOYXUll/hq
         j0cLZcWuOKiEUGhTk8jQ5E127PzBwO4L4GaOpLmjYQKx5XIUQ/8r0gIMK4XH+ULLWWrZ
         JQInpJ/j3GKVvUaLpxDsnZrfC+H6Vbdu9PcOGLpjW78RNf9fQj3FmWKZojcVLbbVd61/
         HovEuaUsh+1Wk3nsDAcrQdEqMrYNeOcwajgLgwraZ1FkDYa6JUmiV/EFJioupZiKmBP2
         DBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m9DN8GZLnqfgQbJETPdoOENIKXarw30wjGXDiTZV/WI=;
        b=OI8Vl5eLsaktUf0vYnfEeU8EgkM1GD8kbnDoqZLOVyJ8ZnHEKIsUs+BCIoi9ZL8zy7
         pZzy4LGs0HDQanUQai6teI0UvlM9ve2CFn4AZvrx7nbYdjvd7rb7cwuFXQ96QCwXJj3P
         Z9nBi7kAgTD0wm/L1fT6xesGAWZSQ6dMPmbacPF/WdgNJIYlJnwEndq1wc5JltptLl/M
         IZsKSD+XXxk5zXOSZYwcf7IJom3rgYL8RlGpUMyALSj/JXmWGevWRYhC68RZOnjZ0jFj
         jls86/7wpOHQM0LKfwS7XsrKD2gsSWYJuqT30rzGYsqzjqBzbvOYFl1DuxnLWmVkDzRq
         A2Tg==
X-Gm-Message-State: AOAM530ikczLcsTiWZSktqQtCThjF3G8qvkN28KZkFhggJR0kp2l6Clj
        nlIXBao1OaTkN407YE3fuPQ=
X-Google-Smtp-Source: ABdhPJw1+OU2H8gT2uzN0UKOWZeQRmUsnXEp21lDc2Wxz8YGSRZqFGpgM3kMpvTY+orF8Fq8lDlkBA==
X-Received: by 2002:a05:6a00:16d3:b0:4cb:51e2:1923 with SMTP id l19-20020a056a0016d300b004cb51e21923mr43816386pfc.7.1646413339783;
        Fri, 04 Mar 2022 09:02:19 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:5388:c313:5e37:a261])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a000cc900b004f3581ae086sm6947038pfv.16.2022.03.04.09.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 09:02:19 -0800 (PST)
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
Subject: [PATCH v2] mm/page_alloc: call check_new_pages() while zone spinlock is not held
Date:   Fri,  4 Mar 2022 09:02:15 -0800
Message-Id: <20220304170215.1868106-1-eric.dumazet@gmail.com>
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
the costly check_new_pages() while zone spinlock is held,
and hard irqs masked.

This is not needed, we can release the spinlock sooner to reduce
zone spinlock contention.

Note that after this patch, we call __mod_zone_freepage_state()
before deciding to leak the page because it is in bad state.

v2: We need to keep interrupts disabled to call __mod_zone_freepage_state()

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
 mm/page_alloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31928f850ebe5a4015ddc40e0469f3..1804287c1b792b8aa0e964b17eb002b6b1115258 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3706,10 +3706,10 @@ struct page *rmqueue(struct zone *preferred_zone,
 	 * allocate greater than order-1 page units with __GFP_NOFAIL.
 	 */
 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
-	spin_lock_irqsave(&zone->lock, flags);
 
 	do {
 		page = NULL;
+		spin_lock_irqsave(&zone->lock, flags);
 		/*
 		 * order-0 request can reach here when the pcplist is skipped
 		 * due to non-CMA allocation context. HIGHATOMIC area is
@@ -3721,15 +3721,15 @@ struct page *rmqueue(struct zone *preferred_zone,
 			if (page)
 				trace_mm_page_alloc_zone_locked(page, order, migratetype);
 		}
-		if (!page)
+		if (!page) {
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
-	} while (page && check_new_pages(page, order));
-	if (!page)
-		goto failed;
-
-	__mod_zone_freepage_state(zone, -(1 << order),
-				  get_pcppage_migratetype(page));
-	spin_unlock_irqrestore(&zone->lock, flags);
+			if (!page)
+				goto failed;
+		}
+		__mod_zone_freepage_state(zone, -(1 << order),
+					  get_pcppage_migratetype(page));
+		spin_unlock_irqrestore(&zone->lock, flags);
+	} while (check_new_pages(page, order));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
 	zone_statistics(preferred_zone, zone, 1);
-- 
2.35.1.616.g0bdcbb4464-goog

