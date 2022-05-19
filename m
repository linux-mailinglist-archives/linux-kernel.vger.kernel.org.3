Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9952DB26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiESRZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242607AbiESRY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038CA30A5;
        Thu, 19 May 2022 10:24:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id bh5so5376893plb.6;
        Thu, 19 May 2022 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3OxyC3/DI33JXHwVUL35gvyfpdRWxFslUVcm3O0EXs=;
        b=gIY+kSSVUC4Mo1TlPJ2EpffwqI+g7vs9uSicukEY6JHyWUdCZrcpOcFeFlHxlp/9CT
         O1dorvDVkiR3qdq+ZTIE0axAWgk3elhD5DnL1fdP7mQY05KF77ubjlrR2z0JouMqOw3k
         9S6Nkgstt4va5hpQ6rjkaxN6uefqKHXkHRyojR3uPmSoNz0OfO5j1bijGobBv1C7oKsR
         Bm7KgWf+cPb03mm6lQjxWHjabmxEyEwgdqmpCjPLIZgBP9NUbGqzjqdIcxVFiFlQC4xS
         QbKoK4pHfgoYpe/GsRl4Dwo5zwxyYmnxp1i63apv1e8r/U5Q4tblR+7VvBQij8KQhGIO
         xnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3OxyC3/DI33JXHwVUL35gvyfpdRWxFslUVcm3O0EXs=;
        b=S5JbkDsMCc+7Wf1Py1DXxgvyCMCFZcRJDrwDhqiR6xB6jtZ62nK524yCLqjFgOb2+4
         olUiVw8qAD7U/qLxDBo7oyuw8U2P5f0F0uAZoJGdL48s+v/imXheDAmUfdzME6UvsAut
         MuhqR+sgxFzRQ21AeFpup1vVGM5KyExGCmgd209n/JN/meO3usWYJaoL3K5ERMzvLa+y
         j5DD1muj9tMXOl6VUzBMsakaQylVKwptyC8PHlCLlgnPSKNIS4g1iFDsOAMwIzjZoX71
         o8pfDqwZnj4NF44rmtNB82QD+wdKgYIktNUb2ZlejHOSYWUTGZgZmpNn/p7/rbz7bOlH
         E2jQ==
X-Gm-Message-State: AOAM530QC8ZT8pAypUvVucPDFiNGVu9SLBpu2q5JEocbaB73OJpYmAuc
        i61vMIfmIaIb5ozsK2Z3yBkMpmiCrtCt
X-Google-Smtp-Source: ABdhPJysdaEJkG8ndxjZfsUp39aQC6MnGASv6eEov7HDfqLiNgQj3nda4/tl6+uPmbOCpJn3pJB3Jg==
X-Received: by 2002:a17:90b:1d87:b0:1dc:a9c0:3d49 with SMTP id pf7-20020a17090b1d8700b001dca9c03d49mr6875780pjb.12.1652981097648;
        Thu, 19 May 2022 10:24:57 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:56 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 10/28] vsprintf: pr_u64_minwidth(), pr_u64()
Date:   Thu, 19 May 2022 13:24:03 -0400
Message-Id: <20220519172421.162394-11-kent.overstreet@gmail.com>
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

This adds two new-style printbuf helpers for printing simple u64s, and
converts num_to_str() to be a simple wrapper around pr_u64_minwidth().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 100 ++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d1372c0b37..3f5638d27a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -363,41 +363,51 @@ char *put_dec(char *buf, unsigned long long n)
 
 #endif
 
-/*
- * Convert passed number to decimal string.
- * Returns the length of string.  On buffer overflow, returns 0.
- *
- * If speed is not important, use snprintf(). It's easy to read the code.
+/**
+ * pr_u64_minwidth - print a u64, in decimal, with zero padding
+ * @out: printbuf to output to
+ * @num: u64 to print
+ * @width: minimum width
  */
