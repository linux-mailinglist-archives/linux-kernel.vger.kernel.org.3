Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D217A503353
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiDPFly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiDPFlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:41:42 -0400
Received: from eastern.birch.relay.mailchannels.net (eastern.birch.relay.mailchannels.net [23.83.209.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DF2FCBC5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:39:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 66FAC6C0905;
        Sat, 16 Apr 2022 05:39:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9EEF46C08CD;
        Sat, 16 Apr 2022 05:39:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650087549; a=rsa-sha256;
        cv=none;
        b=sbosIBhnEqP1T17IyQBJiEtU/uS2lfZdVvZLa55sLUW8R4P293rXEojZ+eQa0BehrjjNyS
        GtbXbXvnkOCLORoeOGORl+gNG0jhT//wPSmlr26FG/6BWGWCly2hS35xRXuAWiBFq3bDjK
        MmQHFCeXiMN4F8k7Kw7sOgDl3K8/BEsuHKfPKD9toH//v3isBfOAXTm+/tL37V8VgbpUJP
        W0MwlBKCDJSO5h2mJf4B1dcdBxA+4kka5Dr6V6zn7NjzPcrohNpcwsUy8ozJvfFrVBmmYm
        k3VjkoJj/HineqBmq804b71J2QLN1JjcwVXwuQ6ESVCqLnSXoTB2kgEcDKUsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650087549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=f59htISnwsqoH/jBojWcG/OX8Gw18WwWDAuC1GWBkrc=;
        b=LjAwIScXaues8ODld+ikp2DoRT/kH0s1tZQi5XHiJLc0Bu+oyXhKLJZ/DHZ+WK2Xnreq23
        hZnseiZIpCGZDL2v/6IJpDWfxED8U58PGpQIz8pNkU6hJR1U8UApt0nHM57rdMJ0Y0152t
        dyTMFCmo/ev9KwQoEVaVkOYbXPKSaD2LyNBYcqauV5X57ZJ85yiKcMlOcCrEXh3lz3d5NT
        7QumbFtCwI3nZZ/5YirWHxXs3AsAWxEW+z3upjESwvGhxjxn5cbrqFrSvrtqfGUYkoEJj1
        +SL7rso6Xpfrd9s979otP32YURrMYnF0iFcd0Fwf6jrRnRmRyaLgdRwKkDB0fA==
ARC-Authentication-Results: i=1;
        rspamd-b69d6888c-zhs78;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.158.161 (trex/6.7.1);
        Sat, 16 Apr 2022 05:39:10 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Minister: 2239f3141878fde9_1650087550201_4208480808
X-MC-Loop-Signature: 1650087550201:4069922302
X-MC-Ingress-Time: 1650087550201
Received: from localhost.localdomain (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KgMSr2zjXz1M5;
        Fri, 15 Apr 2022 22:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650087549;
        bh=f59htISnwsqoH/jBojWcG/OX8Gw18WwWDAuC1GWBkrc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=nFPvhSglVmtuufEmK6rGA668yDzj4PT0wtwCTlI3Pa5k5AFfKRgEbHOx/iMxJyzTr
         MW3dLOtFRYgV/T8I598HUMMjY6i9ZXcUOzZGTcceQi8gV7j6pxIOSDpGmUuo/pRmOE
         7PpemJMP4k5fWMZPf7nEj1EMXi90TV674KMZAuCrlR10bFLrgU4ftCjsYtlMSfiJHy
         EMC1pNwgnqnnxCxADAbhVsAGMGCCSZkofbuXuU4hACZhipSKgp20heJcztRdQmQmAf
         yn0g952C7zaU7xYYoLC88WhRVnYr0lFDDMBPWDwj4xyQlUAxH0iesIha60bqEBDxHA
         l5K3VkL1TaPgg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mm: make __node_reclaim() more flexible
Date:   Fri, 15 Apr 2022 22:38:59 -0700
Message-Id: <20220416053902.68517-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220416053902.68517-1-dave@stgolabs.net>
References: <20220416053902.68517-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __node_reclaim() is tailored to the allocator paths. With
proactive per-node reclaim it requires a bit more flexibly:

 - Deal in terms of nr_pages instead of order. Similarly this also
   applies to the respective tracing.
 - Make the caller pass an already armed scan control.
 - Return number of reclaimed pages. The caller can trivially check
   against this explicitly instead.

The current node_reclaim() interface remains the same.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 include/trace/events/vmscan.h | 12 ++++-----
 mm/vmscan.c                   | 47 +++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index de136dbd623a..ab6ce8d8770b 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -439,25 +439,25 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
 
 TRACE_EVENT(mm_vmscan_node_reclaim_begin,
 
-	TP_PROTO(int nid, int order, gfp_t gfp_flags),
+	TP_PROTO(int nid, unsigned long nr_pages, gfp_t gfp_flags),
 
-	TP_ARGS(nid, order, gfp_flags),
+	TP_ARGS(nid, nr_pages, gfp_flags),
 
 	TP_STRUCT__entry(
 		__field(int, nid)
-		__field(int, order)
+		__field(int, nr_pages)
 		__field(gfp_t, gfp_flags)
 	),
 
 	TP_fast_assign(
 		__entry->nid = nid;
-		__entry->order = order;
+		__entry->nr_pages = nr_pages;
 		__entry->gfp_flags = gfp_flags;
 	),
 
-	TP_printk("nid=%d order=%d gfp_flags=%s",
+	TP_printk("nid=%d nr_pages=%d gfp_flags=%s",
 		__entry->nid,
-		__entry->order,
+		__entry->nr_pages,
 		show_gfp_flags(__entry->gfp_flags))
 );
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cb583fcbf5bf..1735c302831c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4668,36 +4668,28 @@ static unsigned long node_pagecache_reclaimable(struct pglist_data *pgdat)
 
 /*
  * Try to free up some pages from this node through reclaim.
+ * Returns the number of reclaimed pages.
  */
-static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
+static unsigned long __node_reclaim(struct pglist_data *pgdat,
+				    gfp_t gfp_mask, unsigned long nr_pages,
+				    struct scan_control *sc)
 {
 	/* Minimum pages needed in order to stay on node */
-	const unsigned long nr_pages = 1 << order;
 	struct task_struct *p = current;
 	unsigned int noreclaim_flag;
-	struct scan_control sc = {
-		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
-		.gfp_mask = current_gfp_context(gfp_mask),
-		.order = order,
-		.priority = NODE_RECLAIM_PRIORITY,
-		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
-		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
-		.may_swap = 1,
-		.reclaim_idx = gfp_zone(gfp_mask),
-	};
 	unsigned long pflags;
 
-	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
-					   sc.gfp_mask);
+	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, nr_pages,
+					   sc->gfp_mask);
 
 	cond_resched();
 	psi_memstall_enter(&pflags);
-	fs_reclaim_acquire(sc.gfp_mask);
+	fs_reclaim_acquire(sc->gfp_mask);
 	/*
 	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
 	 */
 	noreclaim_flag = memalloc_noreclaim_save();
-	set_task_reclaim_state(p, &sc.reclaim_state);
+	set_task_reclaim_state(p, &sc->reclaim_state);
 
 	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
 		/*
@@ -4705,23 +4697,34 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		 * priorities until we have enough memory freed.
 		 */
 		do {
-			shrink_node(pgdat, &sc);
-		} while (sc.nr_reclaimed < nr_pages && --sc.priority >= 0);
+			shrink_node(pgdat, sc);
+		} while (sc->nr_reclaimed < nr_pages && --sc->priority >= 0);
 	}
 
 	set_task_reclaim_state(p, NULL);
 	memalloc_noreclaim_restore(noreclaim_flag);
-	fs_reclaim_release(sc.gfp_mask);
+	fs_reclaim_release(sc->gfp_mask);
 	psi_memstall_leave(&pflags);
 
-	trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);
+	trace_mm_vmscan_node_reclaim_end(sc->nr_reclaimed);
 
-	return sc.nr_reclaimed >= nr_pages;
+	return sc->nr_reclaimed;
 }
 
 int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 {
 	int ret;
+	const unsigned long nr_pages = 1 << order;
+	struct scan_control sc = {
+		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
+		.gfp_mask = current_gfp_context(gfp_mask),
+		.order = order,
+		.priority = NODE_RECLAIM_PRIORITY,
+		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
+		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
+		.may_swap = 1,
+		.reclaim_idx = gfp_zone(gfp_mask),
+	};
 
 	/*
 	 * Node reclaim reclaims unmapped file backed pages and
@@ -4756,7 +4759,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
 		return NODE_RECLAIM_NOSCAN;
 
-	ret = __node_reclaim(pgdat, gfp_mask, order);
+	ret = __node_reclaim(pgdat, gfp_mask, nr_pages, &sc) >= nr_pages;
 	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (!ret)
-- 
2.26.2

