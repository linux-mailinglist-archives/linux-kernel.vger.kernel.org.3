Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6419D552A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiFUERm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbiFUER2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:17:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56925ED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:17:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC40821F36;
        Tue, 21 Jun 2022 04:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655785045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RD4sy+2BaX5dGg7b7ucLGgHHapq1SLtKUacFvTEnfcw=;
        b=QjIquwJYZLJwTxi8gcPBkW+f69EjNnNYPBikE5v9wlMM3rIlFRqPVmr73cSWXS4cS6RxXj
        7rUVLuGDQ3cUv3csK4AiMecz0Y4ZhKFjxx2nHMBPJiC1zDuaAIZfNNy76s82Y0Qzn2BZF3
        +9B3tltxCldl3aiF+QSDUqFKxJluNSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655785045;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RD4sy+2BaX5dGg7b7ucLGgHHapq1SLtKUacFvTEnfcw=;
        b=HG3iaJAln/w9mHkkdLgaE/tOq2y/oW+ySyN7n5ei2te6jezSoii+28guvjax8/oQuSAK+d
        Hab1RlMU5t859oCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8670813A37;
        Tue, 21 Jun 2022 04:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6G3hHVVGsWLLGwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 21 Jun 2022 04:17:25 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/2] mm/page_alloc: Do not calculate node's total pages and memmap pages when empty
Date:   Tue, 21 Jun 2022 06:17:16 +0200
Message-Id: <20220621041717.6355-2-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621041717.6355-1-osalvador@suse.de>
References: <20220621041717.6355-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_area_init_node() calls calculate_node_totalpages() and
free_area_init_core(). The former to get node's {spanned,present}_pages,
and the latter to calculate, among other things, how many pages per zone
we spent on memmap_pages, which is used to substract zone's free pages.

On memoryless-nodes, it is pointless to perform such a bunch of work, so
make sure we skip the calculations when having a node or empty zone.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..2b9b2422ba32 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7361,6 +7361,10 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 	unsigned long realtotalpages = 0, totalpages = 0;
 	enum zone_type i;
 
+	/* Skip calculation for memoryless nodes */
+	if (pgdat_is_empty(pgdat))
+		goto no_pages;
+
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 		unsigned long zone_start_pfn, zone_end_pfn;
@@ -7393,6 +7397,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		realtotalpages += real_size;
 	}
 
+no_pages:
 	pgdat->node_spanned_pages = totalpages;
 	pgdat->node_present_pages = realtotalpages;
 	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
@@ -7610,6 +7615,12 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		size = zone->spanned_pages;
 		freesize = zone->present_pages;
 
+		/* No pages? Nothing to calculate then. */
+		if (!size) {
+			zone_init_internals(zone, j, nid, 0);
+			continue;
+		}
+
 		/*
 		 * Adjust freesize so that it accounts for how much memory
 		 * is used by this zone for memmap. This affects the watermark
@@ -7647,9 +7658,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		 */
 		zone_init_internals(zone, j, nid, freesize);
 
-		if (!size)
-			continue;
-
 		set_pageblock_order();
 		setup_usemap(zone);
 		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
@@ -7730,7 +7738,7 @@ static void __init free_area_init_node(int nid)
 	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
 
-	if (start_pfn != end_pfn) {
+	if (!pgdat_is_empty(pgdat)) {
 		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
 			(u64)start_pfn << PAGE_SHIFT,
 			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
-- 
2.35.3

