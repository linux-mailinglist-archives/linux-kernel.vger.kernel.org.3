Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588B152DB28
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiESRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbiESRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684BDA2041;
        Thu, 19 May 2022 10:24:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i24so5706065pfa.7;
        Thu, 19 May 2022 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqqe897jT3bJTlDV5KkrLu5Sm6S8Vcy+zi9IaoKFPgU=;
        b=q5C7u/12y0rwLUACTBBnOlgcMundJ8zp0NHyYcrZnSqhptgjv81mpLjAFr0GK2y65A
         BMFSP4pIeB7mb0FkFsXJQY4BFjrcXqU9hy7URpYv6OQt1//ponh3vwmM6n/nZl5srl55
         uNsA/a3s132XRx6qc4lz63K7E3Jg99VSd7uklS+mScoZQIDDX1YJeXtRPwj/bAA6CWRg
         EC91oFj8Yiav1+aVPayDHqPr9vG5VEBpkbpY6UDV95Njqdb9M/UJxhvnuxkZJpgZ61wU
         qo3Pxj6pT5G4u+c8+uCUlzKGUOUtpQUGWbW9lEadxmZalkHcA+faU6u8bgeZKmqC6i3Y
         kWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqqe897jT3bJTlDV5KkrLu5Sm6S8Vcy+zi9IaoKFPgU=;
        b=SxJPmauPNJc5GhkIbeJ0Eo517bQcVaTbJHhU0C7j5N9Q0Mpfcx2KrOU17wRo8oIuab
         q7kBEcmKWOMc8GqBgYivHKGW+U5X1JKxnC/s+1zCEexxy+7p+MZEBZsDzKRYPyTAakSe
         NK4c0EYyBZ617twtzXDhkfl+Zd+Kb/llGBJzXSHJwbMjRmI83W4s2rYCf3EsmvjtPM4L
         LIuXM8Yi1k1IihjtMlFqjBqyaLveKJoEgv9IMe7ZLcLRfazO5+6/BLlnWN7g5ctTj0TW
         REVgPcBNmvgIHbkXN+h1petuzekn0LtGmmF2k6lhGpfT/W1GDHdnqMD6Pp5P8WO83att
         hhZQ==
X-Gm-Message-State: AOAM532d5VMGVeW4Ne5ALHMgU3ammzzPPBeZSWg5pi0zHYqPQrh+49zD
        4KvdOiJmiNrPZbop5Tkm91g8V4S+koRX
X-Google-Smtp-Source: ABdhPJwFScg0uiMUswmKY0DiYEJDr0W8KYuCisAy4+GQKy9hveECuABrXMRKNUvHLMMyviOHUAXPTg==
X-Received: by 2002:a65:6051:0:b0:39d:1b00:e473 with SMTP id a17-20020a656051000000b0039d1b00e473mr4779741pgp.578.1652981081345;
        Thu, 19 May 2022 10:24:41 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:40 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 05/28] lib/printbuf: Heap allocation
Date:   Thu, 19 May 2022 13:23:58 -0400
Message-Id: <20220519172421.162394-6-kent.overstreet@gmail.com>
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
 include/linux/printbuf.h | 118 ++++++++++++++++++++++++++++++++++-----
 lib/Makefile             |   2 +-
 lib/printbuf.c           |  70 +++++++++++++++++++++++
 3 files changed, 174 insertions(+), 16 deletions(-)
 create mode 100644 lib/printbuf.c

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 40dc07040d..c114072773 100644
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
+ *   pr_buf(&buf, "foo=");
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
 static inline unsigned printbuf_remaining(struct printbuf *out)
 {
 	return out->pos < out->size ? out->size - out->pos : 0;
@@ -28,28 +78,44 @@ static inline unsigned printbuf_written(struct printbuf *out)
 
 static inline void printbuf_nul_terminate(struct printbuf *out)
 {
+	printbuf_make_room(out, 1);
+
 	if (out->pos < out->size)
 		out->buf[out->pos] = 0;
 	else if (out->size)
 		out->buf[out->size - 1] = 0;
 }
 
-static inline void pr_chars(struct printbuf *out, char c, unsigned n)
+static inline void __pr_chars_reserved(struct printbuf *out, char c, unsigned n)
 {
 	memset(out->buf + out->pos,
 	       c,
 	       min(n, printbuf_remaining(out)));
 	out->pos += n;
+}
+
+static inline void pr_chars(struct printbuf *out, char c, unsigned n)
+{
+	printbuf_make_room(out, n);
+	__pr_chars_reserved(out, c, n);
 	printbuf_nul_terminate(out);
 }
 
-static inline void __pr_char(struct printbuf *out, char c)
+/* Doesn't call printbuf_make_room(), doesn't nul terminate: */
+static inline void __pr_char_reserved(struct printbuf *out, char c)
 {
 	if (printbuf_remaining(out))
 		out->buf[out->pos] = c;
 	out->pos++;
 }
 
+/* Doesn't nul terminate: */
+static inline void __pr_char(struct printbuf *out, char c)
+{
+	printbuf_make_room(out, 1);
+	__pr_char_reserved(out, c);
+}
+
 static inline void pr_char(struct printbuf *out, char c)
 {
 	__pr_char(out, c);
@@ -58,6 +124,8 @@ static inline void pr_char(struct printbuf *out, char c)
 
 static inline void pr_bytes(struct printbuf *out, const void *b, unsigned n)
 {
+	printbuf_make_room(out, n);
+
 	memcpy(out->buf + out->pos,
 	       b,
 	       min(n, printbuf_remaining(out)));
@@ -72,23 +140,43 @@ static inline void pr_str(struct printbuf *out, const char *str)
 
 static inline void pr_hex_byte(struct printbuf *out, u8 byte)
 {
-	__pr_char(out, hex_asc_hi(byte));
-	__pr_char(out, hex_asc_lo(byte));
+	printbuf_make_room(out, 2);
+	__pr_char_reserved(out, hex_asc_hi(byte));
+	__pr_char_reserved(out, hex_asc_lo(byte));
 	printbuf_nul_terminate(out);
 }
 
 static inline void pr_hex_byte_upper(struct printbuf *out, u8 byte)
 {
-	__pr_char(out, hex_asc_upper_hi(byte));
-	__pr_char(out, hex_asc_upper_lo(byte));
+	printbuf_make_room(out, 2);
+	__pr_char_reserved(out, hex_asc_upper_hi(byte));
+	__pr_char_reserved(out, hex_asc_upper_lo(byte));
 	printbuf_nul_terminate(out);
 }
 
-#define PRINTBUF ((struct printbuf) { .si_units = PRINTBUF_UNITS_10 })
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
index c588a126a3..31a3904eda 100644
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

