Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B176D53D85C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiFDTbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbiFDTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD04F9CC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:01 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m68so8372010qkb.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MU9DtaSuF50B3IjXtdJRPfGcH4KUhigTNIeUQnFwNis=;
        b=I6O6qa9R3mrhrhGhFya4ywOG0hY24R5AAUSmtWprus0S2GogvRjDBcOlBqZ8dvVqBN
         2CkX9+A0uBITuwjHnP8EqW3TspJAO5MYRgVent0RWEwzyVQRi1TC9AnzjHWXK7EGKKsk
         jbohjgq2g6DKOY7QYHeppJCZCTWkR5uqm9erwmo1RH3unu0QniO7HjaG8g3Bthyoosqz
         7e5tIXNLAKvyBgCYCbdcjRfZSo0NzQbL4/o6QzOtmQEPEaPN8xCXFm4mQbd52CMGujNE
         1YH4S+13liqReBsswAl9hn1hmph07qO8Qgf2CtYVaLEcwd9H/Qgzn12QgA/RL8T+OkeL
         TM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MU9DtaSuF50B3IjXtdJRPfGcH4KUhigTNIeUQnFwNis=;
        b=TCb8aX1kSFVTvn0Ea9ptkEyG8bEkyByOh3yZE5CxUR/TOzy+8vICkh2yWl/SJ5gIn6
         5PANj/bCsBmcWthBzHIe62ax7il8rlN9dB+0eXPZ4fnX9VI9sghfiE8/cbfFGCEylabs
         mLtRFARxo1m3StIJA/M6eqpBHddBHadVT1z+wX1v/bt8XvKpODAgg32mcl7Qt1h0NroS
         psPpdDV+LhiWw8owGOvEyv+Q+v3YBaO7KQqBx2BFDR98VHjVDHf9a0GDTu7G166Ur+ns
         94ppHkJro0Hb6w3QwBFVghQvjNy9tSieW2uI+ioeyo66nhlnAWpV/05TE6azPUxDgA6T
         TrIg==
X-Gm-Message-State: AOAM5301v4UKuyU8XjH+8tVLBQL9FE2m9R1D9aXUk67ECI1hDmKjBLCU
        HpxOzgrboCcf4gGvZMiqhzS6046HlWZG
X-Google-Smtp-Source: ABdhPJx5b7OWtFu4vTDQFtt0vq8apRehNU0egcz3GMQXo6Mgh524Y0Tc5CwIbDP7NPXrtuBAWIpUkA==
X-Received: by 2002:a05:620a:2586:b0:680:f846:4708 with SMTP id x6-20020a05620a258600b00680f8464708mr10997183qko.654.1654371060527;
        Sat, 04 Jun 2022 12:31:00 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:30:59 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 07/33] lib/printbuf: Heap allocation
Date:   Sat,  4 Jun 2022 15:30:16 -0400
Message-Id: <20220604193042.1674951-8-kent.overstreet@gmail.com>
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

This makes printbufs optionally heap allocated: a printbuf initialized
with the PRINTBUF initializer will automatically heap allocate and
resize as needed.

Allocations are done with GFP_KERNEL: code should use e.g.
memalloc_nofs_save()/restore() as needed. Since we do not currently have
memalloc_nowait_save()/restore(), in contexts where it is not safe to
block we provide the helpers

  printbuf_atomic_inc()
  printbuf_atomic_dec()

When the atomic count is nonzero, memory allocations will be done with
GFP_NOWAIT.

On memory allocation failure, output will be truncated. Code that wishes
to check for memory allocation failure (in contexts where we should
return -ENOMEM) should check if printbuf->allocation_failure is set.
Since printbufs are expected to be typically used for log messages and
on a best effort basis, we don't return errors directly.

Other helpers provided by this patch:

 - printbuf_make_room(buf, extra)
   Reallocates if necessary to make room for @extra bytes (not including
   terminating null).

 - printbuf_str(buf)
   Returns a null terminated string equivalent to the contents of @buf.
   If @buf was never allocated (or allocation failed), returns a
   constant empty string.

 - printbuf_exit(buf)
   Releases memory allocated by a printbuf.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/printbuf.h | 114 +++++++++++++++++++++++++++++++++------
 lib/Makefile             |   2 +-
 lib/printbuf.c           |  70 ++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 16 deletions(-)
 create mode 100644 lib/printbuf.c

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 8b3797dc4b..35236f774a 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -4,18 +4,68 @@
 #ifndef _LINUX_PRINTBUF_H
 #define _LINUX_PRINTBUF_H
 
