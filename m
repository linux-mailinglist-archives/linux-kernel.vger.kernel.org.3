Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674FE595952
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiHPLEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiHPLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:03:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A481690
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:29:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso9124215wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZUx34QkHnBswCsUg5dOcBaoezDJ6gfWumxiIbYHCirs=;
        b=iNJTjNTrsT+WogTYPkEAEhy9SRvgJoM0IwoK9HllLm5bRoE/UsSQi9ijHQE9b1MCLb
         fjEu5WK399K8xPkUwnOfprDq5JfgJVZB5pCJfXqgWND3NuePAvnNxdTSffr3esCV6qan
         o7mJUbSkrDjNZOJnEtHMVUVsJCgLxjZx1n7imAv8lIk4GSFnq3fRSWiJRDepn/Kynn26
         jPY0bJ67ZLEIFOn34quychCwurRDo2DzV+EnDxdEyZo/+WM01IJ/iqgAKldJdixIqrWD
         lwDrTYkT6J+vqSR5Kp8+REV8TPmB/ChCFek2dzfC3lhKt1szDPOY4W+87Dr0ncsLn1TO
         x+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZUx34QkHnBswCsUg5dOcBaoezDJ6gfWumxiIbYHCirs=;
        b=l00MaszXg0E7vfmslBxzBENcKeYiXFCQCFjezb7JONVQuEldO4VS0s+Yvok49S3G+w
         6kC/XfK9iuYqE9RZ9Iaj3DxoE388ou3VNvoFPB7WBT5VPlAIO0a53g+Sy6sQgy+0qwZt
         GwTHPdKkVeNYO8ZS7FC69MOJlhOzXqTHpRTc62beNWxJGzeyrtyMd/j2dzx8LqEUnmiN
         z29U71w3Q6E/OKODGRzN/JMi7dupsY5XiXtHma94N6zBVNCbUSnfUITwVbE9m9BXrzaY
         bMPczgaxmP3MW7exTVRxXQkJB6COmB4WlNxlWz1JK8z+M/QwRA0vi5+/f3IPoAOplvku
         cUdw==
X-Gm-Message-State: ACgBeo1hJUyHHISFs1+65j3AJuD47/lmmac9IxrTwqS9kWrNHmeLNg0/
        9f28YiHy501QzK9FijAF2Ec=
X-Google-Smtp-Source: AA6agR5iHzQVr37Imsp8vtLPGEI0c14MbmGxjtQYWSuBdSpxix+OPsAN07NhKDaJU7WiPHcoHA4NgQ==
X-Received: by 2002:a05:600c:3ba0:b0:3a5:b73a:8773 with SMTP id n32-20020a05600c3ba000b003a5b73a8773mr16993312wms.64.1660645754524;
        Tue, 16 Aug 2022 03:29:14 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m9-20020adffe49000000b002251639bfd0sm1668407wrs.59.2022.08.16.03.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:29:14 -0700 (PDT)
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
Subject: [PATCH 2/3] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_xrgb2101010()
Date:   Tue, 16 Aug 2022 12:29:02 +0200
Message-Id: <20220816102903.276879-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816102903.276879-1-jose.exposito89@gmail.com>
References: <20220816102903.276879-1-jose.exposito89@gmail.com>
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
XRGB2101010.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 08d08e7ab19a..d8536db4de1e 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -32,6 +32,11 @@ struct convert_to_rgb888_result {
 	const u8 expected[TEST_BUF_SIZE];
 };
 
+struct convert_to_xrgb2101010_result {
+	unsigned int dst_pitch;
+	const u32 expected[TEST_BUF_SIZE];
+};
+
 struct convert_xrgb8888_case {
 	const char *name;
 	unsigned int pitch;
@@ -40,6 +45,7 @@ struct convert_xrgb8888_case {
 	struct convert_to_rgb332_result rgb332_result;
 	struct convert_to_rgb565_result rgb565_result;
 	struct convert_to_rgb888_result rgb888_result;
+	struct convert_to_xrgb2101010_result xrgb2101010_result;
 };
 
 static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
@@ -61,6 +67,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = 0,
 			.expected = { 0x00, 0x00, 0xFF },
 		},
+		.xrgb2101010_result = {
+			.dst_pitch = 0,
+			.expected = { 0x3FF00000 },
+		},
 	},
 	{
 		.name = "single_pixel_clip_rectangle",
@@ -83,6 +93,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = 0,
 			.expected = { 0x00, 0x00, 0xFF },
 		},
+		.xrgb2101010_result = {
+			.dst_pitch = 0,
+			.expected = { 0x3FF00000 },
+		},
 	},
 	{
 		/* Well known colors: White, black, red, green, blue, magenta,
@@ -132,6 +146,15 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
 			},
 		},
+		.xrgb2101010_result = {
+			.dst_pitch = 0,
+			.expected = {
+				0x3FFFFFFF, 0x00000000,
+				0x3FF00000, 0x000FFC00,
+				0x000003FF, 0x3FF003FF,
+				0x3FFFFC00, 0x000FFFFF,
+			},
+		},
 	},
 	{
 		/* Randomly picked colors. Full buffer within the clip area. */
@@ -175,6 +198,14 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			},
 		},
+		.xrgb2101010_result = {
+			.dst_pitch = 20,
+			.expected = {
+				0x03844672, 0x0444D414, 0x2A20300C, 0x00000000, 0x00000000,
+				0x1B1705CD, 0x03844672, 0x0444D414, 0x00000000, 0x00000000,
+				0x2A20300C, 0x1B1705CD, 0x03844672, 0x00000000, 0x00000000,
+			},
+		},
 	},
 };
 
@@ -319,10 +350,42 @@ static void xrgb8888_to_rgb888_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
 }
 
+static void xrgb8888_to_xrgb2101010_test(struct kunit *test)
+{
+	const struct convert_xrgb8888_case *params = test->param_value;
+	const struct convert_to_xrgb2101010_result *result = &params->xrgb2101010_result;
+	size_t dst_size;
+	__u32 *buf = NULL;
+	__u32 *xrgb8888 = NULL;
+	struct iosys_map dst, src;
+
+	struct drm_framebuffer fb = {
+		.format = drm_format_info(DRM_FORMAT_XRGB8888),
+		.pitches = { params->pitch, 0, 0 },
+	};
+
+	dst_size = conversion_buf_size(DRM_FORMAT_XRGB2101010,
+				       result->dst_pitch, &params->clip);
+	KUNIT_ASSERT_GT(test, dst_size, 0);
+
+	buf = kunit_kzalloc(test, dst_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	iosys_map_set_vaddr(&dst, buf);
+
+	xrgb8888 = le32buf_to_cpu(test, params->xrgb8888, TEST_BUF_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xrgb8888);
+	iosys_map_set_vaddr(&src, xrgb8888);
+
+	drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &fb, &params->clip);
+	buf = le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
+	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+}
+
 static struct kunit_case drm_format_helper_test_cases[] = {
 	KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(xrgb8888_to_rgb565_test, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(xrgb8888_to_rgb888_test, convert_xrgb8888_gen_params),
+	KUNIT_CASE_PARAM(xrgb8888_to_xrgb2101010_test, convert_xrgb8888_gen_params),
 	{}
 };
 
-- 
2.25.1

