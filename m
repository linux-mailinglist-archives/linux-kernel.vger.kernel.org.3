Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9758C1BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiHHCmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241906AbiHHClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1200121A0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Gu7E425V0iQ09fl0rKkMxUs5hGFHfm7wcAjUWU6QsC0=; b=EkDS2YIcgaEOL7lgUCs+DjIc80
        BqsGZM8taB76nkv4bO1HblmPKAORGjfmP5902S45+S2A1SscElpDexmxCOepGPwMvVhz3ZQta21Yu
        CBKQcNJgDpQBzGLsDCKWDGP44194+/OC3NNC/mOu4s0UJXj5kKZEurBJM2A1VcTTWE6jhxwQd3tRq
        iqBMC9oHllOITKUsrAFKsgJtlTa1WnzUmh1UofoSA2yptLNlZ6cdluQ0m/GNr3dyfGoAZzrtDAqMO
        yuEUG+1J3G/crOnFnWH1mAwvolsvWn/efAjCIpuVFPJxv92d8YHWrgHoGRuO5cjl8yBnqPnzFwNNA
        xscCGUKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshw-00DVRR-O8; Mon, 08 Aug 2022 02:41:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v5 02/32] lib/string_helpers: Convert string_escape_mem() to printbuf
Date:   Mon,  8 Aug 2022 03:40:58 +0100
Message-Id: <20220808024128.3219082-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
 include/linux/string_helpers.h |   4 +
 lib/string_helpers.c           | 217 ++++++++++++++++++---------------
 2 files changed, 126 insertions(+), 95 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 4d72258d42fd..67de398944e8 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -10,6 +10,7 @@
 struct device;
 struct file;
 struct task_struct;
+struct printbuf;
 
 /* Descriptions of the types of units to
  * print in */
@@ -62,6 +63,8 @@ static inline int string_unescape_any_inplace(char *buf)
 
 #define ESCAPE_ALL_MASK		GENMASK(8, 0)
 
+void prt_escaped_string(struct printbuf *out, const char *src, size_t isz,
+			unsigned int flags, const char *only);
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
 
@@ -71,6 +74,7 @@ static inline int string_escape_mem_any_np(const char *src, size_t isz,
 	return string_escape_mem(src, isz, dst, osz, ESCAPE_ANY_NP, only);
 }
 
+
 static inline int string_escape_str(const char *src, char *dst, size_t sz,
 		unsigned int flags, const char *only)
 {
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5ed3beb066e6..7be20bcc6137 100644
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
+		    escape_passthrough(out, c))
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
2.35.1

