Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6467F5A9F98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiIATKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiIATJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:09:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9165B3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:09:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q3so14815843pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rmhnaxQfwN1McE4B6m4Z6oqL1MRBI2ssnsG/A4hbweI=;
        b=E5MyDImbdL8E/T862MbS3GPy8IndR86HbVZO+HTuE2qenj8Ij1hGVD0qOgX+iJAQ9C
         RJun2L/ro45JuctTlr69CDBjQgT2B5zXgMli9zoFHR7Upifgl+ZutOM7qFYtGnfEDQDL
         S7un5iXyXJPp/2w9DdwsweQWkC/NriFrQU5q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rmhnaxQfwN1McE4B6m4Z6oqL1MRBI2ssnsG/A4hbweI=;
        b=XJYR0AxfAx8uX+hyvptP+rfqzJfbMvIgDEjyyTou2T4HlL4Icb/65Vo8xjliBTLbLq
         7e6uEAh9VqZ6B4g2ptcr/WO9dm04Tbwshmfev2xeM7a5cIdsZ27PvoK62axwBE7X803R
         +/FhIWCzwX3k5YG8IcUHkjw7cYpR9fDYslXN+PZjCdW0mmLTniRRAAz6W1U16Nt4l3Ad
         2kgTzyHNQ0YHKj1NrEbpXgGfpUlcK+zD/mq/51io4y7Lv1EeVyVNZi/Rs3qJJS5I2muf
         t+GZOMrQeVHcWvxQ0IKiUJu5vEVvmVYvNb7oIicPJYtuyBebSnrIcwK3cgca4DtFZa5d
         oy9A==
X-Gm-Message-State: ACgBeo3xtJm6dczbtLqqavdR9IsF4rcBJTK5Y4no2X+bU3iVOPWqsoG+
        0qfLoCX5hgA6NTKJuTtTMW6tpw==
X-Google-Smtp-Source: AA6agR7tJ/cbV52rdYs3d2bZ07wOzydTl7VLmGdNX7pIOkk2dCEOIYb1ZWPq/BbE3Tp794QSwfOYKQ==
X-Received: by 2002:a17:90b:2496:b0:1ef:a94:7048 with SMTP id nt22-20020a17090b249600b001ef0a947048mr626469pjb.244.1662059394673;
        Thu, 01 Sep 2022 12:09:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t20-20020a62d154000000b0052dbad1ea2esm13685785pfl.6.2022.09.01.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:09:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] string: Introduce strtomem() and strtomem_pad()
Date:   Thu,  1 Sep 2022 12:09:52 -0700
Message-Id: <20220901190952.2229696-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10264; h=from:subject; bh=u0Wr8M6AT07QJos7oxfIVjMj8ajuDyzF1jmHlbzlirs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEQOAmYjTS71e0epMnCq0v8rFPmeBlr1KIn2pg4cB X/IwMByJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxEDgAAKCRCJcvTf3G3AJua0D/ 9UdsHrVqL+qP3/3ynvjxBpXXV6wW65Jj0Dkbhz2bkaHur4hSlyxcxsniuVg9HaS5U0s/o5G6cjhfOW IRfBw9bPdKZV3CXO/5pdxtJ4D2iZS2qBYglxai5pTcSmW9g2wsGLvTWlbYthKr9DYjpbK4XnX84eyH RhjH8KLtXnpIq2xPxkCHdhJcrl6adLeh5+1Q+6l6B9ljKZ8hcslWyuY+fSt9k9N4taarbPlnZbgn2H B3mzqbnNpDJkqp8VejVXObt/AKa0oeC74Dh/Ky4/OwcvllUTeRdLD/aeRUKV6WBWmgRwyF89rHJeus Y8tJPdanL9YzSUC+gjhPGCNHBbgcrxXa5A9i+T9dYUuyB5tPuj5PPUuJ8JcZhEoGD+/uJyJRNeMllv aIWukbgGzx1/mX9E35ZJK6XubxrCc6FbcRvSnji4kuR8DlfvU046Gurk4O1AfYJmoCXKvfIntmnRSH Gaq85av/eQPk0mSQblBejEpcv6N10rockW4GWUgiLbooiK5ackbV8hMHqXOiJvZH79M3W954wpGDlD AHe45rsnGcm3gXou9881eQ7+vxK3o1wWwbIGu+xgj7VIgC5RBejGHMxepNMHRilM1HovGZ/o1/6NGt Mzr0aqK885opJbuBIa6DhWXH4ZWvYjlbQ/J8bMdkayB8xvtYs3sbSYycNsSA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the "legitimate" uses of strncpy() is copying a NUL-terminated
string into a fixed-size non-NUL-terminated character array. To avoid
the weaknesses and ambiguity of intent when using strncpy(), provide
replacement functions that explicitly distinguish between trailing
padding and not, and require the destination buffer size be discoverable
by the compiler.

