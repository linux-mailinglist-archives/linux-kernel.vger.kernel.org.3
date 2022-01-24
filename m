Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06C149A988
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347186AbiAYDXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1320010AbiAYDKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:10:10 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBBBC0604D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:23:45 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id h14so573870plf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZ8p5y9oUNksth/roXssMhpD2f8VzUDdp1g4RYGvHG8=;
        b=FsCf9AlvKVkJ8vsKSKyrDqjwETjKkekMhO6Kx82kDnXILhh8wnEkgA8rH1cdNB5SMX
         FrdiukrD80LHrPIUVzGBpw5K+/bDoJULiZ+Ii5PgOZc0TFkykODA6HJlwsIdrAwp0qQi
         nSDs7Xww9WEzHmMM9BwzjC87gg/LRXabZMEEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZ8p5y9oUNksth/roXssMhpD2f8VzUDdp1g4RYGvHG8=;
        b=Am7uyMIZszL+qoxfl20+EbZd1EhWPIb+lAJqLi8awJTnqz2Zu0zfUYmMnRq3FPo3QX
         w0iFpVQsqxmuuxr+Xz0pSdY3v8V15h2+KzBiM4Zjq90ca79Pv4MER8KCJVUPmZHHPEOH
         Rfz4A1n3l/TpEr3wqcDpQ/H/iVOEO+T9fy3jvlsTN6omJlz2zQSut3k3VFOjG1UhTRnW
         MoHCT/56MUHDdJ3AVjZVIRMCSiynancSTML1ceRk9kwxYUH2L/7/5ki2TGoRRQaiIQb/
         7RjhCN2JoQGzsmL7g6cDn0ZLnJM5k8QdXrOVq2zbBhSJijnjnIA+lXZ2/qJM0sY9A/Wl
         +0fw==
X-Gm-Message-State: AOAM533CEhcoueP6+kP2JdLHTUqTn32pyrrOlOUAyDaaFDEP7lXIDMwK
        zQJD7rrgxbN73z/fPAu3PMGMWA==
X-Google-Smtp-Source: ABdhPJz4sDdLboRXNQJmwtE2APYB1rrDtgI5UwgcQtl4nNvICTIvrtNVg4aNn3dPi+ytuT5ptkWvcg==
X-Received: by 2002:a17:90b:3e81:: with SMTP id rj1mr585788pjb.190.1643066624594;
        Mon, 24 Jan 2022 15:23:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11sm797010pfu.50.2022.01.24.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 15:23:44 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] overflow: Implement size_t saturating arithmetic helpers
Date:   Mon, 24 Jan 2022 15:23:42 -0800
Message-Id: <20220124232342.3113350-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124232342.3113350-1-keescook@chromium.org>
References: <20220124232342.3113350-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13659; h=from:subject; bh=FokG8Ywbbh733yQNUjpTzng9yD1PMKpMSVb/f0rF7jo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh7zT9yHEA8+LTOksjqCQXYTG/bBmAjhBalLvgzHq1 cyxXqk+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYe80/QAKCRCJcvTf3G3AJrm9D/ 9uc1g3UP6axHgkLoGdDJRL4fPTDHdidFXXv8z04Xbh50YitchTxTt31i4DtILhp5E2K0DS9J6bd1pm LRtyiQmyiuaHHOtpf1ovBt9XnOV4rBfHVTddXJuK/eN1ANXadmGjIKBnVOypd/7Z9lWJpZ2wxAr+1t lcsFvu09O8wslWXnzJ42PIwgci6uoED6pPzuinihuOXIzg1DSNzLke6C3uaolmD3VQfZja9Vn8xDS0 UVDqioc+UBdWFEvzP7vEYbZkh+bQmS+ezNWwSGAzbb0R43Qa/0lD16joGgbMJFT9z/NZ83VFrCo45b JphGI2Tta/EGe3P/23nyEmbKBeRzDxHbkcrW7bKFGvxFejkHmbVnf4MwmJX6qU02zZLzxXGPAZpQC2 HjDwv5/s5QDG6I/CCiQVoLELRum1Dt11hlwpm58Z9svLXFbHbJwGF+oL+TynaQK+HAfuFLf5RCwefx +DqxxB+xJOH02b/or3nEBbIn5rV2VEUf/XyAsOiNLXOPT+qsH8bURZvwXO6XPM/g1WIZ15IL9W9619 Y4tUpdSJui4eRs/wRjT9selQbe4LxzBkHBZNhd5uCGILSX7zUHHBIXDZzh03qqUkOTTGSSxbszZblT LUSPSkWajbKkHJf468JzvfsbtvGNFz/eYNuxJn2DbSmhxPPk9eEWJmYO17Qg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to perform more open-coded replacements of common allocation
size arithmetic, the kernel needs saturating (SIZE_MAX) helpers for
multiplication, addition, and subtraction. For example, it is common in
allocators, especially on realloc, to add to an existing size:

    p = krealloc(map->patch,
                 sizeof(struct reg_sequence) * (map->patch_regs + num_regs),
                 GFP_KERNEL);

