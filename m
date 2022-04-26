Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63D5106A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351121AbiDZSXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351134AbiDZSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:22:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249D197F95
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:19:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f198b4e2d1so161820267b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pmGguFEnVQZXUniO0qK+xxYCdVnApJ0Srb7572vJ7Dg=;
        b=pybsRBOiqiYAlzMXp0jHWN76469Ajig+vJfI3Nb9HvDU4KSuZlTuibVNq4m+bInuf5
         txLVT4AZgjzSz9vjzUpguxII80F3NWSy7QmgQmXf2tU2YFxEbHMqkXdopTdqrpgFF4B8
         xwyroLevaF1PIWB3Vuhst+GL3jimQFLupSWznScgRLW+xrtw/thXLT2AQbB3ydjAwJO6
         nDELK2r3MqdMQJsACCsM+piK8NmEAMW7vVK0IAnVuS5jH49NMH4UfrG7exmMHFJTPGPQ
         ge1AciuENN8c+CtIKWruy3VmtqoPTv0C9aWq2+n9qX5W2oQ1iQFU6pXkqlWcnxqvWO3F
         n00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pmGguFEnVQZXUniO0qK+xxYCdVnApJ0Srb7572vJ7Dg=;
        b=a911j0kAvfmqtDJ/umRVwzkMVCakVbmuGFiYl4KCjWzWfTkvrF1llEecxE5/7oMdS7
         IhnCNcNp+gCziVQMRBQ4R+LowQuaxsP5m9jfisLBT0wGw0TSlKWYNdBXU1WkVHNuMbAy
         IfFvBtdsitgdhdgv61AYGrE2YWshl79Knd/FeeBEw1EvzWUmNMMZMOL+VKUcqWgYKc0h
         qVMOP7FUpCZkbUTv2D+5vpv5sQc6Nu91ZamkBnHGKulD7UK5il0fLCjKfnci0cHj/U4F
         EBT5CnNiz+bWNdGasYKSrY6WSXqNixI7pKJcbzcdItVED0Kx8cns9zfGEgWMfaxC3mXZ
         fxrA==
X-Gm-Message-State: AOAM5318trZB85UvsIX6ZyExumP+HWPFG5PomJBWTr/mhWhPzyxJ5KlU
        ISmmW+1WDnABwn8OKFApzpnw9i7muWnShQ==
X-Google-Smtp-Source: ABdhPJxhzH+TWPuyp7emwm0mw9vgu336o9A1/GlamB9krBA8VwSxwwkINWt6C1gmiXACaCSI1EXwnx475/Kcdg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:b03d:8d64:4a06:2c5f])
 (user=dlatypov job=sendgmr) by 2002:a5b:38d:0:b0:645:7b27:3b8b with SMTP id
 k13-20020a5b038d000000b006457b273b8bmr21950232ybp.146.1650997186276; Tue, 26
 Apr 2022 11:19:46 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:19:24 -0700
In-Reply-To: <20220426181925.3940286-1-dlatypov@google.com>
Message-Id: <20220426181925.3940286-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220426181925.3940286-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 3/3] kfence: test: use new suite_{init/exit} support, add .kunitconfig
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the kfence test suite could not run via "normal" means since
KUnit didn't support per-suite setup/teardown. So it manually called
internal kunit functions to run itself.
This has some downsides, like missing TAP headers => can't use kunit.py
to run or even parse the test results (w/o tweaks).

Use the newly added support and convert it over, adding a .kunitconfig
so it's even easier to run from kunit.py.

People can now run the test via
$ ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kfence --arch=x86_64
...
[11:02:32] Testing complete. Passed: 23, Failed: 0, Crashed: 0, Skipped: 2, Errors: 0
[11:02:32] Elapsed time: 43.562s total, 0.003s configuring, 9.268s building, 34.281s running

Cc: kasan-dev@googlegroups.com
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 mm/kfence/.kunitconfig  |  6 ++++++
 mm/kfence/kfence_test.c | 31 +++++++++++++------------------
 2 files changed, 19 insertions(+), 18 deletions(-)
 create mode 100644 mm/kfence/.kunitconfig

diff --git a/mm/kfence/.kunitconfig b/mm/kfence/.kunitconfig
new file mode 100644
index 000000000000..f3d65e939bfa
--- /dev/null
+++ b/mm/kfence/.kunitconfig
@@ -0,0 +1,6 @@
+CONFIG_KUNIT=y
+CONFIG_KFENCE=y
+CONFIG_KFENCE_KUNIT_TEST=y
+
+# Additional dependencies.
+CONFIG_FTRACE=y
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 1b50f70a4c0f..96206a4ee9ab 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -826,14 +826,6 @@ static void test_exit(struct kunit *test)
 	test_cache_destroy();
 }
 
-static struct kunit_suite kfence_test_suite = {
-	.name = "kfence",
-	.test_cases = kfence_test_cases,
-	.init = test_init,
-	.exit = test_exit,
-};
-static struct kunit_suite *kfence_test_suites[] = { &kfence_test_suite, NULL };
-
 static void register_tracepoints(struct tracepoint *tp, void *ignore)
 {
 	check_trace_callback_type_console(probe_console);
@@ -847,11 +839,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
 		tracepoint_probe_unregister(tp, probe_console, NULL);
 }
 
-/*
- * We only want to do tracepoints setup and teardown once, therefore we have to
- * customize the init and exit functions and cannot rely on kunit_test_suite().
- */
-static int __init kfence_test_init(void)
+static int kfence_suite_init(struct kunit_suite *suite)
 {
 	/*
 	 * Because we want to be able to build the test as a module, we need to
@@ -859,18 +847,25 @@ static int __init kfence_test_init(void)
 	 * won't work here.
 	 */
 	for_each_kernel_tracepoint(register_tracepoints, NULL);
-	return __kunit_test_suites_init(kfence_test_suites);
+	return 0;
 }
 
-static void kfence_test_exit(void)
+static void kfence_suite_exit(struct kunit_suite *suite)
 {
-	__kunit_test_suites_exit(kfence_test_suites);
 	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
 	tracepoint_synchronize_unregister();
 }
 
-late_initcall_sync(kfence_test_init);
-module_exit(kfence_test_exit);
+static struct kunit_suite kfence_test_suite = {
+	.name = "kfence",
+	.test_cases = kfence_test_cases,
+	.init = test_init,
+	.exit = test_exit,
+	.suite_init = kfence_suite_init,
+	.suite_exit = kfence_suite_exit,
+};
+
+kunit_test_suites(&kfence_test_suite);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>");
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

