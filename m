Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06894E2F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349554AbiCURf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348813AbiCURe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:58 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD78A74847
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:31 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXOj5007575;
        Mon, 21 Mar 2022 18:33:24 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 6/8] tools/nolibc/types: add poll() and waitpid() flag definitions
Date:   Mon, 21 Mar 2022 18:33:12 +0100
Message-Id: <20220321173314.7519-7-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- POLLIN etc were missing, so poll() could only be used with timeouts.
- WNOHANG was not defined and is convenient to check if a child is still
  running

Signed-off-by: Willy Tarreau <w@1wt.eu>
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
2.35.1

