Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED47550E08
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiFTAoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbiFTAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FB4BC82
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:25 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 89so14069525qvc.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWerF38n5tR4uSTYJFoRyRIOxNHFK081RFLAVt0+9RY=;
        b=gdle2QPYdF/YDxgrZ9pCDc5ZojhpY5013lioWippA7pS5CQtIdOHGV0VF6XVa7t8ur
         E4yDb9mwxMBv1FoxU33la1kQe+PkFQh+p4f404l5zrxKPcn7TqNGt2UAOeSLXL4sc9KE
         XTUgUbfGvRPlBJCKZYScvl0eybu5/QUXFImffx6qGE9NmZz830DBTO+DCBDXTRmWC66O
         Po1GeL6X5PVq6XXZ61vXr/ublbiswEFasOtyLVMIwXoK2hTpb15WdTu9/fuuVMnZPaUo
         mZWzHxOUGkR4pdoohQxvviHKsTD8mB0XpzPBuVFY+tNQg5HNEefdc4RGvWTO+Uq850ej
         9HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWerF38n5tR4uSTYJFoRyRIOxNHFK081RFLAVt0+9RY=;
        b=1BHKAF43yuGg/dHbkN1DM+q9sFSWzWSzf/9n3CCgERZdlTvgByxdsvuNh1N+QU9xHy
         TS6ZLIzErnm74t2qDkurIg1Gw6jHlZk3g5P7CaNe1rbQMdY/6dN9hqTHKBFnWJKuRlO7
         yAZjYGqQkd3U4rRLJIUMYt1OQDxBqYVNRcJcq0gkWEwcQW0Y0viRyEQtYkvu3h/dlca/
         DB+MKQy92gMZjJGYnZKZJJVglmCLjYGV1wKnuD4U0kBUnW+MMz/Qk+JpwHqFuStdtRDq
         Fw3Gfpk+UdMW5HTN9gS5RT9GU3E2wtWkntk5+ksB70mKhydJr0yFMNfagRTMU4iGopkW
         C6gQ==
X-Gm-Message-State: AJIora8EIUXJuZNqtUugcd4KvUXM8Tn22CgnGQayfCQDrddA+5cei4N9
        yTZ6XePJCtq7/YMJ4NkbBV1JW0zzYghC2Oo=
X-Google-Smtp-Source: AGRyM1sqZc0tCgtuhT0Syhi5cozDr+xp4LtE9SWos2+SZBuOvssoygcA8ICZRj2oL8lN6sg+wRIGtw==
X-Received: by 2002:a05:6214:62a:b0:46e:5f25:56b6 with SMTP id a10-20020a056214062a00b0046e5f2556b6mr17206265qvx.12.1655685803670;
        Sun, 19 Jun 2022 17:43:23 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bi20-20020a05620a319400b006a6dcd92eb3sm10291756qkb.121.2022.06.19.17.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:23 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 21/34] vsprintf: Refactor device_node_string, fwnode_string
Date:   Sun, 19 Jun 2022 20:42:20 -0400
Message-Id: <20220620004233.3805-22-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
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
index 3900f7a1a5..7f47533ed8 100644
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
2.36.1

