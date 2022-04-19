Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5376506117
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiDSArA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCECC25EA1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E95BB81154
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3906C385C3;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=HJVo8SNSgNgCFQgpJq+kcG/I/BHK65lUkahcpXLXpcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IjJwKY0UZyofmw/gu+AUXxO6M9GlmIwLYPQpWQD5mtmzDuaJjpNMaoT8YTn5K+Sbr
         lSx9YtiGXK1tMa66yd6ODnHsmNN5k8pBhw7jwzo3JRJJv4sHo3q17mbpaYSv+7dcr3
         sLZYOPLyPwu5ft6OX6JtFE8QFRR1BL1so10d8MlNmZ4MP+nLlbRu1fox2o93x9YG6U
         upnNUM+aMvK2EbbR4Teb6WXeVDRK9ZlGIQ82PFHkD5uXiU/bhnYDsNo19QKMMtRwUL
         0yTOp/Atlv+5gXuTrqOqHbTZEN70nlllttOWLqDhCnzUVclNGtgSaVdraZxQts+xoQ
         dF5DHssvRDXGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 223FE5C2DEA; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 15/61] tools/nolibc/stdlib: replace the ltoa() function with more efficient ones
Date:   Mon, 18 Apr 2022 17:41:39 -0700
Message-Id: <20220419004225.3952530-15-paulmck@kernel.org>
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

The original ltoa() function and the reentrant one ltoa_r() present a
number of drawbacks. The divide by 10 generates calls to external code
from libgcc_s, and the number does not necessarily start at the beginning
of the buffer.

Let's rewrite these functions so that they do not involve a divide and
only use loops on powers of 10, and implement both signed and unsigned
variants, always starting from the buffer's first character. Instead of
using a static buffer for each function, we're now using a common one.

In order to avoid confusion with the ltoa() name, the new functions are
called itoa_r() and utoa_r() to distinguish the signed and unsigned
versions, and for convenience for their callers, these functions now
reutrn the number of characters emitted. The ltoa_r() function is just
an inline mapping to the signed one and which returns the buffer.

The functions are quite small (86 bytes on x86_64, 68 on armv7) and
do not depend anymore on external code.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 109 +++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 84fc4353fb01..dbb45631c7ca 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -12,6 +12,13 @@
 #include "types.h"
 #include "sys.h"
 
+
+/* Buffer used to store int-to-ASCII conversions. Will only be implemented if
+ * any of the related functions is implemented. The area is large enough to
+ * store "18446744073709551615" or "-9223372036854775808" and the final zero.
+ */
+static __attribute__((unused)) char itoa_buffer[21];
+
 /*
  * As much as possible, please keep functions alphabetically sorted.
  */
@@ -45,36 +52,96 @@ int atoi(const char *s)
 	return atol(s);
 }
 
-/* performs the opposite of atol() using a user-fed buffer. The buffer must be
- * at least 21 bytes long (large enough for "-9223372036854775808").
+/* Converts the unsigned long integer <in> to its string representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (21 bytes for 18446744073709551615 in 64-bit, 11 for
+ * 4294967295 in 32-bit). The buffer is filled from the first byte, and the
+ * number of characters emitted (not counting the trailing zero) is returned.
+ * The function is constructed in a way to optimize the code size and avoid
+ * any divide that could add a dependency on large external functions.
  */
 static __attribute__((unused))
-const char *ltoa_r(long in, char *buffer)
+int utoa_r(unsigned long in, char *buffer)
 {
-	char       *pos = buffer + 21 - 1;
-	int         neg = in < 0;
-	unsigned long n = neg ? -in : in;
+	unsigned long lim;
+	int digits = 0;
+	int pos = (~0UL > 0xfffffffful) ? 19 : 9;
+	int dig;
 
-	*pos-- = '\0';
 	do {
-		*pos-- = '0' + n % 10;
-		n /= 10;
-		if (pos < buffer)
-			return pos + 1;
-	} while (n);
-
-	if (neg)
-		*pos-- = '-';
-	return pos + 1;
+		for (dig = 0, lim = 1; dig < pos; dig++)
+			lim *= 10;
+
+		if (digits || in >= lim || !pos) {
+			for (dig = 0; in >= lim; dig++)
+				in -= lim;
+			buffer[digits++] = '0' + dig;
+		}
+	} while (pos--);
+
+	buffer[digits] = 0;
+	return digits;
 }
 
-/* performs the opposite of atol() using a statically allocated buffer */
+/* Converts the signed long integer <in> to its string representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (21 bytes for -9223372036854775808 in 64-bit, 12 for
+ * -2147483648 in 32-bit). The buffer is filled from the first byte, and the
+ * number of characters emitted (not counting the trailing zero) is returned.
+ */
 static __attribute__((unused))
-const char *ltoa(long in)
+int itoa_r(long in, char *buffer)
+{
+	char *ptr = buffer;
+	int len = 0;
+
+	if (in < 0) {
+		in = -in;
+		*(ptr++) = '-';
+		len++;
+	}
+	len += utoa_r(in, ptr);
+	return len;
+}
+
+/* for historical compatibility, same as above but returns the pointer to the
+ * buffer.
+ */
+static inline __attribute__((unused))
+char *ltoa_r(long in, char *buffer)
+{
+	itoa_r(in, buffer);
+	return buffer;
+}
+
+/* converts long integer <in> to a string using the static itoa_buffer and
+ * returns the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *itoa(long in)
+{
+	itoa_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
+/* converts long integer <in> to a string using the static itoa_buffer and
+ * returns the pointer to that string. Same as above, for compatibility.
+ */
+static inline __attribute__((unused))
+char *ltoa(long in)
+{
+	itoa_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
+/* converts unsigned long integer <in> to a string using the static itoa_buffer
+ * and returns the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *utoa(unsigned long in)
 {
-	/* large enough for -9223372036854775808 */
-	static char buffer[21];
-	return ltoa_r(in, buffer);
+	utoa_r(in, itoa_buffer);
+	return itoa_buffer;
 }
 
 static __attribute__((unused))
-- 
2.31.1.189.g2e36527f23

