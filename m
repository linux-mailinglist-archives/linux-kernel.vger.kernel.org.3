Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB4F50612E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbiDSAsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCAD25EB2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF3B613F5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F46C385CC;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=DoH+DKwtnZi++mxO5o84y/4hk/LGEST5iJ6GyK18UC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h63Eitfcg4e8pOwZFt7DTfsSJ06uSIXYE5YLL40O/JKSKrMo0oeXARlrP8MmY3RcM
         a/OXGBGzhITZ+Ox8v8UdLnY/SoGf2x5PmIu9djzhmCn1RQosGyoW+BPoqU7Ecm5osq
         6HqRwQlR0NXHu6/w3yrJN6D6CBjcLReGpVrwd0BwXW/hr7H1USutuCDYSnIhGzAcUW
         VSkpj30ZcRiGxWsCqvVlXA3vAbgjAZHXlB84P4PEi+0vsoJyjSsW0+KQvH4yUwhS0B
         qSje/CfKP/BoGhR3mZ9aEgNN+1tqFUTZkbUYJXv2qezI04Mk1eEPZqXyAzdg0T+uxy
         s0Ifd5R8PZbTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2DB155C30EA; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 21/61] tools/nolibc/stdio: add a minimal [vf]printf() implementation
Date:   Mon, 18 Apr 2022 17:41:45 -0700
Message-Id: <20220419004225.3952530-21-paulmck@kernel.org>
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

This adds a minimal vfprintf() implementation as well as the commonly
used fprintf() and printf() that rely on it.

For now the function supports:
  - formats: %s, %c, %u, %d, %x
  - modifiers: %l and %ll
  - unknown chars are considered as modifiers and are ignored

It is designed to remain minimalist, despite this printf() is 549 bytes
on x86_64. It would be wise not to add too many formats.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

