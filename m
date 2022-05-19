Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0E352DB31
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbiESR0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242664AbiESRZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0431A5019;
        Thu, 19 May 2022 10:25:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c14so5729202pfn.2;
        Thu, 19 May 2022 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=teMqOk605wE7rUEuFa8rRtNMPBYif8vlfnxLj41/R8s=;
        b=RhLKemdeyKMoaO8/D7bl3XzrMy3eOARd40G6avAxat24s5KPh9KNOXNZBsTaKFNNZA
         URVsxFq7jsqNmeO1Zz75Bw9lTKStQQxXgFDrarQpK1jFC6FvHVHlT8Ph8aCGSZtRovAS
         mwFLG85EBXYt4+gvjt7J3Ncm9/bi4YVwDp0b9A8rT8wBpL2KbdQAMgEPfeOYFaJkcL2N
         hdeumnwhHY1E9Dtj7Pkr9kn0GwpRRm6bpBpp8LD3cO16RTl3lCouCs1PEEfkWcZoB47M
         tVCS9Ws9/pcvzvR9A90sQg4Hl9H+0NsRfi5fopz/8ePZUK1Y9myJJeIqAesjHKoKPkma
         OQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=teMqOk605wE7rUEuFa8rRtNMPBYif8vlfnxLj41/R8s=;
        b=WZKneUQmlddI/8YGEMJzHMkI0A9WOYg5hhA9K9j2TQj40B+haIGRGaRk9NpwaF73Rx
         oiaP5k1ruo4B1upoM4G+ku+Hs6pzb4KifSFCnNey2OKtYVbHX2DN1Lr1BfJHz95GzTrM
         yx+iXAKQ7Sv6Bqf8VuTCe4ZNZw4jC1H+7cUGFD6oTWTpASWDzJ+fMDS5PDcDja2rQaSm
         WPu9rAztjWdXPXJEeUHrExE30nD+iPpRVc7h5dD7P+poR07xE+oXIr+9wNU/xT0f2gr6
         kHNNljmoJGAu5JIINSRsyNReyifujjPF9Eo2e+CwWIFk6/M4sQt5P9ua8DpRTy4OD8TJ
         8Jrg==
X-Gm-Message-State: AOAM530Picoxc0g6lGUUMemVcFdYLLbUfRX11CQmlFCphriEXrsH5mWr
        PEKmUQy5K0eubyiM1BlVHUZ8CXmo8l5T
X-Google-Smtp-Source: ABdhPJxmG4yWmQYM6MYp7ey8C6E2XXkNpCtkpekZPD9kwoH4kpFBMfn/+DU75HGQBkBCiYnuoFeWRA==
X-Received: by 2002:a63:e017:0:b0:3f2:543b:8402 with SMTP id e23-20020a63e017000000b003f2543b8402mr4763071pgh.209.1652981111766;
        Thu, 19 May 2022 10:25:11 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:11 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 16/28] vsprintf: Refactor ip_addr_string()
Date:   Thu, 19 May 2022 13:24:09 -0400
Message-Id: <20220519172421.162394-17-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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
 lib/vsprintf.c | 116 ++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 79 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3d17ddad31..62a221522c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1273,13 +1273,13 @@ void mac_address_string(struct printbuf *out, u8 *addr,
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
@@ -1303,19 +1303,9 @@ void ip4_string(struct printbuf *out,
 		break;
 	}
 	for (i = 0; i < 4; i++) {
-		char temp[4] __aligned(2);	/* hold each IP quad in reverse order */
-		int digits = put_dec_trunc8(temp, addr[index]) - temp;
-		if (leading_zeros) {
-			if (digits < 3)
-				__pr_char(out, '0');
-			if (digits < 2)
-				__pr_char(out, '0');
-		}
-		/* reverse the digits in the quad */
-		while (digits--)
-			__pr_char(out, temp[digits]);
-		if (i < 3)
+		if (i)
 			__pr_char(out, '.');
+		number(out, addr[index], spec);
 		index += step;
 	}
 }
@@ -1398,8 +1388,6 @@ void ip6_compressed_string(struct printbuf *out, const char *addr)
 			__pr_char(out, ':');
 		ip4_string(out, &in6.s6_addr[12], "I4");
 	}
-
-	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
@@ -1419,41 +1407,20 @@ void ip6_string(struct printbuf *out, const char *addr, const char *fmt)
 
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
 
@@ -1476,42 +1443,35 @@ void ip6_addr_string_sa(struct printbuf *out,
 	}
 
 	if (have_p || have_s || have_f)
-		__pr_char(&ip6_addr, '[');
+		__pr_char(out, '[');
 
 	if (fmt6[0] == 'I' && have_c)
-		ip6_compressed_string(&ip6_addr, addr);
+		ip6_compressed_string(out, addr);
 	else
-		ip6_string(&ip6_addr, addr, fmt6);
+		ip6_string(out, addr, fmt6);
 
 	if (have_p || have_s || have_f)
-		__pr_char(&ip6_addr, ']');
+		__pr_char(out, ']');
 
 	if (have_p) {
-		__pr_char(&ip6_addr, ':');
-		number(&ip6_addr, ntohs(sa->sin6_port), spec);
+		__pr_char(out, ':');
+		pr_u64(out, ntohs(sa->sin6_port));
 	}
 	if (have_f) {
-		__pr_char(&ip6_addr, '/');
-		number(&ip6_addr, ntohl(sa->sin6_flowinfo &
-					IPV6_FLOWINFO_MASK), spec);
+		__pr_char(out, '/');
+		pr_u64(out, ntohl(sa->sin6_flowinfo & IPV6_FLOWINFO_MASK));
 	}
 	if (have_s) {
-		__pr_char(&ip6_addr, '%');
-		number(&ip6_addr, sa->sin6_scope_id, spec);
+		__pr_char(out, '%');
+		pr_u64(out, sa->sin6_scope_id);
 	}
-	printbuf_nul_terminate(&ip6_addr);
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
 
@@ -1530,30 +1490,27 @@ void ip4_addr_string_sa(struct printbuf *out,
 		}
 	}
 
-	ip4_string(&ip4_addr, addr, fmt4);
+	ip4_string(out, addr, fmt4);
 	if (have_p) {
-		__pr_char(&ip4_addr, ':');
-		number(&ip4_addr, ntohs(sa->sin_port), spec);
+		__pr_char(out, ':');
+		pr_u64(out, ntohs(sa->sin_port));
 	}
-	printbuf_nul_terminate(&ip4_addr);
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
@@ -1563,16 +1520,16 @@ void ip_addr_string(struct printbuf *out, const void *ptr,
 
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
@@ -2323,7 +2280,8 @@ void pointer(struct printbuf *out, const char *fmt,
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

