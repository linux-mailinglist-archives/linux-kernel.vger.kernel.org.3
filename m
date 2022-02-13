Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7FD4B3A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiBMIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 03:52:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBMIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 03:52:31 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923BB1132
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 00:52:25 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21D8qARE031979;
        Sun, 13 Feb 2022 09:52:10 +0100
Date:   Sun, 13 Feb 2022 09:52:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/42] tools/nolibc/types: move the FD_* functions to
 macros in types.h
Message-ID: <20220213085210.GA31914@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
 <20220207162354.14293-12-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207162354.14293-12-w@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


FD_SET, FD_CLR, FD_ISSET, FD_ZERO are often expected to be macros and
not functions. In addition we already have a file dedicated to such
macros and types used by syscalls, it's types.h, so let's move them
there and turn them to macros. FD_CLR() and FD_ISSET() were missing,
so they were added. FD_ZERO() now deals with its own loop so that it
doesn't rely on memset() that sets one byte at a time.

Cc: David Laight <David.Laight@aculab.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>

---
v2:
- nolibc/types: improve portability of FD_CLR/SET/ISSET/ZERO by dropping
  useless casts and the test on FD_SETSIZE
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
2.35.1

