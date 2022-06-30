Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350E95623B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbiF3T7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiF3T7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:59:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CC54132B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:59:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c20461d7eso2650717b3.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=bQE81g2DmbR80VZhT+P0vc15LIodMtph9Q2b9AmTsII=;
        b=eR90cr21CMIzTJFV+sggZ9202FIY3SWnOc51sGGAw3DCFSfXQZHBwHRBWfPMiSA11h
         LcCL9ysenrMzJ3KFahx7K4L1bPkH2ZO300OMvJvSQGOQmx5oz8Y1OFlOL6lUlVMP/OPa
         3son8m5HjnpQntHpajGNczO51xPJaWE1UYl5n2mv0QZ8LKfEfYjqig5HtmIyavx80OIe
         8c+M8wXg2MHwbaBpMEOuGiHlGk+0DPdEeabNg9j6tshUS+V+Hu3UXGkY/6uKIP31XS0o
         owM1PPa/9+tp82p0O12qYjfTfLQcPyqevFfns1deiXWDR/b2Ah3j35PmtbKktzOY9TnI
         jaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bQE81g2DmbR80VZhT+P0vc15LIodMtph9Q2b9AmTsII=;
        b=aBLy3kv+xv6x1d4bOFjn2AsSH7jzBDrzM6hsR2ivPgxsz49u5MV2M9v0PMo389aBbB
         9kk4l8gj+93ad59b+PTsC64gKEDYPJQaJT8p0mSxu9mWBbiXiWtyJlN07MP+Ro/LXpmZ
         b6oxxoAFuyN4smk+dJPUKEUHAcJ50A3q2ThcykI8wS4c0EbiNHuyOBdTokyKPiCBNqbk
         m3Y+VosMMECT+0AKI8lSZUAH5eA8YqTjsmepJlxG5FIrbV6UyPzG1PaXBm78lH5lXxOQ
         JCyFJ/DnGGkZf0hzXWQpCVzTgs8g6GsO/2wYexZQgMRCEI5UKVO8qUNx1VuNomDsomXm
         wQWA==
X-Gm-Message-State: AJIora8tIYRxXO40md060uw7FX9+QKEfn2KV1gzzQL9bEaWPK32gXRIg
        /tmEToMC95E905f/UKklFwO53TyWqBXbpZFQVA==
X-Google-Smtp-Source: AGRyM1sparANkcr0hS7xCyT2s+pmU9FlGK6H0Zbv4B5xz9oF44IokbA8zliI6ZJEN3LaUeYqK1qiHE5Df6Gm0RNlSA==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:c5f5:d5e5:38d2:2025])
 (user=justinstitt job=sendgmr) by 2002:a25:d292:0:b0:66c:8adb:ce55 with SMTP
 id j140-20020a25d292000000b0066c8adbce55mr11608903ybg.131.1656619155389; Thu,
 30 Jun 2022 12:59:15 -0700 (PDT)
Date:   Thu, 30 Jun 2022 12:57:38 -0700
In-Reply-To: <20220629235326.480858-1-justinstitt@google.com>
Message-Id: <20220630195738.904505-1-justinstitt@google.com>
Mime-Version: 1.0
References: <20220629235326.480858-1-justinstitt@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] lib/test_printf.c: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes from v1:
* moved NOWARN macro definition to a more appropriate location
* using __diag_ignore_all (thanks Nathan)
* using local scoping for code blocks instead of __VA_ARGS__ (thanks Nick)
* indented affected test cases (thanks Andy)

Suggested-by: Andy Shevchenko <andy@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 lib/test_printf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 07309c45f327..1b1755ce9fa7 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -30,6 +30,9 @@
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
=20
+#define NOWARN(option, comment, block) \
+		__diag_push() __diag_ignore_all(#option, comment) block __diag_pop()
+
 KSTM_MODULE_GLOBALS();
=20
 static char *test_buffer __initdata;
@@ -154,9 +157,11 @@ test_number(void)
 	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
 	test("  0x1234abcd", "%#12x", 0x1234abcd);
 	test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0,=
 1, 12, 123, 1234, -123, -1234);
-	test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
-	test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
-	test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
+	NOWARN(-Wformat, "Disables clang -Wformat warning", {
+		test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
+		test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
+		test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
+	})
 	/*
 	 * POSIX/C99: =C2=BBThe result of converting zero with an explicit
 	 * precision of zero shall be no characters.=C2=AB Hence the output
--=20
2.37.0.rc0.161.g10f37bed90-goog

