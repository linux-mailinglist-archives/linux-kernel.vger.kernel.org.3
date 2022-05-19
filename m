Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F237552DB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiESR0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242640AbiESRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EACAEE07;
        Thu, 19 May 2022 10:25:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so6418786pjb.1;
        Thu, 19 May 2022 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYDmKGQ68/tcSrl96epbwKIv/5DWUEdmV+ljYHPziEQ=;
        b=Wp2efo+C3K4Ivu4rvZOFIJAHwQ1ryFWKaVFECGdFWYf87IEmUdHKWbf39P0c8fjElA
         m2yhaUhZSkZYA8QBoNRgLuBFeyNoxNx7hAqOpTF8naCZgfSkltJUNtVQPwImHyLGcOJi
         N79mOU+o9K0PoHhwtD9Fe6ei10ET+UKlwvluDjUohaEIP+Yfgsl9gPiw/j1LWL71Mck3
         tFIw0Ao3/ApVsYMepzbAJdcH5E4lvLlPivsBpMbNGrIRY48dwZFfdeXce0Q5comOVhM7
         CCpvTcsqpsv/gA2iaEkNGWYJbFQjqfyuFJ8qoBUP82VrPYvkvNccFnLpO1T1P2xPHQMl
         iTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYDmKGQ68/tcSrl96epbwKIv/5DWUEdmV+ljYHPziEQ=;
        b=wZB/YBbxc69xsy4f/NivuDS7aiIJ8Y0tDjpmN80KKZ+7uIYa9QLmc5NlN0BfhyV22D
         +LtCwQauJx2qgDkWlChk6IqKQoxTl3GO8lyEFDLvZABCQvw4tbb1JDnxi+DQFLdTeRWR
         7bMXoDuEam7x1k3tSsxubAiKK4wg2jqiNUTfgYWOyhVUbuOPRMGuqAHn7GsHoo7/9AqR
         l8RoaxVTO63+DQQEvmC/bMOzpSyn3YzllkuR+kD5RFlzVLVNPnfzi8L2m2at1owYZ8Fi
         aswPKXCe22pZbMPVwlhAO60uRaYSHYtRt4ZWTk09/LTUxexCNRkCubxThJg93TASlb1A
         rJSA==
X-Gm-Message-State: AOAM533NsdrB6Sl//EVU2+Kq5WmNUmSfOJAO+Z09DlOzQj3JG2NNM5By
        b/jj3l5m3puaPyoiGIoNf9eY9sZpoNgS
X-Google-Smtp-Source: ABdhPJwV/SeCuBwi09/4GacP5ySX3VYfZpArZWbWdS9Qs6GE+kBNtfBoB95oICb/LCleM8twL0QxRQ==
X-Received: by 2002:a17:90a:f81:b0:1df:91b5:f0e3 with SMTP id 1-20020a17090a0f8100b001df91b5f0e3mr6809170pjz.227.1652981100183;
        Thu, 19 May 2022 10:25:00 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:59 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 11/28] vsprintf: Lift pr_hex_bytes() out from hex_string()
Date:   Thu, 19 May 2022 13:24:04 -0400
Message-Id: <20220519172421.162394-12-kent.overstreet@gmail.com>
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

This factors pr_hex_bytes(), a new printbuf-style helper, out from
hex_string and adds it to pretty-printers.c.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/pretty-printers.h |  1 +
 lib/pretty-printers.c           | 23 +++++++++++++++++++++++
 lib/vsprintf.c                  | 13 ++++---------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/linux/pretty-printers.h b/include/linux/pretty-printers.h
index 2e8b6b4426..ded34622e8 100644
--- a/include/linux/pretty-printers.h
+++ b/include/linux/pretty-printers.h
@@ -4,6 +4,7 @@
 #ifndef _LINUX_PRETTY_PRINTERS_H
 #define _LINUX_PRETTY_PRINTERS_H
 
+void pr_hex_bytes(struct printbuf *, const u8 *, unsigned, unsigned);
 void pr_string_option(struct printbuf *, const char * const[], size_t);
 void pr_bitflags(struct printbuf *, const char * const[], u64);
 
diff --git a/lib/pretty-printers.c b/lib/pretty-printers.c
index d794648ef9..162e6865f9 100644
--- a/lib/pretty-printers.c
+++ b/lib/pretty-printers.c
@@ -4,6 +4,29 @@
 #include <linux/kernel.h>
 #include <linux/printbuf.h>
 
+/**
+ * pr_hex_bytes - Print a string of hex bytes, with optional separator
+ *
+ * @out: The printbuf to output to
+ * @addr: Buffer to print
+ * @nr: Number of bytes to print
+ * @separator: Optional separator character between each byte
+ */
+void pr_hex_bytes(struct printbuf *out, const u8 *addr,
+		  unsigned nr, unsigned separator)
+{
+	unsigned i;
+
+	for (i = 0; i < nr; ++i) {
+		if (separator && i)
+			pr_char(out, separator);
+		pr_hex_byte(out, addr[i]);
+	}
+
+	printbuf_nul_terminate(out);
+}
+EXPORT_SYMBOL(pr_hex_bytes);
+
 /**
  * pr_string_option - Given a list of strings, print out the list and indicate
  * which option is selected, with square brackets (sysfs style)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3f5638d27a..d4293b4a40 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -52,6 +52,7 @@
 #include <asm/byteorder.h>	/* cpu_to_le16 */
 
 #include <linux/string_helpers.h>
+#include <linux/pretty-printers.h>
 #include "kstrtox.h"
 
 static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
@@ -1107,10 +1108,10 @@ void resource_string(struct printbuf *out, struct resource *res,
 }
 
 static noinline_for_stack
-void hex_string(struct printbuf *out, u8 *addr,
+void hex_string(struct printbuf *out, const u8 *addr,
 		struct printf_spec spec, const char *fmt)
 {
-	int i, len = 1;		/* if we pass '%ph[CDN]', field width remains
+	int len = 1;		/* if we pass '%ph[CDN]', field width remains
 				   negative value, fallback to the default */
 	char separator;
 
@@ -1139,13 +1140,7 @@ void hex_string(struct printbuf *out, u8 *addr,
 	if (spec.field_width > 0)
 		len = min_t(int, spec.field_width, 64);
 
-	for (i = 0; i < len; ++i) {
-		__pr_char(out, hex_asc_hi(addr[i]));
-		__pr_char(out, hex_asc_lo(addr[i]));
-
-		if (separator && i != len - 1)
-			__pr_char(out, separator);
-	}
+	pr_hex_bytes(out, addr, len, separator);
 }
 
 static noinline_for_stack
-- 
2.36.0

