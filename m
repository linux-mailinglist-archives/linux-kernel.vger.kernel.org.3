Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3D4A377B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355629AbiA3QLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355489AbiA3QL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:28 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCD6C06173B;
        Sun, 30 Jan 2022 08:11:27 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id m25so8984577qka.9;
        Sun, 30 Jan 2022 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WqNaKu42S/xjFg/mTc3gwlQdZz2UrnsBgUJqIDmMZb8=;
        b=Y/bO7ihQ+vmwdXY/jATaUghZN+RiNWanfNhXCdtphppbYEAc0nAZA9aiTo8ECWoZK6
         MR1jQH4xsNsaZGEbG7C8t4ku99i+WvSUH+HBNymez1kEATwSd9VRtOdIIQXoBECH3bXk
         sP/VlSVWZR+Ne32yihJNxv0x9fM7fQQ5WvorAdfGF+5cRIwnFQnfP/PqBs9lUZY38Piz
         wEF9sl2mISHQzVf+uqE2wgiAU12AUJYfwZ2ggIDQ65P/7EnULT+Z+fcCSuEM3jPFD8Qi
         3UdvloDolicxJv1AxgVML/7SN/CvXjNlkL+4cTJEucBJ95igtLp/vvz221KWXOr7MKQU
         XwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WqNaKu42S/xjFg/mTc3gwlQdZz2UrnsBgUJqIDmMZb8=;
        b=AvEEs/zJlMCGNGjD5kCfK9ejd/7Zdy+csmwc4OrIC8mWyiwuvfOL/ktHuLPdeUFvGN
         l4aB8XuMLu3lDS9L3Ms6Zckt2rW69d6RWGPgThOQOPo17w7L+x3dre/x9rL26qyvGd63
         0bEpNRAyl8m2VYCzOryel/VgEquqjLOegSMgurEV6gOl+j/RRnu8Z8M6BO2eSaHKLNL9
         gs7f6i7MFcaAReOxlcx9JaTJy0LswI5tdmBOE3JnTuI+VsY1eyH3X+WEjWSrGSYXU4H/
         X+E5rzwXGhAy64iEwxyU43lwrxS1dRQGRLM1WVX4Tnvv77VdYuZtPpDdQ32UG3OE5Krb
         CR1Q==
X-Gm-Message-State: AOAM532FYUrU8HaW4ezDr8PqN0kyKSXxR94JNp7M4Xf3i+6aJrf1khqj
        r595WSjP/26EPfS/f7eOsa4=
X-Google-Smtp-Source: ABdhPJzNbj4p2Zo7mkukzjitR2+YrGm+O98ij0ZZNnxT0VSQuM//zqqWDogfmswc+7kgbDgWnU3qrg==
X-Received: by 2002:a37:a855:: with SMTP id r82mr10811393qke.645.1643559086438;
        Sun, 30 Jan 2022 08:11:26 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:25 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 07/11] iio: test: add basic tests for the iio-rescale driver
Date:   Sun, 30 Jan 2022 11:10:57 -0500
Message-Id: <20220130161101.1067691-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iio-rescale driver supports various combinations of scale types and
offsets. These can often result in large integer multiplications. Make
sure these calculations are done right by adding a set of kunit test
cases that build on top of iio-test-format.

To run these tests, add the following to .kunitconfig
	$ cat .kunitconfig
	CONFIG_IIO=y
	CONFIG_IIO_RESCALE_KUNIT_TEST=y
	CONFIG_KUNIT=y

Then run:
	$ ./tools/testing/kunit/kunit.py run --kunitconfig .kunitconfig

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/test/Kconfig            |  10 +
 drivers/iio/test/Makefile           |   1 +
 drivers/iio/test/iio-test-rescale.c | 711 ++++++++++++++++++++++++++++
 3 files changed, 722 insertions(+)
 create mode 100644 drivers/iio/test/iio-test-rescale.c

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 679a7794af20..872ed4ed140a 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,16 @@
 #
 
 # Keep in alphabetical order