For example:

struct obj {
	int foo;
	char small[4] __nonstring;
	char big[8] __nonstring;
	int bar;
};

struct obj p;

/* This will truncate to 4 chars with no trailing NUL */
strncpy(p.small, "hello", sizeof(p.small));
/* p.small contains 'h', 'e', 'l', 'l' */

/* This will NUL pad to 8 chars. */
strncpy(p.big, "hello", sizeof(p.big));
/* p.big contains 'h', 'e', 'l', 'l', 'o', '\0', '\0', '\0' */

When the "__nonstring" attributes are missing, the intent of the
programmer becomes ambiguous for whether the lack of a trailing NUL
in the p.small copy is a bug. Additionally, it's not clear whether
the trailing padding in the p.big copy is _needed_. Both cases
become unambiguous with:

strtomem(p.small, "hello");
strtomem_pad(p.big, "hello", 0);

See also https://github.com/KSPP/linux/issues/90

Expand the memcpy KUnit tests to include these functions.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - updated deprecated.rst to include strtomem*()
 - added kerndoc and replacement table to strncpy()
 - switched to ULONG_MAX in KUnit tests (Geert)
 - fix typo in commit log example (Geert)
v1: https://lore.kernel.org/lkml/20220831230006.1016236-1-keescook@chromium.org
---
 Documentation/process/deprecated.rst | 11 +++---
 include/linux/fortify-string.h       | 30 ++++++++++++++++
 include/linux/string.h               | 43 ++++++++++++++++++++++
 lib/memcpy_kunit.c                   | 53 ++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index a6e36d9c3d14..783b0488cf4d 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -138,17 +138,20 @@ be NUL terminated. This can lead to various linear read overflows and
 other misbehavior due to the missing termination. It also NUL-pads
 the destination buffer if the source contents are shorter than the
 destination buffer size, which may be a needless performance penalty
-for callers using only NUL-terminated strings. The safe replacement is
+for callers using only NUL-terminated strings.
+
+When the destination is required to be NUL-terminated, the replacement is
 strscpy(), though care must be given to any cases where the return value
 of strncpy() was used, since strscpy() does not return a pointer to the
 destination, but rather a count of non-NUL bytes copied (or negative
 errno when it truncates). Any cases still needing NUL-padding should
 instead use strscpy_pad().
 
-If a caller is using non-NUL-terminated strings, strncpy() can
-still be used, but destinations should be marked with the `__nonstring
+If a caller is using non-NUL-terminated strings, strtomem() should be
+be used, and the destinations should be marked with the `__nonstring
 <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
-attribute to avoid future compiler warnings.
+attribute to avoid future compiler warnings. For cases still needing
+NUL-padding, strtomem_pad() can be used.
 
 strlcpy()
 ---------
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 3b401fa0f374..eed2119b23c5 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -77,6 +77,36 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define POS	__pass_object_size(1)
 #define POS0	__pass_object_size(0)
 
+/** strncpy - Copy a string to memory with non-guaranteed NUL padding
+ *
+ * @p: pointer to destination of copy
+ * @q: pointer to NUL-terminated source string to copy
+ * @size: bytes to write at @p
+ *
+ * If strlen(@q) >= @size, the copy of @q will stop after @size bytes,
+ * and @p will NOT be NUL-terminated
+ *
+ * If strlen(@q) < @size, following the copy of @q, trailing NUL bytes
+ * will be written to @p until @size total bytes have been written.
+ *
+ * Do not use this function. While FORTIFY_SOURCE tries to avoid
+ * over-reads of @q, it cannot defend against writing unterminated
+ * results to @p. Using strncpy() remains ambiguous and fragile.
+ * Instead, please choose an alternative, so that the expectation
+ * of @p's contents is unambiguous:
+ *
+ * @p needs to be:     | padded to @size | not padded
+ * --------------------+-----------------+------------+
+ *      NUL-terminated | strscpy_pad()   | strscpy()  |
+ * --------------------+-----------------+------------+
+ *  not NUL-terminated | strtomem_pad()  | strtomem() |
+ * --------------------+-----------------+------------+
+ *
+ * Note strscpy*()'s differing return values for detecting truncation,
+ * and strtomem*()'s expectation that the destination is marked with
+ * __nonstring when it is a character array.
+ *
+ */
 __FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
 char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 {
diff --git a/include/linux/string.h b/include/linux/string.h
index 61ec7e4f6311..cf7607b32102 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -260,6 +260,49 @@ static inline const char *kbasename(const char *path)
 void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
 		    int pad);
 
