Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B581550E13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiFTAnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiFTAnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:07 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF80EBB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cu16so13426196qvb.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRvBrdNqHSOuaoyss77k+WXhFUbhXQ/IETYNRL++H68=;
        b=C0iy85m5EuxdFG09Uh6+Haq+2q/rP3zXWcbwUJqs4YtBMwxq/vLtLbpPqkuakivAnS
         ERWQbldL9l9Kg5o9jHhW0xACtq8slkMT8ajsWOzPiBM1CNZhx4DG7LjmuSYVJEC0XnjG
         B6uawwH76VEa/hLnq+G8O+A1rKHcebJtjF/N6zbqbAa6U5kpWUWDbW+WN10ocx5NnMsL
         mV0Vq8Ujxr7mnxKyOgvit6Iez+Jfn9+vpjwrAKltmw9A7ZUZJs7z/JyH6XrWtpZQv8VK
         33hPYUZKtz2gESvicUXyk5SE+EUdRBdogDul0KWQhLRmvb9dMHUWpaBnbQgklvUM3ZpI
         Fm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRvBrdNqHSOuaoyss77k+WXhFUbhXQ/IETYNRL++H68=;
        b=swBXAwzGTyheCTJy3Y7+XmRhhIZTXRPu56XxUPJOBlKhJKlj4yennxDXamJTIeuWj5
         88pngVVZCrVqslBTASWd/mQHJjqPoIMmN7++TIhNbh5UF/W89qkBboWJpJDGA5Blo/ZZ
         8mc3sWPMReCzvp3DukypVUt3SLeUG2pCNQFz6o25Y8mw7LM470HejFQueohc2P210Xez
         hbu7O/d1V9IJXOphlHeBIhyheM1sn3KeKcgzivIwUbwlHXOxhn36daP2Nw8LHWY+h2/N
         BOIfSn+0K1fzelT7oLJ2jVHPJYO8gejM/4wiMllCnlp2WbBtxD5ieXQ88ax7aH5ayYF1
         vsng==
X-Gm-Message-State: AJIora/mqBR0OgJG3ZX25QXbgf9PdVh+nI8DKIZmjUk7WPGS8UD5T47L
        kYabBDilwIkmpLNLZdJyMcQvl/ut3QqjTUQ=
X-Google-Smtp-Source: AGRyM1scNnKLdDPjDmLLvYvy5kkK6KyNyDdCsMJnrp7LkoNXR5fOfae3fke6nNaiaLijdgXoPJsvNA==
X-Received: by 2002:a05:622a:d0:b0:305:c643:68fe with SMTP id p16-20020a05622a00d000b00305c64368femr17928566qtw.232.1655685769928;
        Sun, 19 Jun 2022 17:42:49 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t20-20020ac86a14000000b00304b5eef8aasm9398994qtr.32.2022.06.19.17.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:49 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 07/34] lib/printbuf: Heap allocation
Date:   Sun, 19 Jun 2022 20:42:06 -0400
Message-Id: <20220620004233.3805-8-kent.overstreet@gmail.com>
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
 include/linux/printbuf.h | 120 +++++++++++++++++++++++++++++++++------
 lib/Makefile             |   2 +-
 lib/printbuf.c           |  71 +++++++++++++++++++++++
 3 files changed, 175 insertions(+), 18 deletions(-)
 create mode 100644 lib/printbuf.c

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 8186c447ca..382863afa7 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -4,19 +4,69 @@
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
@@ -49,26 +99,36 @@ static inline bool printbuf_overflowed(struct printbuf *out)
 
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
 
@@ -79,13 +139,18 @@ static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
 
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
@@ -101,22 +166,43 @@ static inline void prt_str(struct printbuf *out, const char *str)
 
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
index 0000000000..8c70128e31
--- /dev/null
+++ b/lib/printbuf.c
@@ -0,0 +1,71 @@
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

