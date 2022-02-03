Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDC4A8A55
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352997AbiBCRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiBCRlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:41:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70601C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:41:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l25so6418607wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQ5jnJGIVwxZ5qUgziHdkflPhGPqIybpU+uC+PzwvsQ=;
        b=Dll/nIYHPPorabZIeb2zcK9wrw6PrJReK2x+wyx0LGKxKghUbxhsKrVZB9J5lvFBJ0
         JNyrgS+dZhrU55ZQGKJ7Zl3m25t7qLXIdTmqQV4JT8iRc9X40KczseYqG5zioGLBkUcb
         FhCKE6CmBOBuZhRN2+MoOURzUTX6a2mNZBl2Lw8zs8ybb3U2Xv+yMlMfBmR4pB0JlG6l
         RaDVlWXkOGBsxjPRoPGoRPgoSUzg5168V2bGcCSgGwYZlzYDjdcfXqhZe8L3sjqyW0zm
         w40IxUF7+bCGVT5BDWKopH1+gjNnNO+399jICtNXlvO795pPdJf66iDEIkFTSk9gih6S
         llXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQ5jnJGIVwxZ5qUgziHdkflPhGPqIybpU+uC+PzwvsQ=;
        b=CBunaVHZmnoAVr6ABwdP4rpwPCMeKmLx/nrLWG3zaGOS9JNg0SgY78s3VYOjOsG49u
         YL8C1I9vsHyEaQJXZgJYnO/cEXYz8dq5zGA1NVJeJH0+nvTZBnV0QwrVs9q3MYwJzQ+S
         IRZHsoi5QtOX47PNYQIZXYmjjp//oxM2ee2Sz7yAG/sl2nTdKbu/lsfALA3de98vnT6z
         0KaMBRzseldt4cssXIvfDsAnrcvfP7Bmn4eEttlPbWZxCu706dBTz28RYxfmaesEJD/i
         KiDFYt+VuOKWspuU0sGVmQS1SFQx4ouXzkQbH4tPP3qEIN/r88lbVM87cHsXF+dHAWd4
         k+Ig==
X-Gm-Message-State: AOAM531wY7XuxI7uC2UMbO14ewz03BCf1XvGDvR4F22G0OCI9K7Y/4Pl
        R+sT4/3YbDwpjY54jCNV/TGJhQ==
X-Google-Smtp-Source: ABdhPJzo42krRzhRX1nmGY1EuVoNe1Ug1QCeiMYhQz0Rphzf7vm7SwyV2IIvvbkTFEx7mrMPtfnrLw==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr28671051wrm.119.1643910075079;
        Thu, 03 Feb 2022 09:41:15 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:28c2:5854:c832:e580])
        by smtp.gmail.com with ESMTPSA id r2sm10166178wmq.24.2022.02.03.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:41:14 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v3 3/3] io_uring: avoid ring quiesce for IORING_REGISTER_EVENTFD_ASYNC
Date:   Thu,  3 Feb 2022 17:41:08 +0000
Message-Id: <20220203174108.668549-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174108.668549-1-usama.arif@bytedance.com>
References: <20220203174108.668549-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done using the RCU data structure (io_ev_fd). eventfd_async
is moved from io_ring_ctx to io_ev_fd which is RCU protected hence
avoiding ring quiesce which is much more expensive than an RCU lock.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 fs/io_uring.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 47d48020ae27..25ed86533910 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -328,6 +328,7 @@ struct io_submit_state {
 
 struct io_ev_fd {
 	struct eventfd_ctx	*cq_ev_fd;
+	unsigned int		eventfd_async: 1;
 };
 
 struct io_ring_ctx {
@@ -339,7 +340,6 @@ struct io_ring_ctx {
 		unsigned int		flags;
 		unsigned int		compat: 1;
 		unsigned int		drain_next: 1;
-		unsigned int		eventfd_async: 1;
 		unsigned int		restricted: 1;
 		unsigned int		off_timeout_used: 1;
 		unsigned int		drain_active: 1;
@@ -1745,7 +1745,7 @@ static void io_eventfd_signal(struct io_ring_ctx *ctx)
 	if (READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
 		goto out;
 
-	if (!ctx->eventfd_async || io_wq_current_is_worker())
+	if (!ev_fd->eventfd_async || io_wq_current_is_worker())
 		eventfd_signal(ev_fd->cq_ev_fd, 1);
 
 out:
@@ -9366,7 +9366,8 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 	return done ? done : err;
 }
 
-static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
+static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg,
+			       unsigned int eventfd_async)
 {
 	struct io_ev_fd *ev_fd;
 	__s32 __user *fds = arg;
@@ -9392,6 +9393,7 @@ static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
 		kfree(ev_fd);
 		goto out;
 	}
+	ev_fd->eventfd_async = eventfd_async;
 
 	rcu_assign_pointer(ctx->io_ev_fd, ev_fd);
 	ret = 0;
@@ -11000,6 +11002,7 @@ static bool io_register_op_must_quiesce(int op)
 	case IORING_UNREGISTER_FILES:
 	case IORING_REGISTER_FILES_UPDATE:
 	case IORING_REGISTER_EVENTFD:
+	case IORING_REGISTER_EVENTFD_ASYNC:
 	case IORING_UNREGISTER_EVENTFD:
 	case IORING_REGISTER_PROBE:
 	case IORING_REGISTER_PERSONALITY:
@@ -11100,17 +11103,16 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 		ret = io_register_files_update(ctx, arg, nr_args);
 		break;
 	case IORING_REGISTER_EVENTFD:
-	case IORING_REGISTER_EVENTFD_ASYNC:
 		ret = -EINVAL;
 		if (nr_args != 1)
 			break;
-		ret = io_eventfd_register(ctx, arg);
-		if (ret)
+		ret = io_eventfd_register(ctx, arg, 0);
+		break;
+	case IORING_REGISTER_EVENTFD_ASYNC:
+		ret = -EINVAL;
+		if (nr_args != 1)
 			break;
-		if (opcode == IORING_REGISTER_EVENTFD_ASYNC)
-			ctx->eventfd_async = 1;
-		else
-			ctx->eventfd_async = 0;
+		ret = io_eventfd_register(ctx, arg, 1);
 		break;
 	case IORING_UNREGISTER_EVENTFD:
 		ret = -EINVAL;
-- 
2.25.1

