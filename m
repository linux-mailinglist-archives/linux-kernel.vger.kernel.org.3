Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF74D0275
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbiCGPIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbiCGPIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:08:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356D5F8F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:07:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A33DB210F6;
        Mon,  7 Mar 2022 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646665654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+A0bDyvDGXMAEGgLd6HrR1FD9t6zIOokUQHzoAnIiw=;
        b=Jd6GKQ9CUlQiRU4Ruylo/72Vw/mzoTPXEaHLVjz3U8htklKaWXDhh9ENlGO9pxRJZIBssi
        xT0bfWbxVcU0t1QCPYCITTJc2yOFlnQI+7wA2EIPrI6tzRst7ssacZ4QAJS7/QVSeAOhNu
        CpyiHOz9t06tLOWQ+3RF2Nx3Le+5x0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646665654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+A0bDyvDGXMAEGgLd6HrR1FD9t6zIOokUQHzoAnIiw=;
        b=+G0LP7QZV1k0Ud+wRWdG3t4zAkFwL8JaDfCtV/eqHl+PU2FLOf/Dn6GQfw2oJ2vtjkuwN4
        Jg/zADZI7rm8fPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27D34132BC;
        Mon,  7 Mar 2022 15:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eAj7BrYfJmLrHgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 07 Mar 2022 15:07:34 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/3] mm/page_alloc: Do not calculate node's total pages and memmap pages when empty
Date:   Mon,  7 Mar 2022 16:07:23 +0100
Message-Id: <20220307150725.6810-2-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307150725.6810-1-osalvador@suse.de>
References: <20220307150725.6810-1-osalvador@suse.de>
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
 mm/page_alloc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 967085c1c78a..0b7d176a8990 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7312,6 +7312,10 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 	unsigned long realtotalpages = 0, totalpages = 0;
 	enum zone_type i;
 
+	/* Skip calculation for memoryless nodes */
+	if (node_start_pfn == node_end_pfn)
+		goto no_pages;
+
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 		unsigned long zone_start_pfn, zone_end_pfn;
@@ -7344,6 +7348,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		realtotalpages += real_size;
 	}
 
+no_pages:
 	pgdat->node_spanned_pages = totalpages;
 	pgdat->node_present_pages = realtotalpages;
 	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
@@ -7562,6 +7567,10 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		size = zone->spanned_pages;
 		freesize = zone->present_pages;
 
+		/* No pages? Nothing to calculate then. */
+		if (!size)
+			goto no_pages;
+
 		/*
 		 * Adjust freesize so that it accounts for how much memory
 		 * is used by this zone for memmap. This affects the watermark
@@ -7597,6 +7606,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		 * when the bootmem allocator frees pages into the buddy system.
 		 * And all highmem pages will be managed by the buddy system.
 		 */
+no_pages:
 		zone_init_internals(zone, j, nid, freesize);
 
 		if (!size)
-- 
2.34.1

