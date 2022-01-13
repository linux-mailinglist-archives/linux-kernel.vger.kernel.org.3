Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEF148DC64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiAMRAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiAMQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:59:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B54C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:59:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e18-20020a255012000000b00611b9fa7078so5465586ybb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v3PPhP3uVEfd/KOYr8YIKy5+IlECtDSlMkBa+ZKkSZU=;
        b=Wa/obs6dUVxI/f3FfSJi9Q/YYpyuA8jddW6ibazM0YOF2eBNVHnyCbGHWCuEK+BLPz
         iCHH6Ak2ziyApjtUmmpAnrXxosl4OIRoAp0yzbSuQ3r7rvviWVhGX3lK6dx37FUH/Zz/
         +qyVR0NP/zahjaA+7Y7hSpgx0fhy1jdNRS0vduPjeOeIOVTp6AGlha0v8LO1X95uGVch
         Oj5eEylp+hrKh9fH6tuyIfCkOCl5KqtqCTae7F1wYmi84zOmZLyDRxSIIVYaJkY/zAwM
         ayZtzJibBr0MrQjEwwZg7Nxc5eIzHBeH0UV8SMQ0hmDRbdS9V3fZw8H+EjrBgWeoNwQk
         wZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v3PPhP3uVEfd/KOYr8YIKy5+IlECtDSlMkBa+ZKkSZU=;
        b=otIGrLVb4uT4TyO8vaaAzXeLxYdt7vAu2g+3i36UKYeLCEVKxldnvkaTv5kD/7xSin
         Kwym/c4DYHM6Yg+wGT3jiYPQdk4duuoAG+PxVVHJ6zHkX6BChR7sj8mkzs/jhAUt1DO0
         F/n0o421wJwAR0yYufqpwLzPv0pxQMNrs9NBjsQp+o78tzyZeysUhIvC0Bvn1fjpfejD
         3fSoJxJmnpnB8inexrRE77DMzrJ0Nedk63mcz2qdzYUSvBlTQgxeHi9JzoB7WvlqD32W
         K/ieOqNZ7oBkWJZNnkE3X/+cujC/1BmYTS4dK8a0CLIwVat68Q7Lwp2Ur66ommNHMyWF
         AAMA==
X-Gm-Message-State: AOAM533FcUrHnJn38FfL5Ae1XjfN3Ny4/t3Gq899Hlq/ZHfjTHJsGf9Y
        KjnuLF9CGjrkGFhNRNWobxINzYBh259+KA==
X-Google-Smtp-Source: ABdhPJxBopUg1Hwoxwgo+gBUXiZUekN4GiscGmHN1IuLUcLuznNT+y5jLXnaGb/yF65YxsEJgSR34MtdvLAH7Q==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a70:cede:4191:24bc])
 (user=dlatypov job=sendgmr) by 2002:a25:5686:: with SMTP id
 k128mr6389419ybb.14.1642093196899; Thu, 13 Jan 2022 08:59:56 -0800 (PST)
Date:   Thu, 13 Jan 2022 08:59:29 -0800
In-Reply-To: <20220113165931.451305-1-dlatypov@google.com>
Message-Id: <20220113165931.451305-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20220113165931.451305-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v3 4/6] kunit: factor out kunit_base_assert_format() call into kunit_fail()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call this function first thing for all the assertion `format()`
functions.
This is the part that prints the file and line number and assertion type
(EXPECTATION, ASSERTION).

Having it as part of the format functions lets us have the flexibility
to not print that information (or print it differently) for new
assertion types, but I think this we don't need that.

And in the future, we'd like to consider factoring that data (file,
line#, type) out of the kunit_assert struct and into a `static`
variable, as Linus suggested [1], so we'd need to extract it anyways.

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/assert.c | 6 ------
 lib/kunit/test.c   | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index b972bda61c0c..4d9a1295efc7 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -40,7 +40,6 @@ EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
 {
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream, "%pV", &assert->message);
 }
 EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
@@ -52,7 +51,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 
 	unary_assert = container_of(assert, struct kunit_unary_assert, assert);
 
-	kunit_base_assert_format(assert, stream);
 	if (unary_assert->expected_true)
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
@@ -73,7 +71,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
 				  assert);
 
-	kunit_base_assert_format(assert, stream);
 	if (!ptr_assert->value) {
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
@@ -119,7 +116,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
@@ -147,7 +143,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
@@ -187,7 +182,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_str_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3a52c321c280..345a9dd88c27 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -255,6 +255,7 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 		return;
 	}
 
+	kunit_base_assert_format(assert, stream);
 	assert->format(assert, stream);
 
 	kunit_print_string_stream(test, stream);
-- 
2.34.1.703.g22d0c6ccf7-goog

