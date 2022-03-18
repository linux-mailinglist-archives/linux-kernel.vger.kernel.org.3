Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB54DDD66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiCRP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiCRP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:58:11 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004099ED3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:56:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=cuibixuan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7XBZR6_1647619000;
Received: from VM20210331-25.tbsite.net(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0V7XBZR6_1647619000)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 23:56:45 +0800
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     cuibixuan@linux.alibaba.com, rostedt@goodmis.org, mingo@redhat.com,
        yi.zhang@huawei.com, jack@suse.cz
Subject: [PATCH -next] jbd2: use the correct print format
Date:   Fri, 18 Mar 2022 23:56:40 +0800
Message-Id: <1647619000-17758-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print format error was found when using ftrace event:
    <...>-1406 [000] .... 23599442.895823: jbd2_end_commit: dev 252,8 transaction -1866216965 sync 0 head -1866217368
    <...>-1406 [000] .... 23599442.896299: jbd2_start_commit: dev 252,8 transaction -1866216964 sync 0

Print transaction and head with the unsigned format "%u" instead.

Fixes: 879c5e6b7cb4 ('jbd2: convert instrumentation from markers to tracepoints')
Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
---
 include/trace/events/jbd2.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index a4dfe005983d..5be1aa1691fb 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -40,7 +40,7 @@ DECLARE_EVENT_CLASS(jbd2_commit,
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	char,	sync_commit		  )
-		__field(	int,	transaction		  )
+		__field(	tid_t,	transaction		  )
 	),
 
 	TP_fast_assign(
@@ -49,7 +49,7 @@ DECLARE_EVENT_CLASS(jbd2_commit,
 		__entry->transaction	= commit_transaction->t_tid;
 	),
 
-	TP_printk("dev %d,%d transaction %d sync %d",
+	TP_printk("dev %d,%d transaction %u sync %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->transaction, __entry->sync_commit)
 );
@@ -97,8 +97,8 @@ TRACE_EVENT(jbd2_end_commit,
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	char,	sync_commit		  )
-		__field(	int,	transaction		  )
-		__field(	int,	head		  	  )
+		__field(	tid_t,	transaction		  )
+		__field(	tid_t,	head		  	  )
 	),
 
 	TP_fast_assign(
@@ -108,7 +108,7 @@ TRACE_EVENT(jbd2_end_commit,
 		__entry->head		= journal->j_tail_sequence;
 	),
 
-	TP_printk("dev %d,%d transaction %d sync %d head %d",
+	TP_printk("dev %d,%d transaction %u sync %d head %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->transaction, __entry->sync_commit, __entry->head)
 );
-- 
2.19.1.6.gb485710b

