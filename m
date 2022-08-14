Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2B59268F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiHNVWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240457AbiHNVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:20:57 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAEE9FF8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CjtlxSZamCxDX/Eq6Y5CRH7Lx5l3be65tGpP4P33pdc=;
        b=nDKopf4q6qgLE8E0YcajY2tg7sIsX5gcc6QuvJ6DVyuZwVe9HZmjtL8dsFOI6qq88AsOSX
        Yo8CjmPbEoVQPmA364An5zpAhe6eJAW6tHd+Z+bVXqR+XLKrlfeQZfxKcRAezmieCx0z0+
        /ko/3sLuu9Jplhh4dgDZMNK13FJzI6Y=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 10/32] vsprintf: prt_u64_minwidth(), prt_u64()
Date:   Sun, 14 Aug 2022 17:19:49 -0400
Message-Id: <20220814212011.1727798-11-kent.overstreet@linux.dev>
In-Reply-To: <20220814212011.1727798-1-kent.overstreet@linux.dev>
References: <20220814212011.1727798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This adds two new-style printbuf helpers for printing simple u64s, and
converts num_to_str() to be a simple wrapper around prt_u64_minwidth().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/kernel.h |  4 +-
 lib/vsprintf.c         | 94 ++++++++++++++++++++----------------------
 2 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1906861ece..9ba5a53c6a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -202,12 +202,14 @@ static inline void might_fault(void) { }
 
 void do_exit(long error_code) __noreturn;
 
+struct printbuf;
+extern void prt_u64_minwidth(struct printbuf *out, u64 num, unsigned width);
+extern void prt_u64(struct printbuf *out, u64 num);
 extern int num_to_str(char *buf, int size,
 		      unsigned long long num, unsigned int width);
 
 /* lib/printf utilities */
 
-struct printbuf;
 extern __printf(2, 3) void prt_printf(struct printbuf *out, const char *fmt, ...);
 extern __printf(2, 0) void prt_vprintf(struct printbuf *out, const char *fmt, va_list);
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 87adc528c6..d389f74071 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -368,41 +368,51 @@ char *put_dec(char *buf, unsigned long long n)
 
 #endif
 
-/*
- * Convert passed number to decimal string.
- * Returns the length of string.  On buffer overflow, returns 0.
- *
- * If speed is not important, use snprintf(). It's easy to read the code.
+/**
+ * prt_u64_minwidth - print a u64, in decimal, with zero padding
+ * @out: printbuf to output to
+ * @num: u64 to print
+ * @width: minimum width
  */
-int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
+void prt_u64_minwidth(struct printbuf *out, u64 num, unsigned width)
 {
 	/* put_dec requires 2-byte alignment of the buffer. */
 	char tmp[sizeof(num) * 3] __aligned(2);
-	int idx, len;
+	unsigned len = put_dec(tmp, num) - tmp;
 
-	/* put_dec() may work incorrectly for num = 0 (generate "", not "0") */
-	if (num <= 9) {
-		tmp[0] = '0' + num;
-		len = 1;
-	} else {
-		len = put_dec(tmp, num) - tmp;
-	}
+	printbuf_make_room(out, max(len, width));
 
-	if (len > size || width > size)
-		return 0;
+	if (width > len)
+		__prt_chars_reserved(out, ' ', width - len);
 
-	if (width > len) {
-		width = width - len;
-		for (idx = 0; idx < width; idx++)
-			buf[idx] = ' ';
-	} else {
-		width = 0;
-	}
+	while (len)
+		__prt_char_reserved(out, tmp[--len]);
+	printbuf_nul_terminate(out);
+}
 
-	for (idx = 0; idx < len; ++idx)
-		buf[idx + width] = tmp[len - idx - 1];
+/**
+ * prt_u64 - print a simple u64, in decimal
+ * @out: printbuf to output to
+ * @num: u64 to print
+ */
+void prt_u64(struct printbuf *out, u64 num)
+{
+	prt_u64_minwidth(out, num, 0);
+}
 
-	return len + width;
+/*
+ * Convert passed number to decimal string.
+ * Returns the length of string.  On buffer overflow, returns 0.
+ *
+ * Consider switching to printbufs and using prt_u64() or prt_u64_minwith()
+ * instead.
+ */
+int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
+{
+	struct printbuf out = PRINTBUF_EXTERN(buf, size);
+
+	prt_u64_minwidth(&out, num, width);
+	return out.pos;
 }
 
 #define SIGN	1		/* unsigned/signed, must be 1 */
@@ -993,20 +1003,6 @@ static const struct printf_spec default_dec_spec = {
 	.precision = -1,
 };
 
-static const struct printf_spec default_dec02_spec = {
-	.base = 10,
-	.field_width = 2,
-	.precision = -1,
-	.flags = ZEROPAD,
-};
-
-static const struct printf_spec default_dec04_spec = {
-	.base = 10,
-	.field_width = 4,
-	.precision = -1,
-	.flags = ZEROPAD,
-};
-
 static noinline_for_stack
 void resource_string(struct printbuf *out, struct resource *res,
 		     struct printf_spec spec, const char *fmt)
@@ -1206,12 +1202,12 @@ void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
 			prt_char(out, ',');
 		first = false;
 
-		number(out, rbot, default_dec_spec);
+		prt_u64(out, rbot);
 		if (rtop == rbot + 1)
 			continue;
 
 		prt_char(out, '-');
-		number(out, rtop - 1, default_dec_spec);
+		prt_u64(out, rtop - 1);
 	}
 }
 
@@ -1753,21 +1749,21 @@ void date_str(struct printbuf *out,
 	int year = tm->tm_year + (r ? 0 : 1900);
 	int mon = tm->tm_mon + (r ? 0 : 1);
 
-	number(out, year, default_dec04_spec);
+	prt_u64_minwidth(out, year, 4);
 	prt_char(out, '-');
-	number(out, mon, default_dec02_spec);
+	prt_u64_minwidth(out, mon, 2);
 	prt_char(out, '-');
-	number(out, tm->tm_mday, default_dec02_spec);
+	prt_u64_minwidth(out, tm->tm_mday, 2);
 }
 
 static noinline_for_stack
 void time_str(struct printbuf *out, const struct rtc_time *tm, bool r)
 {
-	number(out, tm->tm_hour, default_dec02_spec);
+	prt_u64_minwidth(out, tm->tm_hour, 2);
 	prt_char(out, ':');
-	number(out, tm->tm_min, default_dec02_spec);
+	prt_u64_minwidth(out, tm->tm_min, 2);
 	prt_char(out, ':');
-	number(out, tm->tm_sec, default_dec02_spec);
+	prt_u64_minwidth(out, tm->tm_sec, 2);
 }
 
 static noinline_for_stack
@@ -2045,7 +2041,7 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 			str_spec.precision = precision;
 			break;
 		case 'p':	/* phandle */
-			number(out, (unsigned int)dn->phandle, default_dec_spec);
+			prt_u64(out, (unsigned int)dn->phandle);
 			break;
 		case 'P':	/* path-spec */
 			p = fwnode_get_name(of_fwnode_handle(dn));
-- 
2.36.1