+/**
+ * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
+ *
+ * @dest: Pointer of destination character array (marked as __nonstring)
+ * @src: Pointer to NUL-terminated string
+ * @pad: Padding character to fill any remaining bytes of @dest after copy
+ *
+ * This is a replacement for strncpy() uses where the destination is not
+ * a NUL-terminated string, but with bounds checking on the source size, and
+ * an explicit padding character. If padding is not required, use strtomem().
+ *
+ * Note that the size of @dest is not an argument, as the length of @dest
+ * must be discoverable by the compiler.
+ */
+#define strtomem_pad(dest, src, pad)	do {				\
+	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+									\
+	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
+		     _dest_len == (size_t)-1);				\
+	memcpy_and_pad(dest, _dest_len, src, strnlen(src, _dest_len), pad); \
+} while (0)
+
+/**
+ * strtomem - Copy NUL-terminated string to non-NUL-terminated buffer
+ *
+ * @dest: Pointer of destination character array (marked as __nonstring)
+ * @src: Pointer to NUL-terminated string
+ *
+ * This is a replacement for strncpy() uses where the destination is not
+ * a NUL-terminated string, but with bounds checking on the source size, and
+ * without trailing padding. If padding is required, use strtomem_pad().
+ *
+ * Note that the size of @dest is not an argument, as the length of @dest
+ * must be discoverable by the compiler.
+ */
+#define strtomem(dest, src)	do {					\
+	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+									\
+	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
+		     _dest_len == (size_t)-1);				\
+	memcpy(dest, src, min(_dest_len, strnlen(src, _dest_len)));	\
+} while (0)
+
 /**
  * memset_after - Set a value after a struct member to the end of a struct
  *
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 62f8ffcbbaa3..598f5f7dadf4 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -272,10 +272,63 @@ static void memset_test(struct kunit *test)
 #undef TEST_OP
 }
 
+static void strtomem_test(struct kunit *test)
+{
+	static const char input[] = "hi";
+	static const char truncate[] = "this is too long";
+	struct {
+		unsigned long canary1;
+		unsigned char output[sizeof(unsigned long)] __nonstring;
+		unsigned long canary2;
+	} wrap;
+
+	memset(&wrap, 0xFF, sizeof(wrap));
+	KUNIT_EXPECT_EQ_MSG(test, wrap.canary1, ULONG_MAX,
+			    "bad initial canary value");
+	KUNIT_EXPECT_EQ_MSG(test, wrap.canary2, ULONG_MAX,
+			    "bad initial canary value");
+
+	/* Check unpadded copy leaves surroundings untouched. */
+	strtomem(wrap.output, input);
+	KUNIT_EXPECT_EQ(test, wrap.canary1, ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
+	KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
+	for (int i = 2; i < sizeof(wrap.output); i++)
+		KUNIT_EXPECT_EQ(test, wrap.output[i], 0xFF);
+	KUNIT_EXPECT_EQ(test, wrap.canary2, ULONG_MAX);
+
+	/* Check truncated copy leaves surroundings untouched. */
+	memset(&wrap, 0xFF, sizeof(wrap));
+	strtomem(wrap.output, truncate);
+	KUNIT_EXPECT_EQ(test, wrap.canary1, ULONG_MAX);
+	for (int i = 0; i < sizeof(wrap.output); i++)
+		KUNIT_EXPECT_EQ(test, wrap.output[i], truncate[i]);
+	KUNIT_EXPECT_EQ(test, wrap.canary2, ULONG_MAX);
+
+	/* Check padded copy leaves only string padded. */
+	memset(&wrap, 0xFF, sizeof(wrap));
+	strtomem_pad(wrap.output, input, 0xAA);
+	KUNIT_EXPECT_EQ(test, wrap.canary1, ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
+	KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
+	for (int i = 2; i < sizeof(wrap.output); i++)
+		KUNIT_EXPECT_EQ(test, wrap.output[i], 0xAA);
+	KUNIT_EXPECT_EQ(test, wrap.canary2, ULONG_MAX);
+
+	/* Check truncated padded copy has no padding. */
+	memset(&wrap, 0xFF, sizeof(wrap));
+	strtomem(wrap.output, truncate);
+	KUNIT_EXPECT_EQ(test, wrap.canary1, ULONG_MAX);
+	for (int i = 0; i < sizeof(wrap.output); i++)
+		KUNIT_EXPECT_EQ(test, wrap.output[i], truncate[i]);
+	KUNIT_EXPECT_EQ(test, wrap.canary2, ULONG_MAX);
+}
+
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
 	KUNIT_CASE(memmove_test),
+	KUNIT_CASE(strtomem_test),
 	{}
 };
 
-- 
2.34.1

