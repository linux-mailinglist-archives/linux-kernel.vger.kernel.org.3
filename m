Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E187B4E9DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244676AbiC1Rnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244663AbiC1Rnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:43:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972465152
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:41:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y10-20020a5b0d0a000000b00633b9765410so11381162ybp.18
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aVA4LBHoLKMhMeszpuqgZVuKkHU9fUPyLNppRxS+x30=;
        b=b8YOQWtHZFjqrGpVz0IfM2MOlUS28rXfzIOO4U0z8LH66Q4385DU1RQX9YwULYvE6K
         0D9F85V9xAkc4+ZqL7fi8NvouSXz/3jlk6WawL9tTugRib2gpu5JOO1xmtTSwioct0FJ
         qPJYJIitF4x1jyyKzYDcu0SCR6KYF6hum5wMaLQrciia6QJn1uOtFI/eIQ0/IeO8MjS1
         I38sV1PURryNLMXfXxkY6a/c38NkHdSpYENv/K7Mky3E52xrLTvnKhjOzA2SAFiY9rfh
         loaQhllfxcn5oRwl55dY95LKWOcQqyU9V8dupc8tZQBaix1ONPZaxAR6kJ+sM7v1yGud
         Liwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aVA4LBHoLKMhMeszpuqgZVuKkHU9fUPyLNppRxS+x30=;
        b=E4k9dWvAuQlUC0rI6GGgqjDgRiNbOoY7Qstxq9I8DPpnuyglYobyO+JDeJluTSzhGd
         9cf9izodx2IlidlipCWvM1S9Ub16zahw+igmnzCPiJACCDMbKp/U3RxBb2lF9V9uI/Nk
         0/DkglOEUXp33pYxQ395ERauVLLLSl5DngFRv3hv6L7xUqSCBbQuktYB3EvpFFep+lyX
         okKoLicZDOuiwJ+PVmId6LQHhFRwtm8K+xc61KhM1/0celJ8qkqQwaKztH0HtZ89kXdq
         WktNynEoKcZPvk/p8+yO06qvGeOmkchWScB/ygEjgysISKttAzDXQLSpE6/jw2i97D+H
         CFSg==
X-Gm-Message-State: AOAM5306TGhkXge6Nf6yQOiKtvc4BH2dYon83s3bwfM5g4LEd2wZiqIc
        gDVVVKvpdUlWbWSeFPRA1twiRXpCyU/ZNw==
X-Google-Smtp-Source: ABdhPJwT4e9NZT6ZiqObMlzk2YveWab3+TEkjoa2PYCl3ut5T+4O5QYfGL5wjUYwOtZSqylIRTzMQDjvKoQxvA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:73c:9f0b:d20c:cf44])
 (user=dlatypov job=sendgmr) by 2002:a81:106:0:b0:2d0:e682:8a7a with SMTP id
 6-20020a810106000000b002d0e6828a7amr27046249ywb.257.1648489312013; Mon, 28
 Mar 2022 10:41:52 -0700 (PDT)
Date:   Mon, 28 Mar 2022 10:41:43 -0700
In-Reply-To: <20220328174143.857262-1-dlatypov@google.com>
Message-Id: <20220328174143.857262-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220328174143.857262-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v3 2/2] kunit: split resource API impl from test.c into new resource.c
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

We've split out the declarations from include/kunit/test.h into
resource.h.
This patch splits out the definitions as well for consistency.

A side effect of this is git blame won't properly track history by
default, users need to run
$ git blame -L ,1 -C13 lib/kunit/resource.c

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: add this patch
v2 -> v3: drop trailing \n at end of resource.c
---
 lib/kunit/Makefile   |   1 +
 lib/kunit/resource.c | 125 +++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c     | 116 +--------------------------------------
 3 files changed, 127 insertions(+), 115 deletions(-)
 create mode 100644 lib/kunit/resource.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index c49f4ffb6273..29aff6562b42 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
