Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB2C550E16
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbiFTAoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiFTAn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:26 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC19EBB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:09 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id t16so9021471qvh.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCq6AKFAlUXGqF4DA0HsDCSO8h2xYDtnNCe5ZdhSdK4=;
        b=Oe5cJFCnVbXEmZUpE7rqgrX5IjJnEG7SbQFZ95e/WKbGj1Hl2J7mTiwwDWsyD6Z3YS
         /a/iW28zNI9mTxABs6ipe4wRhdybAdBIcl4ZM4Wg/CYV3PGvElUmDIPPmg0IUZMSOixi
         zvfjYtdqjzx+H+inYmA3agMXfKKOgSGja8sRQO+i+mXan3sQJza85N4S5a5u9QmNpv25
         KeJtv0wR/K+QCTorLCHhZCESxOluSs0Hk21DZbqOSMEvCyr5fz2IuXUpRIOn4k2Ol25r
         grRxL+L0ufPcKnYfY8ch9ncR5CDqJbnR/z1vhd68AwnhmBbssvIvYXSenZLuA2HxKfZc
         L5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCq6AKFAlUXGqF4DA0HsDCSO8h2xYDtnNCe5ZdhSdK4=;
        b=dtcrOz9cyJ+ZkiNzJkBUX0AZ0Adk84/dW4jS6JDcEMojfaGVYg8g7lacLTv8U8kxzi
         Jsq4dH8pO1RXg2oMk4ruC0HzviYNlV9NRKFUZOwu2Bh6+WFkpVZKMLEQu1NQdeP9x/3W
         SXVgBmA/iPn+aaIcBJ4phy3u+J7uqQi+tzJqDjTUA92Y4WheYgiXRT/lfc5IDocDMMwZ
         qi5uBhk6oeJC2f3INiXDuOfa/jeplgG89uUWFFSDYXa08zJNRfMoCKzQI7kpvA/C9KJl
         +g8mcbRdjPydGOsKbZzoR5lZgPN/9rc0MC0LnYykcphsakXPzjVGJljRNzYztAwZGQjl
         /rbQ==
X-Gm-Message-State: AJIora9R3O6Amhee3ZKbh8iuwePfA4GLS7xSLHhRP+TvmUg86D9fF6ri
        W3Hy6ZZt+72zjrY6SDWADjeVh1MtWuVRgnk=
X-Google-Smtp-Source: AGRyM1sMsY6x0wzYYG8F8zSOj+RzNa5QMB0waNv1G3LpplIDOxZ1RPdMTxyR3MGURfWs8xYml8DWAQ==
X-Received: by 2002:ad4:584c:0:b0:464:5904:998d with SMTP id de12-20020ad4584c000000b004645904998dmr16937211qvb.33.1655685788313;
        Sun, 19 Jun 2022 17:43:08 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id d8-20020a05620a240800b006a6b564e9b8sm11073547qkn.4.2022.06.19.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:07 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 15/34] vsprintf: Refactor resource_string()
Date:   Sun, 19 Jun 2022 20:42:14 -0400
Message-Id: <20220620004233.3805-16-kent.overstreet@gmail.com>
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
index feaca085cd..5e96ab24f5 100644
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
2.36.1

