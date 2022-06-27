Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED9155C8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiF0QN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiF0QNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:13:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE3140D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so7853214wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYw7CGFO//CItwO+VZ/QzzGgwBzkgCzOgnZsxxYoTY4=;
        b=AP8G17ouwX9ay9Nsklm0TKFMzxwv/NWaVziOluPLmZmnWmq03RlfjWfSxM4UQ1GMN5
         U5vTf22WStIu22sjeRwc9g+ixi0h4/mXIPo+l9qTyT+Oc7M/30OSU3I3JXJw7kEWIDhD
         RXMwPqnmRCEj8vK5iOJB/LkRl+Bq6gDTMKt4JQAFS+erDyP2268MyPD2N5ydzDKli0xO
         g9om5V+4vfKqDYHURINaY1jMLBOtbAesc1f86f81qyOcdp/wVbjSIRbzuhpwq7W8sD8m
         b9N7+VZAkfIaGnJthH9lrfhhmfncxx+yQvC2BGsGC8g9cBegS8WF4+tZbyhPTqXRY3NL
         Adeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYw7CGFO//CItwO+VZ/QzzGgwBzkgCzOgnZsxxYoTY4=;
        b=5H9tNCztfq9tdHAI17sT/YxGwtqZOmrfAI4g32xyqZd7rdtevanHkXCpVnT+dpI3NG
         8VglNrWDOL8M1GN7b0mcmluBS5yxVvmnp9KrRK/xS+pdtPfEuJA90mdCijZJEzw9byqF
         RdP2I8788dd5HUshE75faA0vED4EOc7d8TrsWbpkFIN+awjfpgRVEVY+Dcrjume2Vcm/
         cmwp4qiVMpXAB5BcqsmHJx5NS1vMr/yYLwa0DTuoGQxDLVsyvOWUivKXNQqF25YsXT8D
         Ics58f811wZe1s1mRQYKa5YT7E3vGcriOdOiEAWjGJJYIG1NKH7nxmcvGQfgYlTyDErt
         gdAw==
X-Gm-Message-State: AJIora8U5WVj1kxNDsK7ROKDhauJWlUK0fNq1KeLXOXmPpwrWFXBKZlb
        XN20x63+/NaRCHL9eMX2GUU=
X-Google-Smtp-Source: AGRyM1vVUM1sq3THYxF0+f/5T7IB/yfC/bim5nxm8lDQImUcWMPfgAI5TeGngQaDoMUY2LCxuGReIA==
X-Received: by 2002:a1c:7414:0:b0:3a0:201c:5b7f with SMTP id p20-20020a1c7414000000b003a0201c5b7fmr21074157wmc.170.1656346389529;
        Mon, 27 Jun 2022 09:13:09 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b0021b9504cc83sm10883600wrs.31.2022.06.27.09.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:13:09 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 4/4] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()
Date:   Mon, 27 Jun 2022 18:11:32 +0200
Message-Id: <20220627161132.33256-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627161132.33256-1-jose.exposito89@gmail.com>
References: <20220627161132.33256-1-jose.exposito89@gmail.com>
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

[1] http://www.barth-dev.de/online/rgb565-color-picker/

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 100 +++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 52dc41cc7c60..3fbe8026bccc 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -48,7 +48,7 @@ struct convert_xrgb8888_case {
 	unsigned int pitch;
 	struct drm_rect clip;
 	const u32 xrgb8888[TEST_BUF_SIZE];
-	struct convert_xrgb8888_result results[1];
+	struct convert_xrgb8888_result results[3];
 };
 
 static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
@@ -64,6 +64,26 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				.dst_pitch = 0,
 				.expected = { 0xE0 },
 			},
