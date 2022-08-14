Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E6592699
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiHNVWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbiHNVVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:44 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF66BC1D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptPwYB0Na0QNvO8nfaucya/V27gZPueTz3T5kBROrAw=;
        b=xFaKz0SwOEscTnG+1GYL5MdR0kkplrisSPqDK+yyGsBtqhMOBvnhLgjplThfu1TYvuBuoX
        ijf9K2mjj8Y/ntr/kB4jKffcZBUePuciZ/uPiTBjj0XCR3jnd7NL3IaoOWZ8NhG8agWx7Q
        HL6o4LC2IhC42FALLMIpyjvkKtZ1Gb4=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 17/32] vsprintf: time_and_date() no longer takes printf_spec
Date:   Sun, 14 Aug 2022 17:19:56 -0400
Message-Id: <20220814212011.1727798-18-kent.overstreet@linux.dev>
In-Reply-To: <20220814212011.1727798-1-kent.overstreet@linux.dev>
References: <20220814212011.1727798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
index d8e8d211bd..8154beae12 100644
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
2.36.1

