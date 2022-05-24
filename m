Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E4C532324
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiEXG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiEXG1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:27:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1816772E1F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:27:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so1295615pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQmbzG/x1UDz5U0yQVXExNL9W+QNwv5yyDN0QDopwLM=;
        b=SbFCQ3vJYsGUAEX8nyldT87US7H/Zi6r40ReQrz8S1DFmwuWGEoV2ZsawlDNV2F+b9
         cBbWPLt6WyLG/WEs6j6or7s/bkrS5fhQCtCJYspYV7YbDoGUD1Kpw7Cz19/bYZvOSmvn
         C7kr1O/qam5v/KZxRh4lh9qzOJtWk0NaaM5tm7fJrsj7KBzxuKuwY074AEzpGvXjXhRa
         OSdKGe9kRdi5MZEOyUCYPsJ6eblgDNZpMXrb7JA12Yd9Uc5u620Py3qTO2xYaCVNavdX
         iwklkT8fllKtpNXMNWn4waK8JwI1CM/uTxteV3N+Nq25H+HgDd0owN20+UIAf1N6TPfK
         7S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQmbzG/x1UDz5U0yQVXExNL9W+QNwv5yyDN0QDopwLM=;
        b=tlKRQVh/vYI7h+n8ut3nCMH9OYWN43Z4xBitrDi5jpK30qic1P4pkLkkSc/ebBBAWp
         +VveAwbeOafHdeTjunMkXELitswrBpjDj8HOXDuxjbn/kSrp5U/oAf/3meulscrXAKE7
         HQU/odQa4f6EK9nscnkAUefMb0mHRcrCLOUa3CxRl071pS2SaaAP9l7d+wH5G3BiaMo4
         NbNLGORGAkZW76TjVFPeGycZBH9Ymwjbu1VFGbPWRBlI6KnGgYb+o61OQZZ/e07oJPFL
         KgP5kKf280XHcbss4wFSKpmY8MghIW/hS8KAFZzwqQK6JH5X2nQsBhUH3yBdE0JUdrrm
         uk7w==
X-Gm-Message-State: AOAM531rGgzcz1FQH7BimBqbb+biRPVzdkFWfBnBu3ZjUdpiae4z7Vy9
        pq5p5Lc4D+oPgeiKaYCK3V+yvA==
X-Google-Smtp-Source: ABdhPJyvk99DuGpFOsiT2uRB5kw+R+itIfmHziS8mh58MTBgrfJrSmlj+pJB/4xFtnMj2WkZMk1iTA==
X-Received: by 2002:a17:90b:4ace:b0:1df:cb33:5e7e with SMTP id mh14-20020a17090b4ace00b001dfcb335e7emr2962784pjb.5.1653373644635;
        Mon, 23 May 2022 23:27:24 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016168e90f2dsm6254455plf.219.2022.05.23.23.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:27:24 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 02/11] mm: memcontrol: introduce compact_folio_lruvec_lock_irqsave
Date:   Tue, 24 May 2022 14:05:42 +0800
Message-Id: <20220524060551.80037-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220524060551.80037-1-songmuchun@bytedance.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
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

If we reuse the objcg APIs to charge LRU pages, the folio_memcg()
can be changed when the LRU pages reparented. In this case, we need
to acquire the new lruvec lock.

    lruvec = folio_lruvec(folio);

    // The page is reparented.

    compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);

    // Acquired the wrong lruvec lock and need to retry.

But compact_lock_irqsave() only take lruvec lock as the parameter,
we cannot aware this change. If it can take the page as parameter
to acquire the lruvec lock. When the page memcg is changed, we can
use the folio_memcg() detect whether we need to reacquire the new
lruvec lock. So compact_lock_irqsave() is not suitable for us.
Similar to folio_lruvec_lock_irqsave(), introduce
compact_folio_lruvec_lock_irqsave() to acquire the lruvec lock in
the compaction routine.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/compaction.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index fe915db6149b..817098817302 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -509,6 +509,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
+static struct lruvec *
+compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
+				  struct compact_control *cc)
+{
+	struct lruvec *lruvec;
+
+	lruvec = folio_lruvec(folio);
+
+	/* Track if the lock is contended in async mode */
+	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
+		if (spin_trylock_irqsave(&lruvec->lru_lock, *flags))
+			goto out;
+
+		cc->contended = true;
+	}
+
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
+out:
+	lruvec_memcg_debug(lruvec, folio);
+
+	return lruvec;
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -844,6 +867,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	/* Time to isolate some pages for migration */
 	for (; low_pfn < end_pfn; low_pfn++) {
+		struct folio *folio;
 
 		if (skip_on_failure && low_pfn >= next_skip_pfn) {
 			/*
@@ -1065,18 +1089,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		lruvec = folio_lruvec(page_folio(page));
+		folio = page_folio(page);
+		lruvec = folio_lruvec(folio);
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
 			if (locked)
 				unlock_page_lruvec_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			lruvec = compact_folio_lruvec_lock_irqsave(folio, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page_folio(page));
-
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
-- 
2.11.0

