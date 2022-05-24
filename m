Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B82532F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiEXRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiEXRPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:15:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED49548B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:15:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m1so16401948plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=endC3alHoLTLA4FLHknWYkaNdhLZeB6EPQBxO4tTvuo=;
        b=S608X6dhf0y0oSktG79rcCKE8rOlDWTvXumHu2IIwKMTwsBSp92xkTchz4e7aOKhQP
         A5MW6fz4l8he66Jc1K27G3POf6hL2eC3WR59rR3ozUz4McJjmFdvGRdYoSLTPjqYP5YH
         8nsBgm2Buy6kDZICMPvdfrWPkz7TmPmvJLnxuhi6HE+8SAjUuOK9nGQ2tLmkryn3RjrQ
         mGjnEsjHVOb5xfPF3W5H9O6XyHNMixbP24PsMTnSNOOZ1Vnl93KxOgZv0eK4wDPEVkAl
         eTAd2+qDc/aFxp8EO4oiBupM+EUmkoY/uEP3zOiK6y681NzSOzdgDdKbPNTnDJxMBS8w
         17ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=endC3alHoLTLA4FLHknWYkaNdhLZeB6EPQBxO4tTvuo=;
        b=W/eZPt4Df4xEFbvVRsbGIc1PrcsEhY0qDrsnpEGKD12H4OtSeRG3PGqdy/yk6QlMGS
         nWu+PR1zpv75T+egAopquEhuBkh5/H75EhAz6DQP9cDdZGlcpDG3/Lpwq3RN5jZmXvVb
         /G81ANZZlqSO09pCGAJHrc1ISPQL6fKwQvYrtrfAjBQ6AtrFkp/UWB2uCBTEXYh3nKBt
         bYzPSS1bU2cjJyVRNFgGql1SnapTjtPWW0oHe1iI7osYoxqQX4W+EdLeM3PoeS3HxHC9
         5VE3X0hNad8i1+cvz1ZNktZOAP2z5E9cC2eLsPqPzw28abIlDzOTwj6qiDW/6s69rCpU
         8Gnw==
X-Gm-Message-State: AOAM533o+oHNFWkIPMQuAmWhFr8B7Wgwu5f+MOmW9YqUXv0PLxLOgb3i
        Cy4T2h2O85MgEfLeq/i5qxQ=
X-Google-Smtp-Source: ABdhPJwezDHG6N0erN8CFswLbGqvA7eJ4ffAywhkLT28bPKZbNXiAvrlTQ5Drlv4B4rySD78fbGCsw==
X-Received: by 2002:a17:903:228e:b0:161:8632:2725 with SMTP id b14-20020a170903228e00b0016186322725mr28533371plh.126.1653412529090;
        Tue, 24 May 2022 10:15:29 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:20f:8bc7:9098:371f])
        by smtp.gmail.com with ESMTPSA id i13-20020aa796ed000000b005107a4d5096sm7139875pfq.30.2022.05.24.10.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 10:15:28 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v6] mm: fix is_pinnable_page against a cma page
Date:   Tue, 24 May 2022 10:15:25 -0700
Message-Id: <20220524171525.976723-1-minchan@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
so current is_pinnable_page could miss CMA pages which has MIGRATE_
ISOLATE. It ends up pinning CMA pages as longterm at pin_user_pages
APIs so CMA allocation keep failed until the pin is released.

     CPU 0                                   CPU 1 - Task B

cma_alloc
alloc_contig_range
                                        pin_user_pages_fast(FOLL_LONGTERM)
change pageblock as MIGRATE_ISOLATE
                                        internal_get_user_pages_fast
                                        lockless_pages_from_mm
                                        gup_pte_range
                                        try_grab_folio
                                        is_pinnable_page
                                          return true;
                                        So, pinned the page successfully.
page migration failure with pinned page
                                        ..
                                        .. After 30 sec
                                        unpin_user_page(page)

CMA allocation succeeded after 30 sec.

The CMA allocation path protects the migration type change race
using zone->lock but what GUP path need to know is just whether the
page is on CMA area or not rather than exact migration type.
Thus, we don't need zone->lock but just checks migration type in
either of (MIGRATE_ISOLATE and MIGRATE_CMA).

Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
rejecting of pinning pages on MIGRATE_ISOLATE pageblocks even
though it's neither CMA nor movable zone if the page is temporarily
unmovable. However, such a migration failure by unexpected temporal
refcount holding is general issue, not only come from MIGRATE_ISOLATE
and the MIGRATE_ISOLATE is also transient state like other temporal
elevated refcount problem.

Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v5 - https://lore.kernel.org/all/20220512204143.3961150-1-minchan@kernel.org/
  * Use READ_ONCE in __get_pfnblock_flags_mask - Jason
  * adding a comment about READ_ONCE - John

* from v4 - https://lore.kernel.org/all/20220510211743.95831-1-minchan@kernel.org/
  * clarification why we need READ_ONCE - Paul
  * Adding a comment about READ_ONCE - John

* from v3 - https://lore.kernel.org/all/20220509153430.4125710-1-minchan@kernel.org/
  * Fix typo and adding more description - akpm

* from v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/
  * Use __READ_ONCE instead of volatile - akpm

* from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
  * fix build warning - lkp
  * fix refetching issue of migration type
  * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david

 include/linux/mm.h | 9 +++++++--
 mm/page_alloc.c    | 8 ++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6acca5cecbc5..ba13411b6dca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,13 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
-		is_zero_pfn(page_to_pfn(page));
+#ifdef CONFIG_CMA
+	int mt = get_pageblock_migratetype(page);
+
+	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
+		return false;
+#endif
+	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a2053621e27..348071e5d8d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -482,8 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
 	bitidx = pfn_to_bitidx(page, pfn);
 	word_bitidx = bitidx / BITS_PER_LONG;
 	bitidx &= (BITS_PER_LONG-1);
-
-	word = bitmap[word_bitidx];
+	/*
+	 * This races, without locks, with set_pfnblock_flags_mask(). Ensure
+	 * a consistent read of the memory array, so that results, even though
+	 * racy, are not corrupted.
+	 */
+	word = READ_ONCE(bitmap[word_bitidx]);
 	return (word >> bitidx) & mask;
 }
 
-- 
2.36.1.124.g0e6072fb45-goog

