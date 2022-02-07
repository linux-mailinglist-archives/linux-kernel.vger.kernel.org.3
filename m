Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283374AC659
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385225AbiBGQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380469AbiBGQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:08 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E3EBC0401E9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:06 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOdNr014401;
        Mon, 7 Feb 2022 17:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 18/42] tools/nolibc/stdio: add a minimal set of stdio functions
Date:   Mon,  7 Feb 2022 17:23:30 +0100
Message-Id: <20220207162354.14293-19-w@1wt.eu>
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

This only provides getchar(), putchar(), and puts().

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h |  1 +
 tools/include/nolibc/stdio.h  | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/include/nolibc/stdio.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index a349c88c45ff..7eaa09fe9f4d 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -88,6 +88,7 @@
 #include "types.h"
 #include "sys.h"
 #include "ctype.h"
+#include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
 
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
new file mode 100644
index 000000000000..4c6af3016e2e
--- /dev/null
+++ b/tools/include/nolibc/stdio.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * minimal stdio function definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_STDIO_H
+#define _NOLIBC_STDIO_H
+
+#include "std.h"
+#include "arch.h"
+#include "types.h"
+#include "sys.h"
+#include "stdlib.h"
+#include "string.h"
+
+#ifndef EOF
+#define EOF (-1)
+#endif
+
+static __attribute__((unused))
+int getchar(void)
+{
+	unsigned char ch;
+
+	if (read(0, &ch, 1) <= 0)
+		return EOF;
+	return ch;
+}
+
+static __attribute__((unused))
+int putchar(int c)
+{
+	unsigned char ch = c;
+
+	if (write(1, &ch, 1) <= 0)
+		return EOF;
+	return ch;
+}
+
+static __attribute__((unused))
+int puts(const char *s)
+{
+	size_t len = strlen(s);
+	ssize_t ret;
+
+	while (len > 0) {
+		ret = write(1, s, len);
+		if (ret <= 0)
+			return EOF;
+		s += ret;
+		len -= ret;
+	}
+	return putchar('\n');
+}
+
+#endif /* _NOLIBC_STDIO_H */
-- 
2.35.1

