Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CBD58C1B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbiHHCl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiHHClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE8621B4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description;
        bh=oEg9AsCOZDOluYzZVESlodsCM31B8LHTgFU/mz1O/dw=; b=immJNjPThnAPBDU9T21B8lJXu7
        5qJsOClID5bGeO/98Rhe3D7yJlmZkx6zLOewvA5JdShAy9zRzYvu2AQUgZZiYzwhFhMdr3qocjlYG
        9unXn04o6NqSqHTc46e6LfZ+eg3HdrEf9Wnj4dtzQ1g4FOve28IsxZNSHably9eTfAjOvTlndTbxT
        K2df1ctq6jc+58HBj24GZMY1oFuBhlR2Xf4T0fG/KOLFCf2+2N7R3Bn64snoDjMSWqmdmFtLvBfTE
        dHTxFZE/X+rKFYqQP5WJN5Pp4xG2z2Z0r5FrDQfghOzJyHXe5hrHWo6LEcwFCcVav6GIYrHDzYBkD
        GtLZ+A+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRc-6z; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v5 07/32] lib/printbuf: Tabstops, indenting
Date:   Mon,  8 Aug 2022 03:41:03 +0100
Message-Id: <20220808024128.3219082-8-willy@infradead.org>
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

This patch adds two new features to printbuf for structured formatting:

 - Indent level: the indent level, as a number of spaces, may be
   increased with pr_indent_add() and decreased with pr_indent_sub().

   Subsequent lines, when started with pr_newline() (not "\n", although
   that may change) will then be intended according to the current
   indent level. This helps with pretty-printers that structure a large
   amonut of data across multiple lines and multiple functions.

 - Tabstops: Tabstops may be set by assigning to the printbuf->tabstops
   array.

   Then, pr_tab() may be used to advance to the next tabstop, printing
   as many spaces as required - leaving previous output left justified
   to the previous tabstop. pr_tab_rjust() advances to the next tabstop
   but inserts the spaces just after the previous tabstop - right
   justifying the previously-outputted text to the next tabstop.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/printbuf.h |  30 ++++++++++
 lib/printbuf.c           | 125 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 71f631c49f4e..c1a482b6c0a8 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -40,6 +40,23 @@
  * memory allocation failure we usually don't want to bail out and unwind - we
  * want to print what we've got, on a best-effort basis. But code that does want
  * to return -ENOMEM may check printbuf.allocation_failure.
+ *
+ * Indenting, tabstops:
+ *
+ * To aid is writing multi-line pretty printers spread across multiple
+ * functions, printbufs track the current indent level.
+ *
+ * printbuf_indent_push() and printbuf_indent_pop() increase and decrease the current indent
+ * level, respectively.
+ *
+ * To use tabstops, set printbuf->tabstops[]; they are in units of spaces, from
+ * start of line. Once set, prt_tab() will output spaces up to the next tabstop.
+ * prt_tab_rjust() will also advance the current line of text up to the next
+ * tabstop, but it does so by shifting text since the previous tabstop up to the
+ * next tabstop - right justifying it.
+ *
+ * Make sure you use prt_newline() instead of \n in the format string for indent
+ * level and tabstops to work corretly.
  */
 
 #include <linux/kernel.h>
@@ -49,18 +66,29 @@ struct printbuf {
 	char			*buf;
 	unsigned		size;
 	unsigned		pos;
+	unsigned		last_newline;
+	unsigned		last_field;
+	unsigned		indent;
 	/*
 	 * If nonzero, allocations will be done with GFP_ATOMIC:
 	 */
 	u8			atomic;
 	bool			allocation_failure:1;
 	bool			heap_allocated:1;
+	u8			tabstop;
+	u8			tabstops[4];
 };
 
 int printbuf_make_room(struct printbuf *, unsigned);
 const char *printbuf_str(const struct printbuf *);
 void printbuf_exit(struct printbuf *);
 
+void prt_newline(struct printbuf *);
+void printbuf_indent_add(struct printbuf *, unsigned);
+void printbuf_indent_sub(struct printbuf *, unsigned);
+void prt_tab(struct printbuf *);
+void prt_tab_rjust(struct printbuf *);
+
 /* Initializer for a heap allocated printbuf: */
 #define PRINTBUF ((struct printbuf) { .heap_allocated = true })
 
