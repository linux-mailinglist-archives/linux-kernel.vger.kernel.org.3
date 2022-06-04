Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA3E53D84D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiFDTch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbiFDTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C40350030
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:23 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 15so3180689qki.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBLUoPSxSGKqcejJuuf09USNiWA4deHhuF7lsarfJlk=;
        b=b8ibYrANVzYijUODa3pl10vPBNYWfl7jr/XJ0dU3DOVCP57IAou/cLUfCpFakBCDY3
         K575QZbv3eNn7iKbYcpqiuW9KTxgO/xwOjxQU0srH9MLM8L2AGsLK7FKCRhrKXy9aqfm
         /cpXC3HqPAkEk2S3gRtHNOTWZqzLBcOnFKxG9hYKi7Kx6kywT9LorSWdxoD8aA72zoAG
         8eACTq4BGw9zdjFvUK2FAee3elqFwkqMDglw3/YWtIQisnu5rw/9UCO4bnIQnt72EtlD
         TCaFjJfgQApWcuht3Y/itnuqRXuzCJVjwjJFqliuc8zFuN5MVGVyfhiZI8tkzejw/gvo
         aX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBLUoPSxSGKqcejJuuf09USNiWA4deHhuF7lsarfJlk=;
        b=OA8NJhhJtYQ6deDCKHdeU4Gg0lH75YzGS6FmNqJNp1zLCeB/4YEVst/Y9gPQTW73t5
         ggKiOxv5I00WY5IjQdzffuy9YX9kJAbrrpAbRUDkeGicC2tLXSe0WycxqFwzT6N6+mZ5
         SRlhlczbLsAAvvcGgtcIftsNAPQq/nBpY3q65CVaQ5RhUlCHZmik8rO1nVTHaN4Q4nuX
         C0YpxfTqqG793x3HcBS932D0LCqKAH9THSEFwzf1QNm5iztkdgsN8gAg5soB8qo21fB0
         6KqskzYUtbMJ/ypSiPV97mISprj//6RoyPL68MW20vZU+NcPF0Hur9avT9TB3GZd5VRl
         bH8w==
X-Gm-Message-State: AOAM531U+0+VXEtNNlbh/HYfsAKaTYhsK5VPgA1ju9Mp9AzbhmDWA8qp
        LR13hfp2CaNjpwttYpbVqQcODoedfqMJ
X-Google-Smtp-Source: ABdhPJxV991bBD3QwqWsTw3IDLsLBmeZHoyyMOxLxoxh00qU774JUl1cV2K9WSceT4W7bgiusGKMgw==
X-Received: by 2002:ae9:eb94:0:b0:6a6:a208:e420 with SMTP id b142-20020ae9eb94000000b006a6a208e420mr5815509qkg.684.1654371081736;
        Sat, 04 Jun 2022 12:31:21 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:20 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 21/33] vsprintf: Refactor device_node_string, fwnode_string
Date:   Sat,  4 Jun 2022 15:30:30 -0400
Message-Id: <20220604193042.1674951-22-kent.overstreet@gmail.com>
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

 - eliminate on-stack buffer in device_node_string
 - eliminate unnecessary uses of printf_spec, lift format string
   precision/field width to pointer()

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 73 ++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 1cd08d0d5b..a0a17a2aac 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1988,25 +1988,20 @@ void fwnode_full_name_string(struct printbuf *out,
 
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
@@ -2015,7 +2010,6 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 		fmt = "f";
 
 	for (pass = false; strspn(fmt,"fnpPFcC"); fmt++, pass = true) {
-		int precision;
 		if (pass)
 			prt_char(out, ':');
 
@@ -2023,43 +2017,41 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
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
@@ -2068,39 +2060,30 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
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
@@ -2338,9 +2321,11 @@ void pointer(struct printbuf *out, const char *fmt,
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
2.36.0

