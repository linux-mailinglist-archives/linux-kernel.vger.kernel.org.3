Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C8581C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiGZXJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbiGZXJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:09:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC3D2ED56
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:09:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h9so22066849wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXBbfu9mH+3+82kkU4IAZXAEpzI0pj7x/+D2ozToh5w=;
        b=NPv3yuIQbsQLMH7RsnBBqh/qdJLdGbIa0IDae1WJu0k0Lgagakni4QySN5ufrp9P4O
         sif0hRkblEt+rTBcvEIy4EXFb1WBRinXkxxKwELgZhAuF3wt8CKBGG60r8oI4LgsWdGP
         87+sKBoWp94lRiKoeqTo44xD4MmmfXXtpdRi8GKy9rSfSgQWGzDuh31GY4qmgQZxoYpO
         iJBEqJlUr+iGd0uacoQAaB/ovVyJ2T5cAa9lPce8RRqiVa7ygPtXQynKgkTZKmrsfAls
         jOPBIt5JfsDT8Yo3z8LFnLmWpOwRXB7JJqC0dlmEUGgML9uCFX6kpCaN7FHfsfW1Mq5E
         VASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXBbfu9mH+3+82kkU4IAZXAEpzI0pj7x/+D2ozToh5w=;
        b=nIsYPIE4HfwnhkA+G9YBCQXF5DsBEC0P2hbVckCujalK4DAuBVAt90/M74bBb50zZD
         zxfeP21n0MIqzDS4YqeXW6Z0mAAxny1LivfRN/rIQ3PngtZJQ3jw7ZoquLL7LrSCBSRr
         s0UFmT1kWwjVPYt2SwNms5FkbaFbbImD+bcHg7/DcXldyYtQK+57szp9nPqa1UVGaWD1
         Tda1V2iASrS4sXcwqbuWwcFRMbvF44Kzbsn9OqA3v8CtagfyPZv1y0awXSxFnMIWY/5i
         yXcuAiDMLsrtfe8v6+46NX5MDvmdrS2YrzxOoYF9k5Xxg8Zbpqe05zFTsltS6AvLfKUg
         orAQ==
X-Gm-Message-State: AJIora9wYS4lJIeMMMvBwW8eiWLVfECTSikm1gxoqyV9XpWZGSTTfurO
        GlmFWVJVcz1NAw4R1UIftl4=
X-Google-Smtp-Source: AGRyM1tWEYsb37uk6QjZIBeHdz8zdF3zgTaiG38PwXMzYHyAoZm5sRjiG4hj2tmDVSOwHofPYB7brg==
X-Received: by 2002:a5d:64ec:0:b0:21e:92fe:ac77 with SMTP id g12-20020a5d64ec000000b0021e92feac77mr5802206wri.24.1658876972259;
        Tue, 26 Jul 2022 16:09:32 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0021e86504736sm7278533wrb.16.2022.07.26.16.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:09:32 -0700 (PDT)
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
Subject: [PATCH v3 2/4] drm/format-helper: Rename test cases to make them more generic
Date:   Wed, 27 Jul 2022 01:09:14 +0200
Message-Id: <20220726230916.390575-3-jose.exposito89@gmail.com>
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

The tests available at the moment only check the conversion from
XRGB8888 to RGB332. However, more conversions will be tested in the
future.

In order to make the struct and functions present in the tests more
generic, rename xrgb8888_to_rgb332_* to convert_xrgb8888_*.

Tested-by: Tales L. Aparecida <tales.aparecida@gmail.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/tests/drm_format_helper_test.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index eefaba3aaea2..97fccd0a948b 100644
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

