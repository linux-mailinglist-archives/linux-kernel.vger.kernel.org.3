Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D588E592689
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbiHNVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiHNVUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:20:49 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF30CC2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqGDdTweNv7J1oVwJZ9r7zPN5qFqqWPMiJnzM6zCERo=;
        b=QjA4/YbD0OELuukz9MrO7dTiAAWsCGeAf/6Yysl3mTXUWPm0QVwahL+mcQ+f1v3iE/R8e3
        XB9KdEr3H2N6D1p07HUQMFos4Hyy+ALyNHksc6qTXDhqxJSKWmxJEGKtyrI4RSVyO3UBCq
        PH+h1bRfMYcRz5MSy5DyEJHHErZQwns=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 06/32] lib/printbuf: Heap allocation
Date:   Sun, 14 Aug 2022 17:19:45 -0400
Message-Id: <20220814212011.1727798-7-kent.overstreet@linux.dev>
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
 include/linux/printbuf.h | 124 +++++++++++++++++++++++++++++++++------
 lib/Makefile             |   2 +-
 lib/printbuf.c           |  76 ++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 18 deletions(-)
 create mode 100644 lib/printbuf.c

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 1aa3331bf0..71f631c49f 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -4,19 +4,73 @@
 #ifndef _LINUX_PRINTBUF_H
 #define _LINUX_PRINTBUF_H
 
-#include <linux/kernel.h>
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
+ * It's allowed to grab the output buffer and free it later with kfree() instead
+ * of using printbuf_exit(), if the user just needs a heap allocated string at
+ * the end.
+ *
+ * Memory allocation failures: We don't return errors directly, because on
+ * memory allocation failure we usually don't want to bail out and unwind - we
+ * want to print what we've got, on a best-effort basis. But code that does want
+ * to return -ENOMEM may check printbuf.allocation_failure.
  */
 
+#include <linux/kernel.h>
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
@@ -49,26 +103,36 @@ static inline bool printbuf_overflowed(struct printbuf *out)
 
 static inline void printbuf_nul_terminate(struct printbuf *out)
 {
+	printbuf_make_room(out, 1);
+
 	if (out->pos < out->size)
 		out->buf[out->pos] = 0;
 	else if (out->size)
 		out->buf[out->size - 1] = 0;
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
 	printbuf_nul_terminate(out);
 }
 
-static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
+static inline void __prt_chars_reserved(struct printbuf *out, char c, unsigned n)
 {
 	unsigned i, can_print = min(n, printbuf_remaining(out));
 
@@ -79,13 +143,18 @@ static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
 
 static inline void prt_chars(struct printbuf *out, char c, unsigned n)
 {
-	__prt_chars(out, c, n);
+	printbuf_make_room(out, n);
+	__prt_chars_reserved(out, c, n);
 	printbuf_nul_terminate(out);
 }
 
 static inline void prt_bytes(struct printbuf *out, const void *b, unsigned n)
 {
-	unsigned i, can_print = min(n, printbuf_remaining(out));
+	unsigned i, can_print;
+
+	printbuf_make_room(out, n);
+
+	can_print = min(n, printbuf_remaining(out));
 
 	for (i = 0; i < can_print; i++)
 		out->buf[out->pos++] = ((char *) b)[i];
@@ -101,22 +170,43 @@ static inline void prt_str(struct printbuf *out, const char *str)
 
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
index 17e48da223..d44f8d03d6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
-	 buildid.o cpumask.o
+	 buildid.o cpumask.o printbuf.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 
diff --git a/lib/printbuf.c b/lib/printbuf.c
new file mode 100644
index 0000000000..e3e5a791b2
--- /dev/null
+++ b/lib/printbuf.c
@@ -0,0 +1,76 @@
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
+#include <linux/err.h>
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
+
+	/*
+	 * Note: output buffer must be freeable with kfree(), it's not required
+	 * that the user use printbuf_exit().
+	 */
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
2.36.1

