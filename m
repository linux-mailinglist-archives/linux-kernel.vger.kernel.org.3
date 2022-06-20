Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E14550E17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiFTAn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiFTAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADFEB7D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:01 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c144so6864144qkg.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=87vr5hheCjxa+C+zJDx+UhCXUzg+Bvxner7x63Be5z0=;
        b=ocbtVxqlFRKBq2hJSLkb1jSAZI+z+3QG9/JSVg+4RFJ1C/ow58U8dZhOK82LCCUPOB
         3HRqKTj9Vp+ypkb2xtG+NnDyZobOOfEob5du36/KgfSpRRen4GXLuTwz7CXEUpsCaCrA
         +L5PUA1xlnrN0JSOja7JY9f+NodUqwMC92vxSt0iM9vHyNyEzklb13A3yLvzlmrcjC/k
         yFACZSug+zUrJkcC+DiHt70wi+qd6LAArh2Zp4szCWvuqY92HgZqwFeQjeT5rcl99DMp
         ml+k7YYcbgaj5BXOB3em38kBqjfsUY3OzwQ5+dsgnScr1TBqSN+Un3SRuBO3CY3ws5wt
         k3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87vr5hheCjxa+C+zJDx+UhCXUzg+Bvxner7x63Be5z0=;
        b=yi3R5sO9WZARY1Tec2QDZjLrv4WNy6EmiaN2+Q7e4S+moG0Rrx3+wNlV9D/AMibkRh
         6sHLrxgyfqSelY6aQKgUEkyBky7hgzuCZbjK+rWfknRJP3DbCYGpRXEtnKTgtcU86fYG
         Ly52WqS4fO+jXQFcJGczT9ErT7F56LPxexMUXVe4olnWMziPQSzYoiE7zYV3sBMWpugk
         WJaX5rAxlo/KFXdesolCzEk9vllvInqxDRsXDN516MQHeKYhhW6khZwukEzST7T+AwIV
         OiIbCugVsmZ1A7Uo0k1EQ8kJuJABpR1h4QquZJ7qGEMrnKEf//VqlxBNqwUcXjTCfSXD
         13OQ==
X-Gm-Message-State: AJIora8thd86yyqU4DR/leezdBurucX3RgrstSbYPT0+o7kD7C8E7Q4U
        DjHG+TYqpp70eKTvJW7vTevL1Mp95Fy7gW8=
X-Google-Smtp-Source: AGRyM1vHltOnT6lZQxwYcHcDmIe/iCQZuLx8M068VFsShpd1IhADyohd3Ftmhz+guiDL0E8AM8B5gQ==
X-Received: by 2002:a37:ad09:0:b0:6a6:ae2b:9d54 with SMTP id f9-20020a37ad09000000b006a6ae2b9d54mr14777059qkm.424.1655685780208;
        Sun, 19 Jun 2022 17:43:00 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id y26-20020ac87c9a000000b00304ecf35b50sm9055654qtv.97.2022.06.19.17.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:59 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 12/34] vsprintf: prt_u64_minwidth(), prt_u64()
Date:   Sun, 19 Jun 2022 20:42:11 -0400
Message-Id: <20220620004233.3805-13-kent.overstreet@gmail.com>
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

This adds two new-style printbuf helpers for printing simple u64s, and
converts num_to_str() to be a simple wrapper around prt_u64_minwidth().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/kernel.h |  4 +-
 lib/vsprintf.c         | 94 ++++++++++++++++++++----------------------
 2 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1906861ece..9ba5a53c6a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -202,12 +202,14 @@ static inline void might_fault(void) { }
 
 void do_exit(long error_code) __noreturn;
 
+struct printbuf;
+extern void prt_u64_minwidth(struct printbuf *out, u64 num, unsigned width);
+extern void prt_u64(struct printbuf *out, u64 num);
 extern int num_to_str(char *buf, int size,
 		      unsigned long long num, unsigned int width);
 
 /* lib/printf utilities */
 
