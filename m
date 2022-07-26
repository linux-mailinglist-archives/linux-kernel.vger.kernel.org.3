Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48E581792
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbiGZQjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbiGZQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:39:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2851CB24;
        Tue, 26 Jul 2022 09:39:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g2so12883064wru.3;
        Tue, 26 Jul 2022 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLL2RudRcmj7MtRur/Ij0ZhLJLzj6mBpPVyBeIpUBA0=;
        b=TlUKzACpDDOoZ3/8c37pSCT9uc0p2jCs6RNs5q+5fdOAmOoC9DetPQR3JeKahirbLz
         QCFf9Pe4FRLCqA0fiUEdZZ228Qd8aRa3HccFF1aCfDj/b4EqVS2IGzVrLsWNZ0/jJw9j
         8ZkP/OIJdJo4/qwyPEtn0Vz1dQcUBvt4DBiAxezgwwIpxiiI5oNXX73XFPgOXiTqvkZs
         4NimeVYl7AcBmritqOVb5f1VFpyOMQ8zsTA9lTxUggyUjfO2WuwOOsAPqFhd/5gVe7c3
         P8EDKYVZVp3WG5mSSor7hmLHhtKuVWY7J0j3VyVNGoUtuie5siyTIe3NJ1LSpG9ZpmPT
         MPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLL2RudRcmj7MtRur/Ij0ZhLJLzj6mBpPVyBeIpUBA0=;
        b=eDi6kKokoUTiTZ8hL8sHBon5vf5ONFTqfXXpdN/XT2lYFHCz35hpUV2PPawxM9hUBu
         r9BdwISrz8bDrGodM/KA6OhR7P+DEzUSOzxh2euNxmLtAPgo9rv24idWAxdW9eXOss31
         Rs6eSFb9AEPDQLyCULKrY8AA5Sd/14PH95sfMizZXXg76lyPd+ZLHrpBgNKU4bJ0Yx1Y
         dSNS7Tr+vH6z0Mb9yNyjTjQ78bVRINKtD4E346gvMdcyaNEtDPTS1QGVUGJM4olAFKOq
         eVuxTIpvSCvcS65jJ6cqX9uIO3ylhb7snBHnhPcv3jAcuXHAZ22jOsgy4QeIDDb6iq4x
         F5nA==
X-Gm-Message-State: AJIora8gC1ncYIbdnbIojt2Y2WnH9Ef5VOLGZ5uy3Qxs+mrdkU72Dt0Y
        KLqTJhPrAhaUrT+7DKLmN3g=
X-Google-Smtp-Source: AGRyM1u9c25v4KuOQHv3tm2c5d7qwa/9wVla7idwpMyLmz+h+qsS6i+VTsR9FBR/1rB8JCD3tdoduQ==
X-Received: by 2002:a05:6000:15c1:b0:21e:8048:1b1a with SMTP id y1-20020a05600015c100b0021e80481b1amr9398055wry.370.1658853572321;
        Tue, 26 Jul 2022 09:39:32 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm19514710wmd.36.2022.07.26.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:39:32 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 2/7] HID: uclogic: Refactor UGEE v2 string descriptor parsing
Date:   Tue, 26 Jul 2022 18:39:21 +0200
Message-Id: <20220726163926.10549-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726163926.10549-1-jose.exposito89@gmail.com>
References: <20220726163926.10549-1-jose.exposito89@gmail.com>
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

The UGEE v2 tablets expose a string descriptor with their capabilities.

Move the code used to parse the descriptors and generate a parameter
list from it to its own function and add KUnit tests to validate the
parser.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/Makefile                  |   1 +
 drivers/hid/hid-uclogic-params-test.c | 159 ++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-params.c      |  86 ++++++++++----
 3 files changed, 226 insertions(+), 20 deletions(-)
 create mode 100644 drivers/hid/hid-uclogic-params-test.c

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 82d8fd97d96c..fe69dece2a46 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_HID_SENSOR_HUB)	+= hid-sensor-hub.o
 obj-$(CONFIG_HID_SENSOR_CUSTOM_SENSOR)	+= hid-sensor-custom.o
 
 hid-uclogic-test-objs		:= hid-uclogic-rdesc.o \
