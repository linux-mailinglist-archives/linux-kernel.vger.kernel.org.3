Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD14AC643
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382293AbiBGQnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390634AbiBGQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:21 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11A00C0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:18 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOdng014404;
        Mon, 7 Feb 2022 17:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 21/42] tools/nolibc/stdio: add a minimal [vf]printf() implementation
Date:   Mon,  7 Feb 2022 17:23:33 +0100
Message-Id: <20220207162354.14293-22-w@1wt.eu>
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

This adds a minimal vfprintf() implementation as well as the commonly
used fprintf() and printf() that rely on it.

For now the function supports:
  - formats: %s, %c, %u, %d, %x
  - modifiers: %l and %ll
  - unknown chars are considered as modifiers and are ignored

It is designed to remain minimalist, despite this printf() is 549 bytes
on x86_64. It would be wise not to add too many formats.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 128 +++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 996bf89a30d2..a73cf24cb68d 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_STDIO_H
 #define _NOLIBC_STDIO_H
 
+#include <stdarg.h>
+
 #include "std.h"
 #include "arch.h"
 #include "types.h"
@@ -158,4 +160,130 @@ char *fgets(char *s, int size, FILE *stream)
 	return ofs ? s : NULL;
 }
 
+
+/* minimal vfprintf(). It supports the following formats:
+ *  - %[l*]{d,u,c,x}
+ *  - %s
+ *  - unknown modifiers are ignored.
+ */
+static __attribute__((unused))
+int vfprintf(FILE *stream, const char *fmt, va_list args)
+{
+	char escape, lpref, c;
+	unsigned long long v;
+	unsigned int written;
+	size_t len, ofs;
+	char tmpbuf[21];
+	const char *outstr;
+
+	written = ofs = escape = lpref = 0;
+	while (1) {
+		c = fmt[ofs++];
+
+		if (escape) {
+			/* we're in an escape sequence, ofs == 1 */
+			escape = 0;
+			if (c == 'c' || c == 'd' || c == 'u' || c == 'x') {
+				if (lpref) {
+					if (lpref > 1)
+						v = va_arg(args, unsigned long long);
+					else
+						v = va_arg(args, unsigned long);
+				} else
+					v = va_arg(args, unsigned int);
+
+				if (c == 'd') {
+					/* sign-extend the value */
+					if (lpref == 0)
+						v = (long long)(int)v;
+					else if (lpref == 1)
+						v = (long long)(long)v;
+				}
+
+				switch (c) {
+				case 'd':
+					i64toa_r(v, tmpbuf);
+					break;
+				case 'u':
+					u64toa_r(v, tmpbuf);
+					break;
+				case 'x':
+					u64toh_r(v, tmpbuf);
+					break;
+				default: /* 'c' */
+					tmpbuf[0] = v;
+					tmpbuf[1] = 0;
+					break;
+				}
+				outstr = tmpbuf;
+			}
+			else if (c == 's') {
+				outstr = va_arg(args, char *);
+			}
+			else if (c == '%') {
+				/* queue it verbatim */
+				continue;
+			}
+			else {
+				/* modifiers or final 0 */
+				if (c == 'l') {
+					/* long format prefix, maintain the escape */
+					lpref++;
+				}
+				escape = 1;
+				goto do_escape;
+			}
+			len = strlen(outstr);
+			goto flush_str;
+		}
+
+		/* not an escape sequence */
+		if (c == 0 || c == '%') {
+			/* flush pending data on escape or end */
+			escape = 1;
+			lpref = 0;
+			outstr = fmt;
+			len = ofs - 1;
+		flush_str:
+			if (_fwrite(outstr, len, stream) != 0)
+				break;
+
+			written += len;
+		do_escape:
+			if (c == 0)
+				break;
+			fmt += ofs;
+			ofs = 0;
+			continue;
+		}
+
+		/* literal char, just queue it */
+	}
+	return written;
+}
+
+static __attribute__((unused))
+int fprintf(FILE *stream, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vfprintf(stream, fmt, args);
+	va_end(args);
+	return ret;
+}
+
+static __attribute__((unused))
+int printf(const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vfprintf(stdout, fmt, args);
+	va_end(args);
+	return ret;
+}
+
 #endif /* _NOLIBC_STDIO_H */
-- 
2.35.1

