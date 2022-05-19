Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85B52DB27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbiESRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbiESRYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4ADA2041;
        Thu, 19 May 2022 10:24:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a19so5650867pgw.6;
        Thu, 19 May 2022 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdosP/pHOmdUT1GcMbPpmLyIQDuljI/X8gwrTiRDtk8=;
        b=CLWHKPizggH8N4nzmVjYeWABHQkwQQ4EZGGTG5p40MCenGmqMjOxhwW0j2bUEjl7h2
         6JvN/ppxEcFG0ldzZaIFxgXZjZmtrKausESqomqKzNmIfiLlZa7vLeZEpQCUDUKkPLbK
         7aoV3B1PI0WD6oMLuBAdypphAHs+xOWWcosq3KgxxDBszY4cqJ4Aeg6bfuQyPd278oWo
         5bND+kUqBTL02OJuboTOn6uELv3dcEWpBTIcOc/9UmnXlfc0p0eURXnm3SxbiN9GE4PY
         E7ijHc5QeXLlhGM60LGFRljkxzJ5P5nJqVjdn38xoKaszI1aHHkxdCkkHjEFRwOUp53G
         MQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdosP/pHOmdUT1GcMbPpmLyIQDuljI/X8gwrTiRDtk8=;
        b=enGvuIjgoKD19oyssyllF/m/rJLDphj3pDbOb9Ad3KAL2HROcdiFj1c47TNl5pFcug
         CC/1KCr1KdXXs+o9xP/kmq6QSyGfoai6uEkUT9kcAlIvIZO8K5roNe9cFPMqySV8E1/u
         PYImjlvNTFD5c3O2/q+ffX47WYT2Q+WWaGiyuKpxAA590tn9v4ik8Y3hMY1r0cOAt5wH
         /mQh+YsUEYzMbuVFK9NOBM9KNUV9miAD7sdDtCW01PEwekKIy9i4tUpA5Td6rLRrRg7T
         ZUUbInO2kFV1YLM0ow5aYGHvhY5mvnpVO72kmBxdUz3QOiNPoDrZHxoPHHKx0XUSzux4
         uKMA==
X-Gm-Message-State: AOAM533+xoZal/QIbpXodTiH1HOrgxV9nRCn3vmbJ80w76lEAr0XBJXY
        9WbE239Y9oSd+4vB0bhfkPI7wbf+Q+E4
X-Google-Smtp-Source: ABdhPJzALpbDm1utpgUxPnAe87RywRmlshnN2xH9UbflTNbmf299iP48AK9D7ITuztAHQjPLL+ziEQ==
X-Received: by 2002:a63:d743:0:b0:3f5:f77a:a516 with SMTP id w3-20020a63d743000000b003f5f77aa516mr4781472pgi.210.1652981085422;
        Thu, 19 May 2022 10:24:45 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:44 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 06/28] lib/printbuf: Tabstops, indenting
Date:   Thu, 19 May 2022 13:23:59 -0400
Message-Id: <20220519172421.162394-7-kent.overstreet@gmail.com>
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
 include/linux/printbuf.h |  28 +++++++++
 lib/printbuf.c           | 125 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index c114072773..798e067457 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -36,6 +36,23 @@
  * memory allocation failure we usually don't want to bail out and unwind - we
  * want to print what we've got, on a best-effort basis. But code that does want
  * to return -ENOMEM may check printbuf.allocation_failure.
+ *
+ * Indenting, tabstops:
+ *
+ * To aid is writing multi-line pretty printers spread across multiple
+ * functions, printbufs track the current indent level.
+ *
+ * pr_indent_push() and pr_indent_pop() increase and decrease the current indent
+ * level, respectively.
+ *
+ * To use tabstops, set printbuf->tabstops[]; they are in units of spaces, from
+ * start of line. Once set, pr_tab() will output spaces up to the next tabstop.
+ * pr_tab_rjust() will also advance the current line of text up to the next
+ * tabstop, but it does so by shifting text since the previous tabstop up to the
+ * next tabstop - right justifying it.
+ *
+ * Make sure you use pr_newline() instead of \n in the format string for indent
+ * level and tabstops to work corretly.
  */
 
 #include <linux/string.h>
