Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9F850610D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiDSAqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C95A201AD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CD6DB81151
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB62C385CB;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=U8Bdhhgm4XkhuZa/4y0o4tKotWCm1yK5jlD2daXT+eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBrdvSpyJoOkiJ049s5jVwiI+iA7oSIZUQQlNn2SbTO+0XImSMzKwcyioCzCwN7ol
         l3rHZoyOk3LTz0CVyp7S6hVU0FQXP/8DicPV4VsOt0IsOfEsmN7E/0/qRfAZQbSg5v
         g03YhDTlyMDq0tvW3jeYvPtYz/2LDsr5kGjAvRANUAe7hD8TQcp5Bqs551QPB6pvEm
         NxSLeWbRJZ8z7AysyezvJv9Z9zeu0KR/DrCOLFKfMDimDAiNyLkgrefXoPXL6I/SCV
         zbcgfefAff1zLibaw2sXa8IRNsUsoPn/rrTN4/HXBa4wGDNUCr5cnSxWakOm4DbmSP
         7cPXIQkdsKSUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 29F9D5C30E1; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 19/61] tools/nolibc/stdio: add stdin/stdout/stderr and fget*/fput* functions
Date:   Mon, 18 Apr 2022 17:41:43 -0700
Message-Id: <20220419004225.3952530-19-paulmck@kernel.org>
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

The standard puts() function always emits the trailing LF which makes it
unconvenient for small string concatenation. fputs() ought to be used
instead but it requires a FILE*.

This adds 3 dummy FILE* values (stdin, stdout, stderr) which are in fact
pointers to struct FILE of one byte. We reserve 3 pointer values for them,
-3, -2 and -1, so that they are ordered, easing the tests and mapping to
integer.

>From this, fgetc(), fputc(), fgets() and fputs() were implemented, and
the previous putchar() and getchar() now remap to these. The standard
getc() and putc() macros were also implemented as pointing to these
ones.

There is absolutely no buffering, fgetc() and fgets() read one byte at
a time, fputc() writes one byte at a time, and only fputs() which knows
the string's length writes all of it at once.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

