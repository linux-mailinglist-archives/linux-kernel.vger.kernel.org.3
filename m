Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38556C94C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGIL6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGIL6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:58:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCCD140A2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 04:58:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so580391wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diHVyWaKn6Q/nu2QvOdZ3HTvtDhCo0LX1HleEXdmXqI=;
        b=DWnqE//9FMXAxffjNAXz30EtSW+qp/5vJj2E5W+p4i2W8l/cEecvh8/ar4q095uLXb
         Z8bjLP6cIuNiv0DLgpTYKCYDUhSKds8/BUkC15uc/B3Lw529CuCghyagrtfNDuDoh4ac
         wHVUFnPwK1by1BTZKBN4BN36YfOMpgytcJbZI4ZuHoPy2J8F6+Jq5o1+L8ri62UjXPiu
         rEr+ajtR4MU9c7URWYOU0Vx4/2K4ejgsphClfOVSJLHF2sDDl1qVCyC4u14OxcgEQzli
         bXgLyybpjy3npfKqkLPM629/B/3Re6ZprYhcBJg8WGz/gidLBmnAHkEZRVO/ANW7tsl7
         4V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diHVyWaKn6Q/nu2QvOdZ3HTvtDhCo0LX1HleEXdmXqI=;
        b=nK1pE/Z68K4mAgNh2bvLqc2Sibqsrt/pk9o9Ptb+SBMIo3D03Rk8xLsE2iZTtynmZJ
         t0LFYpswl6ka2U7XBj7Hg2bckdKmGyTAn96Yd1hFXGawVDqDRz0+4CkeWMndiv0+achK
         /I/C2plqRcGNKc7WHYsBjiEJlNjy8UNQ7uyzafjnW0JVjegTwhK8kqNlgNBJ8Hm3kTiw
         AcMiST4eKIdl10O9yBwYJVjNOTSTXguEMyzTOYh7BaxYV2YYpRksA3alGMCB4hyg504e
         g/eRBjC0lHz0r71UKp8yYn9LQ0gaYYgiXaZqZ2n+/bkHZlTh0jI4c90buNwH4/J0M9Zg
         VZ+Q==
X-Gm-Message-State: AJIora86L/cZubp3rbJMEiXSXLWn03rU6F4BZD0GK3StlOW+Gzk8TaKq
        HjznXgqekonvuB5hrBxsXXo=
X-Google-Smtp-Source: AGRyM1vVsISrYMEwIKnQOUVlwE02A9wmCavPdKoQTAmON+qapDhbuEkmWNfKWaE4RiRcjz1TIDdG2Q==
X-Received: by 2002:a05:600c:4e07:b0:3a1:8548:4dd7 with SMTP id b7-20020a05600c4e0700b003a185484dd7mr5198289wmq.170.1657367926988;
        Sat, 09 Jul 2022 04:58:46 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id co1-20020a0560000a0100b0021cf31e1f7csm1199494wrb.102.2022.07.09.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 04:58:46 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/4] drm/format-helper: Fix test on big endian architectures
Date:   Sat,  9 Jul 2022 13:58:34 +0200
Message-Id: <20220709115837.560877-2-jose.exposito89@gmail.com>
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

The tests fail on big endian architectures, like PowerPC:

 $ ./tools/testing/kunit/kunit.py run \
   --kunitconfig=drivers/gpu/drm/tests \
   --arch=powerpc --cross_compile=powerpc64-linux-gnu-

Transform the XRGB8888 buffer from little endian to the CPU endian
before calling the conversion function to avoid this error.

Fixes: 8f456104915f ("drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()")
Reported-by: David Gow <davidgow@google.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 98583bf56044..4d074c2e48bf 100644
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
+	dst = kunit_kzalloc(test, buf_size, GFP_KERNEL);
+	if (!dst)
+		return NULL;
+
+	for (n = 0; n < buf_size; n++)
+		dst[n] = le32_to_cpu(buf[n]);
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

