Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CC55CAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiF0QNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbiF0QNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:13:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20E14095
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so13793305wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pDNBhiLmVfVV+Ne/LbE/267jCUJxvNsVJYjt8/p09X8=;
        b=NSZPuSAPNl3/J0a/ww1tySEBOpRdxoi0GTHu14n97sUfgnnInXMiWim3dXIZF2//vS
         kzJfJwQJBhGcx9Wp1xLt390KArSmPba0zTcSewvF65CHYFnBc8HLyKnb6VezoPNuQGZ8
         WC8Evuv5b7L3vPSWXWfeldHCecGJHNIUanbkYrxxIeZgYCJWHXdiosK+W5pVGDcn9S3i
         JYNhw6TuSTgQPM+bDn2Oby++SC6VYXENStbHDLNMBGSCF10efi7QPO4OyAIbwwvxMMfh
         Y2y7r5yal7oRs0jymS903iXMzV8N0842Gf+bUnTjq5h2nVTPs+XcaZnrk35cdtmVhNRf
         JCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pDNBhiLmVfVV+Ne/LbE/267jCUJxvNsVJYjt8/p09X8=;
        b=RZqTGm/rrVIjCsj9wyn4Uk7uSuWgJ5e0O4JBJWAR6WFgs60c7KMv59aER1eMkXknjW
         oifMp4PBeARlHAUjoBGh11sTOHfQCRrsyGUfoM6zeSsbIJXmcpyv5RDGV5J21yaZ1Vxu
         wTaijPHLjx7QaW35OXa+Y6PdmxQeFRTNLKJDhNeuLpR7BHc885rf160NzlA/ef24ElX/
         eBHJ36wQIO4ooIRkaRVYfB/fIbn1z8lqfPQbm6+RCdiztZ0DW0+8cSd7blHF6dHKaF0U
         aUu6nX9RgXTYsGjgDOe4HA5/Hvnfd0/pKV8VtEK1D7TaDGPW4aK3Ri5915U/rjwH+mO2
         0zEw==
X-Gm-Message-State: AJIora97wCbZil9+jiyoTuusvAdbwAxWsjCDZLUHLitdQMthGuhQZaAc
        414L6PK/SdfKMJkdfyHc4jc=
X-Google-Smtp-Source: AGRyM1slA7u8TabruKXHhU8WYvPoHJ2BflQEkj8mUaP8ATALqTre8paJHdfYQayhYw6aS2fi93jPEw==
X-Received: by 2002:adf:dc08:0:b0:21b:bcaf:8500 with SMTP id t8-20020adfdc08000000b0021bbcaf8500mr12257540wri.133.1656346386572;
        Mon, 27 Jun 2022 09:13:06 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b0021b9504cc83sm10883600wrs.31.2022.06.27.09.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:13:06 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/4] drm/format-helper: Rename test cases to make them more generic
Date:   Mon, 27 Jun 2022 18:11:29 +0200
Message-Id: <20220627161132.33256-2-jose.exposito89@gmail.com>
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

The tests available at the moment only check the conversion from
XRGB8888 to RGB332. However, more conversion will be tested in the
future.

In order to make the struct and functions present in the tests more
generic, rename xrgb8888_to_rgb332_* to convert_xrgb8888_*.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 98583bf56044..de8cf525109e 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -16,7 +16,7 @@
 
 #define TEST_BUF_SIZE 50
 
-struct xrgb8888_to_rgb332_case {
+struct convert_xrgb8888_case {
 	const char *name;
 	unsigned int pitch;
 	unsigned int dst_pitch;
@@ -25,7 +25,7 @@ struct xrgb8888_to_rgb332_case {
 	const u8 expected[4 * TEST_BUF_SIZE];
 };
 
-static struct xrgb8888_to_rgb332_case xrgb8888_to_rgb332_cases[] = {
+static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 	{
 		.name = "single_pixel_source_buffer",
 		.pitch = 1 * 4,
@@ -111,18 +111,18 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
 	return dst_pitch * drm_rect_height(clip);
 }
 
-static void xrgb8888_to_rgb332_case_desc(struct xrgb8888_to_rgb332_case *t,
-					 char *desc)
+static void convert_xrgb8888_case_desc(struct convert_xrgb8888_case *t,
+				       char *desc)
 {
 	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
 }
 
-KUNIT_ARRAY_PARAM(xrgb8888_to_rgb332, xrgb8888_to_rgb332_cases,
-		  xrgb8888_to_rgb332_case_desc);
+KUNIT_ARRAY_PARAM(convert_xrgb8888, convert_xrgb8888_cases,
+		  convert_xrgb8888_case_desc);
 
-static void xrgb8888_to_rgb332_test(struct kunit *test)
+static void convert_xrgb8888_test(struct kunit *test)
 {
-	const struct xrgb8888_to_rgb332_case *params = test->param_value;
+	const struct convert_xrgb8888_case *params = test->param_value;
 	size_t dst_size;
 	__u8 *dst = NULL;
 
@@ -144,8 +144,7 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 }
 
 static struct kunit_case drm_format_helper_test_cases[] = {
-	KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test,
-			 xrgb8888_to_rgb332_gen_params),
+	KUNIT_CASE_PARAM(convert_xrgb8888_test, convert_xrgb8888_gen_params),
 	{}
 };
 
-- 
2.25.1

