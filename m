Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB599547AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiFLQNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiFLQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:13:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13849F21
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:13:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h19so1181331wrc.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9paBtxXNBD7qiHLbnLJJzVrVOQ+NkLFfVFsFjcnuDQ8=;
        b=fJlYQjVfVRPI0uH2FebcSvGfd205oSVl7E7EyNq3nIViCBMqkHJw8DFjm8wbOn2T/o
         qXXTbh2Om8pTMpvWNcoXDlwbw6lCZAxV/2aEfKJwywGClhPUIW10yreCKuRfVpMsX/rk
         InLsdewApyan6N/TJIiNfBwh0ZDwFXgGw2Quz3GMjy2iV+e+HDIF3c5wD1kkLEl3/gd3
         YWNvk6yh0cqS692/8IN5O1F+4JS1lONjUcmjjXIdsBRheEXdWSkPIyMsuuAVxou5mZy1
         Hjjklr7yW/q9zTU+ztM++KlbLkfHxk0jJeqWin10MMx8lVVcTJZPWIkZ6s2T1abpJzjr
         otkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9paBtxXNBD7qiHLbnLJJzVrVOQ+NkLFfVFsFjcnuDQ8=;
        b=euOOQZCvwqtJ9GAJMzphZlyKkAKcR+V1E/h79GcEQfp+1P+wWUcDX8fW7ho8Kdfe/g
         fNI+nK4fESGzjYwE3jE7vB5kZ/cWKqjej2Ko3VYM4b+EU3Rb9HwWktoCoyZwYHeJGmXC
         aYSxcz/NHD0JNHG8tJLOf0xmZkeLkvOTYEridxeU59M7FWjLPaC9feaCPxyzm9W/B4q5
         VamS4gqUirqwgkpXqF7fAG0R2pjOPgEHbxDc/DuZIRKQehIYBAMGg2tRIUO2SCd1fXiJ
         q5znvlYgw6yHYcI+9brSQgnwL1M0I/omzdyZ7weCelr4RFsKQU5kZ8jNRYIEa+4zG6Sd
         9krg==
X-Gm-Message-State: AOAM532yU901D1TxrWVYnBJ1SqwHYhPYq9B918PMlP4VZhNaIOBK5D2e
        0NOEljCczbtsiG0Y5D67GqU=
X-Google-Smtp-Source: ABdhPJxsm76CBCSR//kQF/Gq7dCdenIy3ZsNPOnT5bViF618JMFkxHkLSyXhwJc0rbb1FXLUPULsyw==
X-Received: by 2002:adf:a4d8:0:b0:219:ecd4:159b with SMTP id h24-20020adfa4d8000000b00219ecd4159bmr10534011wrb.431.1655050380178;
        Sun, 12 Jun 2022 09:13:00 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d6208000000b0020d0f111241sm6015925wru.24.2022.06.12.09.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 09:12:59 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/3] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
Date:   Sun, 12 Jun 2022 18:12:47 +0200
Message-Id: <20220612161248.271590-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220612161248.271590-1-jose.exposito89@gmail.com>
References: <20220612161248.271590-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the conversion from XRGB8888 to RGB332.

What is tested?

 - Different values for the X in XRGB8888 to make sure it is ignored
 - Different clip values: Single pixel and full and partial buffer
 - Well known colors: White, black, red, green, blue, magenta, yellow
   and cyan
 - Other colors: Randomly picked
 - Destination pitch

How to run the tests?

 $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/kunit \
         --kconfig_add CONFIG_VIRTIO_UML=y \
         --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/Kconfig                       |  16 ++
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/kunit/.kunitconfig            |   3 +
 drivers/gpu/drm/kunit/Makefile                |   3 +
 .../gpu/drm/kunit/drm_format_helper_test.c    | 169 ++++++++++++++++++
 5 files changed, 192 insertions(+)
 create mode 100644 drivers/gpu/drm/kunit/.kunitconfig
 create mode 100644 drivers/gpu/drm/kunit/Makefile
 create mode 100644 drivers/gpu/drm/kunit/drm_format_helper_test.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 22e7fa48d693..6c2256e8474b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -70,6 +70,22 @@ config DRM_DEBUG_SELFTEST
 
 	  If in doubt, say "N".
 
