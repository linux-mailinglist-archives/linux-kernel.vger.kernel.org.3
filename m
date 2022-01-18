Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4684930E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiARWfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350042AbiARWfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:35:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D39C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:35:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e130-20020a255088000000b006126feb051eso941625ybb.18
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tSyDUU2qe6GiQYXnVQVFIIOoNjQpGjnA4HyYPexSfSc=;
        b=h3U/e4WQj8w+C8SvDpVUPh+f64S7zVFg1c9nYRh4hM5j7lKoFCzCNjZsYVbP9Hm9km
         KyZxl+qU1ZhxTh+g5sr3BMjBtMSRffsM2q3R3+9uXR42ZdBX0XJj1RzpmVJHNz0M9c/X
         Hw9Z7djRbrfJQhoPZDO+2jpLS/PQUFpHK9w+Wt/jUOmJETzSFitHFp7knnV4JTh/PEdX
         v97UNP3pVAseCgRBeoMPTqLj28sWtGi0YN97JqAyzuqZB+1yT1C4BGS+3Vle6uae3LPL
         Ouor81bQdh93t4A0/emeKYzEXXf/b58hDzEXAuCJrvIsdpM3AvzlcvCabm0dVlPJe1YB
         bJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tSyDUU2qe6GiQYXnVQVFIIOoNjQpGjnA4HyYPexSfSc=;
        b=ajOCsc2kiF4zW57QopHXjVObVZjQew5/SXrQCJWSWjcqIbws/KFVUTtTStCpAP4J5B
         Q415DivK5OHp1DaEQ4H2i2ugvnXrfHnE0hZpeBXe8rC7fhEiuUzD50UkwZa+qHc8TpEV
         m+1AHMCpFpVLqGwMZzIeEtgx8ae6VRqAhdyEAvVfweBd8VVndEBNMke2pyumjgyBINqw
         SMfcOCPSOblkni4PpHm4V6hiGyelrbSXt4OeD0RQzbeu9YZ/VU7OahbaK7xj4lrxYNfg
         m6Ne5c+wPmJlGPhGd/hh11WvKtie1Pcc8Tjj7hUgZELjF6o0/X3TJG41JW/lTsEIch6m
         JiRA==
X-Gm-Message-State: AOAM530Zy07AnmK0fa56OecW6X+AR5NP+PlghVNkjRb6wriZO+l2b+/V
        XWFnu6bvSGIq98GZov53jZ9dFz7P79dijg==
X-Google-Smtp-Source: ABdhPJyfcDqWEaPAcKcwRJDC085jVE6aroMlVHnPqPKzO+JnPYGtB6KFOhn3f7/CRkgzJ3Kjm8q0dIkgw6IJSQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a25:7509:: with SMTP id
 q9mr36176959ybc.315.1642545323119; Tue, 18 Jan 2022 14:35:23 -0800 (PST)
Date:   Tue, 18 Jan 2022 14:35:05 -0800
In-Reply-To: <20220118223506.1701553-1-dlatypov@google.com>
Message-Id: <20220118223506.1701553-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 4/5] kunit: decrease macro layering for integer asserts
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a KUNIT_BINARY_INT_ASSERTION for the likes of KUNIT_EXPECT_LT.
This is analagous to KUNIT_BINARY_STR_ASSERTION.

Note: this patch leaves the EQ/NE macros untouched since those share
some intermediate macros for the pointer-based macros.

The current macro chain looks like:
KUNIT_EXPECT_LT_MSG => KUNIT_BASE_LT_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
KUNIT_EXPECT_GT_MSG => KUNIT_BASE_GT_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
<ditto for LE, GE, and ASSERT variants>

After this change:
KUNIT_EXPECT_LT_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
KUNIT_EXPECT_GT_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION

I.e. we've traded all the unique intermediary macros for a single shared
KUNIT_BINARY_INT_ASSERTION. The only difference is that users of
KUNIT_BINARY_INT_ASSERTION also need to pass the operation (==, <, etc.).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 199 +++++++++++--------------------------------
 1 file changed, 51 insertions(+), 148 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index d5dc1ef68bfe..48cf520b69ce 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -920,77 +920,28 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ...)				       \
-	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, <, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ...)				       \
-	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, <=, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
+#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
 				    assert_type,			       \
 				    left,				       \
 				    right,				       \
 				    fmt,				       \
-				    ...)				       \
-	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, >, right,			       \
-				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
+#define KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left,				       \
+				   op,					       \
+				   right,				       \
+				   fmt,					       \
 				    ...)				       \
 	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, >=, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
 				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
 				    assert_type,			       \
-				    left,				       \
-				    right,				       \
+				    left, op, right,			       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
@@ -1034,46 +985,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
 #define KUNIT_BINARY_STR_ASSERTION(test,				       \
 				   assert_type,				       \
 				   left,				       \
@@ -1259,12 +1170,11 @@ do {									       \
 	KUNIT_EXPECT_LT_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, <, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
@@ -1281,12 +1191,11 @@ do {									       \
 	KUNIT_EXPECT_LE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, <=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
@@ -1303,12 +1212,11 @@ do {									       \
 	KUNIT_EXPECT_GT_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, >, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
@@ -1325,12 +1233,11 @@ do {									       \
 	KUNIT_EXPECT_GE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, >=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
@@ -1536,12 +1443,11 @@ do {									       \
 	KUNIT_ASSERT_LT_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, <, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 /**
  * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
  * @test: The test context object.
@@ -1557,12 +1463,11 @@ do {									       \
 	KUNIT_ASSERT_LE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, <=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
@@ -1579,12 +1484,11 @@ do {									       \
 	KUNIT_ASSERT_GT_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, >, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
@@ -1601,12 +1505,11 @@ do {									       \
 	KUNIT_ASSERT_GE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, >=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
-- 
2.34.1.703.g22d0c6ccf7-goog

