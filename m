Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C647BCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhLUJSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:18:34 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50682 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236331AbhLUJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:18:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V.K7h71_1640078308;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.K7h71_1640078308)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 17:18:28 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        shy828301@gmail.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: Export the alloc_demote_page() function
Date:   Tue, 21 Dec 2021 17:18:03 +0800
Message-Id: <611250978aa68c1fab6112a795e9c0e5b817d9ee.1640077468.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1640077468.git.baolin.wang@linux.alibaba.com>
References: <cover.1640077468.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1640077468.git.baolin.wang@linux.alibaba.com>
References: <cover.1640077468.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the alloc_demote_page() function to the head file as a
preparation to support page demotion for DAMON monitor.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/internal.h | 1 +
 mm/vmscan.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index deb9bda..99ea5fb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -181,6 +181,7 @@ static inline void set_page_refcounted(struct page *page)
 extern int isolate_lru_page(struct page *page);
 extern void putback_lru_page(struct page *page);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
+extern struct page *alloc_demote_page(struct page *page, unsigned long node);
 
 /*
  * in mm/rmap.c:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f3162a5..bf38327 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1458,7 +1458,7 @@ static void page_check_dirty_writeback(struct page *page,
 		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
 }
 
-static struct page *alloc_demote_page(struct page *page, unsigned long node)
+struct page *alloc_demote_page(struct page *page, unsigned long node)
 {
 	struct migration_target_control mtc = {
 		/*
-- 
1.8.3.1

