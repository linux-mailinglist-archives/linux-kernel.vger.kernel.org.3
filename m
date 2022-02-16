Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE97A4B8721
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiBPLwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:52:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiBPLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:52:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2711354B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x4so1827408plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujWC+Nynecy5cfWWuSueMGD3VsaPW7mqWiNPggI7fVw=;
        b=74WzMLOa4toy3L4dexYCXQatB+XtVs+E3mXl7uS+8FaRUzns/vyDpmzJoaQsaUKJy+
         bbZj/kY5wGeJ40wLrJNe2xcIoN3w8I5jLYMy9FENkECJfhIOXO6pQtTbLEr6bRmgmqkj
         c433CectYmMUSiF3J8HxNa2tVfwZkwnMe/T6m2KIgbHGhFCocaNJM8mKh744PwVOEix6
         M8trrFpluBPKIHgApO7NqUSo4llwtmtVDkiTu3J53Sk/bghugJ83HiVeHRj1dZh1SDDD
         q+34rPaN9qMJACOpVGa+HEGuQmdKv+IHsfj2j/2hpqPKOLfdXtR2Kt7ZsnxGHHRlPdYU
         QXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujWC+Nynecy5cfWWuSueMGD3VsaPW7mqWiNPggI7fVw=;
        b=eWrQIzUWk43ydlXM/HFnaMzAF885q0tEd+4ZPumpZ42J1IpOFQjL43fHoaqlWDdkkC
         DwvdsorgtQvUsDVhSnyRC2YtEqKpwQgojTjVQcARfbjlGk8eENz8p3uezCuY/H6orgo7
         l+f/f+phSz+hT/kou1sBY9B9kIM9Z7ZGiUiPappRQmQEYlJKEwjg2afCNaeMGWy5ImDW
         D3UtdBZNCucu/A3l4B0wOhcnJnL/IK5bxSYajFn9Xpp7C8G0w93Pyl20iGO15FAxhZpV
         zGCIdp278Mch7bZwfBhI42Y+DD23cQkeKQ+l7jW+nmD9bkZhkD+wLAnhJQYcNz6qEtGI
         cbvA==
X-Gm-Message-State: AOAM5319SYufitCy30H+l15FI4UMfDoA771V+Wg9eabW+3p7fKi+Hwry
        O/N48zHfccX6fO6yMVS1Ol+MpA==
X-Google-Smtp-Source: ABdhPJxhYTlLU1UeJbjW60IdORbed8UmBz2oMySzvbgHil4ENU/8HVAVPkPfpn3fHaSNwy6IuBdqVQ==
X-Received: by 2002:a17:903:408d:b0:14d:a09a:fdcf with SMTP id z13-20020a170903408d00b0014da09afdcfmr2144300plc.119.1645012345221;
        Wed, 16 Feb 2022 03:52:25 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:52:24 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 04/12] mm: vmscan: rework move_pages_to_lru()
Date:   Wed, 16 Feb 2022 19:51:24 +0800
Message-Id: <20220216115132.52602-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220216115132.52602-1-songmuchun@bytedance.com>
References: <20220216115132.52602-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the later patch, we will reparent the LRU pages. The pages moved to
appropriate LRU list can be reparented during the process of the
move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
should use the more general interface of folio_lruvec_relock_irq() to
acquire the correct lruvec lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h |  1 +
 mm/vmscan.c        | 49 +++++++++++++++++++++++++------------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..fc270e52a9a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -227,6 +227,7 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+#define lru_to_folio(head) (list_entry((head)->prev, struct folio, lru))
 
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 59b14e0d696c..7beed9041e0a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2305,23 +2305,28 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
  * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
  * On return, @list is reused as a list of pages to be freed by the caller.
  *
- * Returns the number of pages moved to the given lruvec.
+ * Returns the number of pages moved to the appropriate LRU list.
+ *
+ * Note: The caller must not hold any lruvec lock.
  */
-static unsigned int move_pages_to_lru(struct lruvec *lruvec,
-				      struct list_head *list)
+static unsigned int move_pages_to_lru(struct list_head *list)
 {
-	int nr_pages, nr_moved = 0;
+	int nr_moved = 0;
+	struct lruvec *lruvec = NULL;
 	LIST_HEAD(pages_to_free);
-	struct page *page;
 
 	while (!list_empty(list)) {
-		page = lru_to_page(list);
+		int nr_pages;
+		struct folio *folio = lru_to_folio(list);
+		struct page *page = &folio->page;
+
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			spin_unlock_irq(&lruvec->lru_lock);
+			unlock_page_lruvec_irq(lruvec);
 			putback_lru_page(page);
-			spin_lock_irq(&lruvec->lru_lock);
+			lruvec = NULL;
 			continue;
 		}
 
@@ -2342,20 +2347,16 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			__clear_page_lru_flags(page);
 
 			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&lruvec->lru_lock);
+				unlock_page_lruvec_irq(lruvec);
 				destroy_compound_page(page);
-				spin_lock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
 			} else
 				list_add(&page->lru, &pages_to_free);
 
 			continue;
 		}
 
-		/*
-		 * All pages were isolated from the same lruvec (and isolation
-		 * inhibits memcg migration).
-		 */
-		VM_BUG_ON_PAGE(!folio_matches_lruvec(page_folio(page), lruvec), page);
+		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
@@ -2363,6 +2364,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
 
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
@@ -2436,16 +2439,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, &stat, false);
 
-	spin_lock_irq(&lruvec->lru_lock);
-	move_pages_to_lru(lruvec, &page_list);
+	move_pages_to_lru(&page_list);
 
+	local_irq_disable();
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
-	spin_unlock_irq(&lruvec->lru_lock);
+	local_irq_enable();
 
 	lru_note_cost(lruvec, file, stat.nr_pageout);
 	mem_cgroup_uncharge_list(&page_list);
@@ -2572,18 +2575,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move pages back to the lru list.
 	 */
-	spin_lock_irq(&lruvec->lru_lock);
-
-	nr_activate = move_pages_to_lru(lruvec, &l_active);
-	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
+	nr_activate = move_pages_to_lru(&l_active);
+	nr_deactivate = move_pages_to_lru(&l_inactive);
 	/* Keep all free pages in l_active list */
 	list_splice(&l_inactive, &l_active);
 
+	local_irq_disable();
 	__count_vm_events(PGDEACTIVATE, nr_deactivate);
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
-
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&lruvec->lru_lock);
+	local_irq_enable();
 
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
-- 
2.11.0

