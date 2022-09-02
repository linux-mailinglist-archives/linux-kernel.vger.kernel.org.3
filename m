Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBD5AA4CB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiIBBBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiIBBBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:01:08 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF1BA61EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:01:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.38.99])
        by gnuweeb.org (Postfix) with ESMTPSA id 5405880C14;
        Fri,  2 Sep 2022 01:00:57 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662080461;
        bh=TNBQyUndOwcKgHkPQpPb2W5jDyTNkUXpBwq2t+iephY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkimsktItTYLJPUPpfZI3v4cKtooxKWxJsVWk1YNrTRdA8tDT9V7gZ0kII3y7FwBP
         t8Sm2cl6/pdVDZGOJSNah2yH+eF7XPh/YTBXHWZus21kp8W/DMFbu6lgbJcG0QxMT2
         Sk/ZTB94Cr9aGYWSaikJ2m8fEQMTs9euhZqf4/iV0tcacx2xU1gHajauyuzLl6aal0
         kCoBDi4Arv3TZXh87K9lSQaoj+uWuN9qzOY7Egwm2MjOopvf0VuCe8GnUP9r8wf7K/
         qPai9HDiue1wCBekbHNqR2F3SOU3+ZX2Vv3yHeo3P+HK03/bERMK5FwUOoLrZUwCNK
         gv9y8qsyb/T8A==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Dylan Yudaken <dylany@fb.com>,
        Facebook Kernel Team <kernel-team@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH liburing v1 10/12] t/recv-msgall: Don't use a static port number
Date:   Fri,  2 Sep 2022 07:59:44 +0700
Message-Id: <20220902005825.2484023-11-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902005825.2484023-1-ammar.faizi@intel.com>
References: <20220902005825.2484023-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Don't use a static port number. It might already be in use, resulting
in a test failure. Use an ephemeral port to make this test reliable.

Cc: Dylan Yudaken <dylany@fb.com>
Cc: Facebook Kernel Team <kernel-team@fb.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 test/recv-msgall.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/test/recv-msgall.c b/test/recv-msgall.c
index a6f7cfc..ae123e4 100644
--- a/test/recv-msgall.c
+++ b/test/recv-msgall.c
@@ -6,57 +6,55 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <arpa/inet.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <pthread.h>
 
 #include "liburing.h"
 #include "helpers.h"
 
 #define MAX_MSG	128
-
-#define PORT	10201
 #define HOST	"127.0.0.1"
+static __be16 bind_port;
 
 static int recv_prep(struct io_uring *ring, struct iovec *iov, int *sock,
 		     int use_recvmsg)
 {
 	struct sockaddr_in saddr;
 	struct io_uring_sqe *sqe;
 	int sockfd, ret, val;
 	struct msghdr msg = { };
 
 	memset(&saddr, 0, sizeof(saddr));
 	saddr.sin_family = AF_INET;
 	saddr.sin_addr.s_addr = htonl(INADDR_ANY);
-	saddr.sin_port = htons(PORT);
 
 	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
 	if (sockfd < 0) {
 		perror("socket");
 		return 1;
 	}
 
 	val = 1;
 	setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
 
-	ret = bind(sockfd, (struct sockaddr *)&saddr, sizeof(saddr));
-	if (ret < 0) {
+	if (t_bind_ephemeral_port(sockfd, &saddr)) {
 		perror("bind");
 		goto err;
 	}
+	bind_port = saddr.sin_port;
 
 	sqe = io_uring_get_sqe(ring);
 	if (!use_recvmsg) {
 		io_uring_prep_recv(sqe, sockfd, iov->iov_base, iov->iov_len,
 					MSG_WAITALL);
 	} else {
 		msg.msg_namelen = sizeof(struct sockaddr_in);
 		msg.msg_iov = iov;
 		msg.msg_iovlen = 1;
 		io_uring_prep_recvmsg(sqe, sockfd, &msg, MSG_WAITALL);
 	}
 
 	sqe->user_data = 2;
@@ -155,27 +153,27 @@ static int do_send(void)
 
 	ret = io_uring_queue_init(2, &ring, 0);
 	if (ret) {
 		fprintf(stderr, "queue init failed: %d\n", ret);
 		return 1;
 	}
 
 	buf = malloc(MAX_MSG * sizeof(int));
 	for (i = 0; i < MAX_MSG; i++)
 		buf[i] = i;
 
 	memset(&saddr, 0, sizeof(saddr));
 	saddr.sin_family = AF_INET;
-	saddr.sin_port = htons(PORT);
+	saddr.sin_port = bind_port;
 	inet_pton(AF_INET, HOST, &saddr.sin_addr);
 
 	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
 	if (sockfd < 0) {
 		perror("socket");
 		return 1;
 	}
 
 	ret = connect(sockfd, (struct sockaddr *)&saddr, sizeof(saddr));
 	if (ret < 0) {
 		perror("connect");
 		return 1;
 	}
-- 
Ammar Faizi

