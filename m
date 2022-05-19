Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1810752DB25
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbiESRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbiESRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E652A30A6;
        Thu, 19 May 2022 10:24:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso9347050pjj.4;
        Thu, 19 May 2022 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+dNM37QEx17IBKysc6iUKUoZP5TiyCNd77IbXsvUTU=;
        b=ilYhHUCTeM2PGbu+Gbl82yFrFoxxHnlsrFbrmojIxAT4eb/TExD3ZCdh4zoRysxDqa
         UWzZgGTls4Xal+cjkq7JsA7H/aIr1gRMzr5mKPFuEp+8mjxJZdcGX8mJqsNkJhZQMUj+
         RdgOd03pQrmMWyIrc3qKo6zicrjJH3wD/oRx4jFMu/nGl4jILdND6OlwQl5nK9swLtPA
         0ya81KB505meC6JJJJRge7+TFTqBv/5S+ezDnQ8ypf1ovYLPd4TDRCnMhNH81pcibX93
         6ZlxTBabn3PcaBiR+Asxe9QOOren+VnqTyD8+exbaxesWYH4uxsMsQRXkhe14RHjiShH
         6IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+dNM37QEx17IBKysc6iUKUoZP5TiyCNd77IbXsvUTU=;
        b=GsWdpTltEklf5DDNGTRr4OaUY55pRz1+3jdIOH/haKc2A+42eUKOyPcARJjGnwjkgH
         /ewT+BsInwsvxUBWWPzeyPbHmSFgsaPcv4AK8ZjUI71ADTlYt104b7ynzPcl30YjWfjZ
         Y944IjyvWPV8DMVRhptGkTwZ6IzE8ubZHFW4FvDeigAwm6NgSnsMuMEfKVJT7xh8u3h5
         Y+rfBRlQ5m3lNWtl6vrM/WbfZ0tMK4sKQ/pSkEsh+a8oolq/1J+J3T65OtgNyFjXVyYP
         xecLZZied1+3m0pYl6w9tt8ihqaP1Tx4NrcHXd0oMNR6DSAXtheMAgXvc/houIAhbXds
         msVg==
X-Gm-Message-State: AOAM531OfW1V82psw8BJlNQFQWh/RbFNlMD9I9MsrR+H3IbKT4WX9lVh
        HUjCNGEId6/vxILzlShmMdYuv4RfIp18
X-Google-Smtp-Source: ABdhPJxYOYGpapJgRGgJXVv/CJvK0rdMk+XsqzUeNJCcAV632qYmKqzc0xOkEOta+wFIUSXbXtBjKQ==
X-Received: by 2002:a17:902:ef43:b0:156:9c5d:b0fe with SMTP id e3-20020a170902ef4300b001569c5db0femr5703136plx.158.1652981074766;
        Thu, 19 May 2022 10:24:34 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:33 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 02/28] vsprintf: Convert to printbuf
Date:   Thu, 19 May 2022 13:23:55 -0400
Message-Id: <20220519172421.162394-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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

This converts vsnprintf() to printbufs: instead of passing around raw
char * pointers for current buf position and end of buf, we have a real
type!

This makes the calling convention for our existing pretty printers a lot
saner and less error prone, plus printbufs add some new helpers that
make the code smaller and more readable, with a lot less crazy pointer
arithmetic.

There are a lot more refactorings to be done: this patch tries to stick
to just converting the calling conventions, as that needs to be done all
at once in order to avoid introducing a ton of wrappers that will just
be deleted.

Thankfully we have good unit tests for printf, and they have been run
and are all passing with this patch.

We have two new exported functions with this patch:
 - pr_buf(), which is like snprintf but outputs to a printbuf
 - vpr_buf, like vsnprintf

