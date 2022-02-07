Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C74AC656
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383994AbiBGQoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390653AbiBGQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:24 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35B6FC0401D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:22 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GObk2014390;
        Mon, 7 Feb 2022 17:24:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 07/42] tools/nolibc/stdlib: extract the stdlib-specific functions to their own file
Date:   Mon,  7 Feb 2022 17:23:19 +0100
Message-Id: <20220207162354.14293-8-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new file stdlib.h contains the definitions of functions that
are usually found in stdlib.h. Many more could certainly be added.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 67 +--------------------------
 tools/include/nolibc/stdlib.h | 85 +++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 66 deletions(-)
 create mode 100644 tools/include/nolibc/stdlib.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 2af56ec760e2..ed909a8daa1a 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -87,40 +87,11 @@
 #include "arch.h"
 #include "types.h"
 #include "sys.h"
+#include "stdlib.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
 
-static __attribute__((unused))
-int tcsetpgrp(int fd, pid_t pid)
-{
-	return ioctl(fd, TIOCSPGRP, &pid);
-}
-
-static __attribute__((unused))
-unsigned int sleep(unsigned int seconds)
-{
-	struct timeval my_timeval = { seconds, 0 };
-
-	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
-		return my_timeval.tv_sec + !!my_timeval.tv_usec;
-	else
-		return 0;
-}
-
-static __attribute__((unused))
-int msleep(unsigned int msecs)
-{
-	struct timeval my_timeval = { msecs / 1000, (msecs % 1000) * 1000 };
-
-	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
-		return (my_timeval.tv_sec * 1000) +
-			(my_timeval.tv_usec / 1000) +
-			!!(my_timeval.tv_usec % 1000);
-	else
-		return 0;
-}
-
 /* some size-optimized reimplementations of a few common str* and mem*
  * functions. They're marked static, except memcpy() and raise() which are used
  * by libgcc on ARM, so they are marked weak instead in order not to cause an
@@ -216,35 +187,6 @@ int isdigit(int c)
 	return (unsigned int)(c - '0') <= 9;
 }
 
-static __attribute__((unused))
-long atol(const char *s)
-{
-	unsigned long ret = 0;
-	unsigned long d;
-	int neg = 0;
-
-	if (*s == '-') {
-		neg = 1;
-		s++;
-	}
-
-	while (1) {
-		d = (*s++) - '0';
-		if (d > 9)
-			break;
-		ret *= 10;
-		ret += d;
-	}
-
-	return neg ? -ret : ret;
-}
-
-static __attribute__((unused))
-int atoi(const char *s)
-{
-	return atol(s);
-}
-
 static __attribute__((unused))
 const char *ltoa(long in)
 {
@@ -273,13 +215,6 @@ void *memcpy(void *dst, const void *src, size_t len)
 	return memmove(dst, src, len);
 }
 
-/* needed by libgcc for divide by zero */
-__attribute__((weak,unused))
-int raise(int signal)
-{
-	return kill(getpid(), signal);
-}
-
 /* Here come a few helper functions */
 
 static __attribute__((unused))
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
new file mode 100644
index 000000000000..09a506aadbbe
--- /dev/null
+++ b/tools/include/nolibc/stdlib.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * stdlib function definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_STDLIB_H
+#define _NOLIBC_STDLIB_H
+
+#include "std.h"
+#include "arch.h"
+#include "types.h"
+#include "sys.h"
+
+/*
+ * As much as possible, please keep functions alphabetically sorted.
+ */
+
+static __attribute__((unused))
+long atol(const char *s)
+{
+	unsigned long ret = 0;
+	unsigned long d;
+	int neg = 0;
+
+	if (*s == '-') {
+		neg = 1;
+		s++;
+	}
+
+	while (1) {
+		d = (*s++) - '0';
+		if (d > 9)
+			break;
+		ret *= 10;
+		ret += d;
+	}
+
+	return neg ? -ret : ret;
+}
+
+static __attribute__((unused))
+int atoi(const char *s)
+{
+	return atol(s);
+}
+
+static __attribute__((unused))
+int msleep(unsigned int msecs)
+{
+	struct timeval my_timeval = { msecs / 1000, (msecs % 1000) * 1000 };
+
+	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
+		return (my_timeval.tv_sec * 1000) +
+			(my_timeval.tv_usec / 1000) +
+			!!(my_timeval.tv_usec % 1000);
+	else
+		return 0;
+}
+
+/* This one is not marked static as it's needed by libgcc for divide by zero */
+__attribute__((weak,unused))
+int raise(int signal)
+{
+	return kill(getpid(), signal);
+}
+
+static __attribute__((unused))
+unsigned int sleep(unsigned int seconds)
+{
+	struct timeval my_timeval = { seconds, 0 };
+
+	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
+		return my_timeval.tv_sec + !!my_timeval.tv_usec;
+	else
+		return 0;
+}
+
+static __attribute__((unused))
+int tcsetpgrp(int fd, pid_t pid)
+{
+	return ioctl(fd, TIOCSPGRP, &pid);
+}
+
+#endif /* _NOLIBC_STDLIB_H */
-- 
2.35.1

