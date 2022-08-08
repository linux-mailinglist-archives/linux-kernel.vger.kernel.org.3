Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DD658C1D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiHHCoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbiHHClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C5F218F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hZjSf88l3+lM66CwidCtP8JI0G0z2t8AvLM0WYfg0TQ=; b=p5jQkZsDy0AV/sNBCWvC/4+8dm
        0VaauoPgqp4NVYzCwEV248UOyXSbbi/ql8lNU+jBMby6YpldIFoWTeyLSs+dLRkysE/Jyas0ICMBy
        Wl0sp26rQOV16Yq4oNZnM7j04HAgUpGYAGQ7NrLrr2Nl/7bwbwp+FKheY7pXjm2oBBoyC0W6NkexV
        G2Mcz0DGTQZ4PTBC7qG+CYU2KlbWr8nGeYREeW0VChzZSHGI8d383et5XxDYLoxSOqdcTcTuwHxGj
        CTSryPAawPxkn1vsqhu2+3NM7FN0KpaGaaKYq6weI0hhQjiMKcSJc/dq5fwz3R1UwlkTk2hTNPchK
        r7ft5Flw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshw-00DVRV-V7; Mon, 08 Aug 2022 02:41:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v5 04/32] lib/hexdump: Convert to printbuf
Date:   Mon,  8 Aug 2022 03:41:00 +0100
Message-Id: <20220808024128.3219082-5-willy@infradead.org>
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

This converts most of the hexdump code to printbufs, along with some
significant cleanups and a bit of reorganization. The old non-printbuf
functions are mostly left as wrappers around the new printbuf versions.

Big note: byte swabbing behaviour

Previously, hex_dump_to_buffer() would byteswab the groups of bytes
being printed on little endian machines. This behaviour is... not
standard or typical for a hex dumper, and this behaviour was silently
added/changed without documentation (in 2007).

Given that the hex dumpers are just used for debugging output, nothing
is likely to break, and hopefully by reverting to more standard
behaviour the end result will be _less_ confusion, modulo a few kernel
developers who will certainly be annoyed by their tools changing.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 include/linux/kernel.h |   6 +
 lib/hexdump.c          | 246 ++++++++++++++++++++++++-----------------
 lib/test_hexdump.c     |  30 +----
 3 files changed, 159 insertions(+), 123 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5c4f4b6d36ab..1906861ece7a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -293,6 +293,12 @@ extern int hex_to_bin(unsigned char ch);
 extern int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 extern char *bin2hex(char *dst, const void *src, size_t count);
 
+struct printbuf;
+void prt_hex_bytes(struct printbuf *, const void *, unsigned, unsigned, unsigned);
+void prt_hex_line(struct printbuf *, const void *, size_t, int, int, bool);
+void prt_hex_dump(struct printbuf *, const void *, size_t,
+		  const char *, int, unsigned, unsigned, bool);
+
 bool mac_pton(const char *s, u8 *mac);
 
 /*
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 06833d404398..9556f15ad295 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/minmax.h>
 #include <linux/export.h>
+#include <linux/printbuf.h>
 #include <asm/unaligned.h>
 
 const char hex_asc[] = "0123456789abcdef";
@@ -79,32 +80,40 @@ int hex2bin(u8 *dst, const char *src, size_t count)
 EXPORT_SYMBOL(hex2bin);
 
 /**
- * bin2hex - convert binary data to an ascii hexadecimal string
- * @dst: ascii hexadecimal result
- * @src: binary data
- * @count: binary data length
+ * prt_hex_bytes - Print a string of hex bytes, with optional separator
+ *
+ * @out: The printbuf to output to
+ * @addr: Buffer to print
+ * @nr: Number of bytes to print
+ * @separator: Optional separator character between each byte
  */
-char *bin2hex(char *dst, const void *src, size_t count)
+void prt_hex_bytes(struct printbuf *out, const void *buf, unsigned len,
+		   unsigned groupsize, unsigned separator)
 {
-	const unsigned char *_src = src;
+	const u8 *ptr = buf;
+	unsigned i;
 
-	while (count--)
-		dst = hex_byte_pack(dst, *_src++);
-	return dst;
+	if (!groupsize)
+		groupsize = 1;
+
+	for (i = 0; i < len ; ++i) {
+		if (i && separator && !(i % groupsize))
+			__prt_char(out, separator);
+		prt_hex_byte(out, ptr[i]);
+	}
 }
