Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3406249D210
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiAZSwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiAZSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:51:57 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A0CC06161C;
        Wed, 26 Jan 2022 10:51:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i1so372915pla.9;
        Wed, 26 Jan 2022 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hN/zscizeagYqc1YwpHK4gnib72tfXtcXVHqyf91tI=;
        b=UcQ2ObtAnYF8FUfSzd2JBfMjhbcsS8XGWgsXNl9SOd95xoYqVjmRX3d0hihGMVhBY2
         nJYMsLIGpL/H73HYBJQMLRQctV1DlzX/+f8XAbdXK4GmOvXPzdxt2jyllcyPQfMj05YA
         o2oc0zArFju6Jysk6+tyFVNGpR6J4pb7P1/qxhiTqfZHAksy1cXj5E6h5mYbMOv6M17u
         ebV1bKkz2wwRinusbFbvb1GCmTPiX0lg//P9H00ix4Z9FTh0ESZntlc2YApAt9FCkaxy
         pnkUuPRLPOedxsWR6aaUGkfzznI7kYuc30wxwOPnhYySuWrPEUGGoxOzw+aylYN/Q+uO
         7FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hN/zscizeagYqc1YwpHK4gnib72tfXtcXVHqyf91tI=;
        b=sfUssVkuzqDugtuKo7wJLekGWgq/JBFcA4wFwZAkTOBcDBt27iE2d94D7mu9PQAxNx
         vXF1H/eHLXbuwqCRHaqTaoPt0n37j3uGCQGSZztuzhGcS7Zmcl3q3+QwhPeWDs3HXkZz
         TK0/CAdla8uUIWAAfLNxfpN73WLvQD409ckThBtENCG5aqN2RFY67mrJ/iThjhNPqRKS
         IC0yBK3F2IOq5YHZH7ubMT3leeSHxlSNNCiQpFo2WGNEZWhQYSghxB6SC3daSPgQIR9D
         2+sQClZzbBGNpRviTdn44UEm+09vcDEvBKW3QDsxP0aY+q6fqXsJYwwtZV9KeHb4cM1S
         7bOg==
X-Gm-Message-State: AOAM533nFdOQ98233HEoOeWMTgEoiTrdrYciFCm/OB9RTbuhbiwAKayn
        ZXLxqG2SH2qyRBEPdv613U4tQ9D9gfc=
X-Google-Smtp-Source: ABdhPJxhDOFWgabpI4YJhuE8FdpHc3Aqb7IBjFasp6maPHczfi/QOl/6e0jNBoS/ZZ+P055gIuf0kg==
X-Received: by 2002:a17:90a:74c2:: with SMTP id p2mr242102pjl.155.1643223116840;
        Wed, 26 Jan 2022 10:51:56 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id mj23sm10293pjb.54.2022.01.26.10.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:51:55 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     axboe@kernel.dk, hch@infradead.org, rostedt@goodmis.org,
        xiyou.wangcong@gmail.com
Cc:     shy828301@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v5 PATCH] block: introduce block_rq_error tracepoint
Date:   Wed, 26 Jan 2022 10:51:53 -0800
Message-Id: <20220126185153.417948-1-shy828301@gmail.com>
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
Cc: Christoph Hellwig <hch@infradead.org>
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

v4 --> v5:
 * Report the actual block layer status code instead of the errno per
   Christoph Hellwig.
v3 --> v4:
 * Rebased to v5.17-rc1.
 * Collected reviewed-by tag from Steven.

 block/blk-mq.c               |  4 +++-
 include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

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
index 27170e40e8c9..918b190718d5 100644
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
+	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
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
+		__entry->error     = blk_status_to_errno(error);
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

