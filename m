Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEFB53D849
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbiFDTba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiFDTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:08 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B4F4F9DD
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:03 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j8so5184965qtn.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/S9RyrnAxoxBJABrQh6w4keA3WMxhL6CB9ATTh+2iM=;
        b=kX5pVQfSHOnNdg7M682y9YLafSoDvPyLol0a+J1ubVd6S/w3RxV8ZLbMUiaKYIADtx
         6N/IUYDkEigm2PS+DxW5vQTLVgkuN39sabY1YsKYYjea73WUgpl6eWngEpuIa2xofdH6
         cTq/tfvO+3hDSFgclGTJ3wi1dDSIqoZZ1xnyrduucSaFT985PZAHnpUzyQLyEqc6XMwh
         18L76hF4rQthxkC7KOkXsDJLlVttEyPIPIA6J5yjTibyxxq9yIIu009oNYu/l9w1Zppy
         4MTEWb+nV0Gsqxia8SG4dwY2bCV7pPLpWHXapGQ8vOaGLeKCtBzbPV/OQGhw35g+EnmN
         2xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/S9RyrnAxoxBJABrQh6w4keA3WMxhL6CB9ATTh+2iM=;
        b=W1Yt7GV30bvICpRkGkDtSBSoftGQN7K+wLzyCj2/2A7ntooeXkWc+XLCRB5LTCd3cA
         TzLGZemoD64Kikc7IlQbtqEW7V6zLIxKXhTk+etQ6C9xdoPnqyN4lCrz3bBO6Wnvpoxc
         zgG06qmh4b2xmFjVGG/PqRLK7LRVuuyMi91sP/oVPdaHiywlTe5G7MEcR/y0yBUvTxQm
         /T6mflTBTAGBcC32zbpl9Z8gmMlSOFeq07Bt8uqu+EIA/s9MB//ynCi5pmEKgKcvcjeV
         ngU2lHEfInJeuJeG8WMtgICbhJ8h92j7jcS5i2l6who+9RzIVLpdNeYuDuX+FNCJ3qdh
         AFHw==
X-Gm-Message-State: AOAM531j/6wxbg3BrlonX0igOvWILL9RjdiNJRz5/Ls2p+k8isbt7FoC
        MDOwWU1a1JDHm4G+Nmo/dpnPM6O2N8NU
X-Google-Smtp-Source: ABdhPJwaIXSDa0tsBhfJ3waTACNu9eec31qez1/QbublcTeTg39UNK7pcHeatPta8E5bSZ6wRNFSgQ==
X-Received: by 2002:a05:622a:292:b0:304:3b6e:3f49 with SMTP id z18-20020a05622a029200b003043b6e3f49mr13106649qtw.613.1654371061997;
        Sat, 04 Jun 2022 12:31:01 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:01 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 08/33] lib/printbuf: Tabstops, indenting
Date:   Sat,  4 Jun 2022 15:30:17 -0400
Message-Id: <20220604193042.1674951-9-kent.overstreet@gmail.com>
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
index 35236f774a..8fb074eb67 100644
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
 
+void prt_newline(struct printbuf *);
+void printbuf_indent_add(struct printbuf *, unsigned);
+void printbuf_indent_sub(struct printbuf *, unsigned);
+void prt_tab(struct printbuf *);
+void prt_tab_rjust(struct printbuf *);
+
 /* Initializer for a heap allocated printbuf: */
 #define PRINTBUF ((struct printbuf) { .heap_allocated = true })
 
diff --git a/lib/printbuf.c b/lib/printbuf.c
index 0093b34158..e11a504abf 100644
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
2.36.0