+config DRM_KUNIT_TEST
+	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
+	depends on DRM && KUNIT=y
+	select DRM_KMS_HELPER
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for DRM. This option is not useful for
+	  distributions or general kernels, but only for kernel
+	  developers working on DRM and associated drivers.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If in doubt, say "N".
+
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 13ef240b3d2b..3171437d74f8 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 #
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
+obj-$(CONFIG_DRM_KUNIT_TEST) += kunit/
 
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
diff --git a/drivers/gpu/drm/kunit/.kunitconfig b/drivers/gpu/drm/kunit/.kunitconfig
new file mode 100644
index 000000000000..6ec04b4c979d
--- /dev/null
+++ b/drivers/gpu/drm/kunit/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_DRM=y
+CONFIG_DRM_KUNIT_TEST=y
diff --git a/drivers/gpu/drm/kunit/Makefile b/drivers/gpu/drm/kunit/Makefile
new file mode 100644
index 000000000000..2c8273796d9d
--- /dev/null
+++ b/drivers/gpu/drm/kunit/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o
diff --git a/drivers/gpu/drm/kunit/drm_format_helper_test.c b/drivers/gpu/drm/kunit/drm_format_helper_test.c
new file mode 100644
index 000000000000..c87e7ab69184
--- /dev/null
+++ b/drivers/gpu/drm/kunit/drm_format_helper_test.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <kunit/test.h>
+
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_mode.h>
+#include <drm/drm_print.h>
+#include <drm/drm_rect.h>
+
+#include "../drm_crtc_internal.h"
+
+#define TEST_BUF_SIZE 50
+
+struct xrgb8888_to_rgb332_case {
+	const char *name;
+	unsigned int pitch;
+	unsigned int dst_pitch;
+	struct drm_rect clip;
+	const u32 xrgb8888[TEST_BUF_SIZE];
+	const u8 expected[4 * TEST_BUF_SIZE];
+};
+
+static struct xrgb8888_to_rgb332_case xrgb8888_to_rgb332_cases[] = {
+	{
+		.name = "Single pixel source buffer",
+		.pitch = 1 * 4,
+		.dst_pitch = 0,
+		.clip = DRM_RECT_INIT(0, 0, 1, 1),
+		.xrgb8888 = { 0x01FF0000 },
+		.expected = { 0xE0 },
+	},
+	{
+		.name = "Single pixel clip rectangle",
+		.pitch = 2 * 4,
+		.dst_pitch = 0,
+		.clip = DRM_RECT_INIT(1, 1, 1, 1),
+		.xrgb8888 = {
+			0x00000000, 0x00000000,
+			0x00000000, 0x10FF0000,
+		},
+		.expected = { 0xE0 },
+	},
+	{
+		/* Well known colors, different values for the X in XRGB8888 to
+		 * make sure it is ignored. Partial clip area.
+		 */
+		.name = "White, black, red, green, blue, magenta, yellow, cyan",
+		.pitch = 4 * 4,
+		.dst_pitch = 0,
+		.clip = DRM_RECT_INIT(1, 1, 2, 4),
+		.xrgb8888 = {
+			0x00000000, 0x00000000, 0x00000000, 0x00000000,
+			0x00000000, 0x11FFFFFF, 0x22000000, 0x00000000,
+			0x00000000, 0x33FF0000, 0x4400FF00, 0x00000000,
+			0x00000000, 0x550000FF, 0x66FF00FF, 0x00000000,
+			0x00000000, 0x77FFFF00, 0x8800FFFF, 0x00000000,
+		},
+		.expected = {
+			0xFF, 0x00,
+			0xE0, 0x1C,
+			0x03, 0xE3,
+			0xFC, 0x1F,
+		},
+	},
+	{
+		/* Randomly picked colors. Full buffer within the clip area. */
+		.name = "Destination pitch",
+		.pitch = 3 * 4,
+		.dst_pitch = 5,
+		.clip = DRM_RECT_INIT(0, 0, 3, 3),
+		.xrgb8888 = {
+			0xA10E449C, 0xB1114D05, 0xC1A80303,
+			0xD16C7073, 0xA20E449C, 0xB2114D05,
+			0xC2A80303, 0xD26C7073, 0xA30E449C,
+		},
+		.expected = {
+			0x0A, 0x08, 0xA0, 0x00, 0x00,
+			0x6D, 0x0A, 0x08, 0x00, 0x00,
+			0xA0, 0x6D, 0x0A, 0x00, 0x00,
+		},
+	},
+};
+
+/*
+ * conversion_buf_size - Return the destination buffer size required to convert
+ * between formats.
+ * @src_format: source buffer pixel format (DRM_FORMAT_*)
+ * @dst_format: destination buffer pixel format (DRM_FORMAT_*)
+ * @dst_pitch: Number of bytes between two consecutive scanlines within dst
+ * @clip: Clip rectangle area to convert
+ *
+ * Returns:
+ * The size of the destination buffer or negative value on error.
+ */
+static size_t conversion_buf_size(u32 src_format, u32 dst_format,
+				  unsigned int dst_pitch,
+				  const struct drm_rect *clip)
+{
+	const struct drm_format_info *src_fi = drm_format_info(src_format);
+	const struct drm_format_info *dst_fi = drm_format_info(dst_format);
+	size_t width = drm_rect_width(clip);
+	size_t src_nbytes;
+
+	if (!src_fi || !dst_fi)
+		return -EINVAL;
+
+	if (dst_pitch)
+		width = dst_pitch;
+
+	src_nbytes = width * drm_rect_height(clip) * src_fi->cpp[0];
+	if (!src_nbytes)
+		return 0;
+
+	return (src_nbytes * dst_fi->cpp[0]) / src_fi->cpp[0];
+}
+
+static void xrgb8888_to_rgb332_case_desc(struct xrgb8888_to_rgb332_case *t,
+					 char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(xrgb8888_to_rgb332, xrgb8888_to_rgb332_cases,
+		  xrgb8888_to_rgb332_case_desc);
+
+static void xrgb8888_to_rgb332_test(struct kunit *test)
+{
+	const struct xrgb8888_to_rgb332_case *params = test->param_value;
+	size_t dst_size;
+	__u8 *dst = NULL;
+
+	struct drm_framebuffer fb = {
+		.format = drm_format_info(DRM_FORMAT_XRGB8888),
+		.pitches = { params->pitch, 0, 0 },
+	};
+
+	dst_size = conversion_buf_size(DRM_FORMAT_XRGB8888, DRM_FORMAT_RGB332,
+				       params->dst_pitch, &params->clip);
+	KUNIT_ASSERT_GT(test, dst_size, 0);
+
+	dst = kunit_kzalloc(test, dst_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dst);
+
+	drm_fb_xrgb8888_to_rgb332(dst, params->dst_pitch, params->xrgb8888,
+				  &fb, &params->clip);
+	KUNIT_EXPECT_EQ(test, memcmp(dst, params->expected, dst_size), 0);
+}
+
+static struct kunit_case drm_format_helper_test_cases[] = {
+	KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test,
+			 xrgb8888_to_rgb332_gen_params),
+	{}
+};
+
+static struct kunit_suite drm_format_helper_test_suite = {
+	.name = "drm-format-helper-test",
+	.test_cases = drm_format_helper_test_cases,
+};
+
+kunit_test_suite(drm_format_helper_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the drm_format_helper APIs");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("José Expósito <jose.exposito89@gmail.com>");
-- 
2.25.1

