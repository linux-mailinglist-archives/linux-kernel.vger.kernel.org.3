Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913A056C951
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGIL66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGIL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:58:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C3F1572E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 04:58:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso1146399wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOA7JdIx7LclTnxriLkitT5hOMN7G/KZhm/8tzsBWhw=;
        b=YqACFK8JTt8y9rttRvi5GJ/9pkVKnBjIuM3PEgMXzXj8NjcWPbx+MASUjXrxE68nx6
         OQGJyKbwJdK1TzXZVmWBA6EYvjJKh/yi8UlLfKJBNs1UauneT1GAlI30WhHPGgt/gfja
         CWvIN0ETzTGHZdov9mpfPw5GPoK1cwuHdGTO5BHvas/7DN981II+oIOW+8KzTiplEDkX
         sBF1rbvmuJxWTYTD9Z5WIu2MekAQm+2SQuIWVhWmSg5xPVJOJyZcMfrmjiLGHCvPW5BO
         WxpSlgeYlupIv7QdqEPvrxJibgYXfVgVxh4hOe0MpCdpFcxU9drTUtyTW3pDPL7Hh/Hn
         dzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOA7JdIx7LclTnxriLkitT5hOMN7G/KZhm/8tzsBWhw=;
        b=jcz56MxcbzCVInRrWGUE9XED07dNhyYxFAL3gyBFEecK8rxshl/kNvdjpSxQDAiHgh
         HN6mksK7Ve4QbyjO5ftu2izeSw6k7vg3jVihejATPr0T8XmF+MD0Z9GCKNoJhq4NJxrY
         qseLYMzSsfCyQhEiTAKeDsxu6ua6vCTPRXO9YiPpJ8wHVP18xa6vQxXQMEpmd9AoBbQG
         fzYQooGs8ag7eA4GpGlAEAYUd1ilUQdQb2eE9VEBK1NAmrIEfFNcDkkKi0aBFQc7nvXO
         XAg9hB0CkpiJMuNtzYvI5MEur4nWPWDhKboTwMt1lpSrEGQzPRcB9/D4TQrW6T0qmTeq
         0twQ==
X-Gm-Message-State: AJIora8Xct2ufG3SrbMyD+P7ePnwaAo1K1a/cXClWsrOAz9gAYBJnqP8
        8iWXvk24hrAJgXS/3CxSOSg=
X-Google-Smtp-Source: AGRyM1u/fsdcR6R79U7gfq+Fe7nxoZpoRlPqHJddUTulxbAGQIE9UESOGueJF2jm9IAzYcgj1IfwTA==
X-Received: by 2002:a7b:cb10:0:b0:3a0:312c:fd3c with SMTP id u16-20020a7bcb10000000b003a0312cfd3cmr5155014wmj.52.1657367929092;
        Sat, 09 Jul 2022 04:58:49 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id co1-20020a0560000a0100b0021cf31e1f7csm1199494wrb.102.2022.07.09.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 04:58:48 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 3/4] drm/format-helper: Support multiple target formats results
Date:   Sat,  9 Jul 2022 13:58:36 +0200
Message-Id: <20220709115837.560877-4-jose.exposito89@gmail.com>
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

In order to support multiple destination format conversions, store the
destination pitch and the expected result in its own structure.

Tested-by: Tales L. Aparecida <tales.aparecida@gmail.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 53 ++++++++++++-------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index f66aaa0e52c9..0a490ad4fd32 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -16,34 +16,42 @@
 
 #define TEST_BUF_SIZE 50
 
