Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A147528B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244431AbiEPQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbiEPQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:55:45 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B823D1C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:54:53 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m11-20020a170902f64b00b0015820f8038fso8263231plg.23
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+MVCGYE2y7IQ9KF1Y9iPDzkw2D8l040rm/mqMkZxYig=;
        b=mKJClu0HKRrNlZ2zYdbz8BaxR/mQoLSvaIPcE0MAaAFkDXsZJUEsrZkRdFkDIbC3lL
         mkzKuu/R2DnLlfdZlZHmDKIn/s1moeWstlVxLAmdNCuuFVsefAwG1a989jtBH6TZ+yMD
         /jbl9kTzcW4pFeEqD/TaWw+J5LEeHZqUCpdl+By9KDLTfOy5/lIkagLjt2Dk3eoFSNNm
         nDhXtanRGpHVaLEiDUKN7WW2OnIFJIZgIR9jqaijELDG5HKNaYUpvn0PgV6Er8+00SXl
         0aa8579UTVd6+AhYzHfaHejdE2JADWEnC3xubiS2PMQTVtHs16SNcCVHmJ/7fAvVZ01x
         yLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+MVCGYE2y7IQ9KF1Y9iPDzkw2D8l040rm/mqMkZxYig=;
        b=dM/iQGMHB563/PJ4j6Dk9t+1khNladweMiJoX4m0fjJj2U0su+fQ/0PlGwH+D5H13M
         px6TDo/4AjEFBAUS0Yelg6xq9gNOf2kjvgcEXKbySuH73JH5GeiNH7SLqfs4Ecp2nCjC
         Sz5XQkf2UBg43C8r5cg5NjQQXblYzNkiC9LSBjWbeYVFgRe7lfc5yJueRBwI8E47k80i
         e006JY2IEcFfWznYym16i7c/yM8Vew0bV8KvhlnQ/d3g+GxqgqMiLPI9HNqcvRuxuBSx
         6NEtVpYpPVGQmO6tXGxZSZoDTaAuhANlzRV83wd4DEvQH23madOz482AsaUG+bGBcP8R
         OjEg==
X-Gm-Message-State: AOAM533tjLdgm0MB5hQ4b0rLlVlTfBy7eyLK8HJF43GYR7CcSu9fC1K7
        t7mpkVbwje+fFpN4UtYa8MBWpHbwMHrPdQ==
X-Google-Smtp-Source: ABdhPJzSxByWvyU4YOLXwLwK1gB4iz+w8j9tTU5kfvCa7KBpjRzaXJVqkxo0fscScun+wy2cd6dqfeR7dWkSRA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8f91:3848:5672:cb59])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:9282:b0:1dc:4a1b:ea55 with SMTP
 id n2-20020a17090a928200b001dc4a1bea55mr20307630pjo.24.1652720093182; Mon, 16
 May 2022 09:54:53 -0700 (PDT)
Date:   Mon, 16 May 2022 09:54:46 -0700
Message-Id: <20220516165446.1246262-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] kunit: use kmemdup in kunit_filter_tests(), take suite as const
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        kernel test robot <lkp@intel.com>
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

kmemdup() is easier than kmalloc() + memcpy(), per lkp bot.

Also make the input `suite` as const since we're now always making
copies after commit a127b154a8f2 ("kunit: tool: allow filtering test
cases via glob").

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/executor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 2f73a6a35a7e..43e15112460a 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -55,7 +55,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
 
 /* Create a copy of suite with only tests that match test_glob. */
 static struct kunit_suite *
-kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
+kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
 {
 	int n = 0;
 	struct kunit_case *filtered, *test_case;
@@ -69,11 +69,9 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
 	if (n == 0)
 		return NULL;
 
-	/* Use memcpy to workaround copy->name being const. */
-	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
+	copy = kmemdup(suite, sizeof(*copy), GFP_KERNEL);
 	if (!copy)
 		return ERR_PTR(-ENOMEM);
-	memcpy(copy, suite, sizeof(*copy));
 
 	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
 	if (!filtered)

base-commit: 9660209d9418f2295d31fea0d32e313e9b2c1200
-- 
2.36.0.550.gb090851708-goog

