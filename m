Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECDD4AC645
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382340AbiBGQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390623AbiBGQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:16 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A12CC0401D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:15 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOfL2014421;
        Mon, 7 Feb 2022 17:24:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 37/42] tools/nolibc/unistd: extract msleep(), sleep(), tcsetpgrp() to unistd.h
Date:   Mon,  7 Feb 2022 17:23:49 +0100
Message-Id: <20220207162354.14293-38-w@1wt.eu>
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

These functions are normally provided by unistd.h. For ease of porting,
let's create the file and move them there.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h |  1 +
 tools/include/nolibc/stdlib.h | 30 -----------------------
 tools/include/nolibc/unistd.h | 46 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 30 deletions(-)
 create mode 100644 tools/include/nolibc/unistd.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 7eaa09fe9f4d..686726518431 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -91,6 +91,7 @@
 #include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
+#include "unistd.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index da08ff30c15a..0e6bca4ee089 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -300,19 +300,6 @@ char *u64toa(uint64_t in)
 	return itoa_buffer;
 }
 
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
 /* This one is not marked static as it's needed by libgcc for divide by zero */
 __attribute__((weak,unused,section(".text.nolibc_raise")))
 int raise(int signal)
@@ -320,21 +307,4 @@ int raise(int signal)
 	return sys_kill(sys_getpid(), signal);
 }
 
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
-int tcsetpgrp(int fd, pid_t pid)
-{
-	return ioctl(fd, TIOCSPGRP, &pid);
-}
-
 #endif /* _NOLIBC_STDLIB_H */
diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
new file mode 100644
index 000000000000..87b448ff2191
--- /dev/null
+++ b/tools/include/nolibc/unistd.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * unistd function definitions for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_UNISTD_H
+#define _NOLIBC_UNISTD_H
+
+#include "std.h"
+#include "arch.h"
+#include "types.h"
+#include "sys.h"
+
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
+#endif /* _NOLIBC_UNISTD_H */
-- 
2.35.1

