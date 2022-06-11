Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FDE547448
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiFKLjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiFKLjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 07:39:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7816540;
        Sat, 11 Jun 2022 04:39:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o8so1616601wro.3;
        Sat, 11 Jun 2022 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9el9auPnq6m6H+z0qpqCnwqiGaqlZa/48GpKoNNR/g=;
        b=iWicCkBMa5ubbvSCKu1d9G7/O9QYfHJxBaudj/9sZnJN9pOeDqlUrXzKL6fLCikzm9
         /866KjSAmJNuvvEodN+Nftz17BMeJzU8qF5QGpKSoWAS8lnF1aH/wWXJjQe/auC8sZAz
         xdzvYDapUzcyWXWB1VAMlETGL1E9KbgCwkQrZ8YY4TH4ntz06J7Sg2G7PtWLJlsiTzVN
         zMPvbDktGbyYotsMlvgsHZE/Xu4AAhSO4zGQ9nxRif0mqFFL8Sv82b5KvK1V9y1a+sxr
         3BFOhI4WD4xt7SBr03bep1NC9ttZr/sS0MrsLaDIpVsQlfc41G/4wfFVKHJwaq3ayWKE
         bRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9el9auPnq6m6H+z0qpqCnwqiGaqlZa/48GpKoNNR/g=;
        b=trYmj2zkqi7fkNc9vwT/7Wd9953E7KtKye12NPNSU3nvJtPmhxajDORA6uHeU/Rzar
         dJo3bje46ap7GmJy8uZZ2x1tXf/JUkEMVBFOJ/5yhQoAyGllXfUYL+ulrOAt6HqNUSLF
         hqHFeABzN8m/55c4XQZvxkf+BeicOFthUjBRkTS+G7HiDDaawwpyI8PpIhkOydGcyGwn
         steCQG1mg5bf/9yYbABLRGPiosU2Krg7a6SGuq6EhBD0kbESZUSGRcEKRySZalTk/d3m
         9akAvVrkZhtg3mMxPwwMGNDDyaCgcMbBt2cRsYV3hxGJpioGADTsMa2EQlCgr47mEVeW
         fudA==
X-Gm-Message-State: AOAM532t3oj4u88naFinXxlRp77d6oA+EcJ9rHyFTTqo6ogbSZqs3AhH
        Zw8NkCVjVsm2MJKqOV27s8Zpq8O1aXA=
X-Google-Smtp-Source: ABdhPJwdmsGGVtNQ7Ntk/KrGGQQFxxRfqWdhnADjZeAHAKx9zeCrkXLJE2cbiZ1s03NGdzxjiF4rCw==
X-Received: by 2002:a05:6000:1869:b0:211:7f25:89da with SMTP id d9-20020a056000186900b002117f2589damr48444955wri.696.1654947562243;
        Sat, 11 Jun 2022 04:39:22 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b0039c4945c753sm6574198wmq.39.2022.06.11.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 04:39:21 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 2/4] HID: uclogic: Add KUnit tests for uclogic_rdesc_template_apply()
Date:   Sat, 11 Jun 2022 13:39:12 +0200
Message-Id: <20220611113914.355577-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611113914.355577-1-jose.exposito89@gmail.com>
References: <20220611113914.355577-1-jose.exposito89@gmail.com>
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

To run the tests:

 $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/hid \
 	--kconfig_add CONFIG_VIRTIO_UML=y \
 	--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/.kunitconfig             |   5 +
 drivers/hid/Kconfig                  |  16 +++
 drivers/hid/Makefile                 |   3 +
 drivers/hid/hid-uclogic-rdesc-test.c | 183 +++++++++++++++++++++++++++
 4 files changed, 207 insertions(+)
 create mode 100644 drivers/hid/.kunitconfig
 create mode 100644 drivers/hid/hid-uclogic-rdesc-test.c

diff --git a/drivers/hid/.kunitconfig b/drivers/hid/.kunitconfig
new file mode 100644
index 000000000000..04daeff5c970
--- /dev/null
+++ b/drivers/hid/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_USB=y
+CONFIG_USB_HID=y
+CONFIG_HID_UCLOGIC=y
+CONFIG_HID_KUNIT_TEST=y
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 70da5931082f..6ce92830b5d1 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1306,6 +1306,22 @@ config HID_MCP2221
 	To compile this driver as a module, choose M here: the module
 	will be called hid-mcp2221.ko.
 
+config HID_KUNIT_TEST
+	bool "KUnit tests for HID" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	depends on HID_UCLOGIC
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for HID. This option is not useful for
+	  distributions or general kernels, but only for kernel
+	  developers working on HID and associated drivers.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If in doubt, say "N".
+
 endmenu
 
 endif # HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index cac2cbe26d11..b0bef8098139 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -144,6 +144,9 @@ obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
 obj-$(CONFIG_HID_SENSOR_HUB)	+= hid-sensor-hub.o
 obj-$(CONFIG_HID_SENSOR_CUSTOM_SENSOR)	+= hid-sensor-custom.o
 
+obj-$(CONFIG_HID_KUNIT_TEST)	+= hid-uclogic-rdesc.o \
+				   hid-uclogic-rdesc-test.o
+
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/
 obj-$(CONFIG_USB_KBD)		+= usbhid/
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

