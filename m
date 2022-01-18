Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4910C4930E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbiARWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350057AbiARWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:35:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A71C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:35:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x9-20020a25ce09000000b00612eb11922aso1008110ybe.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tnlu6iMT5AOo6ksBK2r/01PAIJqXpT5MvH+Y3uwOVWI=;
        b=RbQvSKG41hFlSgKFjJRM+cxoQsksaXZWagU21kPxbxRLf3ibPdKFv31fBO9doWIbhH
         iwE6JR40etzdhk/VRJomgLf2EhJ4ansOhrEKk0Jbvg0v28bgH5wNqQIQ4SHgxWslZhLK
         wa7BHf8oKAoX87jFPduGPF3cC/Nn9X0VptrXqc/uh7z4pNfsl+23bfkzTX4olTLXh0rD
         84QrbykPcZKYWdLbK3L0bGaXYrUdrVEqMtqtKecIWk0w/cBbiFW27gy0d6Nxl7wqblib
         LW3wI481HwlRow4BQo75zjpoEk9ns9EMe5+pIUcrM6yaRnPU8FExSiJ7U7ej+IcFTv8M
         PTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tnlu6iMT5AOo6ksBK2r/01PAIJqXpT5MvH+Y3uwOVWI=;
        b=rc1+igGBdqko6tMLn/cxq+5/o+AOSHSSSqJrt0ScC74UuGaFRjUeje0JAPCPzL/Xmn
         sBLtl1EWdnUxlqn+fKglTb7veJwwP5PCuZ9eYtvBtPj0qJNwhoovr7I757nluYL9yco6
         Jbn3VkvJ99H6J3AL2mwts18JSwkseeqybEG5z+mzW92XFRZxa76GcZRauaUfNoQpWDzP
         0Jw4exZ6cut1oJJQSMteJ775dpJlbIb6+3cSg//PV79kGKse4T/Ld5CZ1z/p7RB/4XMm
         pq5YwPtT2epptBlQhrdFEQZSAqgUQSRAoA1e9Z0vfARkpsPUHFOk2X3++xt1z7122yfE
         oukg==
X-Gm-Message-State: AOAM533o3u16QIx71ajCQK8myDwGtB2YUZAUBe5/qV6/tITK9T61rCph
        qpdK/+B26kRwtjAWo4hBh80D70kySa5FhQ==
X-Google-Smtp-Source: ABdhPJwyCJPn6NnkVvdWmh4k23mg/Vy9940oUWPfAvESI9EVLW0dnYY3vcQoDlGlgGchbMdZNXbR4hQWfX/Yaw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a25:8b8f:: with SMTP id
 j15mr33935173ybl.585.1642545325480; Tue, 18 Jan 2022 14:35:25 -0800 (PST)
Date:   Tue, 18 Jan 2022 14:35:06 -0800
In-Reply-To: <20220118223506.1701553-1-dlatypov@google.com>
Message-Id: <20220118223506.1701553-6-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 5/5] kunit: decrease macro layering for EQ/NE asserts
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce KUNIT_BINARY_PTR_ASSERTION to match KUNIT_BINARY_INT_ASSERTION
and make KUNIT_EXPECT_EQ and KUNIT_EXPECT_PTREQ use these instead of
shared intermediate macros that only remove the need to type "==" or
"!=".

The current macro chain looks like:
KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
<ditto for NE and ASSERT>

After this change:
KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_ASSERTION => KUNIT_BASE_BINARY_ASSERTION

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 173 ++++++++++++-------------------------------
 1 file changed, 49 insertions(+), 124 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 48cf520b69ce..bf82c313223b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -888,48 +888,6 @@ do {									       \
 			##__VA_ARGS__);					       \
 } while (0)
 
-#define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
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
-				    left, ==, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
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
-				    left, !=, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
 #define KUNIT_BINARY_INT_ASSERTION(test,				       \
 				   assert_type,				       \
 				   left,				       \
@@ -945,43 +903,18 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+#define KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left,				       \
+				   op,					       \
+				   right,				       \
+				   fmt,					       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
 				    kunit_binary_ptr_assert,		       \
 				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
 				    assert_type,			       \
-				    left,				       \
-				    right,				       \
+				    left, op, right,			       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
@@ -1082,12 +1015,11 @@ do {									       \
 	KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
@@ -1104,12 +1036,11 @@ do {									       \
 	KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
-					  KUNIT_EXPECTATION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
@@ -1126,12 +1057,11 @@ do {									       \
 	KUNIT_EXPECT_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
@@ -1148,12 +1078,11 @@ do {									       \
 	KUNIT_EXPECT_PTR_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
-					  KUNIT_EXPECTATION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
@@ -1358,12 +1287,11 @@ do {									       \
 	KUNIT_ASSERT_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
@@ -1379,12 +1307,11 @@ do {									       \
 	KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
-					  KUNIT_ASSERTION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
@@ -1400,12 +1327,11 @@ do {									       \
 	KUNIT_ASSERT_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
@@ -1422,12 +1348,11 @@ do {									       \
 	KUNIT_ASSERT_PTR_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
-					  KUNIT_ASSERTION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 /**
  * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
  * @test: The test context object.
-- 
2.34.1.703.g22d0c6ccf7-goog

