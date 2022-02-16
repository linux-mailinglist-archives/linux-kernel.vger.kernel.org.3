Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F64B871F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiBPLw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:52:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiBPLw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:52:26 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC391BA327
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w20so1802756plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGg/OyjVBMaPdX+FW5TrfDsu52VsxBTEBhG9j0K7sOM=;
        b=3KiU23Dk4IIdfI4c99qbz/qS0FY1rcMSvlEFnUqUEsZ+69PtQnmdQUJMVYwGhvgVHS
         r78whG3T/3AKLDrSJfcP1UKB06vjCZxrlcIycEiCtM38KF7GH8UR83WxgQrRzXsxgT8P
         kjux7lm5v7j83wsK3mc9jepTQoNbujTiA+SX0q43cFzseESCOtmPvYCgZFdjsFmu24zb
         unI6hREvrRte5wyTzapItLZNhuF6obCjuKQrx16ZsnBlowl7c2ExWIJNQCWiGSdMjEGn
         hBqHqEbw/4+2pkiC5HAqB03eivPrBHjPGgmKQf9YUkg4+3eTwtxhg4aVQQVsyjWM1tMh
         NBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGg/OyjVBMaPdX+FW5TrfDsu52VsxBTEBhG9j0K7sOM=;
        b=4AhZ1/pXpHYvFlD44KCqrUjk7WNzXeSnnxT/svXIX7NNzkckIhrppZqswjQ1WmqCU3
         ae/k9d1Wu7tpltYDPALQP0TYYGqPYPz3VJt/LWHaMhcQbtaanY8hOU6yZUm71kUTritW
         t6S7GATQzUEA+FoS9NbBwxI2xkd4qSjZVqCQmVbwWi31XXg7Bv6UC5lFzWGbsLoiJqEc
         b5JWes3kWP+MqwsVHi/SA/HWwwVt5S5hoh9mh8wyfTFFipjo+wB7z9hflaK3A2hGjXFs
         OHVKDHJrm4eN1otK7Su7OmSWV0LNOgle1Q9+jDyYbmgIpeSkSBdu/QfHCOafQHYEm5Pa
         VIhA==
X-Gm-Message-State: AOAM530y9mvY/uCgXLy8obRl74GmIZqGdhaG3Pu3WR4W7O4Uw03lpiki
        lu0fERwzzUzADgiScJX6OyPPIA==
X-Google-Smtp-Source: ABdhPJzWWzYhpIImuxNbs2U6LAKi9urxlUqgGKwHYnuuQnxTJG3UMWrf56amcqobb5YZEgN3v/IY8A==
X-Received: by 2002:a17:903:22c3:b0:14d:8437:5136 with SMTP id y3-20020a17090322c300b0014d84375136mr1948664plg.129.1645012333649;
        Wed, 16 Feb 2022 03:52:13 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:52:13 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 02/12] mm: memcontrol: introduce compact_folio_lruvec_lock_irqsave
Date:   Wed, 16 Feb 2022 19:51:22 +0800
Message-Id: <20220216115132.52602-3-songmuchun@bytedance.com>
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
index b4e94cda3019..58d0e91cde49 100644
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
@@ -843,6 +866,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	/* Time to isolate some pages for migration */
 	for (; low_pfn < end_pfn; low_pfn++) {
+		struct folio *folio;
 
 		if (skip_on_failure && low_pfn >= next_skip_pfn) {
 			/*
@@ -1028,18 +1052,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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

