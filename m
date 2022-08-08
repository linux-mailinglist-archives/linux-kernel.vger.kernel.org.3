Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6789258C1CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbiHHCnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbiHHCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556E821B4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W2IBSE6OJvDnrYaJoiE0u8Y6LmGWG6njA3i978Pnn/E=; b=aCyTn0AbGOfCdL2wtfff6oEQ+x
        s6ZE+C8K84hpVto1NiK3IQGqXdl8nMqGziOVuC75RKlVXD2fo/IcdTpFTQtqqY5SEKhuliQuLhtW7
        UwCYa3eGp35ag3TMIuy2zvWtYxAQyn8Yg3dpqEmVuL3GvJAUfH1T9RHhegecPkoOkPM2TvSLWCIDU
        hZqjPt1uL3F8lGXG8MYOFN+8Kfjckzrj1hC5knbk5l8jqarMOclFN3KY0lHxq3nXu0E74hyQNGBO/
        5OvS+t4CaRDHYlWXUlF5uxZdt/Uc/Qlu1bN/XglH38RkqBxFSCnQzIAS72Y5hxs4Ov+dphfXlOxis
        VE205cSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRt-RN; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 15/32] vsprintf: Refactor ip_addr_string()
Date:   Mon,  8 Aug 2022 03:41:11 +0100
Message-Id: <20220808024128.3219082-16-willy@infradead.org>
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
   handling in the top level vpr_buf(), this changes ip_addr_string() to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 114 ++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 77 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f47f10659737..076e2d23be47 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1276,13 +1276,13 @@ void mac_address_string(struct printbuf *out, u8 *addr,
 }
 
 static noinline_for_stack
-void ip4_string(struct printbuf *out,
-		const u8 *addr, const char *fmt)
+void ip4_string(struct printbuf *out, const u8 *addr, const char *fmt)
 {
-	int i;
-	bool leading_zeros = (fmt[0] == 'i');
-	int index;
-	int step;
+	struct printf_spec spec = default_dec_spec;
+	int i, index, step;
+
+	if (fmt[0] == 'i')
+		spec.precision = 3;
 
 	switch (fmt[2]) {
 	case 'h':
@@ -1306,19 +1306,9 @@ void ip4_string(struct printbuf *out,
 		break;
 	}
 	for (i = 0; i < 4; i++) {
-		char temp[4] __aligned(2);	/* hold each IP quad in reverse order */
-		int digits = put_dec_trunc8(temp, addr[index]) - temp;
-		if (leading_zeros) {
-			if (digits < 3)
-				prt_char(out, '0');
-			if (digits < 2)
-				prt_char(out, '0');
-		}
-		/* reverse the digits in the quad */
-		while (digits--)
-			prt_char(out, temp[digits]);
-		if (i < 3)
+		if (i)
 			prt_char(out, '.');
+		number(out, addr[index], spec);
 		index += step;
 	}
 }
@@ -1401,8 +1391,6 @@ void ip6_compressed_string(struct printbuf *out, const char *addr)
 			__prt_char(out, ':');
 		ip4_string(out, &in6.s6_addr[12], "I4");
 	}
-
-	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
@@ -1420,41 +1408,20 @@ void ip6_string(struct printbuf *out, const char *addr, const char *fmt)
 
 static noinline_for_stack
 void ip6_addr_string(struct printbuf *out, const u8 *addr,
-		     struct printf_spec spec, const char *fmt)
+		     const char *fmt)
 {
-	char ip6_addr_buf[sizeof("xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255")];
-	struct printbuf ip6_addr = PRINTBUF_EXTERN(ip6_addr_buf, sizeof(ip6_addr_buf));
-
 	if (fmt[0] == 'I' && fmt[2] == 'c')
-		ip6_compressed_string(&ip6_addr, addr);
+		ip6_compressed_string(out, addr);
 	else
-		ip6_string(&ip6_addr, addr, fmt);
-
-	string_nocheck(out, ip6_addr_buf, spec);
-}
-
-static noinline_for_stack
-void ip4_addr_string(struct printbuf *out, const u8 *addr,
-		     struct printf_spec spec, const char *fmt)
-{
-	char ip4_addr_buf[sizeof("255.255.255.255")];
-	struct printbuf ip4_addr = PRINTBUF_EXTERN(ip4_addr_buf, sizeof(ip4_addr_buf));
-
-	ip4_string(&ip4_addr, addr, fmt);
-
-	string_nocheck(out, ip4_addr_buf, spec);
+		ip6_string(out, addr, fmt);
 }
 
 static noinline_for_stack
 void ip6_addr_string_sa(struct printbuf *out,
 			const struct sockaddr_in6 *sa,
-			struct printf_spec spec, const char *fmt)
+			const char *fmt)
 {
 	bool have_p = false, have_s = false, have_f = false, have_c = false;
-	char ip6_addr_buf[sizeof("[xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255]") +
-		sizeof(":12345") + sizeof("/123456789") +
-		sizeof("%1234567890")];
-	struct printbuf ip6_addr = PRINTBUF_EXTERN(ip6_addr_buf, sizeof(ip6_addr_buf));
 	const u8 *addr = (const u8 *) &sa->sin6_addr;
 	char fmt6[2] = { fmt[0], '6' };
 
@@ -1477,41 +1444,35 @@ void ip6_addr_string_sa(struct printbuf *out,
 	}
 
 	if (have_p || have_s || have_f)
-		prt_char(&ip6_addr, '[');
+		prt_char(out, '[');
 
 	if (fmt6[0] == 'I' && have_c)
-		ip6_compressed_string(&ip6_addr, addr);
+		ip6_compressed_string(out, addr);
 	else
-		ip6_string(&ip6_addr, addr, fmt6);
+		ip6_string(out, addr, fmt6);
 
 	if (have_p || have_s || have_f)
-		prt_char(&ip6_addr, ']');
+		prt_char(out, ']');
 
 	if (have_p) {
-		prt_char(&ip6_addr, ':');
-		number(&ip6_addr, ntohs(sa->sin6_port), spec);
+		prt_char(out, ':');
+		prt_u64(out, ntohs(sa->sin6_port));
 	}
 	if (have_f) {
-		prt_char(&ip6_addr, '/');
-		number(&ip6_addr, ntohl(sa->sin6_flowinfo &
-					IPV6_FLOWINFO_MASK), spec);
+		prt_char(out, '/');
+		prt_u64(out, ntohl(sa->sin6_flowinfo & IPV6_FLOWINFO_MASK));
 	}
 	if (have_s) {
-		prt_char(&ip6_addr, '%');
-		number(&ip6_addr, sa->sin6_scope_id, spec);
+		prt_char(out, '%');
+		prt_u64(out, sa->sin6_scope_id);
 	}
-
-	string_nocheck(out, ip6_addr_buf, spec);
 }
 
 static noinline_for_stack
