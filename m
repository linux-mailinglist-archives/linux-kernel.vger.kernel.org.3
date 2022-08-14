Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623E592691
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiHNVWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbiHNVVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:11 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A60A1B6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCa0Dl56nRnTQ/AygQWshEXsD/TuB53+NaXkvUhc+5E=;
        b=V4klSAB1YypaucWaf8PH1HXnZyBcG+/OKTr9xEteBDemuAwzmZTbrWpPwO9S3lE8ENGyTg
        HGjb79XSwYBzx+fnVaYSKPkFw67iZkR5dJsSAZVXcktyyaC6ZA14yKogOUxUKa52YQdiD+
        2OzenYhobV+tyrwTefevp1Pa1PdS5PU=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 15/32] vsprintf: Refactor ip_addr_string()
Date:   Sun, 14 Aug 2022 17:19:54 -0400
Message-Id: <20220814212011.1727798-16-kent.overstreet@linux.dev>
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
index e3189c9f2d..27d23e82f5 100644
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
2.36.1

