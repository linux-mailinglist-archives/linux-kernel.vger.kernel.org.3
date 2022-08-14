Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD1E592687
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbiHNVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbiHNVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:20:45 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F765AF
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ke3A74SiaxCOn2Md0vzyaC7eX74aK6spKFXv9mYhNc8=;
        b=GMJWyF4GC+yH0ooKlsLHF+rNsB6av8iQtaeh1vr4YdJgcAjCJ+EoAi4vUovuBerwrB8N+G
        KVG0A+CUrrME4JEQ1+5pViUg/kQRi5zCNNIlzKKcULHgzSwFAKjCWEOGYUq3mDNnDFk/GY
        KUIGmZYZbQSpDTr4f+McLzL6PfkepCA=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 02/32] lib/string_helpers: Convert string_escape_mem() to printbuf
Date:   Sun, 14 Aug 2022 17:19:41 -0400
Message-Id: <20220814212011.1727798-3-kent.overstreet@linux.dev>
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

Like the upcoming vsprintf.c conversion, this converts string_escape_mem
to prt_escaped_string(), which uses and outputs to a printbuf, and makes
string_escape_mem() a smaller wrapper to support existing users.

The new printbuf helpers greatly simplify the code.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 include/linux/string_helpers.h |   3 +
 lib/string_helpers.c           | 217 ++++++++++++++++++---------------
 2 files changed, 125 insertions(+), 95 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 4d72258d42..c048eaec08 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -9,6 +9,7 @@
 
 struct device;
 struct file;
+struct printbuf;
 struct task_struct;
 
 /* Descriptions of the types of units to
@@ -62,6 +63,8 @@ static inline int string_unescape_any_inplace(char *buf)
 
 #define ESCAPE_ALL_MASK		GENMASK(8, 0)
 
+void prt_escaped_string(struct printbuf *out, const char *src, size_t isz,
+			unsigned int flags, const char *only);
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5ed3beb066..b366c660e6 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/limits.h>
 #include <linux/mm.h>
+#include <linux/printbuf.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/string_helpers.h>
@@ -301,19 +302,14 @@ int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
 }
 EXPORT_SYMBOL(string_unescape);
 
-static bool escape_passthrough(unsigned char c, char **dst, char *end)
+static bool escape_passthrough(struct printbuf *out, unsigned char c)
 {
-	char *out = *dst;
-
-	if (out < end)
-		*out = c;
-	*dst = out + 1;
+	prt_char(out, c);
 	return true;
 }
 
-static bool escape_space(unsigned char c, char **dst, char *end)
+static bool escape_space(struct printbuf *out, unsigned char c)
 {
-	char *out = *dst;
 	unsigned char to;
 
 	switch (c) {
@@ -336,20 +332,13 @@ static bool escape_space(unsigned char c, char **dst, char *end)
 		return false;
 	}
 
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = to;
-	++out;
-
-	*dst = out;
+	prt_char(out, '\\');
+	prt_char(out, to);
 	return true;
 }
 
-static bool escape_special(unsigned char c, char **dst, char *end)
+static bool escape_special(struct printbuf *out, unsigned char c)
 {
-	char *out = *dst;
 	unsigned char to;
 
 	switch (c) {
@@ -369,83 +358,43 @@ static bool escape_special(unsigned char c, char **dst, char *end)
 		return false;
 	}
 
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = to;
-	++out;
-
-	*dst = out;
+	prt_char(out, '\\');
+	prt_char(out, to);
 	return true;
 }
 
-static bool escape_null(unsigned char c, char **dst, char *end)
+static bool escape_null(struct printbuf *out, unsigned char c)
 {
-	char *out = *dst;
-
 	if (c)
 		return false;
 
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = '0';
-	++out;
-
-	*dst = out;
+	prt_char(out, '\\');
+	prt_char(out, '0');
 	return true;
 }
 
-static bool escape_octal(unsigned char c, char **dst, char *end)
+static bool escape_octal(struct printbuf *out, unsigned char c)
 {
-	char *out = *dst;
-
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = ((c >> 6) & 0x07) + '0';
-	++out;
-	if (out < end)
-		*out = ((c >> 3) & 0x07) + '0';
-	++out;
-	if (out < end)
-		*out = ((c >> 0) & 0x07) + '0';
-	++out;
-
-	*dst = out;
+	prt_char(out, '\\');
+	prt_char(out, ((c >> 6) & 0x07) + '0');
+	prt_char(out, ((c >> 3) & 0x07) + '0');
+	prt_char(out, ((c >> 0) & 0x07) + '0');
 	return true;
 }
 
-static bool escape_hex(unsigned char c, char **dst, char *end)
+static bool escape_hex(struct printbuf *out, unsigned char c)
 {
-	char *out = *dst;
-
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = 'x';
-	++out;
-	if (out < end)
-		*out = hex_asc_hi(c);
-	++out;
-	if (out < end)
-		*out = hex_asc_lo(c);
-	++out;
-
-	*dst = out;
+	prt_char(out, '\\');
+	prt_char(out, 'x');
+	prt_hex_byte(out, c);
 	return true;
 }
 
 /**
- * string_escape_mem - quote characters in the given memory buffer
+ * prt_escaped_string - quote characters in the given memory buffer
+ * @out:	printbuf to output to (escaped)
  * @src:	source buffer (unescaped)
  * @isz:	source buffer size
- * @dst:	destination buffer (escaped)
- * @osz:	destination buffer size
  * @flags:	combination of the flags
  * @only:	NULL-terminated string containing characters used to limit
  *		the selected escape class. If characters are included in @only
@@ -510,18 +459,11 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  * or %ESCAPE_HEX, because they cover most of the other character classes.
  * %ESCAPE_NAP can utilize %ESCAPE_SPACE or %ESCAPE_SPECIAL in addition to
  * the above.
- *
- * Return:
- * The total size of the escaped output that would be generated for
- * the given input and flags. To check whether the output was
- * truncated, compare the return value to osz. There is room left in
- * dst for a '\0' terminator if and only if ret < osz.
  */
