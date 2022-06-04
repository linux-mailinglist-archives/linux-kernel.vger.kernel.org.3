Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0377853D860
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiFDTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240649AbiFDTbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:40 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20950001
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a184so4813982qkg.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EcspCOdO3ERymWEcbTM1mUbo49A548NGXqTZCRd2s8=;
        b=l02443OrBLuUyG71ej4YvSDyXjAtkdq3Mh1aRuz1IYeuK8rqF0Rpq/jPGeF/j1v6hN
         iXCIvCwEAoKluUuX8Ywo4ZyjynDP/OhfS39bwixWuRs11xDjGdbNOyRLq4akrOO3nDl6
         bs+wvnZtqY0jOPZOXFWqmGLOyXksQ2rNU3hNkoBG4uabJrua+71Dey7PWfhbEjdHL29Z
         8ukiSB4vvtGGJ0/rrlTsB8dHt+qTVLnb6aUCe7j3vGxwAeEgrSS8OtQWPFR19zRqdV7z
         EQIotE6+2/GQVMQ8Yl+VGimeHkgzgF4PziiPrM7bohQSg/oyBCOfulZc8XHX5DJHRFxs
         gHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EcspCOdO3ERymWEcbTM1mUbo49A548NGXqTZCRd2s8=;
        b=hYaVnMOVeutTlEAzhJHY0WtIF6KyosrwVcnKRlRHWrn4HYjX/osTlBg4BfAMthbPKD
         BRrALeTpkCQaa7AgK/0GKXtUVTrzpDRdRmlEwfSAM/hhIEusEukNVsQUTuU64RMwfpbu
         DUsQ+3BZ9HKDccpqyo2LMWE+H+/bljPzvVwndZbLCnvRHT6gUBNbnYY9LQvfyxtIWaN2
         ZyUXUFefJ23gJl+GSvilWvez+iyFanaMtytkuNJ8HENvrA/0n17KD6+V3rqfh8K31LGf
         DKSeHSD4hb4XfsqnpKoU+2Li1inkBPZOCIRkhnMwWXjSQF77XApog+b7n+zQE1pN9JQ7
         gnEQ==
X-Gm-Message-State: AOAM533YTG30przspcdbUzRSxT+BV72WsL3iAs1T6pmKU/cNz+qDTwrH
        +mL/ZFY+T9drKSNStVgFdko4rr9qL0Wj
X-Google-Smtp-Source: ABdhPJzBuY7gv/t5buyAi6q/RUYs/Yy+fsSFyvu5ITPo1CN3yUF3PanibFLO8vDMEg6wfBHBBrJoQg==
X-Received: by 2002:ae9:e401:0:b0:6a3:5985:8f41 with SMTP id q1-20020ae9e401000000b006a359858f41mr11169541qkc.58.1654371078561;
        Sat, 04 Jun 2022 12:31:18 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:17 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 19/33] vsprintf: time_and_date() no longer takes printf_spec
Date:   Sat,  4 Jun 2022 15:30:28 -0400
Message-Id: <20220604193042.1674951-20-kent.overstreet@gmail.com>
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

We're attempting to consolidate printf_spec and format string handling
in the top level vpr_buf(), this changes time_and_date() to not
take printf_spec.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6020f55fc0..5de25723a3 100644
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
2.36.0

