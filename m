Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5B5AA4C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiIBBBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiIBBAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:00:38 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2B48CA6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:00:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.38.99])
        by gnuweeb.org (Postfix) with ESMTPSA id 306D380C0E;
        Fri,  2 Sep 2022 01:00:30 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662080435;
        bh=qs4JWXzimskB0a0dxpXuwJq+RPw5p6Ix1O988JFqCXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFNn40UYvQ4q7OUbaNPIHEDdxDyVPJu4V3423xzNxkvVntWFVsuDK9clwX0Kbk3Ic
         rNYzP71HYXwvfugIWjJBA5zYwspn9hzBqxn6CznbImonljgWZ3GIC7Hg3+nXd4XjYw
         W1axHUf68kA6cZm//gdXdDJYwTGFCR+cYd1lsotPgtWBRgW7/Jwdh/FpqJGZ9KZCc8
         x2te4tc412nqE6FMg1pUHPQXZOU+u4EJOSZybSJspHc/3es2ivkRrQVXfjdrAZ95Mi
         wkdJ3bCM8gI7YwrHaP2a7GxEp6Lt+iRT12O4bFpQvE1ZD+qCszrmNpc1zpOl/qfYvP
         WHntArYofsaQA==
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
Subject: [PATCH liburing v1 04/12] t/socket-rw-eagain: Don't brute force the port number
Date:   Fri,  2 Sep 2022 07:59:38 +0700
Message-Id: <20220902005825.2484023-5-ammar.faizi@intel.com>
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
 test/socket-rw-eagain.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/test/socket-rw-eagain.c b/test/socket-rw-eagain.c
index 2d6a817..a12c70d 100644
--- a/test/socket-rw-eagain.c
+++ b/test/socket-rw-eagain.c
@@ -8,61 +8,51 @@
 #include <stdint.h>
 #include <assert.h>
 
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <netinet/tcp.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 
 #include "liburing.h"
+#include "helpers.h"
 
 int main(int argc, char *argv[])
 {
 	int p_fd[2], ret;
 	int32_t recv_s0;
 	int32_t val = 1;
 	struct sockaddr_in addr;
 	struct iovec iov_r[1], iov_w[1];
 
 	if (argc > 1)
 		return 0;
 
 	srand(getpid());
 
 	recv_s0 = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
 
 	ret = setsockopt(recv_s0, SOL_SOCKET, SO_REUSEPORT, &val, sizeof(val));
 	assert(ret != -1);
 	ret = setsockopt(recv_s0, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
 	assert(ret != -1);
 
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = inet_addr("127.0.0.1");
-
-	do {
-		addr.sin_port = htons((rand() % 61440) + 4096);
-		ret = bind(recv_s0, (struct sockaddr*)&addr, sizeof(addr));
-		if (!ret)
-			break;
-		if (errno != EADDRINUSE) {
-			perror("bind");
-			exit(1);
-		}
-	} while (1);
-
+	assert(!t_bind_ephemeral_port(recv_s0, &addr));
 	ret = listen(recv_s0, 128);
 	assert(ret != -1);
 
 	p_fd[1] = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
 
 	val = 1;
 	ret = setsockopt(p_fd[1], IPPROTO_TCP, TCP_NODELAY, &val, sizeof(val));
 	assert(ret != -1);
 
 	int32_t flags = fcntl(p_fd[1], F_GETFL, 0);
 	assert(flags != -1);
 
 	flags |= O_NONBLOCK;
-- 
Ammar Faizi