-int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
-		      unsigned int flags, const char *only)
+void prt_escaped_string(struct printbuf *out,
+			const char *src, size_t isz,
+			unsigned int flags, const char *only)
 {
-	char *p = dst;
-	char *end = p + osz;
 	bool is_dict = only && *only;
 	bool is_append = flags & ESCAPE_APPEND;
 
@@ -549,41 +491,126 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		 * %ESCAPE_NA cases.
 		 */
 		if (!(is_append || in_dict) && is_dict &&
-					  escape_passthrough(c, &p, end))
+					  escape_passthrough(out, c))
 			continue;
 
 		if (!(is_append && in_dict) && isascii(c) && isprint(c) &&
-		    flags & ESCAPE_NAP && escape_passthrough(c, &p, end))
+		    flags & ESCAPE_NAP && escape_passthrough(out, c))
 			continue;
 
 		if (!(is_append && in_dict) && isprint(c) &&
-		    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
+		    flags & ESCAPE_NP && escape_passthrough(out, c))
 			continue;
 
 		if (!(is_append && in_dict) && isascii(c) &&
-		    flags & ESCAPE_NA && escape_passthrough(c, &p, end))
+		    flags & ESCAPE_NA && escape_passthrough(out, c))
 			continue;
 
-		if (flags & ESCAPE_SPACE && escape_space(c, &p, end))
+		if (flags & ESCAPE_SPACE && escape_space(out, c))
 			continue;
 
-		if (flags & ESCAPE_SPECIAL && escape_special(c, &p, end))
+		if (flags & ESCAPE_SPECIAL && escape_special(out, c))
 			continue;
 
-		if (flags & ESCAPE_NULL && escape_null(c, &p, end))
+		if (flags & ESCAPE_NULL && escape_null(out, c))
 			continue;
 
 		/* ESCAPE_OCTAL and ESCAPE_HEX always go last */
-		if (flags & ESCAPE_OCTAL && escape_octal(c, &p, end))
+		if (flags & ESCAPE_OCTAL && escape_octal(out, c))
 			continue;
 
-		if (flags & ESCAPE_HEX && escape_hex(c, &p, end))
+		if (flags & ESCAPE_HEX && escape_hex(out, c))
 			continue;
 
