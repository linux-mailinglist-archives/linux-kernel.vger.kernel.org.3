Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE24A88ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352438AbiBCQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352257AbiBCQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:45:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F8CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:45:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so2164376wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6U7YdQVGA2YDGwsgkTnmQr3nQCNLxRAeMrGbxyU310=;
        b=0XuF/JGS5W8qkzma5i9WGPf31yOnDg4Ylqo4ISkoU/IijIll9Ymf3Td8QgD0+DmH0o
         sDoOH2il8HeN4WYLZlb1Plj59s9x6fvPOvbtozwkPU2aYwpEyhjezsrbj8kA0i3hoOGx
         tylG7ndZx1hzx6AXXef+3kj1EPL2RRxgL0sk4s6685tNFccloCAwQzWKjzw+1uBxhXsO
         Cwq7N1VZTwYZWHEKkRsSpCf+fWiZ5bNAWhC0FAaVXKztuVhg2l4izMROTTfQr5ZTl6JO
         C3PDQNGL2HWl3Gf+0mmccAwgzkf7N1T45DFS0awEToUo5CcWF2+SAghMZYLB+LUHJI1V
         aGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6U7YdQVGA2YDGwsgkTnmQr3nQCNLxRAeMrGbxyU310=;
        b=AzGjhLwocNpnBdOWM5b8SB7WiqamhStlU1lXoKE5nYoHg/lXscWPobfkFCyt5yqSYh
         e1CKEltVQueFhRF4SoToCqm6XR6piZtCiuSvSAiFSxwMAL4ZAFCUIY5qgP8Jy8hXKmMK
         x5DRMi2rgjc3Kn2TOiHFwKC7QJ0Xe0HtDcYBd9uXcjqLDONZuIPRWFlYSCKZsFJ/UZxt
         3/7SFhaOkrXcpUv/VXZIiZ7J9oQcVz1NGF16nCogveZs/RqeVim6tIobnkJ75eExMCL5
         zGJKI32bDqQEGvesAE08TgQ6yGgtMuJFoZ3qF8/VFDKqA5DUr/p+wt8qj1DXk+Q0BMM8
         6M2Q==
X-Gm-Message-State: AOAM53188KTNiVjVuqEXaz/VCETOKb/zQ1FlrOdXMh7pCsEQOHFNT+7x
        K6alfYbiiV2VSyLZtmHzcrphjw==
X-Google-Smtp-Source: ABdhPJyhbFlaAl5r8+IIntVrV4V0/fEuqNg0yeotDlykZSJOMt2gxlgKbxy4VqszArLK1r8LlHt2Pw==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr10891990wml.34.1643906709375;
        Thu, 03 Feb 2022 08:45:09 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:28c2:5854:c832:e580])
        by smtp.gmail.com with ESMTPSA id n14sm21412831wri.80.2022.02.03.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:45:09 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v2 3/3] io_uring: avoid ring quiesce for IORING_REGISTER_EVENTFD_ASYNC
Date:   Thu,  3 Feb 2022 16:45:03 +0000
Message-Id: <20220203164503.641574-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203164503.641574-1-usama.arif@bytedance.com>
References: <20220203164503.641574-1-usama.arif@bytedance.com>
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
index 9b6ee3b8b9f2..05fd059b3f1e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -329,6 +329,7 @@ struct io_submit_state {
 struct io_ev_fd {
 	struct eventfd_ctx	*cq_ev_fd;
 	struct io_ring_ctx	*ctx;
+	unsigned int		eventfd_async: 1;
 	struct rcu_head		rcu;
 };
 
@@ -341,7 +342,6 @@ struct io_ring_ctx {
 		unsigned int		flags;
 		unsigned int		compat: 1;
 		unsigned int		drain_next: 1;
-		unsigned int		eventfd_async: 1;
 		unsigned int		restricted: 1;
 		unsigned int		off_timeout_used: 1;
 		unsigned int		drain_active: 1;
@@ -1747,7 +1747,7 @@ static void io_eventfd_signal(struct io_ring_ctx *ctx)
 	if (READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
 		goto out;
 
-	if (!ctx->eventfd_async || io_wq_current_is_worker())
+	if (!ev_fd->eventfd_async || io_wq_current_is_worker())
 		eventfd_signal(ev_fd->cq_ev_fd, 1);
 
 out:
@@ -9368,7 +9368,8 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 	return done ? done : err;
 }
 
-static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
+static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg,
+			       unsigned int eventfd_async)
 {
 	struct io_ev_fd *ev_fd;
 	__s32 __user *fds = arg;
@@ -9395,6 +9396,7 @@ static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
 		goto out;
 	}
 	ev_fd->ctx = ctx;
+	ev_fd->eventfd_async = eventfd_async;
 
 	rcu_assign_pointer(ctx->io_ev_fd, ev_fd);
 	ret = 0;
@@ -11010,6 +11012,7 @@ static bool io_register_op_must_quiesce(int op)
 	case IORING_UNREGISTER_FILES:
 	case IORING_REGISTER_FILES_UPDATE:
 	case IORING_REGISTER_EVENTFD:
+	case IORING_REGISTER_EVENTFD_ASYNC:
 	case IORING_UNREGISTER_EVENTFD:
 	case IORING_REGISTER_PROBE:
 	case IORING_REGISTER_PERSONALITY:
@@ -11110,17 +11113,16 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
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

