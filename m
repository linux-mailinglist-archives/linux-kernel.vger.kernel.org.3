Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82AE550E07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiFTAml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiFTAmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:42:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B3A187
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o73so6881158qke.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/nEaXcS+ZC6RKiVGkArvgF330nGs3znieMvRlKYBkE=;
        b=e40j//a0UpC8Y8sCD9pIwNHhYdrQIhc2TpikKiZ4J2M58W6FdUALdIMrL/eslykTBx
         0nzlTt1rhftLuh0tiigwJVcXj9ODls1SlagoERnk2I9tk/8unLDu7c2cU7Xxtr2IRpom
         klekBzuOmbd+q2rtwDd1SS8iaPcXODF29ntc55eCRzRe0VDpqhOi6ClSPHanNkFJyDSV
         mk93zt+iji375miaTDKZXzPcuL4pNBZc0w1Mg8iqI/ssFgqHzCYzI09aFyg0mzVymSJF
         xrJ5GNt0sYGfdk6Tmbp5lnQ0xw27LP7efZPkEnox3epsAjRgZJYynUgbFAnVjQDfhWLC
         xmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/nEaXcS+ZC6RKiVGkArvgF330nGs3znieMvRlKYBkE=;
        b=3W3SjF11bCo1oIqZiIHU7gbR4hwuRWkws89gMIkb/rXssxszgZZN7t6tCezCwFtZWb
         6/4fk+bCyJpFU1EBsKdVvHdYqChnaWoQ+LMZ0yXbHOyOZICdm7VwjcuhNjKNsPCg9vMx
         mPX3skFOcXJRsWzZbKoG+6haxvktp6x1XR4KosdR5TYG92Ysj+S4AI05pOoRE+xJPonk
         zVUSQw3E8WTdwHtNdjeOzO/cXT83rVbzZmWSCg2K2tSHEnLq/NcqJT/XlaDyEXYIMcj+
         OOGuJtFpN/lLkOI66faIPoRN+gajp3q/Q+SHd2ueRejo7vc9iyPgZ+13Syd8ofrHotDK
         PIZg==
X-Gm-Message-State: AJIora9PmYuwbxh6LY15H2MDRDPg+iirmeHV88LrBuGDNpsROJihIz6i
        gy7iSCgFNRa8EKoqeJrQuB0wAqD+n7qtkH4=
X-Google-Smtp-Source: AGRyM1uNJejkIsePjPRiQmFzrgITMNPqpuy+TziXRtN0JNv8oawGRUrDCakDVv7mXhqbhNFu7mXR4g==
X-Received: by 2002:a05:620a:4403:b0:6a6:d0ee:8b22 with SMTP id v3-20020a05620a440300b006a6d0ee8b22mr14672050qkp.144.1655685757374;
        Sun, 19 Jun 2022 17:42:37 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a17cb00b00304bbcc1b8asm9451375qtk.28.2022.06.19.17.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:36 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 01/34] lib/printbuf: New data structure for printing strings
Date:   Sun, 19 Jun 2022 20:42:00 -0400
Message-Id: <20220620004233.3805-2-kent.overstreet@gmail.com>
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

This adds printbufs: a printbuf points to a char * buffer and knows the
size of the output buffer as well as the current output position.

Future patches will be adding more features to printbuf, but initially
printbufs are targeted at refactoring and improving our existing code in
lib/vsprintf.c - so this initial printbuf patch has the features
required for that.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/printbuf.h | 122 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 include/linux/printbuf.h

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
new file mode 100644
index 0000000000..8186c447ca
--- /dev/null
+++ b/include/linux/printbuf.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022 Kent Overstreet */
+
+#ifndef _LINUX_PRINTBUF_H
+#define _LINUX_PRINTBUF_H
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+/*
+ * Printbufs: String buffer for outputting (printing) to, for vsnprintf
+ */
+
+struct printbuf {
+	char			*buf;
+	unsigned		size;
+	unsigned		pos;
+};
+
+/*
+ * Returns size remaining of output buffer:
+ */
+static inline unsigned printbuf_remaining_size(struct printbuf *out)
+{
+	return out->pos < out->size ? out->size - out->pos : 0;
+}
+
+/*
+ * Returns number of characters we can print to the output buffer - i.e.
+ * excluding the terminating nul:
+ */
+static inline unsigned printbuf_remaining(struct printbuf *out)
+{
+	return out->pos < out->size ? out->size - out->pos - 1 : 0;
+}
+
+static inline unsigned printbuf_written(struct printbuf *out)
+{
+	return min(out->pos, out->size);
+}
+
+/*
+ * Returns true if output was truncated:
+ */
+static inline bool printbuf_overflowed(struct printbuf *out)
+{
+	return out->pos >= out->size;
+}
+
+static inline void printbuf_nul_terminate(struct printbuf *out)
+{
+	if (out->pos < out->size)
+		out->buf[out->pos] = 0;
+	else if (out->size)
+		out->buf[out->size - 1] = 0;
+}
+
+static inline void __prt_char(struct printbuf *out, char c)
+{
+	if (printbuf_remaining(out))
+		out->buf[out->pos] = c;
+	out->pos++;
+}
+
+static inline void prt_char(struct printbuf *out, char c)
+{
+	__prt_char(out, c);
+	printbuf_nul_terminate(out);
+}
+
+static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
+{
+	unsigned i, can_print = min(n, printbuf_remaining(out));
+
+	for (i = 0; i < can_print; i++)
+		out->buf[out->pos++] = c;
+	out->pos += n - can_print;
+}
+
+static inline void prt_chars(struct printbuf *out, char c, unsigned n)
+{
+	__prt_chars(out, c, n);
+	printbuf_nul_terminate(out);
+}
+
+static inline void prt_bytes(struct printbuf *out, const void *b, unsigned n)
+{
+	unsigned i, can_print = min(n, printbuf_remaining(out));
+
+	for (i = 0; i < can_print; i++)
+		out->buf[out->pos++] = ((char *) b)[i];
+	out->pos += n - can_print;
+
+	printbuf_nul_terminate(out);
+}
+
+static inline void prt_str(struct printbuf *out, const char *str)
+{
+	prt_bytes(out, str, strlen(str));
+}
+
+static inline void prt_hex_byte(struct printbuf *out, u8 byte)
+{
+	__prt_char(out, hex_asc_hi(byte));
+	__prt_char(out, hex_asc_lo(byte));
+	printbuf_nul_terminate(out);
+}
+
+static inline void prt_hex_byte_upper(struct printbuf *out, u8 byte)
+{
+	__prt_char(out, hex_asc_upper_hi(byte));
+	__prt_char(out, hex_asc_upper_lo(byte));
+	printbuf_nul_terminate(out);
+}
+
+#define PRINTBUF_EXTERN(_buf, _size)			\
+((struct printbuf) {					\
+	.buf	= _buf,					\
+	.size	= _size,				\
+})
+
+#endif /* _LINUX_PRINTBUF_H */
-- 
2.36.1

