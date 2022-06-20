Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD73550E15
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiFTAnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbiFTAnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F300A2725
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c144so6864144qkg.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9eoCaahKKF8GPcnHNvxh314XQP7M2mbXnjspgXSnVM=;
        b=kzWZ14UhWQpr2qaOlYS9QzrKiCUW6Xki1/EC5YcTuk5f5Mk9/O4KLB0qiX8Ne65In/
         CmjidGpj819sto9/TLGGZUjJKfvvwrmOFdiMD/9uWzMgdeK7tfjDZkqutc+4PAEotN2v
         s7GlrUlWfy8+xJ2pmBRxTpwR8JDtUYuzd47cbQL8pc/+33zJ6IRYXnIm/5CsjhSY6HQn
         F/0au4BW21jw3kHihRksYnCPYw/0rff3z+YAT4juNJkTsUJAf8rLZp/RPy/fVltfOyFs
         C0LLJvdJYnIPwGuJxVS4z0qr1Ce8p79jMu0IOjuO1gZptsD5LxffMCQzXk8MpOtyklAH
         Vd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9eoCaahKKF8GPcnHNvxh314XQP7M2mbXnjspgXSnVM=;
        b=kNesjNbch9cDpnMKVKgBFLBCzYBUYGtoYKmnCsKXw4f4CMqWFCcF0hyHzvB3V6IxzD
         T8Apw515L4SQtICiwDIMlOKmrtkOmzgUPwSgyPFm5PkYiXDaYSXRfPVaPiYQBeYRSQVs
         wD9ouOvUz6FFqzx3AkQ8MrGpDvBFI4uD7DfDy0+iiHmTfHgV0mYhqF5DvBV0LMm9rWOl
         blGDSgafOmSyDxE4c1fm7Mx1hMvzgBYPE03/RRrVISHuOFH0u5GdyWilGdEAxONVe4Gj
         KcsSc4crXhsuIEAkmfVIR/LkgKBDcgS11IoL5k9bIBhb5S32I0FlCOOZAlIPYLxqXIsf
         Usdw==
X-Gm-Message-State: AJIora80YvA2cSjws/3E9AO293JxlvzzW2Fo8hqtM0QpI3SgNNvM1cXK
        tHjTMUfSCYpkl/1YtF6jF/ArtCRvCdXaHwg=
X-Google-Smtp-Source: AGRyM1sMZcU2iV/7Pecfr7pTe2lv/4b97s6iQX0qqt/h/ZDOAxOF/7yxG51Ro60SoZQ5zTofSHExNw==
X-Received: by 2002:a37:9fc9:0:b0:6a6:c16b:e634 with SMTP id i192-20020a379fc9000000b006a6c16be634mr14842818qke.230.1655685771574;
        Sun, 19 Jun 2022 17:42:51 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a454300b006a69ee117b6sm11144854qkp.97.2022.06.19.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:50 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 08/34] lib/printbuf: Tabstops, indenting
Date:   Sun, 19 Jun 2022 20:42:07 -0400
Message-Id: <20220620004233.3805-9-kent.overstreet@gmail.com>
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
index 382863afa7..1e43c47891 100644
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
@@ -45,18 +62,29 @@ struct printbuf {
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
 
@@ -187,6 +215,8 @@ static inline void printbuf_reset(struct printbuf *buf)
 {
 	buf->pos		= 0;
 	buf->allocation_failure	= 0;
+	buf->indent		= 0;
+	buf->tabstop		= 0;
 }
 
 /**
diff --git a/lib/printbuf.c b/lib/printbuf.c
index 8c70128e31..a7f80f63ca 100644
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
@@ -69,3 +74,123 @@ void printbuf_exit(struct printbuf *buf)
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
2.36.1

