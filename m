Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580B452567C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358411AbiELUlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358007AbiELUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:41:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103E9579B2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:41:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i24so5854191pfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUZ1B/7xqCMbgStyA7Ho3ErPD4yvMkTwqgpBaMdYV0U=;
        b=itmq0KKZk0ljNSSnvPSn0aOhIoNlC18SbogAnFyZ5XL5esAH48sAtb9WYMZ7EbhpwN
         wNbS5ZZ9fwGNt8vEWxxcgzQqt3VTjbPH11NwxZ6Tq1XwLRkRJjeTLmkFkrBkBUop9Wnh
         JM0ksbxepebVzGOJdTrcvP6Vk/2t7NC6AFgd+Y3pqcZaLcFjaja6zrDQaiTThs2cDw0o
         O4GuUjtiL8BWmtJbUABVXggMDL/7+GKWVSiRDpWo8LmAnqDhk/KKZqMnrtKZjNurtlgp
         wOgKmSZsBy/N59qD4/pl4Mbo54uiZSW4o28FMyMZmzhkMJY8o9uS9Mze60pdDLRNysmZ
         vZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=uUZ1B/7xqCMbgStyA7Ho3ErPD4yvMkTwqgpBaMdYV0U=;
        b=cDjjAGY/SzJChPAcNuAHRZCruNivlLBTZv+ScMQcungvZua9k19qwMcSv2vo6CO54T
         LS3gsTq76lmMXU+pwC+15krqsvSYNizAWm7WO6aXzssWZt0hk+8IaLYA77beABU9Gzlf
         CbRM4IYTk5iy64sl1r7OEZa+ORHn+nf/Ck0TWHiRiBOkAbNheHrI+H6BrbermcyQucw8
         TkSxORAFGvUHBBrX92DyNxtCFT/68LUWvy5lbom3jo0Z0OFUliI8GGSfsalmfganFadn
         UsQa5riOs/IJeSDz1znpdvBDdm+zlZETNNBZpJ2KzsBTu5ygDQJ6J0xXQ8iiblfnGyYK
         Zvlg==
X-Gm-Message-State: AOAM530R/4jYD9z3744NfFRQFAOdiaDNTa5dDWLdeNqcZJnKIsHsqExU
        V/EtCP/5WVGzQjjyxlzONtI=
X-Google-Smtp-Source: ABdhPJwtffE+IeAsEVeyvuHb+1skKZb8DKpXEQTd9yX/lyO3WcfRJd+tAKuWY50b9z4pAqkHdTtNbg==
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id z2-20020a056a00240200b004e146ca68bdmr1431739pfh.70.1652388107535;
        Thu, 12 May 2022 13:41:47 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:872f:bbca:8e23:fae5])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903244600b00160d358a888sm90912pls.32.2022.05.12.13.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 13:41:46 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v5] mm: fix is_pinnable_page against on cma page
Date:   Thu, 12 May 2022 13:41:43 -0700
Message-Id: <20220512204143.3961150-1-minchan@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
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
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
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

 include/linux/mm.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6acca5cecbc5..2d7a5d87decd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,20 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
-		is_zero_pfn(page_to_pfn(page));
+#ifdef CONFIG_CMA
+	/*
+	 * Defend against future compiler LTO features, or code refactoring
+	 * that inlines the above function, by forcing a single read. Because,
+	 * this routine races with set_pageblock_migratetype(), and we want to
+	 * avoid reading zero, when actually one or the other flags was set.
+	 */
+	int mt = __READ_ONCE(__mt);
+
+	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
+		return false;
+#endif
+
+	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
-- 
2.36.0.550.gb090851708-goog

