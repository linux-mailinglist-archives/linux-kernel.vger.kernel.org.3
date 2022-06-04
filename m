Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4053D84F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbiFDTct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbiFDTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB54F9CA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:09 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x18so5087404qtj.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKaXBn5egCcerocp5DjNOYjWsbUcD3ATqXK/SNAzNqI=;
        b=jYiKdFziiTb9X35fFfeHmFR0xAABNykPuIQamDtmiR4aAQ1VskyW18ppAUeCYWf7Zz
         7Nll4jOA4jnmCDeQpGmUIjW1yCXER1xOHWQdjaI3HjyIfYU+OQaleXgee9nQLbUtzjqE
         teRoTFWr2Ewtl+VtaaFxGwFN69M9pOavqp53tyuPpRxua8wmCdWnJ5WBHnQGcCtn7jbT
         tL5C77Si7gAJRDgf0UyRaPDElzm7UR7DcA3n/84mvzGRsTGGctQsh+5+ntco3EX2pfRo
         NUNV5/+PNjviDjT5iqcbVZu5sSCqRjfSrAjsWm8702Kzf5P7UnNXoMRnpTsyYkroyxtO
         2Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKaXBn5egCcerocp5DjNOYjWsbUcD3ATqXK/SNAzNqI=;
        b=YYiFc8mxBh0wml4EmqcsLgMwIEnIJE88zz9Ui0DPChB687zi2TxTTtkc+nrEjOS45W
         VXTeIgfeFjvk8ofC05PRzK9KPkZ6quqtyHjGa93I7MZaROmPDW1O4C8nmZC/x7wsg1iN
         Ctd1f3nt376lyQJJE9MDszUxU+zU57okYa8PjyPHqF4CJZ7vdnGZsPMfNgKzSz+FWT58
         S13zMtreN6IMi4aJHL/g3RZk903oXufB1htun8PXBg5aHxNBhGeuEuLKbNBwMnhhJ9hC
         T0D6pZRx+u4iJxPnIqWLVqSPXlLkeQmROshNoGWZp93ljhtIHE3IvP/R6UOb5VDs+IR2
         1yQQ==
X-Gm-Message-State: AOAM531Bvbmut64oklu91Lgqc1o1ZYsEEncx+eyUvehfw7yButVeZwS+
        NH1Kofa802TIup6dBzdXR3kkgUbHlpfH
X-Google-Smtp-Source: ABdhPJyLsl0QEwOIzxkUnepGxjpzz7ATMHPEl9hA0vD6OQEK7CI5ib96Ws44vmpaMuFwuB+nl5d7+g==
X-Received: by 2002:a05:622a:1ba5:b0:304:e906:c4e6 with SMTP id bp37-20020a05622a1ba500b00304e906c4e6mr1332432qtb.117.1654371067828;
        Sat, 04 Jun 2022 12:31:07 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:07 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 12/33] vsprintf: prt_u64_minwidth(), prt_u64()
Date:   Sat,  4 Jun 2022 15:30:21 -0400
Message-Id: <20220604193042.1674951-13-kent.overstreet@gmail.com>
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
index 1c5ffc7f28..7b49a998d3 100644
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
2.36.0

