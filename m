Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33187581C51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbiGZXJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbiGZXJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:09:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3539D1AF1A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:09:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v13so14248247wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WjHwX17IyVtE8JB1105eRfVv2sAKL5cPl31La/xOQo=;
        b=VGK4nGWHPp+fpD4KWPsFdVLzQoUwu3AS2ZsPPS1d9SDhBhj4jsgK1a7w4mr+kiRkVk
         sV7TSqPh4d6SYELXugNc5Mfxum2KHCm8lFD/01gYXW6nAcSDeg0RO8OzNPA5FOOqa05Q
         uK1doUC+LZxBh2JvADCr/aUKb44C1/HMSu105vww/VzpGa1cG1pE3t2ZGTCL0fpowSL0
         aDKIa5XiEpnEhMERgglzPkq9wEMMscvQ4UGkllAI4EHWy3cn0d0U9WlT1Ewf+xLAjrh2
         /5mycI6+I2DWcUo+3+pqTJdBA6s0BnnCdzza9UfjvVdUogQxTqoB3bPIkc+rI3lBg/B+
         vJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WjHwX17IyVtE8JB1105eRfVv2sAKL5cPl31La/xOQo=;
        b=KYFE9vNPi4QV9L2b72nS5Yli8Jf6kvDevf1BgQBcIjAUiTRvtpeYjEsUqa5JltxevV
         TyMAqdhIoSd5eu+LvJQs+vtn+wuNQHVfSHF0AZ2lX2+ZEuG4xIGqcm6baE4z6o2EAGxZ
         qQGJbrcmDEWnrb/ApIEfLKDzoYjwbynDN5s1h5/SNKdru2b0w79tKB+AqxdMAaADA0M5
         2a0yHJpBcAwXDatNfU001yOM2U3gsF8PJ5PYJ8rLpC/HSlRw3NbjzypedGHQZ8keaIRL
         chKCuH3JHn1aZEbWq81cqY8dreM+6Q7Qx7Lt+04skCmnN41uxMb+qdvVPP53qUMB8GqJ
         nrvw==
X-Gm-Message-State: AJIora91lgX1647JVKy4Tb81zMw2KFyoOCMVCr8q9gVM81z4uTc4hpfl
        RUnnlakC8wa+04gHmynNxkQ=
X-Google-Smtp-Source: AGRyM1v/fQQzGFvnnr7oKrY5P9zFJMTTvyjTxfnbA8sJj+wpsxKlBRi5cRJ61oLJ48N2T6oZihddRg==
X-Received: by 2002:adf:e70e:0:b0:21d:7f90:7501 with SMTP id c14-20020adfe70e000000b0021d7f907501mr11552680wrm.447.1658876967632;
        Tue, 26 Jul 2022 16:09:27 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0021e86504736sm7278533wrb.16.2022.07.26.16.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:09:27 -0700 (PDT)
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
Subject: [PATCH v3 1/4] drm/format-helper: Fix test on big endian architectures
Date:   Wed, 27 Jul 2022 01:09:13 +0200
Message-Id: <20220726230916.390575-2-jose.exposito89@gmail.com>
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

The tests fail on big endian architectures, like PowerPC:

 $ ./tools/testing/kunit/kunit.py run \
   --kunitconfig=drivers/gpu/drm/tests \
   --arch=powerpc --cross_compile=powerpc64-linux-gnu-

Transform the XRGB8888 buffer from little endian to the CPU endian
before calling the conversion function to avoid this error.

Fixes: 8f456104915f ("drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()")
Reported-by: David Gow <davidgow@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 98583bf56044..eefaba3aaea2 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -111,6 +111,21 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
 	return dst_pitch * drm_rect_height(clip);
 }
 
+static u32 *le32buf_to_cpu(struct kunit *test, const u32 *buf, size_t buf_size)
+{
+	u32 *dst = NULL;
+	int n;
+
+	dst = kunit_kzalloc(test, sizeof(*dst) * buf_size, GFP_KERNEL);
+	if (!dst)
+		return NULL;
+
+	for (n = 0; n < buf_size; n++)
+		dst[n] = le32_to_cpu((__force __le32)buf[n]);
+
+	return dst;
+}
+
 static void xrgb8888_to_rgb332_case_desc(struct xrgb8888_to_rgb332_case *t,
 					 char *desc)
 {
@@ -125,6 +140,7 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 	const struct xrgb8888_to_rgb332_case *params = test->param_value;
 	size_t dst_size;
 	__u8 *dst = NULL;
+	__u32 *src = NULL;
 
 	struct drm_framebuffer fb = {
 		.format = drm_format_info(DRM_FORMAT_XRGB8888),
@@ -138,8 +154,11 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 	dst = kunit_kzalloc(test, dst_size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dst);
 
-	drm_fb_xrgb8888_to_rgb332(dst, params->dst_pitch, params->xrgb8888,
-				  &fb, &params->clip);
+	src = le32buf_to_cpu(test, params->xrgb8888, TEST_BUF_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, src);
+
+	drm_fb_xrgb8888_to_rgb332(dst, params->dst_pitch, src, &fb,
+				  &params->clip);
 	KUNIT_EXPECT_EQ(test, memcmp(dst, params->expected, dst_size), 0);
 }
 
-- 
2.25.1

