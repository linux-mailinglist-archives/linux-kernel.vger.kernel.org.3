Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6F550E05
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbiFTAoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbiFTAn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037DEBC1F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d23so6897371qke.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7klV3vdNzn8/A87P4NR4f70XoVa4SM0sCvYSYAJUFs4=;
        b=Z3bzbCoaTUPOIlSJfmP24rQbW9QXTC2u/4OSlp5WsFbVg32IAjNFiVf7vpfBvUqED4
         mX8ohRYUETDXPDKpqRWJq7h06hM1H/joHmCP/Qep7+Wg6RJl6T9s9cdHAUy5u2/p4kTQ
         6bIFpx6gCBuCrJH8WVnm2K9eTM8FDhQmf1VcfWCVWmTq/q35S+TCxwaSPKAEeeJbpEP2
         Rb6I7WqUrcsXBBKUfvKm54t/KKbYLsPivsXZ3Cewri90jbqHE93VSRyzNXSeTx9hEGMU
         XwFh/U+CohoHOqHWVCXT/0u8g1+SvDXxnM4d2sIsFmG6NEw6Qt0o8Ar2OC8dbDIubw5h
         Hmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7klV3vdNzn8/A87P4NR4f70XoVa4SM0sCvYSYAJUFs4=;
        b=ZxyXdAnHzkCF+zKt97gdb31N6Jj3/vs3grU1alWST4X+wwicCYDN+FK4UPz6V016Hd
         QFAzB67UchmbdC0yYjNEc846VF10vPKzleE55W3UzgWT4x9AtE8B7h+y11YjKyVVO4os
         54ox5JMw66FXQNdh3vwZzlyxyX7v35a1/2cbuR3jZ00ikzUhjbA9J/ps0aIOyZY2OPfC
         r2ARZJYKnCO+EInp7439n5XFRxAZx6zdKu2TbxH4ga+vCX188UH6eiM0UZac3XILrDWB
         ZsWMtWUaASHOlz1rf03ALuAFsPMrKVO9fJBItcSoNhluUi5B0Hz/hRxQ05yloNCOylul
         gztg==
X-Gm-Message-State: AJIora9XZ+j7wqSxP2HBBJM6EiHwCg9+lARMc3IJIh0yH9923t2nborQ
        QVWe85HPS3T42dEhs20k4H5o89NfkEWLAw0=
X-Google-Smtp-Source: AGRyM1umLaPAf/akasIsSgksCEhoGwYZ3ZODEavmbk0rCbtNu+YACEOmp4mlkvsk1Aepg/nAjndhmg==
X-Received: by 2002:ae9:e70d:0:b0:6ab:94ad:fe23 with SMTP id m13-20020ae9e70d000000b006ab94adfe23mr9066959qka.739.1655685799180;
        Sun, 19 Jun 2022 17:43:19 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006a6ab8f761csm11425215qko.62.2022.06.19.17.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:17 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 19/34] vsprintf: time_and_date() no longer takes printf_spec
Date:   Sun, 19 Jun 2022 20:42:18 -0400
Message-Id: <20220620004233.3805-20-kent.overstreet@gmail.com>
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

We're attempting to consolidate printf_spec and format string handling
in the top level vpr_buf(), this changes time_and_date() to not
take printf_spec.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 486c09b4ad..affe2b0bcc 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1761,14 +1761,14 @@ void time_str(struct printbuf *out, const struct rtc_time *tm, bool r)
 
 static noinline_for_stack
 void rtc_str(struct printbuf *out, const struct rtc_time *tm,
-	     struct printf_spec spec, const char *fmt)
+	     const char *fmt)
 {
 	bool have_t = true, have_d = true;
 	bool raw = false, iso8601_separator = true;
 	bool found = true;
 	int count = 2;
 
-	if (check_pointer_spec(out, tm, spec))
+	if (check_pointer(out, tm))
 		return;
 
 	switch (fmt[count]) {
@@ -1806,7 +1806,7 @@ void rtc_str(struct printbuf *out, const struct rtc_time *tm,
 
 static noinline_for_stack
 void time64_str(struct printbuf *out, const time64_t time,
-		struct printf_spec spec, const char *fmt)
+		const char *fmt)
 {
 	struct rtc_time rtc_time;
 	struct tm tm;
@@ -1824,21 +1824,20 @@ void time64_str(struct printbuf *out, const time64_t time,
 
 	rtc_time.tm_isdst = 0;
 
-	rtc_str(out, &rtc_time, spec, fmt);
+	rtc_str(out, &rtc_time, fmt);
 }
 
 static noinline_for_stack
-void time_and_date(struct printbuf *out,
-		   void *ptr, struct printf_spec spec,
+void time_and_date(struct printbuf *out, void *ptr,
 		   const char *fmt)
 {
 	switch (fmt[1]) {
 	case 'R':
-		return rtc_str(out, (const struct rtc_time *)ptr, spec, fmt);
+		return rtc_str(out, (const struct rtc_time *)ptr, fmt);
 	case 'T':
-		return time64_str(out, *(const time64_t *)ptr, spec, fmt);
+		return time64_str(out, *(const time64_t *)ptr, fmt);
 	default:
-		return error_string_spec(out, "(%pt?)", spec);
+		return error_string(out, "(%pt?)");
 	}
 }
 
@@ -2322,7 +2321,8 @@ void pointer(struct printbuf *out, const char *fmt,
 		dentry_name(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
 	case 't':
-		return time_and_date(out, ptr, spec, fmt);
+		time_and_date(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'C':
 		return clock(out, ptr, spec, fmt);
 	case 'D':
-- 
2.36.1

