Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532444B18DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbiBJWw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:52:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbiBJWwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:52:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9348B7D;
        Thu, 10 Feb 2022 14:52:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m7so6533736pjk.0;
        Thu, 10 Feb 2022 14:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+G4ImXqp+YpMfGeGYS+9Bq40aQsZnhUC626GwYdKvE=;
        b=jRjyEU3R4uemNWY/qUKFenrVhNKeIRQQgJQSjLwWDYkm3k+ajMOQmWGRJUFOUAbMGI
         JeIY1Qp+Xjv95rv7BnlpEjJ9BUO+wW005jxc9qhsCwhMBRhMBeJonVCSIrhgtG3bR7A5
         RbBvwl5EqA1Snj+FzmxTF+NKlYtNySD3GBveYDIMArClsb3349mLYd+dbzPQ1QAEdGAn
         t87Hfn5dANzEfUds5SpNlZ/gSWI96WeItS2rlmom5oiqM2DQNc7JeLjdHz3dKFgyHlGe
         BRTStPnk4QON0Flb68BwRrgHC+AX9tIVL2fXPinY9TwFWNMAnRkrGFOZeZ5EQ51ia6Rs
         EHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+G4ImXqp+YpMfGeGYS+9Bq40aQsZnhUC626GwYdKvE=;
        b=aHLgxLNhpeNyzgMqEXM2YufGNdmxgcBMCvY8Z2L1pAXtY5IuoZ1HeJ8PWnZKrGuKhz
         3beSI9hPXpN9XKX1dHtCQOJtWQX+zGHYT+qewO5MIupsv59YefMzzuRTcI4/RSX2op0F
         g4gGPbLHINYdn5OJXV40V3Ty29FElIGjrD9MH3yzKfSDgRrTknJUHbmvu3rNdloywLQB
         m03irc5dZYfhIKkADUcjIdXgUSCOj+o/HxW4magkjyj/q7Kt1ut6zNesnAGMuyq+bUSb
         wtRTTHoD6zulNCs2b6mfrCcupWyh9rIcClkuyHOd37+GxOYSKgWoerxrSwvIsNc89u/4
         VE9Q==
X-Gm-Message-State: AOAM533J4uN+Mgqw6vMRMRPMeIaZpXcF3tM+pT/Atz4TKBcnCbIdYv0w
        WrCwxUCvN2gDfPHgNXGdn+U=
X-Google-Smtp-Source: ABdhPJwQ2J1fWIOUF1+0+pC4v7lYv7ERiZvxzsDAUbW70rk1etY82hcz+XyErcUx8/OKwz8H4J9L1w==
X-Received: by 2002:a17:902:7049:: with SMTP id h9mr9947785plt.121.1644533545134;
        Thu, 10 Feb 2022 14:52:25 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id d9sm11033569pfl.69.2022.02.10.14.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:52:23 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     axboe@kernel.dk, hch@infradead.org, rostedt@goodmis.org,
        kch@nvidia.com, xiyou.wangcong@gmail.com
Cc:     shy828301@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v8 PATCH] block: introduce block_rq_error tracepoint
Date:   Thu, 10 Feb 2022 14:52:22 -0800
Message-Id: <20220210225222.260069-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rasdaemon uses the existing tracepoint block_rq_complete
and filters out non-error cases in order to capture block disk errors.

But there are a few problems with this approach:

1. Even kernel trace filter could do the filtering work, there is
   still some overhead after we enable this tracepoint.

2. The filter is merely based on errno, which does not align with kernel
   logic to check the errors for print_req_error().

3. block_rq_complete only provides dev major and minor to identify
   the block device, it is not convenient to use in user-space.

So introduce a new tracepoint block_rq_error just for the error case.
With this patch, rasdaemon could switch to block_rq_error.

Since the new tracepoint has the similar implementation with
block_rq_complete, so move the existing code from TRACE_EVENT
block_rq_complete() into new event class block_rq_completion(). Then add
event for block_rq_complete and block_rq_err respectively from the newly
created event class per the suggestion from Chaitanya Kulkarni.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
The v3 patch was submitted in Feb 2020, and Steven reviewed the patch, but
it was not merged to upstream. See
https://lore.kernel.org/lkml/20200203053650.8923-1-xiyou.wangcong@gmail.com/.

The problems fixed by that patch still exist and we do need it to make
disk error handling in rasdaemon easier. So this resurrected it and
continued the version number.

v7 --> v8:
 * Combined two patches into one per Christoph Hellwig.
 * Kept Steven's reviewed-by since there is no significant change for
   tracepoint other than creating event class.
v6 --> v7:
 * Prepared (two patches) by Chaitanya Kulkarni
 * Created event class
v5 --> v6:
 * Removed disk name per Christoph and Chaitanya
 * Kept errno since I didn't find any other block tracepoints print blk
   status code and userspace (i.e. rasdaemon) does expect errno.
v4 --> v5:
 * Report the actual block layer status code instead of the errno per
   Christoph Hellwig.
v3 --> v4:
 * Rebased to v5.17-rc1.
 * Collected reviewed-by tag from Steven.

 block/blk-mq.c               |  4 ++-
 include/trace/events/block.h | 49 ++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1adfe4824ef5..b79a9b500105 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -789,8 +789,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
+		     !(req->rq_flags & RQF_QUIET))) {
 		blk_print_req_error(req, error);
+		trace_block_rq_error(req, error, nr_bytes);
+	}
 
 	blk_account_io_completion(req, nr_bytes);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 27170e40e8c9..7f4dfbdf12a6 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -100,19 +100,7 @@ TRACE_EVENT(block_rq_requeue,
 		  __entry->nr_sector, 0)
 );
 
-/**
- * block_rq_complete - block IO operation completed by device driver
- * @rq: block operations request
- * @error: status code
- * @nr_bytes: number of completed bytes
- *
- * The block_rq_complete tracepoint event indicates that some portion
- * of operation request has been completed by the device driver.  If
- * the @rq->bio is %NULL, then there is absolutely no additional work to
- * do for the request. If @rq->bio is non-NULL then there is
- * additional work required to complete the request.
- */
-TRACE_EVENT(block_rq_complete,
+DECLARE_EVENT_CLASS(block_rq_completion,
 
 	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
 
@@ -144,6 +132,41 @@ TRACE_EVENT(block_rq_complete,
 		  __entry->nr_sector, __entry->error)
 );
 
+/**
+ * block_rq_complete - block IO operation completed by device driver
+ * @rq: block operations request
+ * @error: status code
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_complete tracepoint event indicates that some portion
+ * of operation request has been completed by the device driver.  If
+ * the @rq->bio is %NULL, then there is absolutely no additional work to
+ * do for the request. If @rq->bio is non-NULL then there is
+ * additional work required to complete the request.
+ */
+DEFINE_EVENT(block_rq_completion, block_rq_complete,
+
+	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes)
+);
+
+/**
+ * block_rq_error - block IO operation error reported by device driver
+ * @rq: block operations request
+ * @error: status code
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_error tracepoint event indicates that some portion
+ * of operation request has failed as reported by the device driver.
+ */
+DEFINE_EVENT(block_rq_completion, block_rq_error,
+
+	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes)
+);
+
 DECLARE_EVENT_CLASS(block_rq,
 
 	TP_PROTO(struct request *rq),
-- 
2.26.3

