Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F94B8720
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiBPLwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:52:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiBPLwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:52:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90D1354B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso3884249pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0eIeZlraOMhnIGvYQ1DKNms/6a6+xjMQP4VMdJ+FeVI=;
        b=Lk52PPLP++WXnr65wbY3KT7YkWgxPQVLSd+9GPVgEUM55MjwLA5hip7PQ1lVeWbZkH
         V72nfGAE/Wn/twE+80TN2RwLE5FgxayjeJJz6zjet2Tt3y2fr9ZN2gBVMHGairFM2iLO
         qQyUi8F1iLmInhD1o5AVj1CVlhANg4NC9YISvqJZJgXesR19d5EJ8MqN5T/xxSCxW5XS
         2IJxAK2IRC6JzIBmDT6DO+4hEVyNjXMLBAZ5pH6LfTMYuGwW4yCsuVlKJFjcO5voNMT9
         bgXshIMcY1jUBGpk4BN9pQAAdaWlx2mRSXr19SiOM+T25cksVXK+yORQ2QxBprL6Uhes
         s5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0eIeZlraOMhnIGvYQ1DKNms/6a6+xjMQP4VMdJ+FeVI=;
        b=ucvoKBK6vNwacygdm+1Zj/0w+FQviB2DN5JtV7w3xsAp69YcPMVI/k6ADUMkOuNmfk
         wvvL/orBKHd9HYYT5g8vUPNtlMR4qTKXRDQ0GeC0TPRlb24/CPI2ECFcsjQE4hYnIFcO
         DAdO3NqGiKQGKy64hMS6JBPsxFzM1GNX1QvhzYsnjcJD/T0vgdl7LMr7NHm6c25C97GI
         96eIjfMg38pqv1mZvBxQSkYhWGsGafV2l2Vtng7XZIL90jFazAQZrjkQZVsdPMi51oHx
         /xpwoGqmSailFYO2Q16DnhOt6OoK7o/czl8SmK/OLbJDJrh42PNNoF3gaAgoEUV7ea7e
         UROQ==
X-Gm-Message-State: AOAM530+tnWfolyt9j5ZjFyJ4uLvBM1JJfsgrl2sG18lOKOFfMB0ynGp
        a4GsoZAXBzqzMmQsK3eow+mJEA==
X-Google-Smtp-Source: ABdhPJzMjXjv4oYiNhaX8VcZnb3AyZNG/qYdAV5g4SBrctN8kM+cmk8GQgmCjKay+PMCJWzdU69Wcw==
X-Received: by 2002:a17:902:b692:b0:14c:935b:2b03 with SMTP id c18-20020a170902b69200b0014c935b2b03mr2164330pls.81.1645012339585;
        Wed, 16 Feb 2022 03:52:19 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:52:19 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 03/12] mm: memcontrol: make lruvec lock safe when LRU pages are reparented
Date:   Wed, 16 Feb 2022 19:51:23 +0800
Message-Id: <20220216115132.52602-4-songmuchun@bytedance.com>
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

The diagram below shows how to make the folio lruvec lock safe when LRU
pages are reparented.

folio_lruvec_lock(folio)
    retry:
	lruvec = folio_lruvec(folio);

        // The folio is reparented at this time.
        spin_lock(&lruvec->lru_lock);

        if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
            // Acquired the wrong lruvec lock and need to retry.
            // Because this folio is on the parent memcg lruvec list.
            goto retry;

        // If we reach here, it means that folio_memcg(folio) is stable.

memcg_reparent_objcgs(memcg)
    // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
    spin_lock(&lruvec->lru_lock);
    spin_lock(&lruvec_parent->lru_lock);

    // Move all the pages from the lruvec list to the parent lruvec list.

    spin_unlock(&lruvec_parent->lru_lock);
    spin_unlock(&lruvec->lru_lock);

After we acquire the lruvec lock, we need to check whether the folio is
reparented. If so, we need to reacquire the new lruvec lock. On the
routine of the LRU pages reparenting, we will also acquire the lruvec
lock (will be implemented in the later patch). So folio_memcg() cannot
be changed when we hold the lruvec lock.

Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
remove it.

