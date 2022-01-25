Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0949BD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiAYUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiAYUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:35:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F26BC06173B;
        Tue, 25 Jan 2022 12:35:51 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso4003416pjm.4;
        Tue, 25 Jan 2022 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3XncuSgpVxyl8Q7vmKZW6EQ/fSYmrQQ0wa5o30oTVc=;
        b=k1LT7AFOqVsh7qUHUBTJ7G94ldMm1XTdQaw1p6+U34HfDteI6eKGvpjPoufDOEnQ0f
         sLCuYlK9e37jpj8qSzClxE79bTLjsbswsza/ecRo7GF9VWLq5jN2ojRaYlXB4w4aPnGt
         1YM63yFh5pwoFmF0NbJsGPjkK2BPDgj09fy1TtRqRep1RG4jfKFBFnjbMnnYCsk2MYuS
         vubkpcxkp20kuxMuNxwW6Ft14XWYDnO3hyDJdKNhYS+Q9GH+4SSJc1RK6QnisScKR6Eo
         3Wk1wMZYZ+MHQ2BH7l4bLuXpXr2kNDT7hnsjaqAOkEAA5uGeIX+UwM0zHd+Kfq9W++d8
         j0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3XncuSgpVxyl8Q7vmKZW6EQ/fSYmrQQ0wa5o30oTVc=;
        b=XCadArHAIG/axqWRTzYQYd/OGTmesfOG9XMOKIsCU6Y9R3pjFYOQ3t4WEctmjUliu1
         h2O60EdJsRBlfppbcS/AbfPYV4vQPlu1MHxWh2BatUP4bbCOsb8tRk63DhgnNtEGvhjF
         s+/p5POkkcWjK1OPX9M5iLNlScidq7ELa1RlTXRPk5ZcTAHLQB9aQHr097iTYVK/cZXh
         NzcqI3Bb9B99UfH0UKdajZSE4mewvgsJ2kc904563IXExIztX19G22oOYH4rZYALlv4/
         1jQxvHQP0V9eKkZkfQ17rxVDRYMyO2QwC8aROn3Lq7ffC7mzjV5a6y9F09U4ESLwruXF
         MwXQ==
X-Gm-Message-State: AOAM5336JHgEUJr/l3c2KDvSYS53dIhhQ09KeY1A6otyfiYlW1TMnTPW
        wq4bhtTcbesF/rszAI1rpNuPTgijfrQ=
X-Google-Smtp-Source: ABdhPJx6hqAtyQhLL4UkKPX0rEpPu9ZOyMaRKEqH0SI759bxBA3dMmBsvfcYToH1qBy1HAajT5CKhw==
X-Received: by 2002:a17:90b:4a41:: with SMTP id lb1mr5287255pjb.151.1643142950844;
        Tue, 25 Jan 2022 12:35:50 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id d126sm10849352pfd.136.2022.01.25.12.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:35:49 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     axboe@kernel.dk, rostedt@goodmis.org, xiyou.wangcong@gmail.com
Cc:     shy828301@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH] block: introduce block_rq_error tracepoint
Date:   Tue, 25 Jan 2022 12:35:48 -0800
Message-Id: <20220125203548.352278-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

So introduce a new tracepoint block_rq_error just for the error case
and provides the device name for convenience too. With this patch,
rasdaemon could switch to block_rq_error.

Cc: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
The v3 patch was submitted in Feb 2020, and Steven reviewed the patch, but
it was not merged to upstream. See
https://lore.kernel.org/lkml/20200203053650.8923-1-xiyou.wangcong@gmail.com/.

The problems fixed by that patch still exist and we do need it to make
disk error handling in rasdaemon easier. So this resurrected it and
continued the version number.

v3 --> v4:
 * Rebased to v5.17-rc1.
 * Collected reviewed-by tag from Steven.

 block/blk-mq.c               |  4 +++-
 include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3bf3358a3bb..bb0593f93675 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -789,8 +789,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
+		     !(req->rq_flags & RQF_QUIET))) {
+		trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
 		blk_print_req_error(req, error);
+	}
 
 	blk_account_io_completion(req, nr_bytes);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 27170e40e8c9..3ab6cfe5795a 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -144,6 +144,47 @@ TRACE_EVENT(block_rq_complete,
 		  __entry->nr_sector, __entry->error)
 );
 
+/**
+ * block_rq_error - block IO operation error reported by device driver
+ * @rq: block operations request
+ * @error: status code
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_error tracepoint event indicates that some portion
+ * of operation request has failed as reported by the device driver.
+ */
+TRACE_EVENT(block_rq_error,
+
+	TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes),
+
+	TP_STRUCT__entry(
+		__field(  dev_t,	dev			)
+		__string( name,		rq->q->disk ? rq->q->disk->disk_name : "?")
+		__field(  sector_t,	sector			)
+		__field(  unsigned int,	nr_sector		)
+		__field(  int,		error			)
+		__array(  char,		rwbs,	RWBS_LEN	)
+	),
+
+	TP_fast_assign(
+		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
+		__assign_str(name,   rq->q->disk ? rq->q->disk->disk_name : "?");
+		__entry->sector    = blk_rq_pos(rq);
+		__entry->nr_sector = nr_bytes >> 9;
+		__entry->error     = error;
+
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
+	),
+
+	TP_printk("%d,%d %s %s %llu + %u [%d]",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __get_str(name), __entry->rwbs,
+		  (unsigned long long)__entry->sector,
+		  __entry->nr_sector, __entry->error)
+);
+
 DECLARE_EVENT_CLASS(block_rq,
 
 	TP_PROTO(struct request *rq),
-- 
2.26.3

