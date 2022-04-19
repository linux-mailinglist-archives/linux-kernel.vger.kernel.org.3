Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10718506168
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiDSAuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbiDSApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFFB2DD5C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D986561450
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537FCC34100;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=LVVrp4UaSnbaG+QA042buI8LKch/e9WeBC8XNXB9cHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guSYPVo5CVNt/QnWSzkcEKVy+YlrRYjRzRZ6arGPReIJ5Tdn8hk1Arve7DkAsQdwp
         x1U+uFgvv/Pcl+ilFEx1g5oX+rPW2m2s0bnq8X8RBSPqwe6ZHPBkTzcOpdpm9A75DU
         de7wsl+vaZ5AWpjEhfb78h6RNON32NnUJA67iLGs2AQeO/JWqpA23Fu9tqBWvTT6c2
         HTF5M/sLUqm93/D+qxaJW2f9LEqCaks941wqrf3tMlWrgbttPQpnzV+8avkYoycjaP
         iWVfNmM7TAwHuGpLMbaA2agm++ShfijHzWzFiqsLbuBXjtx4dKpNk/yWjsbhmCHJOp
         06olnb6nVt5JA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 48AAE5C3140; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 36/61] tools/nolibc/errno: extract errno.h from sys.h
Date:   Mon, 18 Apr 2022 17:42:00 -0700
Message-Id: <20220419004225.3952530-36-paulmck@kernel.org>
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

This allows us to provide a minimal errno.h to ease porting applications
that use it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

