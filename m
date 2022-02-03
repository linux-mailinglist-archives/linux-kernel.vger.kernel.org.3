Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3914A8D07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353970AbiBCUMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350957AbiBCUMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:12:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70D1C061714;
        Thu,  3 Feb 2022 12:12:12 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id h23so3169173pgk.11;
        Thu, 03 Feb 2022 12:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+W+KjPt40snWKlcOiz5y4VMLU8RQSblS+FRo+YklbYo=;
        b=arM4wXQPQIqbNWzf3MS/S5hCXTZ94hUMEZQXR6L1SLSmdVpz+75kk+ZCtb3v4LxFdZ
         UiSohRLVcAdA1PjlhICP6pI+GgLwFfkCxbPEAOCZtqBLeVW0gpUnBJhMicjwtXoGG06e
         rOXtcGsvJzMA16ZhhFDccLMDJZdvJXqueBEOdupvpU48ExrLOqNWYYWWEhaah8V4qJt3
         xAFx++Cq3mauE8mVV7y03mZBlvp0HLCUOIFEUbNsKADNpTiKPk4lJZpoWvPcAwJfibD9
         EY/9zgItTo/d0qpoh3QeR7RuRmrD/ydRJe1D6y8X43bLoRNplh9XCEGKx2mXNLKpSDty
         qQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+W+KjPt40snWKlcOiz5y4VMLU8RQSblS+FRo+YklbYo=;
        b=Vn9Hky3hVd7K6RFRLPV9jL70dqfaezAQiZf/qSYg4+lNTBujdGzgPkvhovX3vPwIrk
         41cF5pE+BCnZcOrb7hf1PLRVxHNw6tfqWHMw7+tWgMDWui8Z1I5Q98etg25oni/Qdi0k
         g2gLE+LkBBuzNDODmd9sBtl8/ft0lC1LQpWg44EvWk1DancQEk8SyRQJ7DkkPJCpo3dN
         y0V8z1L1Gb6OL0MKRaF7faToEDuh/Um3+H6/DGoAq9dFNxQe0zrBRi37bV8edGvCm8uu
         GWNCjoT0+c4EmBdfGwTc6trAb6M/OVfIzvU5/jwd+ESuNboUY521Oh/QblXYGhmF0F8c
         9KjQ==
X-Gm-Message-State: AOAM533P/9fALbbi4/tEby2adka8crOa8gGZ1Jhsvdp884n/RkVR4Vjn
        BpCBMEU/xGPgDGjVC3nO5ys=
X-Google-Smtp-Source: ABdhPJywdOnD4uSlYBz32VRAwgXrN+9+mf99fmcszDbGJqPcxZdavp8IH+fWAcKgOh+Hrk7WwPqE6w==
X-Received: by 2002:a05:6a00:158c:: with SMTP id u12mr35425442pfk.18.1643919132308;
        Thu, 03 Feb 2022 12:12:12 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id nh18sm10727293pjb.18.2022.02.03.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:12:10 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     axboe@kernel.dk, hch@infradead.org, chaitanyak@nvidia.com,
        rostedt@goodmis.org, xiyou.wangcong@gmail.com
Cc:     shy828301@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v6 PATCH] block: introduce block_rq_error tracepoint
Date:   Thu,  3 Feb 2022 12:12:07 -0800
Message-Id: <20220203201207.1075933-1-shy828301@gmail.com>
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

So introduce a new tracepoint block_rq_error just for the error case.
With this patch, rasdaemon could switch to block_rq_error.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
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

 block/blk-mq.c               |  4 +++-
 include/trace/events/block.h | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3bf3358a3bb..4ca72ea917d4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -789,8 +789,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
+		     !(req->rq_flags & RQF_QUIET))) {
+		trace_block_rq_error(req, error, nr_bytes);
 		blk_print_req_error(req, error);
+	}
 
 	blk_account_io_completion(req, nr_bytes);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 27170e40e8c9..8c0bb06e16b8 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -144,6 +144,45 @@ TRACE_EVENT(block_rq_complete,
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
+	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes),
+
+	TP_STRUCT__entry(
+		__field(  dev_t,	dev			)
+		__field(  sector_t,	sector			)
+		__field(  unsigned int,	nr_sector		)
+		__field(  int,		error			)
+		__array(  char,		rwbs,	RWBS_LEN	)
+	),
+
+	TP_fast_assign(
+		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
+		__entry->sector    = blk_rq_pos(rq);
+		__entry->nr_sector = nr_bytes >> 9;
+		__entry->error     = blk_status_to_errno(error);
+
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
+	),
+
+	TP_printk("%d,%d %s %llu + %u [%d]",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->rwbs,
+		  (unsigned long long)__entry->sector,
+		  __entry->nr_sector, __entry->error)
+);
+
 DECLARE_EVENT_CLASS(block_rq,
 
 	TP_PROTO(struct request *rq),
-- 
2.26.3

