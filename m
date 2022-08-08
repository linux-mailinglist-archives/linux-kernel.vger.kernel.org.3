Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D941F58C1D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbiHHCno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbiHHClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4F21A0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UmntpirdSpPRuDoceI03X6/H8+qGMeNpl5xMH8+vOYo=; b=nTWvwNKF5as3dgMXOWCJrpx3Fi
        LPq5lpmrm8Yn724a1WBVo92EyBBZ/ME8vpJ3A3GsA5BDXM76k2T73dUBd+sXvq5V066XUn0fnBbB+
        7vWo10sN9nBWKMCr2UdWp5GT9ElOBk/xNkcC+62Nrd4sydCGYYlMzHNHDees/RcPMYldiMkeCJfmw
        KeBjNeBlPfeCYMuP7e5/hiIOp4sh6gJNXNXoHm+5h0M54wyfEoiI1CEIxMK9nJHMqeyNeKOpiIUiy
        T9n5FaEEtJQb6W86rjJHGrL1VJIZpXS0YJvbYxoMJkXd8fyOQl/kGH1nZkJUTvqD0KDGQylNqLzGl
        W0SpSVRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRv-UI; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 16/32] vsprintf: Refactor mac_address_string()
Date:   Mon,  8 Aug 2022 03:41:12 +0100
Message-Id: <20220808024128.3219082-17-willy@infradead.org>
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
index 076e2d23be47..2042c17f571e 100644
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
2.35.1

