Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590C5981CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiHRK6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244199AbiHRK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:57:44 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C1590C50
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:57:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMaUrGs_1660820256;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VMaUrGs_1660820256)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 18:57:37 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH V2 2/2] mm/damon/lru_sort: Remove struct of damon_lru_sort_ram_walk_arg
Date:   Thu, 18 Aug 2022 18:57:32 +0800
Message-Id: <20220818105732.34492-3-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220818105732.34492-1-xhao@linux.alibaba.com>
References: <20220818105732.34492-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct of 'damon_lru_sort_ram_walk_arg' is the same with struct of
'damon_addr_range', so, there no need to redefine it, just use struct of
'damon_addr_range' instead.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/lru_sort.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index ac50dca026f9..a3674532fa67 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -257,18 +257,13 @@ module_param(nr_cold_quota_exceeds, ulong, 0400);
 static struct damon_ctx *ctx;
 static struct damon_target *target;

-struct damon_lru_sort_ram_walk_arg {
-	unsigned long start;
-	unsigned long end;
-};
-
 static int walk_system_ram(struct resource *res, void *arg)
 {
-	struct damon_lru_sort_ram_walk_arg *a = arg;
+	struct damon_addr_range *r = arg;

-	if (a->end - a->start < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
+	if (r->end - r->start < resource_size(res)) {
+		r->start = res->start;
+		r->end = res->end;
 	}
 	return 0;
 }
@@ -277,16 +272,12 @@ static int walk_system_ram(struct resource *res, void *arg)
  * Find biggest 'System RAM' resource and store its start and end address in
  * @start and @end, respectively.  If no System RAM is found, returns false.
  */
-static bool get_monitoring_region(unsigned long *start, unsigned long *end)
+static bool get_monitoring_region(struct damon_addr_range *range)
 {
-	struct damon_lru_sort_ram_walk_arg arg = {};
-
-	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
-	if (arg.end <= arg.start)
+	walk_system_ram_res(0, ULONG_MAX, range, walk_system_ram);
+	if (range->end <= range->start)
 		return false;

-	*start = arg.start;
-	*end = arg.end;
 	return true;
 }

@@ -380,9 +371,12 @@ static int damon_lru_sort_apply_parameters(void)

 	if (monitor_region_start > monitor_region_end)
 		return -EINVAL;
-	if (!monitor_region_start && !monitor_region_end &&
-			!get_monitoring_region(&monitor_region_start,
-				&monitor_region_end))
+	if (!monitor_region_end)
+		return -EINVAL;
+
+	addr_range.start = monitor_region_start;
+	addr_range.end = monitor_region_end;
+	if (!get_monitoring_region(&addr_range))
 		return -EINVAL;

 	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
@@ -408,8 +402,6 @@ static int damon_lru_sort_apply_parameters(void)
 		return -ENOMEM;
 	damon_add_scheme(ctx, scheme);

-	addr_range.start = monitor_region_start;
-	addr_range.end = monitor_region_end;
 	return damon_set_regions(target, &addr_range, 1);
 }

--
2.27.0
