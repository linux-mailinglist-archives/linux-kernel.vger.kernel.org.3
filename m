Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9C52657D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378612AbiEMPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381876AbiEMPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689747AEE
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12BBD62294
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF7FC34115;
        Fri, 13 May 2022 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652454036;
        bh=w5mI+m7YFoLXGyrTD97A7aVQJcALsUpoPsjo1Fivhrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZ0VSFfIONCVA1y76eAkXqiBNav2M0U1RT1pz5UliiH0R2Rwhs0OS5Atku3oa5iZe
         Kuigcj0Nak335/fGN54i8YYqfrQKetOnbSTLTCm9af0C8AVjaIMYsmGERw64g2mM2A
         V3crrrYRG5g3lCSR7csJrZiuYRfegWS0I6n3GAo+k02usfM21Bdj5kGbx96QYlsIlw
         LSsvoPfvbdb4TniPKLeZ1ezfqxI/+9F6qdSjCFGTaP8rZ3uI7NUiv05zbnIWTpMT62
         luJDOH9SAZQCRzxD5S3DLuhNqnR7ty6E4IfhrWgCvUEcHYaSsDoyTwRL6ayz9Y3Alq
         ageyVvA548Zuw==
From:   SeongJae Park <sj@kernel.org>
Cc:     linux-damon@amazon.com, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 2/3] mm/damon/schemes: Support 'hot' action
Date:   Fri, 13 May 2022 16:59:59 +0200
Message-Id: <20220513150000.25797-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513150000.25797-1-sj@kernel.org>
References: <20220513150000.25797-1-sj@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds another DAMOS action called 'hot'.  The action marks
pages in the memory area of the taregt access pattern to be marked as
accessed.  Specifically, calls 'mark_page_accessed()'.  This is supposed
to be used for memory regions having frequent access so that hot pages
could be more protected under memory pressure.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/ops-common.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 20 ++++++++++++++++++++
 mm/damon/sysfs.c      |  1 +
 5 files changed, 67 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7c62da31ce4b..ed5338c3133d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -87,6 +87,7 @@ struct damon_target {
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_STAT:		Do nothing but count the stat.
+ * @DAMOS_HOT:		Mark the region as hot.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  */
 enum damos_action {
@@ -96,6 +97,7 @@ enum damos_action {
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
+	DAMOS_HOT,
 	NR_DAMOS_ACTIONS,
 };
 
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index e346cc10d143..fe9288025bae 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -131,3 +131,45 @@ int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
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
index 08deee12ebfd..69980b922bf4 100644
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
+	case DAMOS_HOT:
+		return damon_pa_mark_accessed(r);
 	default:
 		break;
 	}
@@ -253,6 +271,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
 		return damon_pageout_score(context, r, scheme);
+	case DAMOS_HOT:
+		return damon_hot_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 09f9e8ca3d1f..a1de2278f8c2 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -763,6 +763,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"hugepage",
 	"nohugepage",
 	"stat",
+	"hot",
 };
 
 static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
-- 
2.17.1