-		escape_passthrough(c, &p, end);
+		escape_passthrough(out, c);
 	}
+}
+EXPORT_SYMBOL(prt_escaped_string);
+
+/**
+ * string_escape_mem - quote characters in the given memory buffer
+ * @src:	source buffer (unescaped)
+ * @isz:	source buffer size
+ * @dst:	destination buffer (escaped)
+ * @osz:	destination buffer size
+ * @flags:	combination of the flags
+ * @only:	NULL-terminated string containing characters used to limit
+ *		the selected escape class. If characters are included in @only
+ *		that would not normally be escaped by the classes selected
+ *		in @flags, they will be copied to @dst unescaped.
+ *
+ * Description:
+ * The process of escaping byte buffer includes several parts. They are applied
+ * in the following sequence.
+ *
+ *	1. The character is not matched to the one from @only string and thus
+ *	   must go as-is to the output.
+ *	2. The character is matched to the printable and ASCII classes, if asked,
+ *	   and in case of match it passes through to the output.
+ *	3. The character is matched to the printable or ASCII class, if asked,
+ *	   and in case of match it passes through to the output.
+ *	4. The character is checked if it falls into the class given by @flags.
+ *	   %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
+ *	   character. Note that they actually can't go together, otherwise
+ *	   %ESCAPE_HEX will be ignored.
+ *
+ * Caller must provide valid source and destination pointers. Be aware that
+ * destination buffer will not be NULL-terminated, thus caller have to append
+ * it if needs. The supported flags are::
+ *
+ *	%ESCAPE_SPACE: (special white space, not space itself)
+ *		'\f' - form feed
+ *		'\n' - new line
+ *		'\r' - carriage return
+ *		'\t' - horizontal tab
+ *		'\v' - vertical tab
+ *	%ESCAPE_SPECIAL:
+ *		'\"' - double quote
+ *		'\\' - backslash
+ *		'\a' - alert (BEL)
+ *		'\e' - escape
+ *	%ESCAPE_NULL:
+ *		'\0' - null
+ *	%ESCAPE_OCTAL:
+ *		'\NNN' - byte with octal value NNN (3 digits)
+ *	%ESCAPE_ANY:
+ *		all previous together
+ *	%ESCAPE_NP:
+ *		escape only non-printable characters, checked by isprint()
+ *	%ESCAPE_ANY_NP:
+ *		all previous together
+ *	%ESCAPE_HEX:
+ *		'\xHH' - byte with hexadecimal value HH (2 digits)
+ *	%ESCAPE_NA:
+ *		escape only non-ascii characters, checked by isascii()
+ *	%ESCAPE_NAP:
+ *		escape only non-printable or non-ascii characters
+ *	%ESCAPE_APPEND:
+ *		append characters from @only to be escaped by the given classes
+ *
+ * %ESCAPE_APPEND would help to pass additional characters to the escaped, when
+ * one of %ESCAPE_NP, %ESCAPE_NA, or %ESCAPE_NAP is provided.
+ *
+ * One notable caveat, the %ESCAPE_NAP, %ESCAPE_NP and %ESCAPE_NA have the
+ * higher priority than the rest of the flags (%ESCAPE_NAP is the highest).
+ * It doesn't make much sense to use either of them without %ESCAPE_OCTAL
+ * or %ESCAPE_HEX, because they cover most of the other character classes.
+ * %ESCAPE_NAP can utilize %ESCAPE_SPACE or %ESCAPE_SPECIAL in addition to
+ * the above.
+ *
+ * Return:
+ * The total size of the escaped output that would be generated for
+ * the given input and flags. To check whether the output was
+ * truncated, compare the return value to osz. There is room left in
+ * dst for a '\0' terminator if and only if ret < osz.
+ */
+int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
+		      unsigned int flags, const char *only)
+{
+	struct printbuf out = PRINTBUF_EXTERN(dst, osz);
 
-	return p - dst;
+	prt_escaped_string(&out, src, isz, flags, only);
+	return out.pos;
 }
 EXPORT_SYMBOL(string_escape_mem);
 
-- 
2.36.1