-void ip4_addr_string_sa(struct printbuf *out,
-			const struct sockaddr_in *sa,
-			struct printf_spec spec, const char *fmt)
+void ip4_addr_string_sa(struct printbuf *out, const struct sockaddr_in *sa,
+			const char *fmt)
 {
 	bool have_p = false;
-	char ip4_addr_buf[sizeof("255.255.255.255") + sizeof(":12345")];
-	struct printbuf ip4_addr = PRINTBUF_EXTERN(ip4_addr_buf, sizeof(ip4_addr_buf));
 	const u8 *addr = (const u8 *) &sa->sin_addr.s_addr;
 	char fmt4[3] = { fmt[0], '4', 0 };
 
@@ -1530,29 +1491,27 @@ void ip4_addr_string_sa(struct printbuf *out,
 		}
 	}
 
-	ip4_string(&ip4_addr, addr, fmt4);
+	ip4_string(out, addr, fmt4);
 	if (have_p) {
-		prt_char(&ip4_addr, ':');
-		number(&ip4_addr, ntohs(sa->sin_port), spec);
+		prt_char(out, ':');
+		prt_u64(out, ntohs(sa->sin_port));
 	}
-
-	string_nocheck(out, ip4_addr_buf, spec);
 }
 
 static noinline_for_stack
 void ip_addr_string(struct printbuf *out, const void *ptr,
-		    struct printf_spec spec, const char *fmt)
+		    const char *fmt)
 {
 	char *err_fmt_msg;
 
-	if (check_pointer_spec(out, ptr, spec))
+	if (check_pointer(out, ptr))
 		return;
 
 	switch (fmt[1]) {
 	case '6':
-		return ip6_addr_string(out, ptr, spec, fmt);
+		return ip6_addr_string(out, ptr, fmt);
 	case '4':
-		return ip4_addr_string(out, ptr, spec, fmt);
+		return ip4_string(out, ptr, fmt);
 	case 'S': {
 		const union {
 			struct sockaddr		raw;
@@ -1562,16 +1521,16 @@ void ip_addr_string(struct printbuf *out, const void *ptr,
 
 		switch (sa->raw.sa_family) {
 		case AF_INET:
-			return ip4_addr_string_sa(out, &sa->v4, spec, fmt);
+			return ip4_addr_string_sa(out, &sa->v4, fmt);
 		case AF_INET6:
-			return ip6_addr_string_sa(out, &sa->v6, spec, fmt);
+			return ip6_addr_string_sa(out, &sa->v6, fmt);
 		default:
-			return error_string_spec(out, "(einval)", spec);
+			return error_string(out, "(einval)");
 		}}
 	}
 
 	err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
-	return error_string_spec(out, err_fmt_msg, spec);
+	error_string(out, err_fmt_msg);
 }
 
 static noinline_for_stack
@@ -2318,7 +2277,8 @@ void pointer(struct printbuf *out, const char *fmt,
 					 * 4:	001.002.003.004
 					 * 6:   000102...0f
 					 */
-		return ip_addr_string(out, ptr, spec, fmt);
+		ip_addr_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'E':
 		return escaped_string(out, ptr, spec, fmt);
 	case 'U':
-- 
2.35.1

