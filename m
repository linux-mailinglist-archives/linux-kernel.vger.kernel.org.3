Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4250F4AC59C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389907AbiBGQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387440AbiBGQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:25:57 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 784DCC0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:25:56 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOd4U014407;
        Mon, 7 Feb 2022 17:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 24/42] tools/nolibc/sys: make open() take a vararg on the 3rd argument
Date:   Mon,  7 Feb 2022 17:23:36 +0100
Message-Id: <20220207162354.14293-25-w@1wt.eu>
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

Let's pass a vararg to open() so that it remains compatible with existing
code. The arg is only dereferenced when flags contain O_CREAT. The function
is generally not inlined anymore, causing an extra call (total 16 extra
bytes) but it's still optimized for constant propagation, limiting the
excess to no more than 16 bytes in practice when open() is called without
O_CREAT, and ~40 with O_CREAT, which remains reasonable.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 98689f668ed3..539af457a91b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -7,6 +7,7 @@
 #ifndef _NOLIBC_SYS_H
 #define _NOLIBC_SYS_H
 
+#include <stdarg.h>
 #include "std.h"
 
 /* system includes */
@@ -719,7 +720,7 @@ int mount(const char *src, const char *tgt,
 
 
 /*
- * int open(const char *path, int flags, mode_t mode);
+ * int open(const char *path, int flags[, mode_t mode]);
  */
 
 static __attribute__((unused))
@@ -735,9 +736,20 @@ int sys_open(const char *path, int flags, mode_t mode)
 }
 
 static __attribute__((unused))
-int open(const char *path, int flags, mode_t mode)
+int open(const char *path, int flags, ...)
 {
-	int ret = sys_open(path, flags, mode);
+	mode_t mode = 0;
+	int ret;
+
+	if (flags & O_CREAT) {
+		va_list args;
+
+		va_start(args, flags);
+		mode = va_arg(args, mode_t);
+		va_end(args);
+	}
+
+	ret = sys_open(path, flags, mode);
 
 	if (ret < 0) {
 		SET_ERRNO(-ret);
-- 
2.35.1

