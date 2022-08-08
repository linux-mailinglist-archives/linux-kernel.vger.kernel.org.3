Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2410A58C1C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiHHCm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242409AbiHHCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5492183
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m0DsKEBL9X2In7g3SaJJ//Eus47I5rm2wtDKWJEHJOc=; b=Mw6XIXrlnBLezyeYbm9vOc8hvb
        rvaPrlZrDsvJas4TiCy3kljk9B6lq2b+F0HrbhLs9sxyG78Dd312Ve7C1LG//jd87GFLKKHllWPgm
        CgfN645tBmX7DjCjZCwCsZHZwgl+WNhMbGdW5vuoqCV4OsO55gVkIzngjKod02ISOSi4RIRzwesDf
        VJv2GjbezpvwgOQAOm6p9wRlTuI5grLxH8d6IpHzOQjHL6NsDz79VqcrtMRYHW3DQIUAWzdA9tFf3
        usohG+1EQvvX1xCGggUCtOHzQxnf8JgjVzzHV9fZ4Bc4v3onYMRVNIyLPZPuXJShAM9DiLSuWbwFZ
        Am+KL02Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshw-00DVRP-LQ; Mon, 08 Aug 2022 02:41:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 01/32] lib/printbuf: New data structure for printing strings
Date:   Mon,  8 Aug 2022 03:40:57 +0100
Message-Id: <20220808024128.3219082-2-willy@infradead.org>
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
index 000000000000..1aa3331bf00b
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
2.35.1

