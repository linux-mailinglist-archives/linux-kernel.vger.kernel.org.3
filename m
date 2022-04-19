Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89E50610B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiDSApi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240977AbiDSApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057CAFD0D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E838B81145
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63C4C385B4;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=Urkpf44K5ryKVUHA26tlpBYNqYPXNmBT+RzfaeQl5qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/Ld+eGCfvEt7fPUvP610S6vvrZ6gkWU5Ym/P6RTdP59mGKSJaLLvZcRJyd2Q1Nz5
         e+k+Yc8V2HZ1qbYGkmq0O/y4T8d0fCadBmS4l1vF1xbyErVtZtRwZ9xdUecexlHOg5
         bbX8mKkB9SKWJPfGa2fr8eteB9jpYgUJYEeZBtWy/yV1mnr0lao1ZePXue4ur+u7OX
         tOsz8ikpSWmGiP08x6dPXACZ9NsJ1+Y+l7bH4zL0Y4v9fHXgvMau8xImgc9zpYeOb2
         Mz1AQoCwuDTqETaXhUuIWw7O0NGbDBPIFDYZlea5S/vEjNZHT433fPG94gT3toFEDC
         UzsT8pwC6OEFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1319C5C0DFD; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 07/61] tools/nolibc/stdlib: extract the stdlib-specific functions to their own file
Date:   Mon, 18 Apr 2022 17:41:31 -0700
Message-Id: <20220419004225.3952530-7-paulmck@kernel.org>
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

The new file stdlib.h contains the definitions of functions that
are usually found in stdlib.h. Many more could certainly be added.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

