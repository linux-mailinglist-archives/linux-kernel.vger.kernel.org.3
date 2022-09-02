Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028285AA4CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiIBBCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiIBBBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:01:19 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DFF5C96C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:01:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.38.99])
        by gnuweeb.org (Postfix) with ESMTPSA id F1B2380C16;
        Fri,  2 Sep 2022 01:01:05 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662080469;
        bh=RiGcPlW7X5CDPS5LPqUVDno+6lkfchw25Ov8zg/eK2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoUql9LkgYcAm+0y+mjw3rUXNVwusfgQAofhZsEAFT0cnn92Sq1oUZdQh1qmNA0PH
         c0qro7M4kavlspo7qNstNK3J9sJlnrx6MJlSEx9qHHZykAAIbo8TPVq5ApaaVOHmMm
         kfmiGYF0q9QiNUX4Uonoq0YRIvsQf/CJhsGwd0IInyX6EWfMg0hiz2IzhSke8nF2LP
         nsXRHECK/G4CCQG76F6L8TlSQKaXVCikPRUqTVayrefXufRqjUtMmHAIcY3cAU8wGH
         LYLvgNklTveQgWKM+aXsfr83aZCtG09zSxZAdU7/AgWDNalrJ0aNUZukTQdQtIZgsa
         dxfGSa11nEAqA==
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
Subject: [PATCH liburing v1 12/12] t/recv-msgall-stream: Don't use a static port number
Date:   Fri,  2 Sep 2022 07:59:46 +0700
Message-Id: <20220902005825.2484023-13-ammar.faizi@intel.com>
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
 test/recv-msgall-stream.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/test/recv-msgall-stream.c b/test/recv-msgall-stream.c
index a188cc1..65b4d22 100644
--- a/test/recv-msgall-stream.c
+++ b/test/recv-msgall-stream.c
@@ -1,68 +1,66 @@
 /* SPDX-License-Identifier: MIT */
 /*
  * Test MSG_WAITALL for recv/recvmsg and include normal sync versions just
  * for comparison.
  */
+#include <assert.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <arpa/inet.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <pthread.h>
 
 #include "liburing.h"
 #include "helpers.h"
 
 #define MAX_MSG	128
 
-static int port = 31200;
-
 struct recv_data {
 	pthread_mutex_t mutex;
 	int use_recvmsg;
 	int use_sync;
-	int port;
+	__be16 port;
 };
 
 static int get_conn_sock(struct recv_data *rd, int *sockout)
 {
 	struct sockaddr_in saddr;
 	int sockfd, ret, val;
 
 	memset(&saddr, 0, sizeof(saddr));
 	saddr.sin_family = AF_INET;
 	saddr.sin_addr.s_addr = htonl(INADDR_ANY);
-	saddr.sin_port = htons(rd->port);
 
 	sockfd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
 	if (sockfd < 0) {
 		perror("socket");
 		goto err;
 	}
 
 	val = 1;
 	setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
 	setsockopt(sockfd, SOL_SOCKET, SO_REUSEPORT, &val, sizeof(val));
 
-	ret = bind(sockfd, (struct sockaddr *)&saddr, sizeof(saddr));
-	if (ret < 0) {
+	if (t_bind_ephemeral_port(sockfd, &saddr)) {
 		perror("bind");
 		goto err;
 	}
+	rd->port = saddr.sin_port;
 
 	ret = listen(sockfd, 16);
 	if (ret < 0) {
 		perror("listen");
 		goto err;
 	}
 
 	pthread_mutex_unlock(&rd->mutex);
 
 	ret = accept(sockfd, NULL, NULL);
 	if (ret < 0) {
 		perror("accept");
 		return -1;
@@ -269,38 +267,38 @@ static int do_send(struct recv_data *rd)
 	struct iovec iov;
 	int *buf;
 
 	ret = io_uring_queue_init(2, &ring, 0);
 	if (ret) {
 		fprintf(stderr, "queue init failed: %d\n", ret);
 		return 1;
 	}
 
 	buf = malloc(MAX_MSG * sizeof(int));
 	for (i = 0; i < MAX_MSG; i++)
 		buf[i] = i;
 
-	memset(&saddr, 0, sizeof(saddr));
-	saddr.sin_family = AF_INET;
-	saddr.sin_port = htons(rd->port);
-	inet_pton(AF_INET, "127.0.0.1", &saddr.sin_addr);
-
 	sockfd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
 	if (sockfd < 0) {
 		perror("socket");
 		return 1;
 	}
 
 	pthread_mutex_lock(&rd->mutex);
+	assert(rd->port != 0);
+	memset(&saddr, 0, sizeof(saddr));
+	saddr.sin_family = AF_INET;
+	saddr.sin_port = rd->port;
+	inet_pton(AF_INET, "127.0.0.1", &saddr.sin_addr);
 
 	ret = connect(sockfd, (struct sockaddr *)&saddr, sizeof(saddr));
 	if (ret < 0) {
 		perror("connect");
 		return 1;
 	}
 
 	iov.iov_base = buf;
 	iov.iov_len = MAX_MSG * sizeof(int) / 2;
 	for (i = 0; i < 2; i++) {
 		sqe = io_uring_get_sqe(&ring);
 		io_uring_prep_send(sqe, sockfd, iov.iov_base, iov.iov_len, 0);
 		sqe->user_data = 1;
@@ -341,27 +339,27 @@ static int test(int use_recvmsg, int use_sync)
 {
 	pthread_mutexattr_t attr;
 	pthread_t recv_thread;
 	struct recv_data rd;
 	int ret;
 	void *retval;
 
 	pthread_mutexattr_init(&attr);
 	pthread_mutexattr_setpshared(&attr, 1);
 	pthread_mutex_init(&rd.mutex, &attr);
 	pthread_mutex_lock(&rd.mutex);
 	rd.use_recvmsg = use_recvmsg;
 	rd.use_sync = use_sync;
-	rd.port = port++;
+	rd.port = 0;
 
 	ret = pthread_create(&recv_thread, NULL, recv_fn, &rd);
 	if (ret) {
 		fprintf(stderr, "Thread create failed: %d\n", ret);
 		pthread_mutex_unlock(&rd.mutex);
 		return 1;
 	}
 
 	do_send(&rd);
 	pthread_join(recv_thread, &retval);
 	return (intptr_t)retval;
 }
 
-- 
Ammar Faizi

