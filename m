Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA7B57886F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiGRR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiGRR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:29:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41CB9591
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:29:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r64-20020a254443000000b006707b7c2baeso519757yba.16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=suawiw5DlcXpf7bbkJ8PQQ5vzk0PkV6q8VurOqdiYMY=;
        b=n1z3j0VmLBxQGOrbPRlK8tZbvAdrIiSz2bQYgkNeq91d456+eDiYc/5GFZensGwLHS
         7JhkuGT1gsar3PIyhhKnulRBxVqnhND67ffrLp/URcjl17F0XFm2d4ye1Qxk32w9T7mI
         cy5H+ZQZJcU6281/3wjSw6u5KrEv5vtBlH331AMPeXiLa9lmTvS4JfE73jJTvQ2le99k
         SH32N15YXJcZp0JXFvFRp8Watj160JjzozaI1GpSWp4VCYTkKkCU015f3TaHU3gdFqtD
         rfXQWyWpzOTiJIxyFl5HS0oOoZsoUbgBvo9mBDgWh28SOwaxjvBu8FhXbkY58Q/bLMIU
         6e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=suawiw5DlcXpf7bbkJ8PQQ5vzk0PkV6q8VurOqdiYMY=;
        b=O7ZfpWUMDJEZ3zE+PUM1+E1sGYHvMax24yZm9AJdCPyLHqkhtpDID8w+R/2FTB5LdK
         FV916t+iUFkBoRxQ7NJJSkaH//xTcq7w9UYCnrQZWprjcLRTyx2VLgM9aTHXM7N86yLv
         4Ux4KZ4IkaPfSzJqjmLBPI+PKwn/yTYvFAlm1tV25ytkh9YnQCHGeWN6EdddDxGoWZU4
         zA8DR5igQVV4CW94/W1lrSTF539z/OBit5mTsFhtVvus6/iVjX7tAM+ZlACGVGhoe6XX
         7JmMh2VSm+ituEKBXsK7r9wTbeNm//dH5YB6IqcRnmVi4tMqVRWg5k+KlO+sL+DcNHEd
         CQHA==
X-Gm-Message-State: AJIora93LLkksyvYf8Nx5cok+kik1kWbO/k+rEVeN1D8kir4yxiM4Xw3
        3ypz4SvMMh+pIGTKd2euDjIM+S7unx/nb7uwHQ==
X-Google-Smtp-Source: AGRyM1vmgl2/mU40hrNgPwoKkTbeprZfiqtsuMWXyJISc3ZqdWtZfqYZaWX9OnKCAm5p/wIsJcS05lXFKYZpdBvngw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:f922:7e91:d8e8:24c4])
 (user=justinstitt job=sendgmr) by 2002:a25:880b:0:b0:66e:3d9e:7dfd with SMTP
 id c11-20020a25880b000000b0066e3d9e7dfdmr25745809ybl.600.1658165393981; Mon,
 18 Jul 2022 10:29:53 -0700 (PDT)
Date:   Mon, 18 Jul 2022 10:29:34 -0700
In-Reply-To: <20220629235326.480858-1-justinstitt@google.com>
Message-Id: <20220718172934.4155189-1-justinstitt@google.com>
Mime-Version: 1.0
References: <20220629235326.480858-1-justinstitt@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v3] lib/test_printf.c: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     justinstitt@google.com
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

see warnings:
| lib/test_printf.c:157:52: error: format specifies type 'unsigned char'
| but the argument has type 'int' [-Werror,-Wformat]
test("0|1|1|128|255",
| "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
-
| lib/test_printf.c:158:55: error: format specifies type 'char' but the
| argument has type 'int' [-Werror,-Wformat] test("0|1|1|-128|-1",
| "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
-
| lib/test_printf.c:159:41: error: format specifies type 'unsigned
short'
| but the argument has type 'int' [-Werror,-Wformat]
| test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);

There's an ongoing movement to eventually enable the -Wformat flag for
clang. Previous patches have targeted incorrect usage of
format specifiers. In this case, however, the "incorrect" format
specifiers are intrinsically part of the test cases. Hence, fixing them
would be misaligned with their intended purpose. My proposed fix is to
simply disable the warnings so that one day a clean build of the kernel
with clang (and -Wformat enabled) would be possible. It would also keep
us in the green for alot of the CI bots.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
changes from v1 -> v2:
* moved NOWARN macro definition to a more appropriate location
* using __diag_ignore_all (thanks Nathan)
* using local scoping for code blocks instead of __VA_ARGS__ (thanks Nick)
* indented affected test cases (thanks Andy)

changes from v2 -> v3:
* reinserted commit message
* remove Andy's Suggested-by tag
* add issue tracker link

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

