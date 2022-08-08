Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEA958C1BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiHHCmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiHHClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D61B219E
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description;
        bh=1Pcy2nOf2MsuNc/qSkleQYM5fWNCLNN0ZDrbzvs8o90=; b=p9voLeBA7Kp4Z8voQNS9EXjJHV
        U3ADUHQogvPAofuVJ/qm/dLNAbmj246qcrCf1oiYgK35a16Uw2N+C8PG9RdHiTldPNa8elQteEi1l
        Y447ZNdS65FTNOb+tBFZSNbisoQPinpMqJGIz4lnbbYK1VYoQLV0a4qLwlCLregmCcdaCnQpTbz07
        kVgtGnMjAPJh143A2jzNqYE+BdYwf047Htaz58Y6YpqK5gOgBZ+dVS7OolLTonbO45API93Xms7Je
        usPRwridBb1TyhYyIXKYoeC6QO0QievEIU27pvIM3izvnGpMrjxZr2xuG1TiC3r9auYn1MMMM9uvh
        +ZmRO/5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRZ-41; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v5 06/32] lib/printbuf: Heap allocation
Date:   Mon,  8 Aug 2022 03:41:02 +0100
Message-Id: <20220808024128.3219082-7-willy@infradead.org>
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
index 1aa3331bf00b..71f631c49f4e 100644
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
index 17e48da223e2..d44f8d03d66b 100644
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
index 000000000000..e3e5a791b244
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
2.35.1

