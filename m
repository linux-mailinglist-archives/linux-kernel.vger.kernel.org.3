Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9047D099
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbhLVLOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:14:54 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57008 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235123AbhLVLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:14:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V.QCTVO_1640171690;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.QCTVO_1640171690)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 19:14:51 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        shy828301@gmail.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: Export the demote_page_list() function
Date:   Wed, 22 Dec 2021 19:14:40 +0800
Message-Id: <abebba759c00afc910650f3867fa40aa16ba10a0.1640171137.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the demote_page_list() function to the head file as a
preparation to support page demotion for DAMON monitor.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/internal.h | 2 ++
 mm/vmscan.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index deb9bda..f11e444 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -181,6 +181,8 @@ static inline void set_page_refcounted(struct page *page)
 extern int isolate_lru_page(struct page *page);
 extern void putback_lru_page(struct page *page);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
+extern unsigned int demote_page_list(struct list_head *demote_pages,
+				     struct pglist_data *pgdat);
 
 /*
  * in mm/rmap.c:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f3162a5..849dffa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1480,8 +1480,8 @@ static struct page *alloc_demote_page(struct page *page, unsigned long node)
  * another node.  Pages which are not demoted are left on
  * @demote_pages.
  */
-static unsigned int demote_page_list(struct list_head *demote_pages,
-				     struct pglist_data *pgdat)
+unsigned int demote_page_list(struct list_head *demote_pages,
+			      struct pglist_data *pgdat)
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
-- 
1.8.3.1

