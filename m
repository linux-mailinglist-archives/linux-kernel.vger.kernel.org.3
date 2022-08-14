Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC6592690
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiHNVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiHNVVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:06 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F91BE07
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpuVtD8iLiHBQAEgFaBl9EYOtHFVB0KrU9ghNizKcJM=;
        b=KRHq+uilv8B7chcgfgMyH5JPVlgKZYvANR+QrLm7YpPhc1SCcmkHx+Fd7FcYMBb0ByXrED
        08ODgS5enYPbjapL49rFkIswfclJPfwbIrt5zMLnhBlJHBdHy9v0MZUDN0pOijLCc94LSo
        aMODhKAy0DCCglkQKU83Da7nBuZXzuc=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 14/32] vsprintf: Refactor fourcc_string()
Date:   Sun, 14 Aug 2022 17:19:53 -0400
Message-Id: <20220814212011.1727798-15-kent.overstreet@linux.dev>
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

 - We're attempting to consolidate printf_spec and format string
   handling in the top level vpr_buf(), this changes fourcc_string() to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f8abeee393..e3189c9f2d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1701,17 +1701,15 @@ void netdev_bits(struct printbuf *out, const void *addr,
 
 static noinline_for_stack
 void fourcc_string(struct printbuf *out, const u32 *fourcc,
-		   struct printf_spec spec, const char *fmt)
+		   const char *fmt)
 {
-	char output_buf[sizeof("0123 little-endian (0x01234567)")];
-	struct printbuf output = PRINTBUF_EXTERN(output_buf, sizeof(output_buf));
 	unsigned int i;
 	u32 orig, val;
 
 	if (fmt[1] != 'c' || fmt[2] != 'c')
-		return error_string_spec(out, "(%p4?)", spec);
+		return error_string(out, "(%p4?)");
 
-	if (check_pointer_spec(out, fourcc, spec))
+	if (check_pointer(out, fourcc))
 		return;
 
 	orig = get_unaligned(fourcc);
@@ -1721,18 +1719,16 @@ void fourcc_string(struct printbuf *out, const u32 *fourcc,
 		unsigned char c = val >> (i * 8);
 
 		/* Print non-control ASCII characters as-is, dot otherwise */
-		prt_char(&output, isascii(c) && isprint(c) ? c : '.');
+		prt_char(out, isascii(c) && isprint(c) ? c : '.');
 	}
 
-	prt_char(&output, ' ');
-	prt_str(&output, orig & BIT(31) ? "big-endian" : "little-endian");
-
-	prt_char(&output, ' ');
-	prt_char(&output, '(');
-	special_hex_number(&output, orig, sizeof(u32));
-	prt_char(&output, ')');
+	prt_char(out, ' ');
+	prt_str(out, orig & BIT(31) ? "big-endian" : "little-endian");
 
-	string_spec(out, output_buf, spec);
+	prt_char(out, ' ');
+	prt_char(out, '(');
+	special_hex_number(out, orig, sizeof(u32));
+	prt_char(out, ')');
 }
 
 static noinline_for_stack
@@ -2336,7 +2332,8 @@ void pointer(struct printbuf *out, const char *fmt,
 		netdev_bits(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
 	case '4':
-		return fourcc_string(out, ptr, spec, fmt);
+		fourcc_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'a':
 		address_val(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
-- 
2.36.1

