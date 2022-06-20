Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A040550E09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiFTAoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiFTAn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25062656A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 89so14069525qvc.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rD78V5jn1N8Qdh8WX66Tgx5067gCW12nmDhtWQN/Hb4=;
        b=PEHIi110xCak8AXVWGSSap54Pb3USEO9D47CylrpBEx4MJ3ouTQwqPgT4GZ9rVlhyB
         SnTRPhdrnXptGBWT1LHKZwuf13+w6RjNidTCElH8Ll7be4wSPEz4Q7qPFqVtyaM3iXXB
         RavwfM25FtdagApCSwiOkPh510cx1/eNb/Uj3cIg7zudX2l2BOxIkuy8Do6PbgPQyl8B
         SQk6KMTD316/9v7azqlhz/9mosPw+vcMplfWWWfHYjviLJDMN3pbml1uhRgjULpzLaQN
         NbO5+f/zzkzL7xhb82vHwNj2pAXwCY2vPRDXQwAduqdvb9bj/93NYmeFfSOFtGbY0Lu4
         22qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rD78V5jn1N8Qdh8WX66Tgx5067gCW12nmDhtWQN/Hb4=;
        b=YQWcHE3NCueAYbePQVXAg2BnMLJM2nMgIRsmb5Je0vmnmpa4gAabcJL/qmjto4wkhP
         T6wdStHCCVa9/s6h9KkA/tQfdcKwd10owEBsdv4fXrFym98qYzXzxKgBy47t4qbbWCQo
         xrd3JbmlIgSvv8LvbjGd6NVXaA7I4PJssgaIZbCA1zv91C30YbEey996dHTN7OddAXTF
         Hf6aTH1e+klGvNabtS0qgq+d31f/xemANl6N8AEYgJlHIDsSC+sgN0QXoz82e8he0rkd
         fNfwaqCsLL29XFclkGl2pq5G1ufkCqVtjkxb85XWML5k9gtLIpzJKT0oN+sSEs06NWzi
         DYLQ==
X-Gm-Message-State: AJIora+eG3Xps7pQRkTBpLS75qnjUmj0fT2Pd6jLCcjWhdvAATUOM96y
        6DEshZ2Kbj20fnxEIU1FwlOH4/iT2qtOqB8=
X-Google-Smtp-Source: AGRyM1ukasHrNUoaju59Y3ImRLnZitdczZF1RrTQDLGOqeCLU/+h7uKC/COyy1yeyTenIYYSYX31Fg==
X-Received: by 2002:a05:622a:11d4:b0:305:222d:8469 with SMTP id n20-20020a05622a11d400b00305222d8469mr17545019qtk.324.1655685791162;
        Sun, 19 Jun 2022 17:43:11 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a240e00b006a6b6638a59sm11167409qkn.53.2022.06.19.17.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:10 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 16/34] vsprintf: Refactor fourcc_string()
Date:   Sun, 19 Jun 2022 20:42:15 -0400
Message-Id: <20220620004233.3805-17-kent.overstreet@gmail.com>
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
index 5e96ab24f5..55a42ae055 100644
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
2.36.1

