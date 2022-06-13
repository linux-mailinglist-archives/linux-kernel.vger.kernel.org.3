Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5E549F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiFMUeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiFMUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:33:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5550B183A9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA47DB812A2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4293BC341C0;
        Mon, 13 Jun 2022 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655148190;
        bh=uKUGIZGPQZchKZAH92MEAi0WmMFjIc8qS5qYmL1UAXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dK6TFvLEVwmXnr86/42/FgXjvzbKYeaAFVTHq+OA3hBpVVNQDCmG6yj4xyYosJlpO
         3HbCMV2snUEAbqP+mr2h7GsZuOMYWVrchP3JJW3gl7ZOR+isfJCza0/wEphct07O36
         m+Uz/LwRBP2cPaMZXDSi6CoZZf4BC7IH8kdLulq8mZUJt1/o1nCRBug8S8WRxnKSJ4
         shA6ZH2CwhBt13c8rn42G/ppl9ZdMS8ZiXsiew65Y4tagAYXCjOK86SI9DfSHCI0RC
         LQQe48kkhO6Nw+higB9rZQCVP9QdVti3gPJaQoK92LKhDSrzcZ+CSDj4ThpN1dWh+w
         kW6kPFM+piwBg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] mm/damon/schemes: add 'LRU_PRIO' DAMOS action
Date:   Mon, 13 Jun 2022 19:22:56 +0000
Message-Id: <20220613192301.8817-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192301.8817-1-sj@kernel.org>
References: <20220613192301.8817-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a new DAMOS action called 'LRU_PRIO' for the physical
address space.  The action prioritizes pages in the memory regions of
the user-specified target access pattern on their LRU lists. This is
hence supposed to be used for frequently accessed (hot) memory regions
so that hot pages could be more likely protected under memory pressure.
Internally, it simply calls 'mark_page_accessed()'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/ops-common.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 20 ++++++++++++++++++++
 mm/damon/sysfs.c      |  1 +
 5 files changed, 67 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b9aae19fab3e..4c64e03e94d8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -86,6 +86,7 @@ struct damon_target {
  * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
+ * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  */
@@ -95,6 +96,7 @@ enum damos_action {
 	DAMOS_PAGEOUT,
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
+	DAMOS_LRU_PRIO,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 10ef20b2003f..b1335de200e7 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -130,3 +130,45 @@ int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 	/* Return coldness of the region */
 	return DAMOS_MAX_SCORE - hotness;
 }
+
+int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
+			struct damos *s)
+{
+	unsigned int max_nr_accesses;
+	int freq_subscore;
+	unsigned int age_in_sec;
+	int age_in_log, age_subscore;
+	unsigned int freq_weight = s->quota.weight_nr_accesses;
+	unsigned int age_weight = s->quota.weight_age;
+	int hotness;
+
+	max_nr_accesses = c->aggr_interval / c->sample_interval;
+	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE / max_nr_accesses;
+
+	age_in_sec = (unsigned long)r->age * c->aggr_interval / 1000000;
+	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
+			age_in_log++, age_in_sec >>= 1)
+		;
+
+	/* If frequency is 0, higher age means it's colder */
+	if (freq_subscore == 0)
+		age_in_log *= -1;
+
+	/*
+	 * Now age_in_log is in [-DAMON_MAX_AGE_IN_LOG, DAMON_MAX_AGE_IN_LOG].
+	 * Scale it to be in [0, 100] and set it as age subscore.
+	 */
+	age_in_log += DAMON_MAX_AGE_IN_LOG;
+	age_subscore = age_in_log * DAMON_MAX_SUBSCORE /
+		DAMON_MAX_AGE_IN_LOG / 2;
+
+	hotness = (freq_weight * freq_subscore + age_weight * age_subscore);
+	if (freq_weight + age_weight)
+		hotness /= freq_weight + age_weight;
+	/*
+	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
+	 */
+	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
+
+	return hotness;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index e790cb5f8fe0..52329ff361cd 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -14,3 +14,5 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
 
 int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
+int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
+			struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 7bcd48066b43..f145b1d51e13 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -233,6 +233,22 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
 	return applied * PAGE_SIZE;
 }
 
+static unsigned long damon_pa_mark_accessed(struct damon_region *r)
+{
+	unsigned long addr, applied = 0;
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct page *page = damon_get_page(PHYS_PFN(addr));
+
+		if (!page)
+			continue;
+		mark_page_accessed(page);
+		put_page(page);
+		applied++;
+	}
+	return applied * PAGE_SIZE;
+}
+
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -240,6 +256,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
 		return damon_pa_pageout(r);
+	case DAMOS_LRU_PRIO:
+		return damon_pa_mark_accessed(r);
 	default:
 		break;
 	}
@@ -253,6 +271,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
 		return damon_pageout_score(context, r, scheme);
+	case DAMOS_LRU_PRIO:
+		return damon_hot_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c35809c6087c..86c69f980927 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -762,6 +762,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"pageout",
 	"hugepage",
 	"nohugepage",
+	"lru_prio",
 	"stat",
 };
 
-- 
2.25.1

