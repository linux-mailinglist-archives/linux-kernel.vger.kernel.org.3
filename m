Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6B56C94F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGIL7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGIL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:58:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF523140D5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 04:58:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n185so658938wmn.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBPnPC81YvyAZ93LszIxzzNNwpHvb+J4GVaMTH2T4lw=;
        b=n7ZdogiezEH+Zl1Hfv0QYr9IYLF5cU58TjVscPaBB/qUDuvSq3V0i12MD1jRzRxASm
         bCxyirxn/OWlmqg1UTQszLQy2WEjYWchwckgOXKtr3+Qg4wFqaMPgO/C9hTrHOO7CQf3
         LJp3Dq4aBWATJaOMgZYs+qR3srN1KRRppZ9tFIoch+7/oNRszpdJNkfDKChJ7SuAb7fV
         9qXJN9siikert4wfJ/MN6/FheYShh1Rv5wEUXRUgQoe9HN1OIR8vkVTWIJZqiz9Am/zd
         9lEnvbqM+AEvILKPulzM8MNUzqzS8wRoQUW24UKGUc/mXb5mMFVk4qpSCSxDTd9VgNd3
         TFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBPnPC81YvyAZ93LszIxzzNNwpHvb+J4GVaMTH2T4lw=;
        b=sC32EFyPOKUxEa26o2pBOi+mSi1YM3dfps0WesHhnBh18bxRgC0Gmc3q3TaMIldiEL
         VOxLQsqDQQEjfhtN+/hSeFw8zPOw/WSzKCnVEp8BXGmvYJ+55ftQgx+jwN86OWlgww29
         rCDP+4jSP1g+Jo2s+HnkA47HF1rWg/DKLHJG3hCYiMKQW9XFdKMU++sqNzTt1kXwgOuX
         YNGAemut3UXaa1cw0mjICvQO7nyvbZevTfUfkiStXmMdwuipRoHkAwVKPmfIRyZldCHf
         X62tc9MBoE8BhCInYdTv6wRhOwfNiImFDfm1RfYycoEhcIxo9QjHnVrKOWXGVvPMU6SS
         y41A==
X-Gm-Message-State: AJIora/7DQU0PpF4+WtZSW//zqB0Y8oELa/p3uXmqYDQurSOBJ09GsOs
        XK9izji8MUO+g5EEz+LyNmw=
X-Google-Smtp-Source: AGRyM1tVxXqylqlgYVJmVWeOHBGL8OSYO0a6TJff9lt/hcu6YKAJmzvdi/E44HGoTDuMNhqcxyXx9g==
X-Received: by 2002:a7b:c848:0:b0:3a0:3937:893 with SMTP id c8-20020a7bc848000000b003a039370893mr5010781wml.163.1657367930126;
        Sat, 09 Jul 2022 04:58:50 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id co1-20020a0560000a0100b0021cf31e1f7csm1199494wrb.102.2022.07.09.04.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 04:58:49 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 4/4] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()
Date:   Sat,  9 Jul 2022 13:58:37 +0200
Message-Id: <20220709115837.560877-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709115837.560877-1-jose.exposito89@gmail.com>
References: <20220709115837.560877-1-jose.exposito89@gmail.com>
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

Extend the existing test cases to test the conversion from XRGB8888 to
RGB565.

The documentation and the color picker available on [1] are useful
resources to understand this patch and validate the values returned by
the conversion function.

Tested-by: Tales L. Aparecida <tales.aparecida@gmail.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Link: http://www.barth-dev.de/online/rgb565-color-picker/ # [1]
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 76 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 0a490ad4fd32..c0592c1235cf 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -21,12 +21,19 @@ struct convert_to_rgb332_result {
 	const u8 expected[TEST_BUF_SIZE];
 };
 
+struct convert_to_rgb565_result {
+	unsigned int dst_pitch;
+	const u16 expected[TEST_BUF_SIZE];
+	const u16 expected_swab[TEST_BUF_SIZE];
+};
+
 struct convert_xrgb8888_case {
 	const char *name;
 	unsigned int pitch;
 	struct drm_rect clip;
 	const u32 xrgb8888[TEST_BUF_SIZE];
 	struct convert_to_rgb332_result rgb332_result;
+	struct convert_to_rgb565_result rgb565_result;
 };
 
 static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