These are the actual core print routines now - vsnprintf() is a wrapper
around vpr_buf().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/kernel.h         |    4 +
 include/linux/string_helpers.h |    4 +
 lib/string_helpers.c           |   11 +
 lib/vsprintf.c                 | 1261 ++++++++++++++------------------
 4 files changed, 576 insertions(+), 704 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 33f47a9965..ca9149de7c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -202,6 +202,10 @@ extern int num_to_str(char *buf, int size,
 
 /* lib/printf utilities */
 
+struct printbuf;
+extern __printf(2, 3) void pr_buf(struct printbuf *out, const char *fmt, ...);
+extern __printf(2, 0) void vpr_buf(struct printbuf *out, const char *fmt, va_list);
+
 extern __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
 extern __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
 extern __printf(3, 4)
diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 7a22921c9d..2e56b4ce98 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -10,6 +10,7 @@
 struct device;
 struct file;
 struct task_struct;
+struct printbuf;
 
 /* Descriptions of the types of units to
  * print in */
@@ -71,6 +72,9 @@ static inline int string_escape_mem_any_np(const char *src, size_t isz,
 	return string_escape_mem(src, isz, dst, osz, ESCAPE_ANY_NP, only);
 }
 
+void pr_escaped_string(struct printbuf *out, const char *src, size_t isz,
+		       unsigned int flags, const char *only);
+
 static inline int string_escape_str(const char *src, char *dst, size_t sz,
 		unsigned int flags, const char *only)
 {
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 90f9f1b7af..c890e83f59 100644
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
@@ -587,6 +588,16 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 }
 EXPORT_SYMBOL(string_escape_mem);
 
+void pr_escaped_string(struct printbuf *out,
+		       const char *src, size_t isz,
+		       unsigned int flags, const char *only)
+{
+	out->pos += string_escape_mem(src, isz, out->buf + out->pos,
+				      printbuf_remaining(out),
+				      flags, only);
+}
+EXPORT_SYMBOL(pr_escaped_string);
+
 /*
  * Return an allocated string that has been escaped of special characters
  * and double quotes, making it safe to log in quotes.
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd37..09b259e030 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -44,6 +44,7 @@
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
 #endif
+#include <linux/printbuf.h>
 
 #include "../mm/internal.h"	/* For the trace_print_flags arrays */
 
@@ -446,8 +447,8 @@ static_assert(sizeof(struct printf_spec) == 8);
 #define PRECISION_MAX ((1 << 15) - 1)
 
 static noinline_for_stack
-char *number(char *buf, char *end, unsigned long long num,
-	     struct printf_spec spec)
+void number(struct printbuf *out, unsigned long long num,
+	    struct printf_spec spec)
 {
 	/* put_dec requires 2-byte alignment of the buffer. */
 	char tmp[3 * sizeof(num)] __aligned(2);
@@ -507,67 +508,40 @@ char *number(char *buf, char *end, unsigned long long num,
 	if (i > precision)
 		precision = i;
 	/* leading space padding */
-	field_width -= precision;
+	field_width = max(0, field_width - precision);
 	if (!(spec.flags & (ZEROPAD | LEFT))) {
-		while (--field_width >= 0) {
-			if (buf < end)
-				*buf = ' ';
-			++buf;
-		}
+		pr_chars(out, ' ', field_width);
+		field_width = 0;
 	}
 	/* sign */
-	if (sign) {
-		if (buf < end)
-			*buf = sign;
-		++buf;
-	}
+	if (sign)
+		__pr_char(out, sign);
 	/* "0x" / "0" prefix */
 	if (need_pfx) {
-		if (spec.base == 16 || !is_zero) {
-			if (buf < end)
-				*buf = '0';
-			++buf;
-		}
-		if (spec.base == 16) {
-			if (buf < end)
-				*buf = ('X' | locase);
-			++buf;
-		}
+		if (spec.base == 16 || !is_zero)
+			__pr_char(out, '0');
+		if (spec.base == 16)
+			__pr_char(out, 'X' | locase);
 	}
 	/* zero or space padding */
 	if (!(spec.flags & LEFT)) {
 		char c = ' ' + (spec.flags & ZEROPAD);
 
-		while (--field_width >= 0) {
-			if (buf < end)
-				*buf = c;
-			++buf;
-		}
+		pr_chars(out, c, field_width);
+		field_width = 0;
 	}
 	/* hmm even more zero padding? */
-	while (i <= --precision) {
-		if (buf < end)
-			*buf = '0';
-		++buf;
-	}
+	if (precision > i)
+		pr_chars(out, '0', precision - i);
 	/* actual digits of result */
-	while (--i >= 0) {
-		if (buf < end)
-			*buf = tmp[i];
-		++buf;
-	}
+	while (--i >= 0)
+		__pr_char(out, tmp[i]);
 	/* trailing space padding */
-	while (--field_width >= 0) {
-		if (buf < end)
-			*buf = ' ';
-		++buf;
-	}
-
-	return buf;
+	pr_chars(out, ' ', field_width);
 }
 
 static noinline_for_stack
-char *special_hex_number(char *buf, char *end, unsigned long long num, int size)
+void special_hex_number(struct printbuf *out, unsigned long long num, int size)
 {
 	struct printf_spec spec;
 
@@ -577,25 +551,28 @@ char *special_hex_number(char *buf, char *end, unsigned long long num, int size)
 	spec.base = 16;
 	spec.precision = -1;
 
-	return number(buf, end, num, spec);
+	number(out, num, spec);
 }
 
-static void move_right(char *buf, char *end, unsigned len, unsigned spaces)
+/*
+ * inserts @spaces spaces @len from the end of @out
+ */
+static void move_right(struct printbuf *out,
+		       unsigned len, unsigned spaces)
 {
-	size_t size;
-	if (buf >= end)	/* nowhere to put anything */
-		return;
-	size = end - buf;
-	if (size <= spaces) {
-		memset(buf, ' ', size);
-		return;
-	}
-	if (len) {
-		if (len > size - spaces)
-			len = size - spaces;
-		memmove(buf + spaces, buf, len);
-	}
-	memset(buf, ' ', spaces);
+	unsigned move_src = out->pos - len;
+	unsigned move_dst = move_src + spaces;
+	unsigned remaining_from_dst = move_dst < out->size ? out->size - move_dst : 0;
+	unsigned remaining_from_src = move_src < out->size ? out->size - move_src : 0;
+
+	BUG_ON(len > out->pos);
+
+	memmove(out->buf + move_dst,
+		out->buf + move_src,
+		min(remaining_from_dst, len));
+	memset(out->buf + move_src, ' ',
+	       min(remaining_from_src, spaces));
+	out->pos += spaces;
 }
 
 /*
@@ -607,67 +584,55 @@ static void move_right(char *buf, char *end, unsigned len, unsigned spaces)
  * Returns: new buffer position after padding.
  */
 static noinline_for_stack
-char *widen_string(char *buf, int n, char *end, struct printf_spec spec)
+void widen_string(struct printbuf *out, int n,
+		  struct printf_spec spec)
 {
 	unsigned spaces;
 
 	if (likely(n >= spec.field_width))
-		return buf;
+		return;
 	/* we want to pad the sucker */
 	spaces = spec.field_width - n;
-	if (!(spec.flags & LEFT)) {
-		move_right(buf - n, end, n, spaces);
-		return buf + spaces;
-	}
-	while (spaces--) {
-		if (buf < end)
-			*buf = ' ';
-		++buf;
-	}
-	return buf;
+	if (!(spec.flags & LEFT))
+		move_right(out, n, spaces);
+	else
+		pr_chars(out, ' ', spaces);
 }
 
 /* Handle string from a well known address. */
-static char *string_nocheck(char *buf, char *end, const char *s,
-			    struct printf_spec spec)
+static void string_nocheck(struct printbuf *out,
+			   const char *s,
+			   struct printf_spec spec)
 {
-	int len = 0;
-	int lim = spec.precision;
+	int len = min_t(unsigned, strlen(s), spec.precision);
 
-	while (lim--) {
-		char c = *s++;
-		if (!c)
-			break;
-		if (buf < end)
-			*buf = c;
-		++buf;
-		++len;
-	}
-	return widen_string(buf, len, end, spec);
+	pr_bytes(out, s, len);
+	widen_string(out, len, spec);
 }
 
-static char *err_ptr(char *buf, char *end, void *ptr,
-		     struct printf_spec spec)
+static void err_ptr(struct printbuf *out, void *ptr,
+		    struct printf_spec spec)
 {
 	int err = PTR_ERR(ptr);
 	const char *sym = errname(err);
 
-	if (sym)
-		return string_nocheck(buf, end, sym, spec);
-
-	/*
-	 * Somebody passed ERR_PTR(-1234) or some other non-existing
-	 * Efoo - or perhaps CONFIG_SYMBOLIC_ERRNAME=n. Fall back to
-	 * printing it as its decimal representation.
-	 */
-	spec.flags |= SIGN;
-	spec.base = 10;
-	return number(buf, end, err, spec);
+	if (sym) {
+		string_nocheck(out, sym, spec);
+	} else {
+		/*
+		 * Somebody passed ERR_PTR(-1234) or some other non-existing
+		 * Efoo - or perhaps CONFIG_SYMBOLIC_ERRNAME=n. Fall back to
+		 * printing it as its decimal representation.
+		 */
+		spec.flags |= SIGN;
+		spec.base = 10;
+		number(out, err, spec);
+	}
 }
 
 /* Be careful: error messages must fit into the given buffer. */
-static char *error_string(char *buf, char *end, const char *s,
-			  struct printf_spec spec)
+static void error_string(struct printbuf *out, const char *s,
+			 struct printf_spec spec)
 {
 	/*
 	 * Hard limit to avoid a completely insane messages. It actually
@@ -677,7 +642,7 @@ static char *error_string(char *buf, char *end, const char *s,
 	if (spec.precision == -1)
 		spec.precision = 2 * sizeof(void *);
 
-	return string_nocheck(buf, end, s, spec);
+	string_nocheck(out, s, spec);
 }
 
 /*
@@ -696,14 +661,15 @@ static const char *check_pointer_msg(const void *ptr)
 	return NULL;
 }
 
-static int check_pointer(char **buf, char *end, const void *ptr,
+static int check_pointer(struct printbuf *out,
+			 const void *ptr,
 			 struct printf_spec spec)
 {
 	const char *err_msg;
 
 	err_msg = check_pointer_msg(ptr);
 	if (err_msg) {
-		*buf = error_string(*buf, end, err_msg, spec);
+		error_string(out, err_msg, spec);
 		return -EFAULT;
 	}
 
@@ -711,18 +677,19 @@ static int check_pointer(char **buf, char *end, const void *ptr,
 }
 
 static noinline_for_stack
-char *string(char *buf, char *end, const char *s,
-	     struct printf_spec spec)
+void string(struct printbuf *out,
+	    const char *s,
+	    struct printf_spec spec)
 {
-	if (check_pointer(&buf, end, s, spec))
-		return buf;
+	if (check_pointer(out, s, spec))
+		return;
 
-	return string_nocheck(buf, end, s, spec);
+	string_nocheck(out, s, spec);
 }
 
-static char *pointer_string(char *buf, char *end,
-			    const void *ptr,
-			    struct printf_spec spec)
+static void pointer_string(struct printbuf *out,
+			   const void *ptr,
+			   struct printf_spec spec)
 {
 	spec.base = 16;
 	spec.flags |= SMALL;
@@ -731,7 +698,7 @@ static char *pointer_string(char *buf, char *end,
 		spec.flags |= ZEROPAD;
 	}
 
-	return number(buf, end, (unsigned long int)ptr, spec);
+	number(out, (unsigned long int)ptr, spec);
 }
 
 /* Make pointers available for printing early in the boot sequence. */
@@ -818,8 +785,9 @@ int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 	return __ptr_to_hashval(ptr, hashval_out);
 }
 
-static char *ptr_to_id(char *buf, char *end, const void *ptr,
-		       struct printf_spec spec)
+static void ptr_to_id(struct printbuf *out,
+		      const void *ptr,
+		      struct printf_spec spec)
 {
 	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
 	unsigned long hashval;
@@ -830,34 +798,35 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	 * as they are not actual addresses.
 	 */
 	if (IS_ERR_OR_NULL(ptr))
-		return pointer_string(buf, end, ptr, spec);
+		return pointer_string(out, ptr, spec);
 
 	/* When debugging early boot use non-cryptographically secure hash. */
 	if (unlikely(debug_boot_weak_hash)) {
 		hashval = hash_long((unsigned long)ptr, 32);
-		return pointer_string(buf, end, (const void *)hashval, spec);
+		return pointer_string(out, (const void *)hashval, spec);
 	}
 
 	ret = __ptr_to_hashval(ptr, &hashval);
 	if (ret) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-		return error_string(buf, end, str, spec);
+		return error_string(out, str, spec);
 	}
 
-	return pointer_string(buf, end, (const void *)hashval, spec);
+	pointer_string(out, (const void *)hashval, spec);
 }
 
 int kptr_restrict __read_mostly;
 
 static noinline_for_stack
-char *restricted_pointer(char *buf, char *end, const void *ptr,
-			 struct printf_spec spec)
+void restricted_pointer(struct printbuf *out,
+			const void *ptr,
+			struct printf_spec spec)
 {
 	switch (kptr_restrict) {
 	case 0:
 		/* Handle as %p, hash and do _not_ leak addresses. */
-		return ptr_to_id(buf, end, ptr, spec);
+		return ptr_to_id(out, ptr, spec);
 	case 1: {
 		const struct cred *cred;
 
@@ -868,7 +837,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		if (in_irq() || in_serving_softirq() || in_nmi()) {
 			if (spec.field_width == -1)
 				spec.field_width = 2 * sizeof(ptr);
-			return error_string(buf, end, "pK-error", spec);
+			return error_string(out, "pK-error", spec);
 		}
 
 		/*
@@ -894,12 +863,13 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		break;
 	}
 
-	return pointer_string(buf, end, ptr, spec);
+	return pointer_string(out, ptr, spec);
 }
 
 static noinline_for_stack
-char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_spec spec,
-		  const char *fmt)
+void dentry_name(struct printbuf *out,
+		 const struct dentry *d, struct printf_spec spec,
+		 const char *fmt)
 {
 	const char *array[4], *s;
 	const struct dentry *p;
@@ -916,9 +886,9 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 
 	rcu_read_lock();
 	for (i = 0; i < depth; i++, d = p) {
-		if (check_pointer(&buf, end, d, spec)) {
+		if (check_pointer(out, d, spec)) {
 			rcu_read_unlock();
-			return buf;
+			return;
 		}
 
 		p = READ_ONCE(d->d_parent);
@@ -931,7 +901,7 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 		}
 	}
 	s = array[--i];
-	for (n = 0; n != spec.precision; n++, buf++) {
+	for (n = 0; n != spec.precision; n++) {
 		char c = *s++;
 		if (!c) {
 			if (!i)
@@ -939,49 +909,46 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 			c = '/';
 			s = array[--i];
 		}
-		if (buf < end)
-			*buf = c;
+		__pr_char(out, c);
 	}
 	rcu_read_unlock();
-	return widen_string(buf, n, end, spec);
+	widen_string(out, n, spec);
 }
 
 static noinline_for_stack
-char *file_dentry_name(char *buf, char *end, const struct file *f,
-			struct printf_spec spec, const char *fmt)
+void file_dentry_name(struct printbuf *out,
+		      const struct file *f,
+		      struct printf_spec spec, const char *fmt)
 {
-	if (check_pointer(&buf, end, f, spec))
-		return buf;
+	if (check_pointer(out, f, spec))
+		return;
 
-	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
+	return dentry_name(out, f->f_path.dentry, spec, fmt);
 }
 #ifdef CONFIG_BLOCK
 static noinline_for_stack
-char *bdev_name(char *buf, char *end, struct block_device *bdev,
-		struct printf_spec spec, const char *fmt)
+void bdev_name(struct printbuf *out,
+	       struct block_device *bdev,
+	       struct printf_spec spec, const char *fmt)
 {
 	struct gendisk *hd;
 
-	if (check_pointer(&buf, end, bdev, spec))
-		return buf;
+	if (check_pointer(out, bdev, spec))
+		return;
 
 	hd = bdev->bd_disk;
-	buf = string(buf, end, hd->disk_name, spec);
+	string(out, hd->disk_name, spec);
 	if (bdev->bd_partno) {
-		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
-			if (buf < end)
-				*buf = 'p';
-			buf++;
-		}
-		buf = number(buf, end, bdev->bd_partno, spec);
+		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
+			__pr_char(out, 'p');
+		number(out, bdev->bd_partno, spec);
 	}
-	return buf;
 }
 #endif
 
 static noinline_for_stack
-char *symbol_string(char *buf, char *end, void *ptr,
-		    struct printf_spec spec, const char *fmt)
+void symbol_string(struct printbuf *out, void *ptr,
+		   struct printf_spec spec, const char *fmt)
 {
 	unsigned long value;
 #ifdef CONFIG_KALLSYMS
@@ -1004,9 +971,9 @@ char *symbol_string(char *buf, char *end, void *ptr,
 	else
 		sprint_symbol_no_offset(sym, value);
 
-	return string_nocheck(buf, end, sym, spec);
+	string_nocheck(out, sym, spec);
 #else
-	return special_hex_number(buf, end, value, sizeof(void *));
+	special_hex_number(out, value, sizeof(void *));
 #endif
 }
 
@@ -1041,8 +1008,8 @@ static const struct printf_spec default_dec04_spec = {
 };
 
 static noinline_for_stack
-char *resource_string(char *buf, char *end, struct resource *res,
-		      struct printf_spec spec, const char *fmt)
+void resource_string(struct printbuf *out, struct resource *res,
+		     struct printf_spec spec, const char *fmt)
 {
 #ifndef IO_RSRC_PRINTK_SIZE
 #define IO_RSRC_PRINTK_SIZE	6
@@ -1081,69 +1048,68 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+	char sym_buf[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
 		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
-
-	char *p = sym, *pend = sym + sizeof(sym);
+	struct printbuf sym = PRINTBUF_EXTERN(sym_buf, sizeof(sym_buf));
 	int decode = (fmt[0] == 'R') ? 1 : 0;
 	const struct printf_spec *specp;
 
-	if (check_pointer(&buf, end, res, spec))
-		return buf;
+	if (check_pointer(out, res, spec))
+		return;
 
-	*p++ = '[';
+	__pr_char(&sym, '[');
 	if (res->flags & IORESOURCE_IO) {
-		p = string_nocheck(p, pend, "io  ", str_spec);
+		string_nocheck(&sym, "io  ", str_spec);
 		specp = &io_spec;
 	} else if (res->flags & IORESOURCE_MEM) {
-		p = string_nocheck(p, pend, "mem ", str_spec);
+		string_nocheck(&sym, "mem ", str_spec);
 		specp = &mem_spec;
 	} else if (res->flags & IORESOURCE_IRQ) {
-		p = string_nocheck(p, pend, "irq ", str_spec);
+		string_nocheck(&sym, "irq ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_DMA) {
-		p = string_nocheck(p, pend, "dma ", str_spec);
+		string_nocheck(&sym, "dma ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_BUS) {
-		p = string_nocheck(p, pend, "bus ", str_spec);
+		string_nocheck(&sym, "bus ", str_spec);
 		specp = &bus_spec;
 	} else {
-		p = string_nocheck(p, pend, "??? ", str_spec);
+		string_nocheck(&sym, "??? ", str_spec);
 		specp = &mem_spec;
 		decode = 0;
 	}
 	if (decode && res->flags & IORESOURCE_UNSET) {
-		p = string_nocheck(p, pend, "size ", str_spec);
-		p = number(p, pend, resource_size(res), *specp);
+		string_nocheck(&sym, "size ", str_spec);
+		number(&sym, resource_size(res), *specp);
 	} else {
-		p = number(p, pend, res->start, *specp);
+		number(&sym, res->start, *specp);
 		if (res->start != res->end) {
-			*p++ = '-';
-			p = number(p, pend, res->end, *specp);
+			__pr_char(&sym, '-');
+			number(&sym, res->end, *specp);
 		}
 	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
-			p = string_nocheck(p, pend, " 64bit", str_spec);
+			string_nocheck(&sym, " 64bit", str_spec);
 		if (res->flags & IORESOURCE_PREFETCH)
-			p = string_nocheck(p, pend, " pref", str_spec);
+			string_nocheck(&sym, " pref", str_spec);
 		if (res->flags & IORESOURCE_WINDOW)
-			p = string_nocheck(p, pend, " window", str_spec);
+			string_nocheck(&sym, " window", str_spec);
 		if (res->flags & IORESOURCE_DISABLED)
-			p = string_nocheck(p, pend, " disabled", str_spec);
+			string_nocheck(&sym, " disabled", str_spec);
 	} else {
-		p = string_nocheck(p, pend, " flags ", str_spec);
-		p = number(p, pend, res->flags, default_flag_spec);
+		string_nocheck(&sym, " flags ", str_spec);
+		number(&sym, res->flags, default_flag_spec);
 	}
-	*p++ = ']';
-	*p = '\0';
+	__pr_char(&sym, ']');
+	printbuf_nul_terminate(&sym);
 
-	return string_nocheck(buf, end, sym, spec);
+	string_nocheck(out, sym_buf, spec);
 }
 
 static noinline_for_stack
-char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
-		 const char *fmt)
+void hex_string(struct printbuf *out, u8 *addr,
+		struct printf_spec spec, const char *fmt)
 {
 	int i, len = 1;		/* if we pass '%ph[CDN]', field width remains
 				   negative value, fallback to the default */
@@ -1151,10 +1117,10 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 
 	if (spec.field_width == 0)
 		/* nothing to print */
-		return buf;
+		return;
 
-	if (check_pointer(&buf, end, addr, spec))
-		return buf;
+	if (check_pointer(out, addr, spec))
+		return;
 
 	switch (fmt[1]) {
 	case 'C':
@@ -1175,34 +1141,25 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		len = min_t(int, spec.field_width, 64);
 
 	for (i = 0; i < len; ++i) {
-		if (buf < end)
-			*buf = hex_asc_hi(addr[i]);
-		++buf;
-		if (buf < end)
-			*buf = hex_asc_lo(addr[i]);
-		++buf;
-
-		if (separator && i != len - 1) {
-			if (buf < end)
-				*buf = separator;
-			++buf;
-		}
-	}
+		__pr_char(out, hex_asc_hi(addr[i]));
+		__pr_char(out, hex_asc_lo(addr[i]));
 
-	return buf;
+		if (separator && i != len - 1)
+			__pr_char(out, separator);
+	}
 }
 
 static noinline_for_stack
-char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
-		    struct printf_spec spec, const char *fmt)
+void bitmap_string(struct printbuf *out, unsigned long *bitmap,
+		   struct printf_spec spec, const char *fmt)
 {
 	const int CHUNKSZ = 32;
 	int nr_bits = max_t(int, spec.field_width, 0);
 	int i, chunksz;
 	bool first = true;
 
-	if (check_pointer(&buf, end, bitmap, spec))
-		return buf;
+	if (check_pointer(out, bitmap, spec))
+		return;
 
 	/* reused to print numbers */
 	spec = (struct printf_spec){ .flags = SMALL | ZEROPAD, .base = 16 };
@@ -1221,54 +1178,45 @@ char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
 		bit = i % BITS_PER_LONG;
 		val = (bitmap[word] >> bit) & chunkmask;
 
-		if (!first) {
-			if (buf < end)
-				*buf = ',';
-			buf++;
-		}
+		if (!first)
+			__pr_char(out, ',');
 		first = false;
 
 		spec.field_width = DIV_ROUND_UP(chunksz, 4);
-		buf = number(buf, end, val, spec);
+		number(out, val, spec);
 
 		chunksz = CHUNKSZ;
 	}
-	return buf;
 }
 
 static noinline_for_stack
-char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
-			 struct printf_spec spec, const char *fmt)
+void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
+			struct printf_spec spec, const char *fmt)
 {
 	int nr_bits = max_t(int, spec.field_width, 0);
 	bool first = true;
 	int rbot, rtop;
 
-	if (check_pointer(&buf, end, bitmap, spec))
-		return buf;
+	if (check_pointer(out, bitmap, spec))
+		return ;
 
 	for_each_set_bitrange(rbot, rtop, bitmap, nr_bits) {
-		if (!first) {
-			if (buf < end)
-				*buf = ',';
-			buf++;
-		}
+		if (!first)
+			__pr_char(out, ',');
 		first = false;
 
-		buf = number(buf, end, rbot, default_dec_spec);
+		number(out, rbot, default_dec_spec);
 		if (rtop == rbot + 1)
 			continue;
 
-		if (buf < end)
-			*buf = '-';
-		buf = number(++buf, end, rtop - 1, default_dec_spec);
+		__pr_char(out, '-');
+		number(out, rtop - 1, default_dec_spec);
 	}
-	return buf;
 }
 
 static noinline_for_stack