+config IIO_RESCALE_KUNIT_TEST
+	bool "Test IIO rescale conversion functions"
+	depends on KUNIT && !IIO_RESCALE
+	default KUNIT_ALL_TESTS
+	help
+	  If you want to run tests on the iio-rescale code say Y here.
+
+	  This takes advantage of ARCH=um to run tests and should be used by
+	  developers to tests their changes to the rescaling logic.
+
 config IIO_TEST_FORMAT
         bool "Test IIO formatting functions"
         depends on KUNIT=y
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index 467519a2027e..f15ae0a6394f 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -4,5 +4,6 @@
 #
 
 # Keep in alphabetical order
+obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
 obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
 CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
new file mode 100644
index 000000000000..a3bbe2db76d3
--- /dev/null
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kunit tests for IIO rescale conversions
+ *
+ * Copyright (c) 2021 Liam Beguin <liambeguin@gmail.com>
+ */
+
+#include <linux/gcd.h>
+#include <linux/overflow.h>
+#include <linux/units.h>
+
+#include <linux/iio/afe/rescale.h>
+#include <linux/iio/iio.h>
+
+#include <kunit/test.h>
+
+struct rescale_tc_data {
+	const char *name;
+
+	const s32 numerator;
+	const s32 denominator;
+	const s32 offset;
+
+	const int schan_val;
+	const int schan_val2;
+	const int schan_off;
+	const int schan_scale_type;
+
+	const char *expected;
+	const char *expected_off;
+};
+
+const struct rescale_tc_data scale_cases[] = {
+	/*
+	 * Typical use cases
+	 */
+	{
+		.name = "typical IIO_VAL_INT, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT,
+		.schan_val = 42,
+		.expected = "5210.918114143",
+	},
+	{
+		.name = "typical IIO_VAL_INT, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT,
+		.schan_val = 42,
+		.expected = "-5210.918114143",
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 42,
+		.schan_val2 = 20,
+		.expected = "260.545905707",
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 42,
+		.schan_val2 = 20,
+		.expected = "-260.545905707",
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL_LOG2, positive",
+		.numerator = 42,
+		.denominator = 53,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 4096,
+		.schan_val2 = 16,
+		.expected = "0.049528301",
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL_LOG2, negative",
+		.numerator = -42,
+		.denominator = 53,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 4096,
+		.schan_val2 = 16,
+		.expected = "-0.049528301",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456,
+		.expected = "1240.710106203",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456,
+		.expected = "-1240.710106203",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 1234,
+		.expected = "1240.84789",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 1234,
+		.expected = "-1240.84789",
+	},
+	/*
+	 * Use cases with small scales involving divisions
+	 */
+	{
+		.name = "small IIO_VAL_FRACTIONAL, 261/509 scaled by 90/1373754273",
+		.numerator = 261,
+		.denominator = 509,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 90,
+		.schan_val2 = 1373754273,
+		.expected = "0.000000033594",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL, 90/1373754273 scaled by 261/509",
+		.numerator = 90,
+		.denominator = 1373754273,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 261,
+		.schan_val2 = 509,
+		.expected = "0.000000033594",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL, 760/1373754273 scaled by 427/2727",
+		.numerator = 760,
+		.denominator = 1373754273,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 427,
+		.schan_val2 = 2727,
+		.expected = "0.000000086626",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL, 761/1373754273 scaled by 427/2727",
+		.numerator = 761,
+		.denominator = 1373754273,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 427,
+		.schan_val2 = 2727,
+		.expected = "0.000000086740",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL, 5/32768 scaled by 3/10000",
+		.numerator = 5,
+		.denominator = 32768,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 3,
+		.schan_val2 = 10000,
+		.expected = "0.0000000457763671875",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL, 0 < scale < 1",
+		.numerator = 6,
+		.denominator = 6,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 1,
+		.schan_val2 = 3,
+		.expected = "0.3333333333333333",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL, -1 < scale < 0",
+		.numerator = -6,
+		.denominator = 6,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 1,
+		.schan_val2 = 3,
+		.expected = "-0.3333333333333333",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL, 0 < scale < 2",
+		.numerator = 8,
+		.denominator = 2,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 1,
+		.schan_val2 = 3,
+		.expected = "1.3333333333333333",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL, -2 < scale < 0",
+		.numerator = -8,
+		.denominator = 2,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 1,
+		.schan_val2 = 3,
+		.expected = "-1.3333333333333333",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL_LOG2, 760/32768 scaled by 15/22",
+		.numerator = 760,
+		.denominator = 32768,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 15,
+		.schan_val2 = 22,
+		.expected = "0.000000082946",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL_LOG2, 761/32768 scaled by 15/22",
+		.numerator = 761,
+		.denominator = 32768,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 15,
+		.schan_val2 = 22,
+		.expected = "0.000000083055",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL_LOG2, 0 < scale < 1",
+		.numerator = 16,
+		.denominator = 3,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 1,
+		.schan_val2 = 4,
+		.expected = "0.3333333333333333",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL_LOG2, -1 < scale < 0",
+		.numerator = -16,
+		.denominator = 3,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 1,
+		.schan_val2 = 4,
+		.expected = "-0.3333333333333333",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL_LOG2, 0 < scale < 2",
+		.numerator = 8,
+		.denominator = 3,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 1,
+		.schan_val2 = 1,
+		.expected = "1.3333333333333333",
+	},
+	{
+		.name = "small IIO_VAL_FRACTIONAL_LOG2, -2 < scale < 0",
+		.numerator = -8,
+		.denominator = 3,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 1,
+		.schan_val2 = 1,
+		.expected = "-1.3333333333333333",
+	},
+	{
+		.name = "small IIO_VAL_INT_PLUS_MICRO, positive",
+		.numerator = 1,
+		.denominator = 2,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 5,
+		.schan_val2 = 1234,
+		.expected = "2.500617",
+	},
+	{
+		.name = "small IIO_VAL_INT_PLUS_MICRO, negative",
+		.numerator = -1,
+		.denominator = 2,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 5,
+		.schan_val2 = 1234,
+		.expected = "-2.500617",
+	},
+	/*
+	 * INT_PLUS_{MICRO,NANO} positive/negative corner cases
+	 */
+	{
+		.name = "negative IIO_VAL_INT_PLUS_NANO, negative schan",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 123456,
+		.expected = "-1240.710106203",
+	},
+	{
+		.name = "negative IIO_VAL_INT_PLUS_NANO, both negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 123456,
+		.expected = "1240.710106203",
+	},
+	{
+		.name = "negative IIO_VAL_INT_PLUS_NANO, 3 negative",
+		.numerator = -1000000,
+		.denominator = -8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 123456,
+		.expected = "-1240.710106203",
+	},
+	{
+		.name = "negative IIO_VAL_INT_PLUS_NANO, 4 negative",
+		.numerator = -1000000,
+		.denominator = -8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = -123456,
+		.expected = "-1240.710106203",
+	},
+	{
+		.name = "negative IIO_VAL_INT_PLUS_NANO, negative, *val = 0",
+		.numerator = 1,
+		.denominator = -10,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 0,
+		.schan_val2 = 123456789,
+		.expected = "-0.012345678",
+	},
+	/*
+	 * INT_PLUS_{MICRO,NANO} decimal part overflow
+	 */
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "1256.01200856",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "-1256.01200856",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, negative schan",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 123456789,
+		.expected = "-1256.01200856",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "16557.914267",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "-16557.914267",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, negative schan",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = -10,
+		.schan_val2 = 123456789,
+		.expected = "-16557.914267",
+	},
+	/*
+	 * 32-bit overflow conditions
+	 */
+	{
+		.name = "overflow IIO_VAL_FRACTIONAL, positive",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = S32_MAX,
+		.schan_val2 = 1,
+		.expected = "214748364.7",
+	},
+	{
+		.name = "overflow IIO_VAL_FRACTIONAL, negative",
+		.numerator = -2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = S32_MAX,
+		.schan_val2 = 1,
+		.expected = "-214748364.7",
+	},
+	{
+		.name = "overflow IIO_VAL_FRACTIONAL_LOG2, positive",
+		.numerator = S32_MAX,
+		.denominator = 4096,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 4096,
+		.schan_val2 = 16,
+		.expected = "32767.99998474121",
+	},
+	{
+		.name = "overflow IIO_VAL_FRACTIONAL_LOG2, negative",
+		.numerator = S32_MAX,
+		.denominator = 4096,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = -4096,
+		.schan_val2 = 16,
+		.expected = "-32767.99998474121",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_NANO, positive",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = S32_MAX,
+		.expected = "1.214748364",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_NANO, negative",
+		.numerator = -2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = S32_MAX,
+		.expected = "-1.214748364",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_NANO, negative schan",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = S32_MAX,
+		.expected = "-1.214748364",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_MICRO, positive",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = S32_MAX,
+		.expected = "215.748364",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_MICRO, negative",
+		.numerator = -2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = S32_MAX,
+		.expected = "-215.748364",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_MICRO, negative schan",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = -10,
+		.schan_val2 = S32_MAX,
+		.expected = "-215.748364",
+	},
+};
+
+const struct rescale_tc_data offset_cases[] = {
+	/*
+	 * Typical use cases
+	 */
+	{
+		.name = "typical IIO_VAL_INT, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_INT,
+		.schan_val = 123,
+		.schan_val2 = 0,
+		.schan_off = 14,
+		.expected_off = "24", /* 23.872 */
+	},
+	{
+		.name = "typical IIO_VAL_INT, negative",
+		.offset = -1234,
+		.schan_scale_type = IIO_VAL_INT,
+		.schan_val = 12,
+		.schan_val2 = 0,
+		.schan_off = 14,
+		.expected_off = "-88", /* -88.83333333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 12,
+		.schan_val2 = 34,
+		.schan_off = 14,
+		.expected_off = "3510", /* 3510.333333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL, negative",
+		.offset = -1234,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 12,
+		.schan_val2 = 34,
+		.schan_off = 14,
+		.expected_off = "-3482", /* -3482.333333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL_LOG2, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 12,
+		.schan_val2 = 16,
+		.schan_off = 14,
+		.expected_off = "6739299", /* 6739299.333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL_LOG2, negative",
+		.offset = -1234,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 12,
+		.schan_val2 = 16,
+		.schan_off = 14,
+		.expected_off = "-6739271", /* -6739271.333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.schan_off = 14,
+		.expected_off = "135", /* 135.8951219647469 */
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
+		.offset = -1234,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.schan_off = 14,
+		.expected_off = "-107", /* -107.89512196474689 */
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.schan_off = 14,
+		.expected_off = "23", /* 23.246438560723952 */
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
+		.offset = -12345,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.schan_off = 14,
+		.expected_off = "-78", /* -78.50185091745313 */
+	},
+};
+
+static void case_to_desc(const struct rescale_tc_data *t, char *desc)
+{
+	strcpy(desc, t->name);
+}
+
+KUNIT_ARRAY_PARAM(iio_rescale_scale, scale_cases, case_to_desc);
+KUNIT_ARRAY_PARAM(iio_rescale_offset, offset_cases, case_to_desc);
+
+/**
+ * iio_str_to_nano() - Parse a fixed-point string to get an
+ *                      IIO_VAL_INT_PLUS_NANO value
+ * @str: The string to parse
+ * @nano: The number as an integer
+ *
+ * Returns 0 on success, or a negative error code if the string cound not be
+ * parsed.
+ */
+static int iio_str_to_nano(const char *str, s64 *nano)
+{
+	int tmp, tmp2;
+	int ret = 0;
+
+	/*
+	 * iio_str_to_fixpoint() uses 10^8 here instead of 10^9 as fract_mult is
+	 * the multiplier for the first decimal place.
+	 */
+	ret = iio_str_to_fixpoint(str, 100000000, &tmp, &tmp2);
+	if (ret < 0)
+		return ret;
+
+	if (tmp < 0)
+		tmp2 *= -1;
+
+	*nano = (s64)tmp * GIGA + tmp2;
+
+	return ret;
+}
+
+/**
+ * iio_test_relative_error_ppm() - Compute relative error (in parts-per-million)
+ *                                 between two fixed-point strings
+ * @real_str: The real value as a string
+ * @exp_str: The expected value as a string
+ *
+ * Returns a negative error code if the strings cound not be parsed, or the
+ * relative error in parts-per-million.
+ */
+static int iio_test_relative_error_ppm(const char *real_str, const char *exp_str)
+{
+	s64 real, exp, err;
+	int ret;
+
+	ret = iio_str_to_nano(real_str, &real);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_str_to_nano(exp_str, &exp);
+	if (ret < 0)
+		return ret;
+
+	if (!exp) {
+		pr_err("Expected value is null, relative error is undefined\n");
+		return -EINVAL;
+	}
+
+	err = MEGA * abs(exp - real);
+
+	return (int)div64_u64(err, abs(exp));
+}
+
+static void iio_rescale_test_scale(struct kunit *test)
+{
+	struct rescale_tc_data *t = (struct rescale_tc_data *)test->param_value;
+	char *buff = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	struct rescale rescale;
+	int values[2];
+	int rel_ppm;
+	int ret;
+
+	rescale.numerator = t->numerator;
+	rescale.denominator = t->denominator;
+	rescale.offset = t->offset;
+	values[0] = t->schan_val;
+	values[1] = t->schan_val2;
+
+	ret = rescale_process_scale(&rescale, t->schan_scale_type,
+				    &values[0], &values[1]);
+
+	ret = iio_format_value(buff, ret, 2, values);
+	KUNIT_EXPECT_EQ(test, (int)strlen(buff), ret);
+
+	rel_ppm = iio_test_relative_error_ppm(buff, t->expected);
+	KUNIT_EXPECT_GE_MSG(test, rel_ppm, 0, "failed to compute ppm\n");
+
+	KUNIT_EXPECT_EQ_MSG(test, rel_ppm, 0,
+			    "\t    real=%s"
+			    "\texpected=%s\n",
+			    buff, t->expected);
+}
+
+static void iio_rescale_test_offset(struct kunit *test)
+{
+	struct rescale_tc_data *t = (struct rescale_tc_data *)test->param_value;
+	char *buff_off = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	struct rescale rescale;
+	int values[2];
+	int ret;
+
+	rescale.numerator = t->numerator;
+	rescale.denominator = t->denominator;
+	rescale.offset = t->offset;
+	values[0] = t->schan_val;
+	values[1] = t->schan_val2;
+
+	ret = rescale_process_offset(&rescale, t->schan_scale_type,
+				     t->schan_val, t->schan_val2, t->schan_off,
+				     &values[0], &values[1]);
+
+	ret = iio_format_value(buff_off, ret, 2, values);
+	KUNIT_EXPECT_EQ(test, (int)strlen(buff_off), ret);
+
+	KUNIT_EXPECT_STREQ(test, strim(buff_off), t->expected_off);
+}
+
+static struct kunit_case iio_rescale_test_cases[] = {
+	KUNIT_CASE_PARAM(iio_rescale_test_scale, iio_rescale_scale_gen_params),
+	KUNIT_CASE_PARAM(iio_rescale_test_offset, iio_rescale_offset_gen_params),
+	{}
+};
+
+static struct kunit_suite iio_rescale_test_suite = {
+	.name = "iio-rescale",
+	.test_cases = iio_rescale_test_cases,
+};
+kunit_test_suite(iio_rescale_test_suite);
-- 
2.35.1.4.g5d01301f2b86

