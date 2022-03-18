Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFC94DD706
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiCRJYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiCRJYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:24:44 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9038DF4F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:23:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V7Vv8yQ_1647595401;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V7Vv8yQ_1647595401)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 17:23:22 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Make the sampling more accurate
Date:   Fri, 18 Mar 2022 17:23:13 +0800
Message-Id: <1647595393-103185-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to sample the physical address with DAMON to migrate pages
on tiered memory system, I found it will demote some cold regions mistakenly.
Now we will choose an physical address in the region randomly, but if
its corresponding page is not an online LRU page, we will ignore the
accessing status in this cycle of sampling, and actually will be treated
as a non-accessed region. Suppose a region including some non-LRU pages,
it will be treated as a cold region with a high probability, and may be
merged with adjacent cold regions, but there are some pages may be
accessed we missed.

So instead of ignoring the access status of this region if we did not find
a valid page according to current sampling address, we can use last valid
sampling address to help to make the sampling more accurate, then we can do
a better decision.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       |  2 ++
 mm/damon/paddr.c      | 15 ++++++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f23cbfa..3311e15 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -38,6 +38,7 @@ struct damon_addr_range {
  * struct damon_region - Represents a monitoring target region.
  * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
+ * @last_sampling_addr:	Last valid address of the sampling.
  * @nr_accesses:	Access frequency of this region.
  * @list:		List head for siblings.
  * @age:		Age of this region.
@@ -50,6 +51,7 @@ struct damon_addr_range {
 struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
+	unsigned long last_sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c1e0fed..957704f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -108,6 +108,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
+	region->last_sampling_addr = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
@@ -848,6 +849,7 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 		return;
 
 	r->ar.end = new->ar.start;
+	r->last_sampling_addr = 0;
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 21474ae..5f15068 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -31,10 +31,9 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
 	return true;
 }
 
-static void damon_pa_mkold(unsigned long paddr)
+static void damon_pa_mkold(struct page *page)
 {
 	struct folio *folio;
-	struct page *page = damon_get_page(PHYS_PFN(paddr));
 	struct rmap_walk_control rwc = {
 		.rmap_one = __damon_pa_mkold,
 		.anon_lock = folio_lock_anon_vma_read,
@@ -66,9 +65,19 @@ static void damon_pa_mkold(unsigned long paddr)
 static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
 					    struct damon_region *r)
 {
+	struct page *page;
+
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
-	damon_pa_mkold(r->sampling_addr);
+	page = damon_get_page(PHYS_PFN(r->sampling_addr));
+	if (page) {
+		r->last_sampling_addr = r->sampling_addr;
+	} else if (r->last_sampling_addr) {
+		r->sampling_addr = r->last_sampling_addr;
+		page = damon_get_page(PHYS_PFN(r->last_sampling_addr));
+	}
+
+	damon_pa_mkold(page);
 }
 
 static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
-- 
1.8.3.1