There is no existing saturating replacement for this calculation, and
just leaving the addition open coded inside array_size() could
potentially overflow as well. For example, an overflow in an expression
for a size_t argument might wrap to zero:

    array_size(anything, something_at_size_max + 1) == 0

Introduce size_mul(), size_add(), and size_sub() helpers that
implicitly promote arguments to size_t and saturated calculations for
use in allocations. With these helpers it is also possible to redefine
array_size(), array3_size(), flex_array_size(), and struct_size() in
terms of the new helpers.

As with the check_*_overflow() helpers, the new helpers use __must_check,
though what is really desired is a way to make sure that assignment is
only to a size_t lvalue. Without this, it's still possible to introduce
overflow/underflow via type conversion (i.e. from size_t to int).
Enforcing this will currently need to be left to static analysis or
future use of -Wconversion.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Len Baker <len.baker@gmx.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst |  20 ++++-
 include/linux/overflow.h             | 110 +++++++++++++++++----------
 lib/test_overflow.c                  |  98 ++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 44 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 388cb19f5dbb..a6e36d9c3d14 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -71,6 +71,9 @@ Instead, the 2-factor form of the allocator should be used::
 
 	foo = kmalloc_array(count, size, GFP_KERNEL);
 
+Specifically, kmalloc() can be replaced with kmalloc_array(), and
+kzalloc() can be replaced with kcalloc().
+
 If no 2-factor form is available, the saturate-on-overflow helpers should
 be used::
 
@@ -91,9 +94,20 @@ Instead, use the helper::
         array usage and switch to a `flexible array member
         <#zero-length-and-one-element-arrays>`_ instead.
 