+				   hid-uclogic-params.o \
 				   hid-uclogic-rdesc-test.o
 obj-$(CONFIG_HID_KUNIT_TEST)	+= hid-uclogic-test.o
 
diff --git a/drivers/hid/hid-uclogic-params-test.c b/drivers/hid/hid-uclogic-params-test.c
new file mode 100644
index 000000000000..9f043f2ab387
--- /dev/null
+++ b/drivers/hid/hid-uclogic-params-test.c
@@ -0,0 +1,159 @@
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
+#define MAX_STR_DESC_SIZE 14
+
+struct uclogic_parse_ugee_v2_desc_case {
+	const char *name;
+	int res;
+	const __u8 str_desc[MAX_STR_DESC_SIZE];
+	size_t str_desc_size;
+	const s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
+};
+
+static struct uclogic_parse_ugee_v2_desc_case uclogic_parse_ugee_v2_desc_cases[] = {
+	{
+		.name = "invalid_str_desc",
+		.res = -EINVAL,
+		.str_desc = {},
+		.str_desc_size = 0,
+		.desc_params = {},
+	},
+	{
+		.name = "resolution_with_value_0",
+		.res = 0,
+		.str_desc = {
+			0x0E, 0x03,
+			0x70, 0xB2,
+			0x10, 0x77,
+			0x08,
+			0x00,
+			0xFF, 0x1F,
+			0x00, 0x00,
+		},
+		.str_desc_size = 12,
+		.desc_params = {
+			[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = 0xB270,
+			[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0,
+			[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = 0x7710,
+			[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = 0,
+			[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = 0x1FFF,
+			[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 0x08,
+		},
+	},
+	/* XP-PEN Deco L str_desc: Frame with 8 buttons */
+	{
+		.name = "frame_type_buttons",
+		.res = 0,
+		.str_desc = {
+			0x0E, 0x03,
+			0x70, 0xB2,
+			0x10, 0x77,
+			0x08,
+			0x00,
+			0xFF, 0x1F,
+			0xD8, 0x13,
+		},
+		.str_desc_size = 12,
+		.desc_params = {
+			[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = 0xB270,
+			[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0x2320,
+			[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = 0x7710,
+			[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = 0x1770,
+			[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = 0x1FFF,
+			[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 0x08,
+		},
+	},
+	/* PARBLO A610 PRO str_desc: Frame with 9 buttons and dial */
+	{
+		.name = "frame_type_dial",
+		.res = 0,
+		.str_desc = {
+			0x0E, 0x03,
+			0x96, 0xC7,
+			0xF9, 0x7C,
+			0x09,
+			0x01,
+			0xFF, 0x1F,
+			0xD8, 0x13,
+		},
+		.str_desc_size = 12,
+		.desc_params = {
+			[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = 0xC796,
+			[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0x2749,
+			[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = 0x7CF9,
+			[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = 0x1899,
+			[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = 0x1FFF,
+			[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 0x09,
+		},
+	},
+};
+
+static void uclogic_parse_ugee_v2_desc_case_desc(struct uclogic_parse_ugee_v2_desc_case *t,
+						 char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(uclogic_parse_ugee_v2_desc, uclogic_parse_ugee_v2_desc_cases,
+		  uclogic_parse_ugee_v2_desc_case_desc);
+
+static void uclogic_parse_ugee_v2_desc_test(struct kunit *test)
+{
+	int res;
+	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
+	const struct uclogic_parse_ugee_v2_desc_case *params = test->param_value;
+
+	res = uclogic_params_parse_ugee_v2_desc(params->str_desc,
+						params->str_desc_size,
+						desc_params,
+						ARRAY_SIZE(desc_params));
+	KUNIT_ASSERT_EQ(test, res, params->res);
+
+	if (res)
+		return;
+
+	KUNIT_EXPECT_EQ(test,
+			params->desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM],
+			desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM]);
+	KUNIT_EXPECT_EQ(test,
+			params->desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM],
+			desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM]);
+	KUNIT_EXPECT_EQ(test,
+			params->desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM],
+			desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM]);
+	KUNIT_EXPECT_EQ(test,
+			params->desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM],
+			desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM]);
+	KUNIT_EXPECT_EQ(test,
+			params->desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM],
+			desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM]);
+	KUNIT_EXPECT_EQ(test,
+			params->desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM],
+			desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM]);
+}
+
+static struct kunit_case hid_uclogic_params_test_cases[] = {
+	KUNIT_CASE_PARAM(uclogic_parse_ugee_v2_desc_test,
+			 uclogic_parse_ugee_v2_desc_gen_params),
+	{}
+};
+
+static struct kunit_suite hid_uclogic_params_test_suite = {
+	.name = "hid_uclogic_params_test",
+	.test_cases = hid_uclogic_params_test_cases,
+};
+
+kunit_test_suite(hid_uclogic_params_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the UC-Logic driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("José Expósito <jose.exposito89@gmail.com>");
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index f24a4aca7920..ab54f0125e05 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1052,6 +1052,62 @@ static int uclogic_probe_interface(struct hid_device *hdev, u8 *magic_arr,
 	return rc;
 }
 
+/**
+ * uclogic_params_parse_ugee_v2_desc - parse the string descriptor containing
+ * pen and frame parameters returned by UGEE v2 devices.
+ *
+ * @str_desc:		String descriptor, cannot be NULL.
+ * @str_desc_size:	Size of the string descriptor.
+ * @desc_params:	Output description params list.
+ * @desc_params_size:	Size of the output description params list.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_parse_ugee_v2_desc(const __u8 *str_desc,
+					     size_t str_desc_size,
+					     s32 *desc_params,
+					     size_t desc_params_size)
+{
+	s32 pen_x_lm, pen_y_lm;
+	s32 pen_x_pm, pen_y_pm;
+	s32 pen_pressure_lm;
+	s32 frame_num_buttons;
+	s32 resolution;
+
+	/* Minimum descriptor length required, maximum seen so far is 14 */
+	const int min_str_desc_size = 12;
+
+	if (!str_desc || str_desc_size < min_str_desc_size)
+		return -EINVAL;
+
+	if (desc_params_size != UCLOGIC_RDESC_PH_ID_NUM)
+		return -EINVAL;
+
+	pen_x_lm = get_unaligned_le16(str_desc + 2);
+	pen_y_lm = get_unaligned_le16(str_desc + 4);
+	frame_num_buttons = str_desc[6];
+	pen_pressure_lm = get_unaligned_le16(str_desc + 8);
+
+	resolution = get_unaligned_le16(str_desc + 10);
+	if (resolution == 0) {
+		pen_x_pm = 0;
+		pen_y_pm = 0;
+	} else {
+		pen_x_pm = pen_x_lm * 1000 / resolution;
+		pen_y_pm = pen_y_lm * 1000 / resolution;
+	}
+
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = pen_x_lm;
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = pen_x_pm;
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = pen_y_lm;
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = pen_y_pm;
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = pen_pressure_lm;
+	desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM] = frame_num_buttons;
+
+	return 0;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1082,7 +1138,6 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	__u8 *rdesc_pen = NULL;
 	__u8 *rdesc_frame = NULL;
 	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
-	s32 resolution;
 	__u8 magic_arr[] = {
 		0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 	};
@@ -1124,25 +1179,12 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 		goto output;
 	}
 
-	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] =
-		get_unaligned_le16(str_desc + 2);
-	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] =
-		get_unaligned_le16(str_desc + 4);
-	desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM] = str_desc[6];
-	desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] =
-		get_unaligned_le16(str_desc + 8);
-	resolution = get_unaligned_le16(str_desc + 10);
-	if (resolution == 0) {
-		desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0;
-		desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = 0;
-	} else {
-		desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] =
-			desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] * 1000 /
-			resolution;
-		desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] =
-			desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] * 1000 /
-			resolution;
-	}
+	rc = uclogic_params_parse_ugee_v2_desc(str_desc, str_desc_len,
+					       desc_params,
+					       ARRAY_SIZE(desc_params));
+	if (rc)
+		goto cleanup;
+
 	kfree(str_desc);
 	str_desc = NULL;
 
@@ -1513,3 +1555,7 @@ int uclogic_params_init(struct uclogic_params *params,
 	uclogic_params_cleanup(&p);
 	return rc;
 }
+
+#ifdef CONFIG_HID_KUNIT_TEST
+#include "hid-uclogic-params-test.c"
+#endif
-- 
2.25.1

