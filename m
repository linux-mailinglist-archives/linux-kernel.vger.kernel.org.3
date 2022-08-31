Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D015A857B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiHaS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiHaSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EE4FB294
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6377861CDE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFE2C43145;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=SQPsyy9Vw1zAhKnxU2HPB0epktjeTQk3RDWN/C0VtjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTzY4pGiBFNhDe/LhkJfWLA/OI5kQxPv6QKYYcFwxRtIUjY78yHG37at6JH/4OW5g
         +w7eektmCnuAFAfpVKmj/Uf6icornAmMnfLXnsrTYFwwQVrGfQf0CM88Wjjejz4xG/
         DYcV7RpnyMbd8/gFqdlTXecUV201Qeq76KsFMdkter6gv3OtI8H1NR/pG33P2b32UW
         PhuwFc8PrinDnU43L1je4T7tJ4Fw3qVRi24lMbt377VtcvOghQZvVM8vtyUaSciG+I
         nq7kR3RNOl4F0r07WO5TvC24Zhd9y7wSLfj011I38LqXq0mGLwMATJLMhyI9ahGNFK
         a1oJ/gRaG9cnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DBBD65C0950; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 05/18] selftests/nolibc: support a test definition format
Date:   Wed, 31 Aug 2022 11:21:35 -0700
Message-Id: <20220831182148.2698489-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

It now becomes possible to pass a string either in argv[1] or in the
NOLIBC_TEST environment variable (the former having precedence), to
specify which tests to run. The format is:

   testname[:range]*[,testname...]

Where a range is either a single value or the min and max numbers of the
test IDs in a sequence, delimited by a dash. Multiple ranges are possible.
This should provide enough flexibility to focus on certain failing parts
just by playing with the boot command line in a boot loader or in qemu
depending on what is accessible.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 91 ++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6c050d4381fec..49177ea9943cc 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -17,6 +17,12 @@
 /* will be used by nolibc by getenv() */
 char **environ;
 
+/* definition of a series of tests */
+struct test {
+	const char *name;              // test name
+	int (*func)(int min, int max); // handler
+};
+
 #define CASE_ERR(err) \
 	case err: return #err
 
@@ -376,19 +382,104 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	return ret;
 }
 
+
 /* declare tests based on line numbers. There must be exactly one test per line. */
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
 
+/* This is the definition of known test names, with their functions */
+static struct test test_names[] = {
+	/* add new tests here */
+	{ 0 }
+};
+
 int main(int argc, char **argv, char **envp)
 {
 	int min = 0;
 	int max = __INT_MAX__;
 	int ret = 0;
+	int err;
+	int idx;
+	char *test;
 
 	environ = envp;
 
+	/* the definition of a series of tests comes from either argv[1] or the
+	 * "NOLIBC_TEST" environment variable. It's made of a comma-delimited
+	 * series of test names and optional ranges:
+	 *    syscall:5-15[:.*],stdlib:8-10
+	 */
+	test = argv[1];
+	if (!test)
+		test = getenv("NOLIBC_TEST");
+
+	if (test) {
+		char *comma, *colon, *dash, *value;
+
+		do {
+			comma = strchr(test, ',');
+			if (comma)
+				*(comma++) = '\0';
+
+			colon = strchr(test, ':');
+			if (colon)
+				*(colon++) = '\0';
+
+			for (idx = 0; test_names[idx].name; idx++) {
+				if (strcmp(test, test_names[idx].name) == 0)
+					break;
+			}
+
+			if (test_names[idx].name) {
+				/* The test was named, it will be called at least
+				 * once. We may have an optional range at <colon>
+				 * here, which defaults to the full range.
+				 */
+				do {
+					min = 0; max = __INT_MAX__;
+					value = colon;
+					if (value && *value) {
+						colon = strchr(value, ':');
+						if (colon)
+							*(colon++) = '\0';
+
+						dash = strchr(value, '-');
+						if (dash)
+							*(dash++) = '\0';
+
+						/* support :val: :min-max: :min-: :-max: */
+						if (*value)
+							min = atoi(value);
+						if (!dash)
+							max = min;
+						else if (*dash)
+							max = atoi(dash);
+
+						value = colon;
+					}
+
+					/* now's time to call the test */
+					printf("Running test '%s'\n", test_names[idx].name);
+					err = test_names[idx].func(min, max);
+					ret += err;
+					printf("Errors during this test: %d\n\n", err);
+				} while (colon && *colon);
+			} else
+				printf("Ignoring unknown test name '%s'\n", test);
+
+			test = comma;
+		} while (test && *test);
+	} else {
+		/* no test mentioned, run everything */
+		for (idx = 0; test_names[idx].name; idx++) {
+			printf("Running test '%s'\n", test_names[idx].name);
+			err = test_names[idx].func(min, max);
+			ret += err;
+			printf("Errors during this test: %d\n\n", err);
+		}
+	}
+
 	printf("Total number of errors: %d\n", ret);
 	printf("Exiting with status %d\n", !!ret);
 	return !!ret;
-- 
2.31.1.189.g2e36527f23

