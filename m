Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5C7598011
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbiHRI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiHRIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:25:58 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46035AFAE7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:25:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMZx.RB_1660811142;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VMZx.RB_1660811142)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 16:25:43 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH] mm/damon/lru_sort: Move target memory region check to head of func
Date:   Thu, 18 Aug 2022 16:25:38 +0800
Message-Id: <20220818082538.67825-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
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

In damon_lru_sort_apply_parameters(), if "monitor_region_start"
and "monitor_region_end" is not a valid physical address range,
There no need to run the remainder codes in it.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/lru_sort.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 9de6f00a71c5..ac50dca026f9 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -378,6 +378,13 @@ static int damon_lru_sort_apply_parameters(void)
 	unsigned int hot_thres, cold_thres;
 	int err = 0;

+	if (monitor_region_start > monitor_region_end)
+		return -EINVAL;
+	if (!monitor_region_start && !monitor_region_end &&
+			!get_monitoring_region(&monitor_region_start,
+				&monitor_region_end))
+		return -EINVAL;
+
 	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
 			min_nr_regions, max_nr_regions);
 	if (err)
@@ -401,12 +408,6 @@ static int damon_lru_sort_apply_parameters(void)
 		return -ENOMEM;
 	damon_add_scheme(ctx, scheme);

-	if (monitor_region_start > monitor_region_end)
-		return -EINVAL;
-	if (!monitor_region_start && !monitor_region_end &&
-			!get_monitoring_region(&monitor_region_start,
-				&monitor_region_end))
-		return -EINVAL;
 	addr_range.start = monitor_region_start;
 	addr_range.end = monitor_region_end;
 	return damon_set_regions(target, &addr_range, 1);
--
2.31.0
