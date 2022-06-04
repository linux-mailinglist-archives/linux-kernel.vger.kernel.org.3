Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB653D85E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbiFDTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbiFDTbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:40 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55BA4FC76
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bi27so1809717qkb.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+OO0U/O9fCdUkK5Q7sI7mM5Cd+STQfapJZCjl15B/w=;
        b=qP08oHvi8nY3OUezgt2nZswPfX/oSDDYzDCqAxorOV06IrbszeIsXCBHQYsQrd9gJb
         5jjU6gs/2cuWjG1jZp0jQrauPRAkSpy0cXGHsYQULiYDl6jJ7xh/e811mp7p2A93Ymnq
         /liRAJ/Su6PV8EHJI+ehuyf8jdIJ8KcdjssPNMF3rwjPINrhMSbdDjYaylJiAAnNB8rZ
         cjtEmsVyOphGap4yrt+vivGXoMGa/ifW6eldZWyZi4YuKy0V4a7w3BRcN6UiRNvMHuYu
         nmwa8Har8dNEuUwrmJEZmhbXBC/NOA43ysFqxZsAkIJYTYcoEX1l2FHGpBanuul5zhzd
         M4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+OO0U/O9fCdUkK5Q7sI7mM5Cd+STQfapJZCjl15B/w=;
        b=xeu5YYBaTBHRh42FXEDNMHokHRXZtaKogqHh4J24E4e4IChItlGKIi4ew+ot2Ip+E/
         uLZfUvgvgAQx9JlccJgmJmX6yZc+AFVDI/kvzpsxZShj4Dj3jeN8naNk93Ppd7iu15BG
         UBHS25x/l5qOZuOpp7/2zhAiawl6Ip9eqhRW1RdfgYui2rhF0iy7tBcTLM9xVM3UWQ+5
         RaIz64Eiv0omYNg7ARSjMnShzUUaIk9thzAcNl4jLJXzKZQ4c0BO/GcV0DAzg9MA/nHx
         8HpUBUqhV653oAzl8VruqH+/YCc1cp3F5ahyZftx30+1hAaj3NJGosZagiWDblOMTOdx
         Fnyg==
X-Gm-Message-State: AOAM531AJOze7TAxT4LrLqBO4AnEEptodALVHEbdX2nuNDfgl0CVcl3d
        Giu/vyg1OYT4C91o7FjB5cfEqmmFRlcn
X-Google-Smtp-Source: ABdhPJzWGfZd5UH/WSl1tsC8XiPB079oUZ1fpabgZPLuWwqzaQ9DEsHbsdCKV/pCtuAm2TkpAys2Fw==
X-Received: by 2002:a37:9d45:0:b0:6a6:8b04:e7fd with SMTP id g66-20020a379d45000000b006a68b04e7fdmr8821614qke.37.1654371076801;
        Sat, 04 Jun 2022 12:31:16 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:16 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 18/33] vsprintf: Refactor mac_address_string()
Date:   Sat,  4 Jun 2022 15:30:27 -0400
Message-Id: <20220604193042.1674951-19-kent.overstreet@gmail.com>
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
   handling in the top level ptr_vprintf(), this changes
mac_address_string() to not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 964e00b6a2..6020f55fc0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1261,15 +1261,13 @@ void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
 
 static noinline_for_stack
 void mac_address_string(struct printbuf *out, u8 *addr,
-			struct printf_spec spec, const char *fmt)
+			const char *fmt)
 {
-	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
-	char *p = mac_addr;
 	int i;
 	char separator;
 	bool reversed = false;
 
-	if (check_pointer_spec(out, addr, spec))
+	if (check_pointer(out, addr))
 		return;
 
 	switch (fmt[1]) {
@@ -1288,16 +1286,13 @@ void mac_address_string(struct printbuf *out, u8 *addr,
 
 	for (i = 0; i < 6; i++) {
 		if (reversed)
-			p = hex_byte_pack(p, addr[5 - i]);
+			prt_hex_byte(out, addr[5 - i]);
 		else
-			p = hex_byte_pack(p, addr[i]);
+			prt_hex_byte(out, addr[i]);
 
 		if (fmt[0] == 'M' && i != 5)
-			*p++ = separator;
+			prt_char(out, separator);
 	}
-	*p = '\0';
-
-	string_nocheck(out, mac_addr, spec);
 }
 
 static noinline_for_stack
@@ -2292,7 +2287,8 @@ void pointer(struct printbuf *out, const char *fmt,
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
 					/* [mM]R (Reverse order; Bluetooth) */
-		return mac_address_string(out, ptr, spec, fmt);
+		mac_address_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'I':			/* Formatted IP supported
 					 * 4:	1.2.3.4
 					 * 6:	0001:0203:...:0708
-- 
2.36.0

