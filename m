Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1255C487
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbiF0QN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbiF0QNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:13:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9E11A29
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i25so8257879wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrWIJqMRTMApBIT0XGEXMBk+DhL+WfBH3A+0ox/Q7jM=;
        b=MdzmxDg5EJsI62qcflHw3guB6lJxYS/DxcUDUx+yNKAan6MZtpIBxAu895Nm6GiIFw
         TvFwkJPNZ9JlayYLFYVMPb3v3Fstm0De3PkzA5ieUSgTsF/9r85HrBFp8jLL8ko7vVfA
         zVFcoic8ic3bWcDEfMYBPT8MAmVWJXoWLte77shZuzG+G7UZ6OylnquNjSpWQ4Xf8stH
         aGaBbl4H5jlTWOW1fKRzEqvVEtcdNWQSQ3xk+hjG4zIWkfHouSGcYpHitwcp//kpbdQ8
         KIxfWDmVNWQ+Q1YmEHqQASZypeLHe9w/pgtbdswh2bXvdBp/4zhYAKLGiDr/czgccAIV
         5hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrWIJqMRTMApBIT0XGEXMBk+DhL+WfBH3A+0ox/Q7jM=;
        b=AmZdslbUXhRi+miuwd/c3c3ARe1t1LGomLaU+3BowcBk2t4KtBS7M/2bx5Qgb++R+R
         uDn1wX9CV9rl6Dl7913WZUFM2d+MB2vJ5l7b3R+ATaFm9TCdTAJFP90ty/Q9qHw6Gwhq
         vnNVXp7qGHF1gwp4Aq8mnga1wQAKf/21qk14XcTIk9QPm8fb3uhuj80serNMqmOrTvPt
         fQ50xsC0NJRNvkl+uY+Axs57Z0VuYeyBg2ypAUfres15AnqTgzqETG+9MykX0AxkaQ6n
         60//XZrCYhghsPMOkt2+s7Twg6Ok5bkLRqDcdF57wZosjRYmPfDo5i+lOy3jpaDQxSz3
         iCog==
X-Gm-Message-State: AJIora/XOefCzwfAKjCgGAKiRlmMrRdtjIZ17ZqUVsGOZYjHPJxEgz13
        3n1zS1xKSrP8+pcwkRzdTsU=
X-Google-Smtp-Source: AGRyM1u/uNhUsvw8yU5xnnlABNgZfGfiv52Jrb+33VlYHZJ28RkbDxos0k2S2DlyBEItf23WTdMleQ==
X-Received: by 2002:a5d:5047:0:b0:21b:92b2:f34f with SMTP id h7-20020a5d5047000000b0021b92b2f34fmr12668117wrt.677.1656346388493;
        Mon, 27 Jun 2022 09:13:08 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b0021b9504cc83sm10883600wrs.31.2022.06.27.09.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:13:08 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/4] drm/format-helper: Add support for conversion functions with swab
Date:   Mon, 27 Jun 2022 18:11:31 +0200
Message-Id: <20220627161132.33256-4-jose.exposito89@gmail.com>
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

The RGB565 conversion functions take an extra parameter ("swab")
indicating whether the bytes should be swapped into the clip buffer or
not.

Create a union in the "convert_xrgb8888_result" structure holding the
value of the "swab" parameter as well as the conversion function
pointer.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 44 ++++++++++++++-----
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 732d945e7f4e..52dc41cc7c60 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -16,12 +16,29 @@
 
 #define TEST_BUF_SIZE 50
 
+struct convert_xrgb8888_func {
+	void (*func)(void *dst, unsigned int dst_pitch,
+		     const void *src,
+		     const struct drm_framebuffer *fb,
+		     const struct drm_rect *clip);
+};
+
+struct convert_xrgb8888_func_swab {
+	void (*func)(void *dst, unsigned int dst_pitch,
+		     const void *src,
+		     const struct drm_framebuffer *fb,
+		     const struct drm_rect *clip,
+		     bool swab);
+	bool swab;
+};
+
 struct convert_xrgb8888_result {
 	u32 dst_format;
-	void (*conv_func)(void *dst, unsigned int dst_pitch,
-			  const void *src,
-			  const struct drm_framebuffer *fb,
-			  const struct drm_rect *clip);
+	bool has_swab;
+	union {
+		struct convert_xrgb8888_func conv;
+		struct convert_xrgb8888_func_swab conv_swab;
+	};
 	unsigned int dst_pitch;
 	const u8 expected[4 * TEST_BUF_SIZE];
 };
@@ -43,7 +60,7 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 		.results = {
 			{
 				.dst_format = DRM_FORMAT_RGB332,
-				.conv_func = drm_fb_xrgb8888_to_rgb332,
+				.conv = { .func = drm_fb_xrgb8888_to_rgb332 },
 				.dst_pitch = 0,
 				.expected = { 0xE0 },
 			},
@@ -60,7 +77,7 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 		.results = {
 			{
 				.dst_format = DRM_FORMAT_RGB332,
-				.conv_func = drm_fb_xrgb8888_to_rgb332,
+				.conv = { .func = drm_fb_xrgb8888_to_rgb332 },
 				.dst_pitch = 0,
 				.expected = { 0xE0 },
 			},
@@ -84,7 +101,7 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 		.results = {
 			{
 				.dst_format = DRM_FORMAT_RGB332,
-				.conv_func = drm_fb_xrgb8888_to_rgb332,
+				.conv = { .func = drm_fb_xrgb8888_to_rgb332 },
 				.dst_pitch = 0,
 				.expected = {
 					0xFF, 0x00,
@@ -108,7 +125,7 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 		.results = {
 			{
 				.dst_format = DRM_FORMAT_RGB332,
-				.conv_func = drm_fb_xrgb8888_to_rgb332,
+				.conv = { .func = drm_fb_xrgb8888_to_rgb332 },
 				.dst_pitch = 5,
 				.expected = {
 					0x0A, 0x08, 0xA0, 0x00, 0x00,
@@ -177,8 +194,15 @@ static void convert_xrgb8888_test(struct kunit *test)
 		dst = kunit_kzalloc(test, dst_size, GFP_KERNEL);
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dst);
 
-		result->conv_func(dst, result->dst_pitch, params->xrgb8888,
-				  &fb, &params->clip);
+		if (result->has_swab) {
+			result->conv_swab.func(dst, result->dst_pitch,
+					       params->xrgb8888, &fb,
+					       &params->clip,
+					       result->conv_swab.swab);
+		} else {
+			result->conv.func(dst, result->dst_pitch,
+					  params->xrgb8888, &fb, &params->clip);
+		}
 		KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
 	}
 }
-- 
2.25.1

