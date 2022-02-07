Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7689E4AC65A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385367AbiBGQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390685AbiBGQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:27 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C47AEC0401D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:26 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GObmP014391;
        Mon, 7 Feb 2022 17:24:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 08/42] tools/nolibc/string: split the string functions into string.h
Date:   Mon,  7 Feb 2022 17:23:20 +0100
Message-Id: <20220207162354.14293-9-w@1wt.eu>
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

The string manipulation functions (mem*, str*) are now found in
string.h. The file depends on almost nothing and will be
usable from other includes if needed. Maybe more functions could
be added.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h |  96 +-----------------------------
 tools/include/nolibc/string.h | 107 ++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 95 deletions(-)
 create mode 100644 tools/include/nolibc/string.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index ed909a8daa1a..b06bd5cb5651 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -88,99 +88,11 @@
 #include "types.h"
 #include "sys.h"
 #include "stdlib.h"
+#include "string.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
 
-/* some size-optimized reimplementations of a few common str* and mem*
- * functions. They're marked static, except memcpy() and raise() which are used
- * by libgcc on ARM, so they are marked weak instead in order not to cause an
- * error when building a program made of multiple files (not recommended).
- */
-
-static __attribute__((unused))
-void *memmove(void *dst, const void *src, size_t len)
-{
-	ssize_t pos = (dst <= src) ? -1 : (long)len;
-	void *ret = dst;
-
-	while (len--) {
-		pos += (dst <= src) ? 1 : -1;
-		((char *)dst)[pos] = ((char *)src)[pos];
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-void *memset(void *dst, int b, size_t len)
-{
-	char *p = dst;
-
-	while (len--)
-		*(p++) = b;
-	return dst;
-}
-
-static __attribute__((unused))
-int memcmp(const void *s1, const void *s2, size_t n)
-{
-	size_t ofs = 0;
-	char c1 = 0;
-
-	while (ofs < n && !(c1 = ((char *)s1)[ofs] - ((char *)s2)[ofs])) {
-		ofs++;
-	}
-	return c1;
-}
-
-static __attribute__((unused))
-char *strcpy(char *dst, const char *src)
-{
-	char *ret = dst;
-
-	while ((*dst++ = *src++));
-	return ret;
-}
-
-static __attribute__((unused))
-char *strchr(const char *s, int c)
-{
-	while (*s) {
-		if (*s == (char)c)
-			return (char *)s;
-		s++;
-	}
-	return NULL;
-}
-
-static __attribute__((unused))
-char *strrchr(const char *s, int c)
-{
-	const char *ret = NULL;
-
-	while (*s) {
-		if (*s == (char)c)
-			ret = s;
-		s++;
-	}
-	return (char *)ret;
-}
-
-static __attribute__((unused))
-size_t nolibc_strlen(const char *str)
-{
-	size_t len;
-
-	for (len = 0; str[len]; len++);
-	return len;
-}
-
-#define strlen(str) ({                          \
-	__builtin_constant_p((str)) ?           \
-		__builtin_strlen((str)) :       \
-		nolibc_strlen((str));           \
-})
-
 static __attribute__((unused))
 int isdigit(int c)
 {
@@ -209,12 +121,6 @@ const char *ltoa(long in)
 	return pos + 1;
 }
 
-__attribute__((weak,unused))
-void *memcpy(void *dst, const void *src, size_t len)
-{
-	return memmove(dst, src, len);
-}
-
 /* Here come a few helper functions */
 
 static __attribute__((unused))
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
new file mode 100644
index 000000000000..8a23cda2d450
--- /dev/null
+++ b/tools/include/nolibc/string.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * string function definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_STRING_H
+#define _NOLIBC_STRING_H
+
+#include "std.h"
+
+/*
+ * As much as possible, please keep functions alphabetically sorted.
+ */
+
+static __attribute__((unused))
+int memcmp(const void *s1, const void *s2, size_t n)
+{
+	size_t ofs = 0;
+	char c1 = 0;
+
+	while (ofs < n && !(c1 = ((char *)s1)[ofs] - ((char *)s2)[ofs])) {
+		ofs++;
+	}
+	return c1;
+}
+
+static __attribute__((unused))
+void *memmove(void *dst, const void *src, size_t len)
+{
+	ssize_t pos = (dst <= src) ? -1 : (long)len;
+	void *ret = dst;
+
+	while (len--) {
+		pos += (dst <= src) ? 1 : -1;
+		((char *)dst)[pos] = ((char *)src)[pos];
+	}
+	return ret;
+}
+
+/* must be exported, as it's used by libgcc on ARM */
+__attribute__((weak,unused))
+void *memcpy(void *dst, const void *src, size_t len)
+{
+	return memmove(dst, src, len);
+}
+
+static __attribute__((unused))
+void *memset(void *dst, int b, size_t len)
+{
+	char *p = dst;
+
+	while (len--)
+		*(p++) = b;
+	return dst;
+}
+
+static __attribute__((unused))
+char *strchr(const char *s, int c)
+{
+	while (*s) {
+		if (*s == (char)c)
+			return (char *)s;
+		s++;
+	}
+	return NULL;
+}
+
+static __attribute__((unused))
+char *strcpy(char *dst, const char *src)
+{
+	char *ret = dst;
+
+	while ((*dst++ = *src++));
+	return ret;
+}
+
+/* this function is only used with arguments that are not constants */
+static __attribute__((unused))
+size_t nolibc_strlen(const char *str)
+{
+	size_t len;
+
+	for (len = 0; str[len]; len++);
+	return len;
+}
+
+#define strlen(str) ({                          \
+	__builtin_constant_p((str)) ?           \
+		__builtin_strlen((str)) :       \
+		nolibc_strlen((str));           \
+})
+
+static __attribute__((unused))
+char *strrchr(const char *s, int c)
+{
+	const char *ret = NULL;
+
+	while (*s) {
+		if (*s == (char)c)
+			ret = s;
+		s++;
+	}
+	return (char *)ret;
+}
+
+#endif /* _NOLIBC_STRING_H */
-- 
2.35.1