+struct convert_to_rgb332_result {
+	unsigned int dst_pitch;
+	const u8 expected[TEST_BUF_SIZE];
+};
+
 struct convert_xrgb8888_case {
 	const char *name;
 	unsigned int pitch;
-	unsigned int dst_pitch;
 	struct drm_rect clip;
 	const u32 xrgb8888[TEST_BUF_SIZE];
-	const u8 expected[4 * TEST_BUF_SIZE];
+	struct convert_to_rgb332_result rgb332_result;
 };
 
 static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 	{
 		.name = "single_pixel_source_buffer",
 		.pitch = 1 * 4,
-		.dst_pitch = 0,
 		.clip = DRM_RECT_INIT(0, 0, 1, 1),
 		.xrgb8888 = { 0x01FF0000 },
-		.expected = { 0xE0 },
+		.rgb332_result = {
+			.dst_pitch = 0,
+			.expected = { 0xE0 },
+		},
 	},
 	{
 		.name = "single_pixel_clip_rectangle",
 		.pitch = 2 * 4,
-		.dst_pitch = 0,
 		.clip = DRM_RECT_INIT(1, 1, 1, 1),
 		.xrgb8888 = {
 			0x00000000, 0x00000000,
 			0x00000000, 0x10FF0000,
 		},
-		.expected = { 0xE0 },
+		.rgb332_result = {
+			.dst_pitch = 0,
+			.expected = { 0xE0 },
+		},
 	},
 	{
 		/* Well known colors: White, black, red, green, blue, magenta,
@@ -52,7 +60,6 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 		 */
 		.name = "well_known_colors",
 		.pitch = 4 * 4,
-		.dst_pitch = 0,
 		.clip = DRM_RECT_INIT(1, 1, 2, 4),
 		.xrgb8888 = {
 			0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -61,28 +68,33 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			0x00000000, 0x550000FF, 0x66FF00FF, 0x00000000,
 			0x00000000, 0x77FFFF00, 0x8800FFFF, 0x00000000,
 		},
-		.expected = {
-			0xFF, 0x00,
-			0xE0, 0x1C,
-			0x03, 0xE3,
-			0xFC, 0x1F,
+		.rgb332_result = {
+			.dst_pitch = 0,
+			.expected = {
+				0xFF, 0x00,
+				0xE0, 0x1C,
+				0x03, 0xE3,
+				0xFC, 0x1F,
+			},
 		},
 	},
 	{
 		/* Randomly picked colors. Full buffer within the clip area. */
 		.name = "destination_pitch",
 		.pitch = 3 * 4,
-		.dst_pitch = 5,
 		.clip = DRM_RECT_INIT(0, 0, 3, 3),
 		.xrgb8888 = {
 			0xA10E449C, 0xB1114D05, 0xC1A80303,
 			0xD16C7073, 0xA20E449C, 0xB2114D05,
 			0xC2A80303, 0xD26C7073, 0xA30E449C,
 		},
-		.expected = {
-			0x0A, 0x08, 0xA0, 0x00, 0x00,
-			0x6D, 0x0A, 0x08, 0x00, 0x00,
-			0xA0, 0x6D, 0x0A, 0x00, 0x00,
+		.rgb332_result = {
+			.dst_pitch = 5,
+			.expected = {
+				0x0A, 0x08, 0xA0, 0x00, 0x00,
+				0x6D, 0x0A, 0x08, 0x00, 0x00,
+				0xA0, 0x6D, 0x0A, 0x00, 0x00,
+			},
 		},
 	},
 };
@@ -138,6 +150,7 @@ KUNIT_ARRAY_PARAM(convert_xrgb8888, convert_xrgb8888_cases,
 static void xrgb8888_to_rgb332_test(struct kunit *test)
 {
 	const struct convert_xrgb8888_case *params = test->param_value;
+	const struct convert_to_rgb332_result *result = &params->rgb332_result;
 	size_t dst_size;
 	__u8 *dst = NULL;
 	__u32 *src = NULL;
@@ -147,7 +160,7 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 		.pitches = { params->pitch, 0, 0 },
 	};
 
-	dst_size = conversion_buf_size(DRM_FORMAT_RGB332, params->dst_pitch,
+	dst_size = conversion_buf_size(DRM_FORMAT_RGB332, result->dst_pitch,
 				       &params->clip);
 	KUNIT_ASSERT_GT(test, dst_size, 0);
 
@@ -157,9 +170,9 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 	src = le32buf_to_cpu(test, params->xrgb8888, TEST_BUF_SIZE);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, src);
 
-	drm_fb_xrgb8888_to_rgb332(dst, params->dst_pitch, src, &fb,
+	drm_fb_xrgb8888_to_rgb332(dst, result->dst_pitch, src, &fb,
 				  &params->clip);
-	KUNIT_EXPECT_EQ(test, memcmp(dst, params->expected, dst_size), 0);
+	KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
 }
 
 static struct kunit_case drm_format_helper_test_cases[] = {
-- 
2.25.1

