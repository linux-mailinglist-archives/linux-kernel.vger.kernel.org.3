Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A955378F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiE3KUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiE3KUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:20:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412387C158
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:20:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l188-20020a1c25c5000000b003978df8a1e2so4076410wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vwQvKjruiYRDvc0VTu2YTcpNWREBhBz6WODeePVxVj4=;
        b=ENNC1PTiwcNYIr3PUDMg6bgC0XU/eWjopPXfQaIA9N7ceAmW55Ku/n17e2HVK1+NND
         EWm0MwHUkRlEaSf1enL9KBmfQow7rtfwtYdAruR5jBjqv8OmPv8HlJCMh5fmRt0Arzs0
         V8n2tT3Ffs5SoSjiQ6kW+BZWQaU8tjzFy9ftF+Q+ukyv52OtJ2mpmg1vysF47XxY7HPb
         N/21FzgvFWGPTDRTGYtofvpvT1E1W7XZ8K2662kv8U07LVLEqQhbNrtZnuHdHA7H7+co
         9wfW3kbKdVi6E5pfHBgU2O8VTlmwfOF4TyEDzI94KZ24/ky2cwkIcyfmji36azPwxSsh
         pirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwQvKjruiYRDvc0VTu2YTcpNWREBhBz6WODeePVxVj4=;
        b=dFAB4MPGtzphE2kQ2tnfyIBW3RPUZerMePwOB3ihZBNYIphTdpIItYNo8zbrKX2jcS
         SKxE/dZc1/w1qJM79ydztHle+D+zFTPPs0cvUIVezb4E83ziv2X29mIXnIXsoRgZt0/t
         OHXQ6P27fnk0zke9FMrZOXyPw7zSsQLvxR3AdlDYpS6JEvBQYX6augkKoy5IuO1UOE+c
         PKwN7aOj792DceNJK19h6oQfvbQ6glqih/PzOK8sjM99fg7iBC7SpjAyHtJ7SVkDgj9p
         U+r02V1nQDqypr3ApJwTO35Xbo49TyzlWsXp05OZqCwe0dAh0V01sdW9f+WyNhkc5DJs
         qeQQ==
X-Gm-Message-State: AOAM5320EVhlMlX0UTkxW67ex03fL4Ki2vJZOvB7XhCeMYnjmSA0bo3x
        B3gpAXkZv/P/e9iCYbroCzri+K4dIEkhyg==
X-Google-Smtp-Source: ABdhPJxL3vZuVXfnKO7PAsd5B6SVjTmyB128/hMed8GbealAla7cC+s1Qs0NHQziADSKexCBBawwtg==
X-Received: by 2002:a7b:c341:0:b0:37b:c619:c9f4 with SMTP id l1-20020a7bc341000000b0037bc619c9f4mr18207748wmj.38.1653906033682;
        Mon, 30 May 2022 03:20:33 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b003973ea7e725sm12986293wmq.0.2022.05.30.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 03:20:33 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
Date:   Mon, 30 May 2022 12:20:17 +0200
Message-Id: <20220530102017.471865-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530102017.471865-1-jose.exposito89@gmail.com>
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
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
 - Well know colors: White, black, red, green, blue, magenta, yellow
   and cyan
 - Other colors: Randomly picked
 - Destination pitch

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/Kconfig                  |  12 ++
 drivers/gpu/drm/Makefile                 |   3 +
 drivers/gpu/drm/drm_format_helper_test.c | 166 +++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_format_helper_test.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e88c497fa010..d92be6faef15 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -76,6 +76,18 @@ config DRM_KMS_HELPER
 	help
 	  CRTC helpers for KMS drivers.
 
+config DRM_FORMAR_HELPER_TEST
+	bool "drm_format_helper tests" if !KUNIT_ALL_TESTS
+	depends on DRM && KUNIT=y
+	select DRM_KMS_HELPER
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the drm_format_helper APIs. This option is not
+	  useful for distributions or general kernels, but only for kernel
+	  developers working on DRM and associated drivers.
+
+	  If in doubt, say "N".
+
 config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
         bool "Enable refcount backtrace history in the DP MST helpers"
 	depends on STACKTRACE_SUPPORT
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 15fe3163f822..6a7d7655d38c 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -76,6 +76,9 @@ obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 #
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
+obj-$(CONFIG_DRM_FORMAR_HELPER_TEST) += drm_kms_helper.o \
+		drm_format_helper_test.o
+CFLAGS_drm_format_helper_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
diff --git a/drivers/gpu/drm/drm_format_helper_test.c b/drivers/gpu/drm/drm_format_helper_test.c
new file mode 100644
index 000000000000..9c8a3007346c
--- /dev/null
+++ b/drivers/gpu/drm/drm_format_helper_test.c
@@ -0,0 +1,166 @@
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
+#include "drm_crtc_internal.h"
+
+#define TEST_BUF_SIZE 50
+#define CLIP(x, y, w, h) { (x), (y), (x) + (w), (y) + (h) }
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
+		.name = "Single pixel source",
+		.pitch = 1 * 4,
+		.dst_pitch = 0,
+		.clip = CLIP(0, 0, 1, 1),
+		.xrgb8888 = { 0x01FF0000 },
+		.expected = { 0xE0 },
+	},
+	{
+		.name = "Single pixel clip",
+		.pitch = 2 * 4,
+		.dst_pitch = 0,
+		.clip = CLIP(1, 1, 1, 1),
+		.xrgb8888 = {
+			0x00000000, 0x00000000,
+			0x00000000, 0x10FF0000,
+		},
+		.expected = { 0xE0 },
+	},
+	{
+		.name = "White, black, red, green, blue, magenta, yellow, cyan",
+		.pitch = 4 * 4,
+		.dst_pitch = 0,
+		.clip = CLIP(1, 1, 2, 4),
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
+		.name = "Destination pitch",
+		.pitch = 3 * 4,
+		.dst_pitch = 5,
+		.clip = CLIP(0, 0, 3, 3),
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
+/**
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
+	dst = kzalloc(dst_size, GFP_KERNEL);
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

