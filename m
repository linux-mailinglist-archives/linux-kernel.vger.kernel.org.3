Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF895AA4C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiIBBAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiIBBA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:00:27 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0247BB3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:00:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.38.99])
        by gnuweeb.org (Postfix) with ESMTPSA id 5C5AD80C0C;
        Fri,  2 Sep 2022 01:00:22 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662080426;
        bh=O+bQx1dVeJn2RzOj49n3WMYCD9Vph/X1is42mAcoHoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqYCo+8x8PKijRKVwSGBuWz3Gh/vMusuucmB2o62U2GfeYyUjf8RqkSfi9BtIF5SS
         xLASi+hLMStOoDXS6/9pje40C1NXxnZaBrDOYAzfK+snLZrOgqhY2erCB3Qfbf1ODZ
         Z+EbeC2teDZFkUj6B3l5wwZr8S1cfFPN3IUhddORZETQPA9nG2NSopmKqBSIZOe1L3
         3wKDigjQFbcIjFft0J1mZpsuI56BAXW7A930ihTm0YzYXlpnv/dSqwyKUFd7vNKotJ
         DeOrCMGcB1IcJ9jpuhQEQD54QznqIddrK8KCTABezgw33Qvmz8rXyV55T1Kw+R9pIl
         FewQX9Y6WkAFw==
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
Subject: [PATCH liburing v1 02/12] t/poll-link: Don't brute force the port number
Date:   Fri,  2 Sep 2022 07:59:36 +0700
Message-Id: <20220902005825.2484023-3-ammar.faizi@intel.com>
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

Don't brute force the port number, use `t_bind_ephemeral_port()`,
much simpler and reliable for choosing a port number that is not
in use.

Cc: Dylan Yudaken <dylany@fb.com>
Cc: Facebook Kernel Team <kernel-team@fb.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 test/poll-link.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/test/poll-link.c b/test/poll-link.c
index 197ad77..a6fe0de 100644
--- a/test/poll-link.c
+++ b/test/poll-link.c
@@ -3,26 +3,27 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
 #include <fcntl.h>
 #include <assert.h>
 #include <pthread.h>
 #include <sys/socket.h>
 #include <netinet/tcp.h>
 #include <netinet/in.h>
 #include <poll.h>
 #include <arpa/inet.h>
 
+#include "helpers.h"
 #include "liburing.h"
 
 pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 
 static int recv_thread_ready = 0;
 static int recv_thread_done = 0;
 
 static void signal_var(int *var)
 {
         pthread_mutex_lock(&mutex);
         *var = 1;
         pthread_cond_signal(&cond);
@@ -79,47 +80,39 @@ void *recv_thread(void *arg)
 
 	ret = io_uring_queue_init(8, &ring, 0);
 	assert(ret == 0);
 
 	int s0 = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
 	assert(s0 != -1);
 
 	int32_t val = 1;
 	ret = setsockopt(s0, SOL_SOCKET, SO_REUSEPORT, &val, sizeof(val));
 	assert(ret != -1);
 	ret = setsockopt(s0, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
 	assert(ret != -1);
 
-	struct sockaddr_in addr;
+	struct sockaddr_in addr = { };
 
 	addr.sin_family = AF_INET;
 	data->addr = inet_addr("127.0.0.1");
 	addr.sin_addr.s_addr = data->addr;
 
-	i = 0;
-	do {
-		data->port = htons(1025 + (rand() % 64510));
-		addr.sin_port = data->port;
-
-		if (bind(s0, (struct sockaddr*)&addr, sizeof(addr)) != -1)
-			break;
-	} while (++i < 100);
-
-	if (i >= 100) {
-		fprintf(stderr, "Can't find good port, skipped\n");
+	if (t_bind_ephemeral_port(s0, &addr)) {
+		perror("bind");
 		data->stop = 1;
 		signal_var(&recv_thread_ready);
-		goto out;
+		goto err;
 	}
+	data->port = addr.sin_port;
 
 	ret = listen(s0, 128);
 	assert(ret != -1);
 
 	signal_var(&recv_thread_ready);
 
 	sqe = io_uring_get_sqe(&ring);
 	assert(sqe != NULL);
 
 	io_uring_prep_poll_add(sqe, s0, POLLIN | POLLHUP | POLLERR);
 	sqe->flags |= IOSQE_IO_LINK;
 	sqe->user_data = 1;
 
@@ -148,27 +141,26 @@ void *recv_thread(void *arg)
 			fprintf(stderr, "cqe %" PRIu64 " got %x, wanted mask %x\n",
 					(uint64_t) cqe->user_data, cqe->res,
 					data->expected[idx]);
 			goto err;
 		} else if (!data->is_mask[idx] && cqe->res != data->expected[idx]) {
 			fprintf(stderr, "cqe %" PRIu64 " got %d, wanted %d\n",
 					(uint64_t) cqe->user_data, cqe->res,
 					data->expected[idx]);
 			goto err;
 		}
 		io_uring_cqe_seen(&ring, cqe);
 	}
 
-out:
 	signal_var(&recv_thread_done);
 	close(s0);
 	io_uring_queue_exit(&ring);
 	return NULL;
 err:
 	signal_var(&recv_thread_done);
 	close(s0);
 	io_uring_queue_exit(&ring);
 	return (void *) 1;
 }
 
 static int test_poll_timeout(int do_connect, unsigned long timeout)
 {
-- 
Ammar Faizi

