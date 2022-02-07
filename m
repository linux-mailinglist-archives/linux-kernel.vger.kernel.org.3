Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234274AC5B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389750AbiBGQam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378418AbiBGQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:21 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8BF9C0401D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:19 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOcrX014397;
        Mon, 7 Feb 2022 17:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 14/42] tools/nolibc/stdlib: move ltoa() to stdlib.h
Date:   Mon,  7 Feb 2022 17:23:26 +0100
Message-Id: <20220207162354.14293-15-w@1wt.eu>
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

This function is not standard and performs the opposite of atol(). Let's
move it with atol(). It's been split between a reentrant function and one
using a static buffer.

There's no more definition in nolibc.h anymore now.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 22 ----------------------
 tools/include/nolibc/stdlib.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 23fb81414b1b..a349c88c45ff 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -94,26 +94,4 @@
 /* Used by programs to avoid std includes */
 #define NOLIBC
 
-static __attribute__((unused))
-const char *ltoa(long in)
-{
-	/* large enough for -9223372036854775808 */
-	static char buffer[21];
-	char       *pos = buffer + sizeof(buffer) - 1;
-	int         neg = in < 0;
-	unsigned long n = neg ? -in : in;
-
-	*pos-- = '\0';
-	do {
-		*pos-- = '0' + n % 10;
-		n /= 10;
-		if (pos < buffer)
-			return pos + 1;
-	} while (n);
-
-	if (neg)
-		*pos-- = '-';
-	return pos + 1;
-}
-
 #endif /* _NOLIBC_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 09a506aadbbe..84fc4353fb01 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -45,6 +45,38 @@ int atoi(const char *s)
 	return atol(s);
 }
 
+/* performs the opposite of atol() using a user-fed buffer. The buffer must be
+ * at least 21 bytes long (large enough for "-9223372036854775808").
+ */
+static __attribute__((unused))
+const char *ltoa_r(long in, char *buffer)
+{
+	char       *pos = buffer + 21 - 1;
+	int         neg = in < 0;
+	unsigned long n = neg ? -in : in;
+
+	*pos-- = '\0';
+	do {
+		*pos-- = '0' + n % 10;
+		n /= 10;
+		if (pos < buffer)
+			return pos + 1;
+	} while (n);
+
+	if (neg)
+		*pos-- = '-';
+	return pos + 1;
+}
+
+/* performs the opposite of atol() using a statically allocated buffer */
+static __attribute__((unused))
+const char *ltoa(long in)
+{
+	/* large enough for -9223372036854775808 */
+	static char buffer[21];
+	return ltoa_r(in, buffer);
+}
+
 static __attribute__((unused))
 int msleep(unsigned int msecs)
 {
-- 
2.35.1