This is a preparation for reparenting the LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 18 +++----------
 mm/compaction.c            | 10 +++++++-
 mm/memcontrol.c            | 63 +++++++++++++++++++++++++++++-----------------
 mm/swap.c                  |  4 +++
 4 files changed, 56 insertions(+), 39 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 81a2720653d0..961e9f9b6567 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -737,7 +737,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
  * folio_lruvec - return lruvec for isolating/putting an LRU folio
  * @folio: Pointer to the folio.
  *
- * This function relies on folio->mem_cgroup being stable.
+ * The lruvec can be changed to its parent lruvec when the page reparented.
+ * The caller need to recheck if it cares about this changes (just like
+ * folio_lruvec_lock() does).
  */
 static inline struct lruvec *folio_lruvec(struct folio *folio)
 {
@@ -756,15 +758,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 						unsigned long *flags);
 
-#ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
-#else
-static inline
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
-{
-}
-#endif
-
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
@@ -1227,11 +1220,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
 	return &pgdat->__lruvec;
 }
 
-static inline
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
-{
-}
-
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
 	return NULL;
diff --git a/mm/compaction.c b/mm/compaction.c
index 58d0e91cde49..eebe55e596fd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -515,6 +515,8 @@ compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
 {
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
 	lruvec = folio_lruvec(folio);
 
 	/* Track if the lock is contended in async mode */
@@ -527,7 +529,13 @@ compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
 
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 out:
-	lruvec_memcg_debug(lruvec, folio);
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in folio_lruvec_lock(). */
+	rcu_read_unlock();
 
 	return lruvec;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6501f5b6df4b..7c7672631456 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1178,23 +1178,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
-#ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
-{
-	struct mem_cgroup *memcg;
-
-	if (mem_cgroup_disabled())
-		return;
-
-	memcg = folio_memcg(folio);
-
-	if (!memcg)
-		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
-	else
-		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
-}
-#endif
-
 /**
  * folio_lruvec_lock - Lock the lruvec for a folio.
  * @folio: Pointer to the folio.
@@ -1209,10 +1192,24 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
  */
 struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
-	struct lruvec *lruvec = folio_lruvec(folio);
+	struct lruvec *lruvec;
+
+	rcu_read_lock();
+retry:
+	lruvec = folio_lruvec(folio);
 
 	spin_lock(&lruvec->lru_lock);
-	lruvec_memcg_debug(lruvec, folio);
+
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock(&lruvec->lru_lock);
+		goto retry;
+	}
+
+	/*
+	 * Preemption is disabled in the internal of spin_lock, which can serve
+	 * as RCU read-side critical sections.
+	 */
+	rcu_read_unlock();
 
 	return lruvec;
 }
@@ -1232,10 +1229,20 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
  */
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 {
-	struct lruvec *lruvec = folio_lruvec(folio);
+	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
+	lruvec = folio_lruvec(folio);
 	spin_lock_irq(&lruvec->lru_lock);
-	lruvec_memcg_debug(lruvec, folio);
+
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock_irq(&lruvec->lru_lock);
+		goto retry;
+	}
+
+	/* See the comments in folio_lruvec_lock(). */
+	rcu_read_unlock();
 
 	return lruvec;
 }
@@ -1257,10 +1264,20 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 		unsigned long *flags)
 {
-	struct lruvec *lruvec = folio_lruvec(folio);
+	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
+	lruvec = folio_lruvec(folio);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
-	lruvec_memcg_debug(lruvec, folio);
+
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in folio_lruvec_lock(). */
+	rcu_read_unlock();
 
 	return lruvec;
 }
diff --git a/mm/swap.c b/mm/swap.c
index bcf3ac288b56..9c2bcc2651c6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -305,6 +305,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_folio(struct folio *folio)
 {
+	/*
+	 * The rcu read lock is held by the caller, so we do not need to
+	 * care about the lruvec returned by folio_lruvec() being released.
+	 */
 	lru_note_cost(folio_lruvec(folio), folio_is_file_lru(folio),
 			folio_nr_pages(folio));
 }
-- 
2.11.0

