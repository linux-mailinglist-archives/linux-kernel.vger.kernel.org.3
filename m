Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA52592692
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiHNVWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbiHNVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:12 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A7A1BB
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvkuUfNxvrOHE9IgbmOO85W316/BA/3wVqx+I3gBLLM=;
        b=wtz3oz+dUo7FmbdwSLE8H4k74V633aQfvqPRjcoaqoxwazh88D+1a/+E/Lm8C0L0b3lTyX
        pL18R1yy/iP7y1xUbBxgNwAS55D+jsjZpnxCMCR1gubTVKW7PaUitIgFlK0DiZBnuryLFE
        oqmefmq0edd4zziH/qbJmG5QFvXM39E=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 16/32] vsprintf: Refactor mac_address_string()
Date:   Sun, 14 Aug 2022 17:19:55 -0400
Message-Id: <20220814212011.1727798-17-kent.overstreet@linux.dev>
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
   handling in the top level ptr_vprintf(), this changes
mac_address_string() to not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 27d23e82f5..d8e8d211bd 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1236,15 +1236,13 @@ void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
 
 static noinline_for_stack
 void mac_address_string(struct printbuf *out, u8 *addr,
-			struct printf_spec spec, const char *fmt)
+			const char *fmt)
 {
-	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
-	char *p = mac_addr;
 	int i;
 	char separator;
 	bool reversed = false;
 
-	if (check_pointer_spec(out, addr, spec))
+	if (check_pointer(out, addr))
 		return;
 
 	switch (fmt[1]) {
@@ -1263,16 +1261,13 @@ void mac_address_string(struct printbuf *out, u8 *addr,
 
 	for (i = 0; i < 6; i++) {
 		if (reversed)
-			p = hex_byte_pack(p, addr[5 - i]);
+			prt_hex_byte(out, addr[5 - i]);
 		else
-			p = hex_byte_pack(p, addr[i]);
+			prt_hex_byte(out, addr[i]);
 
 		if (fmt[0] == 'M' && i != 5)
-			*p++ = separator;
+			prt_char(out, separator);
 	}
-	*p = '\0';
-
-	string_nocheck(out, mac_addr, spec);
 }
 
 static noinline_for_stack
@@ -2267,7 +2262,8 @@ void pointer(struct printbuf *out, const char *fmt,
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
 					/* [mM]R (Reverse order; Bluetooth) */
-		return mac_address_string(out, ptr, spec, fmt);
+		mac_address_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'I':			/* Formatted IP supported
 					 * 4:	1.2.3.4
 					 * 6:	0001:0203:...:0708
-- 
2.36.1

