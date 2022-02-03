Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E224A8A53
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352981AbiBCRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbiBCRlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:41:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1D7C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:41:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso2258681wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/kvsV2Fw6mBqvpDjxp3WYmDCchAjKBAAZ5SIZ3OfkM=;
        b=HSHMAONT3deohB+I/1UzVSnGmWqMvf0TxOrRDOPXl8HIJP1aLazsZcbqKflRKAvb2A
         R2z/8/lvXFscxa41tBF8xizb6oVHc6dxTYqNI80uIyYqKkXZGOoZ2he5zeWTk0Ld3XYE
         tJJPFb2EPPL+r/6FT2s4ofAZb1kJCKsXQ1GU7uJx4shOWROF9uNmf/AZu8bamDoehVPq
         s/YegMHV0i9lzc+3r3tTXZsCbmj1ImMa2BqCAukz/lPEs7X8z2JWkEJFAvT/CAWIj1cX
         5s4dGh9HV8r7TOZt4cjo5xbqm6eNQiTd6ogQyCQelxppN67Y2b8ELsu7B+X+tYZr9jji
         nyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/kvsV2Fw6mBqvpDjxp3WYmDCchAjKBAAZ5SIZ3OfkM=;
        b=p9EMG6rqQhvBuYTo+LL8gKxTyX+nP7b+w8WuwQ9JEe3BRs3K933WkdTiMjzRupHq1D
         J3xOHYvBT/1eeIICf7wB4dbvIl/S1W14m/9MD1te/FBNrslDNi2gK9V/pCDwV0ijZe2/
         hh5t1Km0dvJdXvDhlpeVTPk8cNcBD4rEKh3T1FLOyVMZP0jgzPTqvVHOGGNNriObTQyG
         BoJbeG8GJ7uFfvpmQhguubOxr0pA4u7ZQqB9iC2ap0mLa2sL1CuD7NXs8ZQ+I7WRyIS1
         p2CEzNHgUhGwsOVH4RRAYdB/3vyxkCI40VA3LO7yy0kFsi25Q3Yv/JeDHDrSCchi6OXv
         mLEA==
X-Gm-Message-State: AOAM53280DLdXgU6EBv/hyLdzx51RLxahgwRm5wX8CKDxqcwRzkvPOmP
        OVg0097pSbqWyAI+nncQ+otJg1oU6CiNyg==
X-Google-Smtp-Source: ABdhPJwWFRMw0lDUQQC1/c9xp6DLHWvF0Qfeqznn5fUQXhGw/hQhtPgHachc3tQSajCxF+5JhCLOQQ==
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr11612148wmi.95.1643910073272;
        Thu, 03 Feb 2022 09:41:13 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:28c2:5854:c832:e580])
        by smtp.gmail.com with ESMTPSA id r2sm10166178wmq.24.2022.02.03.09.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:41:12 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v3 1/3] io_uring: remove trace for eventfd
Date:   Thu,  3 Feb 2022 17:41:06 +0000
Message-Id: <20220203174108.668549-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174108.668549-1-usama.arif@bytedance.com>
References: <20220203174108.668549-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The information on whether eventfd is registered is not very useful
and would result in the tracepoint being enclosed in an rcu_readlock
in a later patch that tries to avoid ring quiesce for registering
eventfd.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 fs/io_uring.c                   |  3 +--
 include/trace/events/io_uring.h | 13 +++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2e04f718319d..21531609a9c6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -11171,8 +11171,7 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 	mutex_lock(&ctx->uring_lock);
 	ret = __io_uring_register(ctx, opcode, arg, nr_args);
 	mutex_unlock(&ctx->uring_lock);
-	trace_io_uring_register(ctx, opcode, ctx->nr_user_files, ctx->nr_user_bufs,
-							ctx->cq_ev_fd != NULL, ret);
+	trace_io_uring_register(ctx, opcode, ctx->nr_user_files, ctx->nr_user_bufs, ret);
 out_fput:
 	fdput(f);
 	return ret;
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index 7346f0164cf4..098beda7601a 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -57,10 +57,9 @@ TRACE_EVENT(io_uring_create,
  * @opcode:		describes which operation to perform
  * @nr_user_files:	number of registered files
  * @nr_user_bufs:	number of registered buffers
- * @cq_ev_fd:		whether eventfs registered or not
  * @ret:		return code
  *
- * Allows to trace fixed files/buffers/eventfds, that could be registered to
+ * Allows to trace fixed files/buffers, that could be registered to
  * avoid an overhead of getting references to them for every operation. This
  * event, together with io_uring_file_get, can provide a full picture of how
  * much overhead one can reduce via fixing.
@@ -68,16 +67,15 @@ TRACE_EVENT(io_uring_create,
 TRACE_EVENT(io_uring_register,
 
 	TP_PROTO(void *ctx, unsigned opcode, unsigned nr_files,
-			 unsigned nr_bufs, bool eventfd, long ret),
+			 unsigned nr_bufs, long ret),
 
-	TP_ARGS(ctx, opcode, nr_files, nr_bufs, eventfd, ret),
+	TP_ARGS(ctx, opcode, nr_files, nr_bufs, ret),
 
 	TP_STRUCT__entry (
 		__field(  void *,	ctx			)
 		__field(  unsigned,	opcode		)
 		__field(  unsigned,	nr_files	)
 		__field(  unsigned,	nr_bufs		)
-		__field(  bool,		eventfd		)
 		__field(  long,		ret			)
 	),
 
@@ -86,14 +84,13 @@ TRACE_EVENT(io_uring_register,
 		__entry->opcode		= opcode;
 		__entry->nr_files	= nr_files;
 		__entry->nr_bufs	= nr_bufs;
-		__entry->eventfd	= eventfd;
 		__entry->ret		= ret;
 	),
 
 	TP_printk("ring %p, opcode %d, nr_user_files %d, nr_user_bufs %d, "
-			  "eventfd %d, ret %ld",
+			  "ret %ld",
 			  __entry->ctx, __entry->opcode, __entry->nr_files,
-			  __entry->nr_bufs, __entry->eventfd, __entry->ret)
+			  __entry->nr_bufs, __entry->ret)
 );
 
 /**
-- 
2.25.1