-struct printbuf;
 extern __printf(2, 3) void prt_printf(struct printbuf *out, const char *fmt, ...);
 extern __printf(2, 0) void prt_vprintf(struct printbuf *out, const char *fmt, va_list);
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7d20406deb..e65115f90f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -368,41 +368,51 @@ char *put_dec(char *buf, unsigned long long n)
 
 #endif
 
-/*
- * Convert passed number to decimal string.
- * Returns the length of string.  On buffer overflow, returns 0.
- *
- * If speed is not important, use snprintf(). It's easy to read the code.
+/**
+ * prt_u64_minwidth - print a u64, in decimal, with zero padding
+ * @out: printbuf to output to
+ * @num: u64 to print
+ * @width: minimum width
  */
-int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
+void prt_u64_minwidth(struct printbuf *out, u64 num, unsigned width)
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
+		__prt_chars_reserved(out, '0', width - len);
 
-	if (width > len) {
-		width = width - len;
-		for (idx = 0; idx < width; idx++)
-			buf[idx] = ' ';
-	} else {
-		width = 0;
-	}
+	while (len)
+		__prt_char_reserved(out, tmp[--len]);
+	printbuf_nul_terminate(out);
+}
 
-	for (idx = 0; idx < len; ++idx)
-		buf[idx + width] = tmp[len - idx - 1];
+/**
+ * prt_u64 - print a simple u64, in decimal
+ * @out: printbuf to output to
+ * @num: u64 to print
+ */
+void prt_u64(struct printbuf *out, u64 num)
+{
+	prt_u64_minwidth(out, num, 0);
+}
 
-	return len + width;
+/*
+ * Convert passed number to decimal string.
+ * Returns the length of string.  On buffer overflow, returns 0.
+ *
+ * Consider switching to printbufs and using prt_u64() or prt_u64_minwith()
+ * instead.
+ */
+int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
+{
+	struct printbuf out = PRINTBUF_EXTERN(buf, size);
+
+	prt_u64_minwidth(&out, num, width);
+	return out.pos;
 }
 
 #define SIGN	1		/* unsigned/signed, must be 1 */
@@ -1018,20 +1028,6 @@ static const struct printf_spec default_dec_spec = {
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
@@ -1231,12 +1227,12 @@ void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
 			prt_char(out, ',');
 		first = false;
 
-		number(out, rbot, default_dec_spec);
+		prt_u64(out, rbot);
 		if (rtop == rbot + 1)
 			continue;
 
 		prt_char(out, '-');
-		number(out, rtop - 1, default_dec_spec);
+		prt_u64(out, rtop - 1);
 	}
 }
 
@@ -1778,21 +1774,21 @@ void date_str(struct printbuf *out,
 	int year = tm->tm_year + (r ? 0 : 1900);
 	int mon = tm->tm_mon + (r ? 0 : 1);
 
-	number(out, year, default_dec04_spec);
+	prt_u64_minwidth(out, year, 4);
 	prt_char(out, '-');
-	number(out, mon, default_dec02_spec);
+	prt_u64_minwidth(out, mon, 2);
 	prt_char(out, '-');
-	number(out, tm->tm_mday, default_dec02_spec);
+	prt_u64_minwidth(out, tm->tm_mday, 2);
 }
 
 static noinline_for_stack
 void time_str(struct printbuf *out, const struct rtc_time *tm, bool r)
 {
-	number(out, tm->tm_hour, default_dec02_spec);
+	prt_u64_minwidth(out, tm->tm_hour, 2);
 	prt_char(out, ':');
-	number(out, tm->tm_min, default_dec02_spec);
+	prt_u64_minwidth(out, tm->tm_min, 2);
 	prt_char(out, ':');
-	number(out, tm->tm_sec, default_dec02_spec);
+	prt_u64_minwidth(out, tm->tm_sec, 2);
 }
 
 static noinline_for_stack
@@ -2070,7 +2066,7 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 			str_spec.precision = precision;
 			break;
 		case 'p':	/* phandle */
-			number(out, (unsigned int)dn->phandle, default_dec_spec);
+			prt_u64(out, (unsigned int)dn->phandle);
 			break;
 		case 'P':	/* path-spec */
 			p = fwnode_get_name(of_fwnode_handle(dn));
-- 
2.36.1

