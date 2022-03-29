Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0194EA472
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiC2BLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiC2BLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:11:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C3827CD1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:09:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg10so32038824ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mwCZhHA9nqulJbLohXXtbB61b1ZNqi8d7Xd2G1q8iKc=;
        b=jnmcvSVvJBI7Xd8CkSC4mOK4vi73UyKCWU3eJQ6hETgpgOYniguERwOCvr3yJ3cAiH
         0QHtl1844SvAIdv2l1rYv5li7wKE8rwrFhs94N+3+/oii52AiVjejQ6fvaw+FnYvokcN
         UJc+9SpgtxryyqyRieLnz62woaz7s4fHsazvi2/G0oi8IbcOHilJXjWkHfyPtm3PE1DI
         orsJt0h29n0hBCwYRFHhR6SeFZ1e8aT14f4TqfXhFav8iqRxrgdrcQnfDao35sMgB/ae
         uZ9EKPg5eBTUCJI6djNwb4vat6zj5Ycul0RiS4YWRCl9ZMa62pj0205vmFF1UWQ9skFB
         xIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mwCZhHA9nqulJbLohXXtbB61b1ZNqi8d7Xd2G1q8iKc=;
        b=FNSbIDoBS6moq3mpwwIM6s12uz394NzMZZpldKwUAqWaxZadM/2KDXmn1QnNDp24LB
         yRqBMy/OCRW/IOkM8bRAk/HClDk9gTcrYYGz1PeBX5pHk7N68kewRMEhDf6X78AuMUTN
         tcLximmzHdinv+dtE/t41sWMdVtBRODhdhCWf+Q9o5QsB/mWpUTJ+W06Aq5YQm7ipyMF
         oQUFHt+fCDPuTTAJdxGN+Dsz/fZ5BMK2pbhgQN1g30zKesjX+iTDFKxsQbZpNAmts6UE
         ywsScJGAPIcESYSrJSotvUXtvDaXPr+DSjIRLqwWryMrhoJcSue5xgBhK5QF4JVrrrav
         LqTA==
X-Gm-Message-State: AOAM5323Up85w5GAsyDDfgEK6Fr+ZyKOByJ1zcOjupeRyG1Mn9lUX2ai
        SlzVZ7510SDwvri2bY3aY28=
X-Google-Smtp-Source: ABdhPJzjDkNeJ7oQwNTVr2E8XwOQIK9cknTawSzTrHLCYwivBWAiPt6/Y0U1hMfCkC+iWI79NXxBVA==
X-Received: by 2002:a17:906:d554:b0:6df:a6f8:799a with SMTP id cr20-20020a170906d55400b006dfa6f8799amr31020900ejc.492.1648516159433;
        Mon, 28 Mar 2022 18:09:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm6387886ejb.194.2022.03.28.18.09.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Mar 2022 18:09:19 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [Patch v2 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
Date:   Tue, 29 Mar 2022 01:09:01 +0000
Message-Id: <20220329010901.1654-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220329010901.1654-1-richard.weiyang@gmail.com>
References: <20220329010901.1654-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wakeup_kswapd() only wake up kswapd when the zone is managed.

For two callers of wakeup_kswapd(), they are node perspective.

  * wake_all_kswapds
  * numamigrate_isolate_page

If we picked up a !managed zone, this is not we expected.

This patch makes sure we pick up a managed zone for wakeup_kswapd(). And
it also use managed_zone in migrate_balanced_pgdat() to get the proper
zone.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

---
v2: adjust the usage in migrate_balanced_pgdat()

---
 mm/migrate.c    | 6 +++---
 mm/page_alloc.c | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3d60823afd2d..5adc55b5347c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1971,7 +1971,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Returns true if this is a safe migration target node for misplaced NUMA
- * pages. Currently it only checks the watermarks which crude
+ * pages. Currently it only checks the watermarks which is crude.
  */
 static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 				   unsigned long nr_migrate_pages)
@@ -1981,7 +1981,7 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
 		struct zone *zone = pgdat->node_zones + z;
 
-		if (!populated_zone(zone))
+		if (!managed_zone(zone))
 			continue;
 
 		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
@@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
 			return 0;
 		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
-			if (populated_zone(pgdat->node_zones + z))
+			if (managed_zone(pgdat->node_zones + z))
 				break;
 		}
 		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4c0c4ef94ba0..6656c2d06e01 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4674,6 +4674,8 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
 					ac->nodemask) {
+		if (!managed_zone(zone))
+			continue;
 		if (last_pgdat != zone->zone_pgdat)
 			wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
 		last_pgdat = zone->zone_pgdat;
-- 
2.33.1