-int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
+void pr_u64_minwidth(struct printbuf *out, u64 num, unsigned width)
 {
 	/* put_dec requires 2-byte alignment of the buffer. */
 	char tmp[sizeof(num) * 3] __aligned(2);
-	int idx, len;
+	unsigned len = put_dec(tmp, num) - tmp;
 
-	/* put_dec() may work incorrectly for num = 0 (generate "", not "0") */
-	if (num <= 9) {
-		tmp[0] = '0' + num;
-		len = 1;
-	} else {
-		len = put_dec(tmp, num) - tmp;
-	}
+	printbuf_make_room(out, max(len, width));
 
-	if (len > size || width > size)
-		return 0;
+	if (width > len)
+		__pr_chars_reserved(out, '0', width - len);
 
-	if (width > len) {
-		width = width - len;
-		for (idx = 0; idx < width; idx++)
-			buf[idx] = ' ';
-	} else {
-		width = 0;
-	}
+	while (len)
+		__pr_char_reserved(out, tmp[--len]);
+	printbuf_nul_terminate(out);
+}
 
-	for (idx = 0; idx < len; ++idx)
-		buf[idx + width] = tmp[len - idx - 1];
+/**
+ * pr_u64 - print a simple u64, in decimal
+ * @out: printbuf to output to
+ * @num: u64 to print
+ */
+void pr_u64(struct printbuf *out, u64 num)
+{
+	pr_u64_minwidth(out, num, 0);
+}
 
-	return len + width;
+/*
+ * Convert passed number to decimal string.
+ * Returns the length of string.  On buffer overflow, returns 0.
+ *
+ * Consider switching to printbufs and using pr_u64() or pr_u64_minwith()
+ * instead.
+ */
+int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
+{
+	struct printbuf out = PRINTBUF_EXTERN(buf, size);
+
+	pr_u64_minwidth(&out, num, width);
+	return out.pos;
 }
 
 #define SIGN	1		/* unsigned/signed, must be 1 */
@@ -996,20 +1006,6 @@ static const struct printf_spec default_dec_spec = {
 	.precision = -1,
 };
 
-static const struct printf_spec default_dec02_spec = {
-	.base = 10,
-	.field_width = 2,
-	.precision = -1,
-	.flags = ZEROPAD,
-};
-
-static const struct printf_spec default_dec04_spec = {
-	.base = 10,
-	.field_width = 4,
-	.precision = -1,
-	.flags = ZEROPAD,
-};
-
 static noinline_for_stack
 void resource_string(struct printbuf *out, struct resource *res,
 		     struct printf_spec spec, const char *fmt)
@@ -1208,12 +1204,12 @@ void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
 			__pr_char(out, ',');
 		first = false;
 
-		number(out, rbot, default_dec_spec);
+		pr_u64(out, rbot);
 		if (rtop == rbot + 1)
 			continue;
 
-		__pr_char(out, '-');
-		number(out, rtop - 1, default_dec_spec);
+		pr_char(out, '-');
+		pr_u64(out, rtop - 1);
 	}
 }
 
@@ -1762,21 +1758,21 @@ void date_str(struct printbuf *out,
 	int year = tm->tm_year + (r ? 0 : 1900);
 	int mon = tm->tm_mon + (r ? 0 : 1);
 
-	number(out, year, default_dec04_spec);
-	__pr_char(out, '-');
-	number(out, mon, default_dec02_spec);
-	__pr_char(out, '-');
-	number(out, tm->tm_mday, default_dec02_spec);
+	pr_u64_minwidth(out, year, 4);
+	pr_char(out, '-');
+	pr_u64_minwidth(out, mon, 2);
+	pr_char(out, '-');
+	pr_u64_minwidth(out, tm->tm_mday, 2);
 }
 
 static noinline_for_stack
 void time_str(struct printbuf *out, const struct rtc_time *tm, bool r)
 {
-	number(out, tm->tm_hour, default_dec02_spec);
+	pr_u64_minwidth(out, tm->tm_hour, 2);
 	__pr_char(out, ':');
-	number(out, tm->tm_min, default_dec02_spec);
+	pr_u64_minwidth(out, tm->tm_min, 2);
 	__pr_char(out, ':');
-	number(out, tm->tm_sec, default_dec02_spec);
+	pr_u64_minwidth(out, tm->tm_sec, 2);
 }
 
 static noinline_for_stack
@@ -2054,7 +2050,7 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 			str_spec.precision = precision;
 			break;
 		case 'p':	/* phandle */
-			number(out, (unsigned int)dn->phandle, default_dec_spec);
+			pr_u64(out, (unsigned int)dn->phandle);
 			break;
 		case 'P':	/* path-spec */
 			p = fwnode_get_name(of_fwnode_handle(dn));
-- 
2.36.0

