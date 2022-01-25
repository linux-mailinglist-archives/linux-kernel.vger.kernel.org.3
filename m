Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BD849BD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiAYVBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiAYVAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB1C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:00:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g67-20020a25db46000000b0061437d5e4b3so34330381ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YqkYYVDUijJb3enq48ycsmLOVpHOJRJtlNPVHl/a/kE=;
        b=ERbVknoX/7khuSeu2cYaF+QDYCtbP9/YcqHP0EUZ+yhCZ0j1lgIKoWCzDHOswd8IxE
         +0doqZ+lCTlwTuqFs1dci1L5vz7xcYz1jCYIG6QdEKL19q+vQlh1pcoshYN5pVfZyder
         igFR0Yo0OnhCit356/pGttpiijk5pWoYAvfZFeEUqDge0/xXQqjjd/6ROP/TMIyO9u3k
         lMdzH1AUXvGk5cJu4n0JIG09I+2cACXebH94EcuVk8z5bmYrSTFoSu2aKIgscqVvjNkE
         rdGgRd4Y7fwSHbeoxGqI5ovgZ09uKGR439vsXksj4MR/B+l97+ERTzrk1ZxPvz4cwrjQ
         DB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YqkYYVDUijJb3enq48ycsmLOVpHOJRJtlNPVHl/a/kE=;
        b=GAzhUyqXEgQ8gNgXmrqHoT2LIQ8vpIqYvoIaONxifVPshyy68ZdfRk9L3iXfhAW8iR
         8dsDAWZUmmdJcYzJZTiHqQGd4wIW3RP5djPQV90cg/ST/tyVW4j79tgte39eswNhl+wO
         vKXZANmJBADoyDgP2i1ACZyV1w5GDWOvjsGy4+Pu7S8DC9ZBq4PGhHPuqOq04I61xsqJ
         xsYYwMujdG4n7pusfo/bGzNrDWkaDsXJIhsAH72rVXFgu9JHwwwe9uMJjQDT7LMcRxLS
         hYRfdgMCAYyanU47I2yrUSHJWaI+o7Lg3h9SJQ4cusXaNlefROli49uU2yNcw4/31rn8
         9Mvg==
X-Gm-Message-State: AOAM533OHuja9k6/+LUuiKgEdnqu8UDGLWRS+8Jcyk6xp8iYUs+5tdVI
        vcKzK5nUGpmS24mphEWXq6gMMMHlT/h7Zg==
X-Google-Smtp-Source: ABdhPJzyU7p3vBAyJSgLqCH5HT94gvPnhEVqtequpsLgKOKdvykA90racC/jC0o6ux2kEMkbSzMNi+8BHz6baA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:ec63:7812:5e4a:c688])
 (user=dlatypov job=sendgmr) by 2002:a25:3b89:: with SMTP id
 i131mr32238446yba.449.1643144429806; Tue, 25 Jan 2022 13:00:29 -0800 (PST)
Date:   Tue, 25 Jan 2022 13:00:10 -0800
In-Reply-To: <20220125210011.3817742-1-dlatypov@google.com>
Message-Id: <20220125210011.3817742-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 2/3] kunit: consolidate KUNIT_INIT_BINARY_ASSERT_STRUCT macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have 2 other versions of KUNIT_INIT_BINARY_ASSERT_STRUCT.
The only differences are that
* the format funcition they pass is different
* the types of left_val/right_val should be different (integral,
pointer, string).

The latter doesn't actually matter since these macros are just plumbing
them along to KUNIT_ASSERTION where they will get type checked.

So combine them all into a single KUNIT_INIT_BINARY_ASSERT_STRUCT that
now also takes the format function as a parameter.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h | 68 +++++++-----------------------------------
 include/kunit/test.h   | 20 +++++++------
 2 files changed, 22 insertions(+), 66 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 0b3704db54b6..649bfac9f406 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -178,23 +178,28 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream);
 
 /**
- * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
- *	&struct kunit_binary_assert.
+ * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a binary assert like
+ *	kunit_binary_assert, kunit_binary_ptr_assert, etc.
+ *
+ * @format_func: a function which formats the assert to a string.
  * @op_str: A string representation of the comparison operator (e.g. "==").
  * @left_str: A string representation of the expression in the left slot.
  * @left_val: The actual evaluated value of the expression in the left slot.
  * @right_str: A string representation of the expression in the right slot.
  * @right_val: The actual evaluated value of the expression in the right slot.
  *
- * Initializes a &struct kunit_binary_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ * Initializes a binary assert like kunit_binary_assert,
+ * kunit_binary_ptr_assert, etc. This relies on these structs having the same
+ * fields but with different types for left_val/right_val.
+ * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
  */
