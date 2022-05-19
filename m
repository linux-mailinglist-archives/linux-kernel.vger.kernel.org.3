Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E516252DB37
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbiESR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242721AbiESRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F61B040B;
        Thu, 19 May 2022 10:25:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f10so5899824pjs.3;
        Thu, 19 May 2022 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDtwsLYmJX2VI92KrqMyeH8WST984GDnjSHL6+LrCvw=;
        b=AGhYGSWRQ9YX9HgmiJ/WyOoO/8SiqbWStOyWHFfhAnfYEPlOYLB/n97gekxJrcvaIj
         jFjB5oK7lXEt1AZAYEFXJAkx4LfXzQUANPm3ZwcYrA7ovTgvBN6TaBUJyL8cXGd1ic8N
         cl0vm3vi0N2CIw1TibZPw8z6fY1GqJdxfCM8wXI1Ny+EHoxoBMfrqfeMJlxCUbbLyboT
         7ytaRjOzKZ05/49H2l08CZXmG7KQAhdHWYEwo9fCQHNRb47Vhv5Z1gfcOzWxgBHXeyuP
         ZJ11VuM+lzskUFGdDC9ZKMifrhGNXIl0a8q+g6PVILguFrvz1eOM3Cza/MSAMsUkVIPi
         nrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDtwsLYmJX2VI92KrqMyeH8WST984GDnjSHL6+LrCvw=;
        b=pPZ2jDaIeh6eS8NTBmEN0wLLXfsmAdApYC0td5RIPbSyDbRWtMBs/Pzn8RWEQFPwCn
         /bXvtZI2r2U6DxF4ZSt9T3N1PUIFHkEhUhqq86K8hMlki1uqbOzafglRDPZnRofLTJhs
         xLkY7cJQ4pvfYY8s3yYKfsJGNbyRZ0oe3auSNNxAR9Sgodhsm2bedyNb1F1Ka/q+WH/V
         Tdv/d9S1RFKQf8zI7KIx56eDLje6u2iIGn70ObknWjhNaXYKpG3YKuD81yfpXPYouPwS
         DMrt+az4yv9sogWEUytOL6LtBt0QWenpcxVO1Kw2xWo8OPSIKWqZ7f9NwlGig5/f3Bfp
         pwNg==
X-Gm-Message-State: AOAM531Uqc5RmkLzd2rJ0Kc42zsg/zJeCdnnzL31lAXPAdZgNfLsnFEm
        if7UFrzRih6X9hXih8A1+HhC4kcaR5HZ
X-Google-Smtp-Source: ABdhPJwCQnlAgwYPFM1FAPh7NCigi4C/s5gvY/TMwe/eBeT/sE/vNfCX2jPPmVLXlqgPdCFItzC3oQ==
X-Received: by 2002:a17:90b:4a01:b0:1dc:67b8:983f with SMTP id kk1-20020a17090b4a0100b001dc67b8983fmr6207580pjb.1.1652981121161;
        Thu, 19 May 2022 10:25:21 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:20 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 20/28] vsprintf: Refactor device_node_string, fwnode_string
Date:   Thu, 19 May 2022 13:24:13 -0400
Message-Id: <20220519172421.162394-21-kent.overstreet@gmail.com>
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

 - eliminate on-stack buffer in device_node_string
 - eliminate unnecessary uses of printf_spec, lift format string
   precision/field width to pointer()

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 75 ++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 971cf17d33..ef8b06a25a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1962,25 +1962,20 @@ void fwnode_full_name_string(struct printbuf *out,
 
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
@@ -1989,51 +1984,48 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 		fmt = "f";
 
 	for (pass = false; strspn(fmt,"fnpPFcC"); fmt++, pass = true) {
-		int precision;
 		if (pass)
-			__pr_char(out, ':');
+			pr_char(out, ':');
 
 		switch (*fmt) {
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
+			pr_bytes(out, name, len);
 			break;
+		}
 		case 'p':	/* phandle */
-			pr_u64(out, (unsigned int)dn->phandle);
+			pr_u64(out, dn->phandle);
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
+			pr_char(out, of_node_check_flag(dn, OF_DYNAMIC) ? 'D' : '-');
+			pr_char(out, of_node_check_flag(dn, OF_DETACHED) ? 'd' : '-');
+			pr_char(out, of_node_check_flag(dn, OF_POPULATED) ? 'P' : '-');
+			pr_char(out, of_node_check_flag(dn, OF_POPULATED_BUS) ? 'B' : '-');
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
+					pr_char(out, ',');
+				pr_char(out, '\"');
+				string(out, p);
+				pr_char(out, '\"');
 
 				has_mult = true;
 			}
@@ -2042,39 +2034,30 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
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
 
 /* Disable pointer hashing if requested */
@@ -2316,9 +2299,11 @@ void pointer(struct printbuf *out, const char *fmt,
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

