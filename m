Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE6506110
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiDSAqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8029CA5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80BE2B81144
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB33C385B8;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=y5fnbtEDxlIRgLdidVqgeaZ0Z82o98qJVKjRSnwleXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7PzjNCcRGILEs7f4n9xctxnxdHlJsBULK7Qs/wuB9qQhHFobIkfg8sg03UpKVFO4
         DSXUsE0YkvDkv0T4QP+x27CDnt+5u/9YlOPuZifNavBVMN4kubBFJqCkI+XqotwAHA
         3o1uhlX3b304CYx3aRqvFeFYk1sjfVIld49QNjygZi+9c9b0W18mqAmvov+2E/mLk3
         WiAyB0nHzU3c1wddwLUmjm5V6H0Gh04GfzzJo6O7+WRnVsE2pKxjAaWofqJS0/6Q4l
         lh580j0WCn6mP5breEnQUvQAEXZRW79juXhMQUeZSOZmf02DZPl0bhZZqB7fR+oh+Z
         OiN2WMfI6NM7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1ABFC5C1355; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        David Laight <David.Laight@aculab.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 11/61] tools/nolibc/types: move the FD_* functions to macros in types.h
Date:   Mon, 18 Apr 2022 17:41:35 -0700
Message-Id: <20220419004225.3952530-11-paulmck@kernel.org>
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

FD_SET, FD_CLR, FD_ISSET, FD_ZERO are often expected to be macros and
not functions. In addition we already have a file dedicated to such
macros and types used by syscalls, it's types.h, so let's move them
there and turn them to macros. FD_CLR() and FD_ISSET() were missing,
so they were added. FD_ZERO() now deals with its own loop so that it
doesn't rely on memset() that sets one byte at a time.

Cc: David Laight <David.Laight@aculab.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 14 --------------
 tools/include/nolibc/types.h  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index c96c6cb7f3ae..2267d98337ea 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -118,20 +118,6 @@ const char *ltoa(long in)
 
 /* Here come a few helper functions */
 
-static __attribute__((unused))
-void FD_ZERO(fd_set *set)
-{
-	memset(set, 0, sizeof(*set));
-}
-
-static __attribute__((unused))
-void FD_SET(int fd, fd_set *set)
-{
-	if (fd < 0 || fd >= FD_SETSIZE)
-		return;
-	set->fd32[fd / 32] |= 1 << (fd & 31);
-}
-
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
 static __attribute__((unused))
 dev_t makedev(unsigned int major, unsigned int minor)
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 2f09abaf95f1..a4dda0a22fc2 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -75,6 +75,36 @@ typedef struct {
 	uint32_t fd32[FD_SETSIZE / 32];
 } fd_set;
 
+#define FD_CLR(fd, set) do {                                            \
+		fd_set *__set = (set);                                  \
+		int __fd = (fd);                                        \
+		if (__fd >= 0)                                          \
+			__set->fd32[__fd / 32] &= ~(1U << (__fd & 31)); \
+	} while (0)
+
+#define FD_SET(fd, set) do {                                            \
+		fd_set *__set = (set);                                  \
+		int __fd = (fd);                                        \
+		if (__fd >= 0)                                          \
+			__set->fd32[__fd / 32] |= 1U << (__fd & 31);    \
+	} while (0)
+
+#define FD_ISSET(fd, set) ({                                                  \
+		fd_set *__set = (set);                                        \
+		int __fd = (fd);                                              \
+		int __r = 0;                                                  \
+		if (__fd >= 0)                                                \
+			__r = !!(__set->fd32[__fd / 32] & 1U << (__fd & 31)); \
+		__r;                                                          \
+	})
+
+#define FD_ZERO(set) do {                                               \
+		fd_set *__set = (set);                                  \
+		int __idx;                                              \
+		for (__idx = 0; __idx < FD_SETSIZE / 32; __idx ++)      \
+			__set->fd32[__idx] = 0;                         \
+	} while (0)
+
 /* for poll() */
 struct pollfd {
 	int fd;
-- 
2.31.1.189.g2e36527f23

