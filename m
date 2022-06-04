Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5684A53D855
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbiFDTcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiFDTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA994FC58
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:15 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hf10so7949567qtb.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLK6+egkCovHKJVGrXsuX+1zu1r3Q9U94qYohBZ6ysU=;
        b=lR2Ebc++yXYk7EIAmHmJt5oC4YtNu+3h345iAEZWGUlsZFxZRZoDsC5rIPph3bs2+o
         ixOSAL+g8KhfZO90C8/7ng9xIALijDoK9MHNodU9XMK3/ktmBuGiStG0p3O82u4tfV3E
         72AP2xSAmTmYzX8eQ98wiFS1gR7hatJfEINh/LLG8cFywqfEwi18J0eNvCOUlivM+/aY
         rxePgeON72yT7caAuubDqu5LZM5f/cug0MvvAJViTHPCjQngeh+DAVbS0wyrtLO9zKqF
         OPyfy1Gn9CbpDEmG6T1HXmFvuKiK/52x/T5gONrChfRXs+U5Aq6HLbXJFz6nMtV8Rue8
         DO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLK6+egkCovHKJVGrXsuX+1zu1r3Q9U94qYohBZ6ysU=;
        b=T5HFdrGIUXsO5qd6dRCypBFnljHFY7U6qTu/Ui6n77IcjzIJWhfp7g8gTGHKCPWnau
         rG5sMQW7NgQ++rZHHWcyAsnLOYIj8M4lJISpHWFHp7l08OHe8AwUzVtCXS0Iw++Ckb//
         PxBONrX44sC+46TwYwqAMLTAaiAsBE2LvvoFplfFuN+UHTwRUf4bXfj2jFKVzMSqj2st
         ljBMQZ3Uy4le5uV5MSz3auCoaUo95iGv1w3+6MMhdFdvRA3GblgHWi++/5hKBttRyNQe
         QtmLVHiHydwwFOAFAc9JCqjkTL0yfgr3se+25cuPlOY7CXDrLUxT29iSWFNgNUM9voub
         bkWQ==
X-Gm-Message-State: AOAM533A+qs2aMgU0Off6x/eojs10Q5Id427P263yzXaGcKktgBTEElv
        Gzbw57g+f9EEKlEFRQ8G7xf3C1Zs8R7S
X-Google-Smtp-Source: ABdhPJwXUtbJlxmaOaBtF/AQ5yLrI1MHSSqCox5sjK8rNC+25X0is+ap4JMCAAqqXSlWabJ858cxaA==
X-Received: by 2002:ac8:5c8e:0:b0:303:1a91:e435 with SMTP id r14-20020ac85c8e000000b003031a91e435mr12749544qta.15.1654371073712;
        Sat, 04 Jun 2022 12:31:13 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:13 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 16/33] vsprintf: Refactor fourcc_string()
Date:   Sat,  4 Jun 2022 15:30:25 -0400
Message-Id: <20220604193042.1674951-17-kent.overstreet@gmail.com>
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
   handling in the top level vpr_buf(), this changes fourcc_string() to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 4256b1d3a5..49565e0dc4 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1726,17 +1726,15 @@ void netdev_bits(struct printbuf *out, const void *addr,
 
 static noinline_for_stack
 void fourcc_string(struct printbuf *out, const u32 *fourcc,
-		   struct printf_spec spec, const char *fmt)
+		   const char *fmt)
 {
-	char output_buf[sizeof("0123 little-endian (0x01234567)")];
-	struct printbuf output = PRINTBUF_EXTERN(output_buf, sizeof(output_buf));
 	unsigned int i;
 	u32 orig, val;
 
 	if (fmt[1] != 'c' || fmt[2] != 'c')
-		return error_string_spec(out, "(%p4?)", spec);
+		return error_string(out, "(%p4?)");
 
-	if (check_pointer_spec(out, fourcc, spec))
+	if (check_pointer(out, fourcc))
 		return;
 
 	orig = get_unaligned(fourcc);
@@ -1746,18 +1744,16 @@ void fourcc_string(struct printbuf *out, const u32 *fourcc,
 		unsigned char c = val >> (i * 8);
 
 		/* Print non-control ASCII characters as-is, dot otherwise */
-		prt_char(&output, isascii(c) && isprint(c) ? c : '.');
+		prt_char(out, isascii(c) && isprint(c) ? c : '.');
 	}
 
-	prt_char(&output, ' ');
-	prt_str(&output, orig & BIT(31) ? "big-endian" : "little-endian");
-
-	prt_char(&output, ' ');
-	prt_char(&output, '(');
-	special_hex_number(&output, orig, sizeof(u32));
-	prt_char(&output, ')');
+	prt_char(out, ' ');
+	prt_str(out, orig & BIT(31) ? "big-endian" : "little-endian");
 
-	string_spec(out, output_buf, spec);
+	prt_char(out, ' ');
+	prt_char(out, '(');
+	special_hex_number(out, orig, sizeof(u32));
+	prt_char(out, ')');
 }
 
 static noinline_for_stack
@@ -2361,7 +2357,8 @@ void pointer(struct printbuf *out, const char *fmt,
 		netdev_bits(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
 	case '4':
-		return fourcc_string(out, ptr, spec, fmt);
+		fourcc_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'a':
 		address_val(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
-- 
2.36.0

