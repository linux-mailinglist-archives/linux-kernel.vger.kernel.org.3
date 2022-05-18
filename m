Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25452C689
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiERWrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiERWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:47:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80728146764;
        Wed, 18 May 2022 15:47:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so4701141wrb.1;
        Wed, 18 May 2022 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPJhnUuUOAhXE0Z1vcb1a6z8ipkI3rm+rjP3z+ckVVg=;
        b=eXJiE1dHCeWtR9CN3oq/7GDr/lwgVd/Rn5ldM0pVtdxJ5h7o8lrNjKwAxF3toFuvEA
         j39guQBbA7QS3ALqavxfxKz5QoOSTnvdaj5PKY04fE5nDtxHxXwqKHHhHqR8YNDejkUO
         kBX05ZGwRIhZK1nVDO1zRgg5TMsFJUeeuNMc1G44fG0FnU6GUIc8CvsFNN/GbebLf0ya
         60cfSDkW40am/mGTAmSUwrl9mWUQXigS67KAzft46h0PPObo51eILG4MBru/6GbKZMYv
         fCMc05RJNbbRtlYe294q+sjxax0kRvStItmc0s5zfI901Ke8huHY8Ta7e4+FedzWFY+J
         nKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPJhnUuUOAhXE0Z1vcb1a6z8ipkI3rm+rjP3z+ckVVg=;
        b=tObt80umWc85xHlT54o6wAKXC6c+gQ2oYXgJRVr2jqqU/JOl+RoU3vFhXo54i3BWqF
         W8xqP23kkDguv7ektfGJdRFANoXq2iigYxSb3kkHov9wCZfFj1cuL/IOuJRw67pCVWPe
         yQBYjryH9KncygWbXwlj/5RsfZrlyw8tW/cD+u+Bt3Ve5aQ04sANlSNSBbPmOeqtXIcQ
         h5Uykoc6m4o8YYcPtbT2q/KVSQIajXJ1flBxAN+Q+DzP87uK4iJ0UNI35lh2nzUH4reI
         sudtRUjMfmsajAkL2Fiijv5gD197oDGPsePcLClvSiOesRaaOfiNsIG7Aig5dq8sjVvh
         H3jg==
X-Gm-Message-State: AOAM531wcSmmgt30MAs6uHiIXA+szHgOwcnEfq9/3f2UaileOpR3eFSC
        1apjUmfPMe+Ff0Qki2g6S5k=
X-Google-Smtp-Source: ABdhPJwRlzQElFe7DgtxO2WeEeU91ljzkoiSc92wFJBJivBOT3ERm+mY1Msh2Ng2+MAMsBTVdmMciw==
X-Received: by 2002:a5d:5984:0:b0:20c:7de2:5416 with SMTP id n4-20020a5d5984000000b0020c7de25416mr1485054wri.30.1652914032997;
        Wed, 18 May 2022 15:47:12 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id bi22-20020a05600c3d9600b003942a244f33sm5223419wmb.12.2022.05.18.15.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:47:12 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic v2 2/4] HID: uclogic: Add KUnit tests for uclogic_rdesc_template_apply()
Date:   Thu, 19 May 2022 00:47:00 +0200
Message-Id: <20220518224702.1409327-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518224702.1409327-1-jose.exposito89@gmail.com>
References: <20220518224702.1409327-1-jose.exposito89@gmail.com>
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

The uclogic_rdesc_template_apply() function is used by the driver to
generate HID descriptors from templates.

In order to avoid regressions in future patches, add KUnit tests to
test the function.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/Kconfig                  |   7 +
 drivers/hid/Makefile                 |   3 +
 drivers/hid/hid-uclogic-rdesc-test.c | 183 +++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/hid/hid-uclogic-rdesc-test.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 7a674873d794..2b8dc4c298e6 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -458,6 +458,13 @@ config HID_UCLOGIC
 	help
 	Support for UC-Logic and Huion tablets.
 
+config HID_UCLOGIC_KUNIT_TEST
+	bool "UC-Logic tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the UC-Logic driver.
+
 config HID_WALTOP
 	tristate "Waltop"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index d5ce8d747b14..3d5ec603d4e6 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -127,6 +127,9 @@ hid-uclogic-objs		:= hid-uclogic-core.o \
 				   hid-uclogic-rdesc.o \
 				   hid-uclogic-params.o
 obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
+obj-$(CONFIG_HID_UCLOGIC_KUNIT_TEST)	+= hid-uclogic-rdesc.o \
+					   hid-uclogic-rdesc-test.o
+CFLAGS_hid-uclogic-rdesc-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_HID_UDRAW_PS3)	+= hid-udraw-ps3.o
 obj-$(CONFIG_HID_LED)		+= hid-led.o
 obj-$(CONFIG_HID_XIAOMI)	+= hid-xiaomi.o
diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
new file mode 100644
index 000000000000..ded59e226230
--- /dev/null
+++ b/drivers/hid/hid-uclogic-rdesc-test.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ *  HID driver for UC-Logic devices not fully compliant with HID standard
+ *
+ *  Copyright (c) 2022 José Expósito <jose.exposito89@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include "./hid-uclogic-rdesc.h"
+
+struct uclogic_template_case {
+	const char *name;
+	const __u8 *template;
+	size_t template_size;
+	const s32 *param_list;
+	size_t param_num;
+	const __u8 *expected;
+};
+
+static const s32 params_pen_all[UCLOGIC_RDESC_PH_ID_NUM] = {
+	[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = 0xAA,
+	[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0xBB,
+	[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = 0xCC,
+	[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = 0xDD,
+	[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = 0xEE,
+};
+
+static const s32 params_pen_some[] = {
+	[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = 0xAA,
+	[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0xBB,
+};
+
+static const __u8 template_empty[] = { };
+static const __u8 template_small[] = { 0x00 };
+static const __u8 template_no_ph[] = { 0xAA, 0xFE, 0xAA, 0xED, 0x1D };
+
+static const __u8 template_pen_ph_end[] = {
+	0xAA, 0xBB, UCLOGIC_RDESC_PEN_PH_HEAD
+};
+
+static const __u8 template_pen_all_params[] = {
+	UCLOGIC_RDESC_PEN_PH(X_LM),
+	0x47, UCLOGIC_RDESC_PEN_PH(X_PM),
+	0x27, UCLOGIC_RDESC_PEN_PH(Y_LM),
+	UCLOGIC_RDESC_PEN_PH(Y_PM),
+	0x00, UCLOGIC_RDESC_PEN_PH(PRESSURE_LM),
+};
+
+static const __u8 expected_pen_all_params[] = {
+	0xAA, 0x00, 0x00, 0x00,
+	0x47, 0xBB, 0x00, 0x00, 0x00,
+	0x27, 0xCC, 0x00, 0x00, 0x00,
+	0xDD, 0x00, 0x00, 0x00,
+	0x00, 0xEE, 0x00, 0x00, 0x00,
+};
+
+static const __u8 template_pen_some_params[] = {
+	0x01, 0x02,
+	UCLOGIC_RDESC_PEN_PH(X_LM),
+	0x03, UCLOGIC_RDESC_PEN_PH(X_PM),
+	0x04, 0x05,
+};
+
+static const __u8 expected_pen_some_params[] = {
+	0x01, 0x02,
+	0xAA, 0x00, 0x00, 0x00,
+	0x03, 0xBB, 0x00, 0x00, 0x00,
+	0x04, 0x05,
+};
+
+static const __u8 template_params_none[] = {
+	0x27, UCLOGIC_RDESC_PEN_PH(Y_LM),
+	UCLOGIC_RDESC_PEN_PH(Y_PM),
+	0x00, UCLOGIC_RDESC_PEN_PH(PRESSURE_LM),
+};
+
+static struct uclogic_template_case uclogic_template_cases[] = {
+	{
+		.name = "Empty template",
+		.template = template_empty,
+		.template_size = sizeof(template_empty),
+		.param_list = params_pen_all,
+		.param_num = ARRAY_SIZE(params_pen_all),
+		.expected = template_empty,
+	},
+	{
+		.name = "Template smaller than the placeholder",
+		.template = template_small,
+		.template_size = sizeof(template_small),
+		.param_list = params_pen_all,
+		.param_num = ARRAY_SIZE(params_pen_all),
+		.expected = template_small,
+	},
+	{
+		.name = "No placeholder",
+		.template = template_no_ph,
+		.template_size = sizeof(template_no_ph),
+		.param_list = params_pen_all,
+		.param_num = ARRAY_SIZE(params_pen_all),
+		.expected = template_no_ph,
+	},
+	{
+		.name = "Pen placeholder at the end, without ID",
+		.template = template_pen_ph_end,
+		.template_size = sizeof(template_pen_ph_end),
+		.param_list = params_pen_all,
+		.param_num = ARRAY_SIZE(params_pen_all),
+		.expected = template_pen_ph_end,
+	},
+	{
+		.name = "All params present in the pen template",
+		.template = template_pen_all_params,
+		.template_size = sizeof(template_pen_all_params),
+		.param_list = params_pen_all,
+		.param_num = ARRAY_SIZE(params_pen_all),
+		.expected = expected_pen_all_params,
+	},
+	{
+		.name = "Some params present in the pen template (complete param list)",
+		.template = template_pen_some_params,
+		.template_size = sizeof(template_pen_some_params),
+		.param_list = params_pen_all,
+		.param_num = ARRAY_SIZE(params_pen_all),
+		.expected = expected_pen_some_params,
+	},
+	{
+		.name = "Some params present in the pen template (incomplete param list)",
+		.template = template_pen_some_params,
+		.template_size = sizeof(template_pen_some_params),
+		.param_list = params_pen_some,
+		.param_num = ARRAY_SIZE(params_pen_some),
+		.expected = expected_pen_some_params,
+	},
+	{
+		.name = "No params present in the template",
+		.template = template_params_none,
+		.template_size = sizeof(template_params_none),
+		.param_list = params_pen_some,
+		.param_num = ARRAY_SIZE(params_pen_some),
+		.expected = template_params_none,
+	},
+};
+
+static void uclogic_template_case_desc(struct uclogic_template_case *t,
+				       char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(uclogic_template, uclogic_template_cases,
+		  uclogic_template_case_desc);
+
+static void uclogic_template_test(struct kunit *test)
+{
+	__u8 *res;
+	const struct uclogic_template_case *params = test->param_value;
+
+	res = uclogic_rdesc_template_apply(params->template,
+					   params->template_size,
+					   params->param_list,
+					   params->param_num);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_EQ(test, 0,
+			memcmp(res, params->expected, params->template_size));
+	kfree(res);
+}
+
+static struct kunit_case hid_uclogic_rdesc_test_cases[] = {
+	KUNIT_CASE_PARAM(uclogic_template_test, uclogic_template_gen_params),
+	{}
+};
+
+static struct kunit_suite hid_uclogic_rdesc_test_suite = {
+	.name = "hid-uclogic-rdesc-test",
+	.test_cases = hid_uclogic_rdesc_test_cases,
+};
+
+kunit_test_suite(hid_uclogic_rdesc_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the UC-Logic driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("José Expósito <jose.exposito89@gmail.com>");
-- 
2.25.1

