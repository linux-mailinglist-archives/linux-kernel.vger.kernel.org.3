Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704D34D5CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiCKIGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCKIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:06:14 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52297666C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:05:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V6t9Q36_1646985908;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V6t9Q36_1646985908)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Mar 2022 16:05:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: compaction: Cleanup the compaction trace events
Date:   Fri, 11 Mar 2022 16:04:55 +0800
Message-Id: <4cd393b4d57f8f01ed72c001509b28e3a3b1a8c1.1646985115.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Steven suggested [1], we should access the pointers from the
trace event to avoid dereferencing them to the tracepoint function
when the tracepoint is disabled.

[1] https://lkml.org/lkml/2021/11/3/409

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/trace/events/compaction.h | 26 +++++++++++++-------------
 mm/compaction.c                   |  9 +++------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 7d48e70..c6d5d70 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -67,10 +67,10 @@
 #ifdef CONFIG_COMPACTION
 TRACE_EVENT(mm_compaction_migratepages,
 
-	TP_PROTO(unsigned long nr_all,
+	TP_PROTO(struct compact_control *cc,
 		unsigned int nr_succeeded),
 
-	TP_ARGS(nr_all, nr_succeeded),
+	TP_ARGS(cc, nr_succeeded),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, nr_migrated)
@@ -79,7 +79,7 @@
 
 	TP_fast_assign(
 		__entry->nr_migrated = nr_succeeded;
-		__entry->nr_failed = nr_all - nr_succeeded;
+		__entry->nr_failed = cc->nr_migratepages - nr_succeeded;
 	),
 
 	TP_printk("nr_migrated=%lu nr_failed=%lu",
@@ -88,10 +88,10 @@
 );
 
 TRACE_EVENT(mm_compaction_begin,
-	TP_PROTO(unsigned long zone_start, unsigned long migrate_pfn,
-		unsigned long free_pfn, unsigned long zone_end, bool sync),
+	TP_PROTO(struct compact_control *cc, unsigned long zone_start,
+		unsigned long zone_end, bool sync),
 
-	TP_ARGS(zone_start, migrate_pfn, free_pfn, zone_end, sync),
+	TP_ARGS(cc, zone_start, zone_end, sync),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, zone_start)
@@ -103,8 +103,8 @@
 
 	TP_fast_assign(
 		__entry->zone_start = zone_start;
-		__entry->migrate_pfn = migrate_pfn;
-		__entry->free_pfn = free_pfn;
+		__entry->migrate_pfn = cc->migrate_pfn;
+		__entry->free_pfn = cc->free_pfn;
 		__entry->zone_end = zone_end;
 		__entry->sync = sync;
 	),
@@ -118,11 +118,11 @@
 );
 
 TRACE_EVENT(mm_compaction_end,
-	TP_PROTO(unsigned long zone_start, unsigned long migrate_pfn,
-		unsigned long free_pfn, unsigned long zone_end, bool sync,
+	TP_PROTO(struct compact_control *cc, unsigned long zone_start,
+		unsigned long zone_end, bool sync,
 		int status),
 
-	TP_ARGS(zone_start, migrate_pfn, free_pfn, zone_end, sync, status),
+	TP_ARGS(cc, zone_start, zone_end, sync, status),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, zone_start)
@@ -135,8 +135,8 @@
 
 	TP_fast_assign(
 		__entry->zone_start = zone_start;
-		__entry->migrate_pfn = migrate_pfn;
-		__entry->free_pfn = free_pfn;
+		__entry->migrate_pfn = cc->migrate_pfn;
+		__entry->free_pfn = cc->free_pfn;
 		__entry->zone_end = zone_end;
 		__entry->sync = sync;
 		__entry->status = status;
diff --git a/mm/compaction.c b/mm/compaction.c
index b72fb9d..c3e37aa 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2387,8 +2387,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	update_cached = !sync &&
 		cc->zone->compact_cached_migrate_pfn[0] == cc->zone->compact_cached_migrate_pfn[1];
 
-	trace_mm_compaction_begin(start_pfn, cc->migrate_pfn,
-				cc->free_pfn, end_pfn, sync);
+	trace_mm_compaction_begin(cc, start_pfn, end_pfn, sync);
 
 	/* lru_add_drain_all could be expensive with involving other CPUs */
 	lru_add_drain();
@@ -2438,8 +2437,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 				compaction_free, (unsigned long)cc, cc->mode,
 				MR_COMPACTION, &nr_succeeded);
 
-		trace_mm_compaction_migratepages(cc->nr_migratepages,
-						 nr_succeeded);
+		trace_mm_compaction_migratepages(cc, nr_succeeded);
 
 		/* All pages were either migrated or will be released */
 		cc->nr_migratepages = 0;
@@ -2515,8 +2513,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	count_compact_events(COMPACTMIGRATE_SCANNED, cc->total_migrate_scanned);
 	count_compact_events(COMPACTFREE_SCANNED, cc->total_free_scanned);
 
-	trace_mm_compaction_end(start_pfn, cc->migrate_pfn,
-				cc->free_pfn, end_pfn, sync, ret);
+	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
 
 	return ret;
 }
-- 
1.8.3.1

