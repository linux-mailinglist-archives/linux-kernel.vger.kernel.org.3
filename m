Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4110D592696
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiHNVWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbiHNVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:54 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B114CB1D4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBYJ4m4vFg0jyWQcDf+FclpmW5Pycpi1G9BZRl929UU=;
        b=Km+s1/lKZpoOTZ7dmJ4OU2074QhV00Zfma2luuOmEFfIVkDEJb8ex7REQrpmFPUVdeBNx1
        lf2no6eIZ6bSFlTcgFoejhjkw9E6bgrQ3VgLH8aE5lo6da2KYcezT9JScXH40NzQ9bpr70
        8aH7RAzBcSVkPy96AjoMh/eIhrZ0jQQ=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 19/32] vsprintf: Refactor device_node_string, fwnode_string
Date:   Sun, 14 Aug 2022 17:19:58 -0400
Message-Id: <20220814212011.1727798-20-kent.overstreet@linux.dev>
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

 - eliminate on-stack buffer in device_node_string
 - eliminate unnecessary uses of printf_spec, lift format string
   precision/field width to pointer()

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 73 ++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index df954902a1..81d2f3fa1a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1963,25 +1963,20 @@ void fwnode_full_name_string(struct printbuf *out,
 
 static noinline_for_stack
 void device_node_string(struct printbuf *out, struct device_node *dn,
-			struct printf_spec spec, const char *fmt)
+			const char *fmt)
 {
-	char tbuf[sizeof("xxxx") + 1];
 	const char *p;
 	int ret;
-	unsigned start = out->pos;
 	struct property *prop;
 	bool has_mult, pass;
 
-	struct printf_spec str_spec = spec;
-	str_spec.field_width = -1;
-
 	if (fmt[0] != 'F')
-		return error_string_spec(out, "(%pO?)", spec);
+		return error_string(out, "(%pO?)");
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return error_string_spec(out, "(%pOF?)", spec);
+		return error_string(out, "(%pOF?)");
 
-	if (check_pointer_spec(out, dn, spec))
+	if (check_pointer(out, dn))
 		return;
 
 	/* simple case without anything any more format specifiers */
@@ -1990,7 +1985,6 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 		fmt = "f";
 
 	for (pass = false; strspn(fmt,"fnpPFcC"); fmt++, pass = true) {
-		int precision;
 		if (pass)
 			prt_char(out, ':');
 
@@ -1998,43 +1992,41 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 		case 'f':	/* full_name */
 			fwnode_full_name_string(out, of_fwnode_handle(dn));
 			break;
-		case 'n':	/* name */
-			p = fwnode_get_name(of_fwnode_handle(dn));
-			precision = str_spec.precision;
-			str_spec.precision = strchrnul(p, '@') - p;
-			string_spec(out, p, str_spec);
-			str_spec.precision = precision;
+		case 'n': {	/* name */
+			const char *name = fwnode_get_name(of_fwnode_handle(dn));
+			unsigned len = strchrnul(name, '@') - name;
+
+			prt_bytes(out, name, len);
 			break;
+		}
 		case 'p':	/* phandle */
-			prt_u64(out, (unsigned int)dn->phandle);
+			prt_u64(out, dn->phandle);
 			break;
 		case 'P':	/* path-spec */
 			p = fwnode_get_name(of_fwnode_handle(dn));
 			if (!p[1])
 				p = "/";
-			string_spec(out, p, str_spec);
+			string(out, p);
 			break;
 		case 'F':	/* flags */
-			tbuf[0] = of_node_check_flag(dn, OF_DYNAMIC) ? 'D' : '-';
-			tbuf[1] = of_node_check_flag(dn, OF_DETACHED) ? 'd' : '-';
-			tbuf[2] = of_node_check_flag(dn, OF_POPULATED) ? 'P' : '-';
-			tbuf[3] = of_node_check_flag(dn, OF_POPULATED_BUS) ? 'B' : '-';
-			tbuf[4] = 0;
-			string_nocheck(out, tbuf, str_spec);
+			prt_char(out, of_node_check_flag(dn, OF_DYNAMIC) ? 'D' : '-');
+			prt_char(out, of_node_check_flag(dn, OF_DETACHED) ? 'd' : '-');
+			prt_char(out, of_node_check_flag(dn, OF_POPULATED) ? 'P' : '-');
+			prt_char(out, of_node_check_flag(dn, OF_POPULATED_BUS) ? 'B' : '-');
 			break;
 		case 'c':	/* major compatible string_spec */
 			ret = of_property_read_string(dn, "compatible", &p);
 			if (!ret)
-				string_spec(out, p, str_spec);
+				string(out, p);
 			break;
 		case 'C':	/* full compatible string_spec */
 			has_mult = false;
 			of_property_for_each_string(dn, "compatible", prop, p) {
 				if (has_mult)
-					string_nocheck(out, ",", str_spec);
-				string_nocheck(out, "\"", str_spec);
-				string_spec(out, p, str_spec);
-				string_nocheck(out, "\"", str_spec);
+					prt_char(out, ',');
+				prt_char(out, '\"');
+				string(out, p);
+				prt_char(out, '\"');
 
 				has_mult = true;
 			}
@@ -2043,39 +2035,30 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 			break;
 		}
 	}
-
-	widen_string(out, out->pos - start, spec);
 }
 
 static noinline_for_stack
 void fwnode_string(struct printbuf *out,
 		   struct fwnode_handle *fwnode,
-		   struct printf_spec spec, const char *fmt)
+		   const char *fmt)
 {
-	struct printf_spec str_spec = spec;
-	unsigned start = out->pos;
-
-	str_spec.field_width = -1;
-
 	if (*fmt != 'w')
-		return error_string_spec(out, "(%pf?)", spec);
+		return error_string(out, "(%pf?)");
 
-	if (check_pointer_spec(out, fwnode, spec))
+	if (check_pointer(out, fwnode))
 		return;
 
 	fmt++;
 
 	switch (*fmt) {
 	case 'P':	/* name */
-		string_spec(out, fwnode_get_name(fwnode), str_spec);
+		string(out, fwnode_get_name(fwnode));
 		break;
 	case 'f':	/* full_name */
 	default:
 		fwnode_full_name_string(out, fwnode);
 		break;
 	}
-
-	widen_string(out, out->pos - start, spec);
 }
 
 int __init no_hash_pointers_enable(char *str)
@@ -2313,9 +2296,11 @@ void pointer(struct printbuf *out, const char *fmt,
 		flags_string(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
 	case 'O':
-		return device_node_string(out, ptr, spec, fmt + 1);
+		device_node_string(out, ptr, fmt + 1);
+		return do_width_precision(out, prev_pos, spec);
 	case 'f':
-		return fwnode_string(out, ptr, spec, fmt + 1);
+		fwnode_string(out, ptr, fmt + 1);
+		return do_width_precision(out, prev_pos, spec);
 	case 'x':
 		return pointer_string(out, ptr, spec);
 	case 'e':
-- 
2.36.1

