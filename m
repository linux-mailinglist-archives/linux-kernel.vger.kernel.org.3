Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4172957C4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiGUHIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiGUHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:08:09 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E4277A4E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:08:05 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 26L77AB4031705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 21 Jul 2022 15:07:10 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 21 Jul 2022 15:07:10 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: [RFC PATCH] mm: set cache_trim_mode when inactive ratio is undesired
Date:   Thu, 21 Jul 2022 15:06:48 +0800
Message-ID: <1658387208-20065-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 26L77AB4031705
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Undesirable inactive file ratio could be observed under some scenarios(such as
large number of mapped file access) and hardly recover during a certain period
of time, which could be a result of tight criteria judgement of cache_trim_mode,
which demand both of none-thrashing and inactive_is_low simutaneously and lead
to the mode as SCAN_FRAC or SCAN_EQUAL when scanning lru.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a68..8e84fe6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2663,6 +2663,23 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	return inactive * inactive_ratio < active;
 }
 
+static bool inactive_is_high(struct lruvec *lruvec, enum lru_list inactive_lru)
+{
+	enum lru_list active_lru = inactive_lru + LRU_ACTIVE;
+	unsigned long inactive, active;
+	unsigned long active_ratio = 2;
+	unsigned long gb;
+
+	inactive = lruvec_page_state(lruvec, NR_LRU_BASE + inactive_lru);
+	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
+
+	gb = (inactive + active) >> (30 - PAGE_SHIFT);
+	if (gb)
+		active_ratio = 1;
+
+	return inactive > active_ratio * active;
+}
+
 enum scan_balance {
 	SCAN_EQUAL,
 	SCAN_FRACT,
@@ -3198,7 +3215,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * anonymous pages.
 	 */
 	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
-	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
+	if (file >> sc->priority && (!(sc->may_deactivate & DEACTIVATE_FILE)
+		|| inactive_is_high(target_lruvec, LRU_INACTIVE_FILE)))
 		sc->cache_trim_mode = 1;
 	else
 		sc->cache_trim_mode = 0;
-- 
1.9.1

