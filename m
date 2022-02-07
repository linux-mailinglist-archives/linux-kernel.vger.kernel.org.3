Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD384AC63C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358197AbiBGQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390650AbiBGQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:22 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B08BAC0401D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:21 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOdun014402;
        Mon, 7 Feb 2022 17:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 19/42] tools/nolibc/stdio: add stdin/stdout/stderr and fget*/fput* functions
Date:   Mon,  7 Feb 2022 17:23:31 +0100
Message-Id: <20220207162354.14293-20-w@1wt.eu>
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

The standard puts() function always emits the trailing LF which makes it
unconvenient for small string concatenation. fputs() ought to be used
instead but it requires a FILE*.

This adds 3 dummy FILE* values (stdin, stdout, stderr) which are in fact
pointers to struct FILE of one byte. We reserve 3 pointer values for them,
-3, -2 and -1, so that they are ordered, easing the tests and mapping to
integer.

From this, fgetc(), fputc(), fgets() and fputs() were implemented, and
the previous putchar() and getchar() now remap to these. The standard
getc() and putc() macros were also implemented as pointing to these
ones.

There is absolutely no buffering, fgetc() and fgets() read one byte at
a time, fputc() writes one byte at a time, and only fputs() which knows
the string's length writes all of it at once.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 95 +++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 4c6af3016e2e..149c5ca59aad 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -18,40 +18,123 @@
 #define EOF (-1)
 #endif
 
+/* just define FILE as a non-empty type */
+typedef struct FILE {
+	char dummy[1];
+} FILE;
+
+/* We define the 3 common stdio files as constant invalid pointers that
+ * are easily recognized.
+ */
+static __attribute__((unused)) FILE* const stdin  = (FILE*)-3;
+static __attribute__((unused)) FILE* const stdout = (FILE*)-2;
+static __attribute__((unused)) FILE* const stderr = (FILE*)-1;
+
+/* getc(), fgetc(), getchar() */
+
+#define getc(stream) fgetc(stream)
+
 static __attribute__((unused))
-int getchar(void)
+int fgetc(FILE* stream)
 {
 	unsigned char ch;
+	int fd;
 
-	if (read(0, &ch, 1) <= 0)
+	if (stream < stdin || stream > stderr)
+		return EOF;
+
+	fd = 3 + (long)stream;
+
+	if (read(fd, &ch, 1) <= 0)
 		return EOF;
 	return ch;
 }
 
 static __attribute__((unused))
-int putchar(int c)
+int getchar(void)
+{
+	return fgetc(stdin);
+}
+
+
+/* putc(), fputc(), putchar() */
+
+#define putc(c, stream) fputc(c, stream)
+
+static __attribute__((unused))
+int fputc(int c, FILE* stream)
 {
 	unsigned char ch = c;
+	int fd;
 
-	if (write(1, &ch, 1) <= 0)
+	if (stream < stdin || stream > stderr)
+		return EOF;
+
+	fd = 3 + (long)stream;
+
+	if (write(fd, &ch, 1) <= 0)
 		return EOF;
 	return ch;
 }
 
 static __attribute__((unused))
-int puts(const char *s)
+int putchar(int c)
+{
+	return fputc(c, stdout);
+}
+
+
+/* puts(), fputs(). Note that puts() emits '\n' but not fputs(). */
+
+static __attribute__((unused))
+int fputs(const char *s, FILE *stream)
 {
 	size_t len = strlen(s);
 	ssize_t ret;
+	int fd;
+
+	if (stream < stdin || stream > stderr)
+		return EOF;
+
+	fd = 3 + (long)stream;
 
 	while (len > 0) {
-		ret = write(1, s, len);
+		ret = write(fd, s, len);
 		if (ret <= 0)
 			return EOF;
 		s += ret;
 		len -= ret;
 	}
+	return 0;
+}
+
+static __attribute__((unused))
+int puts(const char *s)
+{
+	if (fputs(s, stdout) == EOF)
+		return EOF;
 	return putchar('\n');
 }
 
+
+/* fgets() */
+static __attribute__((unused))
+char *fgets(char *s, int size, FILE *stream)
+{
+	int ofs;
+	int c;
+
+	for (ofs = 0; ofs + 1 < size;) {
+		c = fgetc(stream);
+		if (c == EOF)
+			break;
+		s[ofs++] = c;
+		if (c == '\n')
+			break;
+	}
+	if (ofs < size)
+		s[ofs] = 0;
+	return ofs ? s : NULL;
+}
+
 #endif /* _NOLIBC_STDIO_H */
-- 
2.35.1

