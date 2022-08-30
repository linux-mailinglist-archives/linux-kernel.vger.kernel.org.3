Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18B5A71D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiH3XcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiH3Xb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:31:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7B72FE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f12-20020a25b6cc000000b0069a9e36de26so875610ybm.16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=stIJrjMqwQ0zAOFApEyjbwm3OExfLqdVzHQ/Ti/K+RQ=;
        b=XT3FqCUj0oWltSKyz0DMYCdz3zG/R+ch6PgREyusoybVfYnjSIIp1QEVmgkw27BMRj
         1bwaWQRauXjRVmhR+FXatY3cAFgTFdHOwv4MeNRe9viWmXCdGh3ZqgTqK/bonGIUbUm2
         nzVQrEYCIwgQuRvzHL9weunLc+sqBtMBzhAT8qbEtdumA2TqedCJySqMrqa0Xf9T3VwZ
         xs9JxjNj3lR1umlvKCUf9SNYAvbTD4J4ebt11ivYnN3e4XZbiJ9Vkff0l7aHJfuG01re
         yOHwdfZzJCRQzCio9+FrwTtHBU/fAgGor0fUpdX6v+iYm5fuK07woR5EljmpbadzEdVA
         zmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=stIJrjMqwQ0zAOFApEyjbwm3OExfLqdVzHQ/Ti/K+RQ=;
        b=I7+AaBoS6PEbD/UVqx5Zdx8D3BwzBRUGzIaCMF8/H763UqyH/Zi1nLft/KWuVrXV9b
         PD+pTRLkdOad7o54hY4qvQI7fClx7sDoUh/MtpDlH62xBSYWqW/1SneA75W5gCqYx/sb
         OppAfUqzRMK6ClUoXAeCNV10dnlh+talNIm2MGeUJX2UtqpJ0ERlZTi5ly8/vS7zPKO1
         gEYL5KnVtrrcZiNVZbJQnAXxySJddTDKito80CFIhBZUcSAbjfMtzh7/geky8XN4E602
         ySQik7QwXw0/EEj4hirihGyJHlpGLPFY5CyWnoobxFRCnHJTnXpuEkuy+g082d5EEozj
         2c4Q==
X-Gm-Message-State: ACgBeo3DvIQZNXvuw5fWeQt6Os9z3uoWK8Et1qWgz4aZiSGW4JAxyKAR
        mrGfn9gGb8IVmF8SbdofsfJ/D0qhafRl2YnZ7w+vXpu1YhrJ2fKaCaOePszrSV1922rJB/BFHRl
        hwbpGJ7KQZ0lyA3plVuZuxx4UwssoGFf9/1na+lRoHeg73eR/lG6XvEvcO38ZEpgCVpLxViGbsF
        8p4hkAouO64Q==
X-Google-Smtp-Source: AA6agR5cGTdetFCiErxtdp82eH3P66qCr5xSoNGpsQG/NljG1Kaq9Ijanf8vSqY++9XIfhHa37mVG0A5SaW5IY9d2eE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a81:8803:0:b0:341:6235:8cbe with SMTP
 id y3-20020a818803000000b0034162358cbemr7018693ywf.146.1661902312128; Tue, 30
 Aug 2022 16:31:52 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:15 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=samitolvanen@google.com;
 h=from:subject; bh=qxVnlSZocW9/1UypXlLGEHXfm4CDzclNhcl/lJ18fGo=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3M7+6Z3E3yWx3lSnRphzF4/3RQHI2psdANcTX1
 DniQSb2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzAAKCRBMtfaEi7xW7vYpC/
 wJyHxmthaRukbl+m+7vClm87xKX81E51zW8v/dmnTAiBQ7oT1Ek1XR7SJo/50PfceCBcZ366Psr6wx
 L7143nIwKv3bXT4p97cRjwxu4M0m8HvXeZYxX2Xqsc6uerduxtDTzFjDPWA8VsVsVXpIN5BluFq//1
 Jx120TP9+6zYwQsOBpMcJCq2cr+LMVUG0pX2qqLSJGAE1+2yoL2kBisWcIdDxS1jJ5266S/HoYqktz
 JO/BzYSjJqxWmTxt2M4SzxDHm1EgNjsm5ntVO+KRW+klcvF2/1A+hyopJ1c+SrByL7fc/WNq8q15Gu
 rS6sXoG21TAT7q0EBWR2GYae6G6d/o1Sn1DTQpzi+TfRj8zYXkDPGgdxdflelIoodZ3g3q/vf2hzCC
 Y6S35Cpa4ek9uS8PsTuYFkYecoZCw/xrq+x1R6KPGpwl3/NAuYPWxv8goJ10UY0hjOxJby0LDXRouv
 cp8+PZmKAqFAjGeoHcRcLyUkHJSTY52q00bcKiCKHOdz8=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 07/21] lkdtm: Emit an indirect call for CFI tests
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang can convert the indirect calls in lkdtm_CFI_FORWARD_PROTO into
direct calls. Move the call into a noinline function that accepts the
target address as an argument to ensure the compiler actually emits an
indirect call instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/cfi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index 71483cb1e422..5245cf6013c9 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -20,6 +20,13 @@ static noinline int lkdtm_increment_int(int *counter)
 
 	return *counter;
 }
+
+/* Don't allow the compiler to inline the calls. */
+static noinline void lkdtm_indirect_call(void (*func)(int *))
+{
+	func(&called_count);
+}
+
 /*
  * This tries to call an indirect function with a mismatched prototype.
  */
@@ -29,15 +36,11 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 	 * Matches lkdtm_increment_void()'s prototype, but not
 	 * lkdtm_increment_int()'s prototype.
 	 */
-	void (*func)(int *);
-
 	pr_info("Calling matched prototype ...\n");
-	func = lkdtm_increment_void;
-	func(&called_count);
+	lkdtm_indirect_call(lkdtm_increment_void);
 
 	pr_info("Calling mismatched prototype ...\n");
-	func = (void *)lkdtm_increment_int;
-	func(&called_count);
+	lkdtm_indirect_call((void *)lkdtm_increment_int);
 
 	pr_err("FAIL: survived mismatched prototype function call!\n");
 	pr_expected_config(CONFIG_CFI_CLANG);
-- 
2.37.2.672.g94769d06f0-goog

