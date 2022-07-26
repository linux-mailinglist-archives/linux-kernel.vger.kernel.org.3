Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B190581790
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbiGZQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiGZQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:39:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F331B7AE;
        Tue, 26 Jul 2022 09:39:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d8so20842938wrp.6;
        Tue, 26 Jul 2022 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSvkv9mhPoR5bDUGa6yltbm4LgVU497Un5RAIEDmaBw=;
        b=ZC27Q78JSFtiJ0rmOKFglVx/Z4JSroP3yNR/1wA9ZTtjuuw+okE2zcA1AvnMaAp/DB
         wGl0N5bRLu27xFh0Hqw61n79lql1dGkz2VxLLuDRxtyz/KdfugX1uVjPBTX/EYwe0SF1
         0mprt/adQjxGwg8N5Ht1hl/pu9JK47EK5EllbjDBWT6iFiblTOQCSLSsIBfufhLrPLdl
         LBhacPeJlT216DMwZPfZptiFqX0uKNeJ8epB5jrNTgGZXYqTkvOE9kB/v2K+cDjTiwqk
         mJM7qBRrSdLbd7eLhuCDVIOW28knQg/ULMfqQpxBg+LfLutEYnUevgR7uwOetF/Q+t9S
         QQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSvkv9mhPoR5bDUGa6yltbm4LgVU497Un5RAIEDmaBw=;
        b=wRRsFmYzo5wF/hNDx/4RtZ5BJqTl5BlvCaop4CpXDUMtx9nsjAOW6fUKyHKSestd0N
         c7Xc+onaJ8CuQkLb3byeRTZABZ74VSmnZWjI4E8oRhEoIkci3HefTZ2UU1TQQeILixGP
         e4Y9K0nsOF+hW9RLU/usdiGKijVi83G4ngTJYyCUmIp94Nx6OOflKp7KCTZDF10UaA3I
         fAqCynV9slQjR2ZW1igtIyiv9N4d3sleUraiXuI/CK2E2IU3Kb1bFGJl41e5NwVFMoLx
         Zs1ZqsEmvA/CCSZ5RVT/StZFQA6DqoDfYJDR8/Ndqy494sKpe6wetj30cQPYT0W3jlQ1
         78Rw==
X-Gm-Message-State: AJIora/n3NLATB9dH3kIYDBnv5IDn57H/gk2JVOYwAddXEY6fq/K8Kgf
        ptQcuy4SuNqoKxUVlU60Hqs=
X-Google-Smtp-Source: AGRyM1sXv7irTOyH4m5ys9MdwD7yFQFl5DWpBoGcabyag5Qeq59FJObhyvRjPZGuOKaRO0X/xqsEDQ==
X-Received: by 2002:a5d:6a06:0:b0:21e:bd8e:4e7f with SMTP id m6-20020a5d6a06000000b0021ebd8e4e7fmr800497wru.134.1658853574267;
        Tue, 26 Jul 2022 09:39:34 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm19514710wmd.36.2022.07.26.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:39:33 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 4/7] HID: uclogic: Parse the UGEE v2 frame type
Date:   Tue, 26 Jul 2022 18:39:23 +0200
Message-Id: <20220726163926.10549-5-jose.exposito89@gmail.com>
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

