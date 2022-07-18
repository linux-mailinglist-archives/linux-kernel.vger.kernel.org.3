Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDEC578E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiGRXGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGRXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:06:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20F275EC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:06:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r142-20020a632b94000000b0041a18177a5dso1630192pgr.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=kr+g0QLyfEsKisyWseSQidWHG7rTs+Z9BjnCTx3ihTc=;
        b=UALDjrOGFK63RNNlZA9jDLc+QBDSAH1EdrvRdsbNPiAxlbTp5/vXOzhCE0JdyzjItg
         6Guq1N/aGwWPV+Lqa8Faop3fIKcrvQylt/GMLCPQ/7GSHA3Tai77w4t5p8omE3dh63a5
         ZvP0h4vC2B2xEwEhysFiZd9ED6dCdIoGNVpxRoS1WZABUjlOKu8WUPczczpe+tVS9M9d
         9zBPC7I6ns7Gu48exyHoPaD1dh3sfob4A9ZMTpZE68k0cJwNgu19cJXyd/sqjPn89v5W
         jR7kBLNsJg8SR0yswTuj0tmeMqIjb3s9rkr8/+e/IITIMXsDBURqpQP2W0buSK4lgJgt
         MgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=kr+g0QLyfEsKisyWseSQidWHG7rTs+Z9BjnCTx3ihTc=;
        b=S6hiNQ822xG5apmLnR/1kxI0cE0DIKZqUrn3nlM6PSTR5WYqMWLrqzvOTeW6dAdMgd
         MQ/nCn59Ni9w+RgdjF6DvO+zQrh4UnukKt1v2X3T30l/fkW9whzk5nYbB17tqF1ITnzr
         Wb81kR/CVvRF0p/DxrJklQZB3U8rRC0PX6jCOgqbEh+yvdP0CHS/tISJonNn+wzB0TYR
         BGfvRNY1VMFS+3l1uf731RD4XBYXYlnbo3hD/DdqzCpnPD1//gQNvT3sbno/hxLcKrZq
         0UNmVesw+HUgMRQCOvscnAXWFY0H/PHJCpyZo0frtlciHsfavAcEoel4D7z9M2Xlfsn4
         Q3aA==
X-Gm-Message-State: AJIora8VMxI5uh361C4m//wODNUiPBKT25HH4eM9IjNGvsLTFvxCDLw8
        rRGiy0EYlOzIfeQGqAvXD5MsV+iLx3sC/PW6Lg==
X-Google-Smtp-Source: AGRyM1vtVDLoN7bIQSM386zKqi30WcOFVcP2gi6jg06lTY3MCLjhqHNIUvyaeunHATC+f0/1R+GPQ6p77PqvVtOUDA==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:f922:7e91:d8e8:24c4])
 (user=justinstitt job=sendgmr) by 2002:a17:903:3093:b0:16b:deea:4d36 with
 SMTP id u19-20020a170903309300b0016bdeea4d36mr30327719plc.126.1658185595359;
 Mon, 18 Jul 2022 16:06:35 -0700 (PDT)
Date:   Mon, 18 Jul 2022 16:06:26 -0700
In-Reply-To: <CAKwvOdnN67xFL22oWfqrKjvES4vjSB3KNhm401LtoC7igO+4Vg@mail.gmail.com>
Message-Id: <20220718230626.1029318-1-justinstitt@google.com>
Mime-Version: 1.0
References: <CAKwvOdnN67xFL22oWfqrKjvES4vjSB3KNhm401LtoC7igO+4Vg@mail.gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4] lib/test_printf.c: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     ndesaulniers@google.com
Cc:     andriy.shevchenko@linux.intel.com, justinstitt@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, trix@redhat.com
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
* using local scoping for code blocks instead of __VA_ARGS__ (thanks
* Nick)
* indented affected test cases (thanks Andy)

changes from v2 -> v3:
* reinserted commit message
* remove Andy's Suggested-by tag
* add issue tracker link

changes from v3 -> v4:
* better macro indentation and usage string (thanks Nick)

 lib/test_printf.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 07309c45f327..f78044c1efaa 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -30,6 +30,12 @@
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
=20
+#define NOWARN(option, comment, block) \
+	__diag_push(); \
+	__diag_ignore_all(#option, comment); \
+	block \
+	__diag_pop();
+
 KSTM_MODULE_GLOBALS();
=20
 static char *test_buffer __initdata;
@@ -154,9 +160,11 @@ test_number(void)
 	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
 	test("  0x1234abcd", "%#12x", 0x1234abcd);
 	test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0,=
 1, 12, 123, 1234, -123, -1234);
-	test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
-	test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
-	test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
+	NOWARN(-Wformat, "Intentionally test narrowing conversion specifiers.", {
+		test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
+		test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
+		test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
+	})
 	/*
 	 * POSIX/C99: =C2=BBThe result of converting zero with an explicit
 	 * precision of zero shall be no characters.=C2=AB Hence the output
--=20
2.37.0.170.g444d1eabd0-goog

