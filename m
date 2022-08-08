Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5552F58C1C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbiHHCnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242602AbiHHClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E425F0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UMLp/z/zO9tVZ6IGymm87CLlbDOH1CSK9TxXY2OyJZw=; b=TV+mgKMyauh+4PXLlijjPCxJht
        1olmilKT9KP1bAhpAgOESD5U+piHKmUsW9sv2+1YVm/vEmDIOPnO9TtpdgW83zVbFFEwDLAJxhrDx
        r9NNAI/mkBYzZB48VkTUtbiiIhkzVNPjj7muCJ/vLu0oFfcn1wKcyA0yhZsZDHGbSHnHjGSc2W2UO
        L9NbIbIiztxhQKBLKBomDBNb9S0n4N7omOOAtiTNh0y5sUKNZAqJPUNw1t6uNY/S5T/aPVf1SEe1t
        58LI5yfvwU9aoV0DB1CWBUOpLgFHdrTykavF/D7+1MwmCLMyjzSJtK0nOQys0lowPHo0gbgCzJa9c
        2vVLYrbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVS4-7m; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 20/32] vsprintf: Refactor hex_string, bitmap_string_list, bitmap_string
Date:   Mon,  8 Aug 2022 03:41:16 +0100
Message-Id: <20220808024128.3219082-21-willy@infradead.org>
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

This patch cleans up printf_spec handling: these functions only use
spec.field_width and they do not interpret it in the normal way -
instead it's a number of bits/bytes passed in to print, so these
functions are changed to take that parameter directly.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 60 +++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 06cfa06aa4ee..0ff7d9fea6da 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -53,6 +53,7 @@
 #include <asm/unaligned.h>
 
 #include <linux/string_helpers.h>
+#include <linux/pretty-printers.h>
 #include "kstrtox.h"
 
 /* Disable pointer hashing if requested */
@@ -1126,18 +1127,23 @@ void resource_string(struct printbuf *out, struct resource *res,
 }
 
 static noinline_for_stack
-void hex_string(struct printbuf *out, u8 *addr,
-		struct printf_spec spec, const char *fmt)
+void hex_string(struct printbuf *out, const u8 *addr,
+		int len, const char *fmt)
 {
-	int i, len = 1;		/* if we pass '%ph[CDN]', field width remains
-				   negative value, fallback to the default */
 	char separator;
 
-	if (spec.field_width == 0)
-		/* nothing to print */
+	/* nothing to print */
+	if (len == 0)
 		return;
 
-	if (check_pointer_spec(out, addr, spec))
+	/* if we pass '%ph[CDN]', field width remains
+	   negative value, fallback to the default */
+	if (len < 0)
+		len = 1;
+
+	len = min(len, 64);
+
+	if (check_pointer(out, addr))
 		return;
 
 	switch (fmt[1]) {
@@ -1155,34 +1161,21 @@ void hex_string(struct printbuf *out, u8 *addr,
 		break;
 	}
 
-	if (spec.field_width > 0)
-		len = min_t(int, spec.field_width, 64);
-
-	for (i = 0; i < len; ++i) {
-		__prt_char(out, hex_asc_hi(addr[i]));
-		__prt_char(out, hex_asc_lo(addr[i]));
-
-		if (separator && i != len - 1)
-			__prt_char(out, separator);
-	}
-
-	printbuf_nul_terminate(out);
+	prt_hex_bytes(out, addr, len, 1, separator);
 }
 
 static noinline_for_stack
-void bitmap_string(struct printbuf *out, unsigned long *bitmap,
-		   struct printf_spec spec, const char *fmt)
+void bitmap_string(struct printbuf *out, unsigned long *bitmap, int nr_bits)
 {
+	struct printf_spec spec = { .flags = SMALL | ZEROPAD, .base = 16 };
 	const int CHUNKSZ = 32;
-	int nr_bits = max_t(int, spec.field_width, 0);
 	int i, chunksz;
 	bool first = true;
 
-	if (check_pointer_spec(out, bitmap, spec))
-		return;
+	nr_bits = max(nr_bits, 0);
 
-	/* reused to print numbers */
-	spec = (struct printf_spec){ .flags = SMALL | ZEROPAD, .base = 16 };
+	if (check_pointer(out, bitmap))
+		return;
 
 	chunksz = nr_bits & (CHUNKSZ - 1);
 	if (chunksz == 0)
@@ -1211,13 +1204,14 @@ void bitmap_string(struct printbuf *out, unsigned long *bitmap,
 
 static noinline_for_stack
 void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
-			struct printf_spec spec, const char *fmt)
+			int nr_bits)
 {
-	int nr_bits = max_t(int, spec.field_width, 0);
 	bool first = true;
 	int rbot, rtop;
 
-	if (check_pointer_spec(out, bitmap, spec))
+	nr_bits = max(nr_bits, 0);
+
+	if (check_pointer(out, bitmap))
 		return ;
 
 	for_each_set_bitrange(rbot, rtop, bitmap, nr_bits) {
@@ -2232,13 +2226,15 @@ void pointer(struct printbuf *out, const char *fmt,
 		resource_string(out, ptr, fmt[0] == 'R');
 		return do_width_precision(out, prev_pos, spec);
 	case 'h':
-		return hex_string(out, ptr, spec, fmt);
+		/* Uses field_width but _not_ as field size */
+		return hex_string(out, ptr, spec.field_width, fmt);
 	case 'b':
+		/* Uses field_width but _not_ as field size */
 		switch (fmt[1]) {
 		case 'l':
-			return bitmap_list_string(out, ptr, spec, fmt);
+			return bitmap_list_string(out, ptr, spec.field_width);
 		default:
-			return bitmap_string(out, ptr, spec, fmt);
+			return bitmap_string(out, ptr, spec.field_width);
 		}
 	case 'M':			/* Colon separated: 00:01:02:03:04:05 */
 	case 'm':			/* Contiguous: 000102030405 */
-- 
2.35.1

