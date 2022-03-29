Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784424EA4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiC2ByQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiC2ByO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:54:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C2921DF2B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:52:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so32164448ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KpVGdHj74P7XQGPM3pM2LQ+cRYtvOqSnEZu9etZOojQ=;
        b=kkMSMgZZ0DGOn6pWx/qsBRGaKk0JuB18O5WbomMN63ewhbBYa7bekXdclyT9Z+sMrb
         2Aw0QR7GdSKNdp2xX4r8GE2++IZQVC/0lP5PLLIfZdO+in8D0ixE71Kd8hrN6JdbAbXK
         x7/rk+aKE6zR8ojQWAx3EAl2x7gbiCNbg/aAINlryNfMFnJpdd/1eO05Y8TIWeMuTRPN
         6OmqHblS0aksfDiBgjhaj8kVH9E1cU3CoAhACyNmG031S00tSVFJsPVJRyuRj335l/gb
         gSqECW1SEOJ4+Yz+mf/uoC9lDRAfN6EuIPe0LoL90X5QjIhlOwoKCHSL79OfSf8gxLIa
         nOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KpVGdHj74P7XQGPM3pM2LQ+cRYtvOqSnEZu9etZOojQ=;
        b=aBuFE5jlwWsoQwD9ylP48SdJi9GKaPNLonf16CYnWVNyWw9i00aqb7Ywu+GERC8UaM
         KtmA+DbABE5qUVUsoW6qwnRBtCXqYutHOYHY/dcKDYW5fYXK7MIFPopfWOB7eGGjJuBd
         jxngeb18Qg5V/Ahtv/gLChdxlfyerYZEkjDpWegNjdtQf1flUTamI9InZA+nre7B3iyc
         bj+oCbhYjfwN55H22Z0ysLGizrZogvXXDRdGV4F0oBdVrFKARHGkXadj1RtJhMzGXUJX
         xRE6YBX0m9FhJsiyfISPZfJS5VrFh2XF3MEZLY7N6X3aZ+Qn/r+Mf/Tw+rLKZTjMeE/S
         SWUw==
X-Gm-Message-State: AOAM533gCWguk0nQBpVzSHhNzI6EQwhV/Bxu1lbWZtfR3k22VYadnYE9
        5BaVWw2Nz70fWv4y7BFNYR8=
X-Google-Smtp-Source: ABdhPJxpVMPBi30qgsX3RURVT5sDN9/nanGT1Gb25mA1wLuAcuQvZm3Gr8YuWpRSwKHdGvOBss8Bzw==
X-Received: by 2002:a17:906:19c6:b0:6ce:98a4:5ee6 with SMTP id h6-20020a17090619c600b006ce98a45ee6mr31254880ejd.567.1648518750878;
        Mon, 28 Mar 2022 18:52:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id mp33-20020a1709071b2100b006db6dea7f9dsm6598058ejc.168.2022.03.28.18.52.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Mar 2022 18:52:30 -0700 (PDT)
Date:   Tue, 29 Mar 2022 01:52:30 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
Message-ID: <20220329015230.hneciyfxoxtvfytl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
 <20220327024101.10378-2-richard.weiyang@gmail.com>
 <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20220329004146.2xdswvrm2qu7f47x@master>
 <875ynxh9lg.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ynxh9lg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 08:43:23AM +0800, Huang, Ying wrote:
[...]
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>>>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>>>>  			return 0;
>>>>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>>>> -			if (populated_zone(pgdat->node_zones + z))
>>>> +			if (managed_zone(pgdat->node_zones + z))
>>>
>>>This looks good to me!  Thanks!  It seems that we can replace
>>>populated_zone() in migrate_balanced_pgdat() too.  Right?
>>>
>>
>> Yes, you are right. I didn't spot this.
>>
>> While this patch comes from the clue of wakeup_kswapd(), I am not sure it is
>> nice to put it in this patch together.
>>
>> Which way you prefer to include this: merge the change into this one, or a
>> separate one?
>
>Either is OK for me.
>

After reading the code, I am willing to do a little simplification. Does this
look good to you?

From 85c8a5cd708ada3e9f5b0409413407b7be1bc446 Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang@gmail.com>
Date: Tue, 29 Mar 2022 09:24:36 +0800
Subject: [PATCH] mm/migrate.c: return valid zone for wakeup_kswapd from
 migrate_balanced_pgdat()

To wakeup kswapd, we need to iterate pgdat->node_zones and get the
proper zone. While this work has already been done in
migrate_balanced_pgdat().

Let's return the valid zone directly instead of do the iteration again.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/migrate.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5adc55b5347c..b086bd781956 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1973,7 +1973,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
  * Returns true if this is a safe migration target node for misplaced NUMA
  * pages. Currently it only checks the watermarks which is crude.
  */
-static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+static struct zone *migrate_balanced_pgdat(struct pglist_data *pgdat,
 				   unsigned long nr_migrate_pages)
 {
 	int z;
@@ -1985,14 +1985,13 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 			continue;
 
 		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
-		if (!zone_watermark_ok(zone, 0,
+		if (zone_watermark_ok(zone, 0,
 				       high_wmark_pages(zone) +
 				       nr_migrate_pages,
 				       ZONE_MOVABLE, 0))
-			continue;
-		return true;
+			return zone;
 	}
-	return false;
+	return NULL;
 }
 
 static struct page *alloc_misplaced_dst_page(struct page *page,
@@ -2032,6 +2031,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	int page_lru;
 	int nr_pages = thp_nr_pages(page);
 	int order = compound_order(page);
+	struct zone *zone;
 
 	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
 
@@ -2040,16 +2040,11 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 		return 0;
 
 	/* Avoid migrating to a node that is nearly full */
-	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
-		int z;
-
+	if ((zone = migrate_balanced_pgdat(pgdat, nr_pages))) {
 		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
 			return 0;
-		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
-			if (managed_zone(pgdat->node_zones + z))
-				break;
-		}
-		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
+
+		wakeup_kswapd(zone, 0, order, ZONE_MOVABLE);
 		return 0;
 	}
 
-- 
2.33.1


>Best Regards,
>Huang, Ying

-- 
Wei Yang
Help you, Help me
