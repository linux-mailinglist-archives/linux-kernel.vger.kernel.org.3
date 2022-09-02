Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF625AA4C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiIBBBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiIBBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:01:07 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A659A59A6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:00:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.38.99])
        by gnuweeb.org (Postfix) with ESMTPSA id F2D9380C13;
        Fri,  2 Sep 2022 01:00:52 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662080456;
        bh=641ABaukanUnlF8DlBpXWu8Xyzx65zYRCewGXBQKAhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJjQeTU1OfSw5E2rOHyia4KRVuSpEcYWzt1JG+Yu8b1zwKncDsqE7nQy7hEgGjwhq
         FoHPAFYrYVBz4t7ngwnmUx6tZ5yQVUKrg/da6Wo9ZN7n6NWhW7p7ctPk5CriCD5/nw
         aJYbVDNvKdnTEUtv8x49PnqrVTnFxhv4BFXInz35869nQ00aC+X4LP96DSC7BhzqM6
         X6bEUIDtP0rkjzBn3H8mAZrrpeS9xCVPUA0c3OlpBOMDRRW5iQz0/UULD9oemZbDc0
         8nGqjXTZZWLB4HLiqcBmX0EirHm8xWQf7l67/JoG6rQi2cWjmtSpZQPiVWEGc29f2M
         E941hFXmVDjsQ==
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
Subject: [PATCH liburing v1 09/12] t/shutdown: Don't use a static port number
Date:   Fri,  2 Sep 2022 07:59:43 +0700
Message-Id: <20220902005825.2484023-10-ammar.faizi@intel.com>
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
 test/shutdown.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/test/shutdown.c b/test/shutdown.c
index 14c7407..064ee36 100644
--- a/test/shutdown.c
+++ b/test/shutdown.c
@@ -9,56 +9,55 @@
 #include <string.h>
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
 
 static void sig_pipe(int sig)
 {
 }
 
 int main(int argc, char *argv[])
 {
 	int p_fd[2], ret;
 	int32_t recv_s0;
 	int32_t val = 1;
-	struct sockaddr_in addr;
+	struct sockaddr_in addr = { };
 
 	if (argc > 1)
 		return 0;
 
 	srand(getpid());
 
 	recv_s0 = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
 
 	ret = setsockopt(recv_s0, SOL_SOCKET, SO_REUSEPORT, &val, sizeof(val));
 	assert(ret != -1);
 	ret = setsockopt(recv_s0, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
 	assert(ret != -1);
 
 	addr.sin_family = AF_INET;
-	addr.sin_port = htons((rand() % 61440) + 4096);
 	addr.sin_addr.s_addr = inet_addr("127.0.0.1");
 
-	ret = bind(recv_s0, (struct sockaddr*)&addr, sizeof(addr));
-	assert(ret != -1);
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

