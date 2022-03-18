Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0694DD4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiCRGva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiCRGv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:51:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EAD1760DD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:50:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o15-20020a17090aac0f00b001c6595a43dbso4331899pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nUaZXQyfVA6LKSUoVjWK+o92l6ePng5lWSLp9pB31r0=;
        b=SDzF1Ke+F1DMWAXTTGR47nu3uPLqhK4gUKma3dNPiMzOTAG6ULypJsiEXJwYhTHCoE
         bnxwVScxoZNGBS8EfhA6gWk7ugqs0SqEdEoWT6sUFre/4ZjOTb0BqyMde7wzGGxtaPhk
         WT3k0eEU76uzzcZN28I9cVxMHazJTObq9fGXibYnQgGVdXZQbdU0DZJbpE580D+NTYjE
         yC4hRh4KNFQq6QBAVMz3blEl3kjI2HMg7jvd+xhvdUAzXtmpGa0BU/Uc5bRMlBWavGHd
         ZUxYyDDXhvADDzgeDpAtBPI7AIDJUAV6ykPqNGE2m58hBqQBeIG6fThXrNfpwKBre/uL
         hf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nUaZXQyfVA6LKSUoVjWK+o92l6ePng5lWSLp9pB31r0=;
        b=XGjzRi/Cnds7tqE3cPikTmUTWxp5gKELoLQNV1uBFH8iIDfKXGYoXtXSQpU92ORWVJ
         mryCTespT++q0ZZc2KXk0SFsKCVZBmDpOFTKf15oR4+CeHeWH1r7cOfdGan1nJUPtsqk
         sKQQGH0cuuU8rPnPM+yp4FiN1a2Tc8A6PMo6ODviFzS7zCIRqZ9O0nuXyppAAP0yuKOb
         xi7Utx9w8nwyLHpKm91FI+amT9hATkAyin1ZHBYz8vkvggY+MH2Tbs8kdL2rOwNGZEji
         piEj4k4ANVmmqJ2eVCL/6sUaix46UKhAMgD52zbb56RKcCdm8aSGTFqoL0x+C96wxNHp
         PH/w==
X-Gm-Message-State: AOAM531zIJdQzkCFKVlltqw1SPSZPkaRLywhO0kggFvN5dR7qKtxpMj0
        2JKWDtpcDd2mB6a0xDhP0u87njj2Vp/Prw==
X-Google-Smtp-Source: ABdhPJxb4sYyfDfH23kEOkweDJutluQ7rle+HcRSjnbVdKbzDKzPdYTCXAu3wwlFVECTmo39dW6ESl88ozSkCA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:db50:b0:1c6:99dd:c40d with SMTP
 id u16-20020a17090adb5000b001c699ddc40dmr5562541pjx.143.1647586209696; Thu,
 17 Mar 2022 23:50:09 -0700 (PDT)
Date:   Fri, 18 Mar 2022 14:49:59 +0800
Message-Id: <20220318064959.3298768-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] kunit: Make kunit_remove_resource() idempotent
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

The kunit_remove_resource() function is used to unlink a resource from
the list of resources in the test, making it no longer show up in
kunit_find_resource().

However, this could lead to a race condition if two threads called
kunit_remove_resource() on the same resource at the same time: the
resource would be removed from the list twice (causing a crash at the
second list_del()), and the refcount for the resource would be
decremented twice (instead of once, for the reference held by the
resource list).

Fix both problems, the first by using list_del_init(), and the second by
checking if the resource has already been removed using list_empty(),
and only decrementing its refcount if it has not.

Also add a KUnit test for the kunit_remove_resource() function which
tests this behaviour.

Reported-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/kunit-test.c | 35 +++++++++++++++++++++++++++++++++++
 lib/kunit/test.c       |  8 ++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 555601d17f79..9005034558aa 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -190,6 +190,40 @@ static void kunit_resource_test_destroy_resource(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
 }
 
+static void kunit_resource_test_remove_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_and_get_resource(
+			&ctx->test,
+			fake_resource_init,
+			fake_resource_free,
+			GFP_KERNEL,
+			ctx);
+
+	/* The resource is in the list */
+	KUNIT_EXPECT_FALSE(test, list_empty(&ctx->test.resources));
+
+	/* Remove the resource. The pointer is still valid, but it can't be
+	 * found.
+	 */
+	kunit_remove_resource(test, res);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+	/* We haven't been freed yet. */
+	KUNIT_EXPECT_TRUE(test, ctx->is_resource_initialized);
+
+	/* Removing the resource multiple times is valid. */
+	kunit_remove_resource(test, res);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+	/* Despite having been removed twice (from only one reference), the
+	 * resource still has not been freed.
+	 */
+	KUNIT_EXPECT_TRUE(test, ctx->is_resource_initialized);
+
+	/* Free the resource. */
+	kunit_put_resource(res);
+	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
+}
+
 static void kunit_resource_test_cleanup_resources(struct kunit *test)
 {
 	int i;
@@ -387,6 +421,7 @@ static struct kunit_case kunit_resource_test_cases[] = {
 	KUNIT_CASE(kunit_resource_test_init_resources),
 	KUNIT_CASE(kunit_resource_test_alloc_resource),
 	KUNIT_CASE(kunit_resource_test_destroy_resource),
+	KUNIT_CASE(kunit_resource_test_remove_resource),
 	KUNIT_CASE(kunit_resource_test_cleanup_resources),
 	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
 	KUNIT_CASE(kunit_resource_test_static),
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bca3bf5c15b..8411cdfe40a8 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -680,11 +680,15 @@ EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
 {
 	unsigned long flags;
+	bool was_linked;
 
 	spin_lock_irqsave(&test->lock, flags);
-	list_del(&res->node);
+	was_linked = !list_empty(&res->node);
+	list_del_init(&res->node);
 	spin_unlock_irqrestore(&test->lock, flags);
-	kunit_put_resource(res);
+
+	if (was_linked)
+		kunit_put_resource(res);
 }
 EXPORT_SYMBOL_GPL(kunit_remove_resource);
 
-- 
2.35.1.894.gb6a874cedc-goog