+			{
+				.dst_format = DRM_FORMAT_RGB565,
+				.has_swab = true,
+				.conv_swab = {
+					.func = drm_fb_xrgb8888_to_rgb565,
+					.swab = false,
+				},
+				.dst_pitch = 0,
+				.expected = { 0x00, 0xF8 },
+			},
+			{
+				.dst_format = DRM_FORMAT_RGB565,
+				.has_swab = true,
+				.conv_swab = {
+					.func = drm_fb_xrgb8888_to_rgb565,
+					.swab = true,
+				},
+				.dst_pitch = 0,
+				.expected = { 0xF8, 0x00 },
+			},
 		},
 	},
 	{
@@ -81,6 +101,26 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				.dst_pitch = 0,
 				.expected = { 0xE0 },
 			},
+			{
+				.dst_format = DRM_FORMAT_RGB565,
+				.has_swab = true,
+				.conv_swab = {
+					.func = drm_fb_xrgb8888_to_rgb565,
+					.swab = false,
+				},
+				.dst_pitch = 0,
+				.expected = { 0x00, 0xF8 },
+			},
+			{
+				.dst_format = DRM_FORMAT_RGB565,
+				.has_swab = true,
+				.conv_swab = {
+					.func = drm_fb_xrgb8888_to_rgb565,
+					.swab = true,
+				},
+				.dst_pitch = 0,
+				.expected = { 0xF8, 0x00 },
+			},
 		},
 	},
 	{
@@ -110,6 +150,36 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 					0xFC, 0x1F,
 				},
 			},
+			{
+				.dst_format = DRM_FORMAT_RGB565,
+				.has_swab = true,
+				.conv_swab = {
+					.func = drm_fb_xrgb8888_to_rgb565,
+					.swab = false,
+				},
+				.dst_pitch = 0,
+				.expected = {
+					0xFF, 0xFF, 0x00, 0x00,
+					0x00, 0xF8, 0xE0, 0x07,
+					0x1F, 0x00, 0x1F, 0xF8,
+					0xE0, 0xFF, 0xFF, 0x07,
+				},
+			},
+			{
+				.dst_format = DRM_FORMAT_RGB565,
+				.has_swab = true,
+				.conv_swab = {
+					.func = drm_fb_xrgb8888_to_rgb565,
+					.swab = true,
+				},
+				.dst_pitch = 0,
+				.expected = {
+					0xFF, 0xFF, 0x00, 0x00,
+					0xF8, 0x00, 0x07, 0xE0,
+					0x00, 0x1F, 0xF8, 0x1F,
+					0xFF, 0xE0, 0x07, 0xFF,
+				},
+			},
 		},
 	},
 	{
@@ -133,6 +203,34 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 					0xA0, 0x6D, 0x0A, 0x00, 0x00,
 				},
 			},
+			{
+				.dst_format = DRM_FORMAT_RGB565,
+				.has_swab = true,
+				.conv_swab = {
+					.func = drm_fb_xrgb8888_to_rgb565,
+					.swab = false,
+				},
+				.dst_pitch = 10,
+				.expected = {
+					0x33, 0x0A, 0x60, 0x12, 0x00, 0xA8, 0x00, 0x00, 0x00, 0x00,
+					0x8E, 0x6B, 0x33, 0x0A, 0x60, 0x12, 0x00, 0x00, 0x00, 0x00,
+					0x00, 0xA8, 0x8E, 0x6B, 0x33, 0x0A, 0x00, 0x00, 0x00, 0x00,
+				},
+			},
+			{
+				.dst_format = DRM_FORMAT_RGB565,
+				.has_swab = true,
+				.conv_swab = {
+					.func = drm_fb_xrgb8888_to_rgb565,
+					.swab = true,
+				},
+				.dst_pitch = 10,
+				.expected = {
+					0x0A, 0x33, 0x12, 0x60, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00,
+					0x6B, 0x8E, 0x0A, 0x33, 0x12, 0x60, 0x00, 0x00, 0x00, 0x00,
+					0xA8, 0x00, 0x6B, 0x8E, 0x0A, 0x33, 0x00, 0x00, 0x00, 0x00,
+				},
+			},
 		},
 	},
 };
-- 
2.25.1