@@ -44,18 +61,29 @@ struct printbuf {
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
 
+void pr_newline(struct printbuf *);
+void pr_indent_add(struct printbuf *, unsigned);
+void pr_indent_sub(struct printbuf *, unsigned);
+void pr_tab(struct printbuf *);
+void pr_tab_rjust(struct printbuf *);
+
 /* Initializer for a heap allocated printbuf: */
 #define PRINTBUF ((struct printbuf) { .heap_allocated = true })
 
diff --git a/lib/printbuf.c b/lib/printbuf.c
index 0093b34158..c9f730a215 100644
--- a/lib/printbuf.c
+++ b/lib/printbuf.c
@@ -11,6 +11,11 @@
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
@@ -68,3 +73,123 @@ void printbuf_exit(struct printbuf *buf)
 	}
 }
 EXPORT_SYMBOL(printbuf_exit);
+
+void pr_newline(struct printbuf *buf)
+{
+	unsigned i;
+
+	printbuf_make_room(buf, 1 + buf->indent);
+
+	__pr_char(buf, '\n');
+
+	buf->last_newline	= buf->pos;
+
+	for (i = 0; i < buf->indent; i++)
+		__pr_char(buf, ' ');
+
+	printbuf_nul_terminate(buf);
+
+	buf->last_field		= buf->pos;
+	buf->tabstop = 0;
+}
+EXPORT_SYMBOL(pr_newline);
+
+/**
+ * pr_indent_add - add to the current indent level
+ *
+ * @buf: printbuf to control
+ * @spaces: number of spaces to add to the current indent level
+ *
+ * Subsequent lines, and the current line if the output position is at the start
+ * of the current line, will be indented by @spaces more spaces.
+ */
+void pr_indent_add(struct printbuf *buf, unsigned spaces)
+{
+	if (WARN_ON_ONCE(buf->indent + spaces < buf->indent))
+		spaces = 0;
+
+	buf->indent += spaces;
+	while (spaces--)
+		pr_char(buf, ' ');
+}
+EXPORT_SYMBOL(pr_indent_add);
+
+/**
+ * pr_indent_sub - subtract from the current indent level
+ *
+ * @buf: printbuf to control
+ * @spaces: number of spaces to subtract from the current indent level
+ *
+ * Subsequent lines, and the current line if the output position is at the start
+ * of the current line, will be indented by @spaces less spaces.
+ */
+void pr_indent_sub(struct printbuf *buf, unsigned spaces)
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
+EXPORT_SYMBOL(pr_indent_sub);
+
+/**
+ * pr_tab - Advance printbuf to the next tabstop
+ *
+ * @buf: printbuf to control
+ *
+ * Advance output to the next tabstop by printing spaces.
+ */
+void pr_tab(struct printbuf *out)
+{
+	int spaces = max(0, out->tabstops[out->tabstop] - printbuf_linelen(out));
+
+	BUG_ON(out->tabstop > ARRAY_SIZE(out->tabstops));
+
+	pr_chars(out, ' ', spaces);
+
+	out->last_field = out->pos;
+	out->tabstop++;
+}
+EXPORT_SYMBOL(pr_tab);
+
+/**
+ * pr_tab - Advance printbuf to the next tabstop, right justifying previous
+ * output
+ *
+ * @buf: printbuf to control
+ *
+ * Advance output to the next tabstop by inserting spaces immediately after the
+ * previous tabstop, right justifying previously outputted text.
+ */
+void pr_tab_rjust(struct printbuf *buf)
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
+EXPORT_SYMBOL(pr_tab_rjust);
-- 
2.36.0