-See array_size(), array3_size(), and struct_size(),
-for more details as well as the related check_add_overflow() and
-check_mul_overflow() family of functions.
+For other calculations, please compose the use of the size_mul(),
+size_add(), and size_sub() helpers. For example, in the case of::
+
+	foo = krealloc(current_size + chunk_size * (count - 3), GFP_KERNEL);
+
+Instead, use the helpers::
+
+	foo = krealloc(size_add(current_size,
+				size_mul(chunk_size,
+					 size_sub(count, 3))), GFP_KERNEL);
+
+For more details, also see array3_size() and flex_array_size(),
+as well as the related check_mul_overflow(), check_add_overflow(),
+check_sub_overflow(), and check_shl_overflow() family of functions.
 
 simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4669632bd72b..59d7228104d0 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -118,81 +118,94 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 }))
 
 /**
- * array_size() - Calculate size of 2-dimensional array.
- *
- * @a: dimension one
- * @b: dimension two
+ * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
  *
- * Calculates size of 2-dimensional array: @a * @b.
+ * @factor1: first factor
+ * @factor2: second factor
  *
- * Returns: number of bytes needed to represent the array or SIZE_MAX on
- * overflow.
+ * Returns: calculate @factor1 * @factor2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline __must_check size_t array_size(size_t a, size_t b)
+static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(a, b, &bytes))
+	if (check_mul_overflow(factor1, factor2, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
 /**
- * array3_size() - Calculate size of 3-dimensional array.
+ * size_add() - Calculate size_t addition with saturation at SIZE_MAX
  *
- * @a: dimension one
- * @b: dimension two
- * @c: dimension three
- *
- * Calculates size of 3-dimensional array: @a * @b * @c.
+ * @addend1: first addend
+ * @addend2: second addend
  *
- * Returns: number of bytes needed to represent the array or SIZE_MAX on
- * overflow.
+ * Returns: calculate @addend1 + @addend2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline __must_check size_t array3_size(size_t a, size_t b, size_t c)
+static inline size_t __must_check size_add(size_t addend1, size_t addend2)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(a, b, &bytes))
-		return SIZE_MAX;
-	if (check_mul_overflow(bytes, c, &bytes))
+	if (check_add_overflow(addend1, addend2, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
-/*
- * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
- * struct_size() below.
+/**
+ * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
+ *
+ * @minuend: value to subtract from
+ * @subtrahend: value to subtract from @minuend
+ *
+ * Returns: calculate @minuend - @subtrahend, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. For
+ * composition with the size_add() and size_mul() helpers, neither
+ * argument may be SIZE_MAX (or the result with be forced to SIZE_MAX).
+ * The lvalue must be size_t to avoid implicit type conversion.
  */
