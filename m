Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6612550E14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiFTAnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiFTAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1466585
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:54 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d128so6880176qkg.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmnZsBS7ICfhtPbFVJE00Af049vTUvEMSfkA9G33Z+Y=;
        b=FS+p1cBlMgrvZr0p4b+tva3wEIao0KwdEJw4GNGD0MkRDG+Q78eE9bMbYmNKtz1DFW
         GYcGcOEivpoUJV4yz/3AMofzVI9M8D5IHkPwmR43g0hZNzL2RqObGCtM+s3hyXdZq783
         xLNOzqLaOM6J7c3kv6aoM5vBqMw0zgVGzD2LoWbaO7xkjPaZXtnuAlFvKDfkD8uYtTZd
         ZRCJVXDTZy/0Ev8v0CWU9Eb7XNDiYE0PjEzKuUhKWCrILL/AKr1H5WNdMMggHtDpzHM/
         clj7iSjtJR+pHdqJp9SNzOJ7LOOnh768E6/lULh9I5d3iDT6/zzudxsdIJHoxuM45QLq
         OktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmnZsBS7ICfhtPbFVJE00Af049vTUvEMSfkA9G33Z+Y=;
        b=tttIGVoLdvN6moR2cU9O/Uyey8/Vx9xnmIBxY5KMiAWYszEfOq7TmUereCavKq0c5V
         HbZMPMTRY2uZTO/BjBdz2VqjhASSIRgfqS4pzF1Acw8rLr+sC/TFRCf2LXnWKjDYLpu3
         Fpi20Yzo1mMBHQCL2XwPj2qN7HXEPfY6SUSibUy2idxk8C+V6PRRBJSl88bmTxLoJZQr
         DnxtPS/B3FRNO3gUp70bKPUKs1rEoJIutiNojNBsANnjlntw3TEv2I6eGnBkMa5n61jt
         UMl8UUNjulT4vJTTLsw+/DZWOGXAwHc4/tyGuUsmAAnbwgIOg4i8Gjxq5DGOeVsNhxb+
         oHQg==
X-Gm-Message-State: AJIora/wMfd6uOj+IEwhJMxMnBE/rqLV+7rZoaSwk5tkhREARFaI/wYx
        YKPAe+5ohGCu93wPdRVnjJCt9tYmMZ3Vae8=
X-Google-Smtp-Source: AGRyM1tBmrxf1indi/uvJgmAPcm0cBP3mfXeFK9mluLQyQy1jfh9ZCHnRGgEBFB8u9JlPE8+z6ipmw==
X-Received: by 2002:a05:620a:d94:b0:6a6:6c9c:c7ec with SMTP id q20-20020a05620a0d9400b006a66c9cc7ecmr14807435qkl.221.1655685772861;
        Sun, 19 Jun 2022 17:42:52 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a405500b0069fe1dfbeffsm11316870qko.92.2022.06.19.17.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:52 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 09/34] lib/printbuf: Unit specifiers
Date:   Sun, 19 Jun 2022 20:42:08 -0400
Message-Id: <20220620004233.3805-10-kent.overstreet@gmail.com>
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

This adds options to printbuf for specifying whether units should be
printed raw (default) or with human readable units, and for controlling
whether human-readable units should be base 2 (default), or base 10.

This also adds new helpers that obey these options:

 - pr_human_readable_u64
 - pr_human_readable_s64
These obey printbuf->si_units

 - pr_units_u64
 - pr_units_s64
These obey both printbuf-human_readable_units and printbuf->si_units

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/printbuf.h | 15 +++++++++++
 lib/printbuf.c           | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 1e43c47891..5100287eed 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -53,11 +53,20 @@
  *
  * Make sure you use prt_newline() instead of \n in the format string for indent
  * level and tabstops to work corretly.
