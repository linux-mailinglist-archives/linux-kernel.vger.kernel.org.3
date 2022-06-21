Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5E5532BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351311AbiFUM7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351014AbiFUM6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:58:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B5BC3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:58:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l4so13021911pgh.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQmNu1Pi61kiVMPJr8aGyJU8VoXoYJEPNAmwcIY/MLE=;
        b=uRoZYgA2WDdO9ticBdRw4R7/aUXk5r9fqjKxKJCs1SkEG4UdxhjFsO/X/PheSrZDg+
         Q23F5hcZd9t0a7k63chGSWb3GHjtfCKitwmgpkZIMzFXmeCoTtJZt1WI45hmjAbSNvjU
         /5wRPFqGLSXBhc/RogtGwjV9RN90CBGRxKIoHDUJysh3Wr6Y4yJWuUtBVejjCQihuCj0
         CtlKQVvYF4ukD9CjCMcdRjlepscIFcl4DKR7BS4rzRSK7Mf6uRzcc1U6qlPUu8rUerNI
         JY12moVGemqnvgCfDy9ZpJmjCyPFcuQ5O6SQvqUei19rSVIpmLCFjVox8NrK4WND0BYX
         Cqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQmNu1Pi61kiVMPJr8aGyJU8VoXoYJEPNAmwcIY/MLE=;
        b=hXQXhRNPbXPGKxii4LYiSjD7h6371sa6KljonwGGoU5LSOFiFlDpW0SNoiITXEpyaF
         WgS/qoDWe5oMiAX+jRVeipszKAGvGUF8m/YCVEW6boWjjUiicy/5wYSwKOcWXLVgPjkL
         DFL8faUmtWZKutPlsnCxP72dPaisoQ4fW7tfPDPuIwpbsgnXyx+IcteWT70ZTGlrdnFD
         Kbev258jC3lSOkxyCsd48OA9P8oRCii1JpmNsXGLmO8j2ogcRx0XazV6k1NgXNmqOfRN
         oxQjQ9CTrSbwv/ewIRkhNoxTvPLaM5o8s+xRb23cWe5eaDGa5/SfDJteuiseE/kcKtP3
         KvzA==
X-Gm-Message-State: AJIora+7jqFtDLkXpKA5NHPi0GTRnOyKQaIAEsmD+vpbwDyJb1dBn8ai
        tEoyZ8juHxug+7AtZ3gergMwfg==
X-Google-Smtp-Source: AGRyM1upaoIcJWVsnc39MXQBtGK/kVVeFupBrAq4ZDu6K/3ZNA+9pZV71aSGLs8BkJ4IPnyCNTw3hA==
X-Received: by 2002:a63:2b16:0:b0:3fa:faf9:e6d7 with SMTP id r22-20020a632b16000000b003fafaf9e6d7mr25873846pgr.325.1655816286866;
        Tue, 21 Jun 2022 05:58:06 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:58:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 05/11] mm: vmscan: rework move_pages_to_lru()
Date:   Tue, 21 Jun 2022 20:56:52 +0800
Message-Id: <20220621125658.64935-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/vmscan.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6a554712ef5d..697656151431 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2312,23 +2312,26 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
  * move_pages_to_lru() moves folios from private @list to appropriate LRU list.
  * On return, @list is reused as a list of folios to be freed by the caller.
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
 	int nr_pages, nr_moved = 0;
+	struct lruvec *lruvec = NULL;
 	LIST_HEAD(folios_to_free);
 
 	while (!list_empty(list)) {
 		struct folio *folio = lru_to_folio(list);
 
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
 		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 		list_del(&folio->lru);
 		if (unlikely(!folio_evictable(folio))) {
-			spin_unlock_irq(&lruvec->lru_lock);
+			lruvec_unlock_irq(lruvec);
 			folio_putback_lru(folio);
-			spin_lock_irq(&lruvec->lru_lock);
+			lruvec = NULL;
 			continue;
 		}
 
@@ -2349,19 +2352,15 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			__folio_clear_lru_flags(folio);
 
 			if (unlikely(folio_test_large(folio))) {
-				spin_unlock_irq(&lruvec->lru_lock);
+				lruvec_unlock_irq(lruvec);
 				destroy_large_folio(folio);
-				spin_lock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
 			} else
 				list_add(&folio->lru, &folios_to_free);
 
 			continue;
 		}
 
-		/*
-		 * All pages were isolated from the same lruvec (and isolation
-		 * inhibits memcg migration).
-		 */
 		VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
 		lruvec_add_folio(lruvec, folio);
 		nr_pages = folio_nr_pages(folio);
@@ -2370,6 +2369,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
 
+	if (lruvec)
+		lruvec_unlock_irq(lruvec);
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
@@ -2440,16 +2441,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
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
@@ -2578,18 +2579,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move folios back to the lru list.
 	 */
-	spin_lock_irq(&lruvec->lru_lock);
-
-	nr_activate = move_pages_to_lru(lruvec, &l_active);
-	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
+	nr_activate = move_pages_to_lru(&l_active);
+	nr_deactivate = move_pages_to_lru(&l_inactive);
 	/* Keep all free folios in l_active list */
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

