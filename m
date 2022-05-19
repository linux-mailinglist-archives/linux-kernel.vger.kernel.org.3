Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF352DB36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbiESR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiESRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E6A5014;
        Thu, 19 May 2022 10:25:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i8so5361723plr.13;
        Thu, 19 May 2022 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gy2+5rtVyQSQ3X+3Wrn/m9PvaQt4Dx/XsZuXj5gNKrU=;
        b=B+r49MDVnM5d0FiWcFCC+mfxqj5H0MKA3XMEXVUTRNEHGFprEwcpGiGffDByit/Ai+
         jBZ9lsrNPI2UQ5kGuaSo+Z2WQDfmbB6M+wGNoCQMSg6dmUr3T0b2Jbf+OcyHARoBHazw
         ObAJwwNC+hFSnPi9KlC047SwXWAGFEmSuajobWNYqrN6KoapKKu9KDJy0cwtR7L0C7ko
         J9vX5Usp6Z8AVWgYa2sb2uwG4cHP0xKRktevbD5cn+7iw5ta3qXqeHIVFTfHMEAGhmDf
         SLtSHPtudWujNfVnNb+UJirItZ2XwS5nCHrwbXQuAbe3vu/YGbwnmMIYwuK+vgzKEDWG
         9O6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gy2+5rtVyQSQ3X+3Wrn/m9PvaQt4Dx/XsZuXj5gNKrU=;
        b=SoHV4IgvCvBq6vGuOh0v7TawFwRy8GQlUWcYivNAIAPCktsHl2kMk3mkGJM0iRDihf
         GyHgCARLKh+DZBPtBdaDPdx9DwiQdQi4aJ0JMZZVApPEOszPbjrGTU+rfWBdvUUgMmfd
         lirpQWJ7h9hLhK5MJnXOnNNFjLyP0kO1XEntJfXrFK0M7Sp7NzU8doQla3y0rsJXLm9e
         yXZzlyThoB3bbUJ7SChBP2S7OTmYqZm3CTi1dpiMsgT6W0gYaTB4guZYF8z9wGPdPlGJ
         cuRCsxmZ/KQ4sKYhPuv0+WyNWSbv3qybSaZPj8oH7FYF1252I3sn2j/kxIk/9HPO8Hu8
         yxNg==
X-Gm-Message-State: AOAM5311LNAKi3iSUZI3bFxonsxAszEfsCoK7V3EVonTduP/14Sz339y
        tG0NAl1l3GG+y8VjxF7BGCy88T6ksqDh
X-Google-Smtp-Source: ABdhPJw4dVRMKUuhKQxwg42jFQsCieCMJQrREs9viGoJuAg8nY1RWFtqTLQb4iB0WD43n5V4Ac29kg==
X-Received: by 2002:a17:902:a583:b0:15d:197b:9259 with SMTP id az3-20020a170902a58300b0015d197b9259mr5601285plb.51.1652981116633;
        Thu, 19 May 2022 10:25:16 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:15 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 18/28] vsprintf: time_and_date() no longer takes printf_spec
Date:   Thu, 19 May 2022 13:24:11 -0400
Message-Id: <20220519172421.162394-19-kent.overstreet@gmail.com>
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

We're attempting to consolidate printf_spec and format string handling
in the top level vpr_buf(), this changes time_and_date() to not
take printf_spec.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 76947e0d30..837a3f967e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1735,14 +1735,14 @@ void time_str(struct printbuf *out, const struct rtc_time *tm, bool r)
 
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
@@ -1780,7 +1780,7 @@ void rtc_str(struct printbuf *out, const struct rtc_time *tm,
 
 static noinline_for_stack
 void time64_str(struct printbuf *out, const time64_t time,
-		struct printf_spec spec, const char *fmt)
+		const char *fmt)
 {
 	struct rtc_time rtc_time;
 	struct tm tm;
@@ -1798,21 +1798,20 @@ void time64_str(struct printbuf *out, const time64_t time,
 
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
 
@@ -2300,7 +2299,8 @@ void pointer(struct printbuf *out, const char *fmt,
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
2.36.0

