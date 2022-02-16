Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D924B8729
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiBPLxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:53:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiBPLxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:53:46 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B525AE4A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:53:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c4so1934511pfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhAhPTyHic8HLjvCRzBQUUQ636+wM982+LUClAOhopw=;
        b=QWgWNzNgU80Sy/fbB7VoAvCmqaopjdIFI6iIHndkTXLJBnwcSbs8MuvIH83u4KyBqG
         NdBVYhBwBrHa9O+Igeno+9U1+YHhWl3jA+dJOVghrOc8OtAZQ3BxeGPTb0982tkMEzYM
         /uDrfbdFHtvkE08wtABKnM4GAs+E7+5F9OoTWDM+uye1q5m9i8SbCIHwDv0SF8Cw85EX
         E71kczc50BRf4IloliZTprHsbw5/95HF79kmGq4fhXDiwp7FEhkeTubqyZYyrT/bNp1+
         gq31CR/tXXc2vXc+A1HIWxsSKP3C2ZoT5heKUWCUlinPdvzn+ewziskziGMeoGRjuOD3
         BrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhAhPTyHic8HLjvCRzBQUUQ636+wM982+LUClAOhopw=;
        b=UhmMbnaO/sEPrrUq6eVU5pYAV3NxCXcQphVD8SR0S7PPp5JdsKYTEk0/OsjHUNj0VQ
         c2OLnOm2IfcJLmK54mJe/AKyUU0RWjvwzDWOaN5GpYEhc8q/8In4AJceNfYoK6zYSxVY
         tj/41oHfYX44NvPvPWclsj+cu0sc75IpLDPaLwYl+A1cUzvk5qMZNCVKuV89oNpf4McB
         o3KWia+gMCSz9KMagnNyssDW1m0+Hv5otlxPoDlmPaIbAxeqEokPb4gZ+aDaIghd5dLA
         fNLXfn/SErGCVnwgKfpMvPo3hEuETBxoF27luQOYRqQFdg6v+u63RegZj1f2ZhOKtfGY
         MTeA==
X-Gm-Message-State: AOAM5317WeUb1Ie8rqG9alfetdBTuaKVjSFSVFDX5IySR8cJ3MkC26gd
        NqAcfvnifn8Us9jHBUoSXQgqfg==
X-Google-Smtp-Source: ABdhPJw8BvSTOCR/CJ4JcuC5BevEZsDegvyDY1WKNxP/0W6FJiLrqwf0q/jlBCGAXZc7jFj1Ae+pgw==
X-Received: by 2002:a05:6a00:244f:b0:4cc:a2ba:4cd8 with SMTP id d15-20020a056a00244f00b004cca2ba4cd8mr2929216pfj.74.1645012394275;
        Wed, 16 Feb 2022 03:53:14 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:53:14 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 12/12] mm: lru: use lruvec lock to serialize memcg changes
Date:   Wed, 16 Feb 2022 19:51:32 +0800
Message-Id: <20220216115132.52602-13-songmuchun@bytedance.com>
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

