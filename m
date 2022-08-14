Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35B459269A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbiHNVWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiHNVVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:55 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3B110E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLxh0Hn7Rty1hn1dIvhOXvcoFTGhIj5G2bOpTwCazBo=;
        b=mlVdt/q3PmocG843a3vsgC8xnGWJwafKJjs1vY7thd1+1EWw87m8wB3I/q3RLYuan37lZF
        7nQXk/ie09zRAXVxnG1WUfe7P9lewDMphooBfych1Ii7UtrPK9F111E1Hf9/if3S+dk+mu
        +m+95r6dMJCwnS60sPUQu4nIKKATqOk=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 20/32] vsprintf: Refactor hex_string, bitmap_string_list, bitmap_string
Date:   Sun, 14 Aug 2022 17:19:59 -0400
Message-Id: <20220814212011.1727798-21-kent.overstreet@linux.dev>
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

This patch cleans up printf_spec handling: these functions only use
spec.field_width and they do not interpret it in the normal way -
instead it's a number of bits/bytes passed in to print, so these
functions are changed to take that parameter directly.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 59 +++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 81d2f3fa1a..e01d660a6f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1126,18 +1126,23 @@ void resource_string(struct printbuf *out, struct resource *res,
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
@@ -1155,34 +1160,21 @@ void hex_string(struct printbuf *out, u8 *addr,
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
@@ -1211,13 +1203,14 @@ void bitmap_string(struct printbuf *out, unsigned long *bitmap,
 
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
@@ -2232,13 +2225,15 @@ void pointer(struct printbuf *out, const char *fmt,
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
2.36.1

