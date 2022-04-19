Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3F506158
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbiDSAs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbiDSApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4B029839
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BE2F2CE128E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B4BC385B2;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=Y7Xa9zgU4TU9b0kuBC+cV7aEripTXHvjDSvcD8Yvyyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jK+t68hmuTT6f2iNDQRgMxvReajME5uDQOZrEHwVDGMEwHfROqqIChLJitsHu+xWx
         PI20CBBxkfdJgaOISj5JvFJBUZJrmHDi03vHlefmg8yeyKlhxlsfRoonZRzdoV4nAM
         MOBasZ19m6sBQqdTYS/qNUT5QGvLtKM6wSqAU43jE4wNzjQ6mJlagT9QF8yJhW9oDJ
         eZqDfJnS7g0s8KMoTqxsMuZR+R2XirYr2L0ZVk3ar87NjBqPKN0QlTjs/V87kxx3z2
         SfZlOZ/F8z5ZYJoQseJ+7xLzInBaCWHD4OVNU/T7pfq9I8fZLMhD0V9dD8JZd8p3yV
         hH+HmNJodTdHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 14EB55C121E; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 08/61] tools/nolibc/string: split the string functions into string.h
Date:   Mon, 18 Apr 2022 17:41:32 -0700
Message-Id: <20220419004225.3952530-8-paulmck@kernel.org>
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

The string manipulation functions (mem*, str*) are now found in
string.h. The file depends on almost nothing and will be
usable from other includes if needed. Maybe more functions could
be added.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

