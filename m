Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5253D856
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiFDTcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbiFDTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C52E4F9FB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k6so5324321qkf.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZR3vpiR15jc25rT55XN+a9EgF+ZdSJRDIqigHrDnho=;
        b=Ax0TRUqWFqBQoDAa5BEt61bnAuF6Ed67k7TQfNLCysxCWPwEUuHJADW/dZVquOmELO
         M0YWX8DDPs0OMKpku7Ur655CIHt81ED3P1UOOGRUeTe1I02cB+hYv4EwRQrUsai49zUO
         Pmj9febU5I2VYRsTtF6sleaJaYntU1fK5Lpjk1bSdDuqvfbn3O3RQoP3JjX2RqbIJGwh
         Tlu3KnWVUpkMz/5qkQ7Nv2LdOTyT72jeWRQLQuI6uydqjz9UQZoV1w/I+JSPDKkkCRDx
         7Fao6awNZECbqzJNaP/U9f3eECWtgypdnQ2ICozXAsWCr3Q52drhMkO6olzQlXcCu+Xq
         cZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZR3vpiR15jc25rT55XN+a9EgF+ZdSJRDIqigHrDnho=;
        b=f3QIFx55Bpkm9ySzd22EPM4GgOYFizFutZC8sGIuQM2dD6+IWlqd8CxA3FHrFrF1Gp
         WwgAk1pfBo2YdS7REbySa2KqazFn9m1ihnDZ9kCwdj2mgfY/J2E4LqQn7+2sNE6teybb
         enXMtf5Ey0EqTWw2Zcnc118UM82B3FBrRw4T+G/nWXZySN/MKq4UmyrvVZHHAOvBrYF0
         zmqY5pF24xybiDpyjpcssDKGb3B6J5xmIlvHgHGz2yv/g3JGl0eEPjMbqOxE5Bsg62pP
         Z36WhYPoo9bAChVzxpd8gB1ZSfc0PlZIZEPzV71H2ZUGtjqZYixElB37jmyBXY/xoER1
         PShw==
X-Gm-Message-State: AOAM530B64D5A/0CaG8UIOajyJHYZCNxAZSe/hLovlzfcxYm9GefmKWV
        cpVkkkVu38vF7dgsu4DFfeqEkwHTtEYu
X-Google-Smtp-Source: ABdhPJyQPhTMjSqi97ahdwhDFjNJRE/3k8WyZKzM35WBcYJXHsCoozDbFPH5AQ99VPWww1VIWCG6Vw==
X-Received: by 2002:a05:620a:b42:b0:6a6:ab7a:8d0d with SMTP id x2-20020a05620a0b4200b006a6ab7a8d0dmr3335289qkg.515.1654371072323;
        Sat, 04 Jun 2022 12:31:12 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:11 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 15/33] vsprintf: Refactor resource_string()
Date:   Sat,  4 Jun 2022 15:30:24 -0400
Message-Id: <20220604193042.1674951-16-kent.overstreet@gmail.com>
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

Two changes:
 - We're attempting to consolidate printf_spec and format string
   handling in the top level vpr_buf(), this changes resource_string to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 51 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 863040fdaa..4256b1d3a5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1057,7 +1057,7 @@ static const struct printf_spec default_dec_spec = {
 
 static noinline_for_stack
 void resource_string(struct printbuf *out, struct resource *res,
-		     struct printf_spec spec, const char *fmt)
+		     int decode)
 {
 #ifndef IO_RSRC_PRINTK_SIZE
 #define IO_RSRC_PRINTK_SIZE	6
@@ -1096,62 +1096,58 @@ void resource_string(struct printbuf *out, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym_buf[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
-	struct printbuf sym = PRINTBUF_EXTERN(sym_buf, sizeof(sym_buf));
-	int decode = (fmt[0] == 'R') ? 1 : 0;
 	const struct printf_spec *specp;
 
-	if (check_pointer_spec(out, res, spec))
+	if (check_pointer(out, res))
 		return;
 
-	prt_char(&sym, '[');
+	prt_char(out, '[');
 	if (res->flags & IORESOURCE_IO) {
-		string_nocheck(&sym, "io  ", str_spec);
+		string_nocheck(out, "io  ", str_spec);
 		specp = &io_spec;
 	} else if (res->flags & IORESOURCE_MEM) {
-		string_nocheck(&sym, "mem ", str_spec);
+		string_nocheck(out, "mem ", str_spec);
 		specp = &mem_spec;
 	} else if (res->flags & IORESOURCE_IRQ) {
-		string_nocheck(&sym, "irq ", str_spec);
+		string_nocheck(out, "irq ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_DMA) {
-		string_nocheck(&sym, "dma ", str_spec);
+		string_nocheck(out, "dma ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_BUS) {
-		string_nocheck(&sym, "bus ", str_spec);
+		string_nocheck(out, "bus ", str_spec);
 		specp = &bus_spec;
 	} else {
-		string_nocheck(&sym, "??? ", str_spec);
+		string_nocheck(out, "??? ", str_spec);
 		specp = &mem_spec;
 		decode = 0;
 	}
 	if (decode && res->flags & IORESOURCE_UNSET) {
-		string_nocheck(&sym, "size ", str_spec);
-		number(&sym, resource_size(res), *specp);
+		string_nocheck(out, "size ", str_spec);
+		number(out, resource_size(res), *specp);
 	} else {
-		number(&sym, res->start, *specp);
+		number(out, res->start, *specp);
 		if (res->start != res->end) {
-			prt_char(&sym, '-');
-			number(&sym, res->end, *specp);
+			prt_char(out, '-');
+			number(out, res->end, *specp);
 		}
 	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
-			string_nocheck(&sym, " 64bit", str_spec);
+			string_nocheck(out, " 64bit", str_spec);
 		if (res->flags & IORESOURCE_PREFETCH)
-			string_nocheck(&sym, " pref", str_spec);
+			string_nocheck(out, " pref", str_spec);
 		if (res->flags & IORESOURCE_WINDOW)
-			string_nocheck(&sym, " window", str_spec);
+			string_nocheck(out, " window", str_spec);
 		if (res->flags & IORESOURCE_DISABLED)
-			string_nocheck(&sym, " disabled", str_spec);
+			string_nocheck(out, " disabled", str_spec);
 	} else {
-		string_nocheck(&sym, " flags ", str_spec);
-		number(&sym, res->flags, default_flag_spec);
+		string_nocheck(out, " flags ", str_spec);
+		number(out, res->flags, default_flag_spec);
 	}
-	prt_char(&sym, ']');
+	prt_char(out, ']');
 
-	string_nocheck(out, sym_buf, spec);
+	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
@@ -2326,7 +2322,8 @@ void pointer(struct printbuf *out, const char *fmt,
 		return do_width_precision(out, prev_pos, spec);
 	case 'R':
 	case 'r':
-		return resource_string(out, ptr, spec, fmt);
+		resource_string(out, ptr, fmt[0] == 'R');
+		return do_width_precision(out, prev_pos, spec);
 	case 'h':
 		return hex_string(out, ptr, spec, fmt);
 	case 'b':
-- 
2.36.0