@@ -39,6 +46,11 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = 0,
 			.expected = { 0xE0 },
 		},
+		.rgb565_result = {
+			.dst_pitch = 0,
+			.expected = { 0xF800 },
+			.expected_swab = { 0x00F8 },
+		},
 	},
 	{
 		.name = "single_pixel_clip_rectangle",
@@ -52,6 +64,11 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = 0,
 			.expected = { 0xE0 },
 		},
+		.rgb565_result = {
+			.dst_pitch = 0,
+			.expected = { 0xF800 },
+			.expected_swab = { 0x00F8 },
+		},
 	},
 	{
 		/* Well known colors: White, black, red, green, blue, magenta,
@@ -77,6 +94,21 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0xFC, 0x1F,
 			},
 		},
+		.rgb565_result = {
+			.dst_pitch = 0,
+			.expected = {
+				0xFFFF, 0x0000,
+				0xF800, 0x07E0,
+				0x001F, 0xF81F,
+				0xFFE0, 0x07FF,
+			},
+			.expected_swab = {
+				0xFFFF, 0x0000,
+				0x00F8, 0xE007,
+				0x1F00, 0x1FF8,
+				0xE0FF, 0xFF07,
+			},
+		},
 	},
 	{
 		/* Randomly picked colors. Full buffer within the clip area. */
@@ -96,6 +128,19 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0xA0, 0x6D, 0x0A, 0x00, 0x00,
 			},
 		},
+		.rgb565_result = {
+			.dst_pitch = 10,
+			.expected = {
+				0x0A33, 0x1260, 0xA800, 0x0000, 0x0000,
+				0x6B8E, 0x0A33, 0x1260, 0x0000, 0x0000,
+				0xA800, 0x6B8E, 0x0A33, 0x0000, 0x0000,
+			},
+			.expected_swab = {
+				0x330A, 0x6012, 0x00A8, 0x0000, 0x0000,
+				0x8E6B, 0x330A, 0x6012, 0x0000, 0x0000,
+				0x00A8, 0x8E6B, 0x330A, 0x0000, 0x0000,
+			},
+		},
 	},
 };
 
@@ -120,7 +165,7 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
 	if (!dst_pitch)
 		dst_pitch = drm_rect_width(clip) * dst_fi->cpp[0];
 
-	return dst_pitch * drm_rect_height(clip);
+	return (dst_pitch * drm_rect_height(clip)) / (dst_fi->depth / 8);
 }
 
 static u32 *le32buf_to_cpu(struct kunit *test, const u32 *buf, size_t buf_size)
@@ -175,8 +220,37 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
 }
 
+static void xrgb8888_to_rgb565_test(struct kunit *test)
+{
+	const struct convert_xrgb8888_case *params = test->param_value;
+	const struct convert_to_rgb565_result *result = &params->rgb565_result;
+	size_t dst_size;
+	__u16 *dst = NULL;
+
+	struct drm_framebuffer fb = {
+		.format = drm_format_info(DRM_FORMAT_XRGB8888),
+		.pitches = { params->pitch, 0, 0 },
+	};
+
+	dst_size = conversion_buf_size(DRM_FORMAT_RGB565, result->dst_pitch,
+				       &params->clip);
+	KUNIT_ASSERT_GT(test, dst_size, 0);
+
+	dst = kunit_kzalloc(test, dst_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dst);
+
+	drm_fb_xrgb8888_to_rgb565(dst, result->dst_pitch, params->xrgb8888, &fb,
+				  &params->clip, false);
+	KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
+
+	drm_fb_xrgb8888_to_rgb565(dst, result->dst_pitch, params->xrgb8888, &fb,
+				  &params->clip, true);
+	KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected_swab, dst_size), 0);
+}
+
 static struct kunit_case drm_format_helper_test_cases[] = {
 	KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test, convert_xrgb8888_gen_params),
+	KUNIT_CASE_PARAM(xrgb8888_to_rgb565_test, convert_xrgb8888_gen_params),
 	{}
 };
 
-- 
2.25.1

