Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F852DB30
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbiESR0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiESRZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B6A7761;
        Thu, 19 May 2022 10:25:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so5721580pfb.4;
        Thu, 19 May 2022 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWycBowt0MidQ3WMMJDlkVMAwAS6HurrbLWqpcpIeew=;
        b=ieIBkesiUG3WbVarQoJ3CVBrLVFF2ZgD6sCot+rKZuv+OcNpsC6ETR0Lkb6mMVWyVL
         pHLD93Z/XR1VmVtIRlTMCg1ijeR+uhfcUWxaklIlWX103icxzWuStv2Ru6+Hyw9XcJWr
         z4lvta76RkjqqL2GH/buE+jfWpq4r6vydBeEBiRHdH5qAQMYLv6YC2eql7OigwD/M7Ha
         B4Ozc9QQCbc/UZ7WItYHxX+sItsW83QLixIgJudfBGAfRrm/n1QRgEP3/PrtNqsXCLoY
         4GDaSKBec+mMr3bT3abk8YT+01q+0bTKb3wZvNck7rInlkdLEdTpArcz+fLfcnCL/BgO
         1f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWycBowt0MidQ3WMMJDlkVMAwAS6HurrbLWqpcpIeew=;
        b=ODlNt0+AuU2Iqrqzs3cGflmjJ0MwOVKaKDDyAeVelvih9SXtciqA7bgW86fZoj7/uU
         8xWep8S1dM/gBmjuOWumP1zwMVjSQ7yo0QncDnLFzdHYDu+47cAe1v7osnRaruqfbxlP
         pUcnDxbknkScl8GZRtHE/stUweJOYRUtifFLNhPP2+l45mCPY+yVgUnKrZtVMfRr9PTE
         QUSTuozX5c2BlJzuycn45ORM+sHzZagcF1CJ+tQHo4wcUXmQ9zjHtWaW4KXN9Pg9mGjr
         KposcQUqY8oAD0nb2oaKbhl5vda+6iUkyujXGMsbcaeGQRGaOd4ozVYJy7hWTJyYhfXY
         75VA==
X-Gm-Message-State: AOAM533r+01UhC6g3mhZrwDzhWiwpdAZS6bTZYQoTSaee3ScRkd1MXB5
        ATzZpjvrdNI2d0n1QC7ZVctfaDigh8iq
X-Google-Smtp-Source: ABdhPJwTg7ITskD+TKuxgCGFKwkICgKnJY2ce2LXZmQUnJk+rxl5keXm7fNU8h11Mv7ipoMF9BHOYg==
X-Received: by 2002:a62:6dc3:0:b0:505:895a:d38b with SMTP id i186-20020a626dc3000000b00505895ad38bmr5888441pfc.7.1652981107652;
        Thu, 19 May 2022 10:25:07 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:06 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 14/28] vsprintf: Refactor resource_string()
Date:   Thu, 19 May 2022 13:24:07 -0400
Message-Id: <20220519172421.162394-15-kent.overstreet@gmail.com>
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

Two changes:
 - We're attempting to consolidate printf_spec and format string
   handling in the top level vpr_buf(), this changes resource_string to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 52 +++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6bbbb52bb0..dd4bbb28e7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1037,7 +1037,7 @@ static const struct printf_spec default_dec_spec = {
 
 static noinline_for_stack
 void resource_string(struct printbuf *out, struct resource *res,
-		     struct printf_spec spec, const char *fmt)
+		     int decode)
 {
 #ifndef IO_RSRC_PRINTK_SIZE
 #define IO_RSRC_PRINTK_SIZE	6
@@ -1076,63 +1076,58 @@ void resource_string(struct printbuf *out, struct resource *res,
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
 
-	__pr_char(&sym, '[');
+	__pr_char(out, '[');
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
-			__pr_char(&sym, '-');
-			number(&sym, res->end, *specp);
+			__pr_char(out, '-');
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
-	__pr_char(&sym, ']');
-	printbuf_nul_terminate(&sym);
+	__pr_char(out, ']');
 
-	string_nocheck(out, sym_buf, spec);
+	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
@@ -2306,7 +2301,8 @@ void pointer(struct printbuf *out, const char *fmt,
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