-#define KUNIT_INIT_BINARY_ASSERT_STRUCT(op_str,				       \
+#define KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,			       \
+					op_str,				       \
 					left_str,			       \
 					left_val,			       \
 					right_str,			       \
 					right_val) {			       \
-	.assert = { .format = kunit_binary_assert_format },		       \
+	.assert = { .format = format_func },				       \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
 	.left_value = left_val,						       \
@@ -229,32 +234,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
 				    struct string_stream *stream);
 
-/**
- * KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT() - Initializes a
- *	&struct kunit_binary_ptr_assert.
- * @type: The type (assertion or expectation) of this kunit_assert.
- * @op_str: A string representation of the comparison operator (e.g. "==").
- * @left_str: A string representation of the expression in the left slot.
- * @left_val: The actual evaluated value of the expression in the left slot.
- * @right_str: A string representation of the expression in the right slot.
- * @right_val: The actual evaluated value of the expression in the right slot.
- *
- * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
- */
-#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(op_str,			       \
-					    left_str,			       \
-					    left_val,			       \
-					    right_str,			       \
-					    right_val) {		       \
-	.assert = { .format = kunit_binary_ptr_assert_format },		       \
-	.operation = op_str,						       \
-	.left_text = left_str,						       \
-	.left_value = left_val,						       \
-	.right_text = right_str,					       \
-	.right_value = right_val					       \
-}
-
 /**
  * struct kunit_binary_str_assert - An expectation/assertion that compares two
  *	string values (for example, KUNIT_EXPECT_STREQ(test, foo, "bar")).
@@ -282,29 +261,4 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
 				    struct string_stream *stream);
 
-/**
- * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
- *	&struct kunit_binary_str_assert.
- * @op_str: A string representation of the comparison operator (e.g. "==").
- * @left_str: A string representation of the expression in the left slot.
- * @left_val: The actual evaluated value of the expression in the left slot.
- * @right_str: A string representation of the expression in the right slot.
- * @right_val: The actual evaluated value of the expression in the right slot.
- *
- * Initializes a &struct kunit_binary_str_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
- */
-#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(op_str,			       \
-					    left_str,			       \
-					    left_val,			       \
-					    right_str,			       \
-					    right_val) {		       \
-	.assert = { .format = kunit_binary_str_assert_format },		       \
-	.operation = op_str,						       \
-	.left_text = left_str,						       \
-	.left_value = left_val,						       \
-	.right_text = right_str,					       \
-	.right_value = right_val					       \
-}
-
 #endif /*  _KUNIT_ASSERT_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index bf82c313223b..a93dfb8ff393 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -864,7 +864,7 @@ void kunit_do_failed_assertion(struct kunit *test,
  */
 #define KUNIT_BASE_BINARY_ASSERTION(test,				       \
 				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
+				    format_func,			       \
 				    assert_type,			       \
 				    left,				       \
 				    op,					       \
@@ -879,11 +879,12 @@ do {									       \
 			assert_type,					       \
 			__left op __right,				       \
 			assert_class,					       \
-			ASSERT_CLASS_INIT(#op,				       \
-					  #left,			       \
-					  __left,			       \
-					  #right,			       \
-					  __right),			       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,	       \
+							#op,		       \
+							#left,		       \
+							__left,		       \
+							#right,		       \
+							__right),	       \
 			fmt,						       \
 			##__VA_ARGS__);					       \
 } while (0)
@@ -897,7 +898,7 @@ do {									       \
 				    ...)				       \
 	KUNIT_BASE_BINARY_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    kunit_binary_assert_format,		       \
 				    assert_type,			       \
 				    left, op, right,			       \
 				    fmt,				       \
@@ -912,7 +913,7 @@ do {									       \
 				    ...)				       \
 	KUNIT_BASE_BINARY_ASSERTION(test,				       \
 				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    kunit_binary_ptr_assert_format,	       \
 				    assert_type,			       \
 				    left, op, right,			       \
 				    fmt,				       \
@@ -933,7 +934,8 @@ do {									       \
 			assert_type,					       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
-			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(#op,	       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(kunit_binary_str_assert_format,\
+							#op,		       \
 							#left,		       \
 							__left,		       \
 							#right,		       \
-- 
2.35.0.rc2.247.g8bbb082509-goog

