Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C724AC641
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381559AbiBGQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390557AbiBGQfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:10 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8907EC0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:08 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOdq6014403;
        Mon, 7 Feb 2022 17:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 20/42] tools/nolibc/stdio: add fwrite() to stdio
Date:   Mon,  7 Feb 2022 17:23:32 +0100
Message-Id: <20220207162354.14293-21-w@1wt.eu>
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

We'll use it to write substrings. It relies on a simpler _fwrite() that
only takes one size. fputs() was also modified to rely on it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 149c5ca59aad..996bf89a30d2 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -84,12 +84,14 @@ int putchar(int c)
 }
 
 
-/* puts(), fputs(). Note that puts() emits '\n' but not fputs(). */
+/* fwrite(), puts(), fputs(). Note that puts() emits '\n' but not fputs(). */
 
+/* internal fwrite()-like function which only takes a size and returns 0 on
+ * success or EOF on error. It automatically retries on short writes.
+ */
 static __attribute__((unused))
-int fputs(const char *s, FILE *stream)
+int _fwrite(const void *buf, size_t size, FILE *stream)
 {
-	size_t len = strlen(s);
 	ssize_t ret;
 	int fd;
 
@@ -98,16 +100,35 @@ int fputs(const char *s, FILE *stream)
 
 	fd = 3 + (long)stream;
 
-	while (len > 0) {
-		ret = write(fd, s, len);
+	while (size) {
+		ret = write(fd, buf, size);
 		if (ret <= 0)
 			return EOF;
-		s += ret;
-		len -= ret;
+		size -= ret;
+		buf += ret;
 	}
 	return 0;
 }
 
+static __attribute__((unused))
+size_t fwrite(const void *s, size_t size, size_t nmemb, FILE *stream)
+{
+	size_t written;
+
+	for (written = 0; written < nmemb; written++) {
+		if (_fwrite(s, size, stream) != 0)
+			break;
+		s += size;
+	}
+	return written;
+}
+
+static __attribute__((unused))
+int fputs(const char *s, FILE *stream)
+{
+	return _fwrite(s, strlen(s), stream);
+}
+
 static __attribute__((unused))
 int puts(const char *s)
 {
-- 
2.35.1