-char *mac_address_string(char *buf, char *end, u8 *addr,
-			 struct printf_spec spec, const char *fmt)
+void mac_address_string(struct printbuf *out, u8 *addr,
+			struct printf_spec spec, const char *fmt)
 {
 	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
 	char *p = mac_addr;
@@ -1276,8 +1224,8 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	char separator;
 	bool reversed = false;
 
-	if (check_pointer(&buf, end, addr, spec))
-		return buf;
+	if (check_pointer(out, addr, spec))
+		return;
 
 	switch (fmt[1]) {
 	case 'F':
@@ -1304,11 +1252,12 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	}
 	*p = '\0';
 
-	return string_nocheck(buf, end, mac_addr, spec);
+	string_nocheck(out, mac_addr, spec);
 }
 
 static noinline_for_stack
-char *ip4_string(char *p, const u8 *addr, const char *fmt)
+void ip4_string(struct printbuf *out,
+		const u8 *addr, const char *fmt)
 {
 	int i;
 	bool leading_zeros = (fmt[0] == 'i');
@@ -1341,24 +1290,23 @@ char *ip4_string(char *p, const u8 *addr, const char *fmt)
 		int digits = put_dec_trunc8(temp, addr[index]) - temp;
 		if (leading_zeros) {
 			if (digits < 3)
-				*p++ = '0';
+				__pr_char(out, '0');
 			if (digits < 2)
-				*p++ = '0';
+				__pr_char(out, '0');
 		}
 		/* reverse the digits in the quad */
 		while (digits--)
-			*p++ = temp[digits];
+			__pr_char(out, temp[digits]);
 		if (i < 3)
-			*p++ = '.';
+			__pr_char(out, '.');
 		index += step;
 	}
-	*p = '\0';
 