+ *
+ * Output units: printbuf->units exists to tell pretty-printers how to output
+ * numbers: a raw value (e.g. directly from a superblock field), as bytes, or as
+ * human readable bytes. prt_units() obeys it.
  */
 
 #include <linux/kernel.h>
 #include <linux/string.h>
 
+enum printbuf_si {
+	PRINTBUF_UNITS_2,	/* use binary powers of 2^10 */
+	PRINTBUF_UNITS_10,	/* use powers of 10^3 (standard SI) */
+};
+
 struct printbuf {
 	char			*buf;
 	unsigned		size;
@@ -71,6 +80,8 @@ struct printbuf {
 	u8			atomic;
 	bool			allocation_failure:1;
 	bool			heap_allocated:1;
+	enum printbuf_si	si_units:1;
+	bool			human_readable_units:1;
 	u8			tabstop;
 	u8			tabstops[4];
 };
@@ -84,6 +95,10 @@ void printbuf_indent_add(struct printbuf *, unsigned);
 void printbuf_indent_sub(struct printbuf *, unsigned);
 void prt_tab(struct printbuf *);
 void prt_tab_rjust(struct printbuf *);
+void prt_human_readable_u64(struct printbuf *, u64);
+void prt_human_readable_s64(struct printbuf *, s64);
+void prt_units_u64(struct printbuf *, u64);
+void prt_units_s64(struct printbuf *, s64);
 
 /* Initializer for a heap allocated printbuf: */
 #define PRINTBUF ((struct printbuf) { .heap_allocated = true })
diff --git a/lib/printbuf.c b/lib/printbuf.c
index a7f80f63ca..553f89ebc1 100644
--- a/lib/printbuf.c
+++ b/lib/printbuf.c
@@ -10,6 +10,7 @@
 
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include <linux/printbuf.h>
 
 static inline size_t printbuf_linelen(struct printbuf *buf)
@@ -194,3 +195,59 @@ void prt_tab_rjust(struct printbuf *buf)
 	buf->tabstop++;
 }
 EXPORT_SYMBOL(prt_tab_rjust);
+
+/**
+ * prt_human_readable_u64 - Print out a u64 in human readable units
+ *
+ * Units of 2^10 (default) or 10^3 are controlled via @buf->si_units
+ */
+void prt_human_readable_u64(struct printbuf *buf, u64 v)
+{
+	printbuf_make_room(buf, 10);
+	buf->pos += string_get_size(v, 1, !buf->si_units,
+				    buf->buf + buf->pos,
+				    printbuf_remaining_size(buf));
+}
+EXPORT_SYMBOL(prt_human_readable_u64);
+
+/**
+ * prt_human_readable_s64 - Print out a s64 in human readable units
+ *
+ * Units of 2^10 (default) or 10^3 are controlled via @buf->si_units
+ */
+void prt_human_readable_s64(struct printbuf *buf, s64 v)
+{
+	if (v < 0)
+		prt_char(buf, '-');
+	prt_human_readable_u64(buf, abs(v));
+}
+EXPORT_SYMBOL(prt_human_readable_s64);
+
+/**
+ * prt_units_u64 - Print out a u64 according to printbuf unit options
+ *
+ * Units are either raw (default), or human reabable units (controlled via
+ * @buf->human_readable_units)
+ */
+void prt_units_u64(struct printbuf *out, u64 v)
+{
+	if (out->human_readable_units)
+		prt_human_readable_u64(out, v);
+	else
+		prt_printf(out, "%llu", v);
+}
+EXPORT_SYMBOL(prt_units_u64);
+
+/**
+ * prt_units_s64 - Print out a s64 according to printbuf unit options
+ *
+ * Units are either raw (default), or human reabable units (controlled via
+ * @buf->human_readable_units)
+ */
+void prt_units_s64(struct printbuf *out, s64 v)
+{
+	if (v < 0)
+		prt_char(out, '-');
+	prt_units_u64(out, abs(v));
+}
+EXPORT_SYMBOL(prt_units_s64);
-- 
2.36.1