-static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
+static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(a, b, &bytes))
-		return SIZE_MAX;
-	if (check_add_overflow(bytes, c, &bytes))
+	if (minuend == SIZE_MAX || subtrahend == SIZE_MAX ||
+	    check_sub_overflow(minuend, subtrahend, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
 /**
- * struct_size() - Calculate size of structure with trailing array.
- * @p: Pointer to the structure.
- * @member: Name of the array member.
- * @count: Number of elements in the array.
+ * array_size() - Calculate size of 2-dimensional array.
  *
- * Calculates size of memory needed for structure @p followed by an
- * array of @count number of @member elements.
+ * @a: dimension one
+ * @b: dimension two
  *
- * Return: number of bytes needed or SIZE_MAX on overflow.
+ * Calculates size of 2-dimensional array: @a * @b.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
  */
-#define struct_size(p, member, count)					\
-	__ab_c_size(count,						\
-		    sizeof(*(p)->member) + __must_be_array((p)->member),\
-		    sizeof(*(p)))
+#define array_size(a, b)	size_mul(a, b)
+
+/**
+ * array3_size() - Calculate size of 3-dimensional array.
+ *
+ * @a: dimension one
+ * @b: dimension two
+ * @c: dimension three
+ *
+ * Calculates size of 3-dimensional array: @a * @b * @c.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+#define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
 
 /**
  * flex_array_size() - Calculate size of a flexible array member
@@ -208,7 +221,22 @@ static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define flex_array_size(p, member, count)				\
-	array_size(count,						\
-		    sizeof(*(p)->member) + __must_be_array((p)->member))
+	size_mul(count,							\
+		 sizeof(*(p)->member) + __must_be_array((p)->member))
+
+/**
+ * struct_size() - Calculate size of structure with trailing flexible array.
+ *
+ * @p: Pointer to the structure.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of memory needed for structure @p followed by an
+ * array of @count number of @member elements.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define struct_size(p, member, count)					\
+	size_add(sizeof(*(p)), flex_array_size(p, member, count))
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index cea37ae82615..712fb2351c27 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -594,12 +594,110 @@ static int __init test_overflow_allocation(void)
 	return err;
 }
 
+struct __test_flex_array {
+	unsigned long flags;
+	size_t count;
+	unsigned long data[];
+};
+
+static int __init test_overflow_size_helpers(void)
+{
+	struct __test_flex_array *obj;
+	int count = 0;
+	int err = 0;
+	int var;
+
+#define check_one_size_helper(expected, func, args...)	({	\
+	bool __failure = false;					\
+	size_t _r;						\
+								\
+	_r = func(args);					\
+	if (_r != (expected)) {					\
+		pr_warn("expected " #func "(" #args ") "	\
+			"to return %zu but got %zu instead\n",	\
+			(size_t)(expected), _r);		\
+		__failure = true;				\
+	}							\
+	count++;						\
+	__failure;						\
+})
+
+	var = 4;
+	err |= check_one_size_helper(20,       size_mul, var++, 5);
+	err |= check_one_size_helper(20,       size_mul, 4, var++);
+	err |= check_one_size_helper(0,	       size_mul, 0, 3);
+	err |= check_one_size_helper(0,	       size_mul, 3, 0);
+	err |= check_one_size_helper(6,	       size_mul, 2, 3);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  1);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  3);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX, -3);
+
+	var = 4;
+	err |= check_one_size_helper(9,        size_add, var++, 5);
+	err |= check_one_size_helper(9,        size_add, 4, var++);
+	err |= check_one_size_helper(9,	       size_add, 9, 0);
+	err |= check_one_size_helper(9,	       size_add, 0, 9);
+	err |= check_one_size_helper(5,	       size_add, 2, 3);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  1);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  3);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX, -3);
+
+	var = 4;
+	err |= check_one_size_helper(1,        size_sub, var--, 3);
+	err |= check_one_size_helper(1,        size_sub, 4, var--);
+	err |= check_one_size_helper(1,        size_sub, 3, 2);
+	err |= check_one_size_helper(9,	       size_sub, 9, 0);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 9, -3);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 0, 9);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 2, 3);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX,  0);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX, 10);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 0,  SIZE_MAX);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 14, SIZE_MAX);
+	err |= check_one_size_helper(SIZE_MAX - 2, size_sub, SIZE_MAX - 1,  1);
+	err |= check_one_size_helper(SIZE_MAX - 4, size_sub, SIZE_MAX - 1,  3);
+	err |= check_one_size_helper(1,		size_sub, SIZE_MAX - 1, -3);
+
+	var = 4;
+	err |= check_one_size_helper(4 * sizeof(*obj->data),
+				     flex_array_size, obj, data, var++);
+	err |= check_one_size_helper(5 * sizeof(*obj->data),
+				     flex_array_size, obj, data, var++);
+	err |= check_one_size_helper(0, flex_array_size, obj, data, 0);
+	err |= check_one_size_helper(sizeof(*obj->data),
+				     flex_array_size, obj, data, 1);
+	err |= check_one_size_helper(7 * sizeof(*obj->data),
+				     flex_array_size, obj, data, 7);
+	err |= check_one_size_helper(SIZE_MAX,
+				     flex_array_size, obj, data, -1);
+	err |= check_one_size_helper(SIZE_MAX,
+				     flex_array_size, obj, data, SIZE_MAX - 4);
+
+	var = 4;
+	err |= check_one_size_helper(sizeof(*obj) + (4 * sizeof(*obj->data)),
+				     struct_size, obj, data, var++);
+	err |= check_one_size_helper(sizeof(*obj) + (5 * sizeof(*obj->data)),
+				     struct_size, obj, data, var++);
+	err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0);
+	err |= check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
+				     struct_size, obj, data, 1);
+	err |= check_one_size_helper(SIZE_MAX,
+				     struct_size, obj, data, -3);
+	err |= check_one_size_helper(SIZE_MAX,
+				     struct_size, obj, data, SIZE_MAX - 3);
+
+	pr_info("%d overflow size helper tests finished\n", count);
+
+	return err;
+}
+
 static int __init test_module_init(void)
 {
 	int err = 0;
 
 	err |= test_overflow_calculation();
 	err |= test_overflow_shift();
+	err |= test_overflow_size_helpers();
 	err |= test_overflow_allocation();
 
 	if (err) {
-- 
2.30.2

