Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C852450612A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbiDSAqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241121AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FBA2B274
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A676613F8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1FAC385AF;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=Y3XHIWYLEBNlv6oGyGJ6J19GcR7wY2z46Qs+JlzYLko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDbWFR3Z/NaB0H1WRkivj8c71u+Lxxpxk0e2HSw698XSPPNIRKEdiTAufHDZexj54
         FKv7MPCJVdpH3DVgvStuQnyG0fjzzDYNFdudnhOWOypH9yc9Hgi5euAU4T66GXko+p
         1KrqXZY9OqP018gr3yVVFyggz+CmReg4mrlS4llxKqtSGllwVL7yu9gGWwvxZtxSZn
         DCy74GEo+HWI1FZoY4WnHNLKHEYniIWqZqW19d9+3vVKKtAxHnXMC1NnJph4tqbkaM
         01haleXk5SuNNwfd2u8YwLK5Ja5YrohLVzY1EyKJnW7z0Gw3n5AexENkLkKK0SkEey
         GXqj4YYW6bcGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2BB895C30E3; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 20/61] tools/nolibc/stdio: add fwrite() to stdio
Date:   Mon, 18 Apr 2022 17:41:44 -0700
Message-Id: <20220419004225.3952530-20-paulmck@kernel.org>
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

We'll use it to write substrings. It relies on a simpler _fwrite() that
only takes one size. fputs() was also modified to rely on it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

