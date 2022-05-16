Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95243528CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344633AbiEPSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbiEPSNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:13:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E6E3D4A0;
        Mon, 16 May 2022 11:13:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r23so5594481wrr.2;
        Mon, 16 May 2022 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMJFaGbnQqlZfyZNLq7xsmyC5xCadPCgU0N0X3zKzt8=;
        b=HqBw5XfZgFoQO7Xk7cma7rn3uIUj97vbuxMPr9978ZrWye2rNBYWlVlrzdZacwK6BW
         an/NvvjjV/2wQp7L1Gq29mWTiXppmDUSpc5R7DijrrQDgF9XBHfCpG3Kxv2T8lu3UIbi
         rIJZkAIkz0kV+piM6wA1F51rvbJJarm2AqgUqgFKtTc1XtHxRp0eQcBiZqsZ4vdthghg
         UgDUhJAAz1ojMYxfuVB//6Wj37M7JGEtld6qam9hTzBwYYeQm6GSNjCbdqeijc+FFiAy
         3tPYZnO2Q6XEUyDoHdeMY+L2iPVLbnEsBD2q/XFB+2EdBV01tycZHkSNenGKbCW0ZKTz
         dvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMJFaGbnQqlZfyZNLq7xsmyC5xCadPCgU0N0X3zKzt8=;
        b=Ai81qKrAwCQpuCq5aM+lN8M3sXI6ttyikPX0nkbWyJHtsjVpnodIVCo6B9Xsiy0Fvy
         1Lj2583Kks3cw24m4iochojht89iV20bjJr2CxDA5jM9oSi4xzOLhDiT02NFJChEe+37
         sHjbQwJ7kt2PaCgB2Esuj0Vq7ZXhfD1mDXox/aXCKpk4aiKAfHdv84wWz8gt6c8Ay9c/
         dhSaYk2plETSa6XSz1twMtUkPLAbozLE/+WA9BxGo0aCn5vAl1ggI7t7keV3seWW03dy
         /ftAkH/ZP0vvrDKtdzYOlA8cHkRMnfQvGHzCxd6nrGz/8jUUgSC5AWcKga3gaTlk4DVi
         3pPw==
X-Gm-Message-State: AOAM5322mO+GLkR7MHVkmX3v98bQL5tcEU651WYrh/g4kLqw5UiIa3ta
        lpBTpOnT7vyfLginFtdCtVI=
X-Google-Smtp-Source: ABdhPJw8TT3Dtm8QQf5sN/rZx2qw71eBwodXFM2rUO7Y1rc0b0OoKz9zKyeoEqEB7DU6zxQ+oQ7eUw==
X-Received: by 2002:adf:9bcf:0:b0:20d:9b:a102 with SMTP id e15-20020adf9bcf000000b0020d009ba102mr8889203wrc.275.1652724829283;
        Mon, 16 May 2022 11:13:49 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600002cf00b0020d0c9c95d3sm3276382wry.77.2022.05.16.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:13:48 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 2/4] HID: uclogic: Add KUnit tests for uclogic_rdesc_template_apply()
Date:   Mon, 16 May 2022 20:13:21 +0200
Message-Id: <20220516181323.59554-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516181323.59554-1-jose.exposito89@gmail.com>
References: <20220516181323.59554-1-jose.exposito89@gmail.com>
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
 drivers/hid/Kconfig                  |   7 ++
 drivers/hid/Makefile                 |   2 +
 drivers/hid/hid-uclogic-rdesc-test.c | 179 +++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/hid/hid-uclogic-rdesc-test.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 7a674873d794..11212963ee3d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -458,6 +458,13 @@ config HID_UCLOGIC
 	help
 	Support for UC-Logic and Huion tablets.
 
+config HID_UCLOGIC_KUNIT_TEST
+	tristate "UC-Logic tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the UC-Logic driver.
+
 config HID_WALTOP
 	tristate "Waltop"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index d5ce8d747b14..b853906f2738 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -127,6 +127,8 @@ hid-uclogic-objs		:= hid-uclogic-core.o \
 				   hid-uclogic-rdesc.o \
 				   hid-uclogic-params.o
 obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
+obj-$(CONFIG_HID_UCLOGIC_KUNIT_TEST)	+= hid-uclogic-rdesc.o \
+					   hid-uclogic-rdesc-test.o
 obj-$(CONFIG_HID_UDRAW_PS3)	+= hid-udraw-ps3.o
 obj-$(CONFIG_HID_LED)		+= hid-led.o
 obj-$(CONFIG_HID_XIAOMI)	+= hid-xiaomi.o
diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
new file mode 100644
index 000000000000..71917de02b03
--- /dev/null
+++ b/drivers/hid/hid-uclogic-rdesc-test.c
@@ -0,0 +1,179 @@
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
-- 
2.25.1

