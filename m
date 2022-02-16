Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197674B8312
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiBPIbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:31:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiBPIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:31:05 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76782A417B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:30:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4cXjzP_1645000248;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V4cXjzP_1645000248)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 16:30:49 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 5/5] mm/damon/tracepoint: Add 'damon_region' NUMA access statistics support
Date:   Wed, 16 Feb 2022 16:30:41 +0800
Message-Id: <ccf161f17c8e5d39d5d41003a4ec8b1d01c2aa8e.1645024354.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1645024354.git.xhao@linux.alibaba.com>
References: <cover.1645024354.git.xhao@linux.alibaba.com>
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

This patch is used to support 'damon_region' NUMA access for tracepoint,
The purpose of this is to facilitate users to obtain the numa access
status of 'damon_region' through perf or damo tools.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 include/trace/events/damon.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index c79f1d4c39af..687b7aba751e 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -23,6 +23,8 @@ TRACE_EVENT(damon_aggregated,
 		__field(unsigned long, end)
 		__field(unsigned int, nr_accesses)
 		__field(unsigned int, age)
+		__field(unsigned long, local)
+		__field(unsigned long, remote)
 	),
 
 	TP_fast_assign(
@@ -32,12 +34,15 @@ TRACE_EVENT(damon_aggregated,
 		__entry->end = r->ar.end;
 		__entry->nr_accesses = r->nr_accesses;
 		__entry->age = r->age;
+		__entry->local = r->local;
+		__entry->remote = r->remote;
 	),
 
-	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
+	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u %lu %lu",
 			__entry->target_id, __entry->nr_regions,
 			__entry->start, __entry->end,
-			__entry->nr_accesses, __entry->age)
+			__entry->nr_accesses, __entry->age,
+			__entry->local, __entry->remote)
 );
 
 #endif /* _TRACE_DAMON_H */
-- 
2.27.0