-	return p;
+	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
-char *ip6_compressed_string(char *p, const char *addr)
+void ip6_compressed_string(struct printbuf *out, const char *addr)
 {
 	int i, j, range;
 	unsigned char zerolength[8];
@@ -1402,14 +1350,14 @@ char *ip6_compressed_string(char *p, const char *addr)
 	for (i = 0; i < range; i++) {
 		if (i == colonpos) {
 			if (needcolon || i == 0)
-				*p++ = ':';
-			*p++ = ':';
+				__pr_char(out, ':');
+			__pr_char(out, ':');
 			needcolon = false;
 			i += longest - 1;
 			continue;
 		}
 		if (needcolon) {
-			*p++ = ':';
+			__pr_char(out, ':');
 			needcolon = false;
 		}
 		/* hex u16 without leading 0s */
@@ -1418,81 +1366,81 @@ char *ip6_compressed_string(char *p, const char *addr)
 		lo = word & 0xff;
 		if (hi) {
 			if (hi > 0x0f)
-				p = hex_byte_pack(p, hi);
+				pr_hex_byte(out, hi);
 			else
-				*p++ = hex_asc_lo(hi);
-			p = hex_byte_pack(p, lo);
+				__pr_char(out, hex_asc_lo(hi));
+			pr_hex_byte(out, lo);
 		}
 		else if (lo > 0x0f)
-			p = hex_byte_pack(p, lo);
+			pr_hex_byte(out, lo);
 		else
-			*p++ = hex_asc_lo(lo);
+			__pr_char(out, hex_asc_lo(lo));
 		needcolon = true;
 	}
 
 	if (useIPv4) {
 		if (needcolon)
-			*p++ = ':';
-		p = ip4_string(p, &in6.s6_addr[12], "I4");
+			__pr_char(out, ':');
+		ip4_string(out, &in6.s6_addr[12], "I4");
 	}
-	*p = '\0';
 
-	return p;
+	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
-char *ip6_string(char *p, const char *addr, const char *fmt)
+void ip6_string(struct printbuf *out, const char *addr, const char *fmt)
 {
 	int i;
 
 	for (i = 0; i < 8; i++) {
-		p = hex_byte_pack(p, *addr++);
-		p = hex_byte_pack(p, *addr++);
+		pr_hex_byte(out, *addr++);
+		pr_hex_byte(out, *addr++);
 		if (fmt[0] == 'I' && i != 7)
-			*p++ = ':';
+			__pr_char(out, ':');
 	}
-	*p = '\0';
 
-	return p;
+	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
-char *ip6_addr_string(char *buf, char *end, const u8 *addr,
-		      struct printf_spec spec, const char *fmt)
+void ip6_addr_string(struct printbuf *out, const u8 *addr,
+		     struct printf_spec spec, const char *fmt)
 {
-	char ip6_addr[sizeof("xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255")];
+	char ip6_addr_buf[sizeof("xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255")];
+	struct printbuf ip6_addr = PRINTBUF_EXTERN(ip6_addr_buf, sizeof(ip6_addr_buf));
 
 	if (fmt[0] == 'I' && fmt[2] == 'c')
-		ip6_compressed_string(ip6_addr, addr);
+		ip6_compressed_string(&ip6_addr, addr);
 	else
-		ip6_string(ip6_addr, addr, fmt);
+		ip6_string(&ip6_addr, addr, fmt);
 
-	return string_nocheck(buf, end, ip6_addr, spec);
+	string_nocheck(out, ip6_addr_buf, spec);
 }
 
 static noinline_for_stack
-char *ip4_addr_string(char *buf, char *end, const u8 *addr,
-		      struct printf_spec spec, const char *fmt)
+void ip4_addr_string(struct printbuf *out, const u8 *addr,
+		     struct printf_spec spec, const char *fmt)
 {
-	char ip4_addr[sizeof("255.255.255.255")];
+	char ip4_addr_buf[sizeof("255.255.255.255")];
+	struct printbuf ip4_addr = PRINTBUF_EXTERN(ip4_addr_buf, sizeof(ip4_addr_buf));
 
-	ip4_string(ip4_addr, addr, fmt);
+	ip4_string(&ip4_addr, addr, fmt);
 
-	return string_nocheck(buf, end, ip4_addr, spec);
+	string_nocheck(out, ip4_addr_buf, spec);
 }
 
 static noinline_for_stack
-char *ip6_addr_string_sa(char *buf, char *end, const struct sockaddr_in6 *sa,
-			 struct printf_spec spec, const char *fmt)
+void ip6_addr_string_sa(struct printbuf *out,
+			const struct sockaddr_in6 *sa,
+			struct printf_spec spec, const char *fmt)
 {
 	bool have_p = false, have_s = false, have_f = false, have_c = false;
-	char ip6_addr[sizeof("[xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255]") +
-		      sizeof(":12345") + sizeof("/123456789") +
-		      sizeof("%1234567890")];
-	char *p = ip6_addr, *pend = ip6_addr + sizeof(ip6_addr);
+	char ip6_addr_buf[sizeof("[xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255]") +
+		sizeof(":12345") + sizeof("/123456789") +
+		sizeof("%1234567890")];
+	struct printbuf ip6_addr = PRINTBUF_EXTERN(ip6_addr_buf, sizeof(ip6_addr_buf));
 	const u8 *addr = (const u8 *) &sa->sin6_addr;
 	char fmt6[2] = { fmt[0], '6' };
-	u8 off = 0;
 
 	fmt++;
 	while (isalpha(*++fmt)) {
@@ -1512,44 +1460,43 @@ char *ip6_addr_string_sa(char *buf, char *end, const struct sockaddr_in6 *sa,
 		}
 	}
 
-	if (have_p || have_s || have_f) {
-		*p = '[';
-		off = 1;
-	}
+	if (have_p || have_s || have_f)
+		__pr_char(&ip6_addr, '[');
 
 	if (fmt6[0] == 'I' && have_c)
-		p = ip6_compressed_string(ip6_addr + off, addr);
+		ip6_compressed_string(&ip6_addr, addr);
 	else
-		p = ip6_string(ip6_addr + off, addr, fmt6);
+		ip6_string(&ip6_addr, addr, fmt6);
 
 	if (have_p || have_s || have_f)
-		*p++ = ']';
+		__pr_char(&ip6_addr, ']');
 
 	if (have_p) {
-		*p++ = ':';
-		p = number(p, pend, ntohs(sa->sin6_port), spec);
+		__pr_char(&ip6_addr, ':');
+		number(&ip6_addr, ntohs(sa->sin6_port), spec);
 	}
 	if (have_f) {
-		*p++ = '/';
-		p = number(p, pend, ntohl(sa->sin6_flowinfo &
-					  IPV6_FLOWINFO_MASK), spec);
+		__pr_char(&ip6_addr, '/');
+		number(&ip6_addr, ntohl(sa->sin6_flowinfo &
+					IPV6_FLOWINFO_MASK), spec);
 	}
 	if (have_s) {
-		*p++ = '%';
-		p = number(p, pend, sa->sin6_scope_id, spec);
+		__pr_char(&ip6_addr, '%');
+		number(&ip6_addr, sa->sin6_scope_id, spec);
 	}
-	*p = '\0';
+	printbuf_nul_terminate(&ip6_addr);
 
-	return string_nocheck(buf, end, ip6_addr, spec);
+	string_nocheck(out, ip6_addr_buf, spec);
 }
 
 static noinline_for_stack
-char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
-			 struct printf_spec spec, const char *fmt)
+void ip4_addr_string_sa(struct printbuf *out,
+			const struct sockaddr_in *sa,
+			struct printf_spec spec, const char *fmt)
 {
 	bool have_p = false;
-	char *p, ip4_addr[sizeof("255.255.255.255") + sizeof(":12345")];
-	char *pend = ip4_addr + sizeof(ip4_addr);
+	char ip4_addr_buf[sizeof("255.255.255.255") + sizeof(":12345")];
+	struct printbuf ip4_addr = PRINTBUF_EXTERN(ip4_addr_buf, sizeof(ip4_addr_buf));
 	const u8 *addr = (const u8 *) &sa->sin_addr.s_addr;
 	char fmt4[3] = { fmt[0], '4', 0 };
 
@@ -1568,30 +1515,30 @@ char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
 		}
 	}
 
-	p = ip4_string(ip4_addr, addr, fmt4);
+	ip4_string(&ip4_addr, addr, fmt4);
 	if (have_p) {
-		*p++ = ':';
-		p = number(p, pend, ntohs(sa->sin_port), spec);
+		__pr_char(&ip4_addr, ':');
+		number(&ip4_addr, ntohs(sa->sin_port), spec);
 	}
-	*p = '\0';
+	printbuf_nul_terminate(&ip4_addr);
 
-	return string_nocheck(buf, end, ip4_addr, spec);
+	string_nocheck(out, ip4_addr_buf, spec);
 }
 
 static noinline_for_stack