-#include <linux/string.h>
-
 /*
- * Printbufs: String buffer for outputting (printing) to, for vsnprintf
+ * Printbufs: Simple strings for printing to, with optional heap allocation
+ *
+ * This code has provisions for use in userspace, to aid in making other code
+ * portable between kernelspace and userspace.
+ *
+ * Basic example:
+ *   struct printbuf buf = PRINTBUF;
+ *
+ *   prt_printf(&buf, "foo=");
+ *   foo_to_text(&buf, foo);
+ *   printk("%s", buf.buf);
+ *   printbuf_exit(&buf);
+ *
+ * Or
+ *   struct printbuf buf = PRINTBUF_EXTERN(char_buf, char_buf_size)
+ *
+ * We can now write pretty printers instead of writing code that dumps
+ * everything to the kernel log buffer, and then those pretty-printers can be
+ * used by other code that outputs to kernel log, sysfs, debugfs, etc.
+ *
+ * Memory allocation: Outputing to a printbuf may allocate memory. This
+ * allocation is done with GFP_KERNEL, by default: use the newer
+ * memalloc_*_(save|restore) functions as needed.
+ *
+ * Since no equivalent yet exists for GFP_ATOMIC/GFP_NOWAIT, memory allocations
+ * will be done with GFP_NOWAIT if printbuf->atomic is nonzero.
+ *
+ * Memory allocation failures: We don't return errors directly, because on
+ * memory allocation failure we usually don't want to bail out and unwind - we
+ * want to print what we've got, on a best-effort basis. But code that does want
+ * to return -ENOMEM may check printbuf.allocation_failure.
  */
 
+#include <linux/string.h>
+
 struct printbuf {
 	char			*buf;
 	unsigned		size;
 	unsigned		pos;
+	/*
+	 * If nonzero, allocations will be done with GFP_ATOMIC:
+	 */
+	u8			atomic;
+	bool			allocation_failure:1;
+	bool			heap_allocated:1;
 };
 
+int printbuf_make_room(struct printbuf *, unsigned);
+const char *printbuf_str(const struct printbuf *);
+void printbuf_exit(struct printbuf *);
+
+/* Initializer for a heap allocated printbuf: */
+#define PRINTBUF ((struct printbuf) { .heap_allocated = true })
+
+/* Initializer a printbuf that points to an external buffer: */
+#define PRINTBUF_EXTERN(_buf, _size)			\
+((struct printbuf) {					\
+	.buf	= _buf,					\
+	.size	= _size,				\
+})
+
 /*
  * Returns size remaining of output buffer:
  */
@@ -48,13 +98,15 @@ static inline bool printbuf_overflowed(struct printbuf *out)
 
 static inline void printbuf_nul_terminate(struct printbuf *out)
 {
+	printbuf_make_room(out, 1);
+
 	if (out->pos < out->size)
 		out->buf[out->pos] = 0;
 	else if (out->size)
 		out->buf[out->size - 1] = 0;
 }
 
