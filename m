Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9CC4AC658
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384848AbiBGQo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390579AbiBGQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:12 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75D04C0401DB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:10 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOgP1014423;
        Mon, 7 Feb 2022 17:24:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 39/42] tools/nolibc/signal: move raise() to signal.h
Date:   Mon,  7 Feb 2022 17:23:51 +0100
Message-Id: <20220207162354.14293-40-w@1wt.eu>
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

This function is normally found in signal.h, and providing the file
eases porting of existing programs. Let's move it there.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h |  1 +
 tools/include/nolibc/signal.h | 22 ++++++++++++++++++++++
 tools/include/nolibc/stdlib.h |  7 -------
 3 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 tools/include/nolibc/signal.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 686726518431..0f375e901a36 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -88,6 +88,7 @@
 #include "types.h"
 #include "sys.h"
 #include "ctype.h"
+#include "signal.h"
 #include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
new file mode 100644
index 000000000000..ef47e71e2be3
--- /dev/null
+++ b/tools/include/nolibc/signal.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * signal function definitions for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_SIGNAL_H
+#define _NOLIBC_SIGNAL_H
+
+#include "std.h"
+#include "arch.h"
+#include "types.h"
+#include "sys.h"
+
+/* This one is not marked static as it's needed by libgcc for divide by zero */
+__attribute__((weak,unused,section(".text.nolibc_raise")))
+int raise(int signal)
+{
+	return sys_kill(sys_getpid(), signal);
+}
+
+#endif /* _NOLIBC_SIGNAL_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 0e6bca4ee089..b46bebd48ba2 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -300,11 +300,4 @@ char *u64toa(uint64_t in)
 	return itoa_buffer;
 }
 
-/* This one is not marked static as it's needed by libgcc for divide by zero */
-__attribute__((weak,unused,section(".text.nolibc_raise")))
-int raise(int signal)
-{
-	return sys_kill(sys_getpid(), signal);
-}
-
 #endif /* _NOLIBC_STDLIB_H */
-- 
2.35.1