-char *ip_addr_string(char *buf, char *end, const void *ptr,
-		     struct printf_spec spec, const char *fmt)
+void ip_addr_string(struct printbuf *out, const void *ptr,
+		    struct printf_spec spec, const char *fmt)
 {
 	char *err_fmt_msg;
 
-	if (check_pointer(&buf, end, ptr, spec))
-		return buf;
+	if (check_pointer(out, ptr, spec))
+		return;
 
 	switch (fmt[1]) {
 	case '6':
-		return ip6_addr_string(buf, end, ptr, spec, fmt);
+		return ip6_addr_string(out, ptr, spec, fmt);
 	case '4':
-		return ip4_addr_string(buf, end, ptr, spec, fmt);
+		return ip4_addr_string(out, ptr, spec, fmt);
 	case 'S': {
 		const union {
 			struct sockaddr		raw;
@@ -1601,21 +1548,21 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
 
 		switch (sa->raw.sa_family) {
 		case AF_INET:
-			return ip4_addr_string_sa(buf, end, &sa->v4, spec, fmt);
+			return ip4_addr_string_sa(out, &sa->v4, spec, fmt);
 		case AF_INET6:
-			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
+			return ip6_addr_string_sa(out, &sa->v6, spec, fmt);
 		default:
-			return error_string(buf, end, "(einval)", spec);
+			return error_string(out, "(einval)", spec);
 		}}
 	}
 
 	err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
-	return error_string(buf, end, err_fmt_msg, spec);
+	return error_string(out, err_fmt_msg, spec);
 }
 
 static noinline_for_stack
-char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
-		     const char *fmt)
+void escaped_string(struct printbuf *out, u8 *addr,
+		    struct printf_spec spec, const char *fmt)
 {
 	bool found = true;
 	int count = 1;
@@ -1623,10 +1570,10 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	int len;
 
 	if (spec.field_width == 0)
-		return buf;				/* nothing to print */
+		return;				/* nothing to print */
 
-	if (check_pointer(&buf, end, addr, spec))
-		return buf;
+	if (check_pointer(out, addr, spec))
+		return;
 
 	do {
 		switch (fmt[count++]) {
@@ -1661,44 +1608,35 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		flags = ESCAPE_ANY_NP;
 
 	len = spec.field_width < 0 ? 1 : spec.field_width;
-
-	/*
-	 * string_escape_mem() writes as many characters as it can to
-	 * the given buffer, and returns the total size of the output
-	 * had the buffer been big enough.
-	 */
-	buf += string_escape_mem(addr, len, buf, buf < end ? end - buf : 0, flags, NULL);
-
-	return buf;
+	pr_escaped_string(out, addr, len, flags, NULL);
 }
 
-static char *va_format(char *buf, char *end, struct va_format *va_fmt,
-		       struct printf_spec spec, const char *fmt)
+static void va_format(struct printbuf *out,
+		      struct va_format *va_fmt,
+		      struct printf_spec spec, const char *fmt)
 {
 	va_list va;
 
-	if (check_pointer(&buf, end, va_fmt, spec))
-		return buf;
+	if (check_pointer(out, va_fmt, spec))
+		return;
 
 	va_copy(va, *va_fmt->va);
-	buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
+	vpr_buf(out, va_fmt->fmt, va);
 	va_end(va);
-
-	return buf;
 }
 
 static noinline_for_stack
-char *uuid_string(char *buf, char *end, const u8 *addr,
-		  struct printf_spec spec, const char *fmt)
+void uuid_string(struct printbuf *out, const u8 *addr,
+		 struct printf_spec spec, const char *fmt)
 {
-	char uuid[UUID_STRING_LEN + 1];
-	char *p = uuid;
+	char uuid_buf[UUID_STRING_LEN + 1];
+	struct printbuf uuid = PRINTBUF_EXTERN(uuid_buf, sizeof(uuid_buf));
 	int i;
 	const u8 *index = uuid_index;
 	bool uc = false;
 
-	if (check_pointer(&buf, end, addr, spec))
-		return buf;
+	if (check_pointer(out, addr, spec))
+		return;
 
 	switch (*(++fmt)) {
 	case 'L':
@@ -1714,60 +1652,60 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 
 	for (i = 0; i < 16; i++) {
 		if (uc)
-			p = hex_byte_pack_upper(p, addr[index[i]]);
+			pr_hex_byte_upper(&uuid, addr[index[i]]);
 		else
-			p = hex_byte_pack(p, addr[index[i]]);
+			pr_hex_byte(&uuid, addr[index[i]]);
 		switch (i) {
 		case 3:
 		case 5:
 		case 7:
 		case 9:
-			*p++ = '-';
+			__pr_char(&uuid, '-');
 			break;
 		}
 	}
 
-	*p = 0;
+	printbuf_nul_terminate(&uuid);
 
-	return string_nocheck(buf, end, uuid, spec);
+	string_nocheck(out, uuid_buf, spec);
 }
 
 static noinline_for_stack
-char *netdev_bits(char *buf, char *end, const void *addr,
-		  struct printf_spec spec,  const char *fmt)
+void netdev_bits(struct printbuf *out, const void *addr,
+		 struct printf_spec spec,  const char *fmt)
 {
 	unsigned long long num;
 	int size;
 
-	if (check_pointer(&buf, end, addr, spec))
-		return buf;
+	if (check_pointer(out, addr, spec))
+		return;
 
 	switch (fmt[1]) {
 	case 'F':
 		num = *(const netdev_features_t *)addr;
 		size = sizeof(netdev_features_t);
+		special_hex_number(out, num, size);
 		break;
 	default:
-		return error_string(buf, end, "(%pN?)", spec);
+		error_string(out, "(%pN?)", spec);
+		break;
 	}
-
-	return special_hex_number(buf, end, num, size);
 }
 
 static noinline_for_stack
-char *fourcc_string(char *buf, char *end, const u32 *fourcc,
-		    struct printf_spec spec, const char *fmt)
+void fourcc_string(struct printbuf *out, const u32 *fourcc,
+		   struct printf_spec spec, const char *fmt)
 {
-	char output[sizeof("0123 little-endian (0x01234567)")];
-	char *p = output;
+	char output_buf[sizeof("0123 little-endian (0x01234567)")];
+	struct printbuf output = PRINTBUF_EXTERN(output_buf, sizeof(output_buf));
 	unsigned int i;
 	u32 val;
 
 	if (fmt[1] != 'c' || fmt[2] != 'c')
-		return error_string(buf, end, "(%p4?)", spec);
+		return error_string(out, "(%p4?)", spec);
 
-	if (check_pointer(&buf, end, fourcc, spec))
-		return buf;
+	if (check_pointer(out, fourcc, spec))
+		return;
 
 	val = *fourcc & ~BIT(31);
 
@@ -1775,30 +1713,29 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
 		unsigned char c = val >> (i * 8);
 
 		/* Print non-control ASCII characters as-is, dot otherwise */
-		*p++ = isascii(c) && isprint(c) ? c : '.';
+		__pr_char(&output, isascii(c) && isprint(c) ? c : '.');
 	}
 
-	strcpy(p, *fourcc & BIT(31) ? " big-endian" : " little-endian");
-	p += strlen(p);
+	pr_str(&output, *fourcc & BIT(31) ? " big-endian" : " little-endian");
 
-	*p++ = ' ';
-	*p++ = '(';
-	p = special_hex_number(p, output + sizeof(output) - 2, *fourcc, sizeof(u32));
-	*p++ = ')';
-	*p = '\0';
+	__pr_char(&output, ' ');
+	__pr_char(&output, '(');
+	special_hex_number(&output, *fourcc, sizeof(u32));
+	__pr_char(&output, ')');
+	printbuf_nul_terminate(&output);
 
-	return string(buf, end, output, spec);
+	string(out, output_buf, spec);
 }
 
 static noinline_for_stack
-char *address_val(char *buf, char *end, const void *addr,
-		  struct printf_spec spec, const char *fmt)
+void address_val(struct printbuf *out, const void *addr,
+		 struct printf_spec spec, const char *fmt)
 {
 	unsigned long long num;
 	int size;
 
-	if (check_pointer(&buf, end, addr, spec))
-		return buf;
+	if (check_pointer(out, addr, spec))
+		return;
 
 	switch (fmt[1]) {
 	case 'd':
@@ -1812,55 +1749,44 @@ char *address_val(char *buf, char *end, const void *addr,
 		break;
 	}
 
-	return special_hex_number(buf, end, num, size);
+	special_hex_number(out, num, size);
 }
 
 static noinline_for_stack
-char *date_str(char *buf, char *end, const struct rtc_time *tm, bool r)
+void date_str(struct printbuf *out,
+	      const struct rtc_time *tm, bool r)
 {
 	int year = tm->tm_year + (r ? 0 : 1900);
 	int mon = tm->tm_mon + (r ? 0 : 1);
 
-	buf = number(buf, end, year, default_dec04_spec);
-	if (buf < end)
-		*buf = '-';
-	buf++;
-
-	buf = number(buf, end, mon, default_dec02_spec);
-	if (buf < end)
-		*buf = '-';
-	buf++;
-
-	return number(buf, end, tm->tm_mday, default_dec02_spec);
+	number(out, year, default_dec04_spec);
+	__pr_char(out, '-');
+	number(out, mon, default_dec02_spec);
+	__pr_char(out, '-');
+	number(out, tm->tm_mday, default_dec02_spec);
 }
 
 static noinline_for_stack
-char *time_str(char *buf, char *end, const struct rtc_time *tm, bool r)
+void time_str(struct printbuf *out, const struct rtc_time *tm, bool r)
 {
-	buf = number(buf, end, tm->tm_hour, default_dec02_spec);
-	if (buf < end)
-		*buf = ':';
-	buf++;
-
-	buf = number(buf, end, tm->tm_min, default_dec02_spec);
-	if (buf < end)
-		*buf = ':';
-	buf++;
-
-	return number(buf, end, tm->tm_sec, default_dec02_spec);
+	number(out, tm->tm_hour, default_dec02_spec);
+	__pr_char(out, ':');
+	number(out, tm->tm_min, default_dec02_spec);
+	__pr_char(out, ':');
+	number(out, tm->tm_sec, default_dec02_spec);
 }
 
 static noinline_for_stack
-char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
-	      struct printf_spec spec, const char *fmt)
+void rtc_str(struct printbuf *out, const struct rtc_time *tm,
+	     struct printf_spec spec, const char *fmt)
 {
 	bool have_t = true, have_d = true;
 	bool raw = false, iso8601_separator = true;
 	bool found = true;
 	int count = 2;
 
-	if (check_pointer(&buf, end, tm, spec))
-		return buf;
+	if (check_pointer(out, tm, spec))
+		return;
 
 	switch (fmt[count]) {
 	case 'd':
@@ -1888,21 +1814,16 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
 	} while (found);
 
 	if (have_d)
-		buf = date_str(buf, end, tm, raw);
-	if (have_d && have_t) {
-		if (buf < end)
-			*buf = iso8601_separator ? 'T' : ' ';
-		buf++;
-	}
+		date_str(out, tm, raw);
+	if (have_d && have_t)
+		__pr_char(out, iso8601_separator ? 'T' : ' ');
 	if (have_t)
-		buf = time_str(buf, end, tm, raw);
-
-	return buf;
+		time_str(out, tm, raw);
 }
 
 static noinline_for_stack
-char *time64_str(char *buf, char *end, const time64_t time,
-		 struct printf_spec spec, const char *fmt)
+void time64_str(struct printbuf *out, const time64_t time,
+		struct printf_spec spec, const char *fmt)
 {
 	struct rtc_time rtc_time;
 	struct tm tm;
@@ -1920,47 +1841,48 @@ char *time64_str(char *buf, char *end, const time64_t time,
 
 	rtc_time.tm_isdst = 0;
 
-	return rtc_str(buf, end, &rtc_time, spec, fmt);
+	rtc_str(out, &rtc_time, spec, fmt);
 }
 
 static noinline_for_stack
-char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
-		    const char *fmt)
+void time_and_date(struct printbuf *out,
+		   void *ptr, struct printf_spec spec,
+		   const char *fmt)
 {
 	switch (fmt[1]) {
 	case 'R':
-		return rtc_str(buf, end, (const struct rtc_time *)ptr, spec, fmt);
+		return rtc_str(out, (const struct rtc_time *)ptr, spec, fmt);
 	case 'T':
-		return time64_str(buf, end, *(const time64_t *)ptr, spec, fmt);
+		return time64_str(out, *(const time64_t *)ptr, spec, fmt);
 	default:
-		return error_string(buf, end, "(%pt?)", spec);
+		return error_string(out, "(%pt?)", spec);
 	}
 }
 
 static noinline_for_stack
-char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
-	    const char *fmt)
+void clock(struct printbuf *out, struct clk *clk,
+	   struct printf_spec spec, const char *fmt)
 {
 	if (!IS_ENABLED(CONFIG_HAVE_CLK))
-		return error_string(buf, end, "(%pC?)", spec);
+		return error_string(out, "(%pC?)", spec);
 
-	if (check_pointer(&buf, end, clk, spec))
-		return buf;
+	if (check_pointer(out, clk, spec))
+		return;
 
 	switch (fmt[1]) {
 	case 'n':
 	default:
 #ifdef CONFIG_COMMON_CLK
-		return string(buf, end, __clk_get_name(clk), spec);
+		return string(out, __clk_get_name(clk), spec);
 #else
-		return ptr_to_id(buf, end, clk, spec);
+		return ptr_to_id(out, clk, spec);
 #endif
 	}
 }
 
 static
-char *format_flags(char *buf, char *end, unsigned long flags,
-					const struct trace_print_flags *names)
+void format_flags(struct printbuf *out, unsigned long flags,
+		  const struct trace_print_flags *names)
 {
 	unsigned long mask;
 
@@ -1969,20 +1891,15 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 		if ((flags & mask) != mask)
 			continue;
 
-		buf = string(buf, end, names->name, default_str_spec);
+		string(out, names->name, default_str_spec);
 
 		flags &= ~mask;
-		if (flags) {
-			if (buf < end)
-				*buf = '|';
-			buf++;
-		}
+		if (flags)
+			__pr_char(out, '|');
 	}
 
 	if (flags)
-		buf = number(buf, end, flags, default_flag_spec);
-
-	return buf;
+		number(out, flags, default_flag_spec);
 }
 
 struct page_flags_fields {
@@ -2007,20 +1924,18 @@ static const struct page_flags_fields pff[] = {
 };
 
 static
-char *format_page_flags(char *buf, char *end, unsigned long flags)
+void format_page_flags(struct printbuf *out, unsigned long flags)
 {
 	unsigned long main_flags = flags & PAGEFLAGS_MASK;
 	bool append = false;
 	int i;
 
-	buf = number(buf, end, flags, default_flag_spec);
-	if (buf < end)
-		*buf = '(';
-	buf++;
+	number(out, flags, default_flag_spec);
+	__pr_char(out, '(');
 
 	/* Page flags from the main area. */
 	if (main_flags) {
-		buf = format_flags(buf, end, main_flags, pageflag_names);
+		format_flags(out, main_flags, pageflag_names);
 		append = true;
 	}
 
@@ -2031,41 +1946,31 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
 			continue;
 
 		/* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
-		if (append) {
-			if (buf < end)
-				*buf = '|';
-			buf++;
-		}
+		if (append)
+			__pr_char(out, '|');
 
-		buf = string(buf, end, pff[i].name, default_str_spec);
-		if (buf < end)
-			*buf = '=';
-		buf++;
-		buf = number(buf, end, (flags >> pff[i].shift) & pff[i].mask,
-			     *pff[i].spec);
+		string(out, pff[i].name, default_str_spec);
+		__pr_char(out, '=');
+		number(out, (flags >> pff[i].shift) & pff[i].mask, *pff[i].spec);
 
 		append = true;
 	}
-	if (buf < end)
-		*buf = ')';
-	buf++;
-
-	return buf;
+	__pr_char(out, ')');
 }
 
 static noinline_for_stack
-char *flags_string(char *buf, char *end, void *flags_ptr,
-		   struct printf_spec spec, const char *fmt)
+void flags_string(struct printbuf *out, void *flags_ptr,
+		  struct printf_spec spec, const char *fmt)
 {
 	unsigned long flags;
 	const struct trace_print_flags *names;
 
-	if (check_pointer(&buf, end, flags_ptr, spec))
-		return buf;
+	if (check_pointer(out, flags_ptr, spec))
+		return;
 
 	switch (fmt[1]) {
 	case 'p':
-		return format_page_flags(buf, end, *(unsigned long *)flags_ptr);
+		return format_page_flags(out, *(unsigned long *)flags_ptr);
 	case 'v':
 		flags = *(unsigned long *)flags_ptr;
 		names = vmaflag_names;
@@ -2075,15 +1980,15 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 		names = gfpflag_names;
 		break;
 	default:
-		return error_string(buf, end, "(%pG?)", spec);
+		return error_string(out, "(%pG?)", spec);
 	}
 
-	return format_flags(buf, end, flags, names);
+	return format_flags(out, flags, names);
 }
 
 static noinline_for_stack
-char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
-			      char *end)
+void fwnode_full_name_string(struct printbuf *out,
+			     struct fwnode_handle *fwnode)
 {
 	int depth;
 
@@ -2092,25 +1997,23 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
 		struct fwnode_handle *__fwnode =
 			fwnode_get_nth_parent(fwnode, depth);
 
-		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
-			     default_str_spec);
-		buf = string(buf, end, fwnode_get_name(__fwnode),
-			     default_str_spec);
+		string(out, fwnode_get_name_prefix(__fwnode),
+		       default_str_spec);
+		string(out, fwnode_get_name(__fwnode),
+		       default_str_spec);
 
 		fwnode_handle_put(__fwnode);
 	}
-
-	return buf;
 }
 
 static noinline_for_stack
-char *device_node_string(char *buf, char *end, struct device_node *dn,
-			 struct printf_spec spec, const char *fmt)
+void device_node_string(struct printbuf *out, struct device_node *dn,
+			struct printf_spec spec, const char *fmt)
 {
 	char tbuf[sizeof("xxxx") + 1];
 	const char *p;
 	int ret;
-	char *buf_start = buf;
+	unsigned start = out->pos;
 	struct property *prop;
 	bool has_mult, pass;
 
@@ -2118,13 +2021,13 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	str_spec.field_width = -1;
 
 	if (fmt[0] != 'F')
-		return error_string(buf, end, "(%pO?)", spec);
+		return error_string(out, "(%pO?)", spec);
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return error_string(buf, end, "(%pOF?)", spec);
+		return error_string(out, "(%pOF?)", spec);
 
-	if (check_pointer(&buf, end, dn, spec))
-		return buf;
+	if (check_pointer(out, dn, spec))
+		return;
 
 	/* simple case without anything any more format specifiers */
 	fmt++;
@@ -2133,32 +2036,28 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 
 	for (pass = false; strspn(fmt,"fnpPFcC"); fmt++, pass = true) {
 		int precision;
-		if (pass) {
-			if (buf < end)
-				*buf = ':';
-			buf++;
-		}
+		if (pass)
+			__pr_char(out, ':');
 
 		switch (*fmt) {
 		case 'f':	/* full_name */
-			buf = fwnode_full_name_string(of_fwnode_handle(dn), buf,
-						      end);
+			fwnode_full_name_string(out, of_fwnode_handle(dn));
 			break;
 		case 'n':	/* name */
 			p = fwnode_get_name(of_fwnode_handle(dn));
 			precision = str_spec.precision;
 			str_spec.precision = strchrnul(p, '@') - p;
-			buf = string(buf, end, p, str_spec);
+			string(out, p, str_spec);
 			str_spec.precision = precision;
 			break;
 		case 'p':	/* phandle */
-			buf = number(buf, end, (unsigned int)dn->phandle, default_dec_spec);
+			number(out, (unsigned int)dn->phandle, default_dec_spec);
 			break;
 		case 'P':	/* path-spec */
 			p = fwnode_get_name(of_fwnode_handle(dn));
 			if (!p[1])
 				p = "/";
-			buf = string(buf, end, p, str_spec);
+			string(out, p, str_spec);
 			break;
 		case 'F':	/* flags */
 			tbuf[0] = of_node_check_flag(dn, OF_DYNAMIC) ? 'D' : '-';
@@ -2166,21 +2065,21 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			tbuf[2] = of_node_check_flag(dn, OF_POPULATED) ? 'P' : '-';
 			tbuf[3] = of_node_check_flag(dn, OF_POPULATED_BUS) ? 'B' : '-';
 			tbuf[4] = 0;
-			buf = string_nocheck(buf, end, tbuf, str_spec);
+			string_nocheck(out, tbuf, str_spec);
 			break;
 		case 'c':	/* major compatible string */
 			ret = of_property_read_string(dn, "compatible", &p);
 			if (!ret)
-				buf = string(buf, end, p, str_spec);
+				string(out, p, str_spec);
 			break;
 		case 'C':	/* full compatible string */
 			has_mult = false;
 			of_property_for_each_string(dn, "compatible", prop, p) {
 				if (has_mult)
-					buf = string_nocheck(buf, end, ",", str_spec);
-				buf = string_nocheck(buf, end, "\"", str_spec);
-				buf = string(buf, end, p, str_spec);
-				buf = string_nocheck(buf, end, "\"", str_spec);
+					string_nocheck(out, ",", str_spec);
+				string_nocheck(out, "\"", str_spec);
+				string(out, p, str_spec);
+				string_nocheck(out, "\"", str_spec);
 
 				has_mult = true;
 			}
@@ -2190,37 +2089,38 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 		}
 	}
 
-	return widen_string(buf, buf - buf_start, end, spec);
+	widen_string(out, out->pos - start, spec);
 }
 
 static noinline_for_stack
-char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
-		    struct printf_spec spec, const char *fmt)
+void fwnode_string(struct printbuf *out,
+		   struct fwnode_handle *fwnode,
+		   struct printf_spec spec, const char *fmt)
 {
 	struct printf_spec str_spec = spec;
-	char *buf_start = buf;
+	unsigned start = out->pos;
 
 	str_spec.field_width = -1;
 
 	if (*fmt != 'w')
-		return error_string(buf, end, "(%pf?)", spec);
+		return error_string(out, "(%pf?)", spec);
 
-	if (check_pointer(&buf, end, fwnode, spec))
-		return buf;
+	if (check_pointer(out, fwnode, spec))
+		return;
 
 	fmt++;
 
 	switch (*fmt) {
 	case 'P':	/* name */
-		buf = string(buf, end, fwnode_get_name(fwnode), str_spec);
+		string(out, fwnode_get_name(fwnode), str_spec);
 		break;
 	case 'f':	/* full_name */
 	default:
-		buf = fwnode_full_name_string(fwnode, buf, end);
+		fwnode_full_name_string(out, fwnode);
 		break;
 	}
 
-	return widen_string(buf, buf - buf_start, end, spec);
+	widen_string(out, out->pos - start, spec);
 }
 
 /* Disable pointer hashing if requested */