As described by commit fc574c23558c ("mm/swap.c: serialize memcg
changes in pagevec_lru_move_fn"), TestClearPageLRU() aims to
serialize mem_cgroup_move_account() during pagevec_lru_move_fn().
Now folio_lruvec_lock*() has the ability to detect whether page
memcg has been changed. So we can use lruvec lock to serialize
mem_cgroup_move_account() during pagevec_lru_move_fn(). This
change is a partial revert of the commit fc574c23558c ("mm/swap.c:
serialize memcg changes in pagevec_lru_move_fn").

And pagevec_lru_move_fn() is more hot compare with
mem_cgroup_move_account(), removing an atomic operation would be
an optimization. Also this change would not dirty cacheline for a
page which isn't on the LRU.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 32 +++++++++++++++++++++++++++++++-
 mm/swap.c       | 45 ++++++++++++++-------------------------------
 mm/vmscan.c     |  9 ++++-----
 3 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9531bdb6ede3..0a28f87b68c0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1316,13 +1316,38 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
 	lruvec = folio_lruvec(folio);
 
 	spin_lock(&lruvec->lru_lock);
-
+	/*
+	 * The memcg of the page can be changed by any the following routines:
+	 *
+	 * 1) mem_cgroup_move_account() or
+	 * 2) memcg_reparent_objcgs()
+	 *
+	 * The possible bad scenario would like:
+	 *
+	 * CPU0:                CPU1:                CPU2:
+	 * lruvec = folio_lruvec()
+	 *
+	 *                      if (!isolate_lru_page())
+	 *                              mem_cgroup_move_account()
+	 *
+	 *                                           memcg_reparent_objcgs()
+	 *
+	 * spin_lock(&lruvec->lru_lock)
+	 *                ^^^^^^
+	 *              wrong lock
+	 *
+	 * Either CPU1 or CPU2 can change page memcg, so we need to check
+	 * whether page memcg is changed, if so, we should reacquire the
+	 * new lruvec lock.
+	 */
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock(&lruvec->lru_lock);
 		goto retry;
 	}
 
 	/*
+	 * When we reach here, it means that the folio_memcg(folio) is stable.
+	 *
 	 * Preemption is disabled in the internal of spin_lock, which can serve
 	 * as RCU read-side critical sections.
 	 */
@@ -1353,6 +1378,7 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 	lruvec = folio_lruvec(folio);
 	spin_lock_irq(&lruvec->lru_lock);
 
+	/* See the comments in folio_lruvec_lock(). */
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto retry;
@@ -1388,6 +1414,7 @@ struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 	lruvec = folio_lruvec(folio);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	/* See the comments in folio_lruvec_lock(). */
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
@@ -5834,7 +5861,10 @@ static int mem_cgroup_move_account(struct page *page,
 	obj_cgroup_put(rcu_dereference(from->objcg));
 	rcu_read_unlock();
 
+	/* See the comments in folio_lruvec_lock(). */
+	spin_lock(&from_vec->lru_lock);
 	folio->memcg_data = (unsigned long)rcu_access_pointer(to->objcg);
+	spin_unlock(&from_vec->lru_lock);
 
 	__folio_memcg_unlock(from);
 
diff --git a/mm/swap.c b/mm/swap.c
index 9c2bcc2651c6..b9022fbbb70f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -201,14 +201,8 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 		struct page *page = pvec->pages[i];
 		struct folio *folio = page_folio(page);
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
-			continue;
-
 		lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
 		(*move_fn)(page, lruvec);
-
-		SetPageLRU(page);
 	}
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
@@ -220,7 +214,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
 	struct folio *folio = page_folio(page);
 
-	if (!folio_test_unevictable(folio)) {
+	if (folio_test_lru(folio) && !folio_test_unevictable(folio)) {
 		lruvec_del_folio(lruvec, folio);
 		folio_clear_active(folio);
 		lruvec_add_folio_tail(lruvec, folio);
@@ -315,7 +309,8 @@ void lru_note_cost_folio(struct folio *folio)
 
 static void __folio_activate(struct folio *folio, struct lruvec *lruvec)
 {
-	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
+	if (folio_test_lru(folio) && !folio_test_active(folio) &&
+	    !folio_test_unevictable(folio)) {
 		long nr_pages = folio_nr_pages(folio);
 
 		lruvec_del_folio(lruvec, folio);
@@ -372,12 +367,9 @@ static void folio_activate(struct folio *folio)
 {
 	struct lruvec *lruvec;
 
-	if (folio_test_clear_lru(folio)) {
-		lruvec = folio_lruvec_lock_irq(folio);
-		__folio_activate(folio, lruvec);
-		unlock_page_lruvec_irq(lruvec);
-		folio_set_lru(folio);
-	}
+	lruvec = folio_lruvec_lock_irq(folio);
+	__folio_activate(folio, lruvec);
+	unlock_page_lruvec_irq(lruvec);
 }
 #endif
 
@@ -530,6 +522,9 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	bool active = PageActive(page);
 	int nr_pages = thp_nr_pages(page);
 
+	if (!PageLRU(page))
+		return;
+
 	if (PageUnevictable(page))
 		return;
 
@@ -567,7 +562,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageActive(page) && !PageUnevictable(page)) {
+	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec);
@@ -583,7 +578,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageAnon(page) && PageSwapBacked(page) &&
+	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
@@ -1006,8 +1001,9 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
-static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
+static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 {
+	struct folio *folio = page_folio(page);
 	int was_unevictable = folio_test_clear_unevictable(folio);
 	long nr_pages = folio_nr_pages(folio);
 
@@ -1064,20 +1060,7 @@ static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	int i;
-	struct lruvec *lruvec = NULL;
-	unsigned long flags = 0;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct folio *folio = page_folio(pvec->pages[i]);
-
-		lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
-		__pagevec_lru_add_fn(folio, lruvec);
-	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
-	release_pages(pvec->pages, pvec->nr);
-	pagevec_reinit(pvec);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 00207553c419..23d6f91b483a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4868,18 +4868,17 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		nr_pages = thp_nr_pages(page);
 		pgscanned += nr_pages;
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
+
+		if (!PageLRU(page) || !PageUnevictable(page))
 			continue;
 
-		lruvec = folio_lruvec_relock_irq(folio, lruvec);
-		if (page_evictable(page) && PageUnevictable(page)) {
+		if (page_evictable(page)) {
 			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
 			add_page_to_lru_list(page, lruvec);
 			pgrescued += nr_pages;
 		}
-		SetPageLRU(page);
 	}
 
 	if (lruvec) {
-- 
2.11.0

