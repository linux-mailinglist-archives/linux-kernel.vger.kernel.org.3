Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB61158C1CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbiHHCnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242539AbiHHClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C177C25ED
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XMPtB3chMhlXpXIghsTgAd24SoNYbzppATzU+ECsSLw=; b=oCAkoSLbXX9r3HlgG8il8G41x5
        Ed2SKexRgOfHJPUy4mgqJXrHIj5sYv+OX3S0rxJNEn1/GG9MGIJvcg4VbW3TnVgDEsaSSmDu0woHd
        9iTPTf5oSqEqMr4B3KU3+SxJjQXLeHJOnPjXxQjMw1lYzugr5jjmRJdahHqyzb2pbI1UlOqawOgUL
        B9v8DhOPf9AzLS4Yau1UQ8wo+HZPn8vowSQBtvcBpuXHJK97yI7Z68io7xQtYhrYavqBYOiU/gAQH
        kTKN4iktY/YbqljHCix/r4Y3L7GdOWxhc0p6swUFODfnE2a7XIPIPxRJXHlvmJOMU8L8+yP0OWCfs
        k8URUZoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVRx-0m; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 17/32] vsprintf: time_and_date() no longer takes printf_spec
Date:   Mon,  8 Aug 2022 03:41:13 +0100
Message-Id: <20220808024128.3219082-18-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

We're attempting to consolidate printf_spec and format string handling
in the top level vpr_buf(), this changes time_and_date() to not
take printf_spec.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2042c17f571e..784f7cb64926 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1736,14 +1736,14 @@ void time_str(struct printbuf *out, const struct rtc_time *tm, bool r)
 
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
@@ -1781,7 +1781,7 @@ void rtc_str(struct printbuf *out, const struct rtc_time *tm,
 
 static noinline_for_stack
 void time64_str(struct printbuf *out, const time64_t time,
-		struct printf_spec spec, const char *fmt)
+		const char *fmt)
 {
 	struct rtc_time rtc_time;
 	struct tm tm;
@@ -1799,21 +1799,20 @@ void time64_str(struct printbuf *out, const time64_t time,
 
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
 
@@ -2297,7 +2296,8 @@ void pointer(struct printbuf *out, const char *fmt,
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
2.35.1

