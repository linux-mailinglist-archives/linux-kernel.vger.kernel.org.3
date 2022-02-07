Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3066E4AC63E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355448AbiBGQnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390627AbiBGQfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:18 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8E53C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:16 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOcQT014400;
        Mon, 7 Feb 2022 17:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 17/42] tools/nolibc/stdlib: add utoh() and u64toh()
Date:   Mon,  7 Feb 2022 17:23:29 +0100
Message-Id: <20220207162354.14293-18-w@1wt.eu>
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

This adds a pair of functions to emit hex values.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 80 +++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index d972871bf2ba..82a4cf606d3c 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -52,6 +52,46 @@ int atoi(const char *s)
 	return atol(s);
 }
 
+/* Converts the unsigned long integer <in> to its hex representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (17 bytes for "ffffffffffffffff" or 9 for "ffffffff"). The
+ * buffer is filled from the first byte, and the number of characters emitted
+ * (not counting the trailing zero) is returned. The function is constructed
+ * in a way to optimize the code size and avoid any divide that could add a
+ * dependency on large external functions.
+ */
+static __attribute__((unused))
+int utoh_r(unsigned long in, char *buffer)
+{
+	signed char pos = (~0UL > 0xfffffffful) ? 60 : 28;
+	int digits = 0;
+	int dig;
+
+	do {
+		dig = in >> pos;
+		in -= (uint64_t)dig << pos;
+		pos -= 4;
+		if (dig || digits || pos < 0) {
+			if (dig > 9)
+				dig += 'a' - '0' - 10;
+			buffer[digits++] = '0' + dig;
+		}
+	} while (pos >= 0);
+
+	buffer[digits] = 0;
+	return digits;
+}
+
+/* converts unsigned long <in> to an hex string using the static itoa_buffer
+ * and returns the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *utoh(unsigned long in)
+{
+	utoh_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
 /* Converts the unsigned long integer <in> to its string representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (21 bytes for 18446744073709551615 in 64-bit, 11 for
@@ -144,6 +184,46 @@ char *utoa(unsigned long in)
 	return itoa_buffer;
 }
 
+/* Converts the unsigned 64-bit integer <in> to its hex representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (17 bytes for "ffffffffffffffff"). The buffer is filled from
+ * the first byte, and the number of characters emitted (not counting the
+ * trailing zero) is returned. The function is constructed in a way to optimize
+ * the code size and avoid any divide that could add a dependency on large
+ * external functions.
+ */
+static __attribute__((unused))
+int u64toh_r(uint64_t in, char *buffer)
+{
+	signed char pos = 60;
+	int digits = 0;
+	int dig;
+
+	do {
+		dig = in >> pos;
+		in -= (uint64_t)dig << pos;
+		pos -= 4;
+		if (dig || digits || pos < 0) {
+			if (dig > 9)
+				dig += 'a' - '0' - 10;
+			buffer[digits++] = '0' + dig;
+		}
+	} while (pos >= 0);
+
+	buffer[digits] = 0;
+	return digits;
+}
+
+/* converts uint64_t <in> to an hex string using the static itoa_buffer and
+ * returns the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *u64toh(uint64_t in)
+{
+	u64toh_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
 /* Converts the unsigned 64-bit integer <in> to its string representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (21 bytes for 18446744073709551615). The buffer is filled from
-- 
2.35.1

