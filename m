Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4912E56C950
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiGIL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGIL6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:58:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B97140D5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 04:58:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 133-20020a1c028b000000b003a2dfdebe47so296678wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHq8eIN5kbK/6ZDjIj/3D1vTFqSkXTQkrho9nQ1d6+o=;
        b=lnYomu7TWcBNGp4X4XxO9j/KkPMVpk9ajD4O5axwDO/Tpr5yj79EUpdiyG4UG81N1s
         sq9aOoGpnRezRctUpnBoyTVFMaVQ/BD1mQLZXBQ+YBpligjqiMtBAY/Ina+C28dPHyPU
         bdmxeOc4juBrXH6ZXnihWiJk+qaBWrszd0++CFGMDkY5lqNNMDEkNDDUxmOrNKz5Abzq
         pDwTqGl82rdMM4Zdrm3B1wcHw+MCy3ymHEiu6qpA/S5FBzm4lhY0UKzOvUUl27t2NXMi
         PQdxztKrsj0OxFUKm0nGHCg+HoB56KWy6AA82KOCgZdDP+sDc3/6fjLDmXfUpLioakLo
         wd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHq8eIN5kbK/6ZDjIj/3D1vTFqSkXTQkrho9nQ1d6+o=;
        b=NJ0vDswqz+4CM8srDwCyHsdIaKF9HpmjEfjyV/PpZuorVgCsxW7BmUQCMRmgcRMDzb
         vlOA1gh0JAIkeUn1yHmXR0US8JMLbWcwIoFE5Bv7rO5Yo0eY+k79arPZj5qPlmZS6MBc
         IMCgfSmdzQPXeFkPcogmClRz4ziG00zVf01Nav1n/xraJZHjL99Ks9vwLjdII3RBbSwL
         dKVvOp8DEIjh9SuBic12/+MzggeC/O1TUTECaQdSOuW8T1PqO44mPZtUjRk/zJZdGEzN
         En2l+VlZH2kWCT0YvvioLDG2e/nBAttKNOWFl6IaOf2/1m1Lj7O92tvIDSlt4ujnlK1c
         Mr4w==
X-Gm-Message-State: AJIora/aj5dejbtCEJmVFjVoRnaNYod5/5iH2kPkwJ/iX+4G0n3RE5Zz
        Hc7F+8gWlrJbkiaeZhfJVc8=
X-Google-Smtp-Source: AGRyM1v2/yU5e9CVpXAuQmo186YPK77B9a21RT4A0gSk/R4S3OtSDgaJtTvEVmX9OSElSkkT5+zyZA==
X-Received: by 2002:a05:600c:4254:b0:3a1:6c19:f3aa with SMTP id r20-20020a05600c425400b003a16c19f3aamr4993203wmm.205.1657367927979;
        Sat, 09 Jul 2022 04:58:47 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id co1-20020a0560000a0100b0021cf31e1f7csm1199494wrb.102.2022.07.09.04.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 04:58:47 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/4] drm/format-helper: Rename test cases to make them more generic
Date:   Sat,  9 Jul 2022 13:58:35 +0200
Message-Id: <20220709115837.560877-3-jose.exposito89@gmail.com>
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

The tests available at the moment only check the conversion from
XRGB8888 to RGB332. However, more conversions will be tested in the
future.

In order to make the struct and functions present in the tests more
generic, rename xrgb8888_to_rgb332_* to convert_xrgb8888_*.

Tested-by: Tales L. Aparecida <tales.aparecida@gmail.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/tests/drm_format_helper_test.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 4d074c2e48bf..f66aaa0e52c9 100644
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
@@ -126,18 +126,18 @@ static u32 *le32buf_to_cpu(struct kunit *test, const u32 *buf, size_t buf_size)
 	return dst;
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
 
 static void xrgb8888_to_rgb332_test(struct kunit *test)
 {
-	const struct xrgb8888_to_rgb332_case *params = test->param_value;
+	const struct convert_xrgb8888_case *params = test->param_value;
 	size_t dst_size;
 	__u8 *dst = NULL;
 	__u32 *src = NULL;
@@ -163,8 +163,7 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 }
 
 static struct kunit_case drm_format_helper_test_cases[] = {
-	KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test,
-			 xrgb8888_to_rgb332_gen_params),
+	KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test, convert_xrgb8888_gen_params),
 	{}
 };
 
-- 
2.25.1

