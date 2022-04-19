Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5516D506115
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiDSApS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbiDSApM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4EA25EA1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98EE2B81132
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEE3C385A7;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=A3zmvQqWQNYVG3Q/nWKuh2wLd7vMlu+vn9ktmaTclf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaF/ZMc6gMIrGq2rADB8ETvTx4lC8UbFyb8BvIWVlWQeNFhXuQ7A/66pjVX2QQtFP
         mjnds5C1xg86E90JPvY47juNW5TKgd/iwwzys4+OfMBie9vABik915wWBvOvkv1M0w
         pNM1yQfAT/pRrkVavT2jboG7vsDzKZcrTLB36RGJMYPMVEvIfApsUN3ASfBNmZzeuM
         fN2S0KB3lvB48YbAR/ofP7au8AYapfAkTTiIIIIFqPn+0e9YoFxa6yqbeEWYlt6K7N
         jqaqo89dYy2u8G8PvYAGG7QNec1ezTLc/b16NO02DeSmI2iWbGpta+ME1FKDlrLIMd
         FhctDkEUAH5HA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0865E5C0848; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 03/61] tools/nolibc/std: move the standard type definitions to std.h
Date:   Mon, 18 Apr 2022 17:41:27 -0700
Message-Id: <20220419004225.3952530-3-paulmck@kernel.org>
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

The ordering of includes and definitions for now is a bit of a mess, as
for example asm/signal.h is included after int defintions, but plenty of
structures are defined later as they rely on other includes.

Let's move the standard type definitions to a dedicated file that is
included first. We also move NULL there. This way all other includes
are aware of it, and we can bring asm/signal.h back to the top of the
file.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

