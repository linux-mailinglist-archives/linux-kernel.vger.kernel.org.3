Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B264953D843
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiFDTbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiFDTaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:30:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097AA22518
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:30:54 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bi27so1809717qkb.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feLvusglZnmvtVTa9kR5/VeR2dvAvIYip9mj6c5ceDs=;
        b=qNsYIXjurPlBzItHVVOSPXWJTMf7iUxeAtowdunE7SMzy/Ny6D0T3jIBmZ7bgd3RMg
         /rzsKGV4v/2IyptKlY7Oh5VuyzaE/DzwMmmiyRMpbRQI+UGB3UE48oSTJLp5segiobfl
         UhS1b4/NFud1bxsBjRZaihY/1LGq7+zll5NKe2pK2zr4HK0mId02nr32QeJJ4EWhz8RB
         G3WVPyM0M9YJKmCkcZ8Orq2PDt42ThXFhRQNJsOid5+tYtmvOAP8Yx1bDV5vGPEHYbLO
         +vXOq5H8k6Rd8ZmYZbKFnycWYdYL+tRVbhHmMpxIeUds+/T/tlR9Oj3RLc/KoQ8gK+gE
         vJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feLvusglZnmvtVTa9kR5/VeR2dvAvIYip9mj6c5ceDs=;
        b=T0XOafsFT4T5AKUHdqXwpPBePKG+ZJ2tYk4smAYSsqpO4M/hRJ1QsHFMqJPusUK6lE
         avCkrhDe7T9tpcdgUWhgMBzynMRrFdwbnGZ80ak7bIf1Ugu6P0YSKipJ+kKRsHNmVTsQ
         YqcKkjSxAHLwlSTPb+WDADB9io3e5ienkB2n+phM9nv9P7ZnFPhQZ5JNYQ0xh0ziSTYM
         cfk/wSDZnfO9lh6GZVMqRZ2GKdhSbZOAvvXkOMUyG9HoE4btrneL7eocD8XJessnIwWy
         xQgKsxMFGhhHJOU2xdbPT4F2HINmy+jqafpmF6jq1X9ELb0KT6OTzeSFHGMduJCNYXBi
         JAtQ==
X-Gm-Message-State: AOAM530A7X+J1pDO4dYIy1pIkziMrAb70Tv4VOtcvV/AM43o9Oc7JnHi
        rEtTERLQp4d5GWo9epYxZzAVTPgX68ry
X-Google-Smtp-Source: ABdhPJzAD1uSMi8YsJUXosEwObWwUYm3gLkL2OePseWoq7hMzwl7e09jXvL5kdWYzQA3fZ+qcwlvKA==
X-Received: by 2002:a37:a9c4:0:b0:6a6:8992:e400 with SMTP id s187-20020a37a9c4000000b006a68992e400mr8916475qke.494.1654371052650;
        Sat, 04 Jun 2022 12:30:52 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:30:52 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 02/33] lib/string_helpers: Convert string_escape_mem() to printbuf
Date:   Sat,  4 Jun 2022 15:30:11 -0400
Message-Id: <20220604193042.1674951-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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
 lib/string_helpers.c           | 134 +++++++++++----------------------
 2 files changed, 49 insertions(+), 89 deletions(-)

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
index 4f877e9551..3b1118337e 100644
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
@@ -517,11 +466,10 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  * truncated, compare the return value to osz. There is room left in
  * dst for a '\0' terminator if and only if ret < osz.
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
 
@@ -549,41 +497,49 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
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
2.36.0

