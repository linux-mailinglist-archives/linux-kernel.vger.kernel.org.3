Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57865A8948
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiHaXAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHaXAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:00:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821A1C10F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:00:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n8-20020a17090a73c800b001fd832b54f6so755137pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IgOuMiHqWLA2iCcwzMC90AOHlkqa6Cq3GBTuA+o1c04=;
        b=cgEqInqdhqkWTwA/ULnZyBJfp9PEH1eH1PS/lrB6k7j38xAd04wbAyOE3hDOLGpb73
         yvuZBFQPabNJekWPFja+fSKL8kn0ylBXWbjga2gNMJV01pfrbf2sCKnf1ksal1qwohzr
         SePAsk1Xw6TQkeJXPNyOz/B+EDqXeKziBKi/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IgOuMiHqWLA2iCcwzMC90AOHlkqa6Cq3GBTuA+o1c04=;
        b=iuidqZvNzTF8jNgL6ihbC/9e8smrRQ7os8ShgDJDmb/ifNSS9Wyo89URUayACIh3eC
         2LdZQxSyq+PylxvcY6mZUkxl89QKVbK7kZFLUxZI8RNEu8ytWqC/VZxfPO2Myvd4e9yC
         yQucpINfrqYkLqmDK1HuiQZcTxhF+SD9YUSwL+Qq4MXPrrK7aBR2I8izfK1q+0ha8SnC
         F9dWmeM9f1cmCHF2JIt3RwU1f42FUtWr0Cir6M8G9Huyezli2B3rg2esM+5SMJTt1ypU
         +NEvjw5c9Wm6nZUHtjaayoIjBFprdOyWtdS1/7TQBETnIIHqGz8GJV96YqeODS/PjpWk
         4kWg==
X-Gm-Message-State: ACgBeo2nnxAku2ZpKJw7xc8yYR6UmuxuPKXIfLSbwq7OD3fb+vvSOh61
        0phCuXTw/hV+Ul3y/SGFIUn2Ug==
X-Google-Smtp-Source: AA6agR57l3US+hH7GM/zud1YaBiWMN8uo19WOCfQ/nudRuF0PvwE63nfyLkf2gOLab6nHfluLIoUrQ==
X-Received: by 2002:a17:902:ef50:b0:171:516d:d2ce with SMTP id e16-20020a170902ef5000b00171516dd2cemr26799253plx.171.1661986808784;
        Wed, 31 Aug 2022 16:00:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b00536f0370db8sm11461917pfv.212.2022.08.31.16.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:00:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] string: Introduce strtomem() and strtomem_pad()
Date:   Wed, 31 Aug 2022 16:00:06 -0700
Message-Id: <20220831230006.1016236-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6354; h=from:subject; bh=Ue4HVUhSOXTfDoQButwCYFrTeQ1yS7vwdL5Wrzf5M9k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjD+f1Z2wNe+q3+lSij+gO3+HtZWfeC4Dw26NASjKa Ac0QWM6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYw/n9QAKCRCJcvTf3G3AJlypD/ 4tSUG5z6CBMD1PmfA9qgt5vCWC0Oy5ZUOE9czOId6kWQ0ZAvIDCO4Z1vZDp29+RQUftKJOoPqHRuUg BoXKoZ5C8e9GZTCBzlFqdKKETy9Nd1e5bCR7aPWJNU5Vz0ZxaYU+SVvwMMZA+frmVfk+MzwqxNui3U 5gZLORnJ/tQ7TkT6gig9pXHHDkWwkVFMjspZla9WCeIer7gLmzaUMp4Tg9MT/O8X046+zGN1XIqD86 ij6EAdGjSnih9HjHEqxeDQ2fO+s70cKdedFRbZf9XGo0lbA/1ss5C4Ge78P8+7tF2fbX4bYzJns2jf hFi+t7WwW69SYf4bzaLdFM+EA0MnT02aB9owXQWvLdgBajdzx4esJs6tfs/T/XreDNEDq/OroTUbF7 I0bJ4peiMnEbKDU/mg3lDNRJW/AXevXSiHeymwcLIpByLoOVOfjggsXBRohT0aWEAaD2QGaajVnazC MWeNSUVKagqqkZ2L/YCJwrCLTKpEu/8FA6wpZ4quUt03NgT5oX2RDzue5i3wumrbK6BKuecISxns9h 5jhYzhopHMk3+VKZU+SeRGbd2mOwevaVRmEENCQXeM55QmcWY3ABt0+Til1pu1veYmTarb5CeEb7O5 Gp0iEF8OSSUfVu/zq18o6z8zA9GB+hTFD5+bmK9+beJf9wHG66HR4pSz20Tg==
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
strtomem_pad(p.big, "hello");

See also https://github.com/KSPP/linux/issues/90

Expand the memcpy KUnit tests to include these functions.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 43 ++++++++++++++++++++++++++++++++++
 lib/memcpy_kunit.c     | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

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
index 62f8ffcbbaa3..2aeb8643e1b0 100644
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
+	KUNIT_EXPECT_EQ_MSG(test, wrap.canary1, -1UL,
+			    "bad initial canary value");
+	KUNIT_EXPECT_EQ_MSG(test, wrap.canary2, -1UL,
+			    "bad initial canary value");
+
+	/* Check unpadded copy leaves surroundings untouched. */
+	strtomem(wrap.output, input);
+	KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
+	KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
+	KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
+	for (int i = 2; i < sizeof(wrap.output); i++)
+		KUNIT_EXPECT_EQ(test, wrap.output[i], 0xFF);
+	KUNIT_EXPECT_EQ(test, wrap.canary2, -1UL);
+
+	/* Check truncated copy leaves surroundings untouched. */
+	memset(&wrap, 0xFF, sizeof(wrap));
+	strtomem(wrap.output, truncate);
+	KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
+	for (int i = 0; i < sizeof(wrap.output); i++)
+		KUNIT_EXPECT_EQ(test, wrap.output[i], truncate[i]);
+	KUNIT_EXPECT_EQ(test, wrap.canary2, -1UL);
+
+	/* Check padded copy leaves only string padded. */
+	memset(&wrap, 0xFF, sizeof(wrap));
+	strtomem_pad(wrap.output, input, 0xAA);
+	KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
+	KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
+	KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
+	for (int i = 2; i < sizeof(wrap.output); i++)
+		KUNIT_EXPECT_EQ(test, wrap.output[i], 0xAA);
+	KUNIT_EXPECT_EQ(test, wrap.canary2, -1UL);
+
+	/* Check truncated padded copy has no padding. */
+	memset(&wrap, 0xFF, sizeof(wrap));
+	strtomem(wrap.output, truncate);
+	KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
+	for (int i = 0; i < sizeof(wrap.output); i++)
+		KUNIT_EXPECT_EQ(test, wrap.output[i], truncate[i]);
+	KUNIT_EXPECT_EQ(test, wrap.canary2, -1UL);
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

