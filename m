Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6262E4AC5B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389817AbiBGQaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380060AbiBGQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:29 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12693C0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:27 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOcV3014398;
        Mon, 7 Feb 2022 17:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 15/42] tools/nolibc/stdlib: replace the ltoa() function with more efficient ones
Date:   Mon,  7 Feb 2022 17:23:27 +0100
Message-Id: <20220207162354.14293-16-w@1wt.eu>
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
---
 tools/include/nolibc/stdlib.h | 107 +++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 20 deletions(-)

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
+		for (dig = 0, lim = 1; dig < pos; dig++)
+			lim *= 10;
 
-	if (neg)
-		*pos-- = '-';
-	return pos + 1;
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
 {
-	/* large enough for -9223372036854775808 */
-	static char buffer[21];
-	return ltoa_r(in, buffer);
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
+{
+	utoa_r(in, itoa_buffer);
+	return itoa_buffer;
 }
 
 static __attribute__((unused))
-- 
2.35.1