@@ -191,6 +219,8 @@ static inline void printbuf_reset(struct printbuf *buf)
 {
 	buf->pos		= 0;
 	buf->allocation_failure	= 0;
+	buf->indent		= 0;
+	buf->tabstop		= 0;
 }
 
 /**
diff --git a/lib/printbuf.c b/lib/printbuf.c
index e3e5a791b244..395c681e3acb 100644
--- a/lib/printbuf.c
+++ b/lib/printbuf.c
@@ -12,6 +12,11 @@
 #include <linux/slab.h>
 #include <linux/printbuf.h>
 
+static inline size_t printbuf_linelen(struct printbuf *buf)
+{
+	return buf->pos - buf->last_newline;
+}
+
 int printbuf_make_room(struct printbuf *out, unsigned extra)
 {
 	unsigned new_size;
@@ -74,3 +79,123 @@ void printbuf_exit(struct printbuf *buf)
 	}
 }
 EXPORT_SYMBOL(printbuf_exit);
+
+void prt_newline(struct printbuf *buf)
+{
+	unsigned i;
+
+	printbuf_make_room(buf, 1 + buf->indent);
+
+	__prt_char(buf, '\n');
+
+	buf->last_newline	= buf->pos;
+
+	for (i = 0; i < buf->indent; i++)
+		__prt_char(buf, ' ');
+
+	printbuf_nul_terminate(buf);
+
+	buf->last_field		= buf->pos;
+	buf->tabstop = 0;
+}
+EXPORT_SYMBOL(prt_newline);
+
+/**
+ * printbuf_indent_add - add to the current indent level
+ *
+ * @buf: printbuf to control
+ * @spaces: number of spaces to add to the current indent level
+ *
+ * Subsequent lines, and the current line if the output position is at the start
+ * of the current line, will be indented by @spaces more spaces.
+ */
+void printbuf_indent_add(struct printbuf *buf, unsigned spaces)
+{
+	if (WARN_ON_ONCE(buf->indent + spaces < buf->indent))
+		spaces = 0;
+
+	buf->indent += spaces;
+	while (spaces--)
+		prt_char(buf, ' ');
+}
+EXPORT_SYMBOL(printbuf_indent_add);
+
+/**
+ * printbuf_indent_sub - subtract from the current indent level
+ *
+ * @buf: printbuf to control
+ * @spaces: number of spaces to subtract from the current indent level
+ *
+ * Subsequent lines, and the current line if the output position is at the start
+ * of the current line, will be indented by @spaces less spaces.
+ */
+void printbuf_indent_sub(struct printbuf *buf, unsigned spaces)
+{
+	if (WARN_ON_ONCE(spaces > buf->indent))
+		spaces = buf->indent;
+
+	if (buf->last_newline + buf->indent == buf->pos) {
+		buf->pos -= spaces;
+		printbuf_nul_terminate(buf);
+	}
+	buf->indent -= spaces;
+}
+EXPORT_SYMBOL(printbuf_indent_sub);
+
+/**
+ * prt_tab - Advance printbuf to the next tabstop
+ *
+ * @buf: printbuf to control
+ *
+ * Advance output to the next tabstop by printing spaces.
+ */
+void prt_tab(struct printbuf *out)
+{
+	int spaces = max_t(int, 0, out->tabstops[out->tabstop] - printbuf_linelen(out));
+
+	BUG_ON(out->tabstop > ARRAY_SIZE(out->tabstops));
+
+	prt_chars(out, ' ', spaces);
+
+	out->last_field = out->pos;
+	out->tabstop++;
+}
+EXPORT_SYMBOL(prt_tab);
+
+/**
+ * prt_tab_rjust - Advance printbuf to the next tabstop, right justifying
+ * previous output
+ *
+ * @buf: printbuf to control
+ *
+ * Advance output to the next tabstop by inserting spaces immediately after the
+ * previous tabstop, right justifying previously outputted text.
+ */
+void prt_tab_rjust(struct printbuf *buf)
+{
+	BUG_ON(buf->tabstop > ARRAY_SIZE(buf->tabstops));
+
+	if (printbuf_linelen(buf) < buf->tabstops[buf->tabstop]) {
+		unsigned move = buf->pos - buf->last_field;
+		unsigned shift = buf->tabstops[buf->tabstop] -
+			printbuf_linelen(buf);
+
+		printbuf_make_room(buf, shift);
+
+		if (buf->last_field + shift < buf->size)
+			memmove(buf->buf + buf->last_field + shift,
+				buf->buf + buf->last_field,
+				min(move, buf->size - 1 - buf->last_field - shift));
+
+		if (buf->last_field < buf->size)
+			memset(buf->buf + buf->last_field, ' ',
+			       min(shift, buf->size - buf->last_field));
+
+		buf->pos += shift;
+		printbuf_nul_terminate(buf);
+	}
+
+	buf->last_field = buf->pos;
+	buf->tabstop++;
+}
+EXPORT_SYMBOL(prt_tab_rjust);
-- 
2.35.1