-static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
+static inline void __prt_chars_reserved(struct printbuf *out, char c, unsigned n)
 {
 	memset(out->buf + out->pos,
 	       c,
@@ -64,17 +116,26 @@ static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
 
 static inline void prt_chars(struct printbuf *out, char c, unsigned n)
 {
-	__prt_chars(out, c, n);
+	printbuf_make_room(out, n);
+	__prt_chars_reserved(out, c, n);
 	printbuf_nul_terminate(out);
 }
 
-static inline void __prt_char(struct printbuf *out, char c)
+/* Doesn't call printbuf_make_room(), doesn't nul terminate: */
+static inline void __prt_char_reserved(struct printbuf *out, char c)
 {
 	if (printbuf_remaining(out))
 		out->buf[out->pos] = c;
 	out->pos++;
 }
 
+/* Doesn't nul terminate: */
+static inline void __prt_char(struct printbuf *out, char c)
+{
+	printbuf_make_room(out, 1);
+	__prt_char_reserved(out, c);
+}
+
 static inline void prt_char(struct printbuf *out, char c)
 {
 	__prt_char(out, c);
@@ -83,6 +144,8 @@ static inline void prt_char(struct printbuf *out, char c)
 
 static inline void prt_bytes(struct printbuf *out, const void *b, unsigned n)
 {
+	printbuf_make_room(out, n);
+
 	memcpy(out->buf + out->pos,
 	       b,
 	       min(n, printbuf_remaining(out)));
@@ -97,22 +160,43 @@ static inline void prt_str(struct printbuf *out, const char *str)
 
 static inline void prt_hex_byte(struct printbuf *out, u8 byte)
 {
-	__prt_char(out, hex_asc_hi(byte));
-	__prt_char(out, hex_asc_lo(byte));
+	printbuf_make_room(out, 2);
+	__prt_char_reserved(out, hex_asc_hi(byte));
+	__prt_char_reserved(out, hex_asc_lo(byte));
 	printbuf_nul_terminate(out);
 }
 
 static inline void prt_hex_byte_upper(struct printbuf *out, u8 byte)
 {
-	__prt_char(out, hex_asc_upper_hi(byte));
-	__prt_char(out, hex_asc_upper_lo(byte));
+	printbuf_make_room(out, 2);
+	__prt_char_reserved(out, hex_asc_upper_hi(byte));
+	__prt_char_reserved(out, hex_asc_upper_lo(byte));
 	printbuf_nul_terminate(out);
 }
 
-#define PRINTBUF_EXTERN(_buf, _size)			\
-((struct printbuf) {					\
-	.buf	= _buf,					\
-	.size	= _size,				\
-})
+/**
+ * printbuf_reset - re-use a printbuf without freeing and re-initializing it:
+ */
+static inline void printbuf_reset(struct printbuf *buf)
+{
+	buf->pos		= 0;
+	buf->allocation_failure	= 0;
+}
+
+/**
+ * printbuf_atomic_inc - mark as entering an atomic section
+ */
+static inline void printbuf_atomic_inc(struct printbuf *buf)
+{
+	buf->atomic++;
+}
+
+/**
+ * printbuf_atomic_inc - mark as leaving an atomic section
+ */
+static inline void printbuf_atomic_dec(struct printbuf *buf)
+{
+	buf->atomic--;
+}
 
 #endif /* _LINUX_PRINTBUF_H */
diff --git a/lib/Makefile b/lib/Makefile
index 6b9ffc1bd1..b4609a4258 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
-	 buildid.o
+	 buildid.o printbuf.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/printbuf.c b/lib/printbuf.c
new file mode 100644
index 0000000000..0093b34158
--- /dev/null
+++ b/lib/printbuf.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/* Copyright (C) 2022 Kent Overstreet */
+
+#ifdef __KERNEL__
+#include <linux/export.h>
+#include <linux/kernel.h>
+#else
+#define EXPORT_SYMBOL(x)
+#endif
+
+#include <linux/slab.h>
+#include <linux/printbuf.h>
+
+int printbuf_make_room(struct printbuf *out, unsigned extra)
+{
+	unsigned new_size;
+	char *buf;
+
+	if (!out->heap_allocated)
+		return 0;
+
+	/* Reserved space for terminating nul: */
+	extra += 1;
+
+	if (out->pos + extra < out->size)
+		return 0;
+
+	new_size = roundup_pow_of_two(out->size + extra);
+	buf = krealloc(out->buf, new_size, !out->atomic ? GFP_KERNEL : GFP_NOWAIT);
+
+	if (!buf) {
+		out->allocation_failure = true;
+		return -ENOMEM;
+	}
+
+	out->buf	= buf;
+	out->size	= new_size;
+	return 0;
+}
+EXPORT_SYMBOL(printbuf_make_room);
+
+/**
+ * printbuf_str - returns printbuf's buf as a C string, guaranteed to be null
+ * terminated
+ */
+const char *printbuf_str(const struct printbuf *buf)
+{
+	/*
+	 * If we've written to a printbuf then it's guaranteed to be a null
+	 * terminated string - but if we haven't, then we might not have
+	 * allocated a buffer at all:
+	 */
+	return buf->pos
+		? buf->buf
+		: "";
+}
+EXPORT_SYMBOL(printbuf_str);
+
+/**
+ * printbuf_exit - exit a printbuf, freeing memory it owns and poisoning it
+ * against accidental use.
+ */
+void printbuf_exit(struct printbuf *buf)
+{
+	if (buf->heap_allocated) {
+		kfree(buf->buf);
+		buf->buf = ERR_PTR(-EINTR); /* poison value */
+	}
+}
+EXPORT_SYMBOL(printbuf_exit);
-- 
2.36.0

