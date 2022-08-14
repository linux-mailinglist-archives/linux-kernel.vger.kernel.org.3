Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBF592684
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiHNVVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiHNVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:20:42 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4CB64FC
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vj+dUILWbh28JfOZyUO57tkh5j92cz8PsOwdjIDTAsg=;
        b=Qq2U7DnRXMEXPLrPHvyIOKzNmansWscUtWGEopV6sq3G8WbSaEE9GhrHRQ4WJB5JOiqZ/b
        l+mGEKvaVkBhLJ3EGljIhHllnryhy78eJwhhMNDShaBC9u7Z9Tglg1rQDpYh8KjnlLIE9r
        dhdF2XvwRCAlpNm/7x4tuVMZTx22/7s=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 01/32] lib/printbuf: New data structure for printing strings
Date:   Sun, 14 Aug 2022 17:19:40 -0400
Message-Id: <20220814212011.1727798-2-kent.overstreet@linux.dev>
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
index 0000000000..1aa3331bf0
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
+	return out->size ? min(out->pos, out->size - 1) : 0;
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