+					resource.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o \
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
new file mode 100644
index 000000000000..8f8057aad78f
--- /dev/null
+++ b/lib/kunit/resource.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit resource API for test managed resources (allocations, etc.).
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: Daniel Latypov <dlatypov@google.com>
+ */
+
+#include <kunit/resource.h>
+#include <kunit/test.h>
+#include <linux/kref.h>
+
+/*
+ * Used for static resources and when a kunit_resource * has been created by
+ * kunit_alloc_resource().  When an init function is supplied, @data is passed
+ * into the init function; otherwise, we simply set the resource data field to
+ * the data value passed in.
+ */
+int kunit_add_resource(struct kunit *test,
+		       kunit_resource_init_t init,
+		       kunit_resource_free_t free,
+		       struct kunit_resource *res,
+		       void *data)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	res->free = free;
+	kref_init(&res->refcount);
+
+	if (init) {
+		ret = init(res, data);
+		if (ret)
+			return ret;
+	} else {
+		res->data = data;
+	}
+
+	spin_lock_irqsave(&test->lock, flags);
+	list_add_tail(&res->node, &test->resources);
+	/* refcount for list is established by kref_init() */
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kunit_add_resource);
+
+int kunit_add_named_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     struct kunit_resource *res,
+			     const char *name,
+			     void *data)
+{
+	struct kunit_resource *existing;
+
+	if (!name)
+		return -EINVAL;
+
+	existing = kunit_find_named_resource(test, name);
+	if (existing) {
+		kunit_put_resource(existing);
+		return -EEXIST;
+	}
+
+	res->name = name;
+
+	return kunit_add_resource(test, init, free, res, data);
+}
+EXPORT_SYMBOL_GPL(kunit_add_named_resource);
+
+struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
+						    kunit_resource_init_t init,
+						    kunit_resource_free_t free,
+						    gfp_t internal_gfp,
+						    void *data)
+{
+	struct kunit_resource *res;
+	int ret;
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	ret = kunit_add_resource(test, init, free, res, data);
+	if (!ret) {
+		/*
+		 * bump refcount for get; kunit_resource_put() should be called
+		 * when done.
+		 */
+		kunit_get_resource(res);
+		return res;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
+
+void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	list_del(&res->node);
+	spin_unlock_irqrestore(&test->lock, flags);
+	kunit_put_resource(res);
+}
+EXPORT_SYMBOL_GPL(kunit_remove_resource);
+
+int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
+			   void *match_data)
+{
+	struct kunit_resource *res = kunit_find_resource(test, match,
+							 match_data);
+
+	if (!res)
+		return -ENOENT;
+
+	kunit_remove_resource(test, res);
+
+	/* We have a reference also via _find(); drop it. */
+	kunit_put_resource(res);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kunit_destroy_resource);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bca3bf5c15b..0f66c13d126e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -6,10 +6,10 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/resource.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/moduleparam.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
@@ -592,120 +592,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
-/*
- * Used for static resources and when a kunit_resource * has been created by
- * kunit_alloc_resource().  When an init function is supplied, @data is passed
- * into the init function; otherwise, we simply set the resource data field to
- * the data value passed in.
- */
-int kunit_add_resource(struct kunit *test,
-		       kunit_resource_init_t init,
-		       kunit_resource_free_t free,
-		       struct kunit_resource *res,
-		       void *data)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	res->free = free;
-	kref_init(&res->refcount);
-
-	if (init) {
-		ret = init(res, data);
-		if (ret)
-			return ret;
-	} else {
-		res->data = data;
-	}
-
-	spin_lock_irqsave(&test->lock, flags);
-	list_add_tail(&res->node, &test->resources);
-	/* refcount for list is established by kref_init() */
-	spin_unlock_irqrestore(&test->lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kunit_add_resource);
-
-int kunit_add_named_resource(struct kunit *test,
-			     kunit_resource_init_t init,
-			     kunit_resource_free_t free,
-			     struct kunit_resource *res,
-			     const char *name,
-			     void *data)
-{
-	struct kunit_resource *existing;
-
-	if (!name)
-		return -EINVAL;
-
-	existing = kunit_find_named_resource(test, name);
-	if (existing) {
-		kunit_put_resource(existing);
-		return -EEXIST;
-	}
-
-	res->name = name;
-
-	return kunit_add_resource(test, init, free, res, data);
-}
-EXPORT_SYMBOL_GPL(kunit_add_named_resource);
-
-struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
-						    kunit_resource_init_t init,
-						    kunit_resource_free_t free,
-						    gfp_t internal_gfp,
-						    void *data)
-{
-	struct kunit_resource *res;
-	int ret;
-
-	res = kzalloc(sizeof(*res), internal_gfp);
-	if (!res)
-		return NULL;
-
-	ret = kunit_add_resource(test, init, free, res, data);
-	if (!ret) {
-		/*
-		 * bump refcount for get; kunit_resource_put() should be called
-		 * when done.
-		 */
-		kunit_get_resource(res);
-		return res;
-	}
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
-
-void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&test->lock, flags);
-	list_del(&res->node);
-	spin_unlock_irqrestore(&test->lock, flags);
-	kunit_put_resource(res);
-}
-EXPORT_SYMBOL_GPL(kunit_remove_resource);
-
-int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
-			   void *match_data)
-{
-	struct kunit_resource *res = kunit_find_resource(test, match,
-							 match_data);
-
-	if (!res)
-		return -ENOENT;
-
-	kunit_remove_resource(test, res);
-
-	/* We have a reference also via _find(); drop it. */
-	kunit_put_resource(res);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kunit_destroy_resource);
-
 struct kunit_kmalloc_array_params {
 	size_t n;
 	size_t size;
-- 
2.35.1.1021.g381101b075-goog

