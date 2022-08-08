Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01CC58C1CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbiHHCnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbiHHClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C166521BA
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gLSmP0ezGtWML91IudXrNJu8Zj7NmJrDaiBCbrXz+LY=; b=MTuHy9VnQfrt2AB+/dowXbi0Xl
        p/HsStgU1cVih1U6rA3n+lDtpLxkQnEfX/PJ9DCqQLl9dmaOeL+IMDfMclxATrkBqZTJk/yVL/+ym
        Dvi5FrLyOGSBglGfyE/fmAK0psd/SAOf5CAfd3w9Z/A5ArMZft9EED/FgJU4F4LRVUfRe1SK5244n
        UUvRaRG11eBhZWsSXwpHo+I6f5EiRjAR6j1EeEqIwctpKDo3WCeDhq3bvz33d4T13V9/H775it6jV
        grcDXX65Gl6/qi6bkwITzFZo3MNtqHnXmRWWQyCYi+agf/UoME3pil5+McLv7ZUCHL3s2YoiV0fUN
        XtBiz4Lw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVS2-56; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 19/32] vsprintf: Refactor device_node_string, fwnode_string
Date:   Mon,  8 Aug 2022 03:41:15 +0100
Message-Id: <20220808024128.3219082-20-willy@infradead.org>
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
index 38d16aa79e56..06cfa06aa4ee 100644
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
2.35.1

