Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C474D4AC65B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385674AbiBGQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390594AbiBGQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:12 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E69BC0401ED
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:11 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOf4u014420;
        Mon, 7 Feb 2022 17:24:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 36/42] tools/nolibc/errno: extract errno.h from sys.h
Date:   Mon,  7 Feb 2022 17:23:48 +0100
Message-Id: <20220207162354.14293-37-w@1wt.eu>
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

This allows us to provide a minimal errno.h to ease porting applications
that use it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/errno.h | 27 +++++++++++++++++++++++++++
 tools/include/nolibc/stdio.h |  1 +
 tools/include/nolibc/sys.h   | 17 +----------------
 3 files changed, 29 insertions(+), 16 deletions(-)
 create mode 100644 tools/include/nolibc/errno.h

diff --git a/tools/include/nolibc/errno.h b/tools/include/nolibc/errno.h
new file mode 100644
index 000000000000..06893d6dfb7a
--- /dev/null
+++ b/tools/include/nolibc/errno.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Minimal errno definitions for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_ERRNO_H
+#define _NOLIBC_ERRNO_H
+
+#include <asm/errno.h>
+
+/* this way it will be removed if unused */
+static int errno;
+
+#ifndef NOLIBC_IGNORE_ERRNO
+#define SET_ERRNO(v) do { errno = (v); } while (0)
+#else
+#define SET_ERRNO(v) do { } while (0)
+#endif
+
+
+/* errno codes all ensure that they will not conflict with a valid pointer
+ * because they all correspond to the highest addressable memory page.
+ */
+#define MAX_ERRNO 4095
+
+#endif /* _NOLIBC_ERRNO_H */
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 5f1cf32470d3..cb4d3ab3a565 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -11,6 +11,7 @@
 
 #include "std.h"
 #include "arch.h"
+#include "errno.h"
 #include "types.h"
 #include "sys.h"
 #include "stdlib.h"
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index ef017cc0a580..28437863c63f 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -14,29 +14,14 @@
 #include <asm/unistd.h>
 #include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
-#include <asm/errno.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
 
 #include "arch.h"
+#include "errno.h"
 #include "types.h"
 
-/* this way it will be removed if unused */
-static int errno;
-
-#ifndef NOLIBC_IGNORE_ERRNO
-#define SET_ERRNO(v) do { errno = (v); } while (0)
-#else
-#define SET_ERRNO(v) do { } while (0)
-#endif
-
-
-/* errno codes all ensure that they will not conflict with a valid pointer
- * because they all correspond to the highest addressable memory page.
- */
-#define MAX_ERRNO 4095
-
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
-- 
2.35.1

