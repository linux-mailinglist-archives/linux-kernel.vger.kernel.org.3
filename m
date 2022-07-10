Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E601D56D09B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGJRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGJRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:51:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BF910570;
        Sun, 10 Jul 2022 10:51:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n10so4393921wrc.4;
        Sun, 10 Jul 2022 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSvkv9mhPoR5bDUGa6yltbm4LgVU497Un5RAIEDmaBw=;
        b=YH1RXhzViNLNFzFQNlttKptkQbIoZ85VBzxDs4m6NLo+nAMlNci8Ks2tbwGvCQJSVQ
         t02addSBhFVFVjrYc+IfEEl8clrZzOjMaB6pn8IuvGmwuUztYXvY/IslvmXP9UI3fiP3
         yVRcaK0Rfl0dYq4MfoZjjxCBZ7wbxCn15lNVK+gFP95/fHFkqtYUfTfHyOnqeXYTignC
         QD79WpwvYex5dovv/yokteucxDcXHGc4AxUK8/WS0ab12UlqGg5kJhr1i+Dqe0onktD1
         yj/Mzp2iWqIiIfjTFnWKI5U/TLhvcZ3+49xr0FrDITabhO37gJ5lIFXBBO+5d1bXBYE0
         cW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSvkv9mhPoR5bDUGa6yltbm4LgVU497Un5RAIEDmaBw=;
        b=O9waoCKqybdaG5FzIDZmk0y54n/LGTH0sMcfvSrEyPRv9OsslsuDlt9urouA/hLsFD
         Mzs8gn9L317H7a/9t7QNdP+x3fvdY0ju+fj1n7mVTvpddKJeaX2B3pv/v8S/C4shATTn
         hbnZS8BHZDxVhW8Im5YegYEwrVybq9sjv/Jh00xHEPDCFg2QtijzQu2xt+QRqrk0wHQP
         KCTxWBNFSISnGiBYBkTF6TmnGYSNODbWv5bLOfoSPJnZJ4fORfUnpUWkldHOXOIdrgJg
         EuG+S3BbVbRRqrA16sRmcaMKx6+ly2GuL3/Ocsmy30Zd6JsJBh9P4G59VMYK99sSa32r
         smEg==
X-Gm-Message-State: AJIora8vM9ZNg9IuM4sERxW3HM/F9Yz+qWlRf/7KG5pAVUdNuvP3NjHw
        JHrvJ/bSCbSZeQQStIkuNx0=
X-Google-Smtp-Source: AGRyM1ubT9urUyF65+ACCPJ2pgacj5pO+inNx15SL5EdmXfVexTcJ+ayd2PXx+7KKsFbP9YsSCQTdQ==
X-Received: by 2002:a5d:6c63:0:b0:21d:2a53:c7a9 with SMTP id r3-20020a5d6c63000000b0021d2a53c7a9mr13566411wrz.34.1657475470986;
        Sun, 10 Jul 2022 10:51:10 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id l23-20020a1ced17000000b003a03ae64f57sm4523495wmh.8.2022.07.10.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 10:51:10 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 4/7] HID: uclogic: Parse the UGEE v2 frame type
Date:   Sun, 10 Jul 2022 19:50:40 +0200
Message-Id: <20220710175043.192901-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710175043.192901-1-jose.exposito89@gmail.com>
References: <20220710175043.192901-1-jose.exposito89@gmail.com>
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

The string descriptor returned by UGEE v2 devices contains a byte
indicating the device frame type.

The values discovered so far are:

 - 0: Frame with buttons, present in the XP-PEN Deco L.
 - 1: Frame with buttons and dial, present in the PARBLO A610 PRO.
 - 2: Frame with buttons and a mouse, shaped as a dial + touchpad.
      Present in the XP-PEN Deco Pro S.

