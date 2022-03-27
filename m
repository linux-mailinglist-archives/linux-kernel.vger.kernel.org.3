Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D84E8509
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 04:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiC0CnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 22:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiC0CnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 22:43:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8CE60ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 19:41:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pv16so22346564ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 19:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K3hLkpz9UBfsQM5/ihZSTbzc6DyuMMrFt7IBwlsxIaQ=;
        b=l/9VF2WnGPk2fqAXyOzFFMON51TfN9Ii8cqphdun+m3/apB1ILZLD4YyoVTfA4Qu1y
         n4IU7t+eAhKTUuLdW0tO82BjHcve71O+ULNWWdyjXrU5rfpJ8vbPzRzXX2GOFuBiAUNk
         a6nL+9jlbcrAXEOQzzSRCJur2fM9LPVMmySRzstCpXWqPe0LhCsIG+PlYE6mA2bwkAjL
         lbyWrEOZexk4SCXBHyQvRUUwuMSunSWnT6fbuy9Ac+PomRsq9mIkj1mlhE9m2EGeEkEf
         /qrKYKhsVhL6FErLQ9YWVytl7FpuwUqLSfCuz+8qZKQBFR+Tg88RKTwvu/p6ZNZflsVK
         G3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K3hLkpz9UBfsQM5/ihZSTbzc6DyuMMrFt7IBwlsxIaQ=;
        b=pOB3ylvlH7r2lYnYPuWk5RrzYqQeWv8mVZ6FrxAMTxBC3lybXVO0lc9XiaqhnoVQ67
         M6JmUzXRgHTi7MrUw3Er0r54nzx5hUAoXZz001o9yuSWyChk9TtNkpUZeY6/ucta3NdH
         5WTfqsBiMcAWlm4X08gUeF0A79mqLCTTqm00WgCRx/3KJejkm+LzOT8VUe23Syl71waC
         D4QzsNr5O+VNmeQdbFdGyT1/BuoOrpTHRzWuy/PPuKzm5AH58UfqNPc9gfvR1PhLZxo3
         orUDIk2yrqIbiBnT3XFv542u08WcU1tCwZq8rKHOCE4p4TzzQhjF6XySkuBmpEvO3pW6
         smMA==
X-Gm-Message-State: AOAM531qrDyNF36ppK8UixdJKgiZBPoruPo9WqdwYfEdqsh/sVvoXqST
        6Iy1Z6vMCenM9D3vFvIow2w=
X-Google-Smtp-Source: ABdhPJx+fb1QIhq3fxPuRrBmS1BZKFF09QsAxuxVkvXEYintX0IP/uzyplJG/MzAnP+6c8677PAsuA==
X-Received: by 2002:a17:906:36ce:b0:6d6:e540:ed65 with SMTP id b14-20020a17090636ce00b006d6e540ed65mr19880051ejc.330.1648348889343;
        Sat, 26 Mar 2022 19:41:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id sb15-20020a1709076d8f00b006dfe4cda58fsm4128613ejc.95.2022.03.26.19.41.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Mar 2022 19:41:29 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
Date:   Sun, 27 Mar 2022 02:41:01 +0000
Message-Id: <20220327024101.10378-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220327024101.10378-1-richard.weiyang@gmail.com>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
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

This patch makes sure we pick up a managed zone for wakeup_kswapd().

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/migrate.c    | 2 +-
 mm/page_alloc.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3d60823afd2d..c4b654c0bdf0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
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

