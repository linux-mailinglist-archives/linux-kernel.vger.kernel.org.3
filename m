Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320B25AA4C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiIBBBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiIBBBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:01:05 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC04A50ED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:00:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.38.99])
        by gnuweeb.org (Postfix) with ESMTPSA id 950B180C12;
        Fri,  2 Sep 2022 01:00:48 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662080452;
        bh=9mn+NsOQ1zaPJ1WbjFHcvyNU4C6nPGPxtaZbqetpeAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7fFVRdMdz1lfJVbKj0RbWr/+JfX5pdiOFDMt/H/z02R1rIbqOhT7cdA/uvDleWwW
         fsQiRQijO6dK0PTkHdD9KRCkuilkN5EnLon7028gKCTQN2BaLABSYwcWRI1eOEPw0B
         1nYOGX4jWUq83wXK2qthJzIMlddhTeSF5jeJIwpwX1t3k6HEnDwv5IGn3QKnAkdx+Y
         0RAAwlT5CKEKV/mPnoURRe218PD56EJogbMsikAswqz5H8ve2NeByhjaY+avxLl4gZ
         o/w6EnsIBHOhYBg3Ki7vqZXXtNwl4OWhcTNwCV1/ZNgkzuG/XmTAmDeEE1lKd4xDZJ
         SwF8U7IeLVPIw==
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
Subject: [PATCH liburing v1 08/12] t/connect: Don't use a static port number
Date:   Fri,  2 Sep 2022 07:59:42 +0700
Message-Id: <20220902005825.2484023-9-ammar.faizi@intel.com>
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
 test/accept.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/test/accept.c b/test/accept.c
index b35ded4..1821faa 100644
--- a/test/accept.c
+++ b/test/accept.c
@@ -184,31 +184,28 @@ static int start_accept_listen(struct sockaddr_in *addr, int port_off,
 
 	int32_t val = 1;
 	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &val, sizeof(val));
 	assert(ret != -1);
 	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
 	assert(ret != -1);
 
 	struct sockaddr_in laddr;
 
 	if (!addr)
 		addr = &laddr;
 
 	addr->sin_family = AF_INET;
-	addr->sin_port = htons(0x1235 + port_off);
 	addr->sin_addr.s_addr = inet_addr("127.0.0.1");
-
-	ret = bind(fd, (struct sockaddr*)addr, sizeof(*addr));
-	assert(ret != -1);
+	assert(!t_bind_ephemeral_port(fd, addr));
 	ret = listen(fd, 128);
 	assert(ret != -1);
 
 	return fd;
 }
 
 static int set_client_fd(struct sockaddr_in *addr)
 {
 	int32_t val;
 	int fd, ret;
 
 	fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
 
-- 
Ammar Faizi

