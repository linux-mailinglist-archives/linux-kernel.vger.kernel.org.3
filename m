Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0515A50615C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbiDSAt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241388AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296582AC5C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87B36142E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBFAC341C4;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=3pUTkJRo/LRVbsUsXADNN+HHvHA4Ka0uxAaEAXmkDp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADfYsaZ5P71ETOFc/WKbTr5O0xKcc1Av2aNEUYlcG2nNs7K23slUyEe/6KtGeQKGF
         Zphw+qBCrvGVD5xtFn378wzAQrP9w2cCdONNG5uR6SKvInY71tIcVKKoKbBMquYkhe
         zTAgNF7kTkf2w7+RabdqG6HvhoEF/KPXqiP3V20ClsMrljtGFmfDgkVrooxJMhKIMI
         Jtqru1VK+HdkMupF9LZJUC9NpbV5mZr+KN2Hv4HlwWlNk6gngkz5y2kT2ZOd6tCXPD
         B1QhkrriLYnHxqaBQY2TAPJ4pn6+JrLBqAI9ahGCbADX7yzRwH+E+o1uQ66NPwuNY2
         eIJgJgmqj2ouQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5EFA95C3237; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 48/61] tools/nolibc/types: add poll() and waitpid() flag definitions
Date:   Mon, 18 Apr 2022 17:42:12 -0700
Message-Id: <20220419004225.3952530-48-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

- POLLIN etc were missing, so poll() could only be used with timeouts.
- WNOHANG was not defined and is convenient to check if a child is still
  running

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/types.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index e4026e740b56..357e60ad38a8 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -82,6 +82,9 @@
 #define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)   (((status) & 0x7f) == 0)
 
+/* waitpid() flags */
+#define WNOHANG      1
+
 /* standard exit() codes */
 #define EXIT_SUCCESS 0
 #define EXIT_FAILURE 1
@@ -122,6 +125,13 @@ typedef struct {
 	} while (0)
 
 /* for poll() */
+#define POLLIN          0x0001
+#define POLLPRI         0x0002
+#define POLLOUT         0x0004
+#define POLLERR         0x0008
+#define POLLHUP         0x0010
+#define POLLNVAL        0x0020
+
 struct pollfd {
 	int fd;
 	short int events;
-- 
2.31.1.189.g2e36527f23

