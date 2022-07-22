Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5247B57E52D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiGVRP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiGVRPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:15:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38CA1C93C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:15:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so4089702yba.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fHf/2y2ImS8+g0A88yDniXGhaU3PcBI0GaxEtqPM90E=;
        b=KPDS4nOtrJFuhxfRuEPmu6keOaCejjdI4L8zfS7T8WvzBIjnBggIF903aLC/t2LP2I
         qs0GJzxxwcWZTCyznbQcKz/ax8qo9gJ56zr4JFcCfNbnKmYs80X0u5aOWaETsBaOvvT8
         3/IzwJbrOZvgun8XL9IDlJuQMbyEFAmvkftxX5byvo1sc/ybR4Pq3c2mLdb6pc0vTLdz
         kZOOiE3o/ncmoMtM+hNK40IgNqdjmE6masrljJDeXwk4iJ90u+IX8BmLxcHY2G21QN70
         Rlj4aRmoUo4EeaZq5FBE/DI6V4hlXdPpv6JFEhiOB4VNkJG8Hq8iqZ5BvtKxFULf+UD3
         eJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fHf/2y2ImS8+g0A88yDniXGhaU3PcBI0GaxEtqPM90E=;
        b=mjMbDQgFpbr8XHbEAPbLmIUa57Pp28XcLYYhdhE4VbzUVFc7QnWzY2sWCvRUaCXA2/
         WVOESrGB8XfXVWOyKngIh3NlUybfPYTPk8Ek3pByUX+DpXSXtNjkFfn7/Ite2OaIAHPT
         1BRr47qrRgFG8BagsQbIhSEd05gWb3YPkOmNv6s5d3yFJ9Vca2c+Yd7Ryr5ZirTC93HJ
         NRuru8N8oboCctERyUp/EJD6N19xzPGZPhwaeRsRHLJMUfcLoKmQaP7knm2jA2s2leRg
         AhRA/ILTL92lyBzL5Mg8U42REEf6w1JloUx1oWXaaQnnlkv1xj+wBIneedcwSqJwym6S
         Mv7A==
X-Gm-Message-State: AJIora9ZW/Xe+3dxf0Cgv1uFizhX6E7hO63Jv5FDn0kpE0qn9QeBK7MA
        Eit6I1N3+UWEzMIx6hQHhY6Tskpl3C0r2Q==
X-Google-Smtp-Source: AGRyM1s1MTEqIuf9GSvKTbAzIhLe0gqPi896Xp1NxiIVUp1bME6wgEMhY5v/yecLl67eFteJez0fVHI6FiNpdw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr871017ybq.472.1658510149999; Fri, 22 Jul
 2022 10:15:49 -0700 (PDT)
Date:   Fri, 22 Jul 2022 17:15:32 +0000
In-Reply-To: <20220722171534.3576419-1-dlatypov@google.com>
Message-Id: <20220722171534.3576419-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 3/5] kunit: make kunit_kfree() only work on pointers from
 kunit_malloc() and friends
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

kunit_kfree() exists to clean up allocations from kunit_kmalloc() and
friends early instead of waiting for this to happen automatically at the
end of the test.

But it can be used on *anything* registered with the kunit resource API.

E.g. the last 2 statements are equivalent:
  struct kunit_resource *res = something();
  kfree(res->data);
  kunit_put_resource(res);

The problem is that there could be multiple resources that point to the
same `data`.

E.g. you can have a named resource acting as a pseudo-global variable in
a test. If you point it to data allocated with kunit_kmalloc(), then
calling `kunit_kfree(ptr)` has the chance to delete either the named
resource or to kfree `ptr`.
Which one it does depends on the order the resources are registered as
kunit_kfree() will delete resources in LIFO order.

So this patch restricts kunit_kfree() to only working on resources
created by kunit_kmalloc(). Calling it is therefore guaranteed to free
the memory, not do anything else.

Note: kunit_resource_instance_match() wasn't used outside of KUnit, so
it should be safe to remove from the public interface. It's also
generally dangerous, as shown above, and shouldn't be used.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: no changes
---
 include/kunit/resource.h | 16 ----------------
 lib/kunit/kunit-test.c   |  7 +++++++
 lib/kunit/test.c         | 10 ++++++++--
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index 09c2b34d1c61..cf6fb8f2ac1b 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -300,22 +300,6 @@ typedef bool (*kunit_resource_match_t)(struct kunit *test,
 				       struct kunit_resource *res,
 				       void *match_data);
 
-/**
- * kunit_resource_instance_match() - Match a resource with the same instance.
- * @test: Test case to which the resource belongs.
- * @res: The resource.
- * @match_data: The resource pointer to match against.
- *
- * An instance of kunit_resource_match_t that matches a resource whose
- * allocation matches @match_data.
- */
-static inline bool kunit_resource_instance_match(struct kunit *test,
-						 struct kunit_resource *res,
-						 void *match_data)
-{
-	return res->data == match_data;
-}
-
 /**
  * kunit_resource_name_match() - Match a resource with the same name.
  * @test: Test case to which the resource belongs.
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 13d0bd8b07a9..4df0335d0d06 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -161,6 +161,13 @@ static void kunit_resource_test_alloc_resource(struct kunit *test)
 	kunit_put_resource(res);
 }
 
+static inline bool kunit_resource_instance_match(struct kunit *test,
+						 struct kunit_resource *res,
+						 void *match_data)
+{
+	return res->data == match_data;
+}
+
 /*
  * Note: tests below use kunit_alloc_and_get_resource(), so as a consequence
  * they have a reference to the associated resource that they must release
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0fb2771ca03e..82019a78462e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -689,12 +689,18 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
 
+static inline bool kunit_kfree_match(struct kunit *test,
+				     struct kunit_resource *res, void *match_data)
+{
+	/* Only match resources allocated with kunit_kmalloc() and friends. */
+	return res->free == kunit_kmalloc_array_free && res->data == match_data;
+}
+
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
 	struct kunit_resource *res;
 
-	res = kunit_find_resource(test, kunit_resource_instance_match,
-				  (void *)ptr);
+	res = kunit_find_resource(test, kunit_kfree_match, (void *)ptr);
 
 	/*
 	 * Removing the resource from the list of resources drops the
-- 
2.37.1.359.gd136c6c3e2-goog

