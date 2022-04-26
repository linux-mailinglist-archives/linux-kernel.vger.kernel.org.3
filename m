Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9435106A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353681AbiDZSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351057AbiDZSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:22:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882DC197F90
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:19:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e4-20020a056902034400b00633691534d5so16583374ybs.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1CXtLzSBvL82PZQ0YMp7opVTudfIiN/XhPTfSqGMA78=;
        b=BhwU0x6S09OF+VKAPRqv0YjM2Eh9AM2nIbZQJFTPuOriIqgw0vS1dh33NIN2DALean
         2PeUKc7cspbxmJOPDKhoFfQVMKM9ULKowZsiMT+tf+JHOVROLBK18fLJTu8riwm/MP3Z
         9Wn4fyCsT6Lk+4UQIBqjtfEeIguxBKjHOVW6bjg87UrvoOvfCg494WiqPg61VLb5sz3N
         l7X1MzQV7Sk1ZejqgDXTgcK5ZJMDBkz2P4eHfM6QTgpFNN7Z8+LmjVtoAiNfA7rj+dru
         ZYGqP5CxAyUoj+Ncnw3hRTnpSixxp3wV21h4oeaCpzcUEv2SKwLUI0UE8h+S6EGsnDlI
         PmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1CXtLzSBvL82PZQ0YMp7opVTudfIiN/XhPTfSqGMA78=;
        b=OeVWIUJuOrv5qKPAh3derokKY4pjQWOwhO+CDQnloadQABqyq0RHJdYsgFqEmFFhpZ
         7zYhtuuRbG1cN5S3sFw0DxdUUD/a4X9Kqp9vTbhjbE9yPy7U9vJf4YqbpMT8qUO5HTgU
         1JCAQavFo7DeN697xUIsonVPu9u4BPJ2cp9Tea24PWJ1rNG4uaNaUiFc6X/pP7LbPid6
         f8BtDBidGlDcicxT9qgHBlWG5wgDUZqdOqOgjve7TkxrNmyFJHiOWV93U4omTgIgNduh
         vaW3TWIqzbRT6YZtRohjwd/+8/I81psX7rXiSOmE1pMVXGSpQRWOJGE0DywLW0hfEKaj
         A8Vg==
X-Gm-Message-State: AOAM532OZ3/N/sFGh6JPRVNB8OBEs9/WTxo5EXtjFQcL6fANTSL+hQsn
        YH07AZO2xO7F774J0Hn0/+IW7wAmU/vxQQ==
X-Google-Smtp-Source: ABdhPJz5BpVmfi7Mn+azLxfv6jrw+X2+SLKzTFhGUrBCbdTwciRajV7s+Lkosi24FSduY+7LULfuUHBCbcEA5A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:b03d:8d64:4a06:2c5f])
 (user=dlatypov job=sendgmr) by 2002:a25:e606:0:b0:648:402e:598a with SMTP id
 d6-20020a25e606000000b00648402e598amr14246558ybh.170.1650997183848; Tue, 26
 Apr 2022 11:19:43 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:19:23 -0700
In-Reply-To: <20220426181925.3940286-1-dlatypov@google.com>
Message-Id: <20220426181925.3940286-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220426181925.3940286-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 2/3] kunit: add ability to specify suite-level init and exit functions
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit has support for setup/cleanup logic for each test case in a suite.
But it lacks the ability to specify setup/cleanup for the entire suite
itself.

This can be used to do setup that is too expensive or cumbersome to do
for each test.
Or it can be used to do simpler things like log debug information after
the suite completes.
It's a fairly common feature, so the lack of it is noticeable.

Some examples in other frameworks and languages:
* https://docs.python.org/3/library/unittest.html#setupclass-and-teardownclass
* https://google.github.io/googletest/reference/testing.html#Test::SetUpTestSuite

Meta:
This is very similar to this patch here: https://lore.kernel.org/linux-kselftest/20210805043503.20252-3-bvanassche@acm.org/
The changes from that patch:
* pass in `struct kunit *` so users can do stuff like
  `kunit_info(suite, "debug message")`
* makes sure the init failure is bubbled up as a failure
* updates kunit-example-test.c to use a suite init
* Updates kunit/usage.rst to mention the new support
* some minor cosmetic things
  * use `suite_{init,exit}` instead of `{init/exit}_suite`
  * make suite init error message more consistent w/ test init
  * etc.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 19 +++++++++++--------
 include/kunit/test.h                    |  4 ++++
 lib/kunit/kunit-example-test.c          | 14 ++++++++++++++
 lib/kunit/test.c                        | 23 ++++++++++++++++++++---
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 1c83e7d60a8a..d62a04255c2e 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -125,8 +125,8 @@ We need many test cases covering all the unit's behaviors. It is common to have
 many similar tests. In order to reduce duplication in these closely related
 tests, most unit testing frameworks (including KUnit) provide the concept of a
 *test suite*. A test suite is a collection of test cases for a unit of code
