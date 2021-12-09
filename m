Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79E46ED1F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhLIQhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:37:05 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37341 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235038AbhLIQhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:37:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V-4XSLS_1639067604;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V-4XSLS_1639067604)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 00:33:27 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 2/2] mm/damon: Modify the display form of damon tracepoint
Date:   Fri, 10 Dec 2021 00:33:17 +0800
Message-Id: <1e019e8ffe8c040376ec59e918d301058cc58ade.1639066954.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1639066954.git.xhao@linux.alibaba.com>
References: <cover.1639066954.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I use the perf command to record damon monitor data, like below.
    # perf record -e damon:damon_aggregated
    # perf script
    ...target_id=18446462667479739520 nr_regions=13 281472805928960-281472942936064...
    ...target_id=18446462667479739520 nr_regions=13 281472942936064-281473080008704...
    ...target_id=18446462667479739520 nr_regions=13 281473080008704-281473216634880...

From a user's point of view, the 'target_id' and 'damon_region' which displays in decimal
are not very friendly, So there do some changes, keep the 'target_id' display consistent
with 'dbgfs/target_ids' interface and 'damon_region' is displayed in hexadecimal, just like
below.
    # perf record -e damon:damon_aggregated
    # perf script
    ...target_id=5522 nr_regions=14 ffff716a3000-ffff79893000...
    ...target_id=5522 nr_regions=14 ffff79893000-ffff819dc000...
    ...target_id=5522 nr_regions=14 ffff819dc000-ffff89bd9000...

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/trace/events/damon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 99ffa601e351..67de51814f4c 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -17,7 +17,7 @@ TRACE_EVENT(damon_aggregated,
 	TP_ARGS(t, r, nr_regions),

 	TP_STRUCT__entry(
-		__field(unsigned long, target_id)
+		__field(int, target_id)
 		__field(unsigned int, nr_regions)
 		__field(unsigned long, start)
 		__field(unsigned long, end)
@@ -26,7 +26,7 @@ TRACE_EVENT(damon_aggregated,
 	),

 	TP_fast_assign(
-		__entry->target_id = t->id;
+		__entry->target_id = (int)pid_vnr((struct pid *)t->id);
 		__entry->nr_regions = nr_regions;
 		__entry->start = r->ar.start;
 		__entry->end = r->ar.end;
@@ -34,7 +34,7 @@ TRACE_EVENT(damon_aggregated,
 		__entry->age = r->age;
 	),

-	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
+	TP_printk("target_id=%u nr_regions=%u %lx-%lx: %u %u",
 			__entry->target_id, __entry->nr_regions,
 			__entry->start, __entry->end,
 			__entry->nr_accesses, __entry->age)
--
2.31.0
