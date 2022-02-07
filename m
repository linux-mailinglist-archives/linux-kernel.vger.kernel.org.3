Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783D04AC637
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355115AbiBGQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390674AbiBGQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:26 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7CCCC0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:24 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOb6q014386;
        Mon, 7 Feb 2022 17:24:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 03/42] tools/nolibc/std: move the standard type definitions to std.h
Date:   Mon,  7 Feb 2022 17:23:15 +0100
Message-Id: <20220207162354.14293-4-w@1wt.eu>
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

The ordering of includes and definitions for now is a bit of a mess, as
for example asm/signal.h is included after int defintions, but plenty of
structures are defined later as they rely on other includes.

Let's move the standard type definitions to a dedicated file that is
included first. We also move NULL there. This way all other includes
are aware of it, and we can bring asm/signal.h back to the top of the
file.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 42 ++++--------------------------
 tools/include/nolibc/std.h    | 49 +++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 37 deletions(-)
 create mode 100644 tools/include/nolibc/std.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 4660637d9b17..186a78c25326 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -83,7 +83,12 @@
 #ifndef _NOLIBC_H
 #define _NOLIBC_H
 
+/* standard type definitions */
+#include "std.h"
+
+/* system includes */
 #include <asm/unistd.h>
+#include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
 #include <asm/errno.h>
 #include <linux/fs.h>
@@ -106,40 +111,6 @@ static int errno;
  */
 #define MAX_ERRNO 4095
 
-/* Declare a few quite common macros and types that usually are in stdlib.h,
- * stdint.h, ctype.h, unistd.h and a few other common locations.
- */
-
-#define NULL ((void *)0)
-
-/* stdint types */
-typedef unsigned char       uint8_t;
-typedef   signed char        int8_t;
-typedef unsigned short     uint16_t;
-typedef   signed short      int16_t;
-typedef unsigned int       uint32_t;
-typedef   signed int        int32_t;
-typedef unsigned long long uint64_t;
-typedef   signed long long  int64_t;
-typedef unsigned long        size_t;
-typedef   signed long       ssize_t;
-typedef unsigned long     uintptr_t;
-typedef   signed long      intptr_t;
-typedef   signed long     ptrdiff_t;
-
-/* for stat() */
-typedef unsigned int          dev_t;
-typedef unsigned long         ino_t;
-typedef unsigned int         mode_t;
-typedef   signed int          pid_t;
-typedef unsigned int          uid_t;
-typedef unsigned int          gid_t;
-typedef unsigned long       nlink_t;
-typedef   signed long         off_t;
-typedef   signed long     blksize_t;
-typedef   signed long      blkcnt_t;
-typedef   signed long        time_t;
-
 /* for poll() */
 struct pollfd {
 	int fd;
@@ -248,9 +219,6 @@ struct stat {
 #define WEXITSTATUS(status)   (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)     (((status) & 0x7f) == 0)
 
-/* for SIGCHLD */
-#include <asm/signal.h>
-
 /* Below comes the architecture-specific code. For each architecture, we have
  * the syscall declarations and the _start code definition. This is the only
  * global part. On all architectures the kernel puts everything in the stack
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
new file mode 100644
index 000000000000..1747ae125392
--- /dev/null
+++ b/tools/include/nolibc/std.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Standard definitions and types for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_STD_H
+#define _NOLIBC_STD_H
+
+/* Declare a few quite common macros and types that usually are in stdlib.h,
+ * stdint.h, ctype.h, unistd.h and a few other common locations. Please place
+ * integer type definitions and generic macros here, but avoid OS-specific and
+ * syscall-specific stuff, as this file is expected to be included very early.
+ */
+
+/* note: may already be defined */
+#ifndef NULL
+#define NULL ((void *)0)
+#endif
+
+/* stdint types */
+typedef unsigned char       uint8_t;
+typedef   signed char        int8_t;
+typedef unsigned short     uint16_t;
+typedef   signed short      int16_t;
+typedef unsigned int       uint32_t;
+typedef   signed int        int32_t;
+typedef unsigned long long uint64_t;
+typedef   signed long long  int64_t;
+typedef unsigned long        size_t;
+typedef   signed long       ssize_t;
+typedef unsigned long     uintptr_t;
+typedef   signed long      intptr_t;
+typedef   signed long     ptrdiff_t;
+
+/* those are commonly provided by sys/types.h */
+typedef unsigned int          dev_t;
+typedef unsigned long         ino_t;
+typedef unsigned int         mode_t;
+typedef   signed int          pid_t;
+typedef unsigned int          uid_t;
+typedef unsigned int          gid_t;
+typedef unsigned long       nlink_t;
+typedef   signed long         off_t;
+typedef   signed long     blksize_t;
+typedef   signed long      blkcnt_t;
+typedef   signed long        time_t;
+
+#endif /* _NOLIBC_STD_H */
-- 
2.35.1

