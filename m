Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABDD522636
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiEJVRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiEJVRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:17:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34850B32
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:17:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 204so247723pfx.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3iS8vaaqUD8jfRE0NHdoQBHIwBnV2ugHoNQ4Z+Efx8=;
        b=cocBJOXiSqOkGGCNk9vDNCQQromh/mWnuC+KMasoT9HGNJtSh3PKZH/eXlf1MGxv2F
         Is1s24zAzJD01Gp0dG8sxbzC7wMFtiuh42LCRFmPe5+0Ti2p7CU9Ux0izG8VSpZcCnWd
         cDB3vIOlJt1xhiDB+uVmPm6ElIEsY52Dr6/90nJw4pQ1eWOHdwOfT3p6GTeAO/x7u14w
         pp2P2w5PBZkcACDjHKzqwSP0qTlEoqLRQVEXEgXrBH5oAg/0YN+IWl+QyV4hioH683zx
         gwliS5xHmZ0wysoH5R9CipYm1N3AhJRRYkLhKo24V4SGi7OlTjnCKQ2BToBM0uJQ7V83
         g2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=M3iS8vaaqUD8jfRE0NHdoQBHIwBnV2ugHoNQ4Z+Efx8=;
        b=zLQASLzyEtg1XQchQHaakQ9+NVUCUJPJY0UtTG1NUne+XHP4FJYhP60rE5ZcQy2oBT
         Z263ZJb05Fd57Y1tVwB2+Ak3jZj47AwxHkk4jEgpqkSBSaQR6ZEowtxkcw1ksrf+T9P6
         3ANUVt/Yk6kDlZHk7387c2OCvvseOOLhHtx0atZZ/RNCFix5KKkMxPfIurLCAfPe7yNE
         GUQ49bIOn73dTl9tDvA2Eane6ZMMhkmp+vtiFJqnTV5he0BR0qzA6hsL4YU9ixu2Au7N
         AH73pLS6JsdIMLq0HiZiqIQ2otHWZartyrGxMMJxfRHexh3sy0VFmZp/kouoHIvdu9RA
         DafQ==
X-Gm-Message-State: AOAM53165w8+gBtfw2P372FM1IZqh2g58/zAFXlJK3idSbq/NJGR2l3Z
        mt6t+YqNutEA9qXBzrHKozAvKVC2lpU=
X-Google-Smtp-Source: ABdhPJx2Y9Xq+3njREh94u64LTI6mtZXpzrndPub0LLJisx1paZBupZB0tvPmrQAG6GfjBG0L8/Qvg==
X-Received: by 2002:a63:1202:0:b0:3da:ec25:b232 with SMTP id h2-20020a631202000000b003daec25b232mr3876532pgl.163.1652217467051;
        Tue, 10 May 2022 14:17:47 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:c98a:65b0:edca:b69a])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902bd8100b0015e8d4eb28esm67639pls.216.2022.05.10.14.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:17:46 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4] mm: fix is_pinnable_page against on cma page
Date:   Tue, 10 May 2022 14:17:43 -0700
Message-Id: <20220510211743.95831-1-minchan@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
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

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v3 - https://lore.kernel.org/all/20220509153430.4125710-1-minchan@kernel.org/
  * Fix typo and adding more description - akpm

* from v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/
  * Use __READ_ONCE instead of volatile - akpm

* from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
  * fix build warning - lkp
  * fix refetching issue of migration type
  * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david

 include/linux/mm.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6acca5cecbc5..cbf79eb790e0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,19 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
-		is_zero_pfn(page_to_pfn(page));
+#ifdef CONFIG_CMA
+	/*
+	 * use volatile to use local variable mt instead of
+	 * refetching mt value.
+	 */
+	int __mt = get_pageblock_migratetype(page);
+	int mt = __READ_ONCE(__mt);
+
+	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
+		return false;
+#endif
+
+	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
-- 
2.36.0.512.ge40c2bad7a-goog

