Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6348806E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiAHBX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiAHBX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:23:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC815C06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 17:23:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e137-20020a25378f000000b0060c1f2f4939so15406859yba.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 17:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HX9u/gX+wulPpUgYABGAfaI/MF3prDzvD4A5ElqjQQA=;
        b=pCJbpOK3Hlj59gurktD7xaUarJdHC4kIFDalfvbWNp7W/OUFUh5EwnS6yznGwOhSiM
         3RYsuBZcBVqbwyplSu5S6uX3rFkzBkc2WXrZP9BnzgSEbeQGqiYaOqsB/nKJIyUnzAsA
         crbr29iYX2niJ2W0cviu+FleBtMHb7EddrxiVrfbuPBDP34Jwnhd/FKaEvtCZYpt9uBz
         gHNVChBqgpycGUnrcF8OP7Iqoo3tiayGmTVPYzJlQ+FxpbcUDw1p8ic3zewDz22KsBRR
         ChLNjlZ+D6HbvxVnO9xbuD6VBW4gNlnR82Q37RNprPkTpC0RkGes3wJ+A/2x6Z3DybOA
         4xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HX9u/gX+wulPpUgYABGAfaI/MF3prDzvD4A5ElqjQQA=;
        b=wZ+ZwzdusaNnWF7cdwBAiUhK9sk8Qvg2zJHeSRZ0kCd0wbL1lE3CVGukH4qP5dKO+l
         v7UiYit2u1bWUuuJ201Pm5B7FyWkwKMABwRu4g4upu4RknafXZoR2xf4o7dayY1scu09
         arjiTx1536zMnCsMH+GrLBQEBSHcBir9lct+Uj9DURQhMmoilU0GhNxriB41a13Rm11+
         9v+VztVk00/DmsHdQGA44oY2JdhBBA6oCCFWWJeHFspyROs7XRWqk4UpvKyXN39eKtKv
         xyCDvcO31FssCL1ki8YGG6A7fnT1ABBOS9CEvgaWm/xST5Vua5PXILIHstB9hIam0gyf
         Cpuw==
X-Gm-Message-State: AOAM531lg6E02nwpzjagoMTyBNlO8Gl9us5y/VY26qZc0t6kdRxAz63W
        SkKRvLdxy4Wdw6kkqDxUfGXs2/RnBufVIQ==
X-Google-Smtp-Source: ABdhPJypEWFmO1LWVEMbx/BDCFVdQsH015D7EuGHNt3chl8VFnUk2wlx0Kf9w/VeGd2S/JoGM4XejJ46yxNarQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bf8a:7e90:eb70:9b2b])
 (user=dlatypov job=sendgmr) by 2002:a25:d105:: with SMTP id
 i5mr79661754ybg.382.1641605006051; Fri, 07 Jan 2022 17:23:26 -0800 (PST)
Date:   Fri,  7 Jan 2022 17:22:59 -0800
In-Reply-To: <20220108012304.1049587-1-dlatypov@google.com>
Message-Id: <20220108012304.1049587-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 1/6] kunit: add example test case showing off all the expect macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, these macros are only really documented near the bottom of
https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html#c.KUNIT_FAIL.

E.g. it's likely someone might just not realize that
KUNIT_EXPECT_STREQ() exists and instead use KUNIT_EXPECT_FALSE(strcmp())
or similar.

This can also serve as a basic smoketest that the KUnit assert machinery
still works for all the macros.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/kunit-example-test.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 51099b0ca29c..182a64c12541 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -69,6 +69,51 @@ static void example_mark_skipped_test(struct kunit *test)
 	/* This line should run */
 	kunit_info(test, "You should see this line.");
 }
+
+/*
+ * This test shows off all the KUNIT_EXPECT macros.
+ */
+static void example_all_expect_macros_test(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, true);
+	KUNIT_EXPECT_FALSE(test, false);
+
+	KUNIT_EXPECT_EQ(test, 1, 1);
+	KUNIT_EXPECT_GE(test, 1, 1);
+	KUNIT_EXPECT_LE(test, 1, 1);
+	KUNIT_EXPECT_NE(test, 1, 0);
+	KUNIT_EXPECT_GT(test, 1, 0);
+	KUNIT_EXPECT_LT(test, 0, 1);
+
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, test);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, NULL);
+	KUNIT_EXPECT_PTR_NE(test, test, NULL);
+
+	KUNIT_EXPECT_STREQ(test, "hi", "hi");
+	KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
+
+	/*
+	 * There are also _MSG variants of all of the above that let you include
+	 * additional text on failure.
+	 */
+	KUNIT_EXPECT_TRUE_MSG(test, true, "msg");
+	KUNIT_EXPECT_FALSE_MSG(test, false, "msg");
+
+	KUNIT_EXPECT_EQ_MSG(test, 1, 1, "msg");
+	KUNIT_EXPECT_GE_MSG(test, 1, 1, "msg");
+	KUNIT_EXPECT_LE_MSG(test, 1, 1, "msg");
+	KUNIT_EXPECT_NE_MSG(test, 1, 0, "msg");
+	KUNIT_EXPECT_GT_MSG(test, 1, 0, "msg");
+	KUNIT_EXPECT_LT_MSG(test, 0, 1, "msg");
+
+	KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, test, "msg");
+	KUNIT_EXPECT_PTR_EQ_MSG(test, NULL, NULL, "msg");
+	KUNIT_EXPECT_PTR_NE_MSG(test, test, NULL, "msg");
+
+	KUNIT_EXPECT_STREQ_MSG(test, "hi", "hi", "msg");
+	KUNIT_EXPECT_STRNEQ_MSG(test, "hi", "bye", "msg");
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -83,6 +128,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_simple_test),
 	KUNIT_CASE(example_skip_test),
 	KUNIT_CASE(example_mark_skipped_test),
+	KUNIT_CASE(example_all_expect_macros_test),
 	{}
 };
 
-- 
2.34.1.575.g55b058a8bb-goog