@@ -2380,8 +2280,8 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  * rendering it useful as a unique identifier.
  */
 static noinline_for_stack
-char *pointer(const char *fmt, char *buf, char *end, void *ptr,
-	      struct printf_spec spec)
+void pointer(struct printbuf *out, const char *fmt,
+	     void *ptr, struct printf_spec spec)
 {
 	switch (*fmt) {
 	case 'S':
@@ -2389,24 +2289,24 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		ptr = dereference_symbol_descriptor(ptr);
 		fallthrough;
 	case 'B':
-		return symbol_string(buf, end, ptr, spec, fmt);
+		return symbol_string(out, ptr, spec, fmt);
 	case 'R':
 	case 'r':
-		return resource_string(buf, end, ptr, spec, fmt);
+		return resource_string(out, ptr, spec, fmt);
 	case 'h':
-		return hex_string(buf, end, ptr, spec, fmt);
+		return hex_string(out, ptr, spec, fmt);
 	case 'b':
 		switch (fmt[1]) {
 		case 'l':
-			return bitmap_list_string(buf, end, ptr, spec, fmt);
+			return bitmap_list_string(out, ptr, spec, fmt);
 		default:
-			return bitmap_string(buf, end, ptr, spec, fmt);
+			return bitmap_string(out, ptr, spec, fmt);
 		}
 	case 'M':			/* Colon separated: 00:01:02:03:04:05 */
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
 					/* [mM]R (Reverse order; Bluetooth) */
-		return mac_address_string(buf, end, ptr, spec, fmt);
+		return mac_address_string(out, ptr, spec, fmt);
 	case 'I':			/* Formatted IP supported
 					 * 4:	1.2.3.4
 					 * 6:	0001:0203:...:0708
@@ -2416,54 +2316,54 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 					 * 4:	001.002.003.004
 					 * 6:   000102...0f
 					 */
-		return ip_addr_string(buf, end, ptr, spec, fmt);
+		return ip_addr_string(out, ptr, spec, fmt);
 	case 'E':
-		return escaped_string(buf, end, ptr, spec, fmt);
+		return escaped_string(out, ptr, spec, fmt);
 	case 'U':
-		return uuid_string(buf, end, ptr, spec, fmt);
+		return uuid_string(out, ptr, spec, fmt);
 	case 'V':
-		return va_format(buf, end, ptr, spec, fmt);
+		return va_format(out, ptr, spec, fmt);
 	case 'K':
-		return restricted_pointer(buf, end, ptr, spec);
+		return restricted_pointer(out, ptr, spec);
 	case 'N':
-		return netdev_bits(buf, end, ptr, spec, fmt);
+		return netdev_bits(out, ptr, spec, fmt);
 	case '4':
-		return fourcc_string(buf, end, ptr, spec, fmt);
+		return fourcc_string(out, ptr, spec, fmt);
 	case 'a':
-		return address_val(buf, end, ptr, spec, fmt);
+		return address_val(out, ptr, spec, fmt);
 	case 'd':
-		return dentry_name(buf, end, ptr, spec, fmt);
+		return dentry_name(out, ptr, spec, fmt);
 	case 't':
-		return time_and_date(buf, end, ptr, spec, fmt);
+		return time_and_date(out, ptr, spec, fmt);
 	case 'C':
-		return clock(buf, end, ptr, spec, fmt);
+		return clock(out, ptr, spec, fmt);
 	case 'D':
-		return file_dentry_name(buf, end, ptr, spec, fmt);
+		return file_dentry_name(out, ptr, spec, fmt);
 #ifdef CONFIG_BLOCK
 	case 'g':
-		return bdev_name(buf, end, ptr, spec, fmt);
+		return bdev_name(out, ptr, spec, fmt);
 #endif
 
 	case 'G':
-		return flags_string(buf, end, ptr, spec, fmt);
+		return flags_string(out, ptr, spec, fmt);
 	case 'O':
-		return device_node_string(buf, end, ptr, spec, fmt + 1);
+		return device_node_string(out, ptr, spec, fmt + 1);
 	case 'f':
-		return fwnode_string(buf, end, ptr, spec, fmt + 1);
+		return fwnode_string(out, ptr, spec, fmt + 1);
 	case 'x':
-		return pointer_string(buf, end, ptr, spec);
+		return pointer_string(out, ptr, spec);
 	case 'e':
 		/* %pe with a non-ERR_PTR gets treated as plain %p */
 		if (!IS_ERR(ptr))
 			break;
-		return err_ptr(buf, end, ptr, spec);
+		return err_ptr(out, ptr, spec);
 	case 'u':
 	case 'k':
 		switch (fmt[1]) {
 		case 's':
-			return string(buf, end, ptr, spec);
+			return string(out, ptr, spec);
 		default:
-			return error_string(buf, end, "(einval)", spec);
+			return error_string(out, "(einval)", spec);
 		}
 	}
 
@@ -2472,9 +2372,9 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	 * unless no_hash_pointers is specified on the command line.
 	 */
 	if (unlikely(no_hash_pointers))
-		return pointer_string(buf, end, ptr, spec);
+		return pointer_string(out, ptr, spec);
 	else
-		return ptr_to_id(buf, end, ptr, spec);
+		return ptr_to_id(out, ptr, spec);
 }
 
 /*
@@ -2695,52 +2595,27 @@ set_precision(struct printf_spec *spec, int prec)
 }
 
 /**
- * vsnprintf - Format a string and place it in a buffer
- * @buf: The buffer to place the result into
- * @size: The size of the buffer, including the trailing null space
+ * vpr_buf - Format a string, outputting to a printbuf
+ * @out: The printbuf to output to
  * @fmt: The format string to use
  * @args: Arguments for the format string
  *
- * This function generally follows C99 vsnprintf, but has some
- * extensions and a few limitations:
- *
- *  - ``%n`` is unsupported
- *  - ``%p*`` is handled by pointer()
- *
- * See pointer() or Documentation/core-api/printk-formats.rst for more
- * extensive description.
+ * vpr_buf works much like the traditional vsnprintf(), but outputs to a
+ * printbuf instead of raw pointer/size.
  *
- * **Please update the documentation in both places when making changes**
+ * If you're not already dealing with a va_list consider using pr_buf().
  *
- * The return value is the number of characters which would
- * be generated for the given input, excluding the trailing
- * '\0', as per ISO C99. If you want to have the exact
- * number of characters written into @buf as return value
- * (not including the trailing '\0'), use vscnprintf(). If the
- * return is greater than or equal to @size, the resulting
- * string is truncated.
- *
- * If you're not already dealing with a va_list consider using snprintf().
+ * See the vsnprintf() documentation for format string extensions over C99.
  */
