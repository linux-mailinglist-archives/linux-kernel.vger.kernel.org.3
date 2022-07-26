Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6B581C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiGZXJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbiGZXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:09:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FD339BA6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:09:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso143592wmm.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LYSq8hx22ya/0Q3RDvIrYgbye9rn19b0dTSWrS2MZM=;
        b=WJpJeqqBlqEKk0b1mJ5CveY8VUPsEHlGwStJlju/fjlQIqyBtyY3i9Nkaw+YpjqgO0
         tSbd2o1UUpgIdJabjsf027FDVfMI5J9Hx9vfQ4Ci5R3ig5DOT3Yv01xIIBozDJjcmGnv
         sxScyjPM0t9QkJzI1wXgs3nq/gFrT5QHaBiotFK623XlcYyUOLWYYjpx9p4s8tIiSFgV
         N91vIbhhXy/zUh3ueEpfyvpm47jknl8pk5vjSgB/V9eD9c161oumNDq0rPPnIwsxfOfo
         pfkduQMCIlIVRoOaJBDqazfLRN40b7mnzC8JqPkrO7Ye0EKQihXyiMTDxECQ5fLuSlO9
         0Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LYSq8hx22ya/0Q3RDvIrYgbye9rn19b0dTSWrS2MZM=;
        b=lRMUMRHM9jNE1OUaKVeylQZM/8h0eiITkhVgd7Kj0EWcFZUNWEz8II/D0EQXTGumI6
         HLppGqm50dR1L/LTRliYqM6qVNcrIGdTeCM/IDwBsTSWKj+QNBPOcFRqVseQN8a/am8i
         qEpCS4OzcBf/wnqueT6quIlqU6jAkpdw3jApRRLYEwtFCj+olKUkCJNbQL1Erp7GNE8L
         dwVTf9cOp64blme1Se2+VtRDU6eeghNOFhXDltUAAayhIS0v1cT85OUUiYDjfv5k0h9V
         itB1cV2Fp8dpX9g2KDDfqzK/KWAYWH/ccWt7dz7kbT++VKyxvPOjx2mCyWSL3ZsYm04g
         JtHQ==
X-Gm-Message-State: AJIora+X8Q1LJcgXih+lS3A4ziRZUPEq1fB1IR4i4QmtXRulHETS/tyn
        6xoMb00h2y3acvtDKtuzICo=
X-Google-Smtp-Source: AGRyM1vKbx3uskTJG4AMUYgWTzQlKU/ObH5liOKJRFdwjqBSWmpqBt2RoO2l9iwU1IggMhb5832kdQ==
X-Received: by 2002:a7b:c391:0:b0:3a3:2f22:7bf6 with SMTP id s17-20020a7bc391000000b003a32f227bf6mr903333wmj.96.1658876975722;
        Tue, 26 Jul 2022 16:09:35 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0021e86504736sm7278533wrb.16.2022.07.26.16.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:09:35 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 3/4] drm/format-helper: Support multiple target formats results
Date:   Wed, 27 Jul 2022 01:09:15 +0200
Message-Id: <20220726230916.390575-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726230916.390575-1-jose.exposito89@gmail.com>
References: <20220726230916.390575-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support multiple destination format conversions, store the
destination pitch and the expected result in its own structure.

Tested-by: Tales L. Aparecida <tales.aparecida@gmail.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 53 ++++++++++++-------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 97fccd0a948b..bbe9e9f57e2b 100644
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