-with a setup function that gets invoked before every test case and then a tear
-down function that gets invoked after every test case completes. For example:
+with optional setup and teardown functions that run before/after the whole
+suite and/or every test case. For example:
 
 .. code-block:: c
 
@@ -141,16 +141,19 @@ down function that gets invoked after every test case completes. For example:
 		.name = "example",
 		.init = example_test_init,
 		.exit = example_test_exit,
+		.suite_init = example_suite_init,
+		.suite_exit = example_suite_exit,
 		.test_cases = example_test_cases,
 	};
 	kunit_test_suite(example_test_suite);
 
-In the above example, the test suite ``example_test_suite`` would run the test
-cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``. Each
-would have ``example_test_init`` called immediately before it and
-``example_test_exit`` called immediately after it.
-``kunit_test_suite(example_test_suite)`` registers the test suite with the
-KUnit test framework.
+In the above example, the test suite ``example_test_suite`` would first run
+``example_suite_init``, then run the test cases ``example_test_foo``,
+``example_test_bar``, and ``example_test_baz``. Each would have
+``example_test_init`` called immediately before it and ``example_test_exit``
+called immediately after it. Finally, ``example_suite_exit`` would be called
+after everything else. ``kunit_test_suite(example_test_suite)`` registers the
+test suite with the KUnit test framework.
 
 .. note::
    A test case will only run if it is associated with a test suite.
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 97cd76461886..5d288f3d8f68 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -153,6 +153,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
  * @name:	the name of the test. Purely informational.
+ * @suite_init:	called once per test suite before the test cases.
+ * @suite_exit:	called once per test suite after all test cases.
  * @init:	called before every test case.
  * @exit:	called after every test case.
  * @test_cases:	a null terminated array of test cases.
@@ -167,6 +169,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 struct kunit_suite {
 	const char name[256];
+	int (*suite_init)(struct kunit_suite *suite);
+	void (*suite_exit)(struct kunit_suite *suite);
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 91b1df7f59ed..f8fe582c9e36 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -40,6 +40,17 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This is run once before all test cases in the suite.
+ * See the comment on example_test_suite for more information.
+ */
+static int example_test_init_suite(struct kunit_suite *suite)
+{
+	kunit_info(suite, "initializing suite\n");
+
+	return 0;
+}
+
 /*
  * This test should always be skipped.
  */
@@ -142,17 +153,20 @@ static struct kunit_case example_test_cases[] = {
  * may be specified which runs after every test case and can be used to for
  * cleanup. For clarity, running tests in a test suite would behave as follows:
  *
+ * suite.suite_init(suite);
  * suite.init(test);
  * suite.test_case[0](test);
  * suite.exit(test);
  * suite.init(test);
  * suite.test_case[1](test);
  * suite.exit(test);
+ * suite.suite_exit(suite);
  * ...;
  */
 static struct kunit_suite example_test_suite = {
 	.name = "example",
 	.init = example_test_init,
+	.suite_init = example_test_init_suite,
 	.test_cases = example_test_cases,
 };
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 64ee6a9d8003..b66e395c795a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -192,10 +192,13 @@ EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
 
 static size_t kunit_suite_counter = 1;
 
-static void kunit_print_suite_end(struct kunit_suite *suite)
+static void kunit_print_suite_end(struct kunit_suite *suite, int init_err)
 {
+	enum kunit_status status =
+		init_err ? KUNIT_FAILURE : kunit_suite_has_succeeded(suite);
+
 	kunit_print_ok_not_ok((void *)suite, false,
-			      kunit_suite_has_succeeded(suite),
+			      status,
 			      kunit_suite_counter++,
 			      suite->name,
 			      suite->status_comment);
@@ -497,6 +500,16 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_case *test_case;
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
+	int suite_init_err = 0;
+
+	if (suite->suite_init) {
+		suite_init_err = suite->suite_init(suite);
+		if (suite_init_err != 0) {
+			kunit_err(suite, KUNIT_SUBTEST_INDENT
+				  "# failed to initialize (%d)", suite_init_err);
+			goto suite_end;
+		}
+	}
 
 	kunit_print_suite_start(suite);
 
@@ -551,8 +564,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 		kunit_accumulate_stats(&total_stats, param_stats);
 	}
 
+	if (suite->suite_exit)
+		suite->suite_exit(suite);
+
 	kunit_print_suite_stats(suite, suite_stats, total_stats);
-	kunit_print_suite_end(suite);
+suite_end:
+	kunit_print_suite_end(suite, suite_init_err);
 
 	return 0;
 }
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