Parse the frame type and add KUnit tests.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params-test.c | 35 ++++++++++++++++++++++++++-
 drivers/hid/hid-uclogic-params.c      | 19 ++++++++++++---
 drivers/hid/hid-uclogic-params.h      | 10 ++++++++
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params-test.c b/drivers/hid/hid-uclogic-params-test.c
index 9f043f2ab387..57ef5d3e4b74 100644
--- a/drivers/hid/hid-uclogic-params-test.c
+++ b/drivers/hid/hid-uclogic-params-test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include "./hid-uclogic-params.h"
 #include "./hid-uclogic-rdesc.h"
 
 #define MAX_STR_DESC_SIZE 14
@@ -17,6 +18,7 @@ struct uclogic_parse_ugee_v2_desc_case {
 	const __u8 str_desc[MAX_STR_DESC_SIZE];
 	size_t str_desc_size;
 	const s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
+	enum uclogic_params_frame_type frame_type;
 };
 
 static struct uclogic_parse_ugee_v2_desc_case uclogic_parse_ugee_v2_desc_cases[] = {
@@ -26,6 +28,7 @@ static struct uclogic_parse_ugee_v2_desc_case uclogic_parse_ugee_v2_desc_cases[]
 		.str_desc = {},
 		.str_desc_size = 0,
 		.desc_params = {},
+		.frame_type = UCLOGIC_PARAMS_FRAME_BUTTONS,
 	},
 	{
 		.name = "resolution_with_value_0",
@@ -48,6 +51,7 @@ static struct uclogic_parse_ugee_v2_desc_case uclogic_parse_ugee_v2_desc_cases[]
 			[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = 0x1FFF,
 			[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 0x08,
 		},
+		.frame_type = UCLOGIC_PARAMS_FRAME_BUTTONS,
 	},
 	/* XP-PEN Deco L str_desc: Frame with 8 buttons */
 	{
@@ -71,6 +75,7 @@ static struct uclogic_parse_ugee_v2_desc_case uclogic_parse_ugee_v2_desc_cases[]
 			[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = 0x1FFF,
 			[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 0x08,
 		},
+		.frame_type = UCLOGIC_PARAMS_FRAME_BUTTONS,
 	},
 	/* PARBLO A610 PRO str_desc: Frame with 9 buttons and dial */
 	{
@@ -94,6 +99,31 @@ static struct uclogic_parse_ugee_v2_desc_case uclogic_parse_ugee_v2_desc_cases[]
 			[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = 0x1FFF,
 			[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 0x09,
 		},
+		.frame_type = UCLOGIC_PARAMS_FRAME_DIAL,
+	},
+	/* XP-PEN Deco Pro S str_desc: Frame with 8 buttons and mouse */
+	{
+		.name = "frame_type_mouse",
+		.res = 0,
+		.str_desc = {
+			0x0E, 0x03,
+			0xC8, 0xB3,
+			0x34, 0x65,
+			0x08,
+			0x02,
+			0xFF, 0x1F,
+			0xD8, 0x13,
+		},
+		.str_desc_size = 12,
+		.desc_params = {
+			[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = 0xB3C8,
+			[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0x2363,
+			[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = 0x6534,
+			[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = 0x13EC,
+			[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = 0x1FFF,
+			[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 0x08,
+		},
+		.frame_type = UCLOGIC_PARAMS_FRAME_MOUSE,
 	},
 };
 
@@ -110,12 +140,14 @@ static void uclogic_parse_ugee_v2_desc_test(struct kunit *test)
 {
 	int res;
 	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
+	enum uclogic_params_frame_type frame_type;
 	const struct uclogic_parse_ugee_v2_desc_case *params = test->param_value;
 
 	res = uclogic_params_parse_ugee_v2_desc(params->str_desc,
 						params->str_desc_size,
 						desc_params,
-						ARRAY_SIZE(desc_params));
+						ARRAY_SIZE(desc_params),
+						&frame_type);
 	KUNIT_ASSERT_EQ(test, res, params->res);
 
 	if (res)
@@ -139,6 +171,7 @@ static void uclogic_parse_ugee_v2_desc_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test,
 			params->desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM],
 			desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM]);
+	KUNIT_EXPECT_EQ(test, params->frame_type, frame_type);
 }
 
 static struct kunit_case hid_uclogic_params_test_cases[] = {
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 7b9e1892aa91..b232125f6972 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1060,6 +1060,7 @@ static int uclogic_probe_interface(struct hid_device *hdev, u8 *magic_arr,
  * @str_desc_size:	Size of the string descriptor.
  * @desc_params:	Output description params list.
  * @desc_params_size:	Size of the output description params list.
+ * @frame_type:		Output frame type.
  *
  * Returns:
  *	Zero, if successful. A negative errno code on error.
@@ -1067,7 +1068,8 @@ static int uclogic_probe_interface(struct hid_device *hdev, u8 *magic_arr,
 static int uclogic_params_parse_ugee_v2_desc(const __u8 *str_desc,
 					     size_t str_desc_size,
 					     s32 *desc_params,
-					     size_t desc_params_size)
+					     size_t desc_params_size,
+					     enum uclogic_params_frame_type *frame_type)
 {
 	s32 pen_x_lm, pen_y_lm;
 	s32 pen_x_pm, pen_y_pm;
@@ -1087,6 +1089,7 @@ static int uclogic_params_parse_ugee_v2_desc(const __u8 *str_desc,
 	pen_x_lm = get_unaligned_le16(str_desc + 2);
 	pen_y_lm = get_unaligned_le16(str_desc + 4);
 	frame_num_buttons = str_desc[6];
+	*frame_type = str_desc[7];
 	pen_pressure_lm = get_unaligned_le16(str_desc + 8);
 
 	resolution = get_unaligned_le16(str_desc + 10);
@@ -1175,6 +1178,7 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	__u8 *str_desc = NULL;
 	__u8 *rdesc_pen = NULL;
 	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
+	enum uclogic_params_frame_type frame_type;
 	__u8 magic_arr[] = {
 		0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 	};
@@ -1218,7 +1222,8 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 
 	rc = uclogic_params_parse_ugee_v2_desc(str_desc, str_desc_len,
 					       desc_params,
-					       ARRAY_SIZE(desc_params));
+					       ARRAY_SIZE(desc_params),
+					       &frame_type);
 	if (rc)
 		goto cleanup;
 
@@ -1242,8 +1247,14 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	p.pen.subreport_list[0].id = UCLOGIC_RDESC_V1_FRAME_ID;
 
 	/* Initialize the frame interface */
-	rc = uclogic_params_ugee_v2_init_frame_buttons(&p, desc_params,
-						       ARRAY_SIZE(desc_params));
+	switch (frame_type) {
+	case UCLOGIC_PARAMS_FRAME_BUTTONS:
+	default:
+		rc = uclogic_params_ugee_v2_init_frame_buttons(&p, desc_params,
+							       ARRAY_SIZE(desc_params));
+		break;
+	}
+
 	if (rc) {
 		uclogic_params_init_invalid(&p);
 		goto output;
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index 5bef8daaa607..a97477c02ff8 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -29,6 +29,16 @@ enum uclogic_params_pen_inrange {
 	UCLOGIC_PARAMS_PEN_INRANGE_NONE,
 };
 
+/* Types of frames */
+enum uclogic_params_frame_type {
+	/* Frame with buttons */
+	UCLOGIC_PARAMS_FRAME_BUTTONS = 0,
+	/* Frame with buttons and a dial */
+	UCLOGIC_PARAMS_FRAME_DIAL,
+	/* Frame with buttons and a mouse (shaped as a dial + touchpad) */
+	UCLOGIC_PARAMS_FRAME_MOUSE,
+};
+
 /*
  * Pen report's subreport data.
  */
-- 
2.25.1

