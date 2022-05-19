Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5527752DB35
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiESR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242634AbiESRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD595A5013;
        Thu, 19 May 2022 10:25:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n10so5900134pjh.5;
        Thu, 19 May 2022 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=io/JXzBTUQk4XZSNyvTx+ccbiuHm3ThRzq8pqtgnkls=;
        b=n7JngmyoE82ipNzOKgXY2Db70Xg2ETtdjgIKTaLPnJnUZj7RqY/32C7MLh65YJW9vB
         iz/naU/m40oekxL1UG80eUUDObsReWUYEFWvNMSHQ31i0paJKyLGSyz+XiPJFBPYPP+o
         PAhw7CNPHhNzdPRJzLrxKAKuRJXN04zbdh0K+BzSg/CdxwHGRQwx+U/29eTVayAGeNfT
         ugZDNRanE4OevAqP2+pzE4KsQ1xJ5TUG1cUDhGG8FDKkQU18hkId3W7kw5IPLdJzwlDE
         h9AcGbbHjXqrdeyBmHeeiWYxfML7UjV0kv8D9PXo+sKJJBAjzvmcE3zcbpbJOBmgulFg
         E9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=io/JXzBTUQk4XZSNyvTx+ccbiuHm3ThRzq8pqtgnkls=;
        b=qcQcSGPi1vk+lHPL5UrXKdN9ZAmpiEEb6ShyRQiapjWorhuWj+26Ig6vHrxuBO8LT+
         suXfjmkufnRajk9zM2x5FAa+K4eBhC6wwwqp9G9XhEjZbaQoAMDjbE4AnEJDL/A9EGCD
         JrJPR5lzU2+000ANsgFVd+2+d56D4L0aP2Q/gc2LwGG761JiZfGP0fFhmm8zX/958l6y
         3SyZAErIsc2ljpMHLUCY+F1N2twsbo3ciY2jrw6poFSW0MDnsgqQEaSiVUb+xPOiRjcP
         9tDAvPp7Esvj9iQ9u9X7YUMvBStiBRjKxbndCpxl16Vfmi7gpPSGp/LQF1XUIBgwSqN7
         LMOA==
X-Gm-Message-State: AOAM532pAdRUycocNmWe++qXePssXTEBV+Dh25mZQPZx5FnnzXNZnFst
        LBRbtSYW6Zfg1gCKNSXS5Nr8JfjEOtzk
X-Google-Smtp-Source: ABdhPJycqfU8mbGxYoOraR7qmIBu84SScDm9vM7ADw0HK604nHc/1qmJ1gzvNgAv2oi8BonybDwaMw==
X-Received: by 2002:a17:90b:3506:b0:1df:d8b8:6eb3 with SMTP id ls6-20020a17090b350600b001dfd8b86eb3mr4246254pjb.104.1652981113811;
        Thu, 19 May 2022 10:25:13 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:13 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 17/28] vsprintf: Refactor mac_address_string()
Date:   Thu, 19 May 2022 13:24:10 -0400
Message-Id: <20220519172421.162394-18-kent.overstreet@gmail.com>
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

 - We're attempting to consolidate printf_spec and format string
   handling in the top level vpr_buf(), this changes mac_address_string() to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 62a221522c..76947e0d30 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1233,15 +1233,13 @@ void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
 
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
@@ -1260,16 +1258,13 @@ void mac_address_string(struct printbuf *out, u8 *addr,
 
 	for (i = 0; i < 6; i++) {
 		if (reversed)
-			p = hex_byte_pack(p, addr[5 - i]);
+			pr_hex_byte(out, addr[5 - i]);
 		else
-			p = hex_byte_pack(p, addr[i]);
+			pr_hex_byte(out, addr[i]);
 
 		if (fmt[0] == 'M' && i != 5)
-			*p++ = separator;
+			pr_char(out, separator);
 	}
-	*p = '\0';
-
-	string_nocheck(out, mac_addr, spec);
 }
 
 static noinline_for_stack
@@ -2270,7 +2265,8 @@ void pointer(struct printbuf *out, const char *fmt,
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

