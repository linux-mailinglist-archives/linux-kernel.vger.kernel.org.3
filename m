Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4B94EA46F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiC2BLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiC2BLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:11:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F927B2D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:09:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b24so18919213edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=weU7q/SN2SltRbJQURNE4PC1QrQjfwh5B+KAtHbIdnc=;
        b=k6iWONx0uz3YChLyoZl9HRU7H3syEfFSjM5BSJbE/VqJ8rKfOp0dFo3X4DJd8CKDHx
         5zPYcIebYhftht2alU1mQV+pmSpyhwZHWJN6iYHHAjmKCkXMXpLOiQQXBiU/m0hHXWEm
         i5YKf5Qk/JcfcIqxh4VmRvf9SN+icp7poTb0JQjwgCNKk68HCC/m2eDvz0FgJ8G2L1PC
         6FQxg9W/Buf5DTlOGN8pWas/ThshtLegH8vW8sI/r3ba5BDLUFlNQHpEFSYtJVBoJtFx
         NjClO7UZuNCB6D8/hyLpc3c3qqsBHCftaDG4A5ynGzhXTCV3BVOGfvYGYaMNjuGIIBg9
         mq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=weU7q/SN2SltRbJQURNE4PC1QrQjfwh5B+KAtHbIdnc=;
        b=mvxLnBUQyNJ4nFjzCuVyLchJS1/m7QaoQQfQyhGsTRYvrEX+RpM5wCPJ7LEz1Ie3Gi
         olQGPsdWYMJgDIBBcZhsxuXoXQKun8OkB4++vk3rFRq6BOeHcaWvEu2l4vlsqbWdCvfL
         yjJf/dFEtDXh0JXm68vlt+W50EuBPDK77y9Nt0A5R/rv3Ak3KY7SXxx+9Mv4gncZXAIT
         yCvjMLt40fb5+nLNeIXeDiLIWPLUIl5OnEciYR4/o0WR7pLiMC/ab8PXlwBN/YoyKdUN
         XCmV4rlD+kZXdiCGhONyd6vST7WAvVhK2fQrpyJZFz53RQ0We3UWTFopHHqGwB0vkmr5
         qiRg==
X-Gm-Message-State: AOAM531aQaAry8v1E0VZ0Tde0dMM/rFcwa2nWXTEjYLFbSwMfbjbIjcZ
        JuXi4GXkzdRLa9rcxyOI1ds=
X-Google-Smtp-Source: ABdhPJx6aXVqw3VlS7+v6A16JzK1+0VJCPyzirZLftLATSn9NxtHnWWnAEvTYiG1BeI8jkEztYgyHA==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr991335edt.186.1648516158666;
        Mon, 28 Mar 2022 18:09:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm7896399edj.49.2022.03.28.18.09.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Mar 2022 18:09:18 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 1/2] mm/vmscan: reclaim only affects managed_zones
Date:   Tue, 29 Mar 2022 01:09:00 +0000
Message-Id: <20220329010901.1654-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in commit 6aa303defb74 ("mm, vmscan: only allocate and
reclaim from zones with pages managed by the buddy allocator") , reclaim
only affects managed_zones.

Let's adjust the code and comment accordingly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1f2d79e8c43c..4385b59ef599 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1040,7 +1040,7 @@ static bool skip_throttle_noprogress(pg_data_t *pgdat)
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 
-		if (!populated_zone(zone))
+		if (!managed_zone(zone))
 			continue;
 
 		reclaimable += zone_reclaimable_pages(zone);
@@ -3909,7 +3909,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 	}
 
 	/*
-	 * If a node has no populated zone within highest_zoneidx, it does not
+	 * If a node has no managed zone within highest_zoneidx, it does not
 	 * need balancing by definition. This can happen if a zone-restricted
 	 * allocation tries to wake a remote kswapd.
 	 */
-- 
2.33.1

