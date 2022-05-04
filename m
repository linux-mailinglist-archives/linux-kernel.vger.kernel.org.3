Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3895197E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiEDHNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiEDHN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:13:28 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC7222BEF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:09:52 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id ga27-20020a1709070c1b00b006f43c161da4so365635ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 00:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BHgM80QXnuHmX9P5lL3WDnID4JQ8ZgL0PARUx1Pn86E=;
        b=MPZFS7xdKawfaKhV3qj1OmMocUZTDTIWrMi3WjVPS3ns9TT9URP16/9iG3gQui7/W6
         mFW6Fq/ON0yH8u2u3A0PR+hHtyLm3Bj15+b6uVvNl53tPovjF66/aOFYWYbw3UqTSftq
         6VzR/qh7MVf8j9xGvIf2kjpGOitqkI+fa7Z5jBokJbJXSZRK4Wzwfi5Dy+xNLADFbo1X
         OKM+fE37kd4ifq6gGiPyz0U8AwoZASPskRNgBdPY8mTc+X5kPRmwfECrR2bS87exPN95
         I4nnLzMTaLZOBxuyyTKCBn1/7ezaK4ifqF/LFYZf02qz/okqEDp7C5pED60NSiDl0tQx
         eWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BHgM80QXnuHmX9P5lL3WDnID4JQ8ZgL0PARUx1Pn86E=;
        b=xilUf/wsA/pLwJGtTVDs5tuceLaAvpy8TQ9FvUZf1S4qfm2t7r5zL/7ZL72jPnUmrT
         wKh0u8jalZdmXVoTArhqcDo/vybcmV0HY3MgOpOgXNo8jjATcLW2JOAwJE6wyS/EXR50
         V6qzKly69LqkebuIJlUMuQ1rjzWa8YnuHNSNSj6dZrWHk0L7udmhCgjDxDisey4tXEhM
         ryFiFXo2zW/QETqoTXYbHenZTWSBeyWgT/THFm6q1Dozu2zw0iK+9OOPaPSKRDl+r0ON
         GtzVMkKHOliyp7dNHj5vpdyw23JcVii9oo/3FAQhaQgEqJviUG0oizLK6dwcMD5HUQiZ
         SRbA==
X-Gm-Message-State: AOAM531s8wHW6rplGKJan1IhWMQmMPXwilSr5rZa0vitTy+7a/ttbeZL
        2kFwjX85QmotY/ZjWbzw/vmoExzKuw==
X-Google-Smtp-Source: ABdhPJxHjGxx3R0R7hVeANsqm89vrY1O60owtCj/9jc0r5vNxFRM95HqtxMLq/W3NieUpkw7VLZX/mygUA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:83ae:6c38:682:3ca2])
 (user=elver job=sendgmr) by 2002:a17:907:3f1d:b0:6f4:ce49:52ea with SMTP id
 hq29-20020a1709073f1d00b006f4ce4952eamr492865ejc.47.1651648190858; Wed, 04
 May 2022 00:09:50 -0700 (PDT)
Date:   Wed,  4 May 2022 09:09:41 +0200
Message-Id: <20220504070941.2798233-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH -kselftest/kunit] kcsan: test: use new suite_{init,exit} support
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly added suite_{init,exit} support for suite-wide init and
cleanup. This avoids the unsupported method by which the test used to do
suite-wide init and cleanup (avoiding issues such as missing TAP
headers, and possible future conflicts).

Signed-off-by: Marco Elver <elver@google.com>
---
This patch should go on the -kselftest/kunit branch, where this new
support currently lives, including a similar change to the KFENCE test.
---
 kernel/kcsan/kcsan_test.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index a36fca063a73..59560b5e1d9c 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1565,14 +1565,6 @@ static void test_exit(struct kunit *test)
 	torture_cleanup_end();
 }
 
-static struct kunit_suite kcsan_test_suite = {
-	.name = "kcsan",
-	.test_cases = kcsan_test_cases,
-	.init = test_init,
-	.exit = test_exit,
-};
-static struct kunit_suite *kcsan_test_suites[] = { &kcsan_test_suite, NULL };
-
 __no_kcsan
 static void register_tracepoints(struct tracepoint *tp, void *ignore)
 {
@@ -1588,11 +1580,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
 		tracepoint_probe_unregister(tp, probe_console, NULL);
 }
 
-/*
- * We only want to do tracepoints setup and teardown once, therefore we have to
- * customize the init and exit functions and cannot rely on kunit_test_suite().
- */
-static int __init kcsan_test_init(void)
+static int kcsan_suite_init(struct kunit_suite *suite)
 {
 	/*
 	 * Because we want to be able to build the test as a module, we need to
@@ -1600,18 +1588,25 @@ static int __init kcsan_test_init(void)
 	 * won't work here.
 	 */
 	for_each_kernel_tracepoint(register_tracepoints, NULL);
-	return __kunit_test_suites_init(kcsan_test_suites);
+	return 0;
 }
 
-static void kcsan_test_exit(void)
+static void kcsan_suite_exit(struct kunit_suite *suite)
 {
-	__kunit_test_suites_exit(kcsan_test_suites);
 	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
 	tracepoint_synchronize_unregister();
 }
 
-late_initcall_sync(kcsan_test_init);
-module_exit(kcsan_test_exit);
+static struct kunit_suite kcsan_test_suite = {
+	.name = "kcsan",
+	.test_cases = kcsan_test_cases,
+	.init = test_init,
+	.exit = test_exit,
+	.suite_init = kcsan_suite_init,
+	.suite_exit = kcsan_suite_exit,
+};
+
+kunit_test_suites(&kcsan_test_suite);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Marco Elver <elver@google.com>");
-- 
2.36.0.464.gb9c8b46e94-goog

