Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA67550E23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiFTAmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiFTAmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:42:42 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E864B1F5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q4so1924789qvq.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7puxfADmpd5bpwduUlW40lUB3hrOm3tdyr/76v8FntU=;
        b=Xa176OeWdZMQYjSjmHh33Vcm6IAuh2AcL+z1TAIrWO67QhBU3iCFyaaJFCZeWG26rD
         16XliIB16zdD+/cu14JfMxfr8/g+Y53vmPL7POZeLCfEKsfIwz/jswUbiLXZ3HJFnDQH
         7obVryGwtzChjgsg+WGgwWBWQ8rsZZy7IXe7CKxGnFiuOMJT2vxQOH+h9bcPwIbcnWId
         FagWps8SL3YjnwwsBz1sZPobw+Pi69+P3J0ra4ZMRlyZ6BeGXeBMRbhUW4VqMntXUp1w
         /hEA0Bu/xZOzWY6toyMwDuxDXi686SC8jgAXpjDn0/UW3hPRkGPEb6RmLsgzgsEdTDJ+
         9cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7puxfADmpd5bpwduUlW40lUB3hrOm3tdyr/76v8FntU=;
        b=IjYz+av2bY99Qcjmnh1Rvr+tiOFvQwnhzGS+jONUURsgG4DFAuvuTiRX+D0JlH2BkX
         1tWwBh9gBCBFJY2/J3nmVmksMU8NW7InG9KEX0519uZk8rEQPLDbg5rVnkS9swZBm/8p
         LGE6qe7aH2WCuQUvVbCiYBYWbmGbBmfC9FmYVtqPVJlqEk0WwTxhK0C1QhPpYn0RWmmg
         yXsaW1h/5g+4aF2pLI40NqfWW8bKEPRXMQSuiwzkli/tEXxpUFUAvInNX0iBGvkH+wU/
         JStpbwc8tsOfXKIQOyyI/Mk+ayPMMzecrdtBHtzN/F7KxL4OJr2Aq3tDyWtXqs6ZK4OT
         2QnA==
X-Gm-Message-State: AJIora9GXpnW0ddKCT7G5q8IVKvxVo26dYvGGFIwyO6VSiBPhjyMYnvH
        +6dXVd2Pp5R++XA3AHAmCdm6zNswcfXj+q0=
X-Google-Smtp-Source: AGRyM1uPh/R05FdXB4P79jDyI2BTeFwTjLIBEzI9eAqRYcd+puVm42gtv5KMq7VG610bMMqGC163Nw==
X-Received: by 2002:a05:622a:174b:b0:307:1492:cdc3 with SMTP id l11-20020a05622a174b00b003071492cdc3mr16525632qtk.18.1655685759668;
        Sun, 19 Jun 2022 17:42:39 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t10-20020a37ea0a000000b006a8b6848556sm10840309qkj.7.2022.06.19.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:39 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 02/34] lib/string_helpers: Convert string_escape_mem() to printbuf
Date:   Sun, 19 Jun 2022 20:42:01 -0400
Message-Id: <20220620004233.3805-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the upcoming vsprintf.c conversion, this converts string_escape_mem
to prt_escaped_string(), which uses and outputs to a printbuf, and makes
string_escape_mem() a smaller wrapper to support existing users.

The new printbuf helpers greatly simplify the code.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/string_helpers.h |   4 +
 lib/string_helpers.c           | 217 ++++++++++++++++++---------------
 2 files changed, 126 insertions(+), 95 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 4d72258d42..67de398944 100644
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
index 4f877e9551..167c31f377 100644
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
2.36.1