-int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
+void vpr_buf(struct printbuf *out, const char *fmt, va_list args)
 {
 	unsigned long long num;
-	char *str, *end;
 	struct printf_spec spec = {0};
 
 	/* Reject out-of-range values early.  Large positive sizes are
 	   used for unknown buffer sizes. */
-	if (WARN_ON_ONCE(size > INT_MAX))
-		return 0;
-
-	str = buf;
-	end = buf + size;
-
-	/* Make sure end is always >= buf */
-	if (end < buf) {
-		end = ((void *)-1);
-		size = end - buf;
-	}
+	if (WARN_ON_ONCE(out->size > INT_MAX))
+		return;
 
 	while (*fmt) {
 		const char *old_fmt = fmt;
@@ -2749,16 +2624,9 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 		fmt += read;
 
 		switch (spec.type) {
-		case FORMAT_TYPE_NONE: {
-			int copy = read;
-			if (str < end) {
-				if (copy > end - str)
-					copy = end - str;
-				memcpy(str, old_fmt, copy);
-			}
-			str += read;
+		case FORMAT_TYPE_NONE:
+			pr_bytes(out, old_fmt, read);
 			break;
-		}
 
 		case FORMAT_TYPE_WIDTH:
 			set_field_width(&spec, va_arg(args, int));
@@ -2768,44 +2636,29 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 			set_precision(&spec, va_arg(args, int));
 			break;
 
-		case FORMAT_TYPE_CHAR: {
-			char c;
+		case FORMAT_TYPE_CHAR:
+			if (spec.field_width > 0 && !(spec.flags & LEFT))
+				pr_chars(out, spec.field_width, ' ');
 
-			if (!(spec.flags & LEFT)) {
-				while (--spec.field_width > 0) {
-					if (str < end)
-						*str = ' ';
-					++str;
+			__pr_char(out, (unsigned char) va_arg(args, int));
 
-				}
-			}
-			c = (unsigned char) va_arg(args, int);
-			if (str < end)
-				*str = c;
-			++str;
-			while (--spec.field_width > 0) {
-				if (str < end)
-					*str = ' ';
-				++str;
-			}
+			if (spec.field_width > 0 && (spec.flags & LEFT))
+				pr_chars(out, spec.field_width, ' ');
+			spec.field_width = 0;
 			break;
-		}
 
 		case FORMAT_TYPE_STR:
-			str = string(str, end, va_arg(args, char *), spec);
+			string(out, va_arg(args, char *), spec);
 			break;
 
 		case FORMAT_TYPE_PTR:
-			str = pointer(fmt, str, end, va_arg(args, void *),
-				      spec);
+			pointer(out, fmt, va_arg(args, void *), spec);
 			while (isalnum(*fmt))
 				fmt++;
 			break;
 
 		case FORMAT_TYPE_PERCENT_CHAR:
-			if (str < end)
-				*str = '%';
-			++str;
+			__pr_char(out, '%');
 			break;
 
 		case FORMAT_TYPE_INVALID:
@@ -2858,21 +2711,71 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 				num = va_arg(args, unsigned int);
 			}
 
-			str = number(str, end, num, spec);
+			number(out, num, spec);
 		}
 	}
