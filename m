Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C178853D850
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbiFDTcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbiFDTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:39 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5484F9DF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c144so5882473qkg.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pf/FzfiFeov0TvwCq8OTCWTHUawuSdyfQ/gNqM6PjUQ=;
        b=Tp1wo/ZA2SnFuK5A4UnbUfj64gtGhb0gbb64GWpIAcagfJfF5IH0+tH1uilDeoXUfX
         PzZqlrtQRWDZ30E8MYMBkG+sLxciu/HfrwelqrPWS76y29Bi4lH6VcIY4c29OaeWRmXp
         e2EeoJNgLP9blMhLQdwaFpXku1pYbg4d6uTE2LaS4ncXrOpRCFhzpaEMW4PpnwWjyJmo
         wuwD+CuD+LusMeO+24rydrDhoG9tD9ae8sk/PhsvOwGXN4OBWZh9RwHUTNuhzD1J0u28
         gdiZJsq+d2eztF/eVUENzF6wa8d2aK+kKes0cnqmWjJCCJgJLCd8WhUkGC5sed8Ci5Oe
         qsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pf/FzfiFeov0TvwCq8OTCWTHUawuSdyfQ/gNqM6PjUQ=;
        b=2FoleXmjJIkhchAZCMUmM0ieo3/+JT/nl6Q4vPSVLaCM/Gzf44XssaWty4JZyx2f0h
         CHTM3JOW23+c7yWg8iANaMHlphQxTFJfX0a1oJ2ylfnF6d0TuGAP9g7JLosp2Th4wn9s
         SIhR7UxUFC4jpxU9oSXrfzxr7Q4JZF5sHr0zr0i7DH5v/slce8MDrhuqv6VOHuCq/onA
         WC2GwR9k7ntRlTJzksHTNtXgyBxF2wCkm2Jhy28BsZHKoeVEa84j9Q99AP3roLmFWli5
         aU8hCJmYapW9AVBcs6ReQr1jByJsMRymCNpkMg9eP2jpn7dkEXEuEecp97rNAxZSoTe9
         TtTg==
X-Gm-Message-State: AOAM530xIAj+vm3oYxmEbgr6dYxVMmPzeqzrJNiLbtWCmN9AU478ja5U
        VWdv5B68qXq0BDZ+o5uptiEbim45KcCx
X-Google-Smtp-Source: ABdhPJzs8MC4G60VN3BYLJKVipa/+cKuKEJ8EV/K4ImNKi99R+/OG5w2PvvftTUqbF8oaoMR8/CfrA==
X-Received: by 2002:a37:e304:0:b0:6a6:a784:6276 with SMTP id y4-20020a37e304000000b006a6a7846276mr5009907qki.778.1654371075318;
        Sat, 04 Jun 2022 12:31:15 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:14 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 17/33] vsprintf: Refactor ip_addr_string()
Date:   Sat,  4 Jun 2022 15:30:26 -0400
Message-Id: <20220604193042.1674951-18-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - We're attempting to consolidate printf_spec and format string
   handling in the top level vpr_buf(), this changes ip_addr_string() to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 114 ++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 77 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 49565e0dc4..964e00b6a2 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1301,13 +1301,13 @@ void mac_address_string(struct printbuf *out, u8 *addr,
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
@@ -1331,19 +1331,9 @@ void ip4_string(struct printbuf *out,
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
@@ -1426,8 +1416,6 @@ void ip6_compressed_string(struct printbuf *out, const char *addr)
 			__prt_char(out, ':');
 		ip4_string(out, &in6.s6_addr[12], "I4");
 	}
-
-	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
@@ -1445,41 +1433,20 @@ void ip6_string(struct printbuf *out, const char *addr, const char *fmt)
 
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
 
@@ -1502,41 +1469,35 @@ void ip6_addr_string_sa(struct printbuf *out,
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
 
@@ -1555,29 +1516,27 @@ void ip4_addr_string_sa(struct printbuf *out,
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
@@ -1587,16 +1546,16 @@ void ip_addr_string(struct printbuf *out, const void *ptr,
 
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
@@ -2343,7 +2302,8 @@ void pointer(struct printbuf *out, const char *fmt,
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
2.36.0