-EXPORT_SYMBOL(bin2hex);
+EXPORT_SYMBOL(prt_hex_bytes);
 
 /**
- * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
+ * prt_hex_line - convert a blob of data to "hex ASCII" in memory
+ * @out: printbuf to output to
  * @buf: data blob to dump
  * @len: number of bytes in the @buf
  * @rowsize: number of bytes to print per line; must be 16 or 32
  * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
- * @linebuf: where to put the converted data
- * @linebuflen: total size of @linebuf, including space for terminating NUL
  * @ascii: include ASCII after the hex output
  *
- * hex_dump_to_buffer() works on one "line" of output at a time, i.e.,
+ * prt_hex_line() works on one "line" of output at a time, i.e.,
  * 16 or 32 bytes of input data converted to hex + ASCII output.
  *
  * Given a buffer of u8 data, hex_dump_to_buffer() converts the input data
@@ -117,22 +126,13 @@ EXPORT_SYMBOL(bin2hex);
  *
  * example output buffer:
  * 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
- *
- * Return:
- * The amount of bytes placed in the buffer without terminating NUL. If the
- * output was truncated, then the return value is the number of bytes
- * (excluding the terminating NUL) which would have been written to the final
- * string if enough space had been available.
  */
-int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
-		       char *linebuf, size_t linebuflen, bool ascii)
+void prt_hex_line(struct printbuf *out, const void *buf, size_t len,
+		  int rowsize, int groupsize, bool ascii)
 {
+	unsigned saved_pos = out->pos;
 	const u8 *ptr = buf;
-	int ngroups;
-	u8 ch;
-	int j, lx = 0;
-	int ascii_column;
-	int ret;
+	int i, ngroups;
 
 	if (rowsize != 16 && rowsize != 32)
 		rowsize = 16;
@@ -145,84 +145,127 @@ int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
 		groupsize = 1;
 
 	ngroups = len / groupsize;
-	ascii_column = rowsize * 2 + rowsize / groupsize + 1;
-
-	if (!linebuflen)
-		goto overflow1;
 
 	if (!len)
-		goto nil;
-
-	if (groupsize == 8) {
-		const u64 *ptr8 = buf;
-
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%16.16llx", j ? " " : "",
-				       get_unaligned(ptr8 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
-		}
-	} else if (groupsize == 4) {
-		const u32 *ptr4 = buf;
-
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%8.8x", j ? " " : "",
-				       get_unaligned(ptr4 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
-		}
-	} else if (groupsize == 2) {
-		const u16 *ptr2 = buf;
-
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%4.4x", j ? " " : "",
-				       get_unaligned(ptr2 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
-		}
-	} else {
-		for (j = 0; j < len; j++) {
-			if (linebuflen < lx + 2)
-				goto overflow2;
-			ch = ptr[j];
-			linebuf[lx++] = hex_asc_hi(ch);
-			if (linebuflen < lx + 2)
-				goto overflow2;
-			linebuf[lx++] = hex_asc_lo(ch);
-			if (linebuflen < lx + 2)
-				goto overflow2;
-			linebuf[lx++] = ' ';
+		return;
+
+	prt_hex_bytes(out, ptr, len, groupsize, ' ');
+
+	if (ascii) {
+		unsigned ascii_column = rowsize * 2 + rowsize / groupsize + 1;
+
+		prt_chars(out, ' ', max_t(int, 0, ascii_column - (out->pos - saved_pos)));
+
+		for (i = 0; i < len; i++) {
+			u8 ch = ptr[i];
+			prt_char(out, isascii(ch) && isprint(ch) ? ch : '.');
 		}
-		if (j)
-			lx--;
 	}
-	if (!ascii)
-		goto nil;
+}
+EXPORT_SYMBOL(prt_hex_line);
 
-	while (lx < ascii_column) {
-		if (linebuflen < lx + 2)
-			goto overflow2;
-		linebuf[lx++] = ' ';
-	}
-	for (j = 0; j < len; j++) {
-		if (linebuflen < lx + 2)
-			goto overflow2;
-		ch = ptr[j];
-		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
+/**
+ * prt_hex_dump - print multiline formatted hex dump
+ * @out: printbuf to output to
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ * @prefix_str: string to prefix each line with;
+ *  caller supplies trailing spaces for alignment if desired
+ * @prefix_type: controls whether prefix of an offset, address, or none
+ *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @rowsize: number of bytes to print per line; must be 16 or 32
+ * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @ascii: include ASCII after the hex output
+ *
+ * Function is an analogue of print_hex_dump() and thus has similar interface.
+ *
+ * linebuf size is maximal length for one line.
+ * 32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
+ *	separating space
+ * 2 - spaces separating hex dump and ascii representation
+ * 32 - ascii representation
+ * 1 - terminating '\0'
+ */
+void prt_hex_dump(struct printbuf *out, const void *buf, size_t len,
+		  const char *prefix_str, int prefix_type,
+		  unsigned rowsize, unsigned groupsize, bool ascii)
+{
+	const u8 *ptr = buf;
+	size_t i;
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len; i += rowsize) {
+		prt_str(out, prefix_str);
+
+		switch (prefix_type) {
+		case DUMP_PREFIX_ADDRESS:
+			prt_printf(out, "%p: ", ptr + i);
+			break;
+		case DUMP_PREFIX_OFFSET:
+			prt_printf(out, "%.8zx: ", i);
+			break;
+		}
+
+		prt_hex_line(out, ptr + i, min_t(size_t, len - i, rowsize),
+			     rowsize, groupsize, ascii);
+		prt_char(out, '\n');
 	}
-nil:
-	linebuf[lx] = '\0';
-	return lx;
-overflow2:
-	linebuf[lx++] = '\0';
-overflow1:
-	return ascii ? ascii_column + len : (groupsize * 2 + 1) * ngroups - 1;
+}
+
+/**
+ * bin2hex - convert binary data to an ascii hexadecimal string
+ * @dst: ascii hexadecimal result
+ * @src: binary data
+ * @count: binary data length
+ */
+char *bin2hex(char *dst, const void *src, size_t count)
+{
+	struct printbuf out = PRINTBUF_EXTERN(dst, count * 4);
+
+	prt_hex_bytes(&out, src, count, 0, 0);
+	return dst + out.pos;
+}
+EXPORT_SYMBOL(bin2hex);
+
+/**
+ * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ * @rowsize: number of bytes to print per line; must be 16 or 32
+ * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @linebuf: where to put the converted data
+ * @linebuflen: total size of @linebuf, including space for terminating NUL
+ * @ascii: include ASCII after the hex output
+ *
+ * hex_dump_to_buffer() works on one "line" of output at a time, i.e.,
+ * 16 or 32 bytes of input data converted to hex + ASCII output.
+ *
+ * Given a buffer of u8 data, hex_dump_to_buffer() converts the input data
+ * to a hex + ASCII dump at the supplied memory location.
+ * The converted output is always NUL-terminated.
+ *
+ * E.g.:
+ *   hex_dump_to_buffer(frame->data, frame->len, 16, 1,
+ *			linebuf, sizeof(linebuf), true);
+ *
+ * example output buffer:
+ * 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
+ *
+ * Return:
+ * The amount of bytes placed in the buffer without terminating NUL. If the
+ * output was truncated, then the return value is the number of bytes
+ * (excluding the terminating NUL) which would have been written to the final
+ * string if enough space had been available.
+ */
+int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
+		       char *linebuf, size_t linebuflen, bool ascii)
+{
+	struct printbuf out = PRINTBUF_EXTERN(linebuf, linebuflen);
+
+	prt_hex_line(&out, buf, len, rowsize, groupsize, ascii);
+	return out.pos;
 }
 EXPORT_SYMBOL(hex_dump_to_buffer);
 
@@ -262,6 +305,11 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		    int rowsize, int groupsize,
 		    const void *buf, size_t len, bool ascii)
 {
+	/*
+	 * XXX: this code does the exact same thing as prt_hex_dump(): we should
+	 * be able to call that and printk() the result, except printk is
+	 * restricted to 1024 bytes of output per call
+	 */
 	const u8 *ptr = buf;
 	int i, linelen, remaining = len;
 	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 5144899d3c6b..f9e97879dcdf 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -25,36 +25,19 @@ static const char * const test_data_1[] __initconst = {
 	"4c", "d1", "19", "99", "43", "b1", "af", "0c",
 };
 
-static const char * const test_data_2_le[] __initconst = {
-	"32be", "7bdb", "180a", "b293",
-	"ba70", "24c4", "837d", "9b34",
-	"9ca6", "ad31", "0f9c", "e9ac",
-	"d14c", "9919", "b143", "0caf",
-};
-
-static const char * const test_data_2_be[] __initconst = {
+static const char * const test_data_2[] __initconst = {
 	"be32", "db7b", "0a18", "93b2",
 	"70ba", "c424", "7d83", "349b",
 	"a69c", "31ad", "9c0f", "ace9",
 	"4cd1", "1999", "43b1", "af0c",
 };
 
-static const char * const test_data_4_le[] __initconst = {
-	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
-	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
-};
-
-static const char * const test_data_4_be[] __initconst = {
+static const char * const test_data_4[] __initconst = {
 	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
 	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
 };
 
-static const char * const test_data_8_le[] __initconst = {
-	"b293180a7bdb32be", "9b34837d24c4ba70",
-	"e9ac0f9cad319ca6", "0cafb1439919d14c",
-};
-
-static const char * const test_data_8_be[] __initconst = {
+static const char * const test_data_8[] __initconst = {
 	"be32db7b0a1893b2", "70bac4247d83349b",
 	"a69c31ad9c0face9", "4cd1199943b1af0c",
 };
@@ -73,7 +56,6 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 	size_t l = len;
 	int gs = groupsize, rs = rowsize;
 	unsigned int i;
-	const bool is_be = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
 
 	if (rs != 16 && rs != 32)
 		rs = 16;
@@ -85,11 +67,11 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 		gs = 1;
 
 	if (gs == 8)
-		result = is_be ? test_data_8_be : test_data_8_le;
+		result = test_data_8;
 	else if (gs == 4)
-		result = is_be ? test_data_4_be : test_data_4_le;
+		result = test_data_4;
 	else if (gs == 2)
-		result = is_be ? test_data_2_be : test_data_2_le;
+		result = test_data_2;
 	else
 		result = test_data_1;
 
-- 
2.35.1