-
 out:
-	if (size > 0) {
-		if (str < end)
-			*str = '\0';
-		else
-			end[-1] = '\0';
-	}
+	printbuf_nul_terminate(out);
+}
+EXPORT_SYMBOL(vpr_buf);
 
-	/* the trailing null byte doesn't count towards the total */
-	return str-buf;
+/**
+ * pr_buf - Format a string, outputting to a printbuf
+ * @out: The printbuf to output to
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ *
+ * pr_buf works much like the traditional sprintf(), but outputs to a
+ * printbuf instead of raw pointer/size.
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+void pr_buf(struct printbuf *out, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vpr_buf(out, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL(pr_buf);
+
+/**
+ * vsnprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * This function generally follows C99 vsnprintf, but has some
+ * extensions and a few limitations:
+ *
+ *  - ``%n`` is unsupported
+ *  - ``%p*`` is handled by pointer()
+ *
+ * See pointer() or Documentation/core-api/printk-formats.rst for more
+ * extensive description.
+ *
+ * **Please update the documentation in both places when making changes**
+ *
+ * The return value is the number of characters which would
+ * be generated for the given input, excluding the trailing
+ * '\0', as per ISO C99. If you want to have the exact
+ * number of characters written into @buf as return value
+ * (not including the trailing '\0'), use vscnprintf(). If the
+ * return is greater than or equal to @size, the resulting
+ * string is truncated.
+ *
+ * If you're not already dealing with a va_list consider using snprintf().
+ */
+int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	struct printbuf out = PRINTBUF_EXTERN(buf, size);
 
+	vpr_buf(&out, fmt, args);
+
+	return out.pos;
 }
 EXPORT_SYMBOL(vsnprintf);
 
@@ -3008,6 +2911,13 @@ EXPORT_SYMBOL(sprintf);
  * bstr_printf() - Binary data to text string
  */
 
+static inline void printbuf_align(struct printbuf *out, unsigned align)
+{
+	/* Assumes output buffer is correctly aligned: */
+	out->pos += align - 1;
+	out->pos &= ~(align - 1);
+}
+
 /**
  * vbin_printf - Parse a format string and place args' binary value in a buffer
  * @bin_buf: The buffer to place args' binary value
@@ -3027,34 +2937,25 @@ EXPORT_SYMBOL(sprintf);
  */
 int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 {
+	struct printbuf out = PRINTBUF_EXTERN((char *) bin_buf, size);
 	struct printf_spec spec = {0};
-	char *str, *end;
 	int width;
 
-	str = (char *)bin_buf;
-	end = (char *)(bin_buf + size);
-
 #define save_arg(type)							\
 ({									\
 	unsigned long long value;					\
 	if (sizeof(type) == 8) {					\
-		unsigned long long val8;				\
-		str = PTR_ALIGN(str, sizeof(u32));			\
-		val8 = va_arg(args, unsigned long long);		\
-		if (str + sizeof(type) <= end) {			\
-			*(u32 *)str = *(u32 *)&val8;			\
-			*(u32 *)(str + 4) = *((u32 *)&val8 + 1);	\
-		}							\
+		u64 val8 = va_arg(args, u64);				\
+		printbuf_align(&out, sizeof(u32));			\
+		pr_bytes(&out, (u32 *) &val8, 4);			\
+		pr_bytes(&out, ((u32 *) &val8) + 1, 4);			\
 		value = val8;						\
 	} else {							\
-		unsigned int val4;					\
-		str = PTR_ALIGN(str, sizeof(type));			\
-		val4 = va_arg(args, int);				\
-		if (str + sizeof(type) <= end)				\
-			*(typeof(type) *)str = (type)(long)val4;	\
+		u32 val4 = va_arg(args, u32);				\
+		printbuf_align(&out, sizeof(type));			\
+		pr_bytes(&out, &val4, sizeof(type));			\
 		value = (unsigned long long)val4;			\
 	}								\
-	str += sizeof(type);						\
 	value;								\
 })
 
@@ -3085,16 +2986,12 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 		case FORMAT_TYPE_STR: {
 			const char *save_str = va_arg(args, char *);
 			const char *err_msg;
-			size_t len;
 
 			err_msg = check_pointer_msg(save_str);
 			if (err_msg)
 				save_str = err_msg;
 
-			len = strlen(save_str) + 1;
-			if (str + len < end)
-				memcpy(str, save_str, len);
-			str += len;
+			pr_str(&out, save_str);
 			break;
 		}
 
@@ -3114,12 +3011,7 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 					save_arg(void *);
 					break;
 				}
-				str = pointer(fmt, str, end, va_arg(args, void *),
-					      spec);
-				if (str + 1 < end)
-					*str++ = '\0';
-				else
-					end[-1] = '\0'; /* Must be nul terminated */
+				pointer(&out, fmt, va_arg(args, void *), spec);
 			}
 			/* skip all alphanumeric pointer suffixes */
 			while (isalnum(*fmt))
@@ -3157,7 +3049,9 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 	}
 
 out:
-	return (u32 *)(PTR_ALIGN(str, sizeof(u32))) - bin_buf;
+	printbuf_nul_terminate(&out);
+	printbuf_align(&out, 4);
+	return out.pos;
 #undef save_arg
 }
 EXPORT_SYMBOL_GPL(vbin_printf);
@@ -3187,14 +3081,15 @@ EXPORT_SYMBOL_GPL(vbin_printf);
 int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 {
 	struct printf_spec spec = {0};
-	char *str, *end;
+	struct printbuf out = PRINTBUF_EXTERN((char *) bin_buf, size);
 	const char *args = (const char *)bin_buf;
 
 	if (WARN_ON_ONCE(size > INT_MAX))
 		return 0;
 
-	str = buf;
-	end = buf + size;
+	/* Make sure end is always >= buf */
+	if (WARN_ON_ONCE(out.buf + out.size < out.buf))
+		return 0;
 
 #define get_arg(type)							\
 ({									\
@@ -3211,12 +3106,6 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 	value;								\
 })
 
-	/* Make sure end is always >= buf */
-	if (end < buf) {
-		end = ((void *)-1);
-		size = end - buf;
-	}
-
 	while (*fmt) {
 		const char *old_fmt = fmt;
 		int read = format_decode(fmt, &spec);
@@ -3224,16 +3113,9 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 		fmt += read;
 
 		switch (spec.type) {
-		case FORMAT_TYPE_NONE: {
-			int copy = read;
-			if (str < end) {
-				if (copy > end - str)
-					copy = end - str;
-				memcpy(str, old_fmt, copy);
-			}
-			str += read;
+		case FORMAT_TYPE_NONE:
+			pr_bytes(&out, old_fmt, read);
 			break;
-		}
 
 		case FORMAT_TYPE_WIDTH:
 			set_field_width(&spec, get_arg(int));
@@ -3243,38 +3125,24 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 			set_precision(&spec, get_arg(int));
 			break;
 
-		case FORMAT_TYPE_CHAR: {
-			char c;
-
-			if (!(spec.flags & LEFT)) {
-				while (--spec.field_width > 0) {
-					if (str < end)
-						*str = ' ';
-					++str;
-				}
-			}
-			c = (unsigned char) get_arg(char);
-			if (str < end)
-				*str = c;
-			++str;
-			while (--spec.field_width > 0) {
-				if (str < end)
-					*str = ' ';
-				++str;
-			}
+		case FORMAT_TYPE_CHAR:
+			if (!(spec.flags & LEFT))
+				pr_chars(&out, spec.field_width, ' ');
+			__pr_char(&out, (unsigned char) get_arg(char));
+			if ((spec.flags & LEFT))
+				pr_chars(&out, spec.field_width, ' ');
 			break;
-		}
 
 		case FORMAT_TYPE_STR: {
 			const char *str_arg = args;
 			args += strlen(str_arg) + 1;
-			str = string(str, end, (char *)str_arg, spec);
+			string(&out, (char *)str_arg, spec);
 			break;
 		}
 
 		case FORMAT_TYPE_PTR: {
 			bool process = false;
-			int copy, len;
+			int len;
 			/* Non function dereferences were already done */
 			switch (*fmt) {
 			case 'S':
@@ -3290,17 +3158,12 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 					break;
 				}
 				/* Pointer dereference was already processed */
-				if (str < end) {
-					len = copy = strlen(args);
-					if (copy > end - str)
-						copy = end - str;
-					memcpy(str, args, copy);
-					str += len;
-					args += len + 1;
-				}
+				len = strlen(args);
+				pr_bytes(&out, args, len);
+				args += len + 1;
 			}
 			if (process)
-				str = pointer(fmt, str, end, get_arg(void *), spec);
+				pointer(&out, fmt, get_arg(void *), spec);
 
 			while (isalnum(*fmt))
 				fmt++;
@@ -3308,9 +3171,7 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 		}
 
 		case FORMAT_TYPE_PERCENT_CHAR:
-			if (str < end)
-				*str = '%';
-			++str;
+			__pr_char(&out, '%');
 			break;
 
 		case FORMAT_TYPE_INVALID:
@@ -3353,23 +3214,15 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 				num = get_arg(int);
 			}
 
-			str = number(str, end, num, spec);
+			number(&out, num, spec);
 		} /* default: */
 		} /* switch(spec.type) */
 	} /* while(*fmt) */
 
 out:
-	if (size > 0) {
-		if (str < end)
-			*str = '\0';
-		else
-			end[-1] = '\0';
-	}
-
 #undef get_arg
-
-	/* the trailing null byte doesn't count towards the total */
-	return str - buf;
+	printbuf_nul_terminate(&out);
+	return out.pos;
 }
 EXPORT_SYMBOL_GPL(bstr_printf);
 
-- 
2.36.0

