Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47A50612B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbiDSAr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD221E31
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C80A61416
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57705C34110;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=mgXsCWjHLao11w3t7r5++qUUVgMHW7AYdTHby6BV1Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZeJHUNy2X8ou6fTmB4y0oXxSlp+Lca2roqeoflHagKwTgjcQ3yL/p/zu10CshqEz
         f58UG9UqH3p+lTudby3/ms4NKEl6wRVkGu3GYsc3gzodEmFM3imW+QCk9uGDO88Yeo
         qE20iAkhMSE0jgTQ/utZakNpy1l3rhUEXERFbiGXqtsHTTZ/HmeiiTkmKmsQUYxnSZ
         7SfP0yiiCdjdWGlGuOIYuXvXRxRdVM+biWQPRK7yxjz0m1iw0brv/ZTPLA0QTSBAZg
         Lg9L7lbAlhWdNJM7dAdDpG9wmnNnkvoPxJXv0vQThHug6AQgGDlwgDgbt/V6Lbe+Fq
         fRqtsDD87lHOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A94A5C3147; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 37/61] tools/nolibc/unistd: extract msleep(), sleep(), tcsetpgrp() to unistd.h
Date:   Mon, 18 Apr 2022 17:42:01 -0700
Message-Id: <20220419004225.3952530-37-paulmck@kernel.org>
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

These functions are normally provided by unistd.h. For ease of porting,
let's create the file and move them there.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

