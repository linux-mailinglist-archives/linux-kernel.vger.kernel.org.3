Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F30C4A8B90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiBCSY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353466AbiBCSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:24:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693FBC061741
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:24:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so4173307wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nbb/JonlYt2gwQTccH2YTHZ8fFvVyRbc8c63+KA/SXs=;
        b=tIGn+9IvEdbkXn5xnNLy09gK3SY2EFeBj/BT39em5zIXMjreIH0iirlTjng4muT1re
         iqgntSWn1lpNoVerckRjRAvdhLtLuHRymFX88dZi47LvqLyQFnGVfmf1H0AyReqDmx/n
         BVQvPiqTc63TJTO75Y/SmZrRXGCWz1QEGbVZA/VP7r91FFphT1FX9pS2MWkuZR5viui8
         fpvguOV37Xq9Zlxlqm6EsKxFrhCtXzdLEUtPO6EUUEkETmysOeQiRlj1Aaslysc0afL3
         tJgWWVpfWQEF+juElhCDyExWrDjLzjJ9YwYnXInIhchz30cDe92A1MC2PQWwdAuM+NOI
         aR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nbb/JonlYt2gwQTccH2YTHZ8fFvVyRbc8c63+KA/SXs=;
        b=OdNsDgCj/J4A0hhUz0Oe6KJGgJnuLvdfej09CdrkUq1ADr/IP1prWeThy4LBzyA/2Y
         fCTH+A0C7DJ/kGLWqQR6WVGeeDagG7DwwLy4TzOJYDqU8CzgzLZfdU0CfHmgbPm4udIT
         jaABShN6AGSm7oYtu/h++mhpGGc4zNg+F6aUBgKrcrxuQ2iXe4OZ/gn3JBL6llPVjPnm
         zSaaNLPD3d8KWcmObYfGw0pHysVTTIdhAtxEuslkMDnN6LMHs6GZb5mKJM4Qm1VhQbLW
         qY3QQqUBFNN86RXLFHYwO1TS3DpQUt2AfY2yWLORO25D70y66NO/fww9oVrpP7KuzmGR
         mD4w==
X-Gm-Message-State: AOAM533dqjj6CMGw18sy3ycv/mBqG9XKwuagPkhIjZrQ9enDOAGbj8Fy
        UbHOyvq4COyQvaf9Xq55Il3TqQ==
X-Google-Smtp-Source: ABdhPJy8kFjgZA7GepNZjH7o49H9W94lbEP8JvFAcXl7hMwg0rlZPQMT0bcsqkgE3yBPSknYYP+iTA==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr11511762wmh.3.1643912687002;
        Thu, 03 Feb 2022 10:24:47 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:28c2:5854:c832:e580])
        by smtp.gmail.com with ESMTPSA id h18sm3540056wro.9.2022.02.03.10.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:24:46 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v4 3/3] io_uring: avoid ring quiesce for IORING_REGISTER_EVENTFD_ASYNC
Date:   Thu,  3 Feb 2022 18:24:41 +0000
Message-Id: <20220203182441.692354-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203182441.692354-1-usama.arif@bytedance.com>
References: <20220203182441.692354-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done using the RCU data structure (io_ev_fd). eventfd_async
is moved from io_ring_ctx to io_ev_fd which is RCU protected hence
avoiding ring quiesce which is much more expensive than an RCU lock.
io_should_trigger_evfd is already under rcu_read_lock so there is
no extra RCU read-side critical section needed.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 fs/io_uring.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7a8f4ac7a785..e287fc61879f 100644
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
@@ -9398,6 +9399,7 @@ static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
 		goto out;
 	}
 	ev_fd->ctx = ctx;
+	ev_fd->eventfd_async = eventfd_async;
 
 	rcu_assign_pointer(ctx->io_ev_fd, ev_fd);
 	ret = 0;
@@ -11013,6 +11015,7 @@ static bool io_register_op_must_quiesce(int op)
 	case IORING_UNREGISTER_FILES:
 	case IORING_REGISTER_FILES_UPDATE:
 	case IORING_REGISTER_EVENTFD:
+	case IORING_REGISTER_EVENTFD_ASYNC:
 	case IORING_UNREGISTER_EVENTFD:
 	case IORING_REGISTER_PROBE:
 	case IORING_REGISTER_PERSONALITY:
@@ -11113,17 +11116,16 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
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

