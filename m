Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141485A9718
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiIAMoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIAMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:44:18 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FCFF4E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:44:17 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MJLMh5DM8z9sCh;
        Thu,  1 Sep 2022 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1662036257; bh=kTIjcU7FBGroks7lEZ00zdInv/aBptXmTVvA/M2VsHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=B9TVnfdHz1mt+jCGaPBrxJokxYoih/qwc2NrGfIDbVu56nWq4zx0+XJTkKaAkkct/
         z10kxbY11dLnMMKNrHNELxmN2+MzjoBotJMCGh2f4n1ZoHjaZm95WEC7574DV4AbqI
         +OCYHs7V4xGX0g69Bhu7WgZKMybjVvA7kXyFCEdA=
X-Riseup-User-ID: A3B67A41DD0DF7C3DB6ABC79DB2122D3625C8106311842502EFF15079CD0A37D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MJLMY6ZcSz1ySR;
        Thu,  1 Sep 2022 12:44:09 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        michal.winiarski@intel.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v2 1/2] drm/tests: Split drm_framebuffer_create_test into parameterized tests
Date:   Thu,  1 Sep 2022 09:42:09 -0300
Message-Id: <20220901124210.591994-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The igt_check_drm_framebuffer_create is based on a loop that executes
tests for all createbuffer_tests test cases. This could be better
represented by parameterized tests, provided by KUnit.

So, convert the igt_check_drm_framebuffer_create into parameterized tests.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>
---
v1 -> v2: https://lore.kernel.org/dri-devel/20220830211603.191734-1-mairacanal@riseup.net/
- Use .init for mock_drm_device instead of a global variable. (Michał Winiarski)
---
 drivers/gpu/drm/tests/drm_framebuffer_test.c | 45 ++++++++++++--------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_framebuffer_test.c b/drivers/gpu/drm/tests/drm_framebuffer_test.c
index ec7a08ba4056..564794917784 100644
--- a/drivers/gpu/drm/tests/drm_framebuffer_test.c
+++ b/drivers/gpu/drm/tests/drm_framebuffer_test.c
@@ -25,7 +25,7 @@ struct drm_framebuffer_test {
 	const char *name;
 };
 
-static struct drm_framebuffer_test createbuffer_tests[] = {
+static const struct drm_framebuffer_test drm_framebuffer_create_cases[] = {
 { .buffer_created = 1, .name = "ABGR8888 normal sizes",
 	.cmd = { .width = 600, .height = 600, .pixel_format = DRM_FORMAT_ABGR8888,
 		 .handles = { 1, 0, 0 }, .pitches = { 4 * 600, 0, 0 },
@@ -330,43 +330,52 @@ static struct drm_mode_config_funcs mock_config_funcs = {
 	.fb_create = fb_create_mock,
 };
 
-static struct drm_device mock_drm_device = {
-	.mode_config = {
+static int drm_framebuffer_test_init(struct kunit *test)
+{
+	struct drm_device *mock;
+
+	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mock);
+
+	mock->mode_config = (struct drm_mode_config) {
 		.min_width = MIN_WIDTH,
 		.max_width = MAX_WIDTH,
 		.min_height = MIN_HEIGHT,
 		.max_height = MAX_HEIGHT,
 		.funcs = &mock_config_funcs,
-	},
-};
+	};
 
-static int execute_drm_mode_fb_cmd2(struct drm_mode_fb_cmd2 *r)
+	test->priv = mock;
+	return 0;
+}
+
+static void test_drm_framebuffer_create(struct kunit *test)
 {
+	const struct drm_framebuffer_test *params = test->param_value;
+	struct drm_device *mock = test->priv;
 	int buffer_created = 0;
 
-	mock_drm_device.dev_private = &buffer_created;
-	drm_internal_framebuffer_create(&mock_drm_device, r, NULL);
-	return buffer_created;
+	mock->dev_private = &buffer_created;
+	drm_internal_framebuffer_create(mock, &params->cmd, NULL);
+	KUNIT_EXPECT_EQ(test, params->buffer_created, buffer_created);
 }
 
-static void igt_check_drm_framebuffer_create(struct kunit *test)
+static void drm_framebuffer_test_to_desc(const struct drm_framebuffer_test *t, char *desc)
 {
-	int i = 0;
-
-	for (i = 0; i < ARRAY_SIZE(createbuffer_tests); i++) {
-		KUNIT_EXPECT_EQ_MSG(test, createbuffer_tests[i].buffer_created,
-				    execute_drm_mode_fb_cmd2(&createbuffer_tests[i].cmd),
-		     "Test %d: \"%s\" failed\n", i, createbuffer_tests[i].name);
-	}
+	strcpy(desc, t->name);
 }
 
+KUNIT_ARRAY_PARAM(drm_framebuffer_create, drm_framebuffer_create_cases,
+		  drm_framebuffer_test_to_desc);
+
 static struct kunit_case drm_framebuffer_tests[] = {
-	KUNIT_CASE(igt_check_drm_framebuffer_create),
+	KUNIT_CASE_PARAM(test_drm_framebuffer_create, drm_framebuffer_create_gen_params),
 	{ }
 };
 
 static struct kunit_suite drm_framebuffer_test_suite = {
 	.name = "drm_framebuffer",
+	.init = drm_framebuffer_test_init,
 	.test_cases = drm_framebuffer_tests,
 };
 
-- 
2.37.2

