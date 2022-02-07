Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142B14AC5B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389809AbiBGQao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389584AbiBGQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:44 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46126C0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:43 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOc8C014399;
        Mon, 7 Feb 2022 17:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 16/42] tools/nolibc/stdlib: add i64toa() and u64toa()
Date:   Mon,  7 Feb 2022 17:23:28 +0100
Message-Id: <20220207162354.14293-17-w@1wt.eu>
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

These are 64-bit variants of the itoa() and utoa() functions. They also
support reentrant ones, and use the same itoa_buffer. The functions are
a bit larger than the previous ones in 32-bit mode (86 and 98 bytes on
x86_64 and armv7 respectively), which is why we continue to provide them
as separate functions.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index dbb45631c7ca..d972871bf2ba 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -144,6 +144,78 @@ char *utoa(unsigned long in)
 	return itoa_buffer;
 }
 
+/* Converts the unsigned 64-bit integer <in> to its string representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (21 bytes for 18446744073709551615). The buffer is filled from
+ * the first byte, and the number of characters emitted (not counting the
+ * trailing zero) is returned. The function is constructed in a way to optimize
+ * the code size and avoid any divide that could add a dependency on large
+ * external functions.
+ */
+static __attribute__((unused))
+int u64toa_r(uint64_t in, char *buffer)
+{
+	unsigned long long lim;
+	int digits = 0;
+	int pos = 19; /* start with the highest possible digit */
+	int dig;
+
+	do {
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
+}
+
+/* Converts the signed 64-bit integer <in> to its string representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (21 bytes for -9223372036854775808). The buffer is filled from
+ * the first byte, and the number of characters emitted (not counting the
+ * trailing zero) is returned.
+ */
+static __attribute__((unused))
+int i64toa_r(int64_t in, char *buffer)
+{
+	char *ptr = buffer;
+	int len = 0;
+
+	if (in < 0) {
+		in = -in;
+		*(ptr++) = '-';
+		len++;
+	}
+	len += u64toa_r(in, ptr);
+	return len;
+}
+
+/* converts int64_t <in> to a string using the static itoa_buffer and returns
+ * the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *i64toa(int64_t in)
+{
+	i64toa_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
+/* converts uint64_t <in> to a string using the static itoa_buffer and returns
+ * the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *u64toa(uint64_t in)
+{
+	u64toa_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
 static __attribute__((unused))
 int msleep(unsigned int msecs)
 {
-- 
2.35.1

